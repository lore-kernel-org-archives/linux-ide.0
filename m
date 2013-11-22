From: Marek Vasut <marex@denx.de>
Subject: [PATCH V5 3/6] ahci: imx: Add i.MX53 support
Date: Fri, 22 Nov 2013 12:05:01 +0100
Message-ID: <1385118304-27435-3-git-send-email-marex@denx.de>
References: <1385118304-27435-1-git-send-email-marex@denx.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:50484 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238Ab3KVLFS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Nov 2013 06:05:18 -0500
In-Reply-To: <1385118304-27435-1-git-send-email-marex@denx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marex@denx.de>, Shawn Guo <shawn.guo@linaro.org>, Richard Zhu <r65037@freescale.com>, Tejun Heo <tj@kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>

Add minor adjustments to support i.MX53 SATA port as well as i.MX6Q one.
The difference here is mostly the clock which need to be enabled and also
the lack of need of programming IOMUXC registers on i.MX53. All of which
is well handles in the clock enable/disable functions. Note that this patch
also cleans up the names of the common functions, so they don't read imx6q_*
but imx_* instead.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Richard Zhu <r65037@freescale.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Linux-IDE <linux-ide@vger.kernel.org>
---
 drivers/ata/ahci_imx.c | 164 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 106 insertions(+), 58 deletions(-)

V2: Rebase this patch to be coherent with formating change in 1/5 .
V3: Rebase this patch to be coherent with change in 1/5 .
V4: Use sata_ref_clk for both MX53 and MX6 instead of separate sata_phy_clk
    for MX53.
V5: Rebase on top of changes in 1/6 and 2/6 . Note that I am keeping the small
    delay after enabling clock on MX53 as well.

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index c5f4d55..29a10e6 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -34,10 +34,21 @@ enum {
 	HOST_TIMER1MS = 0xe0,			/* Timer 1-ms */
 };
 
+enum ahci_imx_type {
+	AHCI_IMX53,
+	AHCI_IMX6Q,
+};
+
 struct imx_ahci_priv {
 	struct platform_device *ahci_pdev;
+	enum ahci_imx_type type;
+
+	/* i.MX53 clock */
+	struct clk *sata_gate_clk;
+	/* Common clock */
 	struct clk *sata_ref_clk;
 	struct clk *ahb_clk;
+
 	struct regmap *gpr;
 	bool no_device;
 	bool first_time;
@@ -52,29 +63,52 @@ static int imx_sata_clock_enable(struct device *dev)
 	struct imx_ahci_priv *imxpriv = dev_get_drvdata(dev->parent);
 	int ret;
 
+	if (imxpriv->type == AHCI_IMX53) {
+		ret = clk_prepare_enable(imxpriv->sata_gate_clk);
+		if (ret < 0) {
+			dev_err(dev, "prepare-enable sata_gate clock err:%d\n",
+				ret);
+			return ret;
+		}
+	}
+
 	ret = clk_prepare_enable(imxpriv->sata_ref_clk);
 	if (ret < 0) {
-		dev_err(dev, "prepare-enable sata_ref clock err:%d\n", ret);
-		return ret;
+		dev_err(dev, "prepare-enable sata_ref clock err:%d\n",
+			ret);
+		goto clk_err;
 	}
 
-	regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
-			   IMX6Q_GPR13_SATA_MPLL_CLK_EN,
-			   IMX6Q_GPR13_SATA_MPLL_CLK_EN);
+	if (imxpriv->type == AHCI_IMX6Q) {
+		regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
+				   IMX6Q_GPR13_SATA_MPLL_CLK_EN,
+				   IMX6Q_GPR13_SATA_MPLL_CLK_EN);
+	}
 
 	usleep_range(1000, 2000);
 
 	return 0;
+
+clk_err:
+	if (imxpriv->type == AHCI_IMX53)
+		clk_disable_unprepare(imxpriv->sata_gate_clk);
+	return ret;
 }
 
 static void imx_sata_clock_disable(struct device *dev)
 {
 	struct imx_ahci_priv *imxpriv = dev_get_drvdata(dev->parent);
 
-	regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
-			   IMX6Q_GPR13_SATA_MPLL_CLK_EN,
-			   !IMX6Q_GPR13_SATA_MPLL_CLK_EN);
+	if (imxpriv->type == AHCI_IMX6Q) {
+		regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
+				   IMX6Q_GPR13_SATA_MPLL_CLK_EN,
+				   !IMX6Q_GPR13_SATA_MPLL_CLK_EN);
+	}
+
 	clk_disable_unprepare(imxpriv->sata_ref_clk);
