From: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 6/9] ARM: tegra: Export tegra_powergate_power_on
Date: Wed, 18 Jun 2014 15:18:06 +0300
Message-ID: <20140618121806.GJ3407@tbergstrom-lnx.Nvidia.com>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
 <1401881559-18469-7-git-send-email-mperttunen@nvidia.com>
 <539F691E.5030204@wwwdotorg.org>
 <20140617121313.GE18816@ulmo>
 <20140617140146.GH3407@tbergstrom-lnx.Nvidia.com>
 <20140617215119.GC24743@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140617215119.GC24743@mithrandir>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Tue, Jun 17, 2014 at 11:51:20PM +0200, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Tue, Jun 17, 2014 at 05:01:46PM +0300, Peter De Schrijver wrote:
> > On Tue, Jun 17, 2014 at 02:13:15PM +0200, Thierry Reding wrote:
> > > > Old Signed by an unknown key
> > > 
> > > On Mon, Jun 16, 2014 at 04:01:02PM -0600, Stephen Warren wrote:
> > > > On 06/04/2014 05:32 AM, Mikko Perttunen wrote:
> > > > > This symbol needs to be exported to power on rails without using
> > > > > tegra_powergate_sequence_power_up. tegra_powergate_sequence_power_up
> > > > > cannot be used in situations where the driver wants to handle clocking
> > > > > by itself.
> > > > 
> > > > Thierry, are you OK with this change?
> > > 
> > > I would've preferred tegra_powergate_sequence_power_up() to be used
> > 
> > I don't think the current tegra_powergate_sequence_power_up() API is very well
> > defined though. I don't think the clocks and resets required by the sequence
> > should be provided by the driver. For one, there can be several clocks and
> > resets that need to be controlled for a single domain.
> 
> Do you have any suggestions for what the API should look like? Even if
> we plan to move to some different API, I think there's some advantage in
> using it consistently if for no other reason than to make it easier to
> replace occurrences later on.
> 

I think the API should only have the domain ID as input so:

int tegra_powerdomain_on(int id) 

/*
 * Prerequisites: domain is off
 * Result: domain is on, clocks of the modules in the domain are off, modules are in reset
 */

int tegra_powerdomain_off(int id)

/*
 * Prerequisites: all clocks of the modules in the domain are off
 * result: domain is off
 */

Cheers,

Peter/
