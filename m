From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH] ata: sata_mv: setting PHY speed according to SControl
 speed
Date: Fri, 27 Dec 2013 10:49:57 -0500
Message-ID: <20131227154957.GK19878@titan.lakedaemon.net>
References: <1387800455-30629-1-git-send-email-simon.guinot@sequanux.org>
 <20131224194603.GE19878@titan.lakedaemon.net>
 <20131225224034.GB5531@kw.sim.vm.gnt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131225224034.GB5531@kw.sim.vm.gnt>
Sender: stable-owner@vger.kernel.org
To: Simon Guinot <simon.guinot@sequanux.org>
Cc: Lior Amsalem <alior@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, stable@vger.kernel.org, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Gregory Clement <gregory.clement@free-electrons.com>, Jeff Garzik <jgarzik@redhat.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-ide@vger.kernel.org

Simon,

On Wed, Dec 25, 2013 at 11:40:34PM +0100, Simon Guinot wrote:
> On Tue, Dec 24, 2013 at 02:46:03PM -0500, Jason Cooper wrote:
> > On Mon, Dec 23, 2013 at 01:07:35PM +0100, Simon Guinot wrote:
> > > From: Lior Amsalem <alior@marvell.com>
> > > 
> > > From: Lior Amsalem <alior@marvell.com>
> > > 
> > > This patch fixes a SATA hotplug issue on the Armada 370 and Armada XP
> > > SoCs. Without it, if a disk is unplugged from a SATA port, then further
> > > hotplug notification are now longer received on this port.
> > > 
> > > This should be applied to every -stable kernel supporting Armada SoCs.
> > 
> > Could we get a little more specific here?  Please determine which commit
> > introduced the regression and note it with 'Fixes: <commitish> "oneline"'
> 
> Well, since the DT support for the sata_mv driver precedes SATA support
> for Armada SoCs, I'd say that the bug has been introduced by:
> 
> a6a6de1a "arm: mvebu: SATA support: SoC-level DT data for Armada 370/XP"

fyi - we've started using 12 chars for the abbreviated sha1.  You can
update your config with 'git config --global core.abbrev 12'

> Let me know if you agree with that. I will update the commit message
> accorgingly.

No, I don't really agree with that.  We should try not to tie the dts
and the kernel version if at all possible.  The correct commit will be
the earliest one that can experience the regression.  I suspect it will
be the either the commit adding the DT binding to sata_mv or the commit
adding mach-mvebu.

> > It's really needed here since the sata_mv driver predates the Armada
> > SoCs introduction.  Is it possible Kirkwood et al also experience this
> > problem?
> 
> On my Orion and Kirkwood based bords, SATA disk hotplug works correctly.

Good, one less thing to worry about.

thx,

Jason.
