From: Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH 0/3] ata: add m68k/Atari Falcon PATA support
Date: Fri, 27 Jan 2017 17:28:20 +1300
Message-ID: <a524b8e2-b7ea-482d-f62c-b0460e852a8b@gmail.com>
References: <CGME20161230140139epcas5p160eda5a6a77be084e21f12002c85cc2a@epcas5p1.samsung.com>
 <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com>
 <CAOmrzkJP6s34DPOHd4OFFx=CXko35Kt=CfeDZthOPvKDJy-9YA@mail.gmail.com>
 <3939493.HXZ6C33pKV@amdc3058>
 <CAOmrzkJfQu6PuCpyyRJL8PNvSYxYO42F-k8jEYf2d1-5C28A_A@mail.gmail.com>
 <alpine.LNX.2.00.1701111053340.22260@nippy.intranet>
 <c55cb48c-7200-9577-974b-3c080e141907@gmail.com>
 <alpine.LNX.2.00.1701151046500.352@nippy.intranet>
 <a637f52e-d70a-4b10-3998-9db5c2534d83@gmail.com>
 <alpine.LNX.2.00.1701151541230.7981@nippy.intranet>
 <b1b409e0-9243-83a6-8379-50f933c97477@gmail.com>
 <alpine.LNX.2.00.1701211805050.18276@nippy.intranet>
 <1585626b-5642-3e42-2d40-52fae49c9e59@gmail.com>
 <alpine.LNX.2.00.1701261944160.23370@nippy.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36236 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753612AbdA0E3R (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2017 23:29:17 -0500
In-Reply-To: <alpine.LNX.2.00.1701261944160.23370@nippy.intranet>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org, Linux/m68k <linux-m68k@lists.linux-m68k.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Andreas Schwab <schwab@linux-m68k.org>

Hi Finn,


Am 26.01.2017 um 21:47 schrieb Finn Thain:

>> I hadn't considered that. Can PDMA for Falcon SCSI coexist with 
>> interrupt-using DMA for TT SCSI in the same driver (i.e. as runtime 
>> options)?
> 
> Sure, why not?
> 
>> How much overhead and latency would polling for DMA completion add?
>>
> 
> A polled DMA transfer should be faster than PDMA (i.e. mac_scsi, g_NCR5380 
> etc). mac_scsi gets about 0.5 MBps from PDMA with sg_tablesize == 1, and I 
> hope that DMA could get twice that (notwithstanding dumb hardware design). 

DMA contends with the processor use of the data bus but that's true for
many DMA designs. Don't think Atari made any more dumb decisions (the
opaque DMA FIFO is probably the worst feature there but that could be
worked around at considerable expense by programming the DMA and the
SCSI bus transfer for one additional 512 byte block. Let's not go there.)

> This would imply CPU overhead that is half of that which mac_scsi incurs. 
> That's the best case, but I see no reason to expect worse performance than 
> PDMA gets.

But how much more overhead would we have compared to using the SCSI
interrupt to signal DMA completion?

>> atari_irq_pending(IRQ_MFP_FSCSI) should show the interrupt pending 
>> condition if you want to poll for it.
> 
> The difficulty will be arranging for disabled FDC & IDE interrupt sources 
> during SCSI DMA, and disabled SCSI & IDE interrupt sources during FDC DMA. 
> (Not all 5380 interrupts can be disabled; no idea about the IDE device or 
> WD1772 FDC.)
> 
> But if that is impossible, we just have to detect the short DMA that might 
> result from an undesired interrupt.

I think that's infeasible - IDE interrupts could be disabled at disk
level as Geert suggests but I don't think there is a kernel API for
other drivers to do so?

At the IRQ controller level, it's all or none due to the wired-OR design
as you pointed out in the reply to Geert's mail.

>> That's actually given me another idea to pursue - if we can ensure the 
>> IDE interrupt handler is always run first,
> 
> There are no interrupts from the ATA driver you're testing, right? If you 
> would re-introduce them, the whole polled DMA idea is moot.

The libata driver currently does disable the IDE interrupt and uses
polling, but I'd like to change that if at all possible. Sorry I didn't
make that clear.

As far as I could see during my testing, the current libata driver
coexists just fine with interrupt driven SCSI operation. I've once seen
a 'lost arbitration' message in the very first test when loading the
SCSI driver, but that's not been repeated. No problems seen otherwise.

>> If we manage to separate interrupt sharing from DMA access locking, IDE 
>> would not need to take part in the locking. I'm assuming that IDE can 
>> cope with spurious interrupts and won't get confused by a SCSI 
>> interrupt.
>>
> 
> The ATA driver will never have to cope with a spurious interrupt under my 
> simplifying assumptions discussed earlier, so the spurious interrupt 
> question seems to belong to some alternative approach...

I was assuming IDE could have interrupts reenabled in libata for that
discussion.

>> I think it could work both ways - polling for DMA completion or avoiding 
>> to call the SCSI interrupt handler the interrupt was caused by IDE only. 
>> But it's indeed time to put that to the test.
>>
> 
> ... "Both ways"? I don't follow. I don't see how IDE can share the FDC and 
> SCSI interrupt line without sharing the stdma.c locking scheme. What is 
> the alternative approach (i.e not polled DMA) that you alude to?

Since IDE does not use the ST-DMA and does not share any registers with
ST-DMA, peeking at the IDE status register in order to decide whether
the interrupt was raised by the IDE interface won't hurt the running DMA
process (regardless of whether FDC or SCSI started it). Nor will
servicing the IDE interrupt.

If at the end of the IDE interrupt processing the interrupt status is
cleared in the IDE interface, the interrupt line should go high again
before the IDE inthandler returns.

If we can ensure that the FDC/SCSI interrupt handler runs after the IDE
handler, we can then make that handler check the interrupt line status
and bail out if there's nothing to be done. (For the sake of simplicity,
this check can be done in stdma_int() since we need to retain mutual
locking of the DMA interface by SCSI and FDC anyway.) We can ensure the
IDE interrupt is called first by using a special interrupt controller to
register separate IDE and FDC/SCSI interrupts with (I've done that to
provide distinct interrupt numbers and handlers for the timer D
interrupt that's used to poll ethernet and USB interface status on the
ROM port).

That way, we can ensure IDE interrupts do not step on the ST-DMA state,
and all that remains are premature SCSI interrupts terminating DMA
transfer (which we already face anyway).

Am I missing a potential race here? Does IDE send the next request off
to the disk from inside the interrupt handler so we could see IDE
immediately raise the next interrupt?  In that case, we'd also need to
check the IDE interrupt status in the interface status register, and
bail out for another pass through the IDE/FDC/SCSI handlers until IDE is
no longer posting an interrupt...

Cheers,

	Michael
