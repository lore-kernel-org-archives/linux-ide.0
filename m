From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v9 1/7] phy: add a driver for the Berlin SATA PHY
Date: Tue, 8 Jul 2014 17:59:13 +0530
Message-ID: <53BBE419.8080107@ti.com>
References: <1404728173-20263-1-git-send-email-antoine.tenart@free-electrons.com> <1404728173-20263-2-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1404728173-20263-2-git-send-email-antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?QW50b2luZSBUw6luYXJ0?= <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hi Antoine,

On Monday 07 July 2014 03:46 PM, Antoine T=C3=A9nart wrote:
> The Berlin SoC has a two SATA ports. Add a PHY driver to handle them.
>=20
> The mode selection can let us think this PHY can be configured to fit
> other purposes. But there are reasons to think the SATA mode will be
> the only one usable: the PHY registers are only accessible indirectly
> through two registers in the SATA range, the PHY seems to be integrat=
ed
> and no information tells us the contrary. For these reasons, make the
> driver a SATA PHY driver.

Thanks for doing multiple revisions of this. Looks good to be merged fo=
r me now.

Cheers
Kishon
>=20
> Signed-off-by: Antoine T=C3=A9nart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org=
>
> ---
>  drivers/phy/Kconfig           |   7 ++
>  drivers/phy/Makefile          |   1 +
>  drivers/phy/phy-berlin-sata.c | 284 ++++++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 292 insertions(+)
>  create mode 100644 drivers/phy/phy-berlin-sata.c
>=20
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 16a2f067c242..8ad5c341b8f9 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -15,6 +15,13 @@ config GENERIC_PHY
>  	  phy users can obtain reference to the PHY. All the users of this
>  	  framework should select this config.
> =20
> +config PHY_BERLIN_SATA
> +	tristate "Marvell Berlin SATA PHY driver"
> +	depends on ARCH_BERLIN && HAS_IOMEM && OF
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the SATA PHY on Marvell Berlin SoCs.
> +
>  config PHY_EXYNOS_MIPI_VIDEO
>  	tristate "S5P/EXYNOS SoC series MIPI CSI-2/DSI PHY driver"
>  	depends on HAS_IOMEM
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index b4f1d5770601..a137a2e23218 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -3,6 +3,7 @@
>  #
> =20
>  obj-$(CONFIG_GENERIC_PHY)		+=3D phy-core.o
> +obj-$(CONFIG_PHY_BERLIN_SATA)		+=3D phy-berlin-sata.o
>  obj-$(CONFIG_BCM_KONA_USB2_PHY)		+=3D phy-bcm-kona-usb2.o
>  obj-$(CONFIG_PHY_EXYNOS_DP_VIDEO)	+=3D phy-exynos-dp-video.o
>  obj-$(CONFIG_PHY_EXYNOS_MIPI_VIDEO)	+=3D phy-exynos-mipi-video.o
> diff --git a/drivers/phy/phy-berlin-sata.c b/drivers/phy/phy-berlin-s=
ata.c
> new file mode 100644
> index 000000000000..c5e688b0899f
> --- /dev/null
> +++ b/drivers/phy/phy-berlin-sata.c
> @@ -0,0 +1,284 @@
> +/*
> + * Marvell Berlin SATA PHY driver
> + *
> + * Copyright (C) 2014 Marvell Technology Group Ltd.
> + *
> + * Antoine T=C3=A9nart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/phy/phy.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +
> +#define HOST_VSA_ADDR		0x0
> +#define HOST_VSA_DATA		0x4
> +#define PORT_SCR_CTL		0x2c
> +#define PORT_VSR_ADDR		0x78
> +#define PORT_VSR_DATA		0x7c
> +
> +#define CONTROL_REGISTER	0x0
> +#define MBUS_SIZE_CONTROL	0x4
> +
> +#define POWER_DOWN_PHY0			BIT(6)
> +#define POWER_DOWN_PHY1			BIT(14)
> +#define MBUS_WRITE_REQUEST_SIZE_128	(BIT(2) << 16)
> +#define MBUS_READ_REQUEST_SIZE_128	(BIT(2) << 19)
> +
> +#define PHY_BASE		0x200
> +
> +/* register 0x01 */
> +#define REF_FREF_SEL_25		BIT(0)
> +#define PHY_MODE_SATA		(0x0 << 5)
> +
> +/* register 0x02 */
> +#define USE_MAX_PLL_RATE	BIT(12)
> +
> +/* register 0x23 */
> +#define DATA_BIT_WIDTH_10	(0x0 << 10)
> +#define DATA_BIT_WIDTH_20	(0x1 << 10)
> +#define DATA_BIT_WIDTH_40	(0x2 << 10)
> +
> +/* register 0x25 */
> +#define PHY_GEN_MAX_1_5		(0x0 << 10)
> +#define PHY_GEN_MAX_3_0		(0x1 << 10)
> +#define PHY_GEN_MAX_6_0		(0x2 << 10)
> +
> +struct phy_berlin_desc {
> +	struct phy	*phy;
> +	u32		power_bit;
> +	unsigned	index;
> +};
> +
> +struct phy_berlin_priv {
> +	void __iomem		*base;
> +	spinlock_t		lock;
> +	struct clk		*clk;
> +	struct phy_berlin_desc	**phys;
> +	unsigned		nphys;
> +};
> +
> +static inline void phy_berlin_sata_reg_setbits(void __iomem *ctrl_re=
g, u32 reg,
> +					       u32 mask, u32 val)
> +{
> +	u32 regval;
> +
> +	/* select register */
> +	writel(PHY_BASE + reg, ctrl_reg + PORT_VSR_ADDR);
> +
> +	/* set bits */
> +	regval =3D readl(ctrl_reg + PORT_VSR_DATA);
> +	regval &=3D ~mask;
> +	regval |=3D val;
> +	writel(regval, ctrl_reg + PORT_VSR_DATA);
> +}
> +
> +static int phy_berlin_sata_power_on(struct phy *phy)
> +{
> +	struct phy_berlin_desc *desc =3D phy_get_drvdata(phy);
> +	struct phy_berlin_priv *priv =3D dev_get_drvdata(phy->dev.parent);
> +	void __iomem *ctrl_reg =3D priv->base + 0x60 + (desc->index * 0x80)=
;
> +	int ret =3D 0;
> +	u32 regval;
> +
> +	clk_prepare_enable(priv->clk);
> +
> +	spin_lock(&priv->lock);
> +
> +	/* Power on PHY */
> +	writel(CONTROL_REGISTER, priv->base + HOST_VSA_ADDR);
> +	regval =3D readl(priv->base + HOST_VSA_DATA);
> +	regval &=3D ~desc->power_bit;
> +	writel(regval, priv->base + HOST_VSA_DATA);
> +
> +	/* Configure MBus */
> +	writel(MBUS_SIZE_CONTROL, priv->base + HOST_VSA_ADDR);
> +	regval =3D readl(priv->base + HOST_VSA_DATA);
> +	regval |=3D MBUS_WRITE_REQUEST_SIZE_128 | MBUS_READ_REQUEST_SIZE_12=
8;
> +	writel(regval, priv->base + HOST_VSA_DATA);
> +
> +	/* set PHY mode and ref freq to 25 MHz */
> +	phy_berlin_sata_reg_setbits(ctrl_reg, 0x1, 0xff,
> +				    REF_FREF_SEL_25 | PHY_MODE_SATA);
> +
> +	/* set PHY up to 6 Gbps */
> +	phy_berlin_sata_reg_setbits(ctrl_reg, 0x25, 0xc00, PHY_GEN_MAX_6_0)=
;
> +
> +	/* set 40 bits width */
> +	phy_berlin_sata_reg_setbits(ctrl_reg, 0x23,  0xc00, DATA_BIT_WIDTH_=
40);
> +
> +	/* use max pll rate */
> +	phy_berlin_sata_reg_setbits(ctrl_reg, 0x2, 0x0, USE_MAX_PLL_RATE);
> +
> +	/* set Gen3 controller speed */
> +	regval =3D readl(ctrl_reg + PORT_SCR_CTL);
> +	regval &=3D ~GENMASK(7, 4);
> +	regval |=3D 0x30;
> +	writel(regval, ctrl_reg + PORT_SCR_CTL);
> +
> +	spin_unlock(&priv->lock);
> +
> +	clk_disable_unprepare(priv->clk);
> +
> +	return ret;
> +}
> +
> +static int phy_berlin_sata_power_off(struct phy *phy)
> +{
> +	struct phy_berlin_desc *desc =3D phy_get_drvdata(phy);
> +	struct phy_berlin_priv *priv =3D dev_get_drvdata(phy->dev.parent);
> +	u32 regval;
> +
> +	clk_prepare_enable(priv->clk);
> +
> +	spin_lock(&priv->lock);
> +
> +	/* Power down PHY */
> +	writel(CONTROL_REGISTER, priv->base + HOST_VSA_ADDR);
> +	regval =3D readl(priv->base + HOST_VSA_DATA);
> +	regval |=3D desc->power_bit;
> +	writel(regval, priv->base + HOST_VSA_DATA);
> +
> +	spin_unlock(&priv->lock);
> +
> +	clk_disable_unprepare(priv->clk);
> +
> +	return 0;
> +}
> +
> +static struct phy *phy_berlin_sata_phy_xlate(struct device *dev,
> +					     struct of_phandle_args *args)
> +{
> +	struct phy_berlin_priv *priv =3D dev_get_drvdata(dev);
> +	int i;
> +
> +	if (WARN_ON(args->args[0] >=3D priv->nphys))
> +		return ERR_PTR(-ENODEV);
> +
> +	for (i =3D 0; i < priv->nphys; i++) {
> +		if (priv->phys[i]->index =3D=3D args->args[0])
> +			break;
> +	}
> +
> +	if (i =3D=3D priv->nphys)
> +		return ERR_PTR(-ENODEV);
> +
> +	return priv->phys[i]->phy;
> +}
> +
> +static struct phy_ops phy_berlin_sata_ops =3D {
> +	.power_on	=3D phy_berlin_sata_power_on,
> +	.power_off	=3D phy_berlin_sata_power_off,
> +	.owner		=3D THIS_MODULE,
> +};
> +
> +static u32 phy_berlin_power_down_bits[] =3D {
> +	POWER_DOWN_PHY0,
> +	POWER_DOWN_PHY1,
> +};
> +
> +static int phy_berlin_sata_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *child;
> +	struct phy *phy;
> +	struct phy_provider *phy_provider;
> +	struct phy_berlin_priv *priv;
> +	struct resource *res;
> +	int i =3D 0;
> +	u32 phy_id;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;
> +
> +	priv->base =3D devm_ioremap(dev, res->start, resource_size(res));
> +	if (!priv->base)
> +		return -ENOMEM;
> +
> +	priv->clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return PTR_ERR(priv->clk);
> +
> +	priv->nphys =3D of_get_child_count(dev->of_node);
> +	if (priv->nphys =3D=3D 0)
> +		return -ENODEV;
> +
> +	priv->phys =3D devm_kzalloc(dev, priv->nphys * sizeof(*priv->phys),
> +				  GFP_KERNEL);
> +	if (!priv->phys)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, priv);
> +	spin_lock_init(&priv->lock);
> +
> +	for_each_available_child_of_node(dev->of_node, child) {
> +		struct phy_berlin_desc *phy_desc;
> +
> +		if (of_property_read_u32(child, "reg", &phy_id)) {
> +			dev_err(dev, "missing reg property in node %s\n",
> +				child->name);
> +			return -EINVAL;
> +		}
> +
> +		if (phy_id >=3D ARRAY_SIZE(phy_berlin_power_down_bits)) {
> +			dev_err(dev, "invalid reg in node %s\n", child->name);
> +			return -EINVAL;
> +		}
> +
> +		phy_desc =3D devm_kzalloc(dev, sizeof(*phy_desc), GFP_KERNEL);
> +		if (!phy_desc)
> +			return -ENOMEM;
> +
> +		phy =3D devm_phy_create(dev, &phy_berlin_sata_ops, NULL);
> +		if (IS_ERR(phy)) {
> +			dev_err(dev, "failed to create PHY %d\n", phy_id);
> +			return PTR_ERR(phy);
> +		}
> +
> +		phy_desc->phy =3D phy;
> +		phy_desc->power_bit =3D phy_berlin_power_down_bits[phy_id];
> +		phy_desc->index =3D phy_id;
> +		phy_set_drvdata(phy, phy_desc);
> +
> +		priv->phys[i++] =3D phy_desc;
> +
> +		/* Make sure the PHY is off */
> +		phy_berlin_sata_power_off(phy);
> +	}
> +
> +	phy_provider =3D
> +		devm_of_phy_provider_register(dev, phy_berlin_sata_phy_xlate);
> +	if (IS_ERR(phy_provider))
> +		return PTR_ERR(phy_provider);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id phy_berlin_sata_of_match[] =3D {
> +	{ .compatible =3D "marvell,berlin2q-sata-phy" },
> +	{ },
> +};
> +
> +static struct platform_driver phy_berlin_sata_driver =3D {
> +	.probe	=3D phy_berlin_sata_probe,
> +	.driver	=3D {
> +		.name		=3D "phy-berlin-sata",
> +		.owner		=3D THIS_MODULE,
> +		.of_match_table	=3D phy_berlin_sata_of_match,
> +	},
> +};
> +module_platform_driver(phy_berlin_sata_driver);
> +
> +MODULE_DESCRIPTION("Marvell Berlin SATA PHY driver");
> +MODULE_AUTHOR("Antoine T=C3=A9nart <antoine.tenart-wi1+55ScJUtKEb57/3fJTGGXanvQGlWp@public.gmane.org=
m>");
> +MODULE_LICENSE("GPL v2");
>=20
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
