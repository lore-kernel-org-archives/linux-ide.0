From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Subject: [PATCH V4] sata_rcar: Add R-Car Gen2 SATA PHY support
Date: Wed, 30 Oct 2013 21:14:21 +0400
Message-ID: <1383153261-17383-1-git-send-email-valentine.barshak@cogentembedded.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:63401 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553Ab3J3ROk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Oct 2013 13:14:40 -0400
Received: by mail-la0-f53.google.com with SMTP id eo20so1377022lab.12
        for <linux-ide@vger.kernel.org>; Wed, 30 Oct 2013 10:14:38 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kumar Gala <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Mark Rutland <mark.rutland@arm.com>

R-Car Gen2 SoCs have a different PHY which is not compatible
with the older R-Car H1 (R8A7779) version.
This adds OF/platform device id tables and PHY initialization
callbacks for the following Gen2 SoCs:
  * R-Car H2: R8A7790;
  * R-Car M2: R8A7791.

PHY initialization method is chosen based on the device id.
Default PHY settings are applied for Gen2 SoCs, which should
suit the Gen2 boards available.

While at it, this also adds "sata-r8a7779" compatibility string
for R-Car H1 SATA, while keeping the old one for compatibility.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 drivers/ata/sata_rcar.c | 118 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 102 insertions(+), 16 deletions(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index c2d95e9..c9ea1bd 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/ata.h>
 #include <linux/libata.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -123,12 +124,37 @@
 
 #define SATA_RCAR_DMA_BOUNDARY		0x1FFFFFFEUL
 
+/* Gen2 Physical Layer Control Registers */
+#define RCAR_GEN2_PHY_CTL1_REG		0x1704
+#define RCAR_GEN2_PHY_CTL1		0x34180002
+#define RCAR_GEN2_PHY_CTL1_SS		0xC180	/* Spread Spectrum */
+
+#define RCAR_GEN2_PHY_CTL2_REG		0x170C
+#define RCAR_GEN2_PHY_CTL2		0x00002303
+
+#define RCAR_GEN2_PHY_CTL3_REG		0x171C
+#define RCAR_GEN2_PHY_CTL3		0x000B0194
+
+#define RCAR_GEN2_PHY_CTL4_REG		0x1724
+#define RCAR_GEN2_PHY_CTL4		0x00030994
+
+#define RCAR_GEN2_PHY_CTL5_REG		0x1740
+#define RCAR_GEN2_PHY_CTL5		0x03004001
+#define RCAR_GEN2_PHY_CTL5_DC		BIT(1)	/* DC connection */
+#define RCAR_GEN2_PHY_CTL5_TR		BIT(2)	/* Termination Resistor */
+
+enum sata_rcar_type {
+	RCAR_GEN1_SATA,
+	RCAR_GEN2_SATA,
+};
+
 struct sata_rcar_priv {
 	void __iomem *base;
 	struct clk *clk;
+	enum sata_rcar_type type;
 };
 
-static void sata_rcar_phy_initialize(struct sata_rcar_priv *priv)
+static void sata_rcar_gen1_phy_preinit(struct sata_rcar_priv *priv)
 {
 	void __iomem *base = priv->base;
 
@@ -141,8 +167,8 @@ static void sata_rcar_phy_initialize(struct sata_rcar_priv *priv)
 	iowrite32(0, base + SATAPHYRESET_REG);
 }
 
-static void sata_rcar_phy_write(struct sata_rcar_priv *priv, u16 reg, u32 val,
-				int group)
+static void sata_rcar_gen1_phy_write(struct sata_rcar_priv *priv, u16 reg,
+				     u32 val, int group)
 {
 	void __iomem *base = priv->base;
 	int timeout;
@@ -170,6 +196,29 @@ static void sata_rcar_phy_write(struct sata_rcar_priv *priv, u16 reg, u32 val,
 	iowrite32(0, base + SATAPHYADDR_REG);
 }
 
+static void sata_rcar_gen1_phy_init(struct sata_rcar_priv *priv)
+{
+	sata_rcar_gen1_phy_preinit(priv);
+	sata_rcar_gen1_phy_write(priv, SATAPCTLR1_REG, 0x00200188, 0);
+	sata_rcar_gen1_phy_write(priv, SATAPCTLR1_REG, 0x00200188, 1);
+	sata_rcar_gen1_phy_write(priv, SATAPCTLR3_REG, 0x0000A061, 0);
+	sata_rcar_gen1_phy_write(priv, SATAPCTLR2_REG, 0x20000000, 0);
+	sata_rcar_gen1_phy_write(priv, SATAPCTLR2_REG, 0x20000000, 1);
+	sata_rcar_gen1_phy_write(priv, SATAPCTLR4_REG, 0x28E80000, 0);
+}
+
+static void sata_rcar_gen2_phy_init(struct sata_rcar_priv *priv)
+{
+	void __iomem *base = priv->base;
+
+	iowrite32(RCAR_GEN2_PHY_CTL1, base + RCAR_GEN2_PHY_CTL1_REG);
+	iowrite32(RCAR_GEN2_PHY_CTL2, base + RCAR_GEN2_PHY_CTL2_REG);
+	iowrite32(RCAR_GEN2_PHY_CTL3, base + RCAR_GEN2_PHY_CTL3_REG);
+	iowrite32(RCAR_GEN2_PHY_CTL4, base + RCAR_GEN2_PHY_CTL4_REG);
+	iowrite32(RCAR_GEN2_PHY_CTL5 | RCAR_GEN2_PHY_CTL5_DC |
+		  RCAR_GEN2_PHY_CTL5_TR, base + RCAR_GEN2_PHY_CTL5_REG);
+}
+
 static void sata_rcar_freeze(struct ata_port *ap)
 {
 	struct sata_rcar_priv *priv = ap->host->private_data;
@@ -738,13 +787,17 @@ static void sata_rcar_init_controller(struct ata_host *host)
 	u32 val;
 
 	/* reset and setup phy */
-	sata_rcar_phy_initialize(priv);
-	sata_rcar_phy_write(priv, SATAPCTLR1_REG, 0x00200188, 0);
-	sata_rcar_phy_write(priv, SATAPCTLR1_REG, 0x00200188, 1);
-	sata_rcar_phy_write(priv, SATAPCTLR3_REG, 0x0000A061, 0);
-	sata_rcar_phy_write(priv, SATAPCTLR2_REG, 0x20000000, 0);
-	sata_rcar_phy_write(priv, SATAPCTLR2_REG, 0x20000000, 1);
-	sata_rcar_phy_write(priv, SATAPCTLR4_REG, 0x28E80000, 0);
+	switch (priv->type) {
+	case RCAR_GEN1_SATA:
+		sata_rcar_gen1_phy_init(priv);
+		break;
+	case RCAR_GEN2_SATA:
+		sata_rcar_gen2_phy_init(priv);
+		break;
+	default:
+		dev_warn(host->dev, "SATA phy is not initialized\n");
+		break;
+	}
 
 	/* SATA-IP reset state */
 	val = ioread32(base + ATAPI_CONTROL1_REG);
@@ -770,8 +823,40 @@ static void sata_rcar_init_controller(struct ata_host *host)
 	iowrite32(ATAPI_INT_ENABLE_SATAINT, base + ATAPI_INT_ENABLE_REG);
 }
 
+static struct of_device_id sata_rcar_match[] = {
+	{
+		/* Deprecated by "renesas,sata-r8a7779" */
+		.compatible = "renesas,rcar-sata",
+		.data = (void *)RCAR_GEN1_SATA,
+	},
+	{
+		.compatible = "renesas,sata-r8a7779",
+		.data = (void *)RCAR_GEN1_SATA,
+	},
+	{
+		.compatible = "renesas,sata-r8a7790",
+		.data = (void *)RCAR_GEN2_SATA
+	},
+	{
+		.compatible = "renesas,sata-r8a7791",
+		.data = (void *)RCAR_GEN2_SATA
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, sata_rcar_match);
+
+static const struct platform_device_id sata_rcar_id_table[] = {
+	{ "sata_rcar", RCAR_GEN1_SATA }, /* Deprecated by "sata-r8a7779" */
+	{ "sata-r8a7779", RCAR_GEN1_SATA },
+	{ "sata-r8a7790", RCAR_GEN2_SATA },
+	{ "sata-r8a7791", RCAR_GEN2_SATA },
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, sata_rcar_id_table);
+
 static int sata_rcar_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *of_id;
 	struct ata_host *host;
 	struct sata_rcar_priv *priv;
 	struct resource *mem;
@@ -787,6 +872,12 @@ static int sata_rcar_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	of_id = of_match_device(sata_rcar_match, &pdev->dev);
+	if (of_id)
+		priv->type = (enum sata_rcar_type)of_id->data;
+	else
+		priv->type = platform_get_device_id(pdev)->driver_data;
+
 	priv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		dev_err(&pdev->dev, "failed to get access to sata clock\n");
@@ -892,15 +983,10 @@ static const struct dev_pm_ops sata_rcar_pm_ops = {
 };
 #endif
 
-static struct of_device_id sata_rcar_match[] = {
-	{ .compatible = "renesas,rcar-sata", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, sata_rcar_match);
-
 static struct platform_driver sata_rcar_driver = {
 	.probe		= sata_rcar_probe,
 	.remove		= sata_rcar_remove,
+	.id_table	= sata_rcar_id_table,
 	.driver = {
 		.name		= DRV_NAME,
 		.owner		= THIS_MODULE,
-- 
1.8.3.1

