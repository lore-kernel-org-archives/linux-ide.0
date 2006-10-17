From: Tejun Heo <htejun@gmail.com>
Subject: [RFT PATCH] ahci PMP support
Date: Tue, 17 Oct 2006 14:02:57 +0900
Message-ID: <20061017050257.GC13677@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.233]:63330 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1423074AbWJQFDE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Oct 2006 01:03:04 -0400
Received: by qb-out-0506.google.com with SMTP id e6so446801qbe
        for <linux-ide@vger.kernel.org>; Mon, 16 Oct 2006 22:03:03 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: forrest.zhao@gmail.com, patrick.s.thomson@intel.com
Cc: linux-ide@vger.kernel.org

Hello,

This patch is originally from Forrest Zhao.  I updated it to the newly
posted PMP patchset[1], rewrote qc_defer and simplified here and
there.  I don't have access to PMP capable ahci at the moment (vt8251
reports pmp but it doesn't seem to work.  I flagged it w/ NO_PMP), so
couldn't test it.  If you have access to known-good ahci w/ PMP
support, please test it.

Thanks.

Index: work/drivers/ata/ahci.c
===================================================================
--- work.orig/drivers/ata/ahci.c	2006-10-17 13:57:39.000000000 +0900
+++ work/drivers/ata/ahci.c	2006-10-17 13:57:39.000000000 +0900
@@ -48,7 +48,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ahci"
-#define DRV_VERSION	"2.0"
+#define DRV_VERSION	"3.0"
 
 
 enum {
@@ -93,6 +93,7 @@ enum {
 
 	/* HOST_CAP bits */
 	HOST_CAP_SSC		= (1 << 14), /* Slumber capable */
+	HOST_CAP_PMP		= (1 << 17), /* Port Multiplier support */
 	HOST_CAP_CLO		= (1 << 24), /* Command List Override support */
 	HOST_CAP_SSS		= (1 << 27), /* Staggered Spin-up */
 	HOST_CAP_NCQ		= (1 << 30), /* Native Command Queueing */
@@ -167,6 +168,7 @@ enum {
 
 	/* ap->flags bits */
 	AHCI_FLAG_NO_NCQ		= (1 << 24),
+	AHCI_FLAG_NO_PMP		= (1 << 25),
 };
 
 struct ahci_cmd_hdr {
@@ -212,6 +214,8 @@ static void ahci_qc_prep(struct ata_queu
 static u8 ahci_check_status(struct ata_port *ap);
 static void ahci_freeze(struct ata_port *ap);
 static void ahci_thaw(struct ata_port *ap);
+static int ahci_pmp_read(struct ata_device *dev, int pmp, int reg, u32 *r_val);
+static int ahci_pmp_write(struct ata_device *dev, int pmp, int reg, u32 val);
 static void ahci_error_handler(struct ata_port *ap);
 static void ahci_vt8251_error_handler(struct ata_port *ap);
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc);
@@ -251,7 +255,7 @@ static const struct ata_port_operations 
 
 	.tf_read		= ahci_tf_read,
 
-	.qc_defer		= ata_std_qc_defer,
+	.qc_defer		= sata_pmp_qc_defer_cmd_switch,
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
 
@@ -266,6 +270,9 @@ static const struct ata_port_operations 
 	.error_handler		= ahci_error_handler,
 	.post_internal_cmd	= ahci_post_internal_cmd,
 
+	.pmp_read		= ahci_pmp_read,
+	.pmp_write		= ahci_pmp_write,
+
 	.hp_poll_activate	= sata_std_hp_poll_activate,
 	.hp_poll		= sata_std_hp_poll,
 
@@ -328,7 +335,8 @@ static const struct ata_port_info ahci_p
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
 				  ATA_FLAG_SKIP_D2H_BSY |
-				  ATA_FLAG_HRST_TO_RESUME | AHCI_FLAG_NO_NCQ,
+				  ATA_FLAG_HRST_TO_RESUME |
+				  AHCI_FLAG_NO_NCQ | AHCI_FLAG_NO_PMP,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &ahci_vt8251_ops,
@@ -735,7 +743,8 @@ static int ahci_clo(struct ata_port *ap)
 	return 0;
 }
 
-static int ahci_softreset(struct ata_link *link, unsigned int *class)
+static int ahci_do_softreset(struct ata_link *link, unsigned int *class,
+			     int pmp)
 {
 	struct ata_port *ap = link->ap;
 	struct ahci_port_priv *pp = ap->private_data;
@@ -787,7 +796,7 @@ static int ahci_softreset(struct ata_lin
 			   cmd_fis_len | AHCI_CMD_RESET | AHCI_CMD_CLR_BUSY);
 
 	tf.ctl |= ATA_SRST;
-	ata_tf_to_fis(&tf, 0, 0, fis);
+	ata_tf_to_fis(&tf, pmp, 0, fis);
 
 	writel(1, port_mmio + PORT_CMD_ISSUE);
 
@@ -805,7 +814,7 @@ static int ahci_softreset(struct ata_lin
 	ahci_fill_cmd_slot(pp, 0, cmd_fis_len);
 
 	tf.ctl &= ~ATA_SRST;
-	ata_tf_to_fis(&tf, 0, 0, fis);
+	ata_tf_to_fis(&tf, pmp, 0, fis);
 
 	writel(1, port_mmio + PORT_CMD_ISSUE);
 	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
@@ -840,6 +849,16 @@ static int ahci_softreset(struct ata_lin
 	return rc;
 }
 
+static int ahci_softreset(struct ata_link *link, unsigned int *class)
+{
+	int pmp = 0;
+
+	if (link->ap->flags & ATA_FLAG_PMP)
+		pmp = SATA_PMP_CTRL_PORT;
+
+	return ahci_do_softreset(link, class, pmp);
+}
+
 static int ahci_hardreset(struct ata_link *link, unsigned int *class)
 {
 	struct ata_port *ap = link->ap;
@@ -918,6 +937,11 @@ static void ahci_postreset(struct ata_li
 	}
 }
 
+static int ahci_pmp_softreset(struct ata_link *link, unsigned int *class)
+{
+	return ahci_do_softreset(link, class, link->pmp);
+}
+
 static u8 ahci_check_status(struct ata_port *ap)
 {
 	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr;
@@ -1214,8 +1238,10 @@ static void ahci_error_handler(struct at
 	}
 
 	/* perform recovery */
-	ata_do_eh(ap, ata_std_prereset, ahci_softreset, ahci_hardreset,
-		  ahci_postreset);
+	sata_pmp_do_eh(ap, ata_std_prereset, ahci_softreset,
+		       ahci_hardreset, ahci_postreset,
+		       sata_pmp_std_prereset, ahci_pmp_softreset,
+		       sata_pmp_std_hardreset, sata_pmp_std_postreset);
 }
 
 static void ahci_vt8251_error_handler(struct ata_port *ap)
@@ -1409,6 +1435,54 @@ static void ahci_port_stop(struct ata_po
 	kfree(pp);
 }
 
+static int ahci_rw_pmp_reg(struct ata_device *dev, int rw, int pmp, int reg,
+			   u32 *val)
+{
+	const u32 cmd_fis_len = 5; /* five dwords */
+	struct ata_port *ap = dev->link->ap;
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *mmio = ap->host->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	u8 *fis = pp->cmd_tbl;
+	struct ata_taskfile tf;
+	u32 tmp;
+
+	if (rw == READ)
+		sata_pmp_read_init_tf(&tf, dev, pmp, reg);
+	else
+		sata_pmp_write_init_tf(&tf, dev, pmp, reg, *val);
+
+	ahci_fill_cmd_slot(pp, 0, cmd_fis_len);
+	ata_tf_to_fis(&tf, SATA_PMP_CTRL_PORT, 1, fis);
+
+	writel(1, port_mmio + PORT_CMD_ISSUE);
+
+	tmp = ata_wait_register(port_mmio + PORT_CMD_ISSUE, 0x1, 0x1, 1, 500);
+	if (tmp & 0x1) {
+		ata_link_printk(dev->link, KERN_ERR, "failed to %s SCR "
+				"register, pmp is %d, reg is %d\n",
+				rw == READ ? "read" : "write", pmp, reg);
+		return -EIO;
+	}
+
+	if (rw == READ) {
+		ahci_tf_read(ap, &tf);
+		*val = sata_pmp_read_val(&tf);
+	}
+
+	return 0;
+}
+
+static int ahci_pmp_read(struct ata_device *dev, int pmp, int reg, u32 *r_val)
+{
+	return ahci_rw_pmp_reg(dev, READ, pmp, reg, r_val);
+}
+
+static int ahci_pmp_write(struct ata_device *dev, int pmp, int reg, u32 val)
+{
+	return ahci_rw_pmp_reg(dev, WRITE, pmp, reg, &val);
+}
+
 static void ahci_setup_port(struct ata_ioports *port, unsigned long base,
 			    unsigned int port_idx)
 {
@@ -1527,25 +1601,27 @@ static void ahci_print_info(struct ata_p
 		scc_s);
 
 	dev_printk(KERN_INFO, &pdev->dev,
-		"flags: "
-	       	"%s%s%s%s%s%s"
-	       	"%s%s%s%s%s%s%s\n"
+		"flags:"
+	       	"%s%s%s%s%s%s%s"
+	       	"%s%s%s%s%s%s%s%s\n"
 	       	,
 
-		cap & (1 << 31) ? "64bit " : "",
-		cap & (1 << 30) ? "ncq " : "",
-		cap & (1 << 28) ? "ilck " : "",
-		cap & (1 << 27) ? "stag " : "",
-		cap & (1 << 26) ? "pm " : "",
-		cap & (1 << 25) ? "led " : "",
-
-		cap & (1 << 24) ? "clo " : "",
-		cap & (1 << 19) ? "nz " : "",
-		cap & (1 << 18) ? "only " : "",
-		cap & (1 << 17) ? "pmp " : "",
-		cap & (1 << 15) ? "pio " : "",
-		cap & (1 << 14) ? "slum " : "",
-		cap & (1 << 13) ? "part " : ""
+		cap & (1 << 31) ? " 64bit" : "",
+		cap & (1 << 30) ? " ncq" : "",
+		probe_ent->port_flags & AHCI_FLAG_NO_NCQ ? "(X)" : "",
+		cap & (1 << 28) ? " ilck" : "",
+		cap & (1 << 27) ? " stag" : "",
+		cap & (1 << 26) ? " pm" : "",
+		cap & (1 << 25) ? " led" : "",
+
+		cap & (1 << 24) ? " clo" : "",
+		cap & (1 << 19) ? " nz" : "",
+		cap & (1 << 18) ? " only" : "",
+		cap & (1 << 17) ? " pmp" : "",
+		probe_ent->port_flags & AHCI_FLAG_NO_PMP ? "(X)" : "",
+		cap & (1 << 15) ? " pio" : "",
+		cap & (1 << 14) ? " slum" : "",
+		cap & (1 << 13) ? " part" : ""
 		);
 }
 
@@ -1642,6 +1718,10 @@ static int ahci_init_one (struct pci_dev
 	    (hpriv->cap & HOST_CAP_NCQ))
 		probe_ent->port_flags |= ATA_FLAG_NCQ;
 
+	if (!(probe_ent->port_flags & AHCI_FLAG_NO_PMP) &&
+	    (hpriv->cap & HOST_CAP_PMP))
+		probe_ent->port_flags |= ATA_FLAG_PMP;
+
 	ahci_print_info(probe_ent);
 
 	/* FIXME: check ata_device_add return value */
Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c	2006-10-17 13:57:39.000000000 +0900
+++ work/drivers/ata/libata-core.c	2006-10-17 13:57:39.000000000 +0900
@@ -6463,6 +6463,7 @@ EXPORT_SYMBOL_GPL(ata_pci_clear_simplex)
 EXPORT_SYMBOL_GPL(ata_scsi_device_suspend);
 EXPORT_SYMBOL_GPL(ata_scsi_device_resume);
 
+EXPORT_SYMBOL_GPL(sata_pmp_qc_defer_cmd_switch);
 EXPORT_SYMBOL_GPL(sata_pmp_read_init_tf);
 EXPORT_SYMBOL_GPL(sata_pmp_read_val);
 EXPORT_SYMBOL_GPL(sata_pmp_write_init_tf);
Index: work/drivers/ata/libata-pmp.c
===================================================================
--- work.orig/drivers/ata/libata-pmp.c	2006-10-17 13:57:39.000000000 +0900
+++ work/drivers/ata/libata-pmp.c	2006-10-17 13:57:39.000000000 +0900
@@ -37,6 +37,36 @@
 #include "libata.h"
 
 /**
+ *	sata_pmp_qc_defer_cmd_switch - qc_defer for command switching PMP
+ *	@qc: ATA command in question
+ *
+ *	A host which has command switching PMP support cannot issue
+ *	commands to multiple links simultaneously.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ *
+ *	RETURNS:
+ *	ATA_DEFER_* if deferring is needed, 0 otherwise.
+ */
+int sata_pmp_qc_defer_cmd_switch(struct ata_queued_cmd *qc)
+{
+	struct ata_link *link = qc->dev->link;
+	struct ata_port *ap = link->ap;
+
+	if (ap->excl_link == NULL || ap->excl_link == link) {
+		if (ap->nr_active_links == 0 || ata_link_active(link)) {
+			qc->flags |= ATA_QCFLAG_CLEAR_EXCL;
+			return ata_std_qc_defer(qc);
+		}
+
+		ap->excl_link = link;
+	}
+
+	return ATA_DEFER_PORT;
+}
+
+/**
  *	sata_pmp_read_init_tf - initialize TF for PMP read
  *	@tf: taskfile to initialize
  *	@dev: PMP dev
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h	2006-10-17 13:57:39.000000000 +0900
+++ work/include/linux/libata.h	2006-10-17 13:57:39.000000000 +0900
@@ -929,6 +929,7 @@ extern unsigned long ata_pci_default_fil
 /*
  * PMP
  */
+extern int sata_pmp_qc_defer_cmd_switch(struct ata_queued_cmd *qc);
 extern void sata_pmp_read_init_tf(struct ata_taskfile *tf,
 				  struct ata_device *dev, int pmp, int reg);
 extern u32 sata_pmp_read_val(const struct ata_taskfile *tf);
