From: Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH 0/3] ata: add m68k/Atari Falcon PATA support
Date: Mon, 23 Jan 2017 21:04:50 +1300
Message-ID: <1585626b-5642-3e42-2d40-52fae49c9e59@gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33773 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbdAWIFB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jan 2017 03:05:01 -0500
In-Reply-To: <alpine.LNX.2.00.1701211805050.18276@nippy.intranet>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org, Linux/m68k <linux-m68k@lists.linux-m68k.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Andreas Schwab <schwab@linux-m68k.org>

Hi Finn,

Am 21.01.2017 um 20:37 schrieb Finn Thain:

>> The MFP interrupt in question is the same as the one used by IDE 
>> (wired-OR of IDE, FDC and SCSI), so we would still have to figure out 
>> where the interrupt originated.
> 
> I thought you said the driver you're testing does not use any interrupt -- 
> I was assuming that only atari_scsi and ataflop drivers share the 
> interupt.

My mistake - I was considering options to allow IDE to share the
interrupt, without the complexities of the old locking scheme.

> 
>> Polling instead of taking the interrupt does not change that fundamental 
>> problem (unless I'm missing something).
>>
> 
> Actually, the fundamental problem you are describing is partly solved. By 
> polling for DMA completion with local irqs disabled, we mostly avoid the 
> need for the stdma.c "lock" because FDC/SCSI/IDE interrupt handlers can 
> never interfere with a FDC/SCSI DMA process that might be underway.

I hadn't considered that. Can PDMA for Falcon SCSI coexist with
interrupt-using DMA for TT SCSI in the same driver (i.e. as runtime
options)? How much overhead and latency would polling for DMA completion
add?

>> Maybe the DMA address register can be used to check for DMA completion 
>> ... it's used to check for residual or lost bytes anyway so that appears 
>> to work. And the FDC driver does use the same strategy to check if 
>> enough track data have been read.
>>
>> Leaves the case where DMA hasn't completed but may have been aborted by 
>> a NCR5380 interrupt. I suppose we can detect that by checking for any 
>> change in the DMA address while repeatedly reading the DMA address 
>> register. No change means the DMA has got stuck. Not exactly pretty but 
>> all I can come up with.
>>
> 
> We don't have to poll any DMA registers (and I don't believe that it is 
> viable to do so). I was talking about polling for end of DMA by polling 
> for the interrupt (as per docs) but with local irqs disabled for the 
> duration of the transfer (which provides exlusive access to the DMA chip).

atari_irq_pending(IRQ_MFP_FSCSI) should show the interrupt pending
condition if you want to poll for it. That's actually given me another
idea to pursue - if we can ensure the IDE interrupt handler is always
run first, and check whether the interrupt is still pending when the
SCSI or floppy interrupt handler runs and DMA has been in progress, we
should be able to avoid calling the respective handlers unnecessarily.

(The output of atari_irq_pending() does not directly reflect the status
of the MFP IRQ inputs - that would require testing bits in
st_mfp.par_dt_reg instead. )

> I don't think the IDE/ATA driver needs to be included. atari_scsi and 
> ataflop would though (if both drivers need DMA transfers).

If we manage to separate interrupt sharing from DMA access locking, IDE
would not need to take part in the locking. I'm assuming that IDE can
cope with spurious interrupts and won't get confused by a SCSI interrupt.

>>> For example, the 5380 SCSI bus reset interrupt is not maskable, which 
>>> could affect FDC transfers. If this terminated the polling for DMA 
>>> completion, the FDC driver then has to access the FDC registers and 
>>> confirm that the transfer was not terminated early.
>>>
>>
>> We'll have to make sure FDC and SCSI don't clash in their DMA and 
>> interrupt use.
>>
> 
> The point I was trying to make above is that stdma lock only gets you so 
> far: if SCSI or FDC generate an interrupt that can't be disabled, it could 
> mess up the interrupt polling (and the interrupt polling is a necessary 
> consequence of IDE operating without stdma lock). This would lead to a 
> short transfer (which could be easily detected).

Point taken - that problem still remains but is already being detected
(though not properly handled IIRC),

> So the chips clash in their interrupt line use (rarely). The drivers need 
> not clash at all.
> 
> Anyway, we seem to be talking past each other somewhat. I suggest we start 
> coding and discuss actual patches ... unless you can convince me that this 
> won't work ...

I think it could work both ways - polling for DMA completion or avoiding
to call the SCSI interrupt handler the interrupt was caused by IDE only.
But it's indeed time to put that to the test.

Cheers,

	Michael
