From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH RFC v4 10/10] ahci_imx: Port to library-ised ahci_platform
Date: Mon, 20 Jan 2014 17:45:03 +0100
Message-ID: <1390236303-22538-11-git-send-email-hdegoede@redhat.com>
References: <1390236303-22538-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBMVF6WLAKGQED4DTJXQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1390236303-22538-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

This avoids the ugliness of creating a nested platform device from probe.

Note untested, I've ordered a wandboard to be able to test these changes.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 .../devicetree/bindings/ata/ahci-platform.txt      |   8 +-
 drivers/ata/ahci_imx.c                             | 199 ++++++++-------------
 2 files changed, 80 insertions(+), 127 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index f036e786..ee3a127 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -5,8 +5,8 @@ Each SATA controller should have its own node.
 
 Required properties:
 - compatible        : compatible list, one of "snps,spear-ahci",
-                      "snps,exynos5440-ahci", "ibm,476gtr-ahci", or
-                      "allwinner,sun4i-a10-ahci"
+                      "snps,exynos5440-ahci", "ibm,476gtr-ahci",
+                      "allwinner,sun4i-a10-ahci" or "fsl,imx6q-ahci"
 - interrupts        : <interrupt mapping for SATA IRQ>
 - reg               : <registers mapping>
 
@@ -18,6 +18,10 @@ Optional properties:
 allwinner,sun4i-a10-ahci required properties:
 - clocks            : index 0 must point to the sata_ref clk, 1 to the ahb clk
 
