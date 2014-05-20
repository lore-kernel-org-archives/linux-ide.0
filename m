From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH v4 1/7] phy: add a driver for the Berlin SATA PHY
Date: Tue, 20 May 2014 16:06:52 +0200
Message-ID: <20140520140652.GB21579@kwain>
References: <1400576675-25265-1-git-send-email-antoine.tenart@free-electrons.com>
 <1400576675-25265-2-git-send-email-antoine.tenart@free-electrons.com>
 <1821771.zFvTDGF2Ae@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:60809 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751092AbaETOG4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 May 2014 10:06:56 -0400
Content-Disposition: inline
In-Reply-To: <1821771.zFvTDGF2Ae@amdc1032>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, tj@kernel.org, kishon@ti.com, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Tue, May 20, 2014 at 02:34:20PM +0200, Bartlomiej Zolnierkiewicz wro=
te:
> On Tuesday, May 20, 2014 11:04:29 AM Antoine T=E9nart wrote:
> > +
> > +static struct phy_berlin_desc desc[] =3D {
> > +	{ .val =3D POWER_DOWN_PHY0 },
> > +	{ .val =3D POWER_DOWN_PHY1 },
>=20
> Only .val entry of struct phy_berlin_desc is initialized and needed,
> it seems that u32 vals[] should be used instead of desc[].

Sure.

> > +
> > +static int phy_berlin_sata_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct phy *phy;
> > +	struct phy_provider *phy_provider;
> > +	struct phy_berlin_priv *priv;
> > +	struct resource *res;
> > +	int i;
> > +
> > +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	priv->base =3D devm_ioremap(dev, res->start, resource_size(res));
> > +	if (IS_ERR(priv->base))
> > +		return PTR_ERR(priv->base);
>=20
> devm_ioremap() (contrary to devm_ioremap_resource()) returns a valid
> pointer or NULL so return value checking should be fixed.

I'll fix this.


Thanks for the review!

Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
