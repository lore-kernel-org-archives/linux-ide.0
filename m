From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH 6/9] ARM: tegra: Export tegra_powergate_power_on
Date: Wed, 9 Jul 2014 14:20:23 +0300
Message-ID: <20140709112023.GH23218@tbergstrom-lnx.Nvidia.com>
References: <53A1B252.1030204@wwwdotorg.org>
 <20140619080234.GK3407@tbergstrom-lnx.Nvidia.com>
 <53A3096B.1040409@wwwdotorg.org>
 <20140623101441.GU3407@tbergstrom-lnx.Nvidia.com>
 <20140708130501.GC9516@ulmo>
 <20140708141135.GC23218@tbergstrom-lnx.Nvidia.com>
 <20140709063130.GA3170@ulmo>
 <20140709083311.GE23218@tbergstrom-lnx.Nvidia.com>
 <20140709102551.GA19357@ulmo>
 <1404901907.5766.3.camel@weser.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1404901907.5766.3.camel@weser.hi.pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "tj@kernel.org" <tj@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-ide@vger.kernel.org

On Wed, Jul 09, 2014 at 12:31:47PM +0200, Lucas Stach wrote:
> > 
> You could also take the easy way out and enable all power domains by
> default. So drivers won't be able to disable the power domain on old
> DTBs where they aren't hooked up, but the will continue to function
> without calling into the old Tegra specific power domain code.
> 

If the bootloader turned some domains off, the kernel would have to turn them
back on again. However that requires knowledge about the clocks and resets of
the peripherals in the domain.

Cheers,

Peter.
