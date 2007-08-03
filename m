From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: move ide_config_drive_speed() calls to upper layers
Date: Sat, 4 Aug 2007 01:01:43 +0200
Message-ID: <200708040101.44106.bzolnier@gmail.com>
References: <200707270222.28230.bzolnier@gmail.com> <46AC87F8.7050508@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:6096 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762595AbXHCXEW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Aug 2007 19:04:22 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1186455mue
        for <linux-ide@vger.kernel.org>; Fri, 03 Aug 2007 16:04:21 -0700 (PDT)
In-Reply-To: <46AC87F8.7050508@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Sunday 29 July 2007, Sergei Shtylyov wrote:
> Hello again. :-)
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Convert {ide_hwif_t,ide_pci_device_t}->host_flag to be u16.
> 
> > * Add IDE_HFLAG_POST_SET_MODE host to indicate the need to program the
> >   host for the transfer mode after programming the device.  Set it in
> >   au1xxx-ide/cs5530/cs5535/pdc202xx_new/sc1200/via82cxxx host drivers.
> 
>     Well, I've already commented about the necessity of this flag...
> 
> > * Add IDE_HFLAG_NO_SET_MODE host flags to indicate the need to completely
> >   skip programming of host/device for the transfer mode ("smart" hosts).
> >   Set it in it821x host driver.
> 
>     Now this flag seems completely artificial to me.  I suggest instead to
> just not "install" the set_{pio|dma}_mode() methods at the driver startup when
> the chips are in smart mode.
> 
> > * Handle ->set_pio_mode abuse wrt to setting DMA modes in do_special()
> >   instead of sc1200.c::sc1200_set_pio_mode().
> 
>     I'm not sure it was a great idea to carry the code specific to only one
> driver into the generic code.  Why not leave it where it was?
> 
> > * Add ide_set_pio_mode()/ide_set_dma_mode() helpers and convert all
> >   direct ->set_pio_mode/->speedproc users to use these helpers.
> 
> > * Move ide_config_drive_speed() calls from ->set_pio_mode/->speedproc
> >   methods to callers.
> 
> > * Rename ->speedproc method to ->set_dma_mode, make it void and update
> >   all implementations accordingly.
> 
> > * Update ide_set_xfer_rate() comments.
> 
> > Except removal of two debugging printk-s (from cs5530.c and sc1200.c)
> > and the fact that transfer modes 0x00-0x07 passed from user space may
> > be programmed twice on the device (not really an issue since 0x00-0x01
> > are handled by very few host drivers and 0x02-0x07 are simply invalid)
> > there should be no other functionality changes caused by this patch.
> 
>     Haven't see any driver handling 0x01. 0x00 is usually handled by setting
> PIO0 or even slower mode which isn't quite correct.

Indeed, comment updated.

> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> > Index: b/drivers/ide/ide-io.c
> > ===================================================================
> > --- a/drivers/ide/ide-io.c
> > +++ b/drivers/ide/ide-io.c
> > @@ -834,6 +834,26 @@ static ide_startstop_t do_special (ide_d
> >  		s->b.set_tune = 0;
> >  
> >  		if (set_pio_mode_abuse(drive->hwif, req_pio)) {
> > +			int mode = -1;
> > +
> > +			switch (req_pio) {
> > +			case 200: mode = XFER_UDMA_0;	break;
> > +			case 201: mode = XFER_UDMA_1;	break;
> > +			case 202: mode = XFER_UDMA_2;	break;
> > +			case 100: mode = XFER_MW_DMA_0;	break;
> > +			case 101: mode = XFER_MW_DMA_1;	break;
> > +			case 102: mode = XFER_MW_DMA_2;	break;
> > +			}
> > +
> > +			if (mode != -1) {
> > +				printk(KERN_INFO "%s: changing (U)DMA mode\n",
> > +						 drive->name);
> > +				hwif->dma_off_quietly(drive);
> > +				if (ide_set_dma_mode(drive, mode) == 0)
> > +					hwif->dma_host_on(drive);
> > +				return ide_stopped;
> > +			}
> > +
> 
>     So, I'm doubtful about this part.  Could you clarify why/whether you deem
> it necassary?

Thinko, I overlooked the fact that for set_pio_mode_abuse() case we are
still using hwif->set_pio_mode() instead of ide_set_pio_mode()...

I added export for ide_set_dma_mode() and fixed the problem.

> > Index: b/drivers/ide/ide-lib.c
> > ===================================================================
> > --- a/drivers/ide/ide-lib.c
> > +++ b/drivers/ide/ide-lib.c
> > @@ -349,7 +349,7 @@ void ide_set_pio(ide_drive_t *drive, u8 
> >  			  drive->name, host_pio, req_pio,
> >  			  req_pio == 255 ? "(auto-tune)" : "", pio);
> >  
> > -	hwif->set_pio_mode(drive, pio);
> > +	(void)ide_set_pio_mode(drive, XFER_PIO_0 + pio);
> >  }
> >  
> >  EXPORT_SYMBOL_GPL(ide_set_pio);
> > @@ -378,39 +378,85 @@ void ide_toggle_bounce(ide_drive_t *driv
> >  		blk_queue_bounce_limit(drive->queue, addr);
> >  }
> >  
> > +int ide_set_pio_mode(ide_drive_t *drive, const u8 mode)
> > +{
> > +	ide_hwif_t *hwif = drive->hwif;
> > +
> > +	if (hwif->host_flags & IDE_HFLAG_NO_SET_MODE)
> > +		return 0;
> 
>     I think that we should not a lie to a user if we can *not* set the
> transfer mode that he requested. So, I suggest that this be replaced by:
> 
> 	if (hwif->set_pio_mode == NULL)
> 		return -1;

Done.

> > +
> > +	/*
> > +	 * TODO: temporary hack for some legacy host drivers that didn't
> > +	 * set transfer mode on the device in ->set_pio_mode method...
> > +	 */
> > +	if (hwif->set_dma_mode == NULL) {
> > +		hwif->set_pio_mode(drive, mode - XFER_PIO_0);
> > +		return 0;
> > +	}
> 
>     Er... I didn't quite get it. :-/
>     You mean those that are still unfixed WRT not calling
> ide_config_drive_speed()?

Yes.

> > +
> > +	if (hwif->host_flags & IDE_HFLAG_POST_SET_MODE) {
> > +		if (ide_config_drive_speed(drive, mode))
> > +			return -1;
> > +		hwif->set_pio_mode(drive, mode - XFER_PIO_0);
> > +		return 0;
> > +	} else {
> > +		hwif->set_pio_mode(drive, mode - XFER_PIO_0);
> > +		return ide_config_drive_speed(drive, mode);
> > +	}
> > +}
> > +
> > +int ide_set_dma_mode(ide_drive_t *drive, const u8 mode)
> > +{
> > +	ide_hwif_t *hwif = drive->hwif;
> > +
> > +	if (hwif->host_flags & IDE_HFLAG_NO_SET_MODE)
> > +		return 0;
> 
>     I suggest that this be replaced by:
> 
> 	if (hwif->set_dma_mode == NULL)
> 		return -1;

Done.

This alone would make ide_tune_dma() fail on it821x in smart mode
but moving IDE_HFLAG_NO_SET_MODE checking there fixes the issue.

> > +	if (hwif->host_flags & IDE_HFLAG_POST_SET_MODE) {
> > +		if (ide_config_drive_speed(drive, mode))
> > +			return -1;
> > +		hwif->set_dma_mode(drive, mode);
> > +		return 0;
> > +	} else {
> > +		hwif->set_dma_mode(drive, mode);
> > +		return ide_config_drive_speed(drive, mode);
> > +	}
> > +}
> > +
> >  /**
> >   *	ide_set_xfer_rate	-	set transfer rate
> >   *	@drive: drive to set
> > - *	@speed: speed to attempt to set
> > + *	@rate: speed to attempt to set
> >   *	
> >   *	General helper for setting the speed of an IDE device. This
> >   *	function knows about user enforced limits from the configuration
> > - *	which speedproc() does not.  High level drivers should never
> > - *	invoke speedproc() directly.
> > + *	which ->set_pio_mode/->set_dma_mode does not.
> >   */
> > - 
> > +
> >  int ide_set_xfer_rate(ide_drive_t *drive, u8 rate)
> >  {
> >  	ide_hwif_t *hwif = drive->hwif;
> >  
> > -	if (hwif->speedproc == NULL)
> > +	if (hwif->set_dma_mode == NULL)
> >  		return -1;
> >  
> >  	rate = ide_rate_filter(drive, rate);
> >  
> >  	if (rate >= XFER_PIO_0 && rate <= XFER_PIO_5) {
> >  		if (hwif->set_pio_mode)
> 
>     Won't be needed if we'll check it inside ide_set_pio_mode().
> 
> > -			hwif->set_pio_mode(drive, rate - XFER_PIO_0);
> > +			return ide_set_pio_mode(drive, rate);
> >  
> > -		/*
> > -		 * FIXME: this is incorrect to return zero here but
> > -		 * since all users of ide_set_xfer_rate() ignore
> > -		 * the return value it is not a problem currently
> > -		 */
> > -		return 0;
> > +		return -1;
> >  	}
> >  
> > -	return hwif->speedproc(drive, rate);
> > +	/*
> > +	 * TODO: transfer modes 0x00-0x07 passed from the user-space are
> > +	 * currently handled here which needs fixing (please note that such
> > +	 * case could happen iff the transfer mode has already been set on
> > +	 * the device by ide-proc.c::set_xfer_rate()).
> > +	 */
> 
>     Would be quite easy to hook and *properly* handle mode 0x00 here, however
> mode 0x01 would certainly be much trickier -- unless we'd want to delegate it
> to set_pio_mode() itself (I'm not suggesting it though :-)...

We do want (patches are welcomed).  :-)

Handling 0x00 properly in ide_set_pio()/ide_set_pio_mode() would allow us to
handle non-IORDY devices correctly without resorting to special hacks.

> > +
> > +	return ide_set_dma_mode(drive, rate);
> >  }
> >  
> >  static void ide_dump_opcode(ide_drive_t *drive)
> > Index: b/drivers/ide/mips/au1xxx-ide.c
> > ===================================================================
> > --- a/drivers/ide/mips/au1xxx-ide.c
> > +++ b/drivers/ide/mips/au1xxx-ide.c
> > @@ -101,11 +101,7 @@ void auide_outsw(unsigned long port, voi
> >  
> >  static void au1xxx_set_pio_mode(ide_drive_t *drive, const u8 pio)
> >  {
> > -	int mem_sttime;
> > -	int mem_stcfg;
> > -
> > -	if (ide_config_drive_speed(drive, pio + XFER_PIO_0))
> > -		return;
> > +	int mem_sttime, mem_stcfg;
> >  
> >  	mem_sttime = 0;
> 
>     Could initialize mem_sttime right in the declaration.

Done.

> >  	mem_stcfg  = au_readl(MEM_STCFG2);
> 
>     Well, this one too... :-)

ditto

> > @@ -168,10 +164,9 @@ static void au1xxx_set_pio_mode(ide_driv
> >  	au_writel(mem_stcfg,MEM_STCFG2);
> >  }
> >  
> > -static int auide_tune_chipset(ide_drive_t *drive, const u8 speed)
> > +static void auide_set_dma_mode(ide_drive_t *drive, const u8 speed)
> >  {
> > -	int mem_sttime;
> > -	int mem_stcfg;
> > +	int mem_sttime, mem_stcfg;
> >  
> >  	mem_sttime = 0;
> >  	mem_stcfg  = au_readl(MEM_STCFG2);
> 
>     Same here...

ditto

> > @@ -681,6 +671,7 @@ static int au_ide_probe(struct device *d
> >  #endif
> >  
> >  	hwif->pio_mask = ATA_PIO4;
> > +	hwif->host_flags = IDE_HFLAG_POST_SET_MODE;
> 
>     As I already said, this flag doesn't seem needed...
> 
> > Index: b/drivers/ide/pci/amd74xx.c
> > ===================================================================
> > --- a/drivers/ide/pci/amd74xx.c
> > +++ b/drivers/ide/pci/amd74xx.c
> > @@ -229,20 +229,16 @@ static void amd_set_speed(struct pci_dev
> [...]
> > @@ -437,7 +431,8 @@ static void __devinit init_hwif_amd74xx(
> >  		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},	\
> >  		.bootable	= ON_BOARD,				\
> >  		.host_flags	= IDE_HFLAG_PIO_NO_BLACKLIST		\
> > -				| IDE_HFLAG_PIO_NO_DOWNGRADE,		\
> > +				| IDE_HFLAG_PIO_NO_DOWNGRADE		\
> > +				| IDE_HFLAG_POST_SET_MODE,		\
> >  		.pio_mask	= ATA_PIO5,				\
> >  	}
> >  
> > @@ -450,7 +445,8 @@ static void __devinit init_hwif_amd74xx(
> >  		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},	\
> >  		.bootable	= ON_BOARD,				\
> >  		.host_flags	= IDE_HFLAG_PIO_NO_BLACKLIST		\
> > -				| IDE_HFLAG_PIO_NO_DOWNGRADE,		\
> > +				| IDE_HFLAG_PIO_NO_DOWNGRADE		\
> > +				| IDE_HFLAG_POST_SET_MODE,		\
> >  		.pio_mask	= ATA_PIO5,				\
> >  	}
> 
>     Maybe it worth fixing the driver to not enable Sesetting UltraDMA modes
> after snooping Set Features command -- then this flags woouldn't be needed...
> 
> > Index: b/drivers/ide/pci/atiixp.c
> > ===================================================================
> > --- a/drivers/ide/pci/atiixp.c
> > +++ b/drivers/ide/pci/atiixp.c
> > @@ -122,14 +122,14 @@ static void atiixp_dma_host_off(ide_driv
> >  }
> >  
> >  /**
> > - *	atiixp_tune_pio	-	tune a drive attached to a ATIIXP
> > - *	@drive: drive to tune
> > - *	@pio: desired PIO mode
> > + *	atiixp_set_pio_mode	-	set host controller for PIO mode
> > + *	@drive: drive
> > + *	@pio: PIO mode number
> >   *
> >   *	Set the interface PIO mode.
> >   */
> >  
> > -static void atiixp_tune_pio(ide_drive_t *drive, u8 pio)
> > +static void atiixp_set_pio_mode(ide_drive_t *drive, const u8 pio)
> >  {
> >  	struct pci_dev *dev = drive->hwif->pci_dev;
> >  	unsigned long flags;
> > @@ -153,23 +153,16 @@ static void atiixp_tune_pio(ide_drive_t 
> >  	spin_unlock_irqrestore(&atiixp_lock, flags);
> >  }
> >  
> > -static void atiixp_set_pio_mode(ide_drive_t *drive, const u8 pio)
> > -{
> > -	atiixp_tune_pio(drive, pio);
> > -	(void)ide_config_drive_speed(drive, XFER_PIO_0 + pio);
> > -}
> > -
> >  /**
> > - *	atiixp_tune_chipset	-	tune a ATIIXP interface
> > - *	@drive: IDE drive to tune
> > - *	@speed: speed to configure
> > + *	atiixp_set_dma_mode	-	set host controller for DMA mode
> > + *	@drive: drive
> > + *	@speed: DMA mode
> >   *
> > - *	Set a ATIIXP interface channel to the desired speeds. This involves
> > - *	requires the right timing data into the ATIIXP configuration space
> > - *	then setting the drive parameters appropriately
> > + *	Set a ATIIXP host controller to the desired DMA mode.  This involves
> > + *	programming the right timing data into the PCI configuration space.
> >   */
> >  
> > -static int atiixp_speedproc(ide_drive_t *drive, const u8 speed)
> > +static void atiixp_set_dma_mode(ide_drive_t *drive, const u8 speed)
> >  {
> >  	struct pci_dev *dev = drive->hwif->pci_dev;
> >  	unsigned long flags;
> > @@ -204,9 +197,7 @@ static int atiixp_speedproc(ide_drive_t 
> >  	else
> >  		pio = speed - XFER_PIO_0;
> >  
> > -	atiixp_tune_pio(drive, pio);
> > -
> > -	return ide_config_drive_speed(drive, speed);
> > +	atiixp_set_pio_mode(drive, pio);
> 
>     Bleh... PIO/DMA needs "decoupling" here too.

I have patch ready, needs documenting though.

> > Index: b/drivers/ide/pci/cs5530.c
> > ===================================================================
> > --- a/drivers/ide/pci/cs5530.c
> > +++ b/drivers/ide/pci/cs5530.c
> [...]
> > @@ -62,20 +46,12 @@ static unsigned int cs5530_pio_timings[2
> >  #define CS5530_BAD_PIO(timings) (((timings)&~0x80000000)==0x0000e132)
> >  #define CS5530_BASEREG(hwif)	(((hwif)->dma_base & ~0xf) + ((hwif)->channel 
> ? 0x30 : 0x20))
> >
> > -static void cs5530_tunepio(ide_drive_t *drive, u8 pio)
> > -{
> > -	unsigned long basereg = CS5530_BASEREG(drive->hwif);
> > -	unsigned int format = (inl(basereg + 4) >> 31) & 1;
> > -
> > -	outl(cs5530_pio_timings[format][pio], basereg + ((drive->dn & 1)<<3));
> > -}
> > -
> >  /**
> > - *	cs5530_set_pio_mode	-	set PIO mode
> > + *	cs5530_set_pio_mode	-	set host controller for PIO mode
> >   *	@drive: drive
> >   *	@pio: PIO mode number
> >   *
> > - *	Handles setting of PIO mode for both the chipset and drive.
> > + *	Handles setting of PIO mode for both the chipset.
> 
>     Both the chipset and what? ;-)

Fixed.

> >[...]
> > @@ -334,6 +301,7 @@ static ide_pci_device_t cs5530_chipset _
> >  	.autodma	= AUTODMA,
> >  	.bootable	= ON_BOARD,
> >  	.pio_mask	= ATA_PIO4,
> > +	.host_flags	= IDE_HFLAG_POST_SET_MODE,
> >  };
> 
>     Shouldn't be needed as well...
> 
> > Index: b/drivers/ide/pci/cs5535.c
> > ===================================================================
> > --- a/drivers/ide/pci/cs5535.c
> > +++ b/drivers/ide/pci/cs5535.c
> [...]
> > @@ -227,7 +219,7 @@ static ide_pci_device_t cs5535_chipset _
> >  	.init_hwif	= init_hwif_cs5535,
> >  	.autodma	= AUTODMA,
> >  	.bootable	= ON_BOARD,
> > -	.host_flags	= IDE_HFLAG_SINGLE,
> > +	.host_flags	= IDE_HFLAG_SINGLE | IDE_HFLAG_POST_SET_MODE,
> >  	.pio_mask	= ATA_PIO4,
> >  };
> 
>     ... and here either.
> 
> > Index: b/drivers/ide/pci/hpt366.c
> > ===================================================================
> > --- a/drivers/ide/pci/hpt366.c
> > +++ b/drivers/ide/pci/hpt366.c
> > @@ -625,24 +623,22 @@ static int hpt37x_tune_chipset(ide_drive
> >  	if (speed < XFER_MW_DMA_0)
> >  		new_itr &= ~0x80000000; /* Disable on-chip PIO FIFO/buffer */
> >  	pci_write_config_dword(dev, itr_addr, new_itr);
> > -
> > -	return ide_config_drive_speed(drive, speed);
> >  }
> >  
> > -static int hpt3xx_tune_chipset(ide_drive_t *drive, u8 speed)
> > +static void hpt3xx_set_mode(ide_drive_t *drive, const u8 speed)
> >  {
> >  	ide_hwif_t *hwif	= HWIF(drive);
> >  	struct hpt_info	*info	= pci_get_drvdata(hwif->pci_dev);
> >  
> >  	if (info->chip_type >= HPT370)
> > -		return hpt37x_tune_chipset(drive, speed);
> > +		hpt37x_set_mode(drive, speed);
> >  	else	/* hpt368: hpt_minimum_revision(dev, 2) */
> > -		return hpt36x_tune_chipset(drive, speed);
> > +		hpt36x_set_mode(drive, speed);
> >  }
> 
>     Sigh, I have a patch pending to deal with this stupid wrapper (and the
> shared PIO/DMA timings) for about a year now (though I'm still going to rework
> it)...
> 
> > Index: b/drivers/ide/pci/it821x.c
> > ===================================================================
> > --- a/drivers/ide/pci/it821x.c
> > +++ b/drivers/ide/pci/it821x.c
> > @@ -629,14 +596,16 @@ static void __devinit init_hwif_it821x(i
> >  			printk(KERN_WARNING "it821x: Revision 0x10, workarounds activated.\n");
> >  	}
> >  
> > -	hwif->speedproc = &it821x_tune_chipset;
> 
>     What I suggest would look like:
> 
>   	if (!idev->smart) {
> 	  	hwif->set_pio_mode = &it821x_set_pio_mode;
> 		hwif->set_dma_mode = &it821x_set_dma_mode;
> 
> 	 	/* MWDMA/PIO clock switching for pass through mode */
>   		hwif->dma_start = &it821x_dma_start;
>   		hwif->ide_dma_end = &it821x_dma_end;
> 	}

Fixed.

> > Index: b/drivers/ide/pci/piix.c
> > ===================================================================
> > --- a/drivers/ide/pci/piix.c
> > +++ b/drivers/ide/pci/piix.c
> [...]
> > @@ -288,9 +273,7 @@ static int piix_tune_chipset(ide_drive_t
> >  			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
> >  	}
> >  
> > -	piix_tune_pio(drive, piix_dma_2_pio(speed));
> > -
> > -	return ide_config_drive_speed(drive, speed);
> > +	piix_set_pio_mode(drive, piix_dma_2_pio(speed));
> 
>     Hm, I remember some earlier patches which have changed this code...

Earlier patches removed *_dma_2_pio() calls for PIO modes.

I'll post patches to completely remove *_ dma_2_pio() shortly.

> > Index: b/drivers/ide/pci/sc1200.c
> > ===================================================================
> > --- a/drivers/ide/pci/sc1200.c
> > +++ b/drivers/ide/pci/sc1200.c
> [...]
> > @@ -423,7 +373,7 @@ static ide_pci_device_t sc1200_chipset _
> >  	.init_hwif	= init_hwif_sc1200,
> >  	.autodma	= AUTODMA,
> >  	.bootable	= ON_BOARD,
> > -	.host_flags	= IDE_HFLAG_ABUSE_DMA_MODES,
> > +	.host_flags	= IDE_HFLAG_ABUSE_DMA_MODES | IDE_HFLAG_POST_SET_MODE,
> 
>     Doesn't seem needed as well...
> 
> > Index: b/drivers/ide/pci/siimage.c
> > ===================================================================
> > --- a/drivers/ide/pci/siimage.c
> > +++ b/drivers/ide/pci/siimage.c
> > @@ -234,21 +234,15 @@ static void sil_tune_pio(ide_drive_t *dr
> >  	}
> >  }
> >  
> > -static void sil_set_pio_mode(ide_drive_t *drive, const u8 pio)
> > -{
> > -	sil_tune_pio(drive, pio);
> > -	(void)ide_config_drive_speed(drive, XFER_PIO_0 + pio);
> > -}
> > -
> >  /**
> > - *	siimage_tune_chipset	-	set controller timings
> > - *	@drive: Drive to set up
> > - *	@speed: speed we want to achieve
> > + *	sil_set_dma_mode	-	set host controller for DMA mode
> > + *	@drive: drive
> > + *	@speed: DMA mode
> >   *
> > - *	Tune the SII chipset for the desired mode.
> > + *	Tune the SII chipset for the desired DMA mode.
> 
>     It's rather SiI chipset.

Fixed.

> > Index: b/drivers/ide/pci/slc90e66.c
> > ===================================================================
> > --- a/drivers/ide/pci/slc90e66.c
> > +++ b/drivers/ide/pci/slc90e66.c
> [...]
> > @@ -144,9 +138,7 @@ static int slc90e66_tune_chipset(ide_dri
> >  			pci_write_config_word(dev, 0x4a, reg4a & ~a_speed);
> >  	}
> >  
> > -	slc90e66_tune_pio(drive, slc90e66_dma_2_pio(speed));
> > -
> > -	return ide_config_drive_speed(drive, speed);
> > +	slc90e66_set_pio_mode(drive, slc90e66_dma_2_pio(speed));
> >  }
> 
>     I remember a prior patch changing this code as well...
> 
> > Index: b/drivers/ide/pci/via82cxxx.c
> > ===================================================================
> > --- a/drivers/ide/pci/via82cxxx.c
> > +++ b/drivers/ide/pci/via82cxxx.c
> [...]
> > @@ -488,7 +481,8 @@ static ide_pci_device_t via82cxxx_chipse
> >  		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
> >  		.bootable	= ON_BOARD,
> >  		.host_flags	= IDE_HFLAG_PIO_NO_BLACKLIST
> > -				| IDE_HFLAG_PIO_NO_DOWNGRADE,
> > +				| IDE_HFLAG_PIO_NO_DOWNGRADE
> > +				| IDE_HFLAG_POST_SET_MODE,
> >  		.pio_mask	= ATA_PIO5,
> >  	},{	/* 1 */
> >  		.name		= "VP_IDE",
> > @@ -498,7 +492,8 @@ static ide_pci_device_t via82cxxx_chipse
> >  		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
> >  		.bootable	= ON_BOARD,
> >  		.host_flags	= IDE_HFLAG_PIO_NO_BLACKLIST
> > -				| IDE_HFLAG_PIO_NO_DOWNGRADE,
> > +				| IDE_HFLAG_PIO_NO_DOWNGRADE
> > +				| IDE_HFLAG_POST_SET_MODE,
> >  		.pio_mask	= ATA_PIO5,
> >  	}
> >  };
> 
>     The same comment about this driver enabling Set Feature command snoop for 
> no apparent reason...
> 
> > Index: b/drivers/ide/ppc/pmac.c
> > ===================================================================
> > --- a/drivers/ide/ppc/pmac.c
> > +++ b/drivers/ide/ppc/pmac.c
> [...]
> > @@ -1143,7 +1130,8 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
> >  	hwif->cbl = pmif->cable_80 ? ATA_CBL_PATA80 : ATA_CBL_PATA40;
> >  	hwif->drives[0].unmask = 1;
> >  	hwif->drives[1].unmask = 1;
> > -	hwif->host_flags = IDE_HFLAG_SET_PIO_MODE_KEEP_DMA;
> > +	hwif->host_flags = IDE_HFLAG_SET_PIO_MODE_KEEP_DMA |
> > +			   IDE_HFLAG_POST_SET_MODE,
> 
>     Er... have you tried to compile this before posting? ;-)

This?  No. ;-)

Fixed.

[PATCH] ide: move ide_config_drive_speed() calls to upper layers (take 2)

* Convert {ide_hwif_t,ide_pci_device_t}->host_flag to be u16.

* Add IDE_HFLAG_POST_SET_MODE host to indicate the need to program the
  host for the transfer mode after programming the device.  Set it in
  au1xxx-ide, amd74xx, cs5530, cs5535, pdc202xx_new, sc1200, pmac and
  via82cxxx host drivers.

* Add IDE_HFLAG_NO_SET_MODE host flags to indicate the need to completely
  skip programming of host/device for the transfer mode ("smart" hosts).
  Set it in it821x host driver and check it in ide_tune_dma().

* Add ide_set_pio_mode()/ide_set_dma_mode() helpers and convert all
  direct ->set_pio_mode/->speedproc users to use these helpers.

* Move ide_config_drive_speed() calls from ->set_pio_mode/->speedproc
  methods to callers.

* Rename ->speedproc method to ->set_dma_mode, make it void and update
  all implementations accordingly.

* Update ide_set_xfer_rate() comments.

* Unexport ide_config_drive_speed().

