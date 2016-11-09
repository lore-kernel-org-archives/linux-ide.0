From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 3/4] pata: imx: add support of setting timings for PIO modes
Date: Wed,  9 Nov 2016 02:56:37 +0200
Message-ID: <20161109005638.17691-4-vz@mleia.com>
References: <20161109005638.17691-1-vz@mleia.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:50585 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932162AbcKIA4m (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 8 Nov 2016 19:56:42 -0500
In-Reply-To: <20161109005638.17691-1-vz@mleia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org

The controller is capable to operate in up to PIO4 mode, however
before the change the driver relies on timing settings done by
a bootloader for PIO0 mode only. The change adds more flexibility
in PIO mode selection at runtime and makes the driver to work even if
bootloader does not preset ATA timings.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/ata/pata_imx.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
index 00df18b..8f13c9f 100644
--- a/drivers/ata/pata_imx.c
+++ b/drivers/ata/pata_imx.c
@@ -11,7 +11,6 @@
  *
  * TODO:
  * - dmaengine support
- * - check if timing stuff needed
  */
 
 #include <linux/ata.h>
@@ -22,6 +21,16 @@
 
 #define DRV_NAME "pata_imx"
 
+#define PATA_IMX_ATA_TIME_OFF		0x00
+#define PATA_IMX_ATA_TIME_ON		0x01
+#define PATA_IMX_ATA_TIME_1		0x02
+#define PATA_IMX_ATA_TIME_2W		0x03
+#define PATA_IMX_ATA_TIME_2R		0x04
+#define PATA_IMX_ATA_TIME_AX		0x05
+#define PATA_IMX_ATA_TIME_PIO_RDX	0x06
+#define PATA_IMX_ATA_TIME_4		0x07
+#define PATA_IMX_ATA_TIME_9		0x08
+
 #define PATA_IMX_ATA_CONTROL		0x24
 #define PATA_IMX_ATA_CTRL_FIFO_RST_B	(1<<7)
 #define PATA_IMX_ATA_CTRL_ATA_RST_B	(1<<6)
@@ -31,6 +40,10 @@
 #define PATA_IMX_DRIVE_DATA		0xA0
 #define PATA_IMX_DRIVE_CONTROL		0xD8
 
+static u32 pio_t4[] = { 30,  20,  15,  10,  10 };
+static u32 pio_t9[] = { 20,  15,  10,  10,  10 };
+static u32 pio_tA[] = { 35,  35,  35,  35,  35 };
+
 struct pata_imx_priv {
 	struct clk *clk;
 	/* timings/interrupt/control regs */
@@ -38,11 +51,43 @@ struct pata_imx_priv {
 	u32 ata_ctl;
 };
 
+static void pata_imx_set_timing(struct ata_device *adev,
+				struct pata_imx_priv *priv)
+{
+	struct ata_timing timing;
+	unsigned long clkrate;
+	u32 T, mode;
+
+	clkrate = clk_get_rate(priv->clk);
+
+	if (adev->pio_mode < XFER_PIO_0 || adev->pio_mode > XFER_PIO_4 ||
+	    !clkrate)
+		return;
+
+	T = 1000000000 / clkrate;
+	ata_timing_compute(adev, adev->pio_mode, &timing, T * 1000, 0);
+
+	mode = adev->pio_mode - XFER_PIO_0;
+
+	writeb(3, priv->host_regs + PATA_IMX_ATA_TIME_OFF);
+	writeb(3, priv->host_regs + PATA_IMX_ATA_TIME_ON);
+	writeb(timing.setup, priv->host_regs + PATA_IMX_ATA_TIME_1);
+	writeb(timing.act8b, priv->host_regs + PATA_IMX_ATA_TIME_2W);
+	writeb(timing.act8b, priv->host_regs + PATA_IMX_ATA_TIME_2R);
+	writeb(1, priv->host_regs + PATA_IMX_ATA_TIME_PIO_RDX);
+
+	writeb(pio_t4[mode] / T + 1, priv->host_regs + PATA_IMX_ATA_TIME_4);
+	writeb(pio_t9[mode] / T + 1, priv->host_regs + PATA_IMX_ATA_TIME_9);
+	writeb(pio_tA[mode] / T + 1, priv->host_regs + PATA_IMX_ATA_TIME_AX);
+}
+
 static void pata_imx_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
 	struct pata_imx_priv *priv = ap->host->private_data;
 	u32 val;
 
+	pata_imx_set_timing(adev, priv);
+
 	val = __raw_readl(priv->host_regs + PATA_IMX_ATA_CONTROL);
 	if (ata_pio_need_iordy(adev))
 		val |= PATA_IMX_ATA_CTRL_IORDY_EN;
-- 
2.10.2

