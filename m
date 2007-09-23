From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/10] sata_sil24: implement PMP support
Date: Sun, 23 Sep 2007 13:19:54 +0900
Message-ID: <1190521194556-git-send-email-htejun@gmail.com>
References: <1190521193410-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:56265 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690AbXIWEUI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Sep 2007 00:20:08 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1141415rvb
        for <linux-ide@vger.kernel.org>; Sat, 22 Sep 2007 21:20:08 -0700 (PDT)
In-Reply-To: <1190521193410-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement PMP support.  sil24 supports full FIS-switching.  However,
it has a PMP DMA CS errata which requires port-wide resetting if
commands are outstanding to three or more devices when an error occurs
on one of them.

ATAPI commands often result in CHECK SENSE and it's crucial to not
reset them before fetching sense data.  Unfortunately, ATAPI CHECK
SENSE causes a lot of problem if command is outstanding to any other
device usually resulting in port-wide reset.  So, sata_sil24
implements sil24_qc_defer() which guarantees ATAPI command is run by
itself.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_sil24.c |  227 +++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 206 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index b4f81eb..03bfbb6 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -30,7 +30,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_sil24"
-#define DRV_VERSION	"1.0"
+#define DRV_VERSION	"1.1"
 
 /*
  * Port request block (PRB) 32 bytes
@@ -238,7 +238,7 @@ enum {
 	SIL24_COMMON_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
 				  ATA_FLAG_NCQ | ATA_FLAG_ACPI_SATA |
-				  ATA_FLAG_AN,
+				  ATA_FLAG_AN | ATA_FLAG_PMP,
 	SIL24_COMMON_LFLAGS	= ATA_LFLAG_SKIP_D2H_BSY,
 	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 24), /* IRQ loss errata on PCI-X */
 
@@ -330,9 +330,14 @@ static u8 sil24_check_status(struct ata_port *ap);
 static int sil24_scr_read(struct ata_port *ap, unsigned sc_reg, u32 *val);
 static int sil24_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val);
 static void sil24_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
+static int sil24_qc_defer(struct ata_queued_cmd *qc);
 static void sil24_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc);
 static void sil24_irq_clear(struct ata_port *ap);
+static void sil24_pmp_attach(struct ata_port *ap);
+static void sil24_pmp_detach(struct ata_port *ap);
+static int sil24_pmp_read(struct ata_device *dev, int pmp, int reg, u32 *r_val);
+static int sil24_pmp_write(struct ata_device *dev, int pmp, int reg, u32 val);
 static void sil24_freeze(struct ata_port *ap);
 static void sil24_thaw(struct ata_port *ap);
 static void sil24_error_handler(struct ata_port *ap);
@@ -341,6 +346,7 @@ static int sil24_port_start(struct ata_port *ap);
 static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
 #ifdef CONFIG_PM
 static int sil24_pci_device_resume(struct pci_dev *pdev);
