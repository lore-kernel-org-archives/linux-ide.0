From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH v3 1/6] phy: add a driver for the Berlin SATA PHY
Date: Wed, 14 May 2014 16:50:02 +0200
Message-ID: <20140514145002.GA18392@kwain>
References: <1400060942-10588-1-git-send-email-antoine.tenart@free-electrons.com>
 <1400060942-10588-2-git-send-email-antoine.tenart@free-electrons.com>
 <16480004.aaDhzlOZgi@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47593 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751253AbaENOuH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 May 2014 10:50:07 -0400
Content-Disposition: inline
In-Reply-To: <16480004.aaDhzlOZgi@wuerfel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, tj@kernel.org, kishon@ti.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alexandre.belloni@free-electrons.com, jszhang@marvell.com

Arnd,

On Wed, May 14, 2014 at 03:02:34PM +0200, Arnd Bergmann wrote:
> On Wednesday 14 May 2014 11:48:57 Antoine T=E9nart wrote:
> > +static int phy_berlin_sata_power_on(struct phy *phy)
> > +{
> > +       struct phy_berlin_desc *desc =3D phy_get_drvdata(phy);
> > +       struct phy_berlin_priv *priv =3D to_berlin_sata_phy_priv(de=
sc);
> > +       u32 regval;
> > +
> > +       spin_lock(&priv->lock);
> > +
> > +       /* Power up PHY */
> > +       writel(CONTROL_REGISTER, priv->base + HOST_VSA_ADDR);
> > +       regval =3D readl(priv->base + HOST_VSA_DATA);
> > +       regval &=3D ~(desc->val);
> > +       writel(regval, priv->base + HOST_VSA_DATA);
> > +
> > +       /* Configure MBus */
> > +       writel(MBUS_SIZE_CONTROL, priv->base + HOST_VSA_ADDR);
> > +       regval =3D readl(priv->base + HOST_VSA_DATA);
> > +       regval |=3D MBUS_WRITE_REQUEST_SIZE_128 | MBUS_READ_REQUEST=
_SIZE_128;
> > +       writel(regval, priv->base + HOST_VSA_DATA);
> > +
> > +       spin_unlock(&priv->lock);
> > +
> > +       return 0;
> > +}
> > +
> > +static int phy_berlin_sata_power_off(struct phy *phy)
> > +{
> > +       struct phy_berlin_desc *desc =3D phy_get_drvdata(phy);
> > +       struct phy_berlin_priv *priv =3D to_berlin_sata_phy_priv(de=
sc);
> > +       u32 regval;
> > +
> > +       spin_lock(&priv->lock);
> > +
> > +       /* Power down PHY */
> > +       writel(CONTROL_REGISTER, priv->base + HOST_VSA_ADDR);
> > +       regval =3D readl(priv->base + HOST_VSA_DATA);
> > +       regval |=3D desc->val;
> > +       writel(regval, priv->base + HOST_VSA_DATA);
> > +
> > +       spin_unlock(&priv->lock);
> > +
> > +       return 0;
>=20
> I don't get this part: you have a reference to the phy here,
> but then you go poking the phy registers from the SATA driver
> rather than calling a PHY API function.

The v1 only introduced an AHCI driver. I somewhat agree the PHY
operations done in the AHCI driver could be in there.

I can move the initialization done in the AHCI driver here, but I'll
still need the driver: the Berlin AHCI needs to call the framework
generic functions with a custom mask and has custom pm_ops. So I'll
end up with a nearly empty AHCI driver, not able to control the port
parameters.

Or I can put all this in the AHCI driver, but then we'll need to
describe the PHYs there (to be able to enable each PHY independently)
and add bindings to the SATA ones.

What do you think? I prefer the first solution, but we'll have SATA
port related configuration in the PHY and a very tiny AHCI driver
because I can't really use the default behaviour of the ahci_platform.

> > +                * By default the PHY node is used to request and m=
atch a PHY.
> > +                * We describe one PHY per sub-node here. Use the r=
ight node.
> > +                */
> > +               phy->dev.of_node =3D child;
> > +
> > +               priv->phys[phy_id].phy =3D phy;
> > +               priv->phys[phy_id].val =3D desc[phy_id].val;
> > +               priv->phys[phy_id].index =3D phy_id;
> > +               phy_set_drvdata(phy, &priv->phys[phy_id]);
>=20
> And here, you set a driver specific value into a structure used by th=
e
> PHY.

Values in priv->phys[] are related to the PHYs. phy_set_drvdata() allow=
s
to store PHY related data, which is what I'm doing there. Nearly all PH=
Y
drivers are doing this.

Or am I missing something?

>=20
> Both of these are layering violations. You should either use the PHY
> interfaces correctly so the SATA driver doesn't have to know about th=
e
> specific, or not use a PHY device node at all and do everything in
> the SATA front-end.

To be sure: you mean using the PHY init() interface in the AHCI driver?

Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