v2:
* Fix issues noticed by Sergei:
  - export ide_set_dma_mode() instead of moving ->set_pio_mode abuse wrt
    to setting DMA modes from sc1200_set_pio_mode() to do_special()
  - check IDE_HFLAG_NO_SET_MODE in ide_tune_dma()
  - check for (hwif->set_pio_mode) == NULL in ide_set_pio_mode()
  - check for (hwif->set_dma_mode) == NULL in ide_set_dma_mode()
  - return -1 from ide_set_{pio,dma}_mode() if ->set_{pio,dma}_mode == NULL
  - don't set ->set_{pio,dma}_mode on it821x in "smart" mode
  - fix build problem in pmac.c
  - minor fixes in au1xxx-ide.c/cs5530.c/siimage.c
  - improve patch description

Changes in behavior caused by this patch:
- HDIO_SET_PIO_MODE ioctl would now return -ENOSYS for attempts to change
  PIO mode if it821x controller is in "smart" mode
- removal of two debugging printk-s (from cs5530.c and sc1200.c)
- transfer modes 0x00-0x07 passed from user space may be programmed twice on
  the device (not really an issue since 0x00 is not supported correctly by
  any host driver ATM, 0x01 is not supported et all and 0x02-0x07 are invalid)

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/icside.c       |    8 +--
 drivers/ide/cris/ide-cris.c    |    8 ---
 drivers/ide/ide-dma.c          |    5 +-
 drivers/ide/ide-iops.c         |    3 -
 drivers/ide/ide-lib.c          |   80 ++++++++++++++++++++++++++++--------
 drivers/ide/ide.c              |    2 
 drivers/ide/mips/au1xxx-ide.c  |   27 ++----------
 drivers/ide/pci/aec62xx.c      |   12 ++---
 drivers/ide/pci/alim15x3.c     |   33 +++------------
 drivers/ide/pci/amd74xx.c      |   20 +++------
 drivers/ide/pci/atiixp.c       |   33 +++++----------
 drivers/ide/pci/cmd64x.c       |    9 +---
 drivers/ide/pci/cs5520.c       |   13 -----
 drivers/ide/pci/cs5530.c       |   50 ++++------------------
 drivers/ide/pci/cs5535.c       |   28 ++++--------
 drivers/ide/pci/hpt34x.c       |    9 +---
 drivers/ide/pci/hpt366.c       |   18 +++-----
 drivers/ide/pci/it8213.c       |   36 +++++-----------
 drivers/ide/pci/it821x.c       |   90 +++++++++++++----------------------------
 drivers/ide/pci/jmicron.c      |   15 ++----
 drivers/ide/pci/pdc202xx_new.c |   24 +++++-----
 drivers/ide/pci/pdc202xx_old.c |    9 +---
 drivers/ide/pci/piix.c         |   46 ++++++--------------
 drivers/ide/pci/sc1200.c       |   32 ++------------
 drivers/ide/pci/scc_pata.c     |   28 ++++--------
 drivers/ide/pci/serverworks.c  |   14 +-----
 drivers/ide/pci/sgiioc4.c      |    8 ---
 drivers/ide/pci/siimage.c      |   29 +++++--------
 drivers/ide/pci/sis5513.c      |   16 +------
 drivers/ide/pci/sl82c105.c     |   23 ++--------
 drivers/ide/pci/slc90e66.c     |   18 ++------
 drivers/ide/pci/tc86c001.c     |    9 +---
 drivers/ide/pci/triflex.c      |   10 +---
 drivers/ide/pci/via82cxxx.c    |   23 ++++------
 drivers/ide/ppc/pmac.c         |   24 ++--------
 include/linux/ide.h            |   17 +++++--
 36 files changed, 305 insertions(+), 524 deletions(-)

