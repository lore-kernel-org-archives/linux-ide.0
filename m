From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v5 11/14] ahci-imx: Add imx_ahci_phy_init /
 _exit helpers
Date: Wed, 22 Jan 2014 20:04:46 +0100
Message-ID: <1390417489-5354-12-git-send-email-hdegoede@redhat.com>
References: <1390417489-5354-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRB55MQCLQKGQEQKF2Y6Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1390417489-5354-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/ata/ahci_imx.c | 142 +++++++++++++++++++++++++++----------------------
 1 file changed, 77 insertions(+), 65 deletions(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 2210866..e58e062 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -51,6 +51,7 @@ static int ahci_imx_hotplug;
 module_param_named(hotplug, ahci_imx_hotplug, int, 0644);
 MODULE_PARM_DESC(hotplug, "AHCI IMX hot-plug support (0=Don't support, 1=support)");
 
+static void imx_ahci_phy_exit(struct ahci_host_priv *hpriv);
 static void ahci_imx_host_stop(struct ata_host *host);
 
 static void ahci_imx_error_handler(struct ata_port *ap)
@@ -78,10 +79,8 @@ static void ahci_imx_error_handler(struct ata_port *ap)
 	 */
 	reg_val = readl(mmio + PORT_PHY_CTL);
 	writel(reg_val | PORT_PHY_CTL_PDDQ_LOC, mmio + PORT_PHY_CTL);
-	regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
-			IMX6Q_GPR13_SATA_MPLL_CLK_EN,
-			!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
-	ahci_platform_disable_clks(hpriv);
+
+	imx_ahci_phy_exit(hpriv);
 	imxpriv->no_device = true;
 }
 
@@ -98,40 +97,18 @@ static const struct ata_port_info ahci_imx_port_info = {
 	.port_ops	= &ahci_imx_ops,
 };
 