+static int sil24_port_resume(struct ata_port *ap);
 #endif
 
 static const struct pci_device_id sil24_pci_tbl[] = {
@@ -393,7 +399,7 @@ static const struct ata_port_operations sil24_ops = {
 
 	.tf_read		= sil24_tf_read,
 
-	.qc_defer		= ata_std_qc_defer,
+	.qc_defer		= sil24_qc_defer,
 	.qc_prep		= sil24_qc_prep,
 	.qc_issue		= sil24_qc_issue,
 
@@ -402,12 +408,21 @@ static const struct ata_port_operations sil24_ops = {
 	.scr_read		= sil24_scr_read,
 	.scr_write		= sil24_scr_write,
 
+	.pmp_attach		= sil24_pmp_attach,
+	.pmp_detach		= sil24_pmp_detach,
+	.pmp_read		= sil24_pmp_read,
+	.pmp_write		= sil24_pmp_write,
+
 	.freeze			= sil24_freeze,
 	.thaw			= sil24_thaw,
 	.error_handler		= sil24_error_handler,
 	.post_internal_cmd	= sil24_post_internal_cmd,
 
 	.port_start		= sil24_port_start,
+
+#ifdef CONFIG_PM
+	.port_resume		= sil24_port_resume,
+#endif
 };
 
 /*
@@ -521,11 +536,40 @@ static void sil24_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
 	*tf = pp->tf;
 }
 
+static void sil24_config_pmp(struct ata_port *ap, int attached)
+{
+	void __iomem *port = ap->ioaddr.cmd_addr;
+
+	if (attached)
+		writel(PORT_CS_PMP_EN, port + PORT_CTRL_STAT);
+	else
+		writel(PORT_CS_PMP_EN, port + PORT_CTRL_CLR);
+}
+
+static void sil24_clear_pmp(struct ata_port *ap)
+{
+	void __iomem *port = ap->ioaddr.cmd_addr;
+	int i;
+
+	writel(PORT_CS_PMP_RESUME, port + PORT_CTRL_CLR);
+
+	for (i = 0; i < SATA_PMP_MAX_PORTS; i++) {
+		void __iomem *pmp_base = port + PORT_PMP + i * PORT_PMP_SIZE;
+
+		writel(0, pmp_base + PORT_PMP_STATUS);
+		writel(0, pmp_base + PORT_PMP_QACTIVE);
+	}
+}
+
 static int sil24_init_port(struct ata_port *ap)
 {
 	void __iomem *port = ap->ioaddr.cmd_addr;
 	u32 tmp;
 
+	/* clear PMP error status */
+	if (ap->nr_pmp_links)
+		sil24_clear_pmp(ap);
+
 	writel(PORT_CS_INIT, port + PORT_CTRL_STAT);
 	ata_wait_register(port + PORT_CTRL_STAT,
 			  PORT_CS_INIT, PORT_CS_INIT, 10, 100);
@@ -640,7 +684,7 @@ static int sil24_do_softreset(struct ata_link *link, unsigned int *class,
 static int sil24_softreset(struct ata_link *link, unsigned int *class,
 			   unsigned long deadline)
 {
-	return sil24_do_softreset(link, class, 0, deadline);
+	return sil24_do_softreset(link, class, SATA_PMP_CTRL_PORT, deadline);
 }
 
 static int sil24_hardreset(struct ata_link *link, unsigned int *class,
@@ -708,6 +752,38 @@ static inline void sil24_fill_sg(struct ata_queued_cmd *qc,
 	}
 }
 
+static int sil24_qc_defer(struct ata_queued_cmd *qc)
+{
+	struct ata_link *link = qc->dev->link;
+	struct ata_port *ap = link->ap;
+	u8 prot = qc->tf.protocol;
+	int is_atapi = (prot == ATA_PROT_ATAPI ||
+			prot == ATA_PROT_ATAPI_NODATA ||
+			prot == ATA_PROT_ATAPI_DMA);
+
+	/* ATAPI commands completing with CHECK_SENSE cause various
+	 * weird problems if other commands are active.  PMP DMA CS
+	 * errata doesn't cover all and HSM violation occurs even with
+	 * only one other device active.  Always run an ATAPI command
+	 * by itself.
+	 */
+	if (unlikely(ap->excl_link)) {
+		if (link == ap->excl_link) {
+			if (ap->nr_active_links)
+				return ATA_DEFER_PORT;
+			qc->flags |= ATA_QCFLAG_CLEAR_EXCL;
+		} else
+			return ATA_DEFER_PORT;
+	} else if (unlikely(is_atapi)) {
+		ap->excl_link = link;
+		if (ap->nr_active_links)
+			return ATA_DEFER_PORT;
+		qc->flags |= ATA_QCFLAG_CLEAR_EXCL;
+	}
+
+	return ata_std_qc_defer(qc);
+}
+
 static void sil24_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
@@ -751,7 +827,7 @@ static void sil24_qc_prep(struct ata_queued_cmd *qc)
 	}
 
 	prb->ctrl = cpu_to_le16(ctrl);
-	ata_tf_to_fis(&qc->tf, 0, 1, prb->fis);
+	ata_tf_to_fis(&qc->tf, qc->dev->link->pmp, 1, prb->fis);
 
 	if (qc->flags & ATA_QCFLAG_DMAMAP)
 		sil24_fill_sg(qc, sge);
@@ -780,6 +856,65 @@ static void sil24_irq_clear(struct ata_port *ap)
 	/* unused */
 }
 
+static void sil24_pmp_attach(struct ata_port *ap)
+{
+	sil24_config_pmp(ap, 1);
+	sil24_init_port(ap);
+}
+
+static void sil24_pmp_detach(struct ata_port *ap)
+{
+	sil24_init_port(ap);
+	sil24_config_pmp(ap, 0);
+}
+
+static int sil24_pmp_read(struct ata_device *dev, int pmp, int reg, u32 *r_val)
+{
+	struct ata_port *ap = dev->link->ap;
+	struct ata_taskfile tf;
+	int rc;
+
+	sata_pmp_read_init_tf(&tf, dev, pmp, reg);
+	rc = sil24_exec_polled_cmd(ap, SATA_PMP_CTRL_PORT, &tf, 1, 0,
+				   SATA_PMP_SCR_TIMEOUT);
+	if (rc == 0) {
+		sil24_read_tf(ap, 0, &tf);
+		*r_val = sata_pmp_read_val(&tf);
+	}
+	return rc;
+}
+
+static int sil24_pmp_write(struct ata_device *dev, int pmp, int reg, u32 val)
+{
+	struct ata_port *ap = dev->link->ap;
+	struct ata_taskfile tf;
+
+	sata_pmp_write_init_tf(&tf, dev, pmp, reg, val);
+	return sil24_exec_polled_cmd(ap, SATA_PMP_CTRL_PORT, &tf, 1, 0,
+				     SATA_PMP_SCR_TIMEOUT);
+}
+
+static int sil24_pmp_softreset(struct ata_link *link, unsigned int *class,
+			       unsigned long deadline)
+{
+	return sil24_do_softreset(link, class, link->pmp, deadline);
+}
+
+static int sil24_pmp_hardreset(struct ata_link *link, unsigned int *class,
+			       unsigned long deadline)
+{
+	int rc;
+
+	rc = sil24_init_port(link->ap);
+	if (rc) {
+		ata_link_printk(link, KERN_ERR,
+				"hardreset failed (port not ready)\n");
+		return rc;
+	}
+
+	return sata_pmp_std_hardreset(link, class, deadline);
+}
+
 static void sil24_freeze(struct ata_port *ap)
 {
 	void __iomem *port = ap->ioaddr.cmd_addr;
@@ -807,8 +942,10 @@ static void sil24_error_intr(struct ata_port *ap)
 {
 	void __iomem *port = ap->ioaddr.cmd_addr;
 	struct sil24_port_priv *pp = ap->private_data;
-	struct ata_eh_info *ehi = &ap->link.eh_info;
-	int freeze = 0;
+	struct ata_queued_cmd *qc = NULL;
+	struct ata_link *link;
+	struct ata_eh_info *ehi;
+	int abort = 0, freeze = 0;
 	u32 irq_stat;
 
 	/* on error, we need to clear IRQ explicitly */
@@ -816,6 +953,8 @@ static void sil24_error_intr(struct ata_port *ap)
 	writel(irq_stat, port + PORT_IRQ_STAT);
 
 	/* first, analyze and record host port events */
+	link = &ap->link;
+	ehi = &link->eh_info;
 	ata_ehi_clear_desc(ehi);
 
 	ata_ehi_push_desc(ehi, "irq_stat 0x%08x", irq_stat);
@@ -844,8 +983,43 @@ static void sil24_error_intr(struct ata_port *ap)
 	if (irq_stat & PORT_IRQ_ERROR) {
 		struct sil24_cerr_info *ci = NULL;
 		unsigned int err_mask = 0, action = 0;
-		struct ata_queued_cmd *qc;
-		u32 cerr;
+		u32 context, cerr;
+		int pmp;
+
+		abort = 1;
+
+		/* DMA Context Switch Failure in Port Multiplier Mode
+		 * errata.  If we have active commands to 3 or more
+		 * devices, any error condition on active devices can
+		 * corrupt DMA context switching.
+		 */
+		if (ap->nr_active_links >= 3) {
+			ehi->err_mask |= AC_ERR_OTHER;
+			ehi->action |= ATA_EH_HARDRESET;
+			ata_ehi_push_desc(ehi, "PMP DMA CS errata");
+			freeze = 1;
+		}
+
+		/* find out the offending link and qc */
+		if (ap->nr_pmp_links) {
+			context = readl(port + PORT_CONTEXT);
+			pmp = (context >> 5) & 0xf;
+
+			if (pmp < ap->nr_pmp_links) {
+				link = &ap->pmp_link[pmp];
+				ehi = &link->eh_info;
+				qc = ata_qc_from_tag(ap, link->active_tag);
+
+				ata_ehi_clear_desc(ehi);
+				ata_ehi_push_desc(ehi, "irq_stat 0x%08x",
+						  irq_stat);
+			} else {
+				err_mask |= AC_ERR_HSM;
+				action |= ATA_EH_HARDRESET;
+				freeze = 1;
+			}
+		} else
+			qc = ata_qc_from_tag(ap, link->active_tag);
 
 		/* analyze CMD_ERR */
 		cerr = readl(port + PORT_CMD_ERR);
@@ -864,7 +1038,6 @@ static void sil24_error_intr(struct ata_port *ap)
 		}
 
 		/* record error info */
-		qc = ata_qc_from_tag(ap, ap->link.active_tag);
 		if (qc) {
 			sil24_read_tf(ap, qc->tag, &pp->tf);
 			qc->err_mask |= err_mask;
@@ -872,13 +1045,21 @@ static void sil24_error_intr(struct ata_port *ap)
 			ehi->err_mask |= err_mask;
 
 		ehi->action |= action;
+
+		/* if PMP, resume */
+		if (ap->nr_pmp_links)
+			writel(PORT_CS_PMP_RESUME, port + PORT_CTRL_STAT);
 	}
 
 	/* freeze or abort */
 	if (freeze)
 		ata_port_freeze(ap);
-	else
-		ata_port_abort(ap);
+	else if (abort) {
+		if (qc)
+			ata_link_abort(qc->dev->link);
+		else
+			ata_port_abort(ap);
+	}
 }
 
 static void sil24_finish_qc(struct ata_queued_cmd *qc)
@@ -971,16 +1152,14 @@ static irqreturn_t sil24_interrupt(int irq, void *dev_instance)
 
 static void sil24_error_handler(struct ata_port *ap)
 {
-	struct ata_eh_context *ehc = &ap->link.eh_context;
-
-	if (sil24_init_port(ap)) {
+	if (sil24_init_port(ap))
 		ata_eh_freeze_port(ap);
-		ehc->i.action |= ATA_EH_HARDRESET;
-	}
 
 	/* perform recovery */
-	ata_do_eh(ap, ata_std_prereset, sil24_softreset, sil24_hardreset,
-		  ata_std_postreset);
+	sata_pmp_do_eh(ap, ata_std_prereset, sil24_softreset, sil24_hardreset,
+		       ata_std_postreset, sata_pmp_std_prereset,
+		       sil24_pmp_softreset, sil24_pmp_hardreset,
+		       sata_pmp_std_postreset);
 }
 
 static void sil24_post_internal_cmd(struct ata_queued_cmd *qc)
@@ -988,8 +1167,8 @@ static void sil24_post_internal_cmd(struct ata_queued_cmd *qc)
 	struct ata_port *ap = qc->ap;
 
 	/* make DMA engine forget about the failed command */
-	if (qc->flags & ATA_QCFLAG_FAILED)
-		sil24_init_port(ap);
+	if ((qc->flags & ATA_QCFLAG_FAILED) && sil24_init_port(ap))
+		ata_eh_freeze_port(ap);
 }
 
 static int sil24_port_start(struct ata_port *ap)
@@ -1190,6 +1369,12 @@ static int sil24_pci_device_resume(struct pci_dev *pdev)
 
 	return 0;
 }
+
+static int sil24_port_resume(struct ata_port *ap)
+{
+	sil24_config_pmp(ap, ap->nr_pmp_links);
+	return 0;
+}
 #endif
 
 static int __init sil24_init(void)
-- 
1.5.0.3


