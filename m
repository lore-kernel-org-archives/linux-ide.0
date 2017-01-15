From: Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH 0/3] ata: add m68k/Atari Falcon PATA support
Date: Sun, 15 Jan 2017 14:48:28 +1300
Message-ID: <a637f52e-d70a-4b10-3998-9db5c2534d83@gmail.com>
References: <CGME20161230140139epcas5p160eda5a6a77be084e21f12002c85cc2a@epcas5p1.samsung.com>
 <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com>
 <CAOmrzkJP6s34DPOHd4OFFx=CXko35Kt=CfeDZthOPvKDJy-9YA@mail.gmail.com>
 <3939493.HXZ6C33pKV@amdc3058>
 <CAOmrzkJfQu6PuCpyyRJL8PNvSYxYO42F-k8jEYf2d1-5C28A_A@mail.gmail.com>
 <alpine.LNX.2.00.1701111053340.22260@nippy.intranet>
 <c55cb48c-7200-9577-974b-3c080e141907@gmail.com>
 <alpine.LNX.2.00.1701151046500.352@nippy.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35249 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbdAOBsj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 14 Jan 2017 20:48:39 -0500
In-Reply-To: <alpine.LNX.2.00.1701151046500.352@nippy.intranet>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org, Linux/m68k <linux-m68k@lists.linux-m68k.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Andreas Schwab <schwab@linux-m68k.org>

Hi Finn,

Am 15.01.2017 um 12:47 schrieb Finn Thain:

> For the sake of discussion, I'll assume that the FDC driver will not
> be using DMA. (Perhaps FDC and SCSI can share the ST-DMA chip, using
> the present locking mechanism, but it would not simplify things much:
> when IDE no longer participates in that locking mechanism then both
> FDC and SCSI drivers have to solve the same issues.)

Correct - IIRC the FDC registers are also accessible 'through' the
ST-DMA registers only so the same problem WRT DMA status arises.


> What compiler are you using, BTW? Are you still using the gcc-4.6.3
> m68k cross-compiler from kernel.org? I had to abandon it in order to
> get my SCSI driver patches to work.

4.6.3 is the version I still use. You had trouble with that one? I
recall some discussion on gcc versions on the m68k list a while back,
just never seemed to see any problems...

>> I need to think about that some more - if no DMA is in progress we
>> can safely peek at the SCSI registers. So the logic could be
>> changed to test for DMA operation first, and just try and service
>> the interrupt if DMA wasn't active.
>> 
> 
> OK, so based on the above, we handle the possible IDE interrupt
> (without checking DMA registers), handle the possible FDC interrupt
> (again without checking DMA registers) and finally handle the
> possible SCSI interrupt.

No, we can't check either FDC or SCSI interrupts (or indeed any chip
registers) without touching the ST-DMA. The moment we select a FDC or
SCSI register for read, DMA is terminated no questions asked.

> The core 5380 driver knows whether or not it has started a DMA. The 
> atari_scsi driver also knows that no other Falcon driver uses DMA. So
> the atari_scsi handler only has to figure out whether the interrupt
> was asserted by the ST-DMA chip or the 5380 chip, or neither. (The
> "neither" possility arises when IDE ditches the the stdma.c lock
> mechanism.)
> 
> Without the stdma.c lock, any or all of these interrupts could be
> asserted simultaneously, so the IDE and FDC drivers need to be able
> to do the right thing in the presence of the other interrupts and do
> so without accessing the ST-DMA chip. And the SCSI interrupt handler
> needs to do the right thing when there is no DMA interrupt, and yet a
> DMA is running.

Again, whenever DMA was running (and it might still be), we have to stop
it in order to look at FDC or SCSI registers. Utter braindamage, but

> Perhaps we could reverse the algorithm in scsi_falcon_intr(): if 
> NCR5380_intr() completes with IRQ_HANDLED and the core 5380 driver is
> no longer in DMA, then check the ST-DMA registers for errors etc.
> 
> Alternatively, if NCR5380_intr() returns IRQ_NONE, then do nothing at
> all, on the basis that the interrupt was handled by FDC or IDE.

We may only call NCR5380_intr() if DMA hadn't been active (or we are
sure it's completed, i.e. transfer address == end address. If that's
even possible). If the DMA is still ongoing, we have the choice of
punting (hoping for a command timeout to happen and clean up the mess),
or terminate DMA (by selecting the SCSI chip registers instead of the
DMA ones) and deal with the fallout.

> In this situation, I gather that atari_scsi could miss out on a DMA
> completion interrupt from the ST-DMA chip, which could lead to
> command timeout?

Doing nothing if DMA is enabled (and IDE had successfully handled an
interrupt!) would cause us to miss a stacked interrupt, yes. Timeout
would likely ensue. Not sure it's wise to kludge around that using a
watchdog timer activated in case we're not sure of the DMA completion
state...

> 
>> If DMA has been in progress, I'm not sure that we can figure out if
>> it's still active from looking at the status register (that is,
>> whether bits 0 or 1 are set while DMA is ongoing). We'd have to
>> peek at the DMA status register (or DMA address registers) without
>> first stopping DMA, which the current driver does. The docs seem to
>> advise against that. If DMA was in progress, stopping it would
>> likely leave us with residual bytes to be transferred -
> 
> I can't comment on the Profibuch doc or the ST-DMA chip details
> (Andreas?)
> 
> I suspect it has to be tried.

Yes, I fear I'll have to just try what happens if SCSI and IDE raise an
interrupt at the same time.

For now, polled IDE might be working well enough (haven't seen a huge
impact in IDE-only test workloads, I'll have to check impact on lots of
seeks across the whole disk a lot harder though). I need to recheck the
old IDE driver with my current combined test workload though (my second
4 GB Seagate disk has finally kicked the bucket, after the latest power
brownout).

> 
>> we'd have to handle that transfer as we would any other DMA error
>> (from memory, probably best to retry the entire command, or
>> transfer the remaining bytes using PIO if we're sure no bytes have
>> been lost).
>> 
> 
> Allowing the command to fail should be fine so long as the 5380
> driver sends the correct result code to the mid-layer. To attempt to
> complete the command after a failed DMA is needless complexity, and
> it's a trick that probably can't be pulled off reliably anyway.

Yep, we've been there before (when my CT60 caused SCSI DMA errors and
lost bytes). Not sure anymore what the correct result code was...

Cheers,

	Michael