+
+	if (imxpriv->type == AHCI_IMX53)
+		clk_disable_unprepare(imxpriv->sata_gate_clk);
 }
 
 static void ahci_imx_error_handler(struct ata_port *ap)
@@ -118,7 +152,7 @@ static const struct ata_port_info ahci_imx_port_info = {
 	.port_ops	= &ahci_imx_ops,
 };
 
-static int imx6q_sata_init(struct device *dev, void __iomem *mmio)
+static int imx_sata_init(struct device *dev, void __iomem *mmio)
 {
 	int ret = 0;
 	unsigned int reg_val;
@@ -152,7 +186,7 @@ static int imx6q_sata_init(struct device *dev, void __iomem *mmio)
 	return 0;
 }
 
-static void imx6q_sata_exit(struct device *dev)
+static void imx_sata_exit(struct device *dev)
 {
 	imx_sata_clock_disable(dev);
 }
@@ -182,16 +216,18 @@ static int imx_ahci_resume(struct device *dev)
 	return ret;
 }
 
-static struct ahci_platform_data imx6q_sata_pdata = {
-	.init = imx6q_sata_init,
-	.exit = imx6q_sata_exit,
-	.ata_port_info = &ahci_imx_port_info,
-	.suspend = imx_ahci_suspend,
-	.resume = imx_ahci_resume,
+static struct ahci_platform_data imx_sata_pdata = {
+	.init		= imx_sata_init,
+	.exit		= imx_sata_exit,
+	.ata_port_info	= &ahci_imx_port_info,
+	.suspend	= imx_ahci_suspend,
+	.resume		= imx_ahci_resume,
+
 };
 
 static const struct of_device_id imx_ahci_of_match[] = {
-	{ .compatible = "fsl,imx6q-ahci", .data = &imx6q_sata_pdata},
+	{ .compatible = "fsl,imx53-ahci", .data = (void *)AHCI_IMX53 },
+	{ .compatible = "fsl,imx6q-ahci", .data = (void *)AHCI_IMX6Q },
 	{},
 };
 MODULE_DEVICE_TABLE(of, imx_ahci_of_match);
@@ -201,12 +237,20 @@ static int imx_ahci_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct resource *mem, *irq, res[2];
 	const struct of_device_id *of_id;
+	enum ahci_imx_type type;
 	const struct ahci_platform_data *pdata = NULL;
 	struct imx_ahci_priv *imxpriv;
 	struct device *ahci_dev;
 	struct platform_device *ahci_pdev;
 	int ret;
 
+	of_id = of_match_device(imx_ahci_of_match, dev);
+	if (!of_id)
+		return -EINVAL;
+
+	type = (enum ahci_imx_type)of_id->data;
+	pdata = &imx_sata_pdata;
+
 	imxpriv = devm_kzalloc(dev, sizeof(*imxpriv), GFP_KERNEL);
 	if (!imxpriv) {
 		dev_err(dev, "can't alloc ahci_host_priv\n");
@@ -222,6 +266,8 @@ static int imx_ahci_probe(struct platform_device *pdev)
 
 	imxpriv->no_device = false;
 	imxpriv->first_time = true;
+	imxpriv->type = type;
+
 	imxpriv->ahb_clk = devm_clk_get(dev, "ahb");
 	if (IS_ERR(imxpriv->ahb_clk)) {
 		dev_err(dev, "can't get ahb clock.\n");
@@ -229,6 +275,15 @@ static int imx_ahci_probe(struct platform_device *pdev)
 		goto err_out;
 	}
 
+	if (type == AHCI_IMX53) {
+		imxpriv->sata_gate_clk = devm_clk_get(dev, "sata_gate");
+		if (IS_ERR(imxpriv->sata_gate_clk)) {
+			dev_err(dev, "can't get sata_gate clock.\n");
+			ret = PTR_ERR(imxpriv->sata_gate_clk);
+			goto err_out;
+		}
+	}
+
 	imxpriv->sata_ref_clk = devm_clk_get(dev, "sata_ref");
 	if (IS_ERR(imxpriv->sata_ref_clk)) {
 		dev_err(dev, "can't get sata_ref clock.\n");
@@ -239,14 +294,6 @@ static int imx_ahci_probe(struct platform_device *pdev)
 	imxpriv->ahci_pdev = ahci_pdev;
 	platform_set_drvdata(pdev, imxpriv);
 
-	of_id = of_match_device(imx_ahci_of_match, dev);
-	if (of_id) {
-		pdata = of_id->data;
-	} else {
-		ret = -EINVAL;
-		goto err_out;
-	}
-
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (!mem || !irq) {
@@ -262,41 +309,42 @@ static int imx_ahci_probe(struct platform_device *pdev)
 	ahci_dev->dma_mask = &ahci_dev->coherent_dma_mask;
 	ahci_dev->of_node = dev->of_node;
 
-	imxpriv->gpr =
-		syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
-
-	if (IS_ERR(imxpriv->gpr)) {
-		dev_err(dev, "failed to find fsl,imx6q-iomux-gpr regmap\n");
-		ret = PTR_ERR(imxpriv->gpr);
-		goto err_out;
+	if (type == AHCI_IMX6Q) {
+		imxpriv->gpr = syscon_regmap_lookup_by_compatible(
+							"fsl,imx6q-iomuxc-gpr");
+		if (IS_ERR(imxpriv->gpr)) {
+			dev_err(dev,
+				"failed to find fsl,imx6q-iomux-gpr regmap\n");
+			return PTR_ERR(imxpriv->gpr);
+		}
+
+		/*
+		 * Set PHY Paremeters, two steps to configure the GPR13,
+		 * one write for rest of parameters, mask of first write
+		 * is 0x07fffffe, and the other one write for setting
+		 * the mpll_clk_en happens in imx_sata_clock_enable().
+		 */
+		regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
+				   IMX6Q_GPR13_SATA_RX_EQ_VAL_MASK |
+				   IMX6Q_GPR13_SATA_RX_LOS_LVL_MASK |
+				   IMX6Q_GPR13_SATA_RX_DPLL_MODE_MASK |
+				   IMX6Q_GPR13_SATA_SPD_MODE_MASK |
+				   IMX6Q_GPR13_SATA_MPLL_SS_EN |
+				   IMX6Q_GPR13_SATA_TX_ATTEN_MASK |
+				   IMX6Q_GPR13_SATA_TX_BOOST_MASK |
+				   IMX6Q_GPR13_SATA_TX_LVL_MASK |
+				   IMX6Q_GPR13_SATA_TX_EDGE_RATE |
+				   IMX6Q_GPR13_SATA_MPLL_CLK_EN,
+				   IMX6Q_GPR13_SATA_RX_EQ_VAL_3_0_DB |
+				   IMX6Q_GPR13_SATA_RX_LOS_LVL_SATA2M |
+				   IMX6Q_GPR13_SATA_RX_DPLL_MODE_2P_4F |
+				   IMX6Q_GPR13_SATA_SPD_MODE_3P0G |
+				   IMX6Q_GPR13_SATA_MPLL_SS_EN |
+				   IMX6Q_GPR13_SATA_TX_ATTEN_9_16 |
+				   IMX6Q_GPR13_SATA_TX_BOOST_3_33_DB |
+				   IMX6Q_GPR13_SATA_TX_LVL_1_025_V);
 	}
 
-	/*
-	 * Set PHY Paremeters, two steps to configure the GPR13,
-	 * one write for rest of parameters, mask of first write
-	 * is 0x07fffffe, and the other one write for setting
-	 * the mpll_clk_en happens in imx_sata_clock_enable().
-	 */
-	regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
-			   IMX6Q_GPR13_SATA_RX_EQ_VAL_MASK |
-			   IMX6Q_GPR13_SATA_RX_LOS_LVL_MASK |
-			   IMX6Q_GPR13_SATA_RX_DPLL_MODE_MASK |
-			   IMX6Q_GPR13_SATA_SPD_MODE_MASK |
-			   IMX6Q_GPR13_SATA_MPLL_SS_EN |
-			   IMX6Q_GPR13_SATA_TX_ATTEN_MASK |
-			   IMX6Q_GPR13_SATA_TX_BOOST_MASK |
-			   IMX6Q_GPR13_SATA_TX_LVL_MASK |
-			   IMX6Q_GPR13_SATA_TX_EDGE_RATE |
-			   IMX6Q_GPR13_SATA_MPLL_CLK_EN,
-			   IMX6Q_GPR13_SATA_RX_EQ_VAL_3_0_DB |
-			   IMX6Q_GPR13_SATA_RX_LOS_LVL_SATA2M |
-			   IMX6Q_GPR13_SATA_RX_DPLL_MODE_2P_4F |
-			   IMX6Q_GPR13_SATA_SPD_MODE_3P0G |
-			   IMX6Q_GPR13_SATA_MPLL_SS_EN |
-			   IMX6Q_GPR13_SATA_TX_ATTEN_9_16 |
-			   IMX6Q_GPR13_SATA_TX_BOOST_3_33_DB |
-			   IMX6Q_GPR13_SATA_TX_LVL_1_025_V);
-
 	ret = platform_device_add_resources(ahci_pdev, res, 2);
 	if (ret)
 		goto err_out;
-- 
1.8.4.2

