From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 2/4] pata: imx: set controller PIO mode with .set_piomode callback
Date: Wed,  9 Nov 2016 02:56:36 +0200
Message-ID: <20161109005638.17691-3-vz@mleia.com>
References: <20161109005638.17691-1-vz@mleia.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:50577 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754024AbcKIA4m (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 8 Nov 2016 19:56:42 -0500
In-Reply-To: <20161109005638.17691-1-vz@mleia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org

Convert .set_mode callback function to more specific .set_piomode,
the driver does not have support of DMA modes, thus a simpler version
of the callback is preferred.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/ata/pata_imx.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
index 203e309..00df18b 100644
--- a/drivers/ata/pata_imx.c
+++ b/drivers/ata/pata_imx.c
@@ -38,28 +38,17 @@ struct pata_imx_priv {
 	u32 ata_ctl;
 };
 
-static int pata_imx_set_mode(struct ata_link *link, struct ata_device **unused)
+static void pata_imx_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
-	struct ata_device *dev;
-	struct ata_port *ap = link->ap;
 	struct pata_imx_priv *priv = ap->host->private_data;
 	u32 val;
 
-	ata_for_each_dev(dev, link, ENABLED) {
-		dev->pio_mode = dev->xfer_mode = XFER_PIO_0;
-		dev->xfer_shift = ATA_SHIFT_PIO;
-		dev->flags |= ATA_DFLAG_PIO;
-
-		val = __raw_readl(priv->host_regs + PATA_IMX_ATA_CONTROL);
-		if (ata_pio_need_iordy(dev))
-			val |= PATA_IMX_ATA_CTRL_IORDY_EN;
-		else
-			val &= ~PATA_IMX_ATA_CTRL_IORDY_EN;
-		__raw_writel(val, priv->host_regs + PATA_IMX_ATA_CONTROL);
-
-		ata_dev_info(dev, "configured for PIO\n");
-	}
-	return 0;
+	val = __raw_readl(priv->host_regs + PATA_IMX_ATA_CONTROL);
+	if (ata_pio_need_iordy(adev))
+		val |= PATA_IMX_ATA_CTRL_IORDY_EN;
+	else
+		val &= ~PATA_IMX_ATA_CTRL_IORDY_EN;
+	__raw_writel(val, priv->host_regs + PATA_IMX_ATA_CONTROL);
 }
 
 static struct scsi_host_template pata_imx_sht = {
@@ -70,7 +59,7 @@ static struct ata_port_operations pata_imx_port_ops = {
 	.inherits		= &ata_sff_port_ops,
 	.sff_data_xfer		= ata_sff_data_xfer_noirq,
 	.cable_detect		= ata_cable_unknown,
-	.set_mode		= pata_imx_set_mode,
+	.set_piomode		= pata_imx_set_piomode,
 };
 
 static void pata_imx_setup_port(struct ata_ioports *ioaddr)
-- 
2.10.2

