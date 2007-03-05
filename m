From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH][pata-2.6 tree] pdc202xx_old: rewrite mode programming code
Date: Mon, 5 Mar 2007 21:38:28 +0100
Message-ID: <200703052138.28508.bzolnier@gmail.com>
References: <200703040149.46186.bzolnier@gmail.com> <45EC53AE.30808@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932339AbXCEUbx@vger.kernel.org>
In-Reply-To: <45EC53AE.30808@ru.mvista.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Hi,

On Monday 05 March 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> > [PATCH] pdc202xx_old: rewrite mode programming code
> 
> > This patch is based on the documentation (I would like to thank Promise
> > for it) and also partially on the older vendor driver.
> 
> > Rewrite mode programming code:
> 
> > * fix XFER_MW_DMA0 timings (they were overclocked, use the official ones)

official == same as in the docs and vendor driver :-)

>     Erm, those look a bit doubtful...

I believe that they are correct - please see explanations below.

> > * fix bitmasks for clearing bits of register B:
> > 
> >   - when programming DMA mode bit 0x10 of register B was cleared which
> >     resulted in overclocked PIO timing setting (iff PIO0 was used)
> 
> >   - when programming PIO mode bits 0x18 weren't cleared so suboptimal
> >     timings were used for PIO1-4 if PIO0 was previously set (bit 0x10)
> >     and for PIO0/3/4 if PIO1/2 was previously set (bit 0x08)
> 
>    I'm glad that somebody fixed those pesky masks at last. :-)
>    I've noticed that issue more than a year ago but lacking time, 
> documentation and access to hardware, have never got to really fixing it... :-(
> 
> > Index: b/drivers/ide/pci/pdc202xx_old.c
> > ===================================================================
> > --- a/drivers/ide/pci/pdc202xx_old.c
> > +++ b/drivers/ide/pci/pdc202xx_old.c
> [...]
> > @@ -107,52 +70,23 @@ static int pdc202xx_tune_chipset (ide_dr
> >  	u8 drive_pci		= 0x60 + (drive->dn << 2);
> >  	u8 speed		= ide_rate_filter(drive, xferspeed);
> >  
> > -	u32			drive_conf;
> > -	u8			AP, BP, CP, DP;
> > +	u32			drive_conf = 0;
> > +	u8			AP = 0, BP = 0, CP = 0;
> >  	u8			TA = 0, TB = 0, TC = 0;
> >  
> > -	if (drive->media != ide_disk &&
> > -		drive->media != ide_cdrom && speed < XFER_SW_DMA_0)
> > -		return -1;
> > +	/*
> > +	 * TODO: do this once per channel
> > +	 */
> > +	if (dev->device != PCI_DEVICE_ID_PROMISE_20246)
> > +		pdc_old_disable_66MHz_clock(hwif);
> >  
> >  	pci_read_config_dword(dev, drive_pci, &drive_conf);
> 
>     This function never uses it as u32 entity, I wonder why read it? Just to 
> hush a warning? :-)

It is used for debugging purposes by PDC202XX_DEBUG_DRIVE_INFO
(it prints old/new content of drive configuration registers).

I think that I'll cover it by #if PDC202XX_DEBUG_DRIVE_INFO to make
the aforementioned fact clear and to optimize non-debug case a bit...

> >  	switch(speed) {
> > -		case XFER_UDMA_6:	speed = XFER_UDMA_5;
> >  		case XFER_UDMA_5:
> >  		case XFER_UDMA_4:	TB = 0x20; TC = 0x01; break;
> 
>     The same clocks for UDMA4/5... I wonder if PDC20265/7 indeed supported 
> UDMA5 (as I'm not seeing any extra clock switching for this mode)?

Probably chipset snoops WIN_SETFEATURES (w/ SETFEATURES_XFER subcommand)
and sets the appropriate timings internally.  It might be possible to drop
the timing setup completely for UDMA modes but the vendor driver actually
does it so I left it alone for now.

> >  		case XFER_UDMA_2:	TB = 0x20; TC = 0x01; break;
> > @@ -161,7 +95,7 @@ static int pdc202xx_tune_chipset (ide_dr
> >  		case XFER_UDMA_0:
> >  		case XFER_MW_DMA_2:	TB = 0x60; TC = 0x03; break;
> >  		case XFER_MW_DMA_1:	TB = 0x60; TC = 0x04; break;
> > -		case XFER_MW_DMA_0:
> > +		case XFER_MW_DMA_0:	TB = 0xE0; TC = 0x0F; break;
> 
>     This seems even slower than SWDMA0!
>     Let's assume that means 7 active cycles and 15 recovery cycles (MWDMA1/2 
> settings seem to confirm this hypothesis) -- this would give us 720 ns vs the 
> specified 480. Could you shed some light on what these fields mean? :-/

The calculations are done in a different way so we get the correct timings:

 7 cycles (== 210 ns) are used for active time
16 cycles (== 480 ns) are used for cycle time

These timings are the maximum possible ones using MB[2:0] and MC[3:0]
(please refer to the comments in the code to see how MB/MC map to TB/TC).

> >  		case XFER_SW_DMA_2:	TB = 0x60; TC = 0x05; break;
> 
>     Well, this don't look right to me -- we need longer active time (given 
> that my hypothesis is true)

MB[2:0] and MC[3:0] are for MWDMA/UDMA timings only
(it is impossible to set SWDMA0/1 timings using them).

I suppose that PA[3:0] and PB[4:0] (PIO timings) should be used for SWDMA.

> >  		case XFER_SW_DMA_1:	TB = 0x80; TC = 0x06; break;
> 
>     This looks more fitting for SWDMA1 -- however, the recovery time seems to 
> be overly long. It certainly doesn't look like SWDMA1 unless the 
> active/recover times are not in clock cycles (should be 8 cycles, not 4 or 6).
> 
> >  		case XFER_SW_DMA_0:	TB = 0xC0; TC = 0x0B; break;
> 
>     Same here -- should be 16 cycles both for active and recovery...

Fixing SWDMA was not a goal of my changes (my patch is already quite
overloaded) but I would happily welcome the incremental patch doing it.

[ I'm also aware that it may difficult without docs so it still on my
  personal TODO if nobody beats my to it earlier. ]

Thanks,
Bart