Index: b/drivers/ide/arm/icside.c
===================================================================
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -248,7 +248,7 @@ static void icside_build_sglist(ide_driv
  *	MW1	80	50	50	150	C
  *	MW2	70	25	25	120	C
  */
-static int icside_set_speed(ide_drive_t *drive, const u8 xfer_mode)
+static void icside_set_dma_mode(ide_drive_t *drive, const u8 xfer_mode)
 {
 	int cycle_time, use_dma_info = 0;
 
@@ -273,7 +273,7 @@ static int icside_set_speed(ide_drive_t 
 		cycle_time = 480;
 		break;
 	default:
-		return 1;
+		return;
 	}
 
 	/*
@@ -287,8 +287,6 @@ static int icside_set_speed(ide_drive_t 
 
 	printk("%s: %s selected (peak %dMB/s)\n", drive->name,
 		ide_xfer_verbose(xfer_mode), 2000 / drive->drive_data);
-
-	return ide_config_drive_speed(drive, xfer_mode);
 }
 
 static void icside_dma_host_off(ide_drive_t *drive)
@@ -433,7 +431,7 @@ static void icside_dma_init(ide_hwif_t *
 
 	hwif->dmatable_cpu	= NULL;
 	hwif->dmatable_dma	= 0;
-	hwif->speedproc		= icside_set_speed;
+	hwif->set_dma_mode	= icside_set_dma_mode;
 	hwif->autodma		= 1;
 
 	hwif->ide_dma_check	= icside_dma_check;
Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -716,11 +716,9 @@ static void cris_set_pio_mode(ide_drive_
 	}
 
 	cris_ide_set_speed(TYPE_PIO, setup, strobe, hold);
-
-	(void)ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
 
-static int speed_cris_ide(ide_drive_t *drive, const u8 speed)
+static void cris_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 	int cyc = 0, dvs = 0, strobe = 0, hold = 0;
 
@@ -759,8 +757,6 @@ static int speed_cris_ide(ide_drive_t *d
 		cris_ide_set_speed(TYPE_UDMA, cyc, dvs, 0);
 	else
 		cris_ide_set_speed(TYPE_DMA, 0, strobe, hold);
-
-	return ide_config_drive_speed(drive, speed);
 }
 
 void __init
@@ -791,7 +787,7 @@ init_e100_ide (void)
 		hwif->mmio = 1;
 		hwif->chipset = ide_etrax100;
 		hwif->set_pio_mode = &cris_set_pio_mode;
-		hwif->speedproc = &speed_cris_ide;
+		hwif->set_dma_mode = &cris_set_dma_mode;
 		hwif->ata_input_data = &cris_ide_input_data;
 		hwif->ata_output_data = &cris_ide_output_data;
 		hwif->atapi_input_bytes = &cris_atapi_input_bytes;
Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -768,7 +768,10 @@ int ide_tune_dma(ide_drive_t *drive)
 	if (!speed)
 		return 0;
 
-	if (drive->hwif->speedproc(drive, speed))
+	if (drive->hwif->host_flags & IDE_HFLAG_NO_SET_MODE)
+		return 0;
+
+	if (ide_set_dma_mode(drive, speed))
 		return 0;
 
 	return 1;
Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -861,9 +861,6 @@ int ide_config_drive_speed(ide_drive_t *
 	return error;
 }
 
-EXPORT_SYMBOL(ide_config_drive_speed);
-
-
 /*
  * This should get invoked any time we exit the driver to
  * wait for an interrupt response from a drive.  handler() points
Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -349,7 +349,7 @@ void ide_set_pio(ide_drive_t *drive, u8 
 			  drive->name, host_pio, req_pio,
 			  req_pio == 255 ? "(auto-tune)" : "", pio);
 
-	hwif->set_pio_mode(drive, pio);
+	(void)ide_set_pio_mode(drive, XFER_PIO_0 + pio);
 }
 
 EXPORT_SYMBOL_GPL(ide_set_pio);
@@ -378,39 +378,83 @@ void ide_toggle_bounce(ide_drive_t *driv
 		blk_queue_bounce_limit(drive->queue, addr);
 }
 
+int ide_set_pio_mode(ide_drive_t *drive, const u8 mode)
+{
+	ide_hwif_t *hwif = drive->hwif;
+
+	if (hwif->set_pio_mode == NULL)
+		return -1;
+
+	/*
+	 * TODO: temporary hack for some legacy host drivers that didn't
+	 * set transfer mode on the device in ->set_pio_mode method...
+	 */
+	if (hwif->set_dma_mode == NULL) {
+		hwif->set_pio_mode(drive, mode - XFER_PIO_0);
+		return 0;
+	}
+
+	if (hwif->host_flags & IDE_HFLAG_POST_SET_MODE) {
+		if (ide_config_drive_speed(drive, mode))
+			return -1;
+		hwif->set_pio_mode(drive, mode - XFER_PIO_0);
+		return 0;
+	} else {
+		hwif->set_pio_mode(drive, mode - XFER_PIO_0);
+		return ide_config_drive_speed(drive, mode);
+	}
+}
+
+int ide_set_dma_mode(ide_drive_t *drive, const u8 mode)
+{
+	ide_hwif_t *hwif = drive->hwif;
+
+	if (hwif->set_dma_mode == NULL)
+		return -1;
+
+	if (hwif->host_flags & IDE_HFLAG_POST_SET_MODE) {
+		if (ide_config_drive_speed(drive, mode))
+			return -1;
+		hwif->set_dma_mode(drive, mode);
+		return 0;
+	} else {
+		hwif->set_dma_mode(drive, mode);
+		return ide_config_drive_speed(drive, mode);
+	}
+}
+
+EXPORT_SYMBOL_GPL(ide_set_dma_mode);
+
 /**
  *	ide_set_xfer_rate	-	set transfer rate
  *	@drive: drive to set
- *	@speed: speed to attempt to set
+ *	@rate: speed to attempt to set
  *	
  *	General helper for setting the speed of an IDE device. This
  *	function knows about user enforced limits from the configuration
- *	which speedproc() does not.  High level drivers should never
- *	invoke speedproc() directly.
+ *	which ->set_pio_mode/->set_dma_mode does not.
  */
- 
+
 int ide_set_xfer_rate(ide_drive_t *drive, u8 rate)
 {
 	ide_hwif_t *hwif = drive->hwif;
 
-	if (hwif->speedproc == NULL)
+	if (hwif->set_dma_mode == NULL)
 		return -1;
 
 	rate = ide_rate_filter(drive, rate);
 
-	if (rate >= XFER_PIO_0 && rate <= XFER_PIO_5) {
-		if (hwif->set_pio_mode)
-			hwif->set_pio_mode(drive, rate - XFER_PIO_0);
-
-		/*
-		 * FIXME: this is incorrect to return zero here but
-		 * since all users of ide_set_xfer_rate() ignore
-		 * the return value it is not a problem currently
-		 */
-		return 0;
-	}
+	if (rate >= XFER_PIO_0 && rate <= XFER_PIO_5)
+		return ide_set_pio_mode(drive, rate);
+
+	/*
+	 * TODO: transfer modes 0x00-0x07 passed from the user-space are
+	 * currently handled here which needs fixing (please note that such
+	 * case could happen iff the transfer mode has already been set on
+	 * the device by ide-proc.c::set_xfer_rate()).
+	 */
 
-	return hwif->speedproc(drive, rate);
+	return ide_set_dma_mode(drive, rate);
 }
 
 static void ide_dump_opcode(ide_drive_t *drive)
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -397,7 +397,7 @@ static void ide_hwif_restore(ide_hwif_t 
 #endif
 
 	hwif->set_pio_mode		= tmp_hwif->set_pio_mode;
-	hwif->speedproc			= tmp_hwif->speedproc;
+	hwif->set_dma_mode		= tmp_hwif->set_dma_mode;
 	hwif->udma_filter		= tmp_hwif->udma_filter;
 	hwif->selectproc		= tmp_hwif->selectproc;
 	hwif->reset_poll		= tmp_hwif->reset_poll;
Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -101,14 +101,7 @@ void auide_outsw(unsigned long port, voi
 
 static void au1xxx_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	int mem_sttime;
-	int mem_stcfg;
-
-	if (ide_config_drive_speed(drive, pio + XFER_PIO_0))
-		return;
-
-	mem_sttime = 0;
-	mem_stcfg  = au_readl(MEM_STCFG2);
+	int mem_sttime = 0, mem_stcfg = au_readl(MEM_STCFG2);
 
 	/* set pio mode! */
 	switch(pio) {
@@ -168,13 +161,9 @@ static void au1xxx_set_pio_mode(ide_driv
 	au_writel(mem_stcfg,MEM_STCFG2);
 }
 
-static int auide_tune_chipset(ide_drive_t *drive, const u8 speed)
+static void auide_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
-	int mem_sttime;
-	int mem_stcfg;
-
-	mem_sttime = 0;
-	mem_stcfg  = au_readl(MEM_STCFG2);
+	int mem_sttime = 0, mem_stcfg = au_readl(MEM_STCFG2);
 
 	switch(speed) {
 #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
@@ -210,16 +199,11 @@ static int auide_tune_chipset(ide_drive_
 		break;
 #endif
 	default:
-		return 1;
+		return;
 	}
 
-	if (ide_config_drive_speed(drive, speed))
-		return 1;
-
 	au_writel(mem_sttime,MEM_STTIME2);
 	au_writel(mem_stcfg,MEM_STCFG2);
-
-	return 0;
 }
 
 /*
@@ -681,6 +665,7 @@ static int au_ide_probe(struct device *d
 #endif
 
 	hwif->pio_mask = ATA_PIO4;
+	hwif->host_flags = IDE_HFLAG_POST_SET_MODE;
 
 	hwif->noprobe = 0;
 	hwif->drives[0].unmask          = 1;
@@ -701,7 +686,7 @@ static int au_ide_probe(struct device *d
 #endif
 
 	hwif->set_pio_mode		= &au1xxx_set_pio_mode;
-	hwif->speedproc                 = &auide_tune_chipset;
+	hwif->set_dma_mode		= &auide_set_dma_mode;
 
 #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
 	hwif->dma_off_quietly		= &auide_dma_off_quietly;
Index: b/drivers/ide/pci/aec62xx.c
===================================================================
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -87,7 +87,7 @@ static u8 pci_bus_clock_list_ultra (u8 s
 	return chipset_table->ultra_settings;
 }
 
-static int aec6210_tune_chipset(ide_drive_t *drive, const u8 speed)
+static void aec6210_set_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
@@ -111,10 +111,9 @@ static int aec6210_tune_chipset(ide_driv
 	tmp2 = ((ultra_conf << (2*drive->dn)) | (tmp1 & ~(3 << (2*drive->dn))));
 	pci_write_config_byte(dev, 0x54, tmp2);
 	local_irq_restore(flags);
-	return(ide_config_drive_speed(drive, speed));
 }
 
-static int aec6260_tune_chipset(ide_drive_t *drive, const u8 speed)
+static void aec6260_set_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
@@ -135,12 +134,11 @@ static int aec6260_tune_chipset(ide_driv
 	tmp2 = ((ultra_conf << (4*unit)) | (tmp1 & ~(7 << (4*unit))));
 	pci_write_config_byte(dev, (0x44|hwif->channel), tmp2);
 	local_irq_restore(flags);
-	return(ide_config_drive_speed(drive, speed));
 }
 
 static void aec_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	(void) HWIF(drive)->speedproc(drive, pio + XFER_PIO_0);
+	drive->hwif->set_dma_mode(drive, pio + XFER_PIO_0);
 }
 
 static int aec62xx_config_drive_xfer_rate (ide_drive_t *drive)
@@ -205,9 +203,9 @@ static void __devinit init_hwif_aec62xx(
 	if (dev->device == PCI_DEVICE_ID_ARTOP_ATP850UF) {
 		if(hwif->mate)
 			hwif->mate->serialized = hwif->serialized = 1;
-		hwif->speedproc = &aec6210_tune_chipset;
+		hwif->set_dma_mode = &aec6210_set_mode;
 	} else
-		hwif->speedproc = &aec6260_tune_chipset;
+		hwif->set_dma_mode = &aec6260_set_mode;
 
 	if (!hwif->dma_base) {
 		hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -283,14 +283,14 @@ static int ali_get_info (char *buffer, c
 #endif  /* defined(DISPLAY_ALI_TIMINGS) && defined(CONFIG_IDE_PROC_FS) */
 
 /**
- *	ali_tune_pio	-	set host controller for PIO mode
+ *	ali_set_pio_mode	-	set host controller for PIO mode
  *	@drive: drive
  *	@pio: PIO mode number
  *
  *	Program the controller for the given PIO mode.
  */
 
-static void ali_tune_pio(ide_drive_t *drive, const u8 pio)
+static void ali_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	struct pci_dev *dev = hwif->pci_dev;
@@ -358,21 +358,6 @@ static void ali_tune_pio(ide_drive_t *dr
 }
 
 /**
- *	ali_set_pio_mode	-	set up drive for PIO mode
- *	@drive: drive to tune
- *	@pio: desired mode
- *
- *	Program the controller with the desired PIO timing for the given drive.
- *	Then set up the drive itself.
- */
-
-static void ali_set_pio_mode(ide_drive_t *drive, const u8 pio)
-{
-	ali_tune_pio(drive, pio);
-	(void) ide_config_drive_speed(drive, XFER_PIO_0 + pio);
-}
-
-/**
  *	ali_udma_filter		-	compute UDMA mask
  *	@drive: IDE device
  *
@@ -401,15 +386,14 @@ static u8 ali_udma_filter(ide_drive_t *d
 }
 
 /**
- *	ali15x3_tune_chipset	-	set up chipset/drive for new speed
- *	@drive: drive to configure for
- *	@speed: desired speed
+ *	ali_set_dma_mode	-	set host controller for DMA mode
+ *	@drive: drive
+ *	@speed: DMA mode
  *
  *	Configure the hardware for the desired IDE transfer mode.
- *	We also do the needed drive configuration through helpers
  */
 
-static int ali15x3_tune_chipset(ide_drive_t *drive, const u8 speed)
+static void ali_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
@@ -419,7 +403,7 @@ static int ali15x3_tune_chipset(ide_driv
 	int m5229_udma		= (hwif->channel) ? 0x57 : 0x56;
 
 	if (speed < XFER_PIO_0)
-		return 1;
+		return;
 
 	if (speed == XFER_UDMA_6)
 		speed1 = 0x47;
@@ -450,7 +434,6 @@ static int ali15x3_tune_chipset(ide_driv
 			pci_write_config_byte(dev, 0x4b, tmpbyte);
 		}
 	}
-	return (ide_config_drive_speed(drive, speed));
 }
 
 /**
@@ -692,7 +675,7 @@ static void __devinit init_hwif_common_a
 {
 	hwif->autodma = 0;
 	hwif->set_pio_mode = &ali_set_pio_mode;
-	hwif->speedproc = &ali15x3_tune_chipset;
+	hwif->set_dma_mode = &ali_set_dma_mode;
 	hwif->udma_filter = &ali_udma_filter;
 
 	/* don't use LBA48 DMA on ALi devices before rev 0xC5 */
Index: b/drivers/ide/pci/amd74xx.c
===================================================================
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -229,20 +229,16 @@ static void amd_set_speed(struct pci_dev
 }
 
 /*
- * amd_set_drive() computes timing values configures the drive and
- * the chipset to a desired transfer mode. It also can be called
- * by upper layers.
+ * amd_set_drive() computes timing values and configures the chipset
+ * to a desired transfer mode.  It also can be called by upper layers.
  */
 
-static int amd_set_drive(ide_drive_t *drive, const u8 speed)
+static void amd_set_drive(ide_drive_t *drive, const u8 speed)
 {
 	ide_drive_t *peer = HWIF(drive)->drives + (~drive->dn & 1);
 	struct ide_timing t, p;
 	int T, UT;
 
-	if (ide_config_drive_speed(drive, speed))
-		return 1;
-
 	T = 1000000000 / amd_clock;
 	UT = (amd_config->udma_mask == ATA_UDMA2) ? T : (T / 2);
 
@@ -257,8 +253,6 @@ static int amd_set_drive(ide_drive_t *dr
 	if (speed == XFER_UDMA_6 && amd_clock <= 33333) t.udma = 15;
 
 	amd_set_speed(HWIF(drive)->pci_dev, drive->dn, &t);
-
-	return 0;
 }
 
 /*
@@ -395,7 +389,7 @@ static void __devinit init_hwif_amd74xx(
 	hwif->autodma = 0;
 
 	hwif->set_pio_mode = &amd_set_pio_mode;
-	hwif->speedproc = &amd_set_drive;
+	hwif->set_dma_mode = &amd_set_drive;
 
 	for (i = 0; i < 2; i++) {
 		hwif->drives[i].io_32bit = 1;
@@ -437,7 +431,8 @@ static void __devinit init_hwif_amd74xx(
 		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},	\
 		.bootable	= ON_BOARD,				\
 		.host_flags	= IDE_HFLAG_PIO_NO_BLACKLIST		\
-				| IDE_HFLAG_PIO_NO_DOWNGRADE,		\
+				| IDE_HFLAG_PIO_NO_DOWNGRADE		\
+				| IDE_HFLAG_POST_SET_MODE,		\
 		.pio_mask	= ATA_PIO5,				\
 	}
 
@@ -450,7 +445,8 @@ static void __devinit init_hwif_amd74xx(
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},	\
 		.bootable	= ON_BOARD,				\
 		.host_flags	= IDE_HFLAG_PIO_NO_BLACKLIST		\
-				| IDE_HFLAG_PIO_NO_DOWNGRADE,		\
+				| IDE_HFLAG_PIO_NO_DOWNGRADE		\
+				| IDE_HFLAG_POST_SET_MODE,		\
 		.pio_mask	= ATA_PIO5,				\
 	}
 
Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -122,14 +122,14 @@ static void atiixp_dma_host_off(ide_driv
 }
 
 /**
- *	atiixp_tune_pio	-	tune a drive attached to a ATIIXP
- *	@drive: drive to tune
- *	@pio: desired PIO mode
+ *	atiixp_set_pio_mode	-	set host controller for PIO mode
+ *	@drive: drive
+ *	@pio: PIO mode number
  *
  *	Set the interface PIO mode.
  */
 
-static void atiixp_tune_pio(ide_drive_t *drive, u8 pio)
+static void atiixp_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	struct pci_dev *dev = drive->hwif->pci_dev;
 	unsigned long flags;
@@ -153,23 +153,16 @@ static void atiixp_tune_pio(ide_drive_t 
 	spin_unlock_irqrestore(&atiixp_lock, flags);
 }
 
-static void atiixp_set_pio_mode(ide_drive_t *drive, const u8 pio)
-{
-	atiixp_tune_pio(drive, pio);
-	(void)ide_config_drive_speed(drive, XFER_PIO_0 + pio);
-}
-
 /**
- *	atiixp_tune_chipset	-	tune a ATIIXP interface
- *	@drive: IDE drive to tune
- *	@speed: speed to configure
+ *	atiixp_set_dma_mode	-	set host controller for DMA mode
+ *	@drive: drive
+ *	@speed: DMA mode
  *
- *	Set a ATIIXP interface channel to the desired speeds. This involves
- *	requires the right timing data into the ATIIXP configuration space
- *	then setting the drive parameters appropriately
+ *	Set a ATIIXP host controller to the desired DMA mode.  This involves
+ *	programming the right timing data into the PCI configuration space.
  */
 
-static int atiixp_speedproc(ide_drive_t *drive, const u8 speed)
+static void atiixp_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 	struct pci_dev *dev = drive->hwif->pci_dev;
 	unsigned long flags;
@@ -204,9 +197,7 @@ static int atiixp_speedproc(ide_drive_t 
 	else
 		pio = speed - XFER_PIO_0;
 
-	atiixp_tune_pio(drive, pio);
-
-	return ide_config_drive_speed(drive, speed);
+	atiixp_set_pio_mode(drive, pio);
 }
 
 /**
@@ -249,7 +240,7 @@ static void __devinit init_hwif_atiixp(i
 
 	hwif->autodma = 0;
 	hwif->set_pio_mode = &atiixp_set_pio_mode;
-	hwif->speedproc = &atiixp_speedproc;
+	hwif->set_dma_mode = &atiixp_set_dma_mode;
 	hwif->drives[0].autotune = 1;
 	hwif->drives[1].autotune = 1;
 
Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -280,10 +280,9 @@ static void cmd64x_set_pio_mode(ide_driv
 		return;
 
 	cmd64x_tune_pio(drive, pio);
-	(void) ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
 
-static int cmd64x_tune_chipset(ide_drive_t *drive, const u8 speed)
+static void cmd64x_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
@@ -324,13 +323,11 @@ static int cmd64x_tune_chipset(ide_drive
 		program_cycle_times(drive, 480, 215);
 		break;
 	default:
-		return 1;
+		return;
 	}
 
 	if (speed >= XFER_SW_DMA_0)
 		(void) pci_write_config_byte(dev, pciU, regU);
-
-	return ide_config_drive_speed(drive, speed);
 }
 
 static int cmd64x_config_drive_for_dma (ide_drive_t *drive)
@@ -524,7 +521,7 @@ static void __devinit init_hwif_cmd64x(i
 	pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
 
 	hwif->set_pio_mode = &cmd64x_set_pio_mode;
-	hwif->speedproc = &cmd64x_tune_chipset;
+	hwif->set_dma_mode = &cmd64x_set_dma_mode;
 
 	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
 
Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -96,22 +96,13 @@ static void cs5520_set_pio_mode(ide_driv
 	reg = inb(hwif->dma_base + 0x02 + 8*controller);
 	reg |= 1<<((drive->dn&1)+5);
 	outb(reg, hwif->dma_base + 0x02 + 8*controller);
-
-	(void)ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
 
-static int cs5520_tune_chipset(ide_drive_t *drive, const u8 speed)
+static void cs5520_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 	printk(KERN_ERR "cs55x0: bad ide timing.\n");
 
 	cs5520_set_pio_mode(drive, 0);
-
-	/*
-	 * FIXME: this is incorrect to return zero here but
-	 * since all users of ide_set_xfer_rate() ignore
-	 * the return value it is not a problem currently
-	 */
-	return 0;
 }
 
 static int cs5520_config_drive_xfer_rate(ide_drive_t *drive)
@@ -150,7 +141,7 @@ static int cs5520_dma_on(ide_drive_t *dr
 static void __devinit init_hwif_cs5520(ide_hwif_t *hwif)
 {
 	hwif->set_pio_mode = &cs5520_set_pio_mode;
-	hwif->speedproc = &cs5520_tune_chipset;
+	hwif->set_dma_mode = &cs5520_set_dma_mode;
 	hwif->ide_dma_check = &cs5520_config_drive_xfer_rate;
 	hwif->ide_dma_on = &cs5520_dma_on;
 
Index: b/drivers/ide/pci/cs5530.c
===================================================================
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -30,22 +30,6 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-/**
- *	cs5530_xfer_set_mode	-	set a new transfer mode at the drive
- *	@drive: drive to tune
- *	@mode: new mode
- *
- *	Logging wrapper to the IDE driver speed configuration. This can
- *	probably go away now.
- */
- 
-static int cs5530_set_xfer_mode (ide_drive_t *drive, u8 mode)
-{
-	printk(KERN_DEBUG "%s: cs5530_set_xfer_mode(%s)\n",
-		drive->name, ide_xfer_verbose(mode));
-	return (ide_config_drive_speed(drive, mode));
-}
-
 /*
  * Here are the standard PIO mode 0-4 timings for each "format".
  * Format-0 uses fast data reg timings, with slower command reg timings.
@@ -62,20 +46,12 @@ static unsigned int cs5530_pio_timings[2
 #define CS5530_BAD_PIO(timings) (((timings)&~0x80000000)==0x0000e132)
 #define CS5530_BASEREG(hwif)	(((hwif)->dma_base & ~0xf) + ((hwif)->channel ? 0x30 : 0x20))
 
-static void cs5530_tunepio(ide_drive_t *drive, u8 pio)
-{
-	unsigned long basereg = CS5530_BASEREG(drive->hwif);
-	unsigned int format = (inl(basereg + 4) >> 31) & 1;
-
-	outl(cs5530_pio_timings[format][pio], basereg + ((drive->dn & 1)<<3));
-}
-
 /**
- *	cs5530_set_pio_mode	-	set PIO mode
+ *	cs5530_set_pio_mode	-	set host controller for PIO mode
  *	@drive: drive
  *	@pio: PIO mode number
  *
- *	Handles setting of PIO mode for both the chipset and drive.
+ *	Handles setting of PIO mode for the chipset.
  *
  *	The init_hwif_cs5530() routine guarantees that all drives
  *	will have valid default PIO timings set up before we get here.
@@ -83,8 +59,10 @@ static void cs5530_tunepio(ide_drive_t *
 
 static void cs5530_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	if (cs5530_set_xfer_mode(drive, XFER_PIO_0 + pio) == 0)
-		cs5530_tunepio(drive, pio);
+	unsigned long basereg = CS5530_BASEREG(drive->hwif);
+	unsigned int format = (inl(basereg + 4) >> 31) & 1;
+
+	outl(cs5530_pio_timings[format][pio], basereg + ((drive->dn & 1)<<3));
 }
 
 /**
@@ -142,20 +120,11 @@ static int cs5530_config_dma(ide_drive_t
 	return 1;
 }
 
-static int cs5530_tune_chipset(ide_drive_t *drive, const u8 mode)
+static void cs5530_set_dma_mode(ide_drive_t *drive, const u8 mode)
 {
 	unsigned long basereg;
 	unsigned int reg, timings = 0;
 
-	/*
-	 * Tell the drive to switch to the new mode; abort on failure.
-	 */
-	if (cs5530_set_xfer_mode(drive, mode))
-		return 1;	/* failure */
-
-	/*
-	 * Now tune the chipset to match the drive:
-	 */
 	switch (mode) {
 		case XFER_UDMA_0:	timings = 0x00921250; break;
 		case XFER_UDMA_1:	timings = 0x00911140; break;
@@ -180,8 +149,6 @@ static int cs5530_tune_chipset(ide_drive
 		outl(reg, basereg + 4);		/* write drive0 config register */
 		outl(timings, basereg + 12);	/* write drive1 config register */
 	}
-
-	return 0;	/* success */
 }
 
 /**
@@ -296,7 +263,7 @@ static void __devinit init_hwif_cs5530 (
 		hwif->serialized = hwif->mate->serialized = 1;
 
 	hwif->set_pio_mode = &cs5530_set_pio_mode;
-	hwif->speedproc = &cs5530_tune_chipset;
+	hwif->set_dma_mode = &cs5530_set_dma_mode;
 
 	basereg = CS5530_BASEREG(hwif);
 	d0_timings = inl(basereg + 0);
@@ -334,6 +301,7 @@ static ide_pci_device_t cs5530_chipset _
 	.autodma	= AUTODMA,
 	.bootable	= ON_BOARD,
 	.pio_mask	= ATA_PIO4,
+	.host_flags	= IDE_HFLAG_POST_SET_MODE,
 };
 
 static int __devinit cs5530_init_one(struct pci_dev *dev, const struct pci_device_id *id)
Index: b/drivers/ide/pci/cs5535.c
===================================================================
--- a/drivers/ide/pci/cs5535.c
+++ b/drivers/ide/pci/cs5535.c
@@ -131,26 +131,21 @@ static void cs5535_set_speed(ide_drive_t
 	}
 }
 
-/****
- *	cs5535_set_drive         -     Configure the drive to the new speed
- *	@drive: Drive to set up
- *	@speed: desired speed
+/**
+ *	cs5535_set_dma_mode	-	set host controller for DMA mode
+ *	@drive: drive
+ *	@speed: DMA mode
  *
- *	cs5535_set_drive() configures the drive and the chipset to a
- *	new speed. It also can be called by upper layers.
+ *	Programs the chipset for DMA mode.
  */
-static int cs5535_set_drive(ide_drive_t *drive, u8 speed)
-{
-	if (ide_config_drive_speed(drive, speed))
-		return 1;
 
+static void cs5535_set_dma_mode(ide_drive_t *drive, const u8 speed)
+{
 	cs5535_set_speed(drive, speed);
-
-	return 0;
 }
 
 /**
- *	cs5535_set_pio_mode	-	PIO setup
+ *	cs5535_set_pio_mode	-	set host controller for PIO mode
  *	@drive: drive
  *	@pio: PIO mode number
  *
@@ -159,9 +154,6 @@ static int cs5535_set_drive(ide_drive_t 
 
 static void cs5535_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	if (ide_config_drive_speed(drive, XFER_PIO_0 + pio))
-		return;
-
 	cs5535_set_speed(drive, XFER_PIO_0 + pio);
 }
 
@@ -203,7 +195,7 @@ static void __devinit init_hwif_cs5535(i
 	hwif->autodma = 0;
 
 	hwif->set_pio_mode = &cs5535_set_pio_mode;
-	hwif->speedproc = &cs5535_set_drive;
+	hwif->set_dma_mode = &cs5535_set_dma_mode;
 	hwif->ide_dma_check = &cs5535_dma_check;
 
 	hwif->atapi_dma = 1;
@@ -227,7 +219,7 @@ static ide_pci_device_t cs5535_chipset _
 	.init_hwif	= init_hwif_cs5535,
 	.autodma	= AUTODMA,
 	.bootable	= ON_BOARD,
-	.host_flags	= IDE_HFLAG_SINGLE,
+	.host_flags	= IDE_HFLAG_SINGLE | IDE_HFLAG_POST_SET_MODE,
 	.pio_mask	= ATA_PIO4,
 };
 
Index: b/drivers/ide/pci/hpt34x.c
===================================================================
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -43,7 +43,7 @@
 
 #define HPT343_DEBUG_DRIVE_INFO		0
 
-static int hpt34x_tune_chipset(ide_drive_t *drive, const u8 speed)
+static void hpt34x_set_mode(ide_drive_t *drive, const u8 speed)
 {
 	struct pci_dev *dev	= HWIF(drive)->pci_dev;
 	u32 reg1= 0, tmp1 = 0, reg2 = 0, tmp2 = 0;
@@ -73,13 +73,11 @@ static int hpt34x_tune_chipset(ide_drive
 		drive->dn, reg1, tmp1, reg2, tmp2,
 		hi_speed, lo_speed);
 #endif /* HPT343_DEBUG_DRIVE_INFO */
-
-	return(ide_config_drive_speed(drive, speed));
 }
 
 static void hpt34x_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	(void) hpt34x_tune_chipset(drive, (XFER_PIO_0 + pio));
+	hpt34x_set_mode(drive, XFER_PIO_0 + pio);
 }
 
 static int hpt34x_config_drive_xfer_rate (ide_drive_t *drive)
@@ -149,7 +147,8 @@ static void __devinit init_hwif_hpt34x(i
 	hwif->autodma = 0;
 
 	hwif->set_pio_mode = &hpt34x_set_pio_mode;
-	hwif->speedproc = &hpt34x_tune_chipset;
+	hwif->set_dma_mode = &hpt34x_set_mode;
+
 	hwif->drives[0].autotune = 1;
 	hwif->drives[1].autotune = 1;
 
Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -578,7 +578,7 @@ static u32 get_speed_setting(u8 speed, s
 	return (*info->settings)[i];
 }
 
-static int hpt36x_tune_chipset(ide_drive_t *drive, const u8 speed)
+static void hpt36x_set_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev  *dev	= hwif->pci_dev;
@@ -601,11 +601,9 @@ static int hpt36x_tune_chipset(ide_drive
 	new_itr &= ~0xc0000000;
 
 	pci_write_config_dword(dev, itr_addr, new_itr);
-
-	return ide_config_drive_speed(drive, speed);
 }
 
-static int hpt37x_tune_chipset(ide_drive_t *drive, const u8 speed)
+static void hpt37x_set_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev  *dev	= hwif->pci_dev;
@@ -625,24 +623,22 @@ static int hpt37x_tune_chipset(ide_drive
 	if (speed < XFER_MW_DMA_0)
 		new_itr &= ~0x80000000; /* Disable on-chip PIO FIFO/buffer */
 	pci_write_config_dword(dev, itr_addr, new_itr);
-
-	return ide_config_drive_speed(drive, speed);
 }
 
-static int hpt3xx_tune_chipset(ide_drive_t *drive, u8 speed)
+static void hpt3xx_set_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct hpt_info	*info	= pci_get_drvdata(hwif->pci_dev);
 
 	if (info->chip_type >= HPT370)
-		return hpt37x_tune_chipset(drive, speed);
+		hpt37x_set_mode(drive, speed);
 	else	/* hpt368: hpt_minimum_revision(dev, 2) */
-		return hpt36x_tune_chipset(drive, speed);
+		hpt36x_set_mode(drive, speed);
 }
 
 static void hpt3xx_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	(void) hpt3xx_tune_chipset (drive, XFER_PIO_0 + pio);
+	hpt3xx_set_mode(drive, XFER_PIO_0 + pio);
 }
 
 static int hpt3xx_quirkproc(ide_drive_t *drive)
@@ -1218,7 +1214,7 @@ static void __devinit init_hwif_hpt366(i
 	hwif->select_data		= hwif->channel ? 0x54 : 0x50;
 
 	hwif->set_pio_mode		= &hpt3xx_set_pio_mode;
-	hwif->speedproc			= &hpt3xx_tune_chipset;
+	hwif->set_dma_mode		= &hpt3xx_set_mode;
 	hwif->quirkproc			= &hpt3xx_quirkproc;
 	hwif->intrproc			= &hpt3xx_intrproc;
 	hwif->maskproc			= &hpt3xx_maskproc;
Index: b/drivers/ide/pci/it8213.c
===================================================================
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -48,15 +48,15 @@ static u8 it8213_dma_2_pio (u8 xfer_rate
 	}
 }
 
-/*
- *	it8213_tune_pio	-	tune a drive
- *	@drive: drive to tune
- *	@pio: desired PIO mode
+/**
+ *	it8213_set_pio_mode	-	set host controller for PIO mode
+ *	@drive: drive
+ *	@pio: PIO mode number
  *
  *	Set the interface PIO mode.
  */
 
-static void it8213_tune_pio(ide_drive_t *drive, const u8 pio)
+static void it8213_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
@@ -105,23 +105,15 @@ static void it8213_tune_pio(ide_drive_t 
 	spin_unlock_irqrestore(&tune_lock, flags);
 }
 
-static void it8213_set_pio_mode(ide_drive_t *drive, const u8 pio)
-{
-	it8213_tune_pio(drive, pio);
-	ide_config_drive_speed(drive, XFER_PIO_0 + pio);
-}
-
 /**
- *	it8213_tune_chipset	-	set controller timings
- *	@drive: Drive to set up
- *	@xferspeed: speed we want to achieve
+ *	it8213_set_dma_mode	-	set host controller for DMA mode
+ *	@drive: drive
+ *	@speed: DMA mode
  *
- *	Tune the ITE chipset for the desired mode. If we can't achieve
- *	the desired mode then tune for a lower one, but ultimately
- *	make the thing work.
+ *	Tune the ITE chipset for the DMA mode.
  */
 
-static int it8213_tune_chipset(ide_drive_t *drive, const u8 speed)
+static void it8213_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
@@ -154,7 +146,7 @@ static int it8213_tune_chipset(ide_drive
 		case XFER_SW_DMA_2:
 			break;
 		default:
-			return -1;
+			return;
 	}
 
 	if (speed >= XFER_UDMA_0) {
@@ -184,9 +176,7 @@ static int it8213_tune_chipset(ide_drive
 			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
 	}
 
-	it8213_tune_pio(drive, it8213_dma_2_pio(speed));
-
-	return ide_config_drive_speed(drive, speed);
+	it8213_set_pio_mode(drive, it8213_dma_2_pio(speed));
 }
 
 /**
@@ -222,7 +212,7 @@ static void __devinit init_hwif_it8213(i
 {
 	u8 reg42h = 0;
 
-	hwif->speedproc = &it8213_tune_chipset;
+	hwif->set_dma_mode = &it8213_set_dma_mode;
 	hwif->set_pio_mode = &it8213_set_pio_mode;
 
 	hwif->autodma = 0;
Index: b/drivers/ide/pci/it821x.c
===================================================================
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -229,24 +229,24 @@ static void it821x_clock_strategy(ide_dr
 }
 
 /**
- *	it821x_tunepio	-	tune a drive
- *	@drive: drive to tune
- *	@pio: the desired PIO mode
+ *	it821x_set_pio_mode	-	set host controller for PIO mode
+ *	@drive: drive
+ *	@pio: PIO mode number
  *
- *	Try to tune the drive/host to the desired PIO mode taking into
- *	the consideration the maximum PIO mode supported by the other
- *	device on the cable.
+ *	Tune the host to the desired PIO mode taking into the consideration
+ *	the maximum PIO mode supported by the other device on the cable.
  */
 
-static int it821x_tunepio(ide_drive_t *drive, u8 set_pio)
+static void it821x_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	ide_hwif_t *hwif	= drive->hwif;
 	struct it821x_dev *itdev = ide_get_hwifdata(hwif);
 	int unit = drive->select.b.unit;
 	ide_drive_t *pair = &hwif->drives[1 - unit];
+	u8 set_pio = pio;
 
 	/* Spec says 89 ref driver uses 88 */
-	static u16 pio[]	= { 0xAA88, 0xA382, 0xA181, 0x3332, 0x3121 };
+	static u16 pio_timings[]= { 0xAA88, 0xA382, 0xA181, 0x3332, 0x3121 };
 	static u8 pio_want[]    = { ATA_66, ATA_66, ATA_66, ATA_66, ATA_ANY };
 
 	/*
@@ -261,22 +261,12 @@ static int it821x_tunepio(ide_drive_t *d
 			set_pio = pair_pio;
 	}
 
-	if (itdev->smart)
-		return 0;
-
 	/* We prefer 66Mhz clock for PIO 0-3, don't care for PIO4 */
 	itdev->want[unit][1] = pio_want[set_pio];
 	itdev->want[unit][0] = 1;	/* PIO is lowest priority */
-	itdev->pio[unit] = pio[set_pio];
+	itdev->pio[unit] = pio_timings[set_pio];
 	it821x_clock_strategy(drive);
 	it821x_program(drive, itdev->pio[unit]);
-
-	return ide_config_drive_speed(drive, XFER_PIO_0 + set_pio);
-}
-
-static void it821x_set_pio_mode(ide_drive_t *drive, const u8 pio)
-{
-	(void)it821x_tunepio(drive, pio);
 }
 
 /**
@@ -405,47 +395,24 @@ static int it821x_dma_end(ide_drive_t *d
 }
 
 /**
- *	it821x_tune_chipset	-	set controller timings
- *	@drive: Drive to set up
- *	@speed: speed we want to achieve
+ *	it821x_set_dma_mode	-	set host controller for DMA mode
+ *	@drive: drive
+ *	@speed: DMA mode
  *
- *	Tune the ITE chipset for the desired mode.
+ *	Tune the ITE chipset for the desired DMA mode.
  */
 
-static int it821x_tune_chipset(ide_drive_t *drive, const u8 speed)
+static void it821x_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
-
-	ide_hwif_t *hwif	= drive->hwif;
-	struct it821x_dev *itdev = ide_get_hwifdata(hwif);
-
-	if (itdev->smart == 0) {
-		switch (speed) {
-			/* MWDMA tuning is really hard because our MWDMA and PIO
-			   timings are kept in the same place. We can switch in the
-			   host dma on/off callbacks */
-			case XFER_MW_DMA_2:
-			case XFER_MW_DMA_1:
-			case XFER_MW_DMA_0:
-				it821x_tune_mwdma(drive, (speed - XFER_MW_DMA_0));
-				break;
-			case XFER_UDMA_6:
-			case XFER_UDMA_5:
-			case XFER_UDMA_4:
-			case XFER_UDMA_3:
-			case XFER_UDMA_2:
-			case XFER_UDMA_1:
-			case XFER_UDMA_0:
-				it821x_tune_udma(drive, (speed - XFER_UDMA_0));
-				break;
-			default:
-				return 1;
-		}
-
-		return ide_config_drive_speed(drive, speed);
-	}
-
-	/* don't touch anything in the smart mode */
-	return 0;
+	/*
+	 * MWDMA tuning is really hard because our MWDMA and PIO
+	 * timings are kept in the same place.  We can switch in the
+	 * host dma on/off callbacks.
+	 */
+	if (speed >= XFER_UDMA_0 && speed <= XFER_UDMA_6)
+		it821x_tune_udma(drive, speed - XFER_UDMA_0);
+	else if (speed >= XFER_MW_DMA_0 && speed <= XFER_MW_DMA_2)
+		it821x_tune_mwdma(drive, speed - XFER_MW_DMA_0);
 }
 
 /**
@@ -629,14 +596,15 @@ static void __devinit init_hwif_it821x(i
 			printk(KERN_WARNING "it821x: Revision 0x10, workarounds activated.\n");
 	}
 
-	hwif->speedproc = &it821x_tune_chipset;
-	hwif->set_pio_mode = &it821x_set_pio_mode;
+	if (idev->smart == 0) {
+		hwif->set_pio_mode = &it821x_set_pio_mode;
+		hwif->set_dma_mode = &it821x_set_dma_mode;
 
-	/* MWDMA/PIO clock switching for pass through mode */
-	if(!idev->smart) {
+		/* MWDMA/PIO clock switching for pass through mode */
 		hwif->dma_start = &it821x_dma_start;
 		hwif->ide_dma_end = &it821x_dma_end;
-	}
+	} else
+		hwif->host_flags |= IDE_HFLAG_NO_SET_MODE;
 
 	hwif->drives[0].autotune = 1;
 	hwif->drives[1].autotune = 1;
