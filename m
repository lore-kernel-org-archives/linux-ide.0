From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: How to cleanly setup legacy IDE irq ?
Date: Mon, 4 Oct 2004 02:27:14 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200410040227.14513.bzolnier@elka.pw.edu.pl>
References: <1096602694.11460.29.camel@gaston> <200410032254.16900.bzolnier@elka.pw.edu.pl> <1096846969.9516.39.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:64689 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S268279AbUJDA1Y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Oct 2004 20:27:24 -0400
Received: from hadron.elka.pw.edu.pl ([194.29.160.13]:55997 "EHLO localhost")
	by higgs.elka.pw.edu.pl with ESMTP id S27376AbUJDA1W (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Oct 2004 02:27:22 +0200
Received: from chello084010012196.chello.pl ([84.10.12.196]:63799 "EHLO
	[192.168.123.164]" ident: "NO-IDENT-SERVICE[2]" smtp-auth: "bzolnier"
	TLS-CIPHER: <none> TLS-PEER-CN1: <none>) by mion.elka.pw.edu.pl
	with ESMTP id S50890AbUJDAZH (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 1 other);
	Mon, 4 Oct 2004 02:25:07 +0200
In-Reply-To: <1096846969.9516.39.camel@gaston>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org

On Monday 04 October 2004 01:42, Benjamin Herrenschmidt wrote:
> On Mon, 2004-10-04 at 06:54, Bartlomiej Zolnierkiewicz wrote:
> 
> > >   if (hwif->irq == NO_IRQ) (*)
> > >       hwif->irq = ide_get_legacy_irq(hwif);
> > 
> > This is really bad from maintainability and sanity point of view ie.
> > you change something in IDE code and then suddenly have to grep
> > arch and platform specific code and worry about what these callbacks
> > wanted to achieve and watch out to not break them (or more likely,
> > don't know about this issue completely and break them silently :).
> > With placing IRQ setup in host drivers everything is clear _immediately_.
> 
> Then you'll have a ton of
> 
> #ifdef CONFIG_****
> 	if (machine == blablabla)
> 		irq = something;
> #endif
> #if CONFIG_****
> 	irq = something else
> #endif
> 
> and that sort of thing all over drivers... stinks as well.

Actually it is fine with me.  I find it very informative. :)
Also host driver specific code is where is should belong.

> > Also what happens when one architecture can use two different
> > drivers both needing different legacy IRQs?
> 
> The port number will let the platform decide.

What do you mean by "the port number"? hwif->index?
In this situation both drivers have to be compiled in
(no modules because they change ordering) and probing 
order must be strictly ordered (ie. if non-PCI controllers
possible) or wrong IRQs will be set.

Do you suggest that we should stick to legacy ordering instead
of going in the direction of user-space solutions (udev)?

> While I agree that the mess of callbacks we had so far was confusing at
> best, I still think that a single callback for optionally letting the
> arch provide the irq for controllers in legacy mode makes sense. We are
> not talking about a mess of callbacks making the stuff unmaintainable,
> but a single simple one. We could even add a printk when it's used to
> make it easier to spot. "Legacy controller with arch provided irq %d\n"
> or something like that.
> 
> > Hm, why there are no such things in other (much more successful)
> > subsystems (SCSI, network) but some devices also use weird IRQs?
> 
> Most SCSI & network I've had to deal with for anything recent use _one_
> irq per device, which makes things a lot easier. A lot of them are PCI,
> which contains a single irq field. Other stuffs are probed in different
> ways, but we tend to have an irq field around.
> 
> IDE is special in this regard, since even PCI and recent controllers end
> up having this "legacy" mode that board vendors still sometimes strap
> the chip in, which cause them to have IRQ on different pins than the
> normal PCI interrupt of the chip.
> 
> > > Or maybe just de-obsolete one of the old "default" callbacks
> > 
> > grep kernel for occurrences of ide_default_irq() and then try to match
> > archs/platforms/IRQs to host drivers and code which setup IRQs vs code
> > which make use of it... really traumatic experience...
> 
> How so ? And why would you care anyway ? We are talking about a single

dynamic objects, sysfs (add your wishlist here)

ide_defualt_irq() is not the main problem here
(ide_init_default_hwifs() is) but I would prefer
not to unobsolete it.

> very clearly defined setup: a PCI controller with an existing driver
> that is in legacy mode asking the arch for it's irqs.

If this is going to be limited to this single case - PCI device
in legacy mode asking for IRQ it makes sense (as long as it
doesn't need to include <linux/ide.h>) otherwise rather not.

Actual code showing pros/cons of both solutions should make
it more clear which one is better (well, both may be wrong). 
