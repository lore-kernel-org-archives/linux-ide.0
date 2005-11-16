From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/5] sil24: use SRST for phy_reset
Date: Wed, 16 Nov 2005 17:05:05 +0900
Message-ID: <20051116080505.GC22807@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.194]:58944 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030211AbVKPIFM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Nov 2005 03:05:12 -0500
Received: by zproxy.gmail.com with SMTP id 13so1710744nzn
        for <linux-ide@vger.kernel.org>; Wed, 16 Nov 2005 00:05:12 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

There seems to be no way to obtain device signature from sil24 after
SATA phy reset and SRST is needed anyway for later port multiplier
suppport.  This patch converts sil24_phy_reset to use SRST instaed.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/sata_sil24.c
===================================================================
--- work.orig/drivers/scsi/sata_sil24.c	2005-11-16 16:58:01.000000000 +0900
+++ work/drivers/scsi/sata_sil24.c	2005-11-16 17:02:56.000000000 +0900
@@ -333,7 +333,7 @@ static struct ata_port_info sil24_port_i
 	{
 		.sht		= &sil24_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO |
+				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
 				  ATA_FLAG_PIO_DMA | SIL24_NPORTS2FLAG(4),
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
@@ -344,7 +344,7 @@ static struct ata_port_info sil24_port_i
 	{
 		.sht		= &sil24_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO |
+				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
 				  ATA_FLAG_PIO_DMA | SIL24_NPORTS2FLAG(2),
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
@@ -355,7 +355,7 @@ static struct ata_port_info sil24_port_i
 	{
 		.sht		= &sil24_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO |
+				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
 				  ATA_FLAG_PIO_DMA | SIL24_NPORTS2FLAG(1),
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
@@ -415,16 +415,69 @@ static void sil24_tf_read(struct ata_por
 	*tf = pp->tf;
 }
 
+static int sil24_issue_SRST(struct ata_port *ap)
+{
+	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+	struct sil24_port_priv *pp = ap->private_data;
+	struct sil24_prb *prb = &pp->cmd_block[0].prb;
+	dma_addr_t paddr = pp->cmd_block_dma;
+	u32 irq_enable, irq_stat;
+	int cnt;
+
+	/* temporarily turn off IRQs during SRST */
+	irq_enable = readl(port + PORT_IRQ_ENABLE_SET);
+	writel(irq_enable, port + PORT_IRQ_ENABLE_CLR);
+
+	/* delay 10 ms */
+	udelay(10000);
+
+	prb->ctrl = PRB_CTRL_SRST;
+	prb->fis[1] = 0; /* no PM yet */
+
+	writel((u32)paddr, port + PORT_CMD_ACTIVATE);
+
+	for (cnt = 0; cnt < 100; cnt++) {
+		irq_stat = readl(port + PORT_IRQ_STAT);
+		writel(irq_stat, port + PORT_IRQ_STAT);		/* clear irq */
+
+		irq_stat >>= PORT_IRQ_RAW_SHIFT;
+		if (irq_stat & (PORT_IRQ_COMPLETE | PORT_IRQ_ERROR))
+			break;
+
+		udelay(1000);
+	}
+
+	/* restore IRQs */
+	writel(irq_enable, port + PORT_IRQ_ENABLE_SET);
+
+	if (!(irq_stat & PORT_IRQ_COMPLETE))
+		return -1;
+
+	/* update TF */
+	sil24_update_tf(ap);
+	return 0;
+}
+
 static void sil24_phy_reset(struct ata_port *ap)
 {
+	struct sil24_port_priv *pp = ap->private_data;
+
 	__sata_phy_reset(ap);
-	/*
-	 * No ATAPI yet.  Just unconditionally indicate ATA device.
-	 * If ATAPI device is attached, it will fail ATA_CMD_ID_ATA
-	 * and libata core will ignore the device.
-	 */
-	if (!(ap->flags & ATA_FLAG_PORT_DISABLED))
-		ap->device[0].class = ATA_DEV_ATA;
+	if (ap->flags & ATA_FLAG_PORT_DISABLED)
+		return;
+
+	if (sil24_issue_SRST(ap) < 0) {
+		printk(KERN_ERR DRV_NAME
+		       " ata%u: SRST failed, disabling port\n", ap->id);
+		ap->ops->port_disable(ap);
+		return;
+	}
+
+	ap->device->class = ata_dev_classify(&pp->tf);
+
+	/* No ATAPI yet */
+	if (ap->device->class == ATA_DEV_ATAPI)
+		ap->ops->port_disable(ap);
 }
 
 static inline void sil24_fill_sg(struct ata_queued_cmd *qc,
