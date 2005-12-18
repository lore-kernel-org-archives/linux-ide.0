From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/14] ahci: convert to new reset mechanism
Date: Sun, 18 Dec 2005 22:49:24 +0900
Message-ID: <20051218134924.GL31571@htj.dyndns.org>
References: <20051218133305.GA31571@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.207]:52348 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965116AbVLRNt3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Dec 2005 08:49:29 -0500
Received: by zproxy.gmail.com with SMTP id 14so1716240nzn
        for <linux-ide@vger.kernel.org>; Sun, 18 Dec 2005 05:49:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20051218133305.GA31571@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, liml@rtr.ca
Cc: linux-ide@vger.kernel.org

Convert ahci ->phy_reset to ->hard_reset.  The original ->phy_reset
simply called __sata_phy_reset() to perform reset; however, AHCI spec
mandates to turn off START bit during reset.  New ->hard_reset method
properly follows AHCI reset procedure.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/ahci.c
===================================================================
--- work.orig/drivers/scsi/ahci.c	2005-12-18 22:23:38.000000000 +0900
+++ work/drivers/scsi/ahci.c	2005-12-18 22:24:04.000000000 +0900
@@ -186,7 +186,8 @@ static void ahci_scr_write (struct ata_p
 static int ahci_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static int ahci_qc_issue(struct ata_queued_cmd *qc);
 static irqreturn_t ahci_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
-static void ahci_phy_reset(struct ata_port *ap);
+static int ahci_hardreset(struct ata_port *ap, unsigned int *classes);
+static void ahci_postreset(struct ata_port *ap, const unsigned int *classes);
 static void ahci_irq_clear(struct ata_port *ap);
 static void ahci_eng_timeout(struct ata_port *ap);
 static int ahci_port_start(struct ata_port *ap);
@@ -226,7 +227,8 @@ static const struct ata_port_operations 
 
 	.tf_read		= ahci_tf_read,
 
-	.phy_reset		= ahci_phy_reset,
+	.hard_reset		= ahci_hardreset,
+	.post_reset		= ahci_postreset,
 
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
@@ -248,8 +250,7 @@ static const struct ata_port_info ahci_p
 	{
 		.sht		= &ahci_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO |
-				  ATA_FLAG_PIO_DMA,
+				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &ahci_ops,
@@ -474,17 +475,30 @@ static void ahci_start_engine(struct ata
 	readl(port_mmio + PORT_CMD); /* flush */
 }
 
-static void ahci_phy_reset(struct ata_port *ap)
+static int ahci_wait_for_bit(void __iomem *reg, u32 mask, u32 val,
+			     unsigned long interval_msec,
+			     unsigned long timeout_msec)
 {
-	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
-	struct ata_taskfile tf;
-	struct ata_device *dev = &ap->device[0];
-	u32 new_tmp, tmp;
+	unsigned long timeout;
+	u32 tmp;
+
+	timeout = jiffies + (timeout_msec * HZ) / 1000;
+	do {
+		tmp = readl(reg);
+		if ((tmp & mask) != val)
+			return 0;
+		msleep(interval_msec);
+	} while (time_before(jiffies, timeout));
 
-	__sata_phy_reset(ap);
+	return -1;
+}
 
-	if (ap->flags & ATA_FLAG_PORT_DISABLED)
-		return;
+static unsigned int ahci_dev_classify(struct ata_port *ap)
+{
+	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	struct ata_taskfile tf;
+	unsigned int class;
+	u32 tmp;
 
 	tmp = readl(port_mmio + PORT_SIG);
 	tf.lbah		= (tmp >> 24)	& 0xff;
@@ -492,15 +506,58 @@ static void ahci_phy_reset(struct ata_po
 	tf.lbal		= (tmp >> 8)	& 0xff;
 	tf.nsect	= (tmp)		& 0xff;
 
-	dev->class = ata_dev_classify(&tf);
-	if (!ata_dev_present(dev)) {
-		ata_port_disable(ap);
-		return;
-	}
+	class = ata_dev_classify(&tf);
+	if (class == ATA_DEV_UNKNOWN)
+		class = ATA_DEV_NONE;
+	return class;
+}
+
+static int ahci_hardreset(struct ata_port *ap, unsigned int *classes)
+{
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	u32 tmp;
+
+	DPRINTK("ENTER\n");
+
+	/* stop engine */
+	ahci_stop_engine(ap);
+
+	/* issue COMRESET */
+	writel(0x301, port_mmio + PORT_SCR_CTL);
+	readl(port_mmio + PORT_SCR_CTL); /* flush */
+	msleep(1);
+	writel(0x300, port_mmio + PORT_SCR_CTL);
+	readl(port_mmio + PORT_SCR_CTL); /* flush */
+
+	msleep(200);
+	ahci_wait_for_bit(port_mmio + PORT_SCR_STAT, 0xf, 0x1, 1, 5000);
+
+	/* clear SATA phy error, if any */
+	tmp = readl(port_mmio + PORT_SCR_ERR);
+	writel(tmp, port_mmio + PORT_SCR_ERR);
+
+	/* re-start engine */
+	ahci_start_engine(ap);
+
+	classes[0] = ATA_DEV_NONE;
+	if (sata_dev_present(ap))
+		classes[0] = ahci_dev_classify(ap);
+
+	DPRINTK("EXIT, class=%u\n", classes[0]);
+	return 0;
+}
+
+static void ahci_postreset(struct ata_port *ap, const unsigned int *classes)
+{
+	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	u32 new_tmp, tmp;
+
+	ata_std_postreset(ap, classes);
 
 	/* Make sure port's ATAPI bit is set appropriately */
 	new_tmp = tmp = readl(port_mmio + PORT_CMD);
-	if (dev->class == ATA_DEV_ATAPI)
+	if (classes[0] == ATA_DEV_ATAPI)
 		new_tmp |= PORT_CMD_ATAPI;
 	else
 		new_tmp &= ~PORT_CMD_ATAPI;
