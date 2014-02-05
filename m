From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [Patch v4 1/3] drivers: phy: Make NULL a valid phy reference
Date: Wed, 5 Feb 2014 00:22:59 -0500
Message-ID: <20140205052259.GQ8533@titan.lakedaemon.net>
References: <1391535193-24165-1-git-send-email-andrew@lunn.ch>
 <20140205051440.GP8533@titan.lakedaemon.net>
 <52F1C9FB.4070300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20056 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbaBEFXF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Feb 2014 00:23:05 -0500
Content-Disposition: inline
In-Reply-To: <52F1C9FB.4070300@ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>, tj@kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, linux-ide@vger.kernel.org

On Wed, Feb 05, 2014 at 10:49:55AM +0530, Kishon Vijay Abraham I wrote:
> On Wednesday 05 February 2014 10:44 AM, Jason Cooper wrote:
> > Kishon,
> > 
> > On Tue, Feb 04, 2014 at 06:33:11PM +0100, Andrew Lunn wrote:
> >> The common clock framework considers NULL a valid clock
> >> reference. This makes handling optional clocks simple, in that if the
> >> optional clock is not available, a NULL reference can be used in the
> >> place of a real clock, simplifying the clock consumer.
> >>
> >> Extend this concept to the phy consumer API. A NULL can be passed to
> >> the release calls, the phy_init() and phy_exit() calls, and
> >> phy_power_on() and phy_power_off() and a NOP is performed.
> >>
> >> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> >> Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> >> ---
> >> v2
> >>  No change.
> >> v4
> >>  combine !phy and IS_ERR().
> >>  Add Tested-by
> >> ---
> >>  Documentation/phy.txt  |  6 ++++++
> >>  drivers/phy/phy-core.c | 17 ++++++++++++++++-
> >>  2 files changed, 22 insertions(+), 1 deletion(-)
> > 
> > Looking over the overall diffstat (there isn't one, Andrew, please don't
> > forget the coverletter in the future), this series is predominately
> > changing the phy subsystem.  However, since it's fixing a boot failure
> > in the arm-soc bootfarm, we'd like to get it into our tree without
> > pulling in a bunch of unnecessary changes (eg by pulling in -rc2 or
> > -rc3).
> > 
> > Could you create a topic branch with this series in it we could base off
> > of?  Or, could you Ack it so we could take it through arm-soc?
> 
> I can just ACK it so you can take it through your tree.

Thanks!

Jason.
