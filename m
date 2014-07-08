From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 3/7] ata: libahci: allow to use multiple PHYs
Date: Tue, 8 Jul 2014 13:18:17 -0400
Message-ID: <20140708171817.GH4979@htj.dyndns.org>
References: <1404728173-20263-1-git-send-email-antoine.tenart@free-electrons.com>
 <1404728173-20263-4-git-send-email-antoine.tenart@free-electrons.com>
 <20140708134000.GC4979@htj.dyndns.org>
 <20140708170353.GA16148@kwain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140708170353.GA16148@kwain>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Hello,

On Tue, Jul 08, 2014 at 07:03:53PM +0200, Antoine T=E9nart wrote:
> > So, hpriv->port is both input and output?  This is messy and can le=
ad
> > to confusing failures and there now are multiple ways to modify
> > port_map.  If carrying this information through ahci_host_priv is
> > necessary, let's remove the direct params and introduce new input
> > fields to the struct.
>=20
> We just use hpriv->port_map to check port_map is valid and describes
> available ports there.
>=20
> hpriv->port_map is filed by the generic ahci_platform_get_resources()
> function when using the new bindings and not by the drivers. port_map=
 is
> the input from the drivers.

So, yeah, it's being used both as input and output and we also have
the arguments which affect port_map, right?  It does seem confusing.

> Well, a had a review a week ago about in the PHY driver saying I shou=
ld
> avoid using fixed sized arrays... And it was in a driver were we know
> the maximum number of PHY available.
>=20
> I think in this case were the number of PHYs depends on the h/w, we s=
hould
> use a dynamically allocated array.

Well, so does clk.  Let's say clk is more restricted and phy can be
one or more per port and thus needs to be dynamic.  If so, shouldn't
we at least have some correlation between phys and ports?  It bothers
me that now libahci is carrying random number of resources that it has
no idea how to associate with the ports it manages.  What if later we
want to involve phy driver in power managing unoccupied ports?

Thanks.

--=20
tejun
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
