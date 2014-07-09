From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 6/9] ARM: tegra: Export tegra_powergate_power_on
Date: Wed, 09 Jul 2014 12:31:47 +0200
Message-ID: <1404901907.5766.3.camel@weser.hi.pengutronix.de>
References: <20140617215119.GC24743@mithrandir>
	 <20140618121806.GJ3407@tbergstrom-lnx.Nvidia.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45978 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022AbaGIKdd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jul 2014 06:33:33 -0400
In-Reply-To: <20140709102551.GA19357@ulmo>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "tj@kernel.org" <tj@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Am Mittwoch, den 09.07.2014, 12:25 +0200 schrieb Thierry Reding:
> On Wed, Jul 09, 2014 at 11:33:11AM +0300, Peter De Schrijver wrote:
> > On Wed, Jul 09, 2014 at 08:31:32AM +0200, Thierry Reding wrote:
> > > * PGP Signed by an unknown key
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
> That then means that each such driver needs a way to figure out whether
> power domains are hooked up (which will be rather clumsy to do if it's
> all supposed to work transparently) and fallback to the legacy API
> otherwise.
> 
> So essentially we'll be adding code without the possibility to remove
> any of the old code.
> 
You could also take the easy way out and enable all power domains by
default. So drivers won't be able to disable the power domain on old
DTBs where they aren't hooked up, but the will continue to function
without calling into the old Tegra specific power domain code.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

