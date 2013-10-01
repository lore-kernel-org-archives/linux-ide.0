From: Yuvaraj Kumar C D <yuvaraj.cd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/3] ahci: exynos: add ahci sata support on Exynos platform
Date: Tue,  1 Oct 2013 12:03:01 +0530
Message-ID: <1380609183-21430-2-git-send-email-yuvaraj.cd@samsung.com>
References: <1380609183-21430-1-git-send-email-yuvaraj.cd@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380609183-21430-1-git-send-email-yuvaraj.cd-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
Cc: s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, ks.giri-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, aditya.ps-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Yuvaraj Kumar C D <yuvaraj.cd-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Exynos5250 contains one Synopsys AHCI SATA controller.The avalaible
ahci_platform driver is not sufficient to handle the AHCI PHY and PHY
clock related initialization.

This patch adds exynos specific ahci sata driver,contained the exynos
specific initialized codes, re-use the generic ahci_platform driver, and
keep the generic ahci_platform driver clean as much as possible.

This patch depends on the below patch
	[1].drivers: phy: add generic PHY framework
		by Kishon Vijay Abraham I<kishon-l0cyMroinI0@public.gmane.org>

Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/ata/Kconfig       |    9 ++
 drivers/ata/Makefile      |    1 +
 drivers/ata/ahci_exynos.c |  226 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 236 insertions(+)
 create mode 100644 drivers/ata/ahci_exynos.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 4e73772..99b2392 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -106,6 +106,15 @@ config AHCI_IMX
 
 	  If unsure, say N.
 
+config AHCI_EXYNOS
+	tristate "Samsung Exynos AHCI SATA support"
+	depends on SATA_AHCI_PLATFORM
+	help
+	  This option enables support for the Samsung's Exynos SoC's
+	  onboard AHCI SATA.
+
+	  If unsure, say N.
+
 config SATA_FSL
 	tristate "Freescale 3.0Gbps SATA support"
 	depends on FSL_SOC
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 46518c6..0e1f420f 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
 obj-$(CONFIG_SATA_DWC)		+= sata_dwc_460ex.o
 obj-$(CONFIG_SATA_HIGHBANK)	+= sata_highbank.o libahci.o
 obj-$(CONFIG_AHCI_IMX)		+= ahci_imx.o
+obj-$(CONFIG_AHCI_EXYNOS)	+= ahci_exynos.o
 
 # SFF w/ custom DMA
 obj-$(CONFIG_PDC_ADMA)		+= pdc_adma.o
