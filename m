From: Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH 0/3] ata: add m68k/Atari Falcon PATA support
Date: Wed, 1 Feb 2017 19:40:30 +1100 (AEDT)
Message-ID: <alpine.LNX.2.00.1701271858100.368@nippy.intranet>
References: <CGME20161230140139epcas5p160eda5a6a77be084e21f12002c85cc2a@epcas5p1.samsung.com> <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com> <CAOmrzkJP6s34DPOHd4OFFx=CXko35Kt=CfeDZthOPvKDJy-9YA@mail.gmail.com> <3939493.HXZ6C33pKV@amdc3058>
 <CAOmrzkJfQu6PuCpyyRJL8PNvSYxYO42F-k8jEYf2d1-5C28A_A@mail.gmail.com> <alpine.LNX.2.00.1701111053340.22260@nippy.intranet> <c55cb48c-7200-9577-974b-3c080e141907@gmail.com> <alpine.LNX.2.00.1701151046500.352@nippy.intranet> <a637f52e-d70a-4b10-3998-9db5c2534d83@gmail.com>
 <alpine.LNX.2.00.1701151541230.7981@nippy.intranet> <b1b409e0-9243-83a6-8379-50f933c97477@gmail.com> <alpine.LNX.2.00.1701211805050.18276@nippy.intranet> <1585626b-5642-3e42-2d40-52fae49c9e59@gmail.com> <alpine.LNX.2.00.1701261944160.23370@nippy.intranet>
 <a524b8e2-b7ea-482d-f62c-b0460e852a8b@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:52632 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbdBAIjO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Feb 2017 03:39:14 -0500
In-Reply-To: <a524b8e2-b7ea-482d-f62c-b0460e852a8b@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org, Linux/m68k <linux-m68k@lists.linux-m68k.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Andreas Schwab <schwab@linux-m68k.org>


On Fri, 27 Jan 2017, Michael Schmitz wrote:

> Am 26.01.2017 um 21:47 schrieb Finn Thain:
> 
> > This would imply CPU overhead that is half of that which mac_scsi 
> > incurs. That's the best case, but I see no reason to expect worse 
> > performance than PDMA gets.
> 
> But how much more overhead would we have compared to using the SCSI 
> interrupt to signal DMA completion?
> 

I imagine that contention for the CPU bus would be a problem if we polled 
the interrupt flag without any delay between iterations. With a small 
delay I think the overhead would be comparable with PDMA and therefore 
tolerable.

> The libata driver currently does disable the IDE interrupt and uses 
> polling, but I'd like to change that if at all possible. Sorry I didn't 
> make that clear.
> 

[snip]

> Since IDE does not use the ST-DMA and does not share any registers with 
> ST-DMA, peeking at the IDE status register in order to decide whether 
> the interrupt was raised by the IDE interface won't hurt the running DMA 
> process (regardless of whether FDC or SCSI started it). Nor will 
> servicing the IDE interrupt.
> 

Maybe we can just call the IDE handler from the ST-DMA handler regardless 
of the status register. For a shared interrupt handler this should work 
okay. (BTW, where is the IDE status register found anyway?)

> If at the end of the IDE interrupt processing the interrupt status is 
> cleared in the IDE interface, the interrupt line should go high again 
> before the IDE inthandler returns.
> 

On page 2 of the schematic, MFP pin I5 is wired to the output of the 
logical OR combination of the IDEIRQ and XDISKINT signals (actually 
active-low signals fed into an AND gate). The pin is edge-triggered.

This is just like the wired-OR Nubus slot IRQs connected to the Mac's VIA 
pin. The handler must ack all asserted IRQs. Otherwise there will be no 
more edges and no more interrupts.

This means looping over the IDE, FDC/SCSI DMA handlers until they all 
return IRQ_NONE. (Or equivalently, looping over the IRQ flags in the 
device registers until they are all de-asserted.)

BTW, this makes me think that the stdma.c mechanism is already flawed, 
since stdma_int() can cause only one of IDEIRQ and XDISKINT to become 
inactive, but not both. That's fine as long as no device raises IRQ until 
it's driver acquires the stdma lock -- but we know this is not true for 
the 5380 bus reset interrupt and it isn't true for IDE devices either 
(based on Geert's email in this thread).

> If we can ensure that the FDC/SCSI interrupt handler runs after the IDE 
> handler, we can then make that handler check the interrupt line status 
> and bail out if there's nothing to be done. (For the sake of simplicity, 
> this check can be done in stdma_int() since we need to retain mutual 
> locking of the DMA interface by SCSI and FDC anyway.)
> 
> We can ensure the IDE interrupt is called first by using a special 
> interrupt controller to register separate IDE and FDC/SCSI interrupts 
> with (I've done that to provide distinct interrupt numbers and handlers 
> for the timer D interrupt that's used to poll ethernet and USB interface 
> status on the ROM port).
> 
> That way, we can ensure IDE interrupts do not step on the ST-DMA state, 
> and all that remains are premature SCSI interrupts terminating DMA 
> transfer (which we already face anyway).
> 
> Am I missing a potential race here? Does IDE send the next request off 
> to the disk from inside the interrupt handler so we could see IDE 
> immediately raise the next interrupt?  In that case, we'd also need to 
> check the IDE interrupt status in the interface status register, and 
> bail out for another pass through the IDE/FDC/SCSI handlers until IDE is 
> no longer posting an interrupt...
> 

I don't know anything about IDE so I can't comment on this particular 
scenario (IDE interrupt handler causing IDE interrupt). The race condition 
may be only theoretical.

What you seem to be aiming at is an algorithm to ensure that no DMA 
interrupt is handled whilst an IDE interrupt is pending. Taking into 
account the logical OR issue, one could imagine a handler for the 
IRQ_MFP_FSCSI interrupt something like the following. (This code is 
probably useless for implementing your interrupt controller, but I hope it 
illustrates some of the issues.)

	do {
		handled = ata_handler(irq, ata_dev);
		if (handled == IRQ_NONE && atari_irq_pending(IRQ_MFP_FSCSI))
			handled |= stdma_int(irq, stdma_dev);
	} while (handled != IRQ_NONE);

Clearly this is not free from race conditions. The other problem is the 
use of atari_irq_pending(IRQ_MFP_FSCSI). It tells us when an edge appears 
but doesn't tell us about the present state of the IRQ output pins on the 
NCR5380 or the WD1772. We can't access the device registers so 
st_mfp.par_dt_reg & BIT(5) must be used instead of 
atari_irq_pending(IRQ_MFP_FSCSI);

The simplest approach is to treat it like a shared interrupt, with a loop 
to account for the logical OR:

	do {
		handled = ata_handler(irq, ata_dev) | 
		          scsi_falcon_intr(irq, scsi_dev) |
		          fdc_handler(irq, fdc_dev);
	} while (handled != IRQ_NONE);

This should work fine with polled DMA (and might even allow the flawed 
stdma.c lock mechanism to be eliminated) but it can't work with your 
scheme because scsi_falcon_intr() assumes exclusive access to the IRQ; 
hence it must not be called unless there is an actual 5380 or DMA 
interrupt.

I don't know which scheme is better. Mine is simpler and probably free of 
race conditions but does burn some CPU time. Your scheme is more 
complicated.

-- 

> Cheers,
> 
> 	Michael
> 
