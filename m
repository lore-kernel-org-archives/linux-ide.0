From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/6] phy: add a driver for the Berlin SATA PHY
Date: Wed, 14 May 2014 18:11:24 +0200
Message-ID: <4414637.rKolGB14Rm@wuerfel>
References: <1400060942-10588-1-git-send-email-antoine.tenart@free-electrons.com> <31922167.uMVzxsQNIT@wuerfel> <20140514154929.GA8016@kwain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:51907 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341AbaENQLa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 May 2014 12:11:30 -0400
In-Reply-To: <20140514154929.GA8016@kwain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Antoine =?ISO-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kishon@ti.com, linux-ide@vger.kernel.org, alexandre.belloni@free-electrons.com, jszhang@marvell.com, tj@kernel.org, sebastian.hesselbarth@gmail.com

On Wednesday 14 May 2014 17:49:29 Antoine T=E9nart wrote:
> On Wed, May 14, 2014 at 05:31:24PM +0200, Arnd Bergmann wrote:
> > On Wednesday 14 May 2014 16:50:02 Antoine T=E9nart wrote:
> > > On Wed, May 14, 2014 at 03:02:34PM +0200, Arnd Bergmann wrote:
> > > > On Wednesday 14 May 2014 11:48:57 Antoine T=E9nart wrote:
> > > > I don't get this part: you have a reference to the phy here,
> > > > but then you go poking the phy registers from the SATA driver
> > > > rather than calling a PHY API function.
> > >=20
> > > The v1 only introduced an AHCI driver. I somewhat agree the PHY
> > > operations done in the AHCI driver could be in there.
> > >=20
> > > I can move the initialization done in the AHCI driver here, but I=
'll
> > > still need the driver: the Berlin AHCI needs to call the framewor=
k
> > > generic functions with a custom mask and has custom pm_ops. So I'=
ll
> > > end up with a nearly empty AHCI driver, not able to control the p=
ort
> > > parameters.
> > >=20
> > > Or I can put all this in the AHCI driver, but then we'll need to
> > > describe the PHYs there (to be able to enable each PHY independen=
tly)
> > > and add bindings to the SATA ones.
> > >=20
> > > What do you think? I prefer the first solution, but we'll have SA=
TA
> > > port related configuration in the PHY and a very tiny AHCI driver
> > > because I can't really use the default behaviour of the ahci_plat=
form.
> >=20
> > I just noticed I quoted the wrong driver with my comment, but I thi=
nk
> > you got what I meant.
> >=20
> > Why do you need a custom mask? Is that something you could pass
> > as the argument in the phy descriptor using #phy-cells=3D<1>?
>=20
> I meant a custom mask in the AHCI driver, when calling the
> ahci_platform_init_host() function. Otherwise we'll have problems on =
the
> BG2Q DMP (it only has one PHY available, and not initializing it is n=
ot
> enough).

Ah, I see what you mean now. Of course, this could also be an optional
property in the generic AHCI binding, which would require that you
specify the available ports in DT for nonstandard masks.

Just to confirm: The HOST_PORTS_IMPL register on BG2Q DMP has an
value that we can't use here to determine the available ports, right?

> > > > > +                * By default the PHY node is used to request=
 and match a PHY.
> > > > > +                * We describe one PHY per sub-node here. Use=
 the right node.
> > > > > +                */
> > > > > +               phy->dev.of_node =3D child;
> > > > > +
> > > > > +               priv->phys[phy_id].phy =3D phy;
> > > > > +               priv->phys[phy_id].val =3D desc[phy_id].val;
> > > > > +               priv->phys[phy_id].index =3D phy_id;
> > > > > +               phy_set_drvdata(phy, &priv->phys[phy_id]);
> > > >=20
> > > > And here, you set a driver specific value into a structure used=
 by the
> > > > PHY.
> > >=20
> > > Values in priv->phys[] are related to the PHYs. phy_set_drvdata()=
 allows
> > > to store PHY related data, which is what I'm doing there. Nearly =
all PHY
> > > drivers are doing this.
> > >=20
> > > Or am I missing something?
> >=20
> > This part is really ok, I got confused when I replied to the wrong =
email.
> > Sorry about this.
> >=20
> > > > Both of these are layering violations. You should either use th=
e PHY
> > > > interfaces correctly so the SATA driver doesn't have to know ab=
out the
> > > > specific, or not use a PHY device node at all and do everything=
 in
> > > > the SATA front-end.
> > >=20
> > > To be sure: you mean using the PHY init() interface in the AHCI d=
river?
> >=20
> > If this PHY is specific to the ahci-berlin hardware and not shared =
with
> > anything else, you don't really need to split out a phy driver. Tha=
t
> > would somewhat simplify what you ahve here.
>=20
> I don't have lots of info about that, but we set the PHY to
> PHY_MODE_SATA in the AHCI driver. So I guess there are other modes.

Ok, good point. This does sound a lot like there are multiple modes.

This would also imply that the "compatible" string should not have
"sata" in it either, but describe a generic PHY. You can pass the mode
as part of the phy descriptor from DT then.

> > The alternative is to make it as generic as you can. If you can man=
age
> > to move all the phy code into phy-berlin-sata driver, it should be
> > possible to just extend the ahci-platform driver resume function to
> > reinitialize the phy if there is one.
>=20
> It is possible to move all the PHY code the phy-berlin-sata. Then I'l=
l
> need to hack a bit the AHCI framework so it can handle more than one
> PHY. But as I said, I'll still need to set a custom mask, and adding =
a
> quirk to the AHCI platform or framework does not seem to be a very go=
od
> idea, imho.
>=20
> Or I can add a computed mask to the ahci-platform driver, like I did =
in
> the Berlin one, but I don't know what would be the consequences. For
> each PHY I have:
>=20
> +	mask |=3D 1 << i;

It does sound generic enough that the same would be done on other
ahci-platform variants with a generic phy attached, even though
currently each one has only one phy.

We can probably define this as an extension in some form.
Do you think we need to handle the case where the first port is
unavailable but some of the other ports should be used?

	Arnd
