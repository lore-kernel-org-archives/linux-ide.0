From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 14/14] ahci: add softreset
Date: Sun, 18 Dec 2005 22:51:49 +0900
Message-ID: <20051218135149.GO31571@htj.dyndns.org>
References: <20051218133305.GA31571@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:30214 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965136AbVLRNvy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Dec 2005 08:51:54 -0500
Received: by zproxy.gmail.com with SMTP id 13so1085519nzn
        for <linux-ide@vger.kernel.org>; Sun, 18 Dec 2005 05:51:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20051218133305.GA31571@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, liml@rtr.ca
Cc: linux-ide@vger.kernel.org

Now that libata is smart enought to handle both soft and hard resets,
add softreset method.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/ahci.c
===================================================================
--- work.orig/drivers/scsi/ahci.c	2005-12-18 22:24:15.000000000 +0900
+++ work/drivers/scsi/ahci.c	2005-12-18 22:24:17.000000000 +0900
@@ -190,6 +190,7 @@ static void ahci_scr_write (struct ata_p
 static int ahci_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static int ahci_qc_issue(struct ata_queued_cmd *qc);
 static irqreturn_t ahci_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
+static int ahci_softreset(struct ata_port *ap, unsigned int *classes);
 static int ahci_hardreset(struct ata_port *ap, unsigned int *classes);
 static void ahci_postreset(struct ata_port *ap, const unsigned int *classes);
 static void ahci_irq_clear(struct ata_port *ap);
@@ -231,6 +232,7 @@ static const struct ata_port_operations 
 
 	.tf_read		= ahci_tf_read,
 
+	.soft_reset		= ahci_softreset,
 	.hard_reset		= ahci_hardreset,
 	.post_reset		= ahci_postreset,
 
@@ -526,6 +528,106 @@ static unsigned int ahci_dev_classify(st
 	return class;
 }
 
+static int ahci_softreset(struct ata_port *ap, unsigned int *classes)
+{
+	struct ahci_host_priv *hpriv = ap->host_set->private_data;
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	const u32 cmd_fis_len = 5; /* five dwords */
+	struct ata_taskfile tf;
+	u8 *fis;
+	int ret;
+
+	DPRINTK("ENTER\n");
+
+	/* prepare for SRST (AHCI-1.1 10.4.1) */
+	ret = ahci_stop_engine(ap);
+	if (ret)
+		goto out_restart;
+
+	/* check BUSY/DRQ, perform Command List Override if necessary */
+	ahci_tf_read(ap, &tf);
+	if (tf.command & (ATA_BUSY | ATA_DRQ)) {
+		u32 tmp;
+
+		ret = -EIO;
+		if (!(hpriv->cap & HOST_CAP_CLO))
+			goto out_restart;
+
+		tmp = readl(port_mmio + PORT_CMD);
+		tmp |= PORT_CMD_CLO;
+		writel(tmp, port_mmio + PORT_CMD);
+		readl(port_mmio + PORT_CMD); /* flush */
+
+		ret = -EIO;
+		if (ahci_wait_for_bit(port_mmio + PORT_CMD,
+				      PORT_CMD_CLO, PORT_CMD_CLO, 1, 500))
+			goto out_restart;
+	}
+
+	/* restart engine */
+	ahci_start_engine(ap);
+
+	ata_tf_init(ap, &tf, 0);
+	fis = pp->cmd_tbl;
+
+	/* issue the first D2H Register FIS */
+	ahci_cmd_prep(ap, cmd_fis_len | AHCI_CMD_RESET | AHCI_CMD_CLR_BUSY);
+
+	tf.ctl |= ATA_SRST;
+	ata_tf_to_fis(&tf, fis, 0);
+	fis[1] &= ~(1 << 7);	/* turn off Command FIS bit */
+
+	writel(1, port_mmio + PORT_CMD_ISSUE);
+	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
+
+	if (ahci_wait_for_bit(port_mmio + PORT_CMD_ISSUE, 0x1, 0x1, 1, 500)) {
+		DPRINTK("EXIT, 1st FIS failed\n");
+		return -EIO;
+	}
+
+	/* spec says at least 5us, but be generous and sleep for 1ms */
+	msleep(1);
+
+	/* issue the second D2H Register FIS */
+	ahci_cmd_prep(ap, cmd_fis_len);
+
+	tf.ctl &= ~ATA_SRST;
+	ata_tf_to_fis(&tf, fis, 0);
+	fis[1] &= ~(1 << 7);	/* turn off Command FIS bit */
+
+	writel(1, port_mmio + PORT_CMD_ISSUE);
+	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
+
+	/* spec mandates ">= 2ms" before checking status.
+	 * We wait 150ms, because that was the magic delay used for
+	 * ATAPI devices in Hale Landis's ATADRVR, for the period of time
+	 * between when the ATA command register is written, and then
+	 * status is checked.  Because waiting for "a while" before
+	 * checking status is fine, post SRST, we perform this magic
+	 * delay here as well.
+	 */
+	msleep(150);
+
+	classes[0] = ATA_DEV_NONE;
+	if (sata_dev_present(ap)) {
+		if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
+			DPRINTK("EXIT, device not ready\n");
+			return -EIO;
+		}
+		classes[0] = ahci_dev_classify(ap);
+	}
+
+	DPRINTK("EXIT, class=%u\n", classes[0]);
+	return 0;
+
+ out_restart:
+	DPRINTK("EXIT, error=%d\n", ret);
+	ahci_start_engine(ap);
+	return ret;
+}
+
 static int ahci_hardreset(struct ata_port *ap, unsigned int *classes)
 {
 	void __iomem *mmio = ap->host_set->mmio_base;