Index: b/drivers/ide/pci/jmicron.c
===================================================================
--- a/drivers/ide/pci/jmicron.c
+++ b/drivers/ide/pci/jmicron.c
@@ -85,21 +85,18 @@ static u8 __devinit ata66_jmicron(ide_hw
 
 static void jmicron_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
 
 /**
- *	jmicron_tune_chipset	-	set controller timings
- *	@drive: Drive to set up
- *	@speed: speed we want to achieve
+ *	jmicron_set_dma_mode	-	set host controller for DMA mode
+ *	@drive: drive
+ *	@mode: DMA mode
  *
- *	As the JMicron snoops for timings all we actually need to do is
- *	set the transfer mode on the device.
+ *	As the JMicron snoops for timings we don't need to do anything here.
  */
 
-static int jmicron_tune_chipset(ide_drive_t *drive, const u8 speed)
+static void jmicron_set_dma_mode(ide_drive_t *drive, const u8 mode)
 {
-	return ide_config_drive_speed(drive, speed);
 }
 
 /**
@@ -129,8 +126,8 @@ static int jmicron_config_drive_for_dma 
 
 static void __devinit init_hwif_jmicron(ide_hwif_t *hwif)
 {
-	hwif->speedproc = &jmicron_tune_chipset;
 	hwif->set_pio_mode = &jmicron_set_pio_mode;
+	hwif->set_dma_mode = &jmicron_set_dma_mode;
 
 	hwif->drives[0].autotune = 1;
 	hwif->drives[1].autotune = 1;
Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -146,19 +146,16 @@ static struct udma_timing {
 	{ 0x1a, 0x01, 0xcb },	/* UDMA mode 6 */
 };
 
