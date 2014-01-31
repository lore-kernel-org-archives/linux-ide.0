From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 2/3] ata: sata_mv: fix disk hotplug for Armada 370/XP
 SoCs
Date: Fri, 31 Jan 2014 11:54:10 +0100
Message-ID: <20140131115410.557cf050@skate>
References: <1389711007-7239-1-git-send-email-simon.guinot@sequanux.org>
	<1389711007-7239-3-git-send-email-simon.guinot@sequanux.org>
	<20140126083210.2998ef12@skate>
	<20140131104643.GC10250@kw.sim.vm.gnt>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20140131104643.GC10250@kw.sim.vm.gnt>
Sender: stable-owner@vger.kernel.org
To: Simon Guinot <simon.guinot@sequanux.org>
Cc: Jeff Garzik <jgarzik@redhat.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Dear Simon Guinot,

On Fri, 31 Jan 2014 11:46:44 +0100, Simon Guinot wrote:

> > > +	/*
> > > +	 * To allow disk hotplug on Armada 370/XP SoCs, the PHY speed must be
> > > +	 * updated in the LP_PHY_CTL register.
> > > +	 */
> > > +	if (pdev->dev.of_node &&
> > > +		of_device_is_compatible(pdev->dev.of_node,
> > > +					"marvell,armada-370-xp-sata"))
> > 
> > Testing whether pdev->dev.of_node is not NULL does not seems to be
> > useful. A quick read of of_device_is_compatible() and the function it's
> > calling seem to indicate that of_device_is_compatible will return false
> > if the passed struct device_node * is NULL.
> 
> I see.
> 
> It seems to me, you already have a patch ready to send. Isn't it ?
> Or do you want me to do the update ?

I see that your patches have been merged, so I will send followup fixes.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
