From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: [PATCH 2/5] Phy: Add a PHY driver for Marvell MVEBU SATA PHY.
Date: Wed,  4 Dec 2013 18:16:01 +0100
Message-ID: <1386177364-10164-3-git-send-email-andrew@lunn.ch>
References: <1386177364-10164-1-git-send-email-andrew@lunn.ch>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1386177364-10164-1-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, kishon-l0cyMroinI0@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Kirkwood and Dove can turn the SATA phy on and off. Add a PHY driver
to control this.

Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
---
 drivers/phy/Kconfig          |   5 ++
 drivers/phy/Makefile         |   1 +
 drivers/phy/phy-mvebu-sata.c | 130 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 136 insertions(+)
 create mode 100644 drivers/phy/phy-mvebu-sata.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index a344f3d52361..2dd97c3bdab7 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -21,6 +21,11 @@ config PHY_EXYNOS_MIPI_VIDEO
 	  Support for MIPI CSI-2 and MIPI DSI DPHY found on Samsung S5P
 	  and EXYNOS SoCs.
 
+config PHY_MVEBU_SATA
+       def_bool y
+       depends on ARCH_KIRKWOOD || ARCH_DOVE
+       depends on OF
+
 config OMAP_USB2
 	tristate "OMAP USB2 PHY Driver"
 	depends on ARCH_OMAP2PLUS
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index d0caae9cfb83..4e4adc96f753 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -5,5 +5,6 @@
 obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
 obj-$(CONFIG_PHY_EXYNOS_DP_VIDEO)	+= phy-exynos-dp-video.o
 obj-$(CONFIG_PHY_EXYNOS_MIPI_VIDEO)	+= phy-exynos-mipi-video.o
+obj-$(CONFIG_PHY_MVEBU_SATA)		+= phy-mvebu-sata.o
 obj-$(CONFIG_OMAP_USB2)			+= phy-omap-usb2.o
 obj-$(CONFIG_TWL4030_USB)		+= phy-twl4030-usb.o
diff --git a/drivers/phy/phy-mvebu-sata.c b/drivers/phy/phy-mvebu-sata.c
new file mode 100644
index 000000000000..7d40c3afb090
--- /dev/null
+++ b/drivers/phy/phy-mvebu-sata.c
@@ -0,0 +1,130 @@
+/*
+ *	phy-mvebu-sata.c: SATA Phy driver for the Marvell mvebu SoCs.
+ *
+ *	Copyright (C) 2013 Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/phy/phy.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+
+struct priv {
+	struct clk	*clk;
+	void __iomem	*base;
+};
+
+#define SATA_PHY_MODE_2	0x0330
+#define SATA_IF_CTRL	0x0050
+
+static int phy_mvebu_sata_power_on(struct phy *phy)
+{
+	struct priv *priv = phy_get_drvdata(phy);
+	u32 reg;
+
+	clk_prepare_enable(priv->clk);
+
+	/* Enable PLL and IVREF */
+	reg = readl(priv->base + SATA_PHY_MODE_2);
+	reg |= 0xf;
+	writel(reg , priv->base + SATA_PHY_MODE_2);
+
+	/* Enable PHY */
+	reg = readl(priv->base + SATA_IF_CTRL);
+	reg &= ~0x200;
+	writel(reg, priv->base + SATA_IF_CTRL);
+
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static int phy_mvebu_sata_power_off(struct phy *phy)
+{
+	struct priv *priv = phy_get_drvdata(phy);
+	u32 reg;
+
+	clk_prepare_enable(priv->clk);
+
+	/* Disable PLL and IVREF */
+	reg = readl(priv->base + SATA_PHY_MODE_2);
+	reg &= ~0xf;
+	writel(reg, priv->base + SATA_PHY_MODE_2);
+
+	/* Disable PHY */
+	reg = readl(priv->base + SATA_IF_CTRL);
+	reg |= 0x200;
+	writel(reg, priv->base + SATA_IF_CTRL);
+
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static struct phy_ops phy_mvebu_sata_ops = {
+	.power_on	= phy_mvebu_sata_power_on,
+	.power_off	= phy_mvebu_sata_power_off,
+	.owner		= THIS_MODULE,
+};
+
+static int phy_mvebu_sata_probe(struct platform_device *pdev)
+{
+	struct phy_provider *phy_provider;
+	struct resource *res;
+	struct priv *priv;
+	struct phy *phy;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->clk = devm_clk_get(&pdev->dev, "sata");
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
+	phy_provider = devm_of_phy_provider_register(&pdev->dev,
+						     of_phy_simple_xlate);
+	if (IS_ERR(phy_provider))
+		return PTR_ERR(phy_provider);
+
+	phy = devm_phy_create(&pdev->dev, &phy_mvebu_sata_ops, NULL);
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
+
+	phy_set_drvdata(phy, priv);
+
+	/* The boot loader may of left it on. Turn it off. */
+	phy_mvebu_sata_power_off(phy);
+
+	return 0;
+}
+
+static const struct of_device_id phy_mvebu_sata_of_match[] = {
+	{ .compatible = "marvell,mvebu-sata-phy" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, phy_mvebu_sata_of_match);
+
+static struct platform_driver phy_mvebu_sata_driver = {
+	.probe	= phy_mvebu_sata_probe,
+	.driver = {
+		.name	= "phy-mvebu-sata",
+		.owner	= THIS_MODULE,
+		.of_match_table	= phy_mvebu_sata_of_match,
+	}
+};
+module_platform_driver(phy_mvebu_sata_driver);
+
+MODULE_AUTHOR("Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>");
+MODULE_DESCRIPTION("Marvell MVEBU SATA PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
1.8.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