-static int pdcnew_tune_chipset(ide_drive_t *drive, const u8 speed)
+static void pdcnew_set_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	u8 adj			= (drive->dn & 1) ? 0x08 : 0x00;
 
 	/*
-	 * Issue SETFEATURES_XFER to the drive first. PDC202xx hardware will
+	 * IDE core issues SETFEATURES_XFER to the drive first (thanks to
+	 * IDE_HFLAG_POST_SET_MODE in ->host_flags).  PDC202xx hardware will
 	 * automatically set the timing registers based on 100 MHz PLL output.
-	 */
-	if (ide_config_drive_speed(drive, speed))
-		return 1;
-
-	/*
+	 *
 	 * As we set up the PLL to output 133 MHz for UltraDMA/133 capable
 	 * chips, we must override the default register settings...
 	 */
@@ -211,13 +208,11 @@ static int pdcnew_tune_chipset(ide_drive
 
 		set_indexed_reg(hwif, 0x10 + adj, tmp & 0x7f);
  	}
-
-	return 0;
 }
 
 static void pdcnew_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	(void)pdcnew_tune_chipset(drive, XFER_PIO_0 + pio);
+	pdcnew_set_mode(drive, XFER_PIO_0 + pio);
 }
 
 static u8 pdcnew_cable_detect(ide_hwif_t *hwif)
@@ -487,9 +482,9 @@ static void __devinit init_hwif_pdc202ne
 	hwif->autodma = 0;
 
 	hwif->set_pio_mode = &pdcnew_set_pio_mode;
+	hwif->set_dma_mode = &pdcnew_set_mode;
 
 	hwif->quirkproc = &pdcnew_quirkproc;
-	hwif->speedproc = &pdcnew_tune_chipset;
 	hwif->resetproc = &pdcnew_reset;
 
 	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
