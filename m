From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH v2 1/6] phy: add a driver for the Berlin SATA PHY
Date: Tue, 13 May 2014 14:14:50 +0200
Message-ID: <20140513121450.GC3213@kwain>
References: <1399886217-20474-1-git-send-email-antoine.tenart@free-electrons.com>
 <1399886217-20474-2-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:38556 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932671AbaEMMOx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 May 2014 08:14:53 -0400
Content-Disposition: inline
In-Reply-To: <1399886217-20474-2-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sebastian.hesselbarth@gmail.com, tj@kernel.org, kishon@ti.com
Cc: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, May 12, 2014 at 11:16:52AM +0200, Antoine T=C3=A9nart wrote:

[=E2=80=A6]

> +static int phy_berlin_sata_probe(struct platform_device *pdev)
> +{
> +	struct phy *phy;
> +	struct phy_provider *phy_provider;
> +	struct priv *priv;
> +	struct resource *res;
> +	int i;
> +
> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->base =3D devm_ioremap(&pdev->dev, res->start, resource_size(r=
es));
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	phy =3D devm_phy_create(&pdev->dev, &phy_berlin_sata_ops, NULL);
> +	if (IS_ERR(phy))
> +		return PTR_ERR(phy);

Not needed.

Antoine

> +
> +	dev_set_drvdata(&pdev->dev, priv);
> +	spin_lock_init(&priv->lock);
> +
> +	for (i =3D 0; i < BERLIN_SATA_PHY_NB; i++) {
> +		struct phy *phy =3D devm_phy_create(&pdev->dev,
> +						  &phy_berlin_sata_ops, NULL);
> +		if (IS_ERR(phy)) {
> +			dev_err(&pdev->dev, "failed to create PHY %d\n", i);
> +			return PTR_ERR(phy);
> +		}
> +
> +		priv->phys[i].phy =3D phy;
> +		priv->phys[i].val =3D desc[i].val;
> +		priv->phys[i].index =3D i;
> +		phy_set_drvdata(phy, &priv->phys[i]);
> +
> +		/* Make sure the PHY is off */
> +		phy_berlin_sata_power_off(phy);
> +	}
> +
> +	phy_provider =3D devm_of_phy_provider_register(&pdev->dev,
> +						     berlin_sata_phy_xlate);
> +	if (IS_ERR(phy_provider))
> +		return PTR_ERR(phy_provider);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id phy_berlin_sata_of_match[] =3D {
> +	{ .compatible =3D "marvell,berlin-sata-phy" },
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
> +MODULE_AUTHOR("Antoine T=C3=A9nart <antoine.tenart@free-electrons.co=
m>");
> +MODULE_LICENSE("GPL");
> --=20
> 1.9.1
>=20

--=20
Antoine T=C3=A9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
