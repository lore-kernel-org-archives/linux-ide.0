From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/9] sata_sil24: convert to new reset mechanism
Date: Fri, 10 Feb 2006 23:58:48 +0900
Message-ID: <1139583528789-git-send-email-htejun@gmail.com>
References: <11395835282719-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.206]:20640 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751268AbWBJO6x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Feb 2006 09:58:53 -0500
Received: by xproxy.gmail.com with SMTP id s18so338572wxc
        for <linux-ide@vger.kernel.org>; Fri, 10 Feb 2006 06:58:52 -0800 (PST)
In-Reply-To: <11395835282719-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Convert sata_sil24 ->phy_reset to new reset mechanism.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   56 +++++++++++++++++++++++----------------------
 1 files changed, 28 insertions(+), 28 deletions(-)

e616f994715634d1feb81f6e0ac24e34896a4bb1
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 962396b..ccac05a 100644
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
@@ -306,7 +306,7 @@ static const struct ata_port_operations 
 
 	.tf_read		= sil24_tf_read,
 
-	.phy_reset		= sil24_phy_reset,
+	.probe_reset		= sil24_probe_reset,
 
 	.qc_prep		= sil24_qc_prep,
 	.qc_issue		= sil24_qc_issue,
@@ -336,8 +336,8 @@ static struct ata_port_info sil24_port_i
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
@@ -347,8 +347,8 @@ static struct ata_port_info sil24_port_i
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
@@ -358,8 +358,8 @@ static struct ata_port_info sil24_port_i
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
@@ -428,7 +428,8 @@ static void sil24_tf_read(struct ata_por
 	*tf = pp->tf;
 }
 
-static int sil24_issue_SRST(struct ata_port *ap)
+static int sil24_softreset(struct ata_port *ap, int verbose,
+			   unsigned int *class)
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
@@ -466,30 +469,27 @@ static int sil24_issue_SRST(struct ata_p
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
+	return ata_drive_probe_reset(ap, ata_std_probeinit,
+				     sil24_softreset, NULL,
+				     ata_std_postreset, classes);
 }
 
 static inline void sil24_fill_sg(struct ata_queued_cmd *qc,
-- 
1.1.5