@@ -568,6 +563,7 @@ static ide_pci_device_t pdcnew_chipsets[
 		.bootable	= OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= 0x3f, /* udma0-5 */
+		.host_flags	= IDE_HFLAG_POST_SET_MODE,
 	},{	/* 1 */
 		.name		= "PDC20269",
 		.init_setup	= init_setup_pdcnew,
@@ -577,6 +573,7 @@ static ide_pci_device_t pdcnew_chipsets[
 		.bootable	= OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= 0x7f, /* udma0-6*/
+		.host_flags	= IDE_HFLAG_POST_SET_MODE,
 	},{	/* 2 */
 		.name		= "PDC20270",
 		.init_setup	= init_setup_pdc20270,
@@ -586,6 +583,7 @@ static ide_pci_device_t pdcnew_chipsets[
 		.bootable	= OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= 0x3f, /* udma0-5 */
+		.host_flags	= IDE_HFLAG_POST_SET_MODE,
 	},{	/* 3 */
 		.name		= "PDC20271",
 		.init_setup	= init_setup_pdcnew,
@@ -595,6 +593,7 @@ static ide_pci_device_t pdcnew_chipsets[
 		.bootable	= OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= 0x7f, /* udma0-6*/
+		.host_flags	= IDE_HFLAG_POST_SET_MODE,
 	},{	/* 4 */
 		.name		= "PDC20275",
 		.init_setup	= init_setup_pdcnew,
@@ -604,6 +603,7 @@ static ide_pci_device_t pdcnew_chipsets[
 		.bootable	= OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= 0x7f, /* udma0-6*/
+		.host_flags	= IDE_HFLAG_POST_SET_MODE,
 	},{	/* 5 */
 		.name		= "PDC20276",
 		.init_setup	= init_setup_pdc20276,
@@ -613,6 +613,7 @@ static ide_pci_device_t pdcnew_chipsets[
 		.bootable	= OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= 0x7f, /* udma0-6*/
+		.host_flags	= IDE_HFLAG_POST_SET_MODE,
 	},{	/* 6 */
 		.name		= "PDC20277",
 		.init_setup	= init_setup_pdcnew,
@@ -622,6 +623,7 @@ static ide_pci_device_t pdcnew_chipsets[
 		.bootable	= OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= 0x7f, /* udma0-6*/
+		.host_flags	= IDE_HFLAG_POST_SET_MODE,
 	}
 };
 
Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -63,7 +63,7 @@ static const char *pdc_quirk_drives[] = 
 
 static void pdc_old_disable_66MHz_clock(ide_hwif_t *);
 
-static int pdc202xx_tune_chipset(ide_drive_t *drive, const u8 speed)
+static void pdc202xx_set_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
@@ -138,13 +138,11 @@ static int pdc202xx_tune_chipset(ide_dri
 	pci_read_config_dword(dev, drive_pci, &drive_conf);
 	printk("0x%08x\n", drive_conf);
 #endif
-
-	return ide_config_drive_speed(drive, speed);
 }
 
 static void pdc202xx_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	pdc202xx_tune_chipset(drive, XFER_PIO_0 + pio);
+	pdc202xx_set_mode(drive, XFER_PIO_0 + pio);
 }
 
 static u8 pdc202xx_old_cable_detect (ide_hwif_t *hwif)
@@ -330,14 +328,13 @@ static void __devinit init_hwif_pdc202xx
 	hwif->autodma = 0;
 
 	hwif->set_pio_mode = &pdc202xx_set_pio_mode;
+	hwif->set_dma_mode = &pdc202xx_set_mode;
 
 	hwif->quirkproc = &pdc202xx_quirkproc;
 
 	if (hwif->pci_dev->device != PCI_DEVICE_ID_PROMISE_20246)
 		hwif->resetproc = &pdc202xx_reset;
 
-	hwif->speedproc = &pdc202xx_tune_chipset;
-
 	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
 
 	hwif->ultra_mask = hwif->cds->udma_mask;
Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -137,13 +137,14 @@ static u8 piix_dma_2_pio (u8 xfer_rate) 
 }
 
 /**
- *	piix_tune_pio		-	tune PIIX for PIO mode
- *	@drive: drive to tune
- *	@pio: desired PIO mode
+ *	piix_set_pio_mode	-	set host controller for PIO mode
+ *	@drive: drive
+ *	@pio: PIO mode number
  *
  *	Set the interface PIO mode based upon the settings done by AMI BIOS.
  */
-static void piix_tune_pio (ide_drive_t *drive, u8 pio)
+
+static void piix_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
@@ -204,31 +205,15 @@ static void piix_tune_pio (ide_drive_t *
 }
 
 /**
- *	piix_set_pio_mode	-	set PIO mode
- *	@drive: drive to tune
- *	@pio: desired PIO mode
- *
- *	Set the drive's PIO mode (might be useful if drive is not registered
- *	in CMOS for any reason).
- */
-
-static void piix_set_pio_mode(ide_drive_t *drive, const u8 pio)
-{
-	piix_tune_pio(drive, pio);
-	(void) ide_config_drive_speed(drive, XFER_PIO_0 + pio);
-}
-
-/**
- *	piix_tune_chipset	-	tune a PIIX interface
- *	@drive: IDE drive to tune
- *	@speed: speed to configure
+ *	piix_set_dma_mode	-	set host controller for DMA mode
+ *	@drive: drive
+ *	@speed: DMA mode
  *
- *	Set a PIIX interface channel to the desired speeds. This involves
- *	requires the right timing data into the PIIX configuration space
- *	then setting the drive parameters appropriately
+ *	Set a PIIX host controller to the desired DMA mode.  This involves
+ *	programming the right timing data into the PCI configuration space.
  */
 
-static int piix_tune_chipset(ide_drive_t *drive, const u8 speed)
+static void piix_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
@@ -259,7 +244,7 @@ static int piix_tune_chipset(ide_drive_t
 		case XFER_MW_DMA_2:
 		case XFER_MW_DMA_1:
 		case XFER_SW_DMA_2:	break;
-		default:		return -1;
+		default:		return;
 	}
 
 	if (speed >= XFER_UDMA_0) {
@@ -288,9 +273,7 @@ static int piix_tune_chipset(ide_drive_t
 			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
 	}
 
-	piix_tune_pio(drive, piix_dma_2_pio(speed));
-
-	return ide_config_drive_speed(drive, speed);
+	piix_set_pio_mode(drive, piix_dma_2_pio(speed));
 }
 
 /**
@@ -448,7 +431,8 @@ static void __devinit init_hwif_piix(ide
 	hwif->autodma = 0;
 
 	hwif->set_pio_mode = &piix_set_pio_mode;
-	hwif->speedproc = &piix_tune_chipset;
+	hwif->set_dma_mode = &piix_set_dma_mode;
+
 	hwif->drives[0].autotune = 1;
 	hwif->drives[1].autotune = 1;
 
Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -68,17 +68,6 @@ static unsigned short sc1200_get_pci_clo
 	return pci_clock;
 }
 
-extern char *ide_xfer_verbose (byte xfer_rate);
-
-/*
- * Set a new transfer mode at the drive
- */
-static int sc1200_set_xfer_mode (ide_drive_t *drive, byte mode)
-{
-	printk("%s: sc1200_set_xfer_mode(%s)\n", drive->name, ide_xfer_verbose(mode));
-	return ide_config_drive_speed(drive, mode);
-}
-
 /*
  * Here are the standard PIO mode 0-4 timings for each "format".
  * Format-0 uses fast data reg timings, with slower command reg timings.
@@ -138,7 +127,7 @@ out:
 	return mask;
 }
 
-static int sc1200_tune_chipset(ide_drive_t *drive, const u8 mode)
+static void sc1200_set_dma_mode(ide_drive_t *drive, const u8 mode)
 {
 	ide_hwif_t		*hwif = HWIF(drive);
 	int			unit = drive->select.b.unit;
@@ -146,17 +135,9 @@ static int sc1200_tune_chipset(ide_drive
 	unsigned short		pci_clock;
 	unsigned int		basereg = hwif->channel ? 0x50 : 0x40;
 
-	/*
-	 * Tell the drive to switch to the new mode; abort on failure.
-	 */
-	if (sc1200_set_xfer_mode(drive, mode))
-		return 1;	/* failure */
-
 	pci_clock = sc1200_get_pci_clock();
 
 	/*
-	 * Now tune the chipset to match the drive:
-	 *
 	 * Note that each DMA mode has several timings associated with it.
 	 * The correct timing depends on the fast PCI clock freq.
 	 */
@@ -216,8 +197,6 @@ static int sc1200_tune_chipset(ide_drive
 	} else {
 		pci_write_config_dword(hwif->pci_dev, basereg+12, timings);
 	}
-
-	return 0;	/* success */
 }
 
 /*
@@ -286,13 +265,12 @@ static void sc1200_set_pio_mode(ide_driv
 	if (mode != -1) {
 		printk("SC1200: %s: changing (U)DMA mode\n", drive->name);
 		hwif->dma_off_quietly(drive);
-		if (sc1200_tune_chipset(drive, mode) == 0)
+		if (ide_set_dma_mode(drive, mode) == 0)
 			hwif->dma_host_on(drive);
 		return;
 	}
 
-	if (sc1200_set_xfer_mode(drive, XFER_PIO_0 + pio) == 0)
-		sc1200_tunepio(drive, pio);
+	sc1200_tunepio(drive, pio);
 }
 
 #ifdef CONFIG_PM
@@ -408,7 +386,7 @@ static void __devinit init_hwif_sc1200 (
                 	hwif->autodma = 1;
 
 		hwif->set_pio_mode = &sc1200_set_pio_mode;
-		hwif->speedproc = &sc1200_tune_chipset;
+		hwif->set_dma_mode = &sc1200_set_dma_mode;
 	}
         hwif->atapi_dma = 1;
         hwif->ultra_mask = 0x07;
@@ -423,7 +401,7 @@ static ide_pci_device_t sc1200_chipset _
 	.init_hwif	= init_hwif_sc1200,
 	.autodma	= AUTODMA,
 	.bootable	= ON_BOARD,
-	.host_flags	= IDE_HFLAG_ABUSE_DMA_MODES,
+	.host_flags	= IDE_HFLAG_ABUSE_DMA_MODES | IDE_HFLAG_POST_SET_MODE,
 	.pio_mask	= ATA_PIO4,
 };
 
Index: b/drivers/ide/pci/scc_pata.c
===================================================================
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -190,15 +190,15 @@ scc_ide_outsl(unsigned long port, void *
 }
 
 /**
- *	scc_tune_pio	-	tune a drive PIO mode
- *	@drive: drive to tune
- *	@mode_wanted: the target operating mode
+ *	scc_set_pio_mode	-	set host controller for PIO mode
+ *	@drive: drive
+ *	@pio: PIO mode number
  *
  *	Load the timing settings for this device mode into the
  *	controller.
  */
 
-static void scc_tune_pio(ide_drive_t *drive, const u8 pio)
+static void scc_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	struct scc_ports *ports = ide_get_hwifdata(hwif);
@@ -221,22 +221,16 @@ static void scc_tune_pio(ide_drive_t *dr
 	out_be32((void __iomem *)pioct_port, reg);
 }
 
-static void scc_set_pio_mode(ide_drive_t *drive, const u8 pio)
-{
-	scc_tune_pio(drive, pio);
-	ide_config_drive_speed(drive, XFER_PIO_0 + pio);
-}
-
 /**
- *	scc_tune_chipset	-	tune a drive DMA mode
- *	@drive: Drive to set up
- *	@speed: speed we want to achieve
+ *	scc_set_dma_mode	-	set host controller for DMA mode
+ *	@drive: drive
+ *	@speed: DMA mode
  *
  *	Load the timing settings for this device mode into the
  *	controller.
  */
 
-static int scc_tune_chipset(ide_drive_t *drive, const u8 speed)
+static void scc_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	struct scc_ports *ports = ide_get_hwifdata(hwif);
@@ -271,7 +265,7 @@ static int scc_tune_chipset(ide_drive_t 
 		idx = speed - XFER_UDMA_0;
 		break;
 	default:
-		return 1;
+		return;
 	}
 
 	jcactsel = JCACTSELtbl[offset][idx];
@@ -287,8 +281,6 @@ static int scc_tune_chipset(ide_drive_t 
 	}
 	reg = JCTSStbl[offset][idx] << 16 | JCENVTtbl[offset][idx];
 	out_be32((void __iomem *)udenvt_port, reg);
-
-	return ide_config_drive_speed(drive, speed);
 }
 
 /**
@@ -708,8 +700,8 @@ static void __devinit init_hwif_scc(ide_
 
 	hwif->dma_setup = scc_dma_setup;
 	hwif->ide_dma_end = scc_ide_dma_end;
-	hwif->speedproc = scc_tune_chipset;
 	hwif->set_pio_mode = scc_set_pio_mode;
+	hwif->set_dma_mode = scc_set_dma_mode;
 	hwif->ide_dma_check = scc_config_drive_for_dma;
 	hwif->ide_dma_test_irq = scc_dma_test_irq;
 	hwif->udma_filter = scc_udma_filter;
Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -124,7 +124,7 @@ static u8 svwks_csb_check (struct pci_de
 	return 0;
 }
 
-static void svwks_tune_pio(ide_drive_t *drive, const u8 pio)
+static void svwks_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	static const u8 pio_modes[] = { 0x5d, 0x47, 0x34, 0x22, 0x20 };
 	static const u8 drive_pci[] = { 0x41, 0x40, 0x43, 0x42 };
@@ -145,7 +145,7 @@ static void svwks_tune_pio(ide_drive_t *
 	}
 }
 
-static int svwks_tune_chipset(ide_drive_t *drive, const u8 speed)
+static void svwks_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 	static const u8 udma_modes[]		= { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05 };
 	static const u8 dma_modes[]		= { 0x77, 0x21, 0x20 };
@@ -193,14 +193,6 @@ static int svwks_tune_chipset(ide_drive_
 	pci_write_config_byte(dev, drive_pci2[drive->dn], dma_timing);
 	pci_write_config_byte(dev, (0x56|hwif->channel), ultra_timing);
 	pci_write_config_byte(dev, 0x54, ultra_enable);
-
-	return (ide_config_drive_speed(drive, speed));
-}
-
-static void svwks_set_pio_mode(ide_drive_t *drive, const u8 pio)
-{
-	svwks_tune_pio(drive, pio);
-	(void)ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
 
 static int svwks_config_drive_xfer_rate (ide_drive_t *drive)
@@ -384,7 +376,7 @@ static void __devinit init_hwif_svwks (i
 		hwif->irq = hwif->channel ? 15 : 14;
 
 	hwif->set_pio_mode = &svwks_set_pio_mode;
-	hwif->speedproc = &svwks_tune_chipset;
+	hwif->set_dma_mode = &svwks_set_dma_mode;
 	hwif->udma_filter = &svwks_udma_filter;
 
 	hwif->atapi_dma = 1;
Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -291,12 +291,8 @@ static void sgiioc4_dma_off_quietly(ide_
 	drive->hwif->dma_host_off(drive);
 }
 
-static int sgiioc4_speedproc(ide_drive_t *drive, const u8 speed)
+static void sgiioc4_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
-	if (speed != XFER_MW_DMA_2)
-		return 1;
-
-	return ide_config_drive_speed(drive, speed);
 }
 
 static int sgiioc4_ide_dma_check(ide_drive_t *drive)
@@ -595,7 +591,7 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
 	hwif->mwdma_mask = 0x04;
 	hwif->pio_mask = 0x00;
 	hwif->set_pio_mode = NULL; /* Sets timing for PIO mode */
-	hwif->speedproc = &sgiioc4_speedproc;
+	hwif->set_dma_mode = &sgiioc4_set_dma_mode;
 	hwif->selectproc = NULL;/* Use the default routine to select drive */
 	hwif->reset_poll = NULL;/* No HBA specific reset_poll needed */
 	hwif->pre_reset = NULL;	/* No HBA specific pre_set needed */
Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -165,16 +165,16 @@ out:
 }
 
 /**
- *	sil_tune_pio	-	tune a drive
- *	@drive: drive to tune
- *	@pio: the desired PIO mode
+ *	sil_set_pio_mode	-	set host controller for PIO mode
+ *	@drive: drive
+ *	@pio: PIO mode number
  *
  *	Load the timing settings for this device mode into the
  *	controller. If we are in PIO mode 3 or 4 turn on IORDY
  *	monitoring (bit 9). The TF timing is bits 31:16
  */
 
-static void sil_tune_pio(ide_drive_t *drive, u8 pio)
+static void sil_set_pio_mode(ide_drive_t *drive, u8 pio)
 {
 	const u16 tf_speed[]	= { 0x328a, 0x2283, 0x1281, 0x10c3, 0x10c1 };
 	const u16 data_speed[]	= { 0x328a, 0x2283, 0x1104, 0x10c3, 0x10c1 };
@@ -234,21 +234,15 @@ static void sil_tune_pio(ide_drive_t *dr
 	}
 }
 
-static void sil_set_pio_mode(ide_drive_t *drive, const u8 pio)
-{
-	sil_tune_pio(drive, pio);
-	(void)ide_config_drive_speed(drive, XFER_PIO_0 + pio);
-}
-
 /**
- *	siimage_tune_chipset	-	set controller timings
- *	@drive: Drive to set up
- *	@speed: speed we want to achieve
+ *	sil_set_dma_mode	-	set host controller for DMA mode
+ *	@drive: drive
+ *	@speed: DMA mode
  *
- *	Tune the SII chipset for the desired mode.
+ *	Tune the SiI chipset for the desired DMA mode.
  */
 
-static int siimage_tune_chipset(ide_drive_t *drive, const u8 speed)
+static void sil_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 	u8 ultra6[]		= { 0x0F, 0x0B, 0x07, 0x05, 0x03, 0x02, 0x01 };
 	u8 ultra5[]		= { 0x0C, 0x07, 0x05, 0x04, 0x02, 0x01 };
@@ -303,7 +297,7 @@ static int siimage_tune_chipset(ide_driv
 			mode |= ((unit) ? 0x30 : 0x03);
 			break;
 		default:
-			return 1;
+			return;
 	}
 
 	if (hwif->mmio) {
@@ -315,7 +309,6 @@ static int siimage_tune_chipset(ide_driv
 		pci_write_config_word(hwif->pci_dev, ma, multi);
 		pci_write_config_word(hwif->pci_dev, ua, ultra);
 	}
-	return (ide_config_drive_speed(drive, speed));
 }
 
 /**
@@ -904,8 +897,8 @@ static void __devinit init_hwif_siimage(
 	hwif->autodma = 0;
 	
 	hwif->resetproc = &siimage_reset;
-	hwif->speedproc = &siimage_tune_chipset;
 	hwif->set_pio_mode = &sil_set_pio_mode;
+	hwif->set_dma_mode = &sil_set_dma_mode;
 	hwif->reset_poll = &siimage_reset_poll;
 	hwif->pre_reset = &siimage_pre_reset;
 	hwif->udma_filter = &sil_udma_filter;
Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -451,7 +451,7 @@ static void config_drive_art_rwp (ide_dr
 }
 
 /* Set per-drive active and recovery time */
-static void config_art_rwp_pio (ide_drive_t *drive, u8 pio)
+static void sis_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
@@ -519,20 +519,14 @@ static void config_art_rwp_pio (ide_driv
 	}
 }
 
-static void sis_set_pio_mode(ide_drive_t *drive, const u8 pio)
-{
-	config_art_rwp_pio(drive, pio);
-	(void)ide_config_drive_speed(drive, XFER_PIO_0 + pio);
-}
-
-static int sis5513_tune_chipset(ide_drive_t *drive, const u8 speed)
+static void sis_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
 	u32 regdw;
 	u8 drive_pci, reg;
 
-	/* See config_art_rwp_pio for drive pci config registers */
+	/* See sis_set_pio_mode() for drive PCI config registers */
 	drive_pci = 0x40;
 	if (chipset_family >= ATA_133) {
 		u32 reg54h;
@@ -600,8 +594,6 @@ static int sis5513_tune_chipset(ide_driv
 			BUG();
 			break;
 	}
-
-	return ide_config_drive_speed(drive, speed);
 }
 
 static int sis5513_config_xfer_rate(ide_drive_t *drive)
@@ -841,7 +833,7 @@ static void __devinit init_hwif_sis5513 
 		hwif->irq = hwif->channel ? 15 : 14;
 
 	hwif->set_pio_mode = &sis_set_pio_mode;
-	hwif->speedproc = &sis5513_tune_chipset;
+	hwif->set_dma_mode = &sis_set_dma_mode;
 
 	if (chipset_family >= ATA_133)
 		hwif->udma_filter = sis5513_ata133_udma_filter;
Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -75,7 +75,7 @@ static unsigned int get_pio_timings(ide_
 /*
  * Configure the chipset for PIO mode.
  */
-static void sl82c105_tune_pio(ide_drive_t *drive, const u8 pio)
+static void sl82c105_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	struct pci_dev *dev	= HWIF(drive)->pci_dev;
 	int reg			= 0x44 + drive->dn * 4;
@@ -105,9 +105,9 @@ static void sl82c105_tune_pio(ide_drive_
 }
 
 /*
- * Configure the drive and chipset for a new transfer speed.
+ * Configure the chipset for DMA mode.
  */
-static int sl82c105_tune_chipset(ide_drive_t *drive, const u8 speed)
+static void sl82c105_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 	static u16 mwdma_timings[] = {0x0707, 0x0201, 0x0200};
 	u16 drv_ctrl;
@@ -140,10 +140,8 @@ static int sl82c105_tune_chipset(ide_dri
 		}
 		break;
 	default:
-		return -1;
+		return;
 	}
