From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: How to cleanly setup legacy IDE irq ?
Date: Mon, 04 Oct 2004 11:05:40 +1000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1096851939.9516.53.camel@gaston>
References: <1096602694.11460.29.camel@gaston>
	 <200410032254.16900.bzolnier@elka.pw.edu.pl>
	 <1096846969.9516.39.camel@gaston>
	 <200410040227.14513.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:54467 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268330AbUJDBKT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Oct 2004 21:10:19 -0400
In-Reply-To: <200410040227.14513.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

On Mon, 2004-10-04 at 10:27, Bartlomiej Zolnierkiewicz wrote:

> > Then you'll have a ton of
> > 
> > #ifdef CONFIG_****
> > 	if (machine == blablabla)
> > 		irq = something;
> > #endif
> > #if CONFIG_****
> > 	irq = something else
> > #endif
> > 
> > and that sort of thing all over drivers... stinks as well.
> 
> Actually it is fine with me.  I find it very informative. :)
> Also host driver specific code is where is should belong.

Ugh ? damn, that's a textboot example of crappy code ! You are
putting interrupt routing platform knowledge in non-platform specific
drivers, that is disgusting !

> > > Also what happens when one architecture can use two different
> > > drivers both needing different legacy IRQs?
> > 
> > The port number will let the platform decide.
> 
> What do you mean by "the port number"? hwif->index?
> In this situation both drivers have to be compiled in
> (no modules because they change ordering) and probing 
> order must be strictly ordered (ie. if non-PCI controllers
> possible) or wrong IRQs will be set.
> 
> Do you suggest that we should stick to legacy ordering instead
> of going in the direction of user-space solutions (udev)?

Nooooo, not at all... We are in a case where a controller that
was detected (we know the port numer / mmio address, the hwif
is almost fully setup already, only the interrupt number is missing).

Eventually, call it

  ide_get_pci_legacy_irq(pdev, channel);

That would make it even clearer.... It's just an arch helper to ask
for the interrupt routing of a known PCI host that happens to be
in "legacy" mode (and thus relies on platform specific interrupt
routing and does not respect normal PCI stuff).

> dynamic objects, sysfs (add your wishlist here)
> 
> ide_defualt_irq() is not the main problem here
> (ide_init_default_hwifs() is) but I would prefer
> not to unobsolete it.

I agree. The old callback stuff for setting up the whole legacy
interfaces has to go. I'm not talking about that. I'm talking about the
specific case of a known PCI chip used in legacy mode looking for an
interrupt.

I agree that setting up "legacy" controllers or controllers at
various random ports requires a specific driver.

In this case, this is an existing driver that works on all platforms
that do PCI, _but_ which happen to have been set to legacy mode by the
HW strapping or the firmware (unfortunately, some can't be changed back)
and thus requires some platform specific IRQ routing informations (ok,
I'm getting redundant here :)

> > very clearly defined setup: a PCI controller with an existing driver
> > that is in legacy mode asking the arch for it's irqs.
> 
> If this is going to be limited to this single case - PCI device
> in legacy mode asking for IRQ it makes sense (as long as it
> doesn't need to include <linux/ide.h>) otherwise rather not.
> 
> Actual code showing pros/cons of both solutions should make
> it more clear which one is better (well, both may be wrong). 

Well, then what about my proposal above ?

  int ide_get_pci_legacy_irq(struct pci_dev *pdev, int channel);

(with eventually an #ifdef ARCH_HAS.....)

We could have it either called by the chipset drivers themselves, or by
the generic code when the controller is in legacy mode.



