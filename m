From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH v3 1/6] phy: add a driver for the Berlin SATA PHY
Date: Wed, 14 May 2014 17:49:29 +0200
Message-ID: <20140514154929.GA8016@kwain>
References: <1400060942-10588-1-git-send-email-antoine.tenart@free-electrons.com>
 <16480004.aaDhzlOZgi@wuerfel>
 <20140514145002.GA18392@kwain>
 <31922167.uMVzxsQNIT@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:48085 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755426AbaENPte (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 May 2014 11:49:34 -0400
Content-Disposition: inline
In-Reply-To: <31922167.uMVzxsQNIT@wuerfel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kishon@ti.com, linux-ide@vger.kernel.org, alexandre.belloni@free-electrons.com, jszhang@marvell.com, tj@kernel.org, sebastian.hesselbarth@gmail.com

On Wed, May 14, 2014 at 05:31:24PM +0200, Arnd Bergmann wrote:
> On Wednesday 14 May 2014 16:50:02 Antoine T=E9nart wrote:
> > On Wed, May 14, 2014 at 03:02:34PM +0200, Arnd Bergmann wrote:
> > > On Wednesday 14 May 2014 11:48:57 Antoine T=E9nart wrote:
> > > > +static int phy_berlin_sata_power_on(struct phy *phy)
> > > > +{
> > > > +       struct phy_berlin_desc *desc =3D phy_get_drvdata(phy);
> > > > +       struct phy_berlin_priv *priv =3D to_berlin_sata_phy_pri=
v(desc);
> > > > +       u32 regval;
> > > > +
> > > > +       spin_lock(&priv->lock);
> > > > +
> > > > +       /* Power up PHY */
> > > > +       writel(CONTROL_REGISTER, priv->base + HOST_VSA_ADDR);
> > > > +       regval =3D readl(priv->base + HOST_VSA_DATA);
> > > > +       regval &=3D ~(desc->val);
> > > > +       writel(regval, priv->base + HOST_VSA_DATA);
> > > > +
> > > > +       /* Configure MBus */
> > > > +       writel(MBUS_SIZE_CONTROL, priv->base + HOST_VSA_ADDR);
> > > > +       regval =3D readl(priv->base + HOST_VSA_DATA);
> > > > +       regval |=3D MBUS_WRITE_REQUEST_SIZE_128 | MBUS_READ_REQ=
UEST_SIZE_128;
> > > > +       writel(regval, priv->base + HOST_VSA_DATA);
> > > > +
> > > > +       spin_unlock(&priv->lock);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int phy_berlin_sata_power_off(struct phy *phy)
> > > > +{
> > > > +       struct phy_berlin_desc *desc =3D phy_get_drvdata(phy);
> > > > +       struct phy_berlin_priv *priv =3D to_berlin_sata_phy_pri=
v(desc);
> > > > +       u32 regval;
> > > > +
> > > > +       spin_lock(&priv->lock);
> > > > +
> > > > +       /* Power down PHY */
> > > > +       writel(CONTROL_REGISTER, priv->base + HOST_VSA_ADDR);
> > > > +       regval =3D readl(priv->base + HOST_VSA_DATA);
> > > > +       regval |=3D desc->val;
> > > > +       writel(regval, priv->base + HOST_VSA_DATA);
> > > > +
> > > > +       spin_unlock(&priv->lock);
> > > > +
> > > > +       return 0;
> > >=20
> > > I don't get this part: you have a reference to the phy here,
> > > but then you go poking the phy registers from the SATA driver
> > > rather than calling a PHY API function.
> >=20
> > The v1 only introduced an AHCI driver. I somewhat agree the PHY
> > operations done in the AHCI driver could be in there.
> >=20
> > I can move the initialization done in the AHCI driver here, but I'l=
l
> > still need the driver: the Berlin AHCI needs to call the framework
> > generic functions with a custom mask and has custom pm_ops. So I'll
> > end up with a nearly empty AHCI driver, not able to control the por=
t
> > parameters.
> >=20
> > Or I can put all this in the AHCI driver, but then we'll need to
> > describe the PHYs there (to be able to enable each PHY independentl=
y)
> > and add bindings to the SATA ones.
> >=20
> > What do you think? I prefer the first solution, but we'll have SATA
> > port related configuration in the PHY and a very tiny AHCI driver
> > because I can't really use the default behaviour of the ahci_platfo=
rm.
>=20
> I just noticed I quoted the wrong driver with my comment, but I think
> you got what I meant.
>=20
> Why do you need a custom mask? Is that something you could pass
> as the argument in the phy descriptor using #phy-cells=3D<1>?

I meant a custom mask in the AHCI driver, when calling the
ahci_platform_init_host() function. Otherwise we'll have problems on th=
e
BG2Q DMP (it only has one PHY available, and not initializing it is not
enough).

>=20
> > > > +                * By default the PHY node is used to request a=
nd match a PHY.
> > > > +                * We describe one PHY per sub-node here. Use t=
he right node.
> > > > +                */
> > > > +               phy->dev.of_node =3D child;
> > > > +
> > > > +               priv->phys[phy_id].phy =3D phy;
> > > > +               priv->phys[phy_id].val =3D desc[phy_id].val;
> > > > +               priv->phys[phy_id].index =3D phy_id;
> > > > +               phy_set_drvdata(phy, &priv->phys[phy_id]);
> > >=20
> > > And here, you set a driver specific value into a structure used b=
y the
> > > PHY.
> >=20
> > Values in priv->phys[] are related to the PHYs. phy_set_drvdata() a=
llows
> > to store PHY related data, which is what I'm doing there. Nearly al=
l PHY
> > drivers are doing this.
> >=20
> > Or am I missing something?
>=20
> This part is really ok, I got confused when I replied to the wrong em=
ail.
> Sorry about this.
>=20
> > > Both of these are layering violations. You should either use the =
PHY
> > > interfaces correctly so the SATA driver doesn't have to know abou=
t the
> > > specific, or not use a PHY device node at all and do everything i=
n
> > > the SATA front-end.
> >=20
> > To be sure: you mean using the PHY init() interface in the AHCI dri=
ver?
>=20
> If this PHY is specific to the ahci-berlin hardware and not shared wi=
th
> anything else, you don't really need to split out a phy driver. That
> would somewhat simplify what you ahve here.

I don't have lots of info about that, but we set the PHY to
PHY_MODE_SATA in the AHCI driver. So I guess there are other modes.

Maybe Jisheng can help us with this?

>=20
> The alternative is to make it as generic as you can. If you can manag=
e
> to move all the phy code into phy-berlin-sata driver, it should be
> possible to just extend the ahci-platform driver resume function to
> reinitialize the phy if there is one.

It is possible to move all the PHY code the phy-berlin-sata. Then I'll
need to hack a bit the AHCI framework so it can handle more than one
PHY. But as I said, I'll still need to set a custom mask, and adding a
quirk to the AHCI platform or framework does not seem to be a very good
idea, imho.

Or I can add a computed mask to the ahci-platform driver, like I did in
the Berlin one, but I don't know what would be the consequences. For
each PHY I have:

+	mask |=3D 1 << i;


Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
