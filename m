From: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with
 SSD
Date: Mon, 26 Oct 2009 07:30:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0910260717290.21316@hs20-bc2-1.build.redhat.com>
References: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com>
 <200910212139.24675.bzolnier@gmail.com> <20091021.174155.44894825.davem@davemloft.net>
 <Pine.LNX.4.64.0910231031200.324@hs20-bc2-1.build.redhat.com>
 <4AE21706.2080906@ru.mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41179 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755628AbZJZLa4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Oct 2009 07:30:56 -0400
In-Reply-To: <4AE21706.2080906@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: David Miller <davem@davemloft.net>, bzolnier@gmail.com, linux-ide@vger.kernel.org, elendil@planet.nl

>   Are you sure? Anyway, there's no need as we're reading the interrupt bits
> CFR/ARTTIM23 registers first (at least in the IDE code). Look at the
> cmd*_test_irq() methods and ide_intr().

Maybe the BMIDE status bit is just the same as CFR/ARTTIM23 interrupt bit.

> > there is an unexpected interrupt on the inactive channel --- this should be
> > much more safe than reading the status register. If there is an interrupt,
> > then
> > --- read the status of the inactive channel? (potential data corruption, but
> > it is reported to happen only on boot).
> > --- Or can the interrupt be acknowledged only in BM-status without touching
> > the device? I believe yes,
> 
>   And I believe no. BMIDE status bit doesn't acknoledge (clear, to be precise)
> the IDE interrupts, only the status register read does.

There are two things: IDE interrupt line set by the device (BMIDE status 
doesn't do anything with it) and chipset's INT[A-D] interrupt line --- and 
BMIDE status should clear it, at least for some chipsets.

Some chipset documentation (not for CMD64x) thatI have says that BMIDE 
irq status is set on any interrupt regardless if it's DMA or NONDMA.

On ICH SATA (in legacy non-AHCI mode), it is even required to acknowledge 
PIO interrupts with BMIDE status, otherwise the interrupt stays pending.

> > it shoud shut the PCI interrupt but it would leave the IDE interrupt line on
> > (should be cleared on next command).
> >   
> 
>    I think the negated wired-OR of both INTRQ signals serves as an -INTA
> source, not the BMIDE status bits. At least in the general case, where the
> BMIDE status doesn't reflect PIO mode interrupts.

It is not as simple, INTA and BMIDE status must be postponed until the 
chip flushes its buffers and writes the DMA last byte to the memory.

I agree with you that for some chipsets BMIDE doesn't have to be signalled 
in PIO mode --- but remember that here we are talking about dealing with 
broken devices that set the interrupt line spuriously and about 
serializing chipsets --- not about all chipsets and all devices.

So the best that can be done for such broken devices is to try to shut the 
interrupt in BMIDE register (or PCI registers in CMD64x). There is nothing 
better to do. If you have serializing chipset that doesn't let you shut 
interrupt and the inactive device fires spuriously --- there is absolutely 
nothing that can be done about it.

Mikulas
