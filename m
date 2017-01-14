From: Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH 0/3] ata: add m68k/Atari Falcon PATA support
Date: Sat, 14 Jan 2017 21:55:07 +1300
Message-ID: <c55cb48c-7200-9577-974b-3c080e141907@gmail.com>
References: <CGME20161230140139epcas5p160eda5a6a77be084e21f12002c85cc2a@epcas5p1.samsung.com>
 <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com>
 <CAOmrzkJP6s34DPOHd4OFFx=CXko35Kt=CfeDZthOPvKDJy-9YA@mail.gmail.com>
 <3939493.HXZ6C33pKV@amdc3058>
 <CAOmrzkJfQu6PuCpyyRJL8PNvSYxYO42F-k8jEYf2d1-5C28A_A@mail.gmail.com>
 <alpine.LNX.2.00.1701111053340.22260@nippy.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1701111053340.22260@nippy.intranet>
Sender: linux-kernel-owner@vger.kernel.org
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org, Linux/m68k <linux-m68k@lists.linux-m68k.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Andreas Schwab <schwab@linux-m68k.org>
List-Id: linux-ide@vger.kernel.org

Hi Finn,

Am 13.01.2017 um 15:33 schrieb Finn Thain:

>> The case I'm worried about is both IDE and SCSI raising an interrupt. We 
>> don't currently mask the IDE/ST-DMA interrupt so a stacked interrupt 
>> must be processed in the same pass as the initial interrupt or it will 
>> get dropped. We'd have to peek at the DMA registers to check the SCSI or 
>> floppy interrupt status, and we just can't safely do that. So races of 
>> this kind are currently prevented by including IDE in the IRQ locking 
>> process.
>>
>> Whether it's possible to mask the interrupt, do one pass, unmask and 
>> process the second interrupt I don't know.
> 
> Would that require handling the SCSI DMA interrupt in the first pass? Or 
> handling IDE first, and ensuring that the IDE handler does not access 
> ST-DMA registers? What about FDC?

Handling the IDE interrupt first I think, then looking at the DMA (for
SCSI or FDC).

> The atari_scsi handler accesses the ST-DMA registers; it can do so because 
> it knows that any DMA must have completed -- it can infer this because a 
> simultaneous pending interrupt from FDC or IDE is impossible due to 
> stdma_lock().

libata dropped the locking (and does not use IDE interrupts at present
so it seems to be safe. Still testing - I've seen IO errors, and that's
a bit of a worry).

> Your suggestion would seem to allow other pending interrupts, hence the 
> atari_scsi interrupt handler logic has to be tossed out. What logic would 
> replace it?

I need to think about that some more - if no DMA is in progress we can
safely peek at the SCSI registers. So the logic could be changed to test
for DMA operation first, and just try and service the interrupt if DMA
wasn't active.

If DMA has been in progress, I'm not sure that we can figure out if it's
still active from looking at the status register (that is, whether bits
0 or 1 are set while DMA is ongoing). We'd have to peek at the DMA
status register (or DMA address registers) without first stopping DMA,
which the current driver does. The docs seem to advise against that.
If DMA was in progress, stopping it would likely leave us with residual
bytes to be transferred - we'd have to handle that transfer as we would
any other DMA error (from memory, probably best to retry the entire
command, or transfer the remaining bytes using PIO if we're sure no
bytes have been lost).

> If all else fails, perhaps we could inhibit DMA entirely when the new ATA 
> driver is loaded. Then we can just dispatch the ST-DMA irq like a shared 
> irq. I'm sure that atari_scsi can work without DMA. No idea about the FDC 
> driver though (ataflop.c).

Yes, SCSI can work using PIO but's it a real dog. Been there, done that
(about 20 years ago). I know nothing about the FDC chip though.

> Another solution would be to dedicate the DMA function to atari_scsi, and 
> then mask the FDC and IDE interrupts during each DMA transfer. But once 
> again, this would mean changing the FDC driver to eliminate DMA, if that 
> is possible. From the schematic it looks the the FDC chip, "AJAX", is 
> another custom ...
> http://dev-docs.atariforge.org/files/Falcon030_Schematic.pdf
> 
> Unfortunately my grasp of the ST hardware reflects my inability to read 
> German; those who can may want to take a look at "ATARI Profibuch 
> ST-STE-TT.pdf".

I'll reread the ST-DMA description (and the FDC one).

Let me know if you think this could work ...

Cheers,

	Michael
