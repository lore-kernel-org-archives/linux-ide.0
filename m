From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v3 1/6] phy: add a driver for the Berlin SATA PHY
Date: Wed, 14 May 2014 17:31:24 +0200
Message-ID: <31922167.uMVzxsQNIT@wuerfel>
References: <1400060942-10588-1-git-send-email-antoine.tenart@free-electrons.com> <16480004.aaDhzlOZgi@wuerfel> <20140514145002.GA18392@kwain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140514145002.GA18392@kwain>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Antoine =?ISO-8859-1?Q?T=E9nart?= <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Wednesday 14 May 2014 16:50:02 Antoine T=E9nart wrote:
> On Wed, May 14, 2014 at 03:02:34PM +0200, Arnd Bergmann wrote:
> > On Wednesday 14 May 2014 11:48:57 Antoine T=E9nart wrote:
> > > +static int phy_berlin_sata_power_on(struct phy *phy)
> > > +{
> > > +       struct phy_berlin_desc *desc =3D phy_get_drvdata(phy);
> > > +       struct phy_berlin_priv *priv =3D to_berlin_sata_phy_priv(=
desc);
> > > +       u32 regval;
> > > +
> > > +       spin_lock(&priv->lock);
> > > +
> > > +       /* Power up PHY */
> > > +       writel(CONTROL_REGISTER, priv->base + HOST_VSA_ADDR);
> > > +       regval =3D readl(priv->base + HOST_VSA_DATA);
> > > +       regval &=3D ~(desc->val);
> > > +       writel(regval, priv->base + HOST_VSA_DATA);
> > > +
> > > +       /* Configure MBus */
> > > +       writel(MBUS_SIZE_CONTROL, priv->base + HOST_VSA_ADDR);
> > > +       regval =3D readl(priv->base + HOST_VSA_DATA);
> > > +       regval |=3D MBUS_WRITE_REQUEST_SIZE_128 | MBUS_READ_REQUE=
ST_SIZE_128;
> > > +       writel(regval, priv->base + HOST_VSA_DATA);
> > > +
> > > +       spin_unlock(&priv->lock);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int phy_berlin_sata_power_off(struct phy *phy)
> > > +{
> > > +       struct phy_berlin_desc *desc =3D phy_get_drvdata(phy);
> > > +       struct phy_berlin_priv *priv =3D to_berlin_sata_phy_priv(=
desc);
> > > +       u32 regval;
> > > +
> > > +       spin_lock(&priv->lock);
> > > +
> > > +       /* Power down PHY */
> > > +       writel(CONTROL_REGISTER, priv->base + HOST_VSA_ADDR);
> > > +       regval =3D readl(priv->base + HOST_VSA_DATA);
> > > +       regval |=3D desc->val;
> > > +       writel(regval, priv->base + HOST_VSA_DATA);
> > > +
> > > +       spin_unlock(&priv->lock);
> > > +
> > > +       return 0;
> >=20
> > I don't get this part: you have a reference to the phy here,
> > but then you go poking the phy registers from the SATA driver
> > rather than calling a PHY API function.
>=20
> The v1 only introduced an AHCI driver. I somewhat agree the PHY
> operations done in the AHCI driver could be in there.
>=20
> I can move the initialization done in the AHCI driver here, but I'll
> still need the driver: the Berlin AHCI needs to call the framework
> generic functions with a custom mask and has custom pm_ops. So I'll
> end up with a nearly empty AHCI driver, not able to control the port
> parameters.
>=20
> Or I can put all this in the AHCI driver, but then we'll need to
> describe the PHYs there (to be able to enable each PHY independently)
> and add bindings to the SATA ones.
>=20
> What do you think? I prefer the first solution, but we'll have SATA
> port related configuration in the PHY and a very tiny AHCI driver
> because I can't really use the default behaviour of the ahci_platform=
=2E

I just noticed I quoted the wrong driver with my comment, but I think
you got what I meant.

Why do you need a custom mask? Is that something you could pass
as the argument in the phy descriptor using #phy-cells=3D<1>?

> > > +                * By default the PHY node is used to request and=
 match a PHY.
> > > +                * We describe one PHY per sub-node here. Use the=
 right node.
> > > +                */
> > > +               phy->dev.of_node =3D child;
> > > +
> > > +               priv->phys[phy_id].phy =3D phy;
> > > +               priv->phys[phy_id].val =3D desc[phy_id].val;
> > > +               priv->phys[phy_id].index =3D phy_id;
> > > +               phy_set_drvdata(phy, &priv->phys[phy_id]);
> >=20
> > And here, you set a driver specific value into a structure used by =
the
> > PHY.
>=20
> Values in priv->phys[] are related to the PHYs. phy_set_drvdata() all=
ows
> to store PHY related data, which is what I'm doing there. Nearly all =
PHY
> drivers are doing this.
>=20
> Or am I missing something?

This part is really ok, I got confused when I replied to the wrong emai=
l.
Sorry about this.

> > Both of these are layering violations. You should either use the PH=
Y
> > interfaces correctly so the SATA driver doesn't have to know about =
the
> > specific, or not use a PHY device node at all and do everything in
> > the SATA front-end.
>=20
> To be sure: you mean using the PHY init() interface in the AHCI drive=
r?

If this PHY is specific to the ahci-berlin hardware and not shared with
anything else, you don't really need to split out a phy driver. That
would somewhat simplify what you ahve here.

The alternative is to make it as generic as you can. If you can manage
to move all the phy code into phy-berlin-sata driver, it should be
possible to just extend the ahci-platform driver resume function to
reinitialize the phy if there is one.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
