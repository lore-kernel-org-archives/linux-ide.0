From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: linux-next: Tree for Oct 11 (ata/pata_of_platform.c)
Date: Thu, 10 Nov 2011 14:25:39 +0000
Message-ID: <20111110142539.2d49a62e@lxorguk.ukuu.org.uk>
References: <20111011201127.455df266dcbffb1d621f8576@canb.auug.org.au>
	<4E94A920.40503@xenotime.net>
	<4E987829.3080104@xenotime.net>
	<20111110135703.GA23609@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60055 "EHLO
	earthlight.etchedpixels.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752220Ab1KJOZl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Nov 2011 09:25:41 -0500
In-Reply-To: <20111110135703.GA23609@elte.hu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Anton Vorontsov <avorontsov@ru.mvista.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>

O> > > drivers/ata/pata_of_platform.c:55:13: error: 'NO_IRQ' undeclared (first use in this function)
> > 
> > 
> > [adding Author: Anton]
> > 
> > Build error still present in linux-next of 20111014.
> 
> This build failure regression report was ignored twice and then 
> pushed upstream and is still unfixed a month after the initial 
> report. Upstream now fails to build on like 25% of x86 configs.
> 
> What's going on with this bug guys?

As I've said before the driver shouldn't be trying to use "NO_IRQ", Not
having an irq is 0 as in if (!dev->irq)

