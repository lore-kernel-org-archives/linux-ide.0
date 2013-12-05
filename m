From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 2/5] Phy: Add a PHY driver for Marvell MVEBU SATA PHY.
Date: Thu, 5 Dec 2013 11:40:29 +0530
Message-ID: <52A018D5.6080604@ti.com>
References: <1386177364-10164-1-git-send-email-andrew@lunn.ch> <1386177364-10164-3-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42688 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298Ab3LEGKo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Dec 2013 01:10:44 -0500
In-Reply-To: <1386177364-10164-3-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>
Cc: devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>

Hi,

On Wednesday 04 December 2013 10:46 PM, Andrew Lunn wrote:
> Kirkwood and Dove can turn the SATA phy on and off. Add a PHY driver
> to control this.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/phy/Kconfig          |   5 ++
>  drivers/phy/Makefile         |   1 +
>  drivers/phy/phy-mvebu-sata.c | 130 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 136 insertions(+)
>  create mode 100644 drivers/phy/phy-mvebu-sata.c
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index a344f3d52361..2dd97c3bdab7 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -21,6 +21,11 @@ config PHY_EXYNOS_MIPI_VIDEO
>  	  Support for MIPI CSI-2 and MIPI DSI DPHY found on Samsung S5P
>  	  and EXYNOS SoCs.
>  
> +config PHY_MVEBU_SATA
> +       def_bool y
> +       depends on ARCH_KIRKWOOD || ARCH_DOVE
> +       depends on OF

select GENERIC_PHY?
> +
>  config OMAP_USB2
>  	tristate "OMAP USB2 PHY Driver"
>  	depends on ARCH_OMAP2PLUS
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index d0caae9cfb83..4e4adc96f753 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -5,5 +5,6 @@
>  obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
>  obj-$(CONFIG_PHY_EXYNOS_DP_VIDEO)	+= phy-exynos-dp-video.o
>  obj-$(CONFIG_PHY_EXYNOS_MIPI_VIDEO)	+= phy-exynos-mipi-video.o
> +obj-$(CONFIG_PHY_MVEBU_SATA)		+= phy-mvebu-sata.o
>  obj-$(CONFIG_OMAP_USB2)			+= phy-omap-usb2.o
>  obj-$(CONFIG_TWL4030_USB)		+= phy-twl4030-usb.o
> diff --git a/drivers/phy/phy-mvebu-sata.c b/drivers/phy/phy-mvebu-sata.c
> new file mode 100644
> index 000000000000..7d40c3afb090
> --- /dev/null
> +++ b/drivers/phy/phy-mvebu-sata.c
> @@ -0,0 +1,130 @@
> +/*
> + *	phy-mvebu-sata.c: SATA Phy driver for the Marvell mvebu SoCs.
> + *
> + *	Copyright (C) 2013 Andrew Lunn <andrew@lunn.ch>
> + *
> + *	This program is free software; you can redistribute it and/or
> + *	modify it under the terms of the GNU General Public License
> + *	as published by the Free Software Foundation; either version
> + *	2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/clk.h>
> +#include <linux/phy/phy.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +
> +struct priv {
> +	struct clk	*clk;
> +	void __iomem	*base;
> +};
> +
> +#define SATA_PHY_MODE_2	0x0330
> +#define SATA_IF_CTRL	0x0050
> +
> +static int phy_mvebu_sata_power_on(struct phy *phy)
> +{
> +	struct priv *priv = phy_get_drvdata(phy);
> +	u32 reg;
> +
> +	clk_prepare_enable(priv->clk);
> +
> +	/* Enable PLL and IVREF */
> +	reg = readl(priv->base + SATA_PHY_MODE_2);
> +	reg |= 0xf;

No magic values here. Please add macros for these.
> +	writel(reg , priv->base + SATA_PHY_MODE_2);
> +
> +	/* Enable PHY */
> +	reg = readl(priv->base + SATA_IF_CTRL);
> +	reg &= ~0x200;

same here.
> +	writel(reg, priv->base + SATA_IF_CTRL);

It would be nice to add mvebu_readl and mvebu_writel apis. No strong feelings
though.
> +
> +	clk_disable_unprepare(priv->clk);
> +
> +	return 0;
> +}
> +
> +static int phy_mvebu_sata_power_off(struct phy *phy)
> +{
> +	struct priv *priv = phy_get_drvdata(phy);
> +	u32 reg;
> +
> +	clk_prepare_enable(priv->clk);
> +
> +	/* Disable PLL and IVREF */
> +	reg = readl(priv->base + SATA_PHY_MODE_2);
> +	reg &= ~0xf;

no magic values.
> +	writel(reg, priv->base + SATA_PHY_MODE_2);
> +
> +	/* Disable PHY */
> +	reg = readl(priv->base + SATA_IF_CTRL);
> +	reg |= 0x200;

same here.
> +	writel(reg, priv->base + SATA_IF_CTRL);
> +
> +	clk_disable_unprepare(priv->clk);
> +
> +	return 0;
> +}
> +
> +static struct phy_ops phy_mvebu_sata_ops = {
> +	.power_on	= phy_mvebu_sata_power_on,
> +	.power_off	= phy_mvebu_sata_power_off,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int phy_mvebu_sata_probe(struct platform_device *pdev)
> +{
> +	struct phy_provider *phy_provider;
> +	struct resource *res;
> +	struct priv *priv;
> +	struct phy *phy;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->clk = devm_clk_get(&pdev->dev, "sata");
> +	if (IS_ERR(priv->clk))
> +		return PTR_ERR(priv->clk);
> +
> +	phy_provider = devm_of_phy_provider_register(&pdev->dev,
> +						     of_phy_simple_xlate);

heh.. so your PHY implements a sinlge PHY device onle. You need to have '0' as
phy-cells values in both Documentation and dt data.

Thanks
Kishon