-static int imx_ahci_probe(struct platform_device *pdev)
+static int imx_ahci_phy_init(struct ahci_host_priv *hpriv)
 {
-	struct device *dev = &pdev->dev;
-	struct ahci_host_priv *hpriv;
-	struct imx_ahci_priv *imxpriv;
-	unsigned int reg_val;
+	struct imx_ahci_priv *imxpriv = hpriv->plat_data;
 	int rc;
 
-	imxpriv = devm_kzalloc(dev, sizeof(*imxpriv), GFP_KERNEL);
-	if (!imxpriv)
-		return -ENOMEM;
-
-	hpriv = ahci_platform_get_resources(pdev);
-	if (IS_ERR(hpriv))
-		return PTR_ERR(hpriv);
-	if (!hpriv->clks[CLK_AHB]) {
-		dev_err(dev, "no ahb clk, need sata, sata_ref and ahb clks\n");
-		rc = -ENOENT;
-		goto put_resources;
-	}
-	hpriv->plat_data = imxpriv;
-
-	imxpriv->gpr =
-		syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
-	if (IS_ERR(imxpriv->gpr)) {
-		dev_err(dev, "failed to find fsl,imx6q-iomux-gpr regmap\n");
-		rc = PTR_ERR(imxpriv->gpr);
-		goto put_resources;
-	}
+	if (imxpriv->no_device)
+		return 0;
 
 	if (hpriv->target_pwr) {
 		rc = regulator_enable(hpriv->target_pwr);
 		if (rc)
-			goto put_resources;
+			return rc;
 	}
 
 	rc = ahci_platform_enable_clks(hpriv);
@@ -144,7 +121,8 @@ static int imx_ahci_probe(struct platform_device *pdev)
 	 * is 0x07ffffff, and the other one write for setting
 	 * the mpll_clk_en.
 	 */
-	regmap_update_bits(imxpriv->gpr, 0x34, IMX6Q_GPR13_SATA_RX_EQ_VAL_MASK
+	regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13
+			, IMX6Q_GPR13_SATA_RX_EQ_VAL_MASK
 			| IMX6Q_GPR13_SATA_RX_LOS_LVL_MASK
 			| IMX6Q_GPR13_SATA_RX_DPLL_MODE_MASK
 			| IMX6Q_GPR13_SATA_SPD_MODE_MASK
@@ -162,9 +140,69 @@ static int imx_ahci_probe(struct platform_device *pdev)
 			| IMX6Q_GPR13_SATA_TX_ATTEN_9_16
 			| IMX6Q_GPR13_SATA_TX_BOOST_3_33_DB
 			| IMX6Q_GPR13_SATA_TX_LVL_1_025_V);
-	regmap_update_bits(imxpriv->gpr, 0x34, IMX6Q_GPR13_SATA_MPLL_CLK_EN,
+
+	regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
+			IMX6Q_GPR13_SATA_MPLL_CLK_EN,
 			IMX6Q_GPR13_SATA_MPLL_CLK_EN);
-	usleep_range(100, 200);
+
+	usleep_range(1000, 2000);
+	return 0;
+
+disable_regulator:
+	if (hpriv->target_pwr)
+		regulator_disable(hpriv->target_pwr);
+	return rc;
+}
+
+static void imx_ahci_phy_exit(struct ahci_host_priv *hpriv)
+{
+	struct imx_ahci_priv *imxpriv = hpriv->plat_data;
+
+	if (imxpriv->no_device)
+		return;
+
+	regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
+			IMX6Q_GPR13_SATA_MPLL_CLK_EN,
+			!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
+	ahci_platform_disable_clks(hpriv);
+
+	if (hpriv->target_pwr)
+		regulator_disable(hpriv->target_pwr);
+}
+
+static int imx_ahci_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ahci_host_priv *hpriv;
+	struct imx_ahci_priv *imxpriv;
+	unsigned int reg_val;
+	int rc;
+
+	imxpriv = devm_kzalloc(dev, sizeof(*imxpriv), GFP_KERNEL);
+	if (!imxpriv)
+		return -ENOMEM;
+
+	hpriv = ahci_platform_get_resources(pdev);
+	if (IS_ERR(hpriv))
+		return PTR_ERR(hpriv);
+	if (!hpriv->clks[CLK_AHB]) {
+		dev_err(dev, "no ahb clk, need sata, sata_ref and ahb clks\n");
+		rc = -ENOENT;
+		goto put_resources;
+	}
+	hpriv->plat_data = imxpriv;
+
+	imxpriv->gpr =
+		syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
+	if (IS_ERR(imxpriv->gpr)) {
+		dev_err(dev, "failed to find fsl,imx6q-iomux-gpr regmap\n");
+		rc = PTR_ERR(imxpriv->gpr);
+		goto put_resources;
+	}
+
+	rc = imx_ahci_phy_init(hpriv);
+	if (rc)
+		goto put_resources;
 
 	/*
 	 * Configure the HWINIT bits of the HOST_CAP and HOST_PORTS_IMPL,
@@ -189,15 +227,12 @@ static int imx_ahci_probe(struct platform_device *pdev)
 
 	rc = ahci_platform_init_host(pdev, hpriv, &ahci_imx_port_info, 0, 0);
 	if (rc)
-		goto disable_clks;
+		goto phy_exit;
 
 	return 0;
 
-disable_clks:
-	ahci_platform_disable_clks(hpriv);
-disable_regulator:
-	if (hpriv->target_pwr)
-		regulator_disable(hpriv->target_pwr);
+phy_exit:
+	imx_ahci_phy_exit(hpriv);
 put_resources:
 	ahci_platform_put_resources(hpriv);
 	return rc;
@@ -206,18 +241,8 @@ put_resources:
 static void ahci_imx_host_stop(struct ata_host *host)
 {
 	struct ahci_host_priv *hpriv = host->private_data;
-	struct imx_ahci_priv *imxpriv = hpriv->plat_data;
-
-	if (!imxpriv->no_device) {
-		regmap_update_bits(imxpriv->gpr, 0x34,
-			IMX6Q_GPR13_SATA_MPLL_CLK_EN,
-			!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
-		ahci_platform_disable_clks(hpriv);
-	}
-
-	if (hpriv->target_pwr)
-		regulator_disable(hpriv->target_pwr);
 
+	imx_ahci_phy_exit(hpriv);
 	ahci_platform_put_resources(hpriv);
 }
 
@@ -225,26 +250,13 @@ static int imx_ahci_suspend(struct device *dev)
 {
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct ahci_host_priv *hpriv = host->private_data;
-	struct imx_ahci_priv *imxpriv = hpriv->plat_data;
 	int rc;
 
 	rc = ahci_platform_suspend_host(dev);
 	if (rc)
 		return rc;
 
-	/*
-	 * If no_device is set, The CLKs had been gated off in the
-	 * initialization so don't do it again here.
-	 */
-	if (!imxpriv->no_device) {
-		regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
-				IMX6Q_GPR13_SATA_MPLL_CLK_EN,
-				!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
-		ahci_platform_disable_clks(hpriv);
-	}
-
-	if (hpriv->target_pwr)
-		regulator_disable(hpriv->target_pwr);
+	imx_ahci_phy_exit(hpriv);
 
 	return 0;
 }
-- 
1.8.5.3
