From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH] ata: sata_mv: setting PHY speed according to SControl
 speed
Date: Mon, 13 Jan 2014 09:36:51 -0500
Message-ID: <20140113143651.GD19878@titan.lakedaemon.net>
References: <1387800455-30629-1-git-send-email-simon.guinot@sequanux.org>
 <20131231121214.GB3985@htj.dyndns.org>
 <20131231170515.GG32537@lunn.ch>
 <EE71107DF0D1F24FA2D95041E64AB9E801C034BF2AD1@IL-MB01.marvell.com>
 <20140110174412.GJ19878@titan.lakedaemon.net>
 <20140111075557.353478fa@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140111075557.353478fa@skate>
Sender: stable-owner@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Tejun Heo <tj@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jeff Garzik <jgarzik@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Simon Guinot <simon.guinot@sequanux.org>
List-Id: linux-ide@vger.kernel.org

On Sat, Jan 11, 2014 at 07:55:57AM +0800, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Fri, 10 Jan 2014 12:44:12 -0500, Jason Cooper wrote:
> 
> > Lior, thanks for the clarification.  Simon, care to respin this with a
> > check for "marvell,armada-370-xp" root compatible string?  It should be
> > safe to say that if there is no DT, don't write the register.
> 
> Why check a root compatible string? If we do this, then we will have to
> change the SATA driver for each and every new Marvell SoC that has this
> PHY speed control register (and these new SOCs will not use the
> "marvell,armada-370-xp" root compatible string, since they are clearly
> not Armada 370/XP).
> 
> Instead, we should introduce an additional compatible string for the
> SATA driver itself.

Agreed.  

> > Alternatively, we could do as Lior suggests, and create a new sata
> > compatible string.  But I think that is overkill.
> 
> No, this is the right thing to do, IMO.
> 
> > Also, I'm growing more leery creating compatible strings for IP blocks
> > which are tied to the SoC revision.  If the IP block doesn't get issued
> > it's own version number/codename, we should just use the root compatible
> > strings to determine which SoC we are on.  I'll expand on this though as
> > I get caught up with Gregory's series's. 
> 
> I really disagree. It means that whenever a new root compatible string
> is created for a new SOC, we will have to edit gazillions of drivers.
> It's not because two SOCs have the same SATA IP that they are globally
> compatible, and can therefore share the same root compatible strings.

Yes, you're right.  I really went off the deep end on that one.  Simon,
please do as Lior and Thomas suggested.

thx,

Jason.
