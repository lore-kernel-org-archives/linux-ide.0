From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH v3 1/6] phy: add a driver for the Berlin SATA PHY
Date: Wed, 14 May 2014 12:21:22 +0200
Message-ID: <20140514102122.GA11140@kwain>
References: <1400060942-10588-1-git-send-email-antoine.tenart@free-electrons.com>
 <1400060942-10588-2-git-send-email-antoine.tenart@free-electrons.com>
 <537341AF.5030105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:45367 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754332AbaENKVg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 May 2014 06:21:36 -0400
Content-Disposition: inline
In-Reply-To: <537341AF.5030105@ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, tj@kernel.org, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Wed, May 14, 2014 at 03:43:03PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
>=20
> On Wednesday 14 May 2014 03:18 PM, Antoine T=C3=A9nart wrote:

[=E2=80=A6]

> > +#define to_berlin_sata_phy_priv(desc)	\
> > +	container_of((desc), struct phy_berlin_priv, phys[(desc)->index])
> > +
> > +struct phy_berlin_desc {
> > +	struct phy	*phy;
> > +	u32		val;
> > +	unsigned	index;
> > +};
> > +
> > +struct phy_berlin_priv {
> > +	void __iomem	*base;
> > +	spinlock_t	lock;
> > +	struct phy_berlin_desc	phys[BERLIN_SATA_PHY_NB];
>=20
> Can't we do away with hardcoding BERLIN_SATA_PHY_NB?

We can't if we want to be able to use the container_of macro in
to_berlin_sata_phy_priv(). And we want a common structure to store the
common spinlock and base address.

[=E2=80=A6]

> > +		/*
> > +		 * By default the PHY node is used to request and match a PHY.
> > +		 * We describe one PHY per sub-node here. Use the right node.
> > +		 */
> > +		phy->dev.of_node =3D child;
> > +
> > +		priv->phys[phy_id].phy =3D phy;
> > +		priv->phys[phy_id].val =3D desc[phy_id].val;
> > +		priv->phys[phy_id].index =3D phy_id;
> > +		phy_set_drvdata(phy, &priv->phys[phy_id]);
> > +
> > +		/* Make sure the PHY is off */
> > +		phy_berlin_sata_power_off(phy);
> > +
> > +		phy_provider =3D devm_of_phy_provider_register(&phy->dev,
> > +							     of_phy_simple_xlate);
> > +		if (IS_ERR(phy_provider))
> > +			return PTR_ERR(phy_provider);
>=20
> was this intentional? registering multiple PHY providers?

Yes. Each sub-node describe a PHY and register as a PHY provider. This
allow to reference the PHY as <&sata_phy0> and not <&sata_phy 0>. It
would be confusing to have a sub-node sata_phy0 and to use its parent
to access it.

Antoine

--=20
Antoine T=C3=A9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