+fsl,imx6q-ahci required properties:
+- clocks            : index 0 must point to the sataf clk, 1 to the sata_ref
+		      clk and 2 to the ahb clk
+
 Examples:
         sata@ffe08000 {
 		compatible = "snps,spear-ahci";
diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 49fa0ca..3454b18 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -34,10 +34,14 @@ enum {
 	HOST_TIMER1MS = 0xe0,			/* Timer 1-ms */
 };
 
+enum {
+	CLK_SATA,
+	CLK_SATA_REF,
+	CLK_AHB
+};
+
 struct imx_ahci_priv {
 	struct platform_device *ahci_pdev;
-	struct clk *sata_ref_clk;
-	struct clk *ahb_clk;
 	struct regmap *gpr;
 	bool no_device;
 	bool first_time;
@@ -47,6 +51,8 @@ static int ahci_imx_hotplug;
 module_param_named(hotplug, ahci_imx_hotplug, int, 0644);
 MODULE_PARM_DESC(hotplug, "AHCI IMX hot-plug support (0=Don't support, 1=support)");
 
+static void ahci_imx_host_stop(struct ata_host *host);
+
 static void ahci_imx_error_handler(struct ata_port *ap)
 {
 	u32 reg_val;
@@ -54,7 +60,7 @@ static void ahci_imx_error_handler(struct ata_port *ap)
 	struct ata_host *host = dev_get_drvdata(ap->dev);
 	struct ahci_host_priv *hpriv = host->private_data;
 	void __iomem *mmio = hpriv->mmio;
-	struct imx_ahci_priv *imxpriv = dev_get_drvdata(ap->dev->parent);
+	struct imx_ahci_priv *imxpriv = hpriv->plat_data;
 
 	ahci_error_handler(ap);
 
@@ -75,12 +81,13 @@ static void ahci_imx_error_handler(struct ata_port *ap)
 	regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
 			IMX6Q_GPR13_SATA_MPLL_CLK_EN,
 			!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
-	clk_disable_unprepare(imxpriv->sata_ref_clk);
+	ahci_platform_disable_clks(hpriv);
 	imxpriv->no_device = true;
 }
 
 static struct ata_port_operations ahci_imx_ops = {
-	.inherits	= &ahci_platform_ops,
+	.inherits	= &ahci_ops,
+	.host_stop	= ahci_imx_host_stop,
 	.error_handler	= ahci_imx_error_handler,
 };
 
@@ -91,23 +98,38 @@ static const struct ata_port_info ahci_imx_port_info = {
 	.port_ops	= &ahci_imx_ops,
 };
 
-static int imx6q_sata_init(struct device *dev, struct ahci_host_priv *hpriv)
+static int imx_ahci_probe(struct platform_device *pdev)
 {
-	int ret = 0;
+	struct device *dev = &pdev->dev;
+	struct ahci_host_priv *hpriv;
+	struct imx_ahci_priv *imxpriv;
 	unsigned int reg_val;
-	struct imx_ahci_priv *imxpriv = dev_get_drvdata(dev->parent);
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
+	rc = ahci_platform_enable_resources(hpriv);
+	if (rc)
+		goto put_resources;
 
 	imxpriv->gpr =
 		syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
 	if (IS_ERR(imxpriv->gpr)) {
 		dev_err(dev, "failed to find fsl,imx6q-iomux-gpr regmap\n");
-		return PTR_ERR(imxpriv->gpr);
-	}
-
-	ret = clk_prepare_enable(imxpriv->sata_ref_clk);
-	if (ret < 0) {
-		dev_err(dev, "prepare-enable sata_ref clock err:%d\n", ret);
-		return ret;
+		rc = PTR_ERR(imxpriv->gpr);
+		goto disable_resources;
 	}
 
 	/*
@@ -156,24 +178,45 @@ static int imx6q_sata_init(struct device *dev, struct ahci_host_priv *hpriv)
 		writel(reg_val, hpriv->mmio + HOST_PORTS_IMPL);
 	}
 
-	reg_val = clk_get_rate(imxpriv->ahb_clk) / 1000;
+	reg_val = clk_get_rate(hpriv->clks[CLK_AHB]) / 1000;
 	writel(reg_val, hpriv->mmio + HOST_TIMER1MS);
 
+	rc = ahci_platform_init_host(pdev, hpriv, &ahci_imx_port_info, 0, 0);
+	if (rc)
+		goto disable_resources;
+
 	return 0;
+
+disable_resources:
+	ahci_platform_disable_resources(hpriv);
+put_resources:
+	ahci_platform_put_resources(hpriv);
+	return rc;
 }
 
-static void imx6q_sata_exit(struct device *dev)
+static void ahci_imx_host_stop(struct ata_host *host)
 {
-	struct imx_ahci_priv *imxpriv =  dev_get_drvdata(dev->parent);
+	struct ahci_host_priv *hpriv = host->private_data;
+	struct imx_ahci_priv *imxpriv = hpriv->plat_data;
 
-	regmap_update_bits(imxpriv->gpr, 0x34, IMX6Q_GPR13_SATA_MPLL_CLK_EN,
+	if (!imxpriv->no_device) {
+		regmap_update_bits(imxpriv->gpr, 0x34,
+			IMX6Q_GPR13_SATA_MPLL_CLK_EN,
 			!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
-	clk_disable_unprepare(imxpriv->sata_ref_clk);
+		ahci_platform_disable_clks(hpriv);
+	}
 }
 
 static int imx_ahci_suspend(struct device *dev)
 {
-	struct imx_ahci_priv *imxpriv =  dev_get_drvdata(dev->parent);
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
+	struct imx_ahci_priv *imxpriv = hpriv->plat_data;
+	int rc;
+
+	rc = ahci_platform_suspend_host(dev);
+	if (rc)
+		return rc;
 
 	/*
 	 * If no_device is set, The CLKs had been gated off in the
@@ -183,7 +226,7 @@ static int imx_ahci_suspend(struct device *dev)
 		regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
 				IMX6Q_GPR13_SATA_MPLL_CLK_EN,
 				!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
-		clk_disable_unprepare(imxpriv->sata_ref_clk);
+		ahci_platform_disable_clks(hpriv);
 	}
 
 	return 0;
@@ -191,11 +234,13 @@ static int imx_ahci_suspend(struct device *dev)
 
 static int imx_ahci_resume(struct device *dev)
 {
-	struct imx_ahci_priv *imxpriv =  dev_get_drvdata(dev->parent);
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
+	struct imx_ahci_priv *imxpriv = hpriv->plat_data;
 	int ret;
 
 	if (!imxpriv->no_device) {
-		ret = clk_prepare_enable(imxpriv->sata_ref_clk);
+		ret = ahci_platform_enable_clks(hpriv);
 		if (ret < 0) {
 			dev_err(dev, "pre-enable sata_ref clock err:%d\n", ret);
 			return ret;
@@ -207,123 +252,27 @@ static int imx_ahci_resume(struct device *dev)
 		usleep_range(1000, 2000);
 	}
 
-	return 0;
+	return ahci_platform_resume_host(dev);
 }
 
-static struct ahci_platform_data imx6q_sata_pdata = {
-	.init = imx6q_sata_init,
-	.exit = imx6q_sata_exit,
-	.ata_port_info = &ahci_imx_port_info,
-	.suspend = imx_ahci_suspend,
-	.resume = imx_ahci_resume,
-};
+static SIMPLE_DEV_PM_OPS(ahci_imx_pm_ops, imx_ahci_suspend, imx_ahci_resume);
 
 static const struct of_device_id imx_ahci_of_match[] = {
-	{ .compatible = "fsl,imx6q-ahci", .data = &imx6q_sata_pdata},
+	{ .compatible = "fsl,imx6q-ahci", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, imx_ahci_of_match);
 
-static int imx_ahci_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct resource *mem, *irq, res[2];
-	const struct of_device_id *of_id;
-	const struct ahci_platform_data *pdata = NULL;
-	struct imx_ahci_priv *imxpriv;
-	struct device *ahci_dev;
-	struct platform_device *ahci_pdev;
-	int ret;
-
-	imxpriv = devm_kzalloc(dev, sizeof(*imxpriv), GFP_KERNEL);
-	if (!imxpriv) {
-		dev_err(dev, "can't alloc ahci_host_priv\n");
-		return -ENOMEM;
-	}
-
-	ahci_pdev = platform_device_alloc("ahci", -1);
-	if (!ahci_pdev)
-		return -ENODEV;
-
-	ahci_dev = &ahci_pdev->dev;
-	ahci_dev->parent = dev;
-
-	imxpriv->no_device = false;
-	imxpriv->first_time = true;
-	imxpriv->ahb_clk = devm_clk_get(dev, "ahb");
-	if (IS_ERR(imxpriv->ahb_clk)) {
-		dev_err(dev, "can't get ahb clock.\n");
-		ret = PTR_ERR(imxpriv->ahb_clk);
-		goto err_out;
-	}
-
-	imxpriv->sata_ref_clk = devm_clk_get(dev, "sata_ref");
-	if (IS_ERR(imxpriv->sata_ref_clk)) {
-		dev_err(dev, "can't get sata_ref clock.\n");
-		ret = PTR_ERR(imxpriv->sata_ref_clk);
-		goto err_out;
-	}
-
-	imxpriv->ahci_pdev = ahci_pdev;
-	platform_set_drvdata(pdev, imxpriv);
-
-	of_id = of_match_device(imx_ahci_of_match, dev);
-	if (of_id) {
-		pdata = of_id->data;
-	} else {
-		ret = -EINVAL;
-		goto err_out;
-	}
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!mem || !irq) {
-		dev_err(dev, "no mmio/irq resource\n");
-		ret = -ENOMEM;
-		goto err_out;
-	}
-
-	res[0] = *mem;
-	res[1] = *irq;
-
-	ahci_dev->coherent_dma_mask = DMA_BIT_MASK(32);
-	ahci_dev->dma_mask = &ahci_dev->coherent_dma_mask;
-	ahci_dev->of_node = dev->of_node;
-
-	ret = platform_device_add_resources(ahci_pdev, res, 2);
-	if (ret)
-		goto err_out;
-
-	ret = platform_device_add_data(ahci_pdev, pdata, sizeof(*pdata));
-	if (ret)
-		goto err_out;
-
-	ret = platform_device_add(ahci_pdev);
-	if (ret) {
-err_out:
-		platform_device_put(ahci_pdev);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int imx_ahci_remove(struct platform_device *pdev)
-{
-	struct imx_ahci_priv *imxpriv = platform_get_drvdata(pdev);
-	struct platform_device *ahci_pdev = imxpriv->ahci_pdev;
-
-	platform_device_unregister(ahci_pdev);
-	return 0;
-}
 
 static struct platform_driver imx_ahci_driver = {
 	.probe = imx_ahci_probe,
-	.remove = imx_ahci_remove,
+	.remove = ata_platform_remove_one,
 	.driver = {
 		.name = "ahci-imx",
 		.owner = THIS_MODULE,
 		.of_match_table = imx_ahci_of_match,
+		.pm = &ahci_imx_pm_ops,
 	},
 };
 module_platform_driver(imx_ahci_driver);
-- 
1.8.5.3
