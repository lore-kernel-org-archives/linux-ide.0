From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/14] sata_sil24: convert to new reset mechanism
Date: Sun, 18 Dec 2005 22:43:36 +0900
Message-ID: <20051218134336.GG31571@htj.dyndns.org>
References: <20051218133305.GA31571@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.195]:32350 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965109AbVLRNnm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Dec 2005 08:43:42 -0500
Received: by zproxy.gmail.com with SMTP id 14so1715462nzn
        for <linux-ide@vger.kernel.org>; Sun, 18 Dec 2005 05:43:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20051218133305.GA31571@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, liml@rtr.ca
Cc: linux-ide@vger.kernel.org

Convert sata_sil24 ->phy_reset to ->soft_reset.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/sata_sil24.c
===================================================================
--- work.orig/drivers/scsi/sata_sil24.c	2005-12-18 18:21:56.000000000 +0900
+++ work/drivers/scsi/sata_sil24.c	2005-12-18 18:35:13.000000000 +0900
@@ -249,7 +249,7 @@ static u8 sil24_check_status(struct ata_
 static u32 sil24_scr_read(struct ata_port *ap, unsigned sc_reg);
 static void sil24_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val);
 static void sil24_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
-static void sil24_phy_reset(struct ata_port *ap);
+static int sil24_softreset(struct ata_port *ap, unsigned int *classes);
 static void sil24_qc_prep(struct ata_queued_cmd *qc);
 static int sil24_qc_issue(struct ata_queued_cmd *qc);
 static void sil24_irq_clear(struct ata_port *ap);
@@ -306,7 +306,8 @@ static const struct ata_port_operations 
 
 	.tf_read		= sil24_tf_read,
 
-	.phy_reset		= sil24_phy_reset,
+	.soft_reset		= sil24_softreset,
+	.post_reset		= ata_std_postreset,
 
 	.qc_prep		= sil24_qc_prep,
 	.qc_issue		= sil24_qc_issue,
@@ -336,8 +337,8 @@ static struct ata_port_info sil24_port_i
 	{
 		.sht		= &sil24_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
-				  ATA_FLAG_PIO_DMA | SIL24_NPORTS2FLAG(4),
+				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
+				  SIL24_NPORTS2FLAG(4),
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
@@ -347,8 +348,8 @@ static struct ata_port_info sil24_port_i
 	{
 		.sht		= &sil24_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
-				  ATA_FLAG_PIO_DMA | SIL24_NPORTS2FLAG(2),
+				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
+				  SIL24_NPORTS2FLAG(2),
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
@@ -358,8 +359,8 @@ static struct ata_port_info sil24_port_i
 	{
 		.sht		= &sil24_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
-				  ATA_FLAG_PIO_DMA | SIL24_NPORTS2FLAG(1),
+				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
+				  SIL24_NPORTS2FLAG(1),
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
@@ -428,7 +429,7 @@ static void sil24_tf_read(struct ata_por
 	*tf = pp->tf;
 }
 
-static int sil24_issue_SRST(struct ata_port *ap)
+static int sil24_softreset(struct ata_port *ap, unsigned int *classes)
 {
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
 	struct sil24_port_priv *pp = ap->private_data;
@@ -437,6 +438,8 @@ static int sil24_issue_SRST(struct ata_p
 	u32 irq_enable, irq_stat;
 	int cnt;
 
+	DPRINTK("ENTER\n");
+
 	/* temporarily turn off IRQs during SRST */
 	irq_enable = readl(port + PORT_IRQ_ENABLE_SET);
 	writel(irq_enable, port + PORT_IRQ_ENABLE_CLR);
@@ -466,30 +469,20 @@ static int sil24_issue_SRST(struct ata_p
 	/* restore IRQs */
 	writel(irq_enable, port + PORT_IRQ_ENABLE_SET);
 
-	if (!(irq_stat & PORT_IRQ_COMPLETE))
-		return -1;
-
-	/* update TF */
-	sil24_update_tf(ap);
-	return 0;
-}
-
-static void sil24_phy_reset(struct ata_port *ap)
-{
-	struct sil24_port_priv *pp = ap->private_data;
-
-	__sata_phy_reset(ap);
-	if (ap->flags & ATA_FLAG_PORT_DISABLED)
-		return;
+	if (sata_dev_present(ap)) {
+		if (!(irq_stat & PORT_IRQ_COMPLETE)) {
+			DPRINTK("EXIT, srst failed\n");
+			return -EIO;
+		}
 
-	if (sil24_issue_SRST(ap) < 0) {
-		printk(KERN_ERR DRV_NAME
-		       " ata%u: SRST failed, disabling port\n", ap->id);
-		ap->ops->port_disable(ap);
-		return;
+		sil24_update_tf(ap);
+		classes[0] = ata_dev_classify(&pp->tf);
 	}
+	if (classes[0] == ATA_DEV_UNKNOWN)
+		classes[0] = ATA_DEV_NONE;
 
-	ap->device->class = ata_dev_classify(&pp->tf);
+	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
+	return 0;
 }
 
 static inline void sil24_fill_sg(struct ata_queued_cmd *qc,
