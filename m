From: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 6/9] ARM: tegra: Export tegra_powergate_power_on
Date: Wed, 9 Jul 2014 14:08:16 +0300
Message-ID: <20140709110816.GF23218@tbergstrom-lnx.Nvidia.com>
References: <20140618121806.GJ3407@tbergstrom-lnx.Nvidia.com>
 <53A1B252.1030204@wwwdotorg.org>
 <20140619080234.GK3407@tbergstrom-lnx.Nvidia.com>
 <53A3096B.1040409@wwwdotorg.org>
 <20140623101441.GU3407@tbergstrom-lnx.Nvidia.com>
 <20140708130501.GC9516@ulmo>
 <20140708141135.GC23218@tbergstrom-lnx.Nvidia.com>
 <20140709063130.GA3170@ulmo>
 <20140709083311.GE23218@tbergstrom-lnx.Nvidia.com>
 <20140709102551.GA19357@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140709102551.GA19357@ulmo>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Wed, Jul 09, 2014 at 12:25:52PM +0200, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Wed, Jul 09, 2014 at 11:33:11AM +0300, Peter De Schrijver wrote:
> > On Wed, Jul 09, 2014 at 08:31:32AM +0200, Thierry Reding wrote:
> > > > Old Signed by an unknown key
> > > 
> > > On Tue, Jul 08, 2014 at 05:11:35PM +0300, Peter De Schrijver wrote:
> > > > > > 
> > > > > > Yes, but the problem is that you also need clocks and reset of other modules
> > > > > > in the same domain to safely control the domain's status. Eg: the ISPs, VI and
> > > > > > CSI share a domain. VI and CSI are useable without ISP and the ISP lacks
> > > > > > public documentation. So it's not unlikely a VI and CSI driver will upstreamed
> > > > > > someday which means we would need to control the domain and therefore would
> > > > > > need to tell that driver about the ISPs clocks and resets even though the
> > > > > > driver doesn't know anything about the ISP hw otherwise.
> > > > > 
> > > > > Can't we make powergates reference counted so that they don't get
> > > > > disabled as long as there are any users? Looking for example at the
> > > > 
> > > > We could, but then why not switch to the powerdomain code and make powering
> > > > off a domain a NOP until we sorted out the context save/restore or fixed
> > > > the framework to allow for suspend without turning off the domains?
> > > 
> > > Well, one of the reasons why I'm not sure it's worth the effort at this
> > > point is that we can't get rid of the tegra_powergate_*() API anyway
> > > because of backwards compatibility. So we're going to add code (without
> > > getting rid of old code) merely to support some generic framework. That
> > > doesn't sound very useful to me.
> > > 
> > 
> > We can also convert the existing users to genpd. Today there are only 2 users
> > (gpu/drm/tegra/gr3d.c and pci/host/pci-tegra.c), so that doesn't seem to be
> > an impossible task.
> 
> We can certainly do that. What I'm trying to say is that since people
> may be running newer versions of the kernel with a DTB that doesn't have
> the necessary properties to hook up power domains, we have to keep calls
> to tegra_powergate_*() functions as-is, lest we break those setups.
> 

For those 2 domains we can find the necessary clocks and resets by parsing
the relevant existing DT nodes for PCIe and gr3d. For clocks, this isn't
even needed as we can always register some extra clkdev's to get them. There
is no equivalent for resets so we have to parse the gr3d and pcie DT nodes,
but that's not too bad I think.

Cheers,

Peter.
