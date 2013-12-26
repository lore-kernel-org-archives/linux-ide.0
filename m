From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] ata: sata_mv: setting PHY speed according to SControl
 speed
Date: Thu, 26 Dec 2013 08:53:55 +0100
Message-ID: <20131226085355.2fd1969c@skate>
References: <1387800455-30629-1-git-send-email-simon.guinot@sequanux.org>
	<20131224194603.GE19878@titan.lakedaemon.net>
	<20131225224034.GB5531@kw.sim.vm.gnt>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20131225224034.GB5531@kw.sim.vm.gnt>
Sender: stable-owner@vger.kernel.org
To: Simon Guinot <simon.guinot@sequanux.org>
Cc: Jason Cooper <jason@lakedaemon.net>, Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, stable@vger.kernel.org, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Gregory Clement <gregory.clement@free-electrons.com>, Jeff Garzik <jgarzik@redhat.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-ide@vger.kernel.org

Dear Simon Guinot,

On Wed, 25 Dec 2013 23:40:34 +0100, Simon Guinot wrote:

> > > This should be applied to every -stable kernel supporting Armada
> > > SoCs.
> > 
> > Could we get a little more specific here?  Please determine which
> > commit introduced the regression and note it with 'Fixes:
> > <commitish> "oneline"'
> 
> Well, since the DT support for the sata_mv driver precedes SATA
> support for Armada SoCs, I'd say that the bug has been introduced by:
> 
> a6a6de1a "arm: mvebu: SATA support: SoC-level DT data for Armada
> 370/XP"
> 
> Let me know if you agree with that. I will update the commit message
> accorgingly.

In some sense, we could say that this is not a regression. According to
what you mean, SATA hotplug has *never* been working on Armada 370/XP.
So technically, it could be seen as a new feature for this platform,
and is therefore not a regression (i.e something that used to work, and
that no longer works). There has been no kernel release for which SATA
hotplug was working for Armada 370/XP.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
