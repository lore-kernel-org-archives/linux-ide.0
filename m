From: Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH 0/3] ata: add m68k/Atari Falcon PATA support
Date: Fri, 13 Jan 2017 13:33:17 +1100 (AEDT)
Message-ID: <alpine.LNX.2.00.1701111053340.22260@nippy.intranet>
References: <CGME20161230140139epcas5p160eda5a6a77be084e21f12002c85cc2a@epcas5p1.samsung.com> <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com> <CAOmrzkJP6s34DPOHd4OFFx=CXko35Kt=CfeDZthOPvKDJy-9YA@mail.gmail.com> <3939493.HXZ6C33pKV@amdc3058>
 <CAOmrzkJfQu6PuCpyyRJL8PNvSYxYO42F-k8jEYf2d1-5C28A_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <CAOmrzkJfQu6PuCpyyRJL8PNvSYxYO42F-k8jEYf2d1-5C28A_A@mail.gmail.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org, Linux/m68k <linux-m68k@lists.linux-m68k.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Andreas Schwab <schwab@linux-m68k.org>
List-Id: linux-ide@vger.kernel.org


On Wed, 11 Jan 2017, Michael Schmitz wrote:

> What is still correct is that the IDE driver does use the interrupt 
> only, not the ST-DMA chip. And a single IDE interrupt can be correctly 
> assigned to IDE by looking at the status register.
> 
> With the SCSI (and IIRC also floppy) interrupts, we don't have direct 
> access to the status registers without disturbing the state of the DMA 
> though. Unless we know for definite that either chips have raised the 
> interrupt (and DMA ops are in flight), we must not touch the DMA chip at 
> all.
> 
> The case I'm worried about is both IDE and SCSI raising an interrupt. We 
> don't currently mask the IDE/ST-DMA interrupt so a stacked interrupt 
> must be processed in the same pass as the initial interrupt or it will 
> get dropped. We'd have to peek at the DMA registers to check the SCSI or 
> floppy interrupt status, and we just can't safely do that. So races of 
> this kind are currently prevented by including IDE in the IRQ locking 
> process.
> 
> Whether it's possible to mask the interrupt, do one pass, unmask and 
> process the second interrupt I don't know.

Would that require handling the SCSI DMA interrupt in the first pass? Or 
handling IDE first, and ensuring that the IDE handler does not access 
ST-DMA registers? What about FDC?

The atari_scsi handler accesses the ST-DMA registers; it can do so because 
it knows that any DMA must have completed -- it can infer this because a 
simultaneous pending interrupt from FDC or IDE is impossible due to 
stdma_lock().

Your suggestion would seem to allow other pending interrupts, hence the 
atari_scsi interrupt handler logic has to be tossed out. What logic would 
replace it?

If all else fails, perhaps we could inhibit DMA entirely when the new ATA 
driver is loaded. Then we can just dispatch the ST-DMA irq like a shared 
irq. I'm sure that atari_scsi can work without DMA. No idea about the FDC 
driver though (ataflop.c).

Another solution would be to dedicate the DMA function to atari_scsi, and 
then mask the FDC and IDE interrupts during each DMA transfer. But once 
again, this would mean changing the FDC driver to eliminate DMA, if that 
is possible. From the schematic it looks the the FDC chip, "AJAX", is 
another custom ...
http://dev-docs.atariforge.org/files/Falcon030_Schematic.pdf

Unfortunately my grasp of the ST hardware reflects my inability to read 
German; those who can may want to take a look at "ATARI Profibuch 
ST-STE-TT.pdf".

-- 

> Maybe Andreas does?
> 
> Cheers,
> 
>   Michael
> 
> 
> > it should be okay to use IDE at the same time as SCSI/Floppy which is 
> > what the new driver does (the old one is serialized operations by 
> > ST-DMA related IRQ handling magic).
> >
> > Also the comment itself may need some fixups as on Falcon it is SCSI 
> > not ACSI (according to the earlier comment in same file) and the old 
> > IDE host driver name is not falhd.c but falconide.c.
> >
> > Best regards,
> > --
> > Bartlomiej Zolnierkiewicz
> > Samsung R&D Institute Poland
> > Samsung Electronics
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