diff --git a/drivers/ata/ahci_exynos.c b/drivers/ata/ahci_exynos.c
new file mode 100644
index 0000000..7f0af00
--- /dev/null
+++ b/drivers/ata/ahci_exynos.c
@@ -0,0 +1,226 @@
+/*
+ * Samsung AHCI SATA platform driver
+ * Copyright 2013 Samsung Electronics Co., Ltd.
+ *
+ * based on the AHCI SATA platform driver by Jeff Garzik and Anton Vorontsov
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+#include <linux/io.h>
+#include <linux/ahci_platform.h>
+#include <linux/of_device.h>
+#include <linux/phy/phy.h>
+#include "ahci.h"
+
+#define MHZ             (1000 * 1000)
+
+struct exynos_ahci_priv {
+	struct platform_device *ahci_pdev;
+	struct clk *sclk;
+	unsigned int freq;
+	struct phy *phy;
+};
+
+static int exynos_sata_init(struct device *dev, void __iomem *mmio)
+{
+	struct exynos_ahci_priv *priv = dev_get_drvdata(dev->parent);
+	int ret;
+
+	priv->phy = devm_phy_get(dev , "sata-phy");
+	if (IS_ERR(priv->phy))
+		return PTR_ERR(priv->phy);
+
+	ret = phy_init(priv->phy);
+	if (ret < 0) {
+			dev_err(dev, "failed to init SATA PHY\n");
+			return ret;
+	}
+
+	ret = clk_prepare_enable(priv->sclk);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable source clk\n");
+		return ret;
+	}
+
+	ret = clk_set_rate(priv->sclk, priv->freq * MHZ);
+	if (ret < 0) {
+		dev_err(dev, "failed to set clk frequency\n");
+		clk_disable_unprepare(priv->sclk);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void exynos_sata_exit(struct device *dev)
+{
+	struct exynos_ahci_priv *priv = dev_get_drvdata(dev->parent);
+	if (!IS_ERR(priv->sclk))
+		clk_disable_unprepare(priv->sclk);
+}
+
+static int exynos_sata_suspend(struct device *dev)
+{
+	struct exynos_ahci_priv *priv = dev_get_drvdata(dev->parent);
+
+	if (!IS_ERR(priv->sclk))
+		clk_disable_unprepare(priv->sclk);
+	phy_power_off(priv->phy);
+	return 0;
+}
+
+static int exynos_sata_resume(struct device *dev)
+{
+	struct exynos_ahci_priv *priv = dev_get_drvdata(dev->parent);
+	phy_power_on(priv->phy);
+	exynos_sata_init(dev, NULL);
+	return 0;
+}
+
+static struct ahci_platform_data exynos_sata_pdata = {
+	.init = exynos_sata_init,
+	.exit = exynos_sata_exit,
+	.suspend = exynos_sata_suspend,
+	.resume = exynos_sata_resume,
+};
+
+static const struct of_device_id exynos_ahci_of_match[] = {
+	{ .compatible = "samsung,exynos5250-sata-ahci",
+		.data = &exynos_sata_pdata},
+	{},
+};
+MODULE_DEVICE_TABLE(of, exynos_ahci_of_match);
+
+static int exynos_sata_parse_dt(struct device_node *np,
+				struct exynos_ahci_priv *priv)
+{
+	if (!np)
+		return -EINVAL;
+	return of_property_read_u32(np, "samsung,sata-freq",
+						&priv->freq);
+}
+
+static int exynos_ahci_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *mem, *irq, res[2];
+	const struct of_device_id *of_id;
+	const struct ahci_platform_data *pdata = NULL;
+	struct exynos_ahci_priv *priv;
+	struct device *ahci_dev;
+	struct platform_device *ahci_pdev;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		dev_err(dev, "can't alloc ahci_host_priv\n");
+		return -ENOMEM;
+	}
+
+	ahci_pdev = platform_device_alloc("ahci", -1);
+	if (!ahci_pdev)
+		return -ENODEV;
+
+	ahci_dev = &ahci_pdev->dev;
+	ahci_dev->parent = dev;
+
+	ret = exynos_sata_parse_dt(dev->of_node, priv);
+	if (ret < 0) {
+			dev_err(dev, "failed to parse device tree\n");
+			goto err_out;
+	}
+
+	priv->sclk = devm_clk_get(dev, "sclk_sata");
+	if (IS_ERR(priv->sclk)) {
+		dev_err(dev, "failed to get sclk_sata\n");
+		ret = PTR_ERR(priv->sclk);
+		goto err_out;
+	}
+	priv->ahci_pdev = ahci_pdev;
+	platform_set_drvdata(pdev, priv);
+
+	of_id = of_match_device(exynos_ahci_of_match, dev);
+	if (of_id) {
+		pdata = of_id->data;
+	} else {
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!mem || !irq) {
+		dev_err(dev, "no mmio/irq resource\n");
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	res[0] = *mem;
+	res[1] = *irq;
+
+	ahci_dev->coherent_dma_mask = DMA_BIT_MASK(32);
+	ahci_dev->dma_mask = &ahci_dev->coherent_dma_mask;
+	ahci_dev->of_node = dev->of_node;
+
+	ret = platform_device_add_resources(ahci_pdev, res, 2);
+	if (ret)
+		goto err_out;
+
+	ret = platform_device_add_data(ahci_pdev, pdata, sizeof(*pdata));
+	if (ret)
+		goto err_out;
+
+	ret = platform_device_add(ahci_pdev);
+	if (ret) {
+
+
+err_out:
+		platform_set_drvdata(pdev, NULL);
+		platform_device_put(ahci_pdev);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int exynos_ahci_remove(struct platform_device *pdev)
+{
+	struct exynos_ahci_priv *priv = platform_get_drvdata(pdev);
+	struct platform_device *ahci_pdev = priv->ahci_pdev;
+
+	platform_device_unregister(ahci_pdev);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver exynos_ahci_driver = {
+	.probe = exynos_ahci_probe,
+	.remove = exynos_ahci_remove,
+	.driver = {
+		.name = "sata-exynos",
+		.owner = THIS_MODULE,
+		.of_match_table = exynos_ahci_of_match,
+	},
+};
+module_platform_driver(exynos_ahci_driver);
+
+MODULE_DESCRIPTION("Samsung Exynos AHCI SATA platform driver");
+MODULE_AUTHOR("Yuvaraj C D <yuvaraj.cd-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("ahci:exynos");
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
