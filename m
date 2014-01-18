From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC v3 11/13] ahci-imx: Don't create a nested platform
 device from probe
Date: Sun, 19 Jan 2014 00:48:53 +0100
Message-ID: <1390088935-7193-12-git-send-email-hdegoede@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBCVG5SLAKGQE3LBQESI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

Instead only provide platform_data through of_device_id, like the ahci-sunxi
driver does.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/ata/Kconfig           |   4 +-
 drivers/ata/Makefile          |   3 +-
 drivers/ata/ahci_imx.c        | 118 ++++++------------------------------------
 drivers/ata/ahci_platform.c   |   3 ++
 include/linux/ahci_platform.h |   1 +
 5 files changed, 22 insertions(+), 107 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 5f6c11a..05523ad 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -98,11 +98,11 @@ config SATA_AHCI_PLATFORM
 	  If unsure, say N.
 
 config AHCI_IMX
-	tristate "Freescale i.MX AHCI SATA support"
+	bool "Freescale i.MX AHCI SATA support"
 	depends on SATA_AHCI_PLATFORM && MFD_SYSCON
 	help
 	  This option enables support for the Freescale i.MX SoC's
-	  onboard AHCI SATA.
+	  onboard AHCI SATA in the ahci_platform driver.
 
 	  If unsure, say N.
 
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 4d8778c..99f4715 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -10,9 +10,8 @@ obj-$(CONFIG_SATA_INIC162X)	+= sata_inic162x.o
 obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
 obj-$(CONFIG_SATA_DWC)		+= sata_dwc_460ex.o
 obj-$(CONFIG_SATA_HIGHBANK)	+= sata_highbank.o libahci.o
-obj-$(CONFIG_AHCI_IMX)		+= ahci_imx.o
 
-ahci_plat-objs := ahci_platform.o ahci_sunxi.o
+ahci_plat-objs := ahci_platform.o ahci_imx.o ahci_sunxi.o
 
 # SFF w/ custom DMA
 obj-$(CONFIG_PDC_ADMA)		+= pdc_adma.o
diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 8eb24a3..6e0178f 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -28,6 +28,8 @@
 #include <linux/libata.h>
 #include "ahci.h"
 
+#ifdef CONFIG_AHCI_IMX
+
 enum {
 	PORT_PHY_CTL = 0x178,			/* Port0 PHY Control */
 	PORT_PHY_CTL_PDDQ_LOC = 0x100000,	/* PORT_PHY_CTL bits */
@@ -57,7 +59,7 @@ static void ahci_imx_error_handler(struct ata_port *ap)
 	struct ata_host *host = dev_get_drvdata(ap->dev);
 	struct ahci_host_priv *hpriv = host->private_data;
 	void __iomem *mmio = hpriv->mmio;
-	struct imx_ahci_priv *imxpriv = dev_get_drvdata(ap->dev->parent);
+	struct imx_ahci_priv *imxpriv = hpriv->plat_data;
 	int i;
 
 	ahci_error_handler(ap);
@@ -104,8 +106,13 @@ static int imx6q_sata_init(struct device *dev, struct ahci_host_priv *hpriv,
 			   void __iomem *mmio)
 {
 	unsigned int reg_val;
-	struct imx_ahci_priv *imxpriv = dev_get_drvdata(dev->parent);
+	struct imx_ahci_priv *imxpriv;
+
+	imxpriv = devm_kzalloc(dev, sizeof(*imxpriv), GFP_KERNEL);
+	if (!imxpriv)
+		return -ENOMEM;
 
+	hpriv->plat_data = imxpriv;
 	imxpriv->gpr =
 		syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
 	if (IS_ERR(imxpriv->gpr)) {
@@ -173,7 +180,7 @@ static void imx6q_sata_exit(struct device *dev)
 {
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct ahci_host_priv *hpriv = host->private_data;
-	struct imx_ahci_priv *imxpriv = dev_get_drvdata(dev->parent);
+	struct imx_ahci_priv *imxpriv = hpriv->plat_data;
 
 	if (hpriv->clks[CLK_SATA])
 		regmap_update_bits(imxpriv->gpr, 0x34,
@@ -185,7 +192,7 @@ static void imx_ahci_suspend(struct device *dev)
 {
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct ahci_host_priv *hpriv = host->private_data;
-	struct imx_ahci_priv *imxpriv = dev_get_drvdata(dev->parent);
+	struct imx_ahci_priv *imxpriv = hpriv->plat_data;
 
 	/* Check the CLKs have not been gated off in the initialization. */
 	if (hpriv->clks[CLK_SATA])
@@ -198,7 +205,7 @@ static int imx_ahci_resume(struct device *dev)
 {
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct ahci_host_priv *hpriv = host->private_data;
-	struct imx_ahci_priv *imxpriv = dev_get_drvdata(dev->parent);
+	struct imx_ahci_priv *imxpriv = hpriv->plat_data;
 
 	if (hpriv->clks[CLK_SATA]) {
 		regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
@@ -210,7 +217,7 @@ static int imx_ahci_resume(struct device *dev)
 	return 0;
 }
 
-static struct ahci_platform_data imx6q_sata_pdata = {
+struct ahci_platform_data imx6q_sata_pdata = {
 	.init = imx6q_sata_init,
 	.exit = imx6q_sata_exit,
 	.ata_port_info = &ahci_imx_port_info,
@@ -218,102 +225,7 @@ static struct ahci_platform_data imx6q_sata_pdata = {
 	.resume = imx_ahci_resume,
 };
 
-static const struct of_device_id imx_ahci_of_match[] = {
-	{ .compatible = "fsl,imx6q-ahci", .data = &imx6q_sata_pdata},
-	{},
-};
-MODULE_DEVICE_TABLE(of, imx_ahci_of_match);
-
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
-	imxpriv->first_time = true;
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
-
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
-
-static struct platform_driver imx_ahci_driver = {
-	.probe = imx_ahci_probe,
-	.remove = imx_ahci_remove,
-	.driver = {
-		.name = "ahci-imx",
-		.owner = THIS_MODULE,
-		.of_match_table = imx_ahci_of_match,
-	},
-};
-module_platform_driver(imx_ahci_driver);
-
-MODULE_DESCRIPTION("Freescale i.MX AHCI SATA platform driver");
 MODULE_AUTHOR("Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>");
-MODULE_LICENSE("GPL");
 MODULE_ALIAS("ahci:imx");
+
+#endif
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 324d066..9022922 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -96,6 +96,9 @@ static const struct of_device_id ahci_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-ahci",
 	  .data = &ahci_sunxi_pdata, },
 #endif
+#ifdef CONFIG_AHCI_IMX
+	{ .compatible = "fsl,imx6q-ahci", .data = &imx6q_sata_pdata, },
+#endif
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_of_match);
diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
index 4e6cbe0..19623ad 100644
--- a/include/linux/ahci_platform.h
+++ b/include/linux/ahci_platform.h
@@ -33,5 +33,6 @@ struct ahci_platform_data {
 };
 
 extern struct ahci_platform_data ahci_sunxi_pdata;
+extern struct ahci_platform_data imx6q_sata_pdata;
 
 #endif /* _AHCI_PLATFORM_H */
-- 
1.8.4.2
