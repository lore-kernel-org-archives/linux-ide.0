From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v4 2/4] Phy: Add a PHY driver for Marvell MVEBU SATA
 PHY.
Date: Fri, 10 Jan 2014 14:31:30 -0500
Message-ID: <20140110193130.GS19878@titan.lakedaemon.net>
References: <20131219194237.GC22725@htj.dyndns.org>
 <1388078742-6726-1-git-send-email-andrew@lunn.ch>
 <1388078742-6726-3-git-send-email-andrew@lunn.ch>
 <52BDABD2.9080701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:32214 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbaAJTbf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Jan 2014 14:31:35 -0500
Content-Disposition: inline
In-Reply-To: <52BDABD2.9080701@ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>, tj@kernel.org, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>

On Fri, Dec 27, 2013 at 10:03:22PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Thursday 26 December 2013 10:55 PM, Andrew Lunn wrote:
> >Kirkwood and Dove can turn the SATA phy on and off. Add a PHY driver
> >to control this.
> >
> >Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> >---
> >v1->v2:
> >Use #defines instead of magic values
> >select GENERIC_PHY in Kconfig.
> >
> >v3->v4
> >
> >Register phy_provider as the last step.
> 
> The previous version is already sent to be merged. We can have the
> new change merged in the rc cycle.

Kishon,

Looking at the patch dependencies, we'd like to keep the sata change in
the same branch as the phy changes.  Would you mind picking that one up
and placing it in the same branch as the ones you already took?  I have
the DT changes, as they don't cause problems out on their own.

Tijon,

If you're ok with this, would you mind Acking the sata patch for Kishon?

thx,

Jason.

