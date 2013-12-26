From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] ata: sata_mv: setting PHY speed according to SControl
 speed
Date: Thu, 26 Dec 2013 14:34:07 +0100
Message-ID: <20131226143407.5c187277@skate>
References: <1387800455-30629-1-git-send-email-simon.guinot@sequanux.org>
	<20131224194603.GE19878@titan.lakedaemon.net>
	<20131225224034.GB5531@kw.sim.vm.gnt>
	<20131226085355.2fd1969c@skate>
	<20131226115428.GC5531@kw.sim.vm.gnt>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20131226115428.GC5531@kw.sim.vm.gnt>
Sender: stable-owner@vger.kernel.org
To: Simon Guinot <simon.guinot@sequanux.org>
Cc: Jason Cooper <jason@lakedaemon.net>, Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, stable@vger.kernel.org, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Gregory Clement <gregory.clement@free-electrons.com>, Jeff Garzik <jgarzik@redhat.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-ide@vger.kernel.org

Dear Simon Guinot,

On Thu, 26 Dec 2013 12:54:28 +0100, Simon Guinot wrote:

> > In some sense, we could say that this is not a regression. According to
> > what you mean, SATA hotplug has *never* been working on Armada 370/XP.
> > So technically, it could be seen as a new feature for this platform,
> > and is therefore not a regression (i.e something that used to work, and
> > that no longer works). There has been no kernel release for which SATA
> > hotplug was working for Armada 370/XP.
> 
> I agree with that. It is not correct to call this issue a regression.
> But, it would also be nice to have this patch applied in the stable
> branches 3.10 and onwards. Maybe, I could just add this information
> while CC'ing Linux stable ?

Yes. Even though not a regression, I believe it qualifies for -stable,
at least according to the rules in
Documentation/stable_kernel_rules.txt.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
