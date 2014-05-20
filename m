From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 1/7] phy: add a driver for the Berlin SATA PHY
Date: Tue, 20 May 2014 16:40:58 +0200
Message-ID: <20140520144058.GE21579@kwain>
References: <1400576675-25265-1-git-send-email-antoine.tenart@free-electrons.com>
 <1400576675-25265-2-git-send-email-antoine.tenart@free-electrons.com>
 <1821771.zFvTDGF2Ae@amdc1032>
 <20140520140652.GB21579@kwain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140520140652.GB21579@kwain>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Tue, May 20, 2014 at 04:06:52PM +0200, Antoine T=E9nart wrote:
> Hi,
>=20
> On Tue, May 20, 2014 at 02:34:20PM +0200, Bartlomiej Zolnierkiewicz w=
rote:
> > On Tuesday, May 20, 2014 11:04:29 AM Antoine T=E9nart wrote:
> > > +
> > > +static struct phy_berlin_desc desc[] =3D {
> > > +	{ .val =3D POWER_DOWN_PHY0 },
> > > +	{ .val =3D POWER_DOWN_PHY1 },
> >=20
> > Only .val entry of struct phy_berlin_desc is initialized and needed=
,
> > it seems that u32 vals[] should be used instead of desc[].
>=20
> Sure.
>=20
> > > +
> > > +static int phy_berlin_sata_probe(struct platform_device *pdev)
> > > +{
> > > +	struct device *dev =3D &pdev->dev;
> > > +	struct phy *phy;
> > > +	struct phy_provider *phy_provider;
> > > +	struct phy_berlin_priv *priv;
> > > +	struct resource *res;
> > > +	int i;
> > > +
> > > +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > +	if (!priv)
> > > +		return -ENOMEM;
> > > +
> > > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);

We also need to check res isn't NULL here.

> > > +	priv->base =3D devm_ioremap(dev, res->start, resource_size(res)=
);
> > > +	if (IS_ERR(priv->base))
> > > +		return PTR_ERR(priv->base);
> >=20
> > devm_ioremap() (contrary to devm_ioremap_resource()) returns a vali=
d
> > pointer or NULL so return value checking should be fixed.
>=20
> I'll fix this.

Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