-
-	return ide_config_drive_speed(drive, speed);
 }
 
 /*
@@ -306,17 +304,6 @@ static void sl82c105_resetproc(ide_drive
 	pci_read_config_dword(dev, 0x40, &val);
 	pci_set_drvdata(dev, (void *)val);
 }
-	
-/*
- * We only deal with PIO mode here - DMA mode 'using_dma' is not
- * initialised at the point that this function is called.
- */
-static void sl82c105_set_pio_mode(ide_drive_t *drive, const u8 pio)
-{
-	sl82c105_tune_pio(drive, pio);
-
-	(void) ide_config_drive_speed(drive, XFER_PIO_0 + pio);
-}
 
 /*
  * Return the revision of the Winbond bridge
@@ -383,7 +370,7 @@ static void __devinit init_hwif_sl82c105
 	DBG(("init_hwif_sl82c105(hwif: ide%d)\n", hwif->index));
 
 	hwif->set_pio_mode	= &sl82c105_set_pio_mode;
-	hwif->speedproc 	= &sl82c105_tune_chipset;
+	hwif->set_dma_mode	= &sl82c105_set_dma_mode;
 	hwif->selectproc	= &sl82c105_selectproc;
 	hwif->resetproc 	= &sl82c105_resetproc;
 
Index: b/drivers/ide/pci/slc90e66.c
===================================================================
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -42,7 +42,7 @@ static u8 slc90e66_dma_2_pio (u8 xfer_ra
 	}
 }
 
-static void slc90e66_tune_pio (ide_drive_t *drive, u8 pio)
+static void slc90e66_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
@@ -95,13 +95,7 @@ static void slc90e66_tune_pio (ide_drive
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
-static void slc90e66_set_pio_mode(ide_drive_t *drive, const u8 pio)
-{
-	slc90e66_tune_pio(drive, pio);
-	(void) ide_config_drive_speed(drive, XFER_PIO_0 + pio);
-}
-
-static int slc90e66_tune_chipset(ide_drive_t *drive, const u8 speed)
+static void slc90e66_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
@@ -125,7 +119,7 @@ static int slc90e66_tune_chipset(ide_dri
 		case XFER_MW_DMA_2:
 		case XFER_MW_DMA_1:
 		case XFER_SW_DMA_2:	break;
-		default:		return -1;
+		default:		return;
 	}
 
 	if (speed >= XFER_UDMA_0) {
@@ -144,9 +138,7 @@ static int slc90e66_tune_chipset(ide_dri
 			pci_write_config_word(dev, 0x4a, reg4a & ~a_speed);
 	}
 
-	slc90e66_tune_pio(drive, slc90e66_dma_2_pio(speed));
-
-	return ide_config_drive_speed(drive, speed);
+	slc90e66_set_pio_mode(drive, slc90e66_dma_2_pio(speed));
 }
 
 static int slc90e66_config_drive_xfer_rate (ide_drive_t *drive)
@@ -172,8 +164,8 @@ static void __devinit init_hwif_slc90e66
 	if (!hwif->irq)
 		hwif->irq = hwif->channel ? 15 : 14;
 
-	hwif->speedproc = &slc90e66_tune_chipset;
 	hwif->set_pio_mode = &slc90e66_set_pio_mode;
+	hwif->set_dma_mode = &slc90e66_set_dma_mode;
 
 	pci_read_config_byte(hwif->pci_dev, 0x47, &reg47);
 
Index: b/drivers/ide/pci/tc86c001.c
===================================================================
--- a/drivers/ide/pci/tc86c001.c
+++ b/drivers/ide/pci/tc86c001.c
@@ -13,7 +13,7 @@
 #include <linux/pci.h>
 #include <linux/ide.h>
 
-static int tc86c001_tune_chipset(ide_drive_t *drive, const u8 speed)
+static void tc86c001_set_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	unsigned long scr_port	= hwif->config_data + (drive->dn ? 0x02 : 0x00);
@@ -39,13 +39,11 @@ static int tc86c001_tune_chipset(ide_dri
 	scr &= (speed < XFER_MW_DMA_0) ? 0xf8ff : 0xff0f;
 	scr |= mode;
 	outw(scr, scr_port);
-
-	return ide_config_drive_speed(drive, speed);
 }
 
 static void tc86c001_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	(void) tc86c001_tune_chipset(drive, XFER_PIO_0 + pio);
+	tc86c001_set_mode(drive, XFER_PIO_0 + pio);
 }
 
 /*
@@ -193,7 +191,8 @@ static void __devinit init_hwif_tc86c001
 	hwif->config_data = sc_base;
 
 	hwif->set_pio_mode = &tc86c001_set_pio_mode;
-	hwif->speedproc = &tc86c001_tune_chipset;
+	hwif->set_dma_mode = &tc86c001_set_mode;
+
 	hwif->busproc	= &tc86c001_busproc;
 
 	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
Index: b/drivers/ide/pci/triflex.c
===================================================================
--- a/drivers/ide/pci/triflex.c
+++ b/drivers/ide/pci/triflex.c
@@ -40,7 +40,7 @@
 #include <linux/ide.h>
 #include <linux/init.h>
 
-static int triflex_tune_chipset(ide_drive_t *drive, const u8 speed)
+static void triflex_set_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	struct pci_dev *dev = hwif->pci_dev;
@@ -82,20 +82,18 @@ static int triflex_tune_chipset(ide_driv
 			timing = 0x0808;
 			break;
 		default:
-			return -1;
+			return;
 	}
 
 	triflex_timings &= ~(0xFFFF << (16 * unit));
 	triflex_timings |= (timing << (16 * unit));
 	
 	pci_write_config_dword(dev, channel_offset, triflex_timings);
-	
-	return (ide_config_drive_speed(drive, speed));
 }
 
 static void triflex_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	(void)triflex_tune_chipset(drive, XFER_PIO_0 + pio);
+	triflex_set_mode(drive, XFER_PIO_0 + pio);
 }
 
 static int triflex_config_drive_xfer_rate(ide_drive_t *drive)
@@ -111,7 +109,7 @@ static int triflex_config_drive_xfer_rat
 static void __devinit init_hwif_triflex(ide_hwif_t *hwif)
 {
 	hwif->set_pio_mode = &triflex_set_pio_mode;
-	hwif->speedproc = &triflex_tune_chipset;
+	hwif->set_dma_mode = &triflex_set_mode;
 
 	hwif->atapi_dma  = 1;
 	hwif->mwdma_mask = 0x07;
Index: b/drivers/ide/pci/via82cxxx.c
===================================================================
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -152,21 +152,17 @@ static void via_set_speed(ide_hwif_t *hw
  *	@drive: Drive to set up
  *	@speed: desired speed
  *
- *	via_set_drive() computes timing values configures the drive and
- *	the chipset to a desired transfer mode. It also can be called
- *	by upper layers.
+ *	via_set_drive() computes timing values configures the chipset to
+ *	a desired transfer mode.  It also can be called by upper layers.
  */
 
-static int via_set_drive(ide_drive_t *drive, const u8 speed)
+static void via_set_drive(ide_drive_t *drive, const u8 speed)
 {
 	ide_drive_t *peer = HWIF(drive)->drives + (~drive->dn & 1);
 	struct via82cxxx_dev *vdev = pci_get_drvdata(drive->hwif->pci_dev);
 	struct ide_timing t, p;
 	unsigned int T, UT;
 
-	if (ide_config_drive_speed(drive, speed))
-		return 1;
-
 	T = 1000000000 / via_clock;
 
 	switch (vdev->via_config->udma_mask) {
@@ -185,12 +181,10 @@ static int via_set_drive(ide_drive_t *dr
 	}
 
 	via_set_speed(HWIF(drive), drive->dn, &t);
-
-	return 0;
 }
 
 /**
- *	via_set_pio_mode	-	PIO setup
+ *	via_set_pio_mode	-	set host controller for PIO mode
  *	@drive: drive
  *	@pio: PIO mode number
  *
@@ -444,8 +438,7 @@ static void __devinit init_hwif_via82cxx
 	hwif->autodma = 0;
 
 	hwif->set_pio_mode = &via_set_pio_mode;
-	hwif->speedproc = &via_set_drive;
-
+	hwif->set_dma_mode = &via_set_drive;
 
 #ifdef CONFIG_PPC_CHRP
 	if(machine_is(chrp) && _chrp_type == _CHRP_Pegasos) {
@@ -488,7 +481,8 @@ static ide_pci_device_t via82cxxx_chipse
 		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
 		.bootable	= ON_BOARD,
 		.host_flags	= IDE_HFLAG_PIO_NO_BLACKLIST
-				| IDE_HFLAG_PIO_NO_DOWNGRADE,
+				| IDE_HFLAG_PIO_NO_DOWNGRADE
+				| IDE_HFLAG_POST_SET_MODE,
 		.pio_mask	= ATA_PIO5,
 	},{	/* 1 */
 		.name		= "VP_IDE",
@@ -498,7 +492,8 @@ static ide_pci_device_t via82cxxx_chipse
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
 		.host_flags	= IDE_HFLAG_PIO_NO_BLACKLIST
-				| IDE_HFLAG_PIO_NO_DOWNGRADE,
+				| IDE_HFLAG_PIO_NO_DOWNGRADE
+				| IDE_HFLAG_POST_SET_MODE,
 		.pio_mask	= ATA_PIO5,
 	}
 };
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -610,9 +610,6 @@ pmac_ide_set_pio_mode(ide_drive_t *drive
 		drive->name, pio,  *timings);
 #endif	
 
-	if (ide_config_drive_speed(drive, XFER_PIO_0 + pio))
-		return;
-
 	pmac_ide_do_update_timings(drive);
 }
 
@@ -820,11 +817,7 @@ set_timings_mdma(ide_drive_t *drive, int
 }
 #endif /* #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC */
 
-/* 
- * Speedproc. This function is called by the core to set any of the standard
- * timing (PIO, MDMA or UDMA) to both the drive and the controller.
- */
-static int pmac_ide_tune_chipset(ide_drive_t *drive, const u8 speed)
+static void pmac_ide_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 	int unit = (drive->select.b.unit & 0x01);
 	int ret = 0;
@@ -865,25 +858,19 @@ static int pmac_ide_tune_chipset(ide_dri
 		case XFER_SW_DMA_2:
 		case XFER_SW_DMA_1:
 		case XFER_SW_DMA_0:
-			return 1;
+			return;
 #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
 		default:
 			ret = 1;
 	}
 	if (ret)
-		return ret;
-
-	ret = ide_config_drive_speed(drive, speed);
-	if (ret)
-		return ret;
+		return;
 
 	/* Apply timings to controller */
 	*timings = tl[0];
 	*timings2 = tl[1];
 
 	pmac_ide_do_update_timings(drive);	
-
-	return 0;
 }
 
 /*
@@ -1143,7 +1130,8 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
 	hwif->cbl = pmif->cable_80 ? ATA_CBL_PATA80 : ATA_CBL_PATA40;
 	hwif->drives[0].unmask = 1;
 	hwif->drives[1].unmask = 1;
-	hwif->host_flags = IDE_HFLAG_SET_PIO_MODE_KEEP_DMA;
+	hwif->host_flags = IDE_HFLAG_SET_PIO_MODE_KEEP_DMA |
+			   IDE_HFLAG_POST_SET_MODE;
 	hwif->pio_mask = ATA_PIO4;
 	hwif->set_pio_mode = pmac_ide_set_pio_mode;
 	if (pmif->kind == controller_un_ata6
@@ -1152,7 +1140,7 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
 		hwif->selectproc = pmac_ide_kauai_selectproc;
 	else
 		hwif->selectproc = pmac_ide_selectproc;
-	hwif->speedproc = pmac_ide_tune_chipset;
+	hwif->set_dma_mode = pmac_ide_set_dma_mode;
 
 	printk(KERN_INFO "ide%d: Found Apple %s controller, bus ID %d%s, irq %d\n",
 	       hwif->index, model_name[pmif->kind], pmif->aapl_bus_id,
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -681,7 +681,7 @@ typedef struct hwif_s {
 	u8 straight8;	/* Alan's straight 8 check */
 	u8 bus_state;	/* power state of the IDE bus */
 
-	u8 host_flags;
+	u16 host_flags;
 
 	u8 pio_mask;
 
@@ -702,10 +702,10 @@ typedef struct hwif_s {
 #if 0
 	ide_hwif_ops_t	*hwifops;
 #else
-	/* routine to set PIO mode for drives */
+	/* routine to program host for PIO mode */
 	void	(*set_pio_mode)(ide_drive_t *, const u8);
-	/* routine to retune DMA modes for drives */
-	int	(*speedproc)(ide_drive_t *, const u8);
+	/* routine to program host for DMA mode */
+	void	(*set_dma_mode)(ide_drive_t *, const u8);
 	/* tweaks hardware to select drive */
 	void	(*selectproc)(ide_drive_t *);
 	/* chipset polling based on hba specifics */
@@ -1256,6 +1256,10 @@ enum {
 	 * for hosts which have separate PIO and DMA timings (ie. PMAC)
 	 */
 	IDE_HFLAG_SET_PIO_MODE_KEEP_DMA	= (1 << 7),
+	/* program host for the transfer mode after programming device */
+	IDE_HFLAG_POST_SET_MODE		= (1 << 8),
+	/* don't program host/device for the transfer mode ("smart" hosts) */
+	IDE_HFLAG_NO_SET_MODE		= (1 << 9),
 };
 
 typedef struct ide_pci_device_s {
@@ -1272,7 +1276,7 @@ typedef struct ide_pci_device_s {
 	u8			bootable;
 	unsigned int		extra;
 	struct ide_pci_device_s	*next;
-	u8			host_flags;
+	u16			host_flags;
 	u8			pio_mask;
 	u8			udma_mask;
 } ide_pci_device_t;
@@ -1398,6 +1402,9 @@ unsigned int ide_pio_cycle_time(ide_driv
 u8 ide_get_best_pio_mode(ide_drive_t *, u8, u8);
 extern const ide_pio_timings_t ide_pio_timings[6];
 
+int ide_set_pio_mode(ide_drive_t *, u8);
+int ide_set_dma_mode(ide_drive_t *, u8);
+
 void ide_set_pio(ide_drive_t *, u8);
 
 static inline void ide_set_max_pio(ide_drive_t *drive)

