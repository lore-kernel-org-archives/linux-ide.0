From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: How to cleanly setup legacy IDE irq ?
Date: Mon, 04 Oct 2004 09:42:49 +1000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1096846969.9516.39.camel@gaston>
References: <1096602694.11460.29.camel@gaston>
	 <200410021656.30122.bzolnier@elka.pw.edu.pl>
	 <1096763626.3634.58.camel@gaston>
	 <200410032254.16900.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:23235 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268248AbUJCXrZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Oct 2004 19:47:25 -0400
In-Reply-To: <200410032254.16900.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

On Mon, 2004-10-04 at 06:54, Bartlomiej Zolnierkiewicz wrote:

> >   if (hwif->irq == NO_IRQ) (*)
> >       hwif->irq = ide_get_legacy_irq(hwif);
> 
> This is really bad from maintainability and sanity point of view ie.
> you change something in IDE code and then suddenly have to grep
> arch and platform specific code and worry about what these callbacks
> wanted to achieve and watch out to not break them (or more likely,
> don't know about this issue completely and break them silently :).
> With placing IRQ setup in host drivers everything is clear _immediately_.

Then you'll have a ton of

#ifdef CONFIG_****
	if (machine == blablabla)
		irq = something;
#endif
#if CONFIG_****
	irq = something else
#endif

and that sort of thing all over drivers... stinks as well.

> Also what happens when one architecture can use two different
> drivers both needing different legacy IRQs?

The port number will let the platform decide.

While I agree that the mess of callbacks we had so far was confusing at
best, I still think that a single callback for optionally letting the
arch provide the irq for controllers in legacy mode makes sense. We are
not talking about a mess of callbacks making the stuff unmaintainable,
but a single simple one. We could even add a printk when it's used to
make it easier to spot. "Legacy controller with arch provided irq %d\n"
or something like that.

> Hm, why there are no such things in other (much more successful)
> subsystems (SCSI, network) but some devices also use weird IRQs?

Most SCSI & network I've had to deal with for anything recent use _one_
irq per device, which makes things a lot easier. A lot of them are PCI,
which contains a single irq field. Other stuffs are probed in different
ways, but we tend to have an irq field around.

IDE is special in this regard, since even PCI and recent controllers end
up having this "legacy" mode that board vendors still sometimes strap
the chip in, which cause them to have IRQ on different pins than the
normal PCI interrupt of the chip.

> > Or maybe just de-obsolete one of the old "default" callbacks
> 
> grep kernel for occurrences of ide_default_irq() and then try to match
> archs/platforms/IRQs to host drivers and code which setup IRQs vs code
> which make use of it... really traumatic experience...

How so ? And why would you care anyway ? We are talking about a single
very clearly defined setup: a PCI controller with an existing driver
that is in legacy mode asking the arch for it's irqs.

> > (*) and please, don't compare with 0, 0 is a valid IRQ number on a
> > number of platforms !)
> 
> ide-probe.c heavily depends on !hwif->irq but maybe somebody
> will finally fix IDE to not use 0 to represent unknown IRQ.

It used to be fixed in ide-io.c at one point, but yes, ide-probe.c is broken.

Ben.


