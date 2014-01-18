From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC v3 10/13] ahci_imx: Adjust for ahci_platform
 managing the clocks
Date: Sun, 19 Jan 2014 00:48:52 +0100
Message-ID: <1390088935-7193-11-git-send-email-hdegoede@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBB5G5SLAKGQEXKNLN5A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1390088935-7193-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

ahci_platform manages all 3 clocks now, so enabling / disabling them from
ahci_imx just results in the sata_ref clock getting enabled / disabled twice.

Note untested, I've ordered a wandboard to be able to test these changes.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 .../devicetree/bindings/ata/ahci-platform.txt      |  8 ++-
 drivers/ata/ahci_imx.c                             | 82 +++++++++-------------
 2 files changed, 40 insertions(+), 50 deletions(-)

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
index 0051f29..8eb24a3 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -34,12 +34,15 @@ enum {
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
-	bool no_device;
 	bool first_time;
 };
 
@@ -55,6 +58,7 @@ static void ahci_imx_error_handler(struct ata_port *ap)
 	struct ahci_host_priv *hpriv = host->private_data;
 	void __iomem *mmio = hpriv->mmio;
 	struct imx_ahci_priv *imxpriv = dev_get_drvdata(ap->dev->parent);
+	int i;
 
 	ahci_error_handler(ap);
 
@@ -75,8 +79,13 @@ static void ahci_imx_error_handler(struct ata_port *ap)
 	regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
 			IMX6Q_GPR13_SATA_MPLL_CLK_EN,
 			!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
-	clk_disable_unprepare(imxpriv->sata_ref_clk);
-	imxpriv->no_device = true;
+
+	for (i = CLK_AHB; i >= 0; i--) {
+		clk_disable_unprepare(hpriv->clks[i]);
+		/* Stop ahci_platform.c from trying to use the clks */
+		clk_put(hpriv->clks[i]);
+		hpriv->clks[i] = NULL;
+	}
 }
 
 static struct ata_port_operations ahci_imx_ops = {
@@ -94,7 +103,6 @@ static const struct ata_port_info ahci_imx_port_info = {
 static int imx6q_sata_init(struct device *dev, struct ahci_host_priv *hpriv,
 			   void __iomem *mmio)
 {
-	int ret = 0;
 	unsigned int reg_val;
 	struct imx_ahci_priv *imxpriv = dev_get_drvdata(dev->parent);
 
@@ -105,12 +113,6 @@ static int imx6q_sata_init(struct device *dev, struct ahci_host_priv *hpriv,
 		return PTR_ERR(imxpriv->gpr);
 	}
 
-	ret = clk_prepare_enable(imxpriv->sata_ref_clk);
-	if (ret < 0) {
-		dev_err(dev, "prepare-enable sata_ref clock err:%d\n", ret);
-		return ret;
-	}
-
 	/*
 	 * set PHY Paremeters, two steps to configure the GPR13,
 	 * one write for rest of parameters, mask of first write
@@ -157,7 +159,11 @@ static int imx6q_sata_init(struct device *dev, struct ahci_host_priv *hpriv,
 		writel(reg_val, mmio + HOST_PORTS_IMPL);
 	}
 
-	reg_val = clk_get_rate(imxpriv->ahb_clk) / 1000;
+	if (!hpriv->clks[CLK_AHB]) {
+		dev_err(dev, "no ahb clk, need sata, sata_ref and ahb clks\n");
+		return -ENOENT;
+	}
+	reg_val = clk_get_rate(hpriv->clks[CLK_AHB]) / 1000;
 	writel(reg_val, mmio + HOST_TIMER1MS);
 
 	return 0;
@@ -165,41 +171,36 @@ static int imx6q_sata_init(struct device *dev, struct ahci_host_priv *hpriv,
 
 static void imx6q_sata_exit(struct device *dev)
 {
-	struct imx_ahci_priv *imxpriv =  dev_get_drvdata(dev->parent);
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
+	struct imx_ahci_priv *imxpriv = dev_get_drvdata(dev->parent);
 
-	regmap_update_bits(imxpriv->gpr, 0x34, IMX6Q_GPR13_SATA_MPLL_CLK_EN,
+	if (hpriv->clks[CLK_SATA])
+		regmap_update_bits(imxpriv->gpr, 0x34,
+			IMX6Q_GPR13_SATA_MPLL_CLK_EN,
 			!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
-	clk_disable_unprepare(imxpriv->sata_ref_clk);
 }
 
 static void imx_ahci_suspend(struct device *dev)
 {
-	struct imx_ahci_priv *imxpriv =  dev_get_drvdata(dev->parent);
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
+	struct imx_ahci_priv *imxpriv = dev_get_drvdata(dev->parent);
 
-	/*
-	 * If no_device is set, The CLKs had been gated off in the
-	 * initialization so don't do it again here.
-	 */
-	if (!imxpriv->no_device) {
+	/* Check the CLKs have not been gated off in the initialization. */
+	if (hpriv->clks[CLK_SATA])
 		regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
 				IMX6Q_GPR13_SATA_MPLL_CLK_EN,
 				!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
-		clk_disable_unprepare(imxpriv->sata_ref_clk);
-	}
 }
 
 static int imx_ahci_resume(struct device *dev)
 {
-	struct imx_ahci_priv *imxpriv =  dev_get_drvdata(dev->parent);
-	int ret;
-
-	if (!imxpriv->no_device) {
-		ret = clk_prepare_enable(imxpriv->sata_ref_clk);
-		if (ret < 0) {
-			dev_err(dev, "pre-enable sata_ref clock err:%d\n", ret);
-			return ret;
-		}
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
+	struct imx_ahci_priv *imxpriv = dev_get_drvdata(dev->parent);
 
+	if (hpriv->clks[CLK_SATA]) {
 		regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
 				IMX6Q_GPR13_SATA_MPLL_CLK_EN,
 				IMX6Q_GPR13_SATA_MPLL_CLK_EN);
@@ -247,22 +248,7 @@ static int imx_ahci_probe(struct platform_device *pdev)
 	ahci_dev = &ahci_pdev->dev;
 	ahci_dev->parent = dev;
 
-	imxpriv->no_device = false;
 	imxpriv->first_time = true;
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
 	imxpriv->ahci_pdev = ahci_pdev;
 	platform_set_drvdata(pdev, imxpriv);
 
-- 
1.8.4.2
