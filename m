From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH v9 3/7] ata: libahci: allow to use multiple PHYs
Date: Wed, 9 Jul 2014 10:23:31 +0200
Message-ID: <20140709082331.GA4510@kwain>
References: <1404728173-20263-1-git-send-email-antoine.tenart@free-electrons.com>
 <1404728173-20263-4-git-send-email-antoine.tenart@free-electrons.com>
 <20140708134000.GC4979@htj.dyndns.org>
 <20140708170353.GA16148@kwain>
 <20140708171817.GH4979@htj.dyndns.org>
 <20140708174900.GC16148@kwain>
 <20140708214010.GI4979@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:44174 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751294AbaGIIXf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jul 2014 04:23:35 -0400
Content-Disposition: inline
In-Reply-To: <20140708214010.GI4979@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, kishon@ti.com, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Hi Tejun,

On Tue, Jul 08, 2014 at 05:40:10PM -0400, Tejun Heo wrote:
> Hey,
>=20
> On Tue, Jul 08, 2014 at 07:49:00PM +0200, Antoine T=E9nart wrote:
> > > So, yeah, it's being used both as input and output and we also ha=
ve
> > > the arguments which affect port_map, right?  It does seem confusi=
ng.
> >=20
> > I do see priv->port_map as being automatically set and then restric=
ted
> > if needed by the port_map input here. I don't see how that's confus=
ing.
> > The only modification is we restrict the port_map parameter to the =
set
> > of available ports. The port_map argument affected priv->port_map b=
efore
> > this patch.
>=20
> It is confusing.  If you wanna pass around available ports in hpriv,
> please add a separate field and replace the arguments to
> save_initial_config().

I don't get it. Which argument should I replace in
save_initial_config()? The change is we compute hpriv->port_map.
I don't see which arguments we can add or replace.

If that's more clear, the modification here is equivalent to (when usin=
g
the new bindings):

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 40ea583d3610..f9d3cfd5d1bd 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -513,7 +513,7 @@ void ahci_save_initial_config(struct device *dev,
        /* record values to use during operation */
        hpriv->cap =3D cap;
        hpriv->cap2 =3D cap2;
-       hpriv->port_map =3D port_map;
+       hpriv->port_map &=3D port_map;
=20
        if (!hpriv->start_engine)
                hpriv->start_engine =3D ahci_start_engine;

It just use the argument port_map on the real set of ports. If that's
still not clear, I can add a separate field. But the field will store
the exact same information as hpriv->port_map. We will have something
like:

if (hpriv->available_port_map)
	hpriv->port_map &=3D hpriv->available_port_map;

> > > Well, so does clk.  Let's say clk is more restricted and phy can =
be
> > > one or more per port and thus needs to be dynamic.  If so, should=
n't
> > > we at least have some correlation between phys and ports?  It bot=
hers
> > > me that now libahci is carrying random number of resources that i=
t has
> > > no idea how to associate with the ports it manages.  What if late=
r we
> > > want to involve phy driver in power managing unoccupied ports?
> >=20
> > I see. This is a first (working) attempt to have a one node per por=
t. I
> > agree that would be nice to have a correlation between ports and PH=
Ys.
> > This can definitively be added when needed without changing the dt
> > bindings as only the internal representation changes. This would al=
so
> > require to get all phys from the port nodes, which is again interna=
l
> > stuff.
> >=20
> > Don't you think we can go by steps, and have a following up series =
for
> > this when needed (like in a power managing series for unoccupied po=
rts)?
>=20
> I don't know.  It isn't exactly difficult to make it per-port, is it?
> We already have ahci_port_priv and wouldn't the code actually be
> simpler that way?

I had a quick look on this, and it does not seems to be that simple. Th=
e
ahci_port_priv is stored inside the ata_port struct and not accessible
(as of now) from the ahci_host_priv one. The ahci_port_priv is
initialized at the end of ahci_platform_init_host(), far after we need
it. This requires quite a lot of changes. Or is there another way?

To be honest, we are now at v9 and it's been quite a long time since v1=
=2E
I'd really like it to be merged in 3.17. As I see it, this patch keeps
the same logic as what was in place before, only with more PHYs.

Don't take me wrong, I really think this is a good idea to have a
per-port PHY information. But this is a refactoring not clearly related
to this series as the logic is not changed. This definitively can be th=
e
subject of a dedicated series, especially if I got it right and the
required modifications are not that obvious.

What do you think?

Thanks,

Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
