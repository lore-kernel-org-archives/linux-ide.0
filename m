From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v3 1/6] phy: add a driver for the Berlin SATA PHY
Date: Thu, 15 May 2014 11:45:16 +0530
Message-ID: <53745B74.2040808@ti.com>
References: <1400060942-10588-1-git-send-email-antoine.tenart@free-electrons.com> <1400060942-10588-2-git-send-email-antoine.tenart@free-electrons.com> <537341AF.5030105@ti.com> <20140514102122.GA11140@kwain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45205 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751403AbaEOGP5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 May 2014 02:15:57 -0400
In-Reply-To: <20140514102122.GA11140@kwain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?QW50b2luZSBUw6luYXJ0?= <antoine.tenart@free-electrons.com>
Cc: sebastian.hesselbarth@gmail.com, tj@kernel.org, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Wednesday 14 May 2014 03:51 PM, Antoine T=C3=A9nart wrote:
> Hi,
>=20
> On Wed, May 14, 2014 at 03:43:03PM +0530, Kishon Vijay Abraham I wrot=
e:
>> Hi,
>>
>> On Wednesday 14 May 2014 03:18 PM, Antoine T=C3=A9nart wrote:
>=20
> [=E2=80=A6]
>=20
>>> +#define to_berlin_sata_phy_priv(desc)	\
>>> +	container_of((desc), struct phy_berlin_priv, phys[(desc)->index])
>>> +
>>> +struct phy_berlin_desc {
>>> +	struct phy	*phy;
>>> +	u32		val;
>>> +	unsigned	index;
>>> +};
>>> +
>>> +struct phy_berlin_priv {
>>> +	void __iomem	*base;
>>> +	spinlock_t	lock;
>>> +	struct phy_berlin_desc	phys[BERLIN_SATA_PHY_NB];
>>
>> Can't we do away with hardcoding BERLIN_SATA_PHY_NB?
>=20
> We can't if we want to be able to use the container_of macro in
> to_berlin_sata_phy_priv(). And we want a common structure to store th=
e
> common spinlock and base address.

to get phy_berlin_priv, you can use dev_get_drvdata(phy->dev->parent).

>=20
> [=E2=80=A6]
>=20
>>> +		/*
>>> +		 * By default the PHY node is used to request and match a PHY.
>>> +		 * We describe one PHY per sub-node here. Use the right node.
>>> +		 */
>>> +		phy->dev.of_node =3D child;
>>> +
>>> +		priv->phys[phy_id].phy =3D phy;
>>> +		priv->phys[phy_id].val =3D desc[phy_id].val;
>>> +		priv->phys[phy_id].index =3D phy_id;
>>> +		phy_set_drvdata(phy, &priv->phys[phy_id]);
>>> +
>>> +		/* Make sure the PHY is off */
>>> +		phy_berlin_sata_power_off(phy);
>>> +
>>> +		phy_provider =3D devm_of_phy_provider_register(&phy->dev,
>>> +							     of_phy_simple_xlate);
>>> +		if (IS_ERR(phy_provider))
>>> +			return PTR_ERR(phy_provider);
>>
>> was this intentional? registering multiple PHY providers?
>=20
> Yes. Each sub-node describe a PHY and register as a PHY provider. Thi=
s
> allow to reference the PHY as <&sata_phy0> and not <&sata_phy 0>. It
> would be confusing to have a sub-node sata_phy0 and to use its parent
> to access it.

It is still a single PHY provider, so you can't register multiple PHY
providers. So in this case <&sata_phy 0> is not that bad.

However phy-core.c should be patched with the following (only compile t=
ested)

=46rom 2517d4c0ad7f13abc2613516ef2b222a1fbcb550 Mon Sep 17 00:00:00 200=
1
=46rom: Kishon Vijay Abraham I <kishon@ti.com>
Date: Thu, 15 May 2014 11:32:57 +0530
Subject: [PATCH] phy: phy-core: Support modelling multi-PHY PHY nodes a=
s
 subnodes of PHY PROVIDER

When a single PHY provider implementing multiple PHYs is represented in=
 dt,
the PHYs should be modelled as sub nodes of the PHY PROVIDER node.

So the consumers using the PHY will have the phandle of the sub node ra=
ther
than the phandle of the PHY PROVIDER. Amended *of_phy_provider_lookup* =
in
PHY core to return the PHY PROVIDER even when the phandle of the PHY PR=
OVIDERs
sub node is provided.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/phy-core.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 03cf8fb..124c6ec 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -83,10 +83,18 @@ static struct phy *phy_lookup(struct device *device=
, const
char *port)
 static struct phy_provider *of_phy_provider_lookup(struct device_node =
*node)
 {
        struct phy_provider *phy_provider;
+       struct device_node *child;

        list_for_each_entry(phy_provider, &phy_provider_list, list) {
-               if (phy_provider->dev->of_node =3D=3D node)
+               if (phy_provider->dev->of_node !=3D node) {
+                       for_each_child_of_node(phy_provider->dev->of_no=
de,
+                               child) {
+                               if (child =3D=3D node)
+                                       return phy_provider;
+                       }
+               } else {
                        return phy_provider;
+               }
        }

        return ERR_PTR(-EPROBE_DEFER);
--=20
1.7.9.5

Thanks
Kishon
