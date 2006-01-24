From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/12] sata_sil24: convert to new reset mechanism
Date: Tue, 24 Jan 2006 17:05:22 +0900
Message-ID: <1138089922977-git-send-email-htejun@gmail.com>
References: <1138089921565-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.192]:30875 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030359AbWAXIFg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jan 2006 03:05:36 -0500
Received: by zproxy.gmail.com with SMTP id z31so979657nzd
        for <linux-ide@vger.kernel.org>; Tue, 24 Jan 2006 00:05:35 -0800 (PST)
In-Reply-To: <1138089921565-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: Tejun Heo <htejun@gmail.com>

Convert sata_sil24 ->phy_reset to new reset mechanism.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   55 ++++++++++++++++++++++-----------------------
 1 files changed, 27 insertions(+), 28 deletions(-)

0e78d1ce36a30c8e8168af303579c248e32467f1
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 1160fda..f884c31 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -249,7 +249,7 @@ static u8 sil24_check_status(struct ata_
 static u32 sil24_scr_read(struct ata_port *ap, unsigned sc_reg);
 static void sil24_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val);
 static void sil24_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
-static void sil24_phy_reset(struct ata_port *ap);
+static int sil24_probe_reset(struct ata_port *ap, unsigned int *classes);
 static void sil24_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc);
 static void sil24_irq_clear(struct ata_port *ap);
@@ -305,7 +305,7 @@ static const struct ata_port_operations 
 
 	.tf_read		= sil24_tf_read,
 
-	.phy_reset		= sil24_phy_reset,
+	.probe_reset		= sil24_probe_reset,
 
 	.qc_prep		= sil24_qc_prep,
 	.qc_issue		= sil24_qc_issue,
@@ -335,8 +335,8 @@ static struct ata_port_info sil24_port_i
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
@@ -346,8 +346,8 @@ static struct ata_port_info sil24_port_i
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
@@ -357,8 +357,8 @@ static struct ata_port_info sil24_port_i
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
@@ -427,7 +427,8 @@ static void sil24_tf_read(struct ata_por
 	*tf = pp->tf;
 }
 
-static int sil24_issue_SRST(struct ata_port *ap)
+static int sil24_softreset(struct ata_port *ap, int verbose,
+			   unsigned int *class)
 {
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
 	struct sil24_port_priv *pp = ap->private_data;
@@ -436,6 +437,8 @@ static int sil24_issue_SRST(struct ata_p
 	u32 irq_enable, irq_stat;
 	int cnt;
 
+	DPRINTK("ENTER\n");
+
 	/* temporarily turn off IRQs during SRST */
 	irq_enable = readl(port + PORT_IRQ_ENABLE_SET);
 	writel(irq_enable, port + PORT_IRQ_ENABLE_CLR);
@@ -465,30 +468,26 @@ static int sil24_issue_SRST(struct ata_p
 	/* restore IRQs */
 	writel(irq_enable, port + PORT_IRQ_ENABLE_SET);
 
-	if (!(irq_stat & PORT_IRQ_COMPLETE))
-		return -1;
+	if (sata_dev_present(ap)) {
+		if (!(irq_stat & PORT_IRQ_COMPLETE)) {
+			DPRINTK("EXIT, srst failed\n");
+			return -EIO;
+		}
 
-	/* update TF */
-	sil24_update_tf(ap);
+		sil24_update_tf(ap);
+		*class = ata_dev_classify(&pp->tf);
+	}
+	if (*class == ATA_DEV_UNKNOWN)
+		*class = ATA_DEV_NONE;
+
+	DPRINTK("EXIT, class=%u\n", *class);
 	return 0;
 }
 
-static void sil24_phy_reset(struct ata_port *ap)
+static int sil24_probe_reset(struct ata_port *ap, unsigned int *classes)
 {
-	struct sil24_port_priv *pp = ap->private_data;
-
-	__sata_phy_reset(ap);
-	if (ap->flags & ATA_FLAG_PORT_DISABLED)
-		return;
-
-	if (sil24_issue_SRST(ap) < 0) {
-		printk(KERN_ERR DRV_NAME
-		       " ata%u: SRST failed, disabling port\n", ap->id);
-		ap->ops->port_disable(ap);
-		return;
-	}
-
-	ap->device->class = ata_dev_classify(&pp->tf);
+	return ata_drive_probe_reset(ap, sil24_softreset, NULL,
+				     ata_std_postreset, classes);
 }
 
 static inline void sil24_fill_sg(struct ata_queued_cmd *qc,
-- 
1.1.3


