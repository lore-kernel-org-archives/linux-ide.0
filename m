From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH v9 3/7] ata: libahci: allow to use multiple PHYs
Date: Tue, 8 Jul 2014 19:49:00 +0200
Message-ID: <20140708174900.GC16148@kwain>
References: <1404728173-20263-1-git-send-email-antoine.tenart@free-electrons.com>
 <1404728173-20263-4-git-send-email-antoine.tenart@free-electrons.com>
 <20140708134000.GC4979@htj.dyndns.org>
 <20140708170353.GA16148@kwain>
 <20140708171817.GH4979@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:40369 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754833AbaGHRtF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jul 2014 13:49:05 -0400
Content-Disposition: inline
In-Reply-To: <20140708171817.GH4979@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, kishon@ti.com, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

On Tue, Jul 08, 2014 at 01:18:17PM -0400, Tejun Heo wrote:
> Hello,
>=20
> On Tue, Jul 08, 2014 at 07:03:53PM +0200, Antoine T=E9nart wrote:
> > > So, hpriv->port is both input and output?  This is messy and can =
lead
> > > to confusing failures and there now are multiple ways to modify
> > > port_map.  If carrying this information through ahci_host_priv is
> > > necessary, let's remove the direct params and introduce new input
> > > fields to the struct.
> >=20
> > We just use hpriv->port_map to check port_map is valid and describe=
s
> > available ports there.
> >=20
> > hpriv->port_map is filed by the generic ahci_platform_get_resources=
()
> > function when using the new bindings and not by the drivers. port_m=
ap is
> > the input from the drivers.
>=20
> So, yeah, it's being used both as input and output and we also have
> the arguments which affect port_map, right?  It does seem confusing.

I do see priv->port_map as being automatically set and then restricted
if needed by the port_map input here. I don't see how that's confusing.
The only modification is we restrict the port_map parameter to the set
of available ports. The port_map argument affected priv->port_map befor=
e
this patch.

>=20
> > Well, a had a review a week ago about in the PHY driver saying I sh=
ould
> > avoid using fixed sized arrays... And it was in a driver were we kn=
ow
> > the maximum number of PHY available.
> >=20
> > I think in this case were the number of PHYs depends on the h/w, we=
 should
> > use a dynamically allocated array.
>=20
> Well, so does clk.  Let's say clk is more restricted and phy can be
> one or more per port and thus needs to be dynamic.  If so, shouldn't
> we at least have some correlation between phys and ports?  It bothers
> me that now libahci is carrying random number of resources that it ha=
s
> no idea how to associate with the ports it manages.  What if later we
> want to involve phy driver in power managing unoccupied ports?

I see. This is a first (working) attempt to have a one node per port. I
agree that would be nice to have a correlation between ports and PHYs.
This can definitively be added when needed without changing the dt
bindings as only the internal representation changes. This would also
require to get all phys from the port nodes, which is again internal
stuff.

Don't you think we can go by steps, and have a following up series for
this when needed (like in a power managing series for unoccupied ports)=
?


Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
