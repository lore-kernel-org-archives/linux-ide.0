From: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 6/9] ARM: tegra: Export tegra_powergate_power_on
Date: Wed, 9 Jul 2014 16:20:10 +0300
Message-ID: <20140709132010.GL23218@tbergstrom-lnx.Nvidia.com>
References: <20140623101441.GU3407@tbergstrom-lnx.Nvidia.com>
 <20140708130501.GC9516@ulmo>
 <20140708141135.GC23218@tbergstrom-lnx.Nvidia.com>
 <20140709063130.GA3170@ulmo>
 <20140709083311.GE23218@tbergstrom-lnx.Nvidia.com>
 <20140709102551.GA19357@ulmo>
 <20140709110816.GF23218@tbergstrom-lnx.Nvidia.com>
 <20140709120400.GA3819@ulmo>
 <20140709124344.GK23218@tbergstrom-lnx.Nvidia.com>
 <20140709125613.GA3262@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140709125613.GA3262@ulmo>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Wed, Jul 09, 2014 at 02:56:14PM +0200, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Wed, Jul 09, 2014 at 03:43:44PM +0300, Peter De Schrijver wrote:
> > On Wed, Jul 09, 2014 at 02:04:02PM +0200, Thierry Reding wrote:
> > > > For those 2 domains we can find the necessary clocks and resets by parsing
> > > > the relevant existing DT nodes for PCIe and gr3d. For clocks, this isn't
> > > > even needed as we can always register some extra clkdev's to get them. There
> > > > is no equivalent for resets so we have to parse the gr3d and pcie DT nodes,
> > > > but that's not too bad I think.
> > > 
> > > Even if we could really do this, at this point I don't see an advantage.
> > > All that it would be doing is move to some subsystem that doesn't quite
> > > match what we need just for the sake of moving to that subsystem. Having
> > > a Tegra-specific API doesn't sound so bad anymore.
> > > 
> > 
> > The advantage would be that we can use LP0/SC7 as a cpuidle state.
> 
> How is that going to work? And why does it need powergates to be

pm_runtime_get() and pm_runtime_put() hook into genpd. So genpd knows
when all devices in a domain are idle. It can then decide to turn off
the domain (based on the decision of a per domain governor). If all
domains are off (except for the non-powergateable domain), a special cpuidle
state can be enabled by genpd which will initiate a transition to LP0 without
actually doing a full system suspend.

> implemented as power domains? If we switch off power gates, then we need
> to restore context in the drivers anyway, therefore I assume .suspend()
> and .resume() would need to be called, in which case powergate handling
> can surely be done at that stage, can't it?
> 

.suspend() and .resume() are not used for this. genpd uses other per device
callbacks to save and restore the state which are invoked when the domain
is turned off and on (.save_state and .restore_state). The major difference
with .suspend() and .resume() is that .suspend() has to perform 3 tasks:
prevent any new requests to the driver, finalize or cancel all outstanding
requests and save the hw context. .save_state will only be called when the
device is idle (based on the refcount controlled by pm_runtime_get() and
pm_runtime_put()) which means it only has to handle saving the hw context.

> > Also system
> > resume from LP0 can be faster as we potentially don't have to resume all
> > domains at once.
> 
> I don't understand what that's got to do with anything. If we call into
> the PMC driver explicitly via tegra_powergate_*() functions from driver
> code, then we have full control over suspend/resume in the drivers, and
> therefore don't need to resume all at once either.

But then we would be duplicating all the bookkeeping required for this? What's
the point of that?

Cheers,

Peter.