> >---
> >  drivers/phy/Kconfig          |    6 ++
> >  drivers/phy/Makefile         |    1 +
> >  drivers/phy/phy-mvebu-sata.c |  137 ++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 144 insertions(+)
> >  create mode 100644 drivers/phy/phy-mvebu-sata.c
> >
> >diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> >index a344f3d..7464d31 100644
> >--- a/drivers/phy/Kconfig
> >+++ b/drivers/phy/Kconfig
> >@@ -21,6 +21,12 @@ config PHY_EXYNOS_MIPI_VIDEO
> >  	  Support for MIPI CSI-2 and MIPI DSI DPHY found on Samsung S5P
> >  	  and EXYNOS SoCs.
> >
> >+config PHY_MVEBU_SATA
> >+	def_bool y
> >+	depends on ARCH_KIRKWOOD || ARCH_DOVE
> >+	depends on OF
> >+	select GENERIC_PHY
> >+
> >  config OMAP_USB2
> >  	tristate "OMAP USB2 PHY Driver"
> >  	depends on ARCH_OMAP2PLUS
> >diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> >index d0caae9..4e4adc9 100644
> >--- a/drivers/phy/Makefile
> >+++ b/drivers/phy/Makefile
> >@@ -5,5 +5,6 @@
> >  obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
> >  obj-$(CONFIG_PHY_EXYNOS_DP_VIDEO)	+= phy-exynos-dp-video.o
> >  obj-$(CONFIG_PHY_EXYNOS_MIPI_VIDEO)	+= phy-exynos-mipi-video.o
> >+obj-$(CONFIG_PHY_MVEBU_SATA)		+= phy-mvebu-sata.o
> >  obj-$(CONFIG_OMAP_USB2)			+= phy-omap-usb2.o
> >  obj-$(CONFIG_TWL4030_USB)		+= phy-twl4030-usb.o
> >diff --git a/drivers/phy/phy-mvebu-sata.c b/drivers/phy/phy-mvebu-sata.c
> >new file mode 100644
> >index 0000000..d70ecd6
> >--- /dev/null
> >+++ b/drivers/phy/phy-mvebu-sata.c
> >@@ -0,0 +1,137 @@
> >+/*
> >+ *	phy-mvebu-sata.c: SATA Phy driver for the Marvell mvebu SoCs.
> >+ *
> >+ *	Copyright (C) 2013 Andrew Lunn <andrew@lunn.ch>
> >+ *
> >+ *	This program is free software; you can redistribute it and/or
> >+ *	modify it under the terms of the GNU General Public License
> >+ *	as published by the Free Software Foundation; either version
> >+ *	2 of the License, or (at your option) any later version.
> >+ */
> >+
> >+#include <linux/kernel.h>
> >+#include <linux/module.h>
> >+#include <linux/clk.h>
> >+#include <linux/phy/phy.h>
> >+#include <linux/io.h>
> >+#include <linux/platform_device.h>
> >+
> >+struct priv {
> >+	struct clk	*clk;
> >+	void __iomem	*base;
> >+};
> >+
> >+#define SATA_PHY_MODE_2	0x0330
> >+#define  MODE_2_FORCE_PU_TX	BIT(0)
> >+#define  MODE_2_FORCE_PU_RX	BIT(1)
> >+#define  MODE_2_PU_PLL		BIT(2)
> >+#define  MODE_2_PU_IVREF	BIT(3)
> >+#define SATA_IF_CTRL	0x0050
> >+#define  CTRL_PHY_SHUTDOWN	BIT(9)
> >+
> >+static int phy_mvebu_sata_power_on(struct phy *phy)
> >+{
> >+	struct priv *priv = phy_get_drvdata(phy);
> >+	u32 reg;
> >+
> >+	clk_prepare_enable(priv->clk);
> >+
> >+	/* Enable PLL and IVREF */
> >+	reg = readl(priv->base + SATA_PHY_MODE_2);
> >+	reg |= (MODE_2_FORCE_PU_TX | MODE_2_FORCE_PU_RX |
> >+		MODE_2_PU_PLL | MODE_2_PU_IVREF);
> >+	writel(reg , priv->base + SATA_PHY_MODE_2);
> >+
> >+	/* Enable PHY */
> >+	reg = readl(priv->base + SATA_IF_CTRL);
> >+	reg &= ~CTRL_PHY_SHUTDOWN;
> >+	writel(reg, priv->base + SATA_IF_CTRL);
> >+
> >+	clk_disable_unprepare(priv->clk);
> >+
> >+	return 0;
> >+}
> >+
> >+static int phy_mvebu_sata_power_off(struct phy *phy)
> >+{
> >+	struct priv *priv = phy_get_drvdata(phy);
> >+	u32 reg;
> >+
> >+	clk_prepare_enable(priv->clk);
> >+
> >+	/* Disable PLL and IVREF */
> >+	reg = readl(priv->base + SATA_PHY_MODE_2);
> >+	reg &= ~(MODE_2_FORCE_PU_TX | MODE_2_FORCE_PU_RX |
> >+		 MODE_2_PU_PLL | MODE_2_PU_IVREF);
> >+	writel(reg, priv->base + SATA_PHY_MODE_2);
> >+
> >+	/* Disable PHY */
> >+	reg = readl(priv->base + SATA_IF_CTRL);
> >+	reg |= CTRL_PHY_SHUTDOWN;
> >+	writel(reg, priv->base + SATA_IF_CTRL);
> >+
> >+	clk_disable_unprepare(priv->clk);
> >+
> >+	return 0;
> >+}
> >+
> >+static struct phy_ops phy_mvebu_sata_ops = {
> >+	.power_on	= phy_mvebu_sata_power_on,
> >+	.power_off	= phy_mvebu_sata_power_off,
> >+	.owner		= THIS_MODULE,
> >+};
> >+
> >+static int phy_mvebu_sata_probe(struct platform_device *pdev)
> >+{
> >+	struct phy_provider *phy_provider;
> >+	struct resource *res;
> >+	struct priv *priv;
> >+	struct phy *phy;
> >+
> >+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> >+
> >+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >+	priv->base = devm_ioremap_resource(&pdev->dev, res);
> >+	if (IS_ERR(priv->base))
> >+		return PTR_ERR(priv->base);
> >+
> >+	priv->clk = devm_clk_get(&pdev->dev, "sata");
> >+	if (IS_ERR(priv->clk))
> >+		return PTR_ERR(priv->clk);
> >+
> >+	phy = devm_phy_create(&pdev->dev, &phy_mvebu_sata_ops, NULL);
> >+	if (IS_ERR(phy))
> >+		return PTR_ERR(phy);
> >+
> >+	phy_set_drvdata(phy, priv);
> >+
> >+	phy_provider = devm_of_phy_provider_register(&pdev->dev,
> >+						     of_phy_simple_xlate);
> >+	if (IS_ERR(phy_provider))
> >+		return PTR_ERR(phy_provider);
> >+
> >+	/* The boot loader may of left it on. Turn it off. */
> >+	phy_mvebu_sata_power_off(phy);
> >+
> >+	return 0;
> >+}
> >+
> >+static const struct of_device_id phy_mvebu_sata_of_match[] = {
> >+	{ .compatible = "marvell,mvebu-sata-phy" },
> >+	{ },
> >+};
> >+MODULE_DEVICE_TABLE(of, phy_mvebu_sata_of_match);
> >+
> >+static struct platform_driver phy_mvebu_sata_driver = {
> >+	.probe	= phy_mvebu_sata_probe,
> >+	.driver = {
> >+		.name	= "phy-mvebu-sata",
> >+		.owner	= THIS_MODULE,
> >+		.of_match_table	= phy_mvebu_sata_of_match,
> >+	}
> >+};
> >+module_platform_driver(phy_mvebu_sata_driver);
> >+
> >+MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch>");
> >+MODULE_DESCRIPTION("Marvell MVEBU SATA PHY driver");
> >+MODULE_LICENSE("GPL v2");
> >
> 
