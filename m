From: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [PATCHSET] libata: PATA driver for Celleb
Date: Thu, 15 Feb 2007 13:11:40 -0600
Message-ID: <20070215191140.GX923@austin.ibm.com>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp> <200702151141.49708.jens@de.ibm.com> <20070215171414.GU923@austin.ibm.com> <200702151909.26082.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:50167 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030696AbXBOTLp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Feb 2007 14:11:45 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1FJBhG3027378
	for <linux-ide@vger.kernel.org>; Thu, 15 Feb 2007 14:11:43 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l1FJBg15211642
	for <linux-ide@vger.kernel.org>; Thu, 15 Feb 2007 14:11:42 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l1FJBfNP014375
	for <linux-ide@vger.kernel.org>; Thu, 15 Feb 2007 14:11:42 -0500
Content-Disposition: inline
In-Reply-To: <200702151909.26082.arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jens Osterkamp <jens@de.ibm.com>, linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, paulus@samba.org, Andrew Morton <akpm@linux-foundation.org>, alan@lxorguk.ukuu.org.uk, James K Lewis <jim@jklewis.com>

On Thu, Feb 15, 2007 at 07:09:25PM +0100, Arnd Bergmann wrote:
> On Thursday 15 February 2007 18:14, Linas Vepstas wrote:
> > > Linas has done a pretty good job on improving the driver in the last half
> > > year or so and he also has access to all the necessary hardware so I think
> > > he would be the right person for the job.
> > 
> > It seems I've been nominated twice. Since I'm expecting future activity
> > to drop to zero, how hard can this be? :-)
> 
> I fear that the hardest part is yet to come, 

Well, then, its a good thing I put a smiley face at the end of the
sentence, eh?

> when we integrate the
> driver for the the PS3 (currently called gelic_net) into spidernet.
> The trouble is that the hardware is sufficiently similar to share
> all the high-level mechanisms like the DMA data structures and
> descriptor chains, but the low-level mechanisms are hidden in the
> hypervisor on the PS3. Someone will have to invest a significant
> amount of time coordinating this so we don't break celleb and qs20
> in the process.

Since I've got the driver more or less memorized, I don't expect this
to be an intellectual challenge. Which sometimes has the side effect
of my getting bored, and dropping things on the floor.

> I also think that you'd do a good job doing this, but it may be
> more that what you are willing to do without official funding of the
> time you spend on it. 

(Ardnt knows that my spidernet work is "moonlighting", off-the-books 
work.)  I'll ask my employer.

> Of course the actual amount of work will
> depend a lot on the quality of the spidernet patches coming from
> Sony to the spidernet maintainer.

I guess I'll have to ask my employer for a ps3 that I can do 
some "research" on.

--linas
