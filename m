From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: move ide_config_drive_speed() calls to upper layers
Date: Sun, 29 Jul 2007 16:28:40 +0400
Message-ID: <46AC87F8.7050508@ru.mvista.com>
References: <200707270222.28230.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:55998 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1761926AbXG2M0l (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Jul 2007 08:26:41 -0400
In-Reply-To: <200707270222.28230.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello again. :-)

Bartlomiej Zolnierkiewicz wrote:

> * Convert {ide_hwif_t,ide_pci_device_t}->host_flag to be u16.

> * Add IDE_HFLAG_POST_SET_MODE host to indicate the need to program the
>   host for the transfer mode after programming the device.  Set it in
>   au1xxx-ide/cs5530/cs5535/pdc202xx_new/sc1200/via82cxxx host drivers.

    Well, I've already commented about the necessity of this flag...

> * Add IDE_HFLAG_NO_SET_MODE host flags to indicate the need to completely
>   skip programming of host/device for the transfer mode ("smart" hosts).
>   Set it in it821x host driver.

    Now this flag seems completely artificial to me.  I suggest instead to
just not "install" the set_{pio|dma}_mode() methods at the driver startup when
the chips are in smart mode.

> * Handle ->set_pio_mode abuse wrt to setting DMA modes in do_special()
>   instead of sc1200.c::sc1200_set_pio_mode().

    I'm not sure it was a great idea to carry the code specific to only one
driver into the generic code.  Why not leave it where it was?

> * Add ide_set_pio_mode()/ide_set_dma_mode() helpers and convert all
>   direct ->set_pio_mode/->speedproc users to use these helpers.

> * Move ide_config_drive_speed() calls from ->set_pio_mode/->speedproc
>   methods to callers.

> * Rename ->speedproc method to ->set_dma_mode, make it void and update
>   all implementations accordingly.

> * Update ide_set_xfer_rate() comments.

> Except removal of two debugging printk-s (from cs5530.c and sc1200.c)
> and the fact that transfer modes 0x00-0x07 passed from user space may
> be programmed twice on the device (not really an issue since 0x00-0x01
> are handled by very few host drivers and 0x02-0x07 are simply invalid)
> there should be no other functionality changes caused by this patch.

    Haven't see any driver handling 0x01. 0x00 is usually handled by setting
PIO0 or even slower mode which isn't quite correct.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> Index: b/drivers/ide/ide-io.c
> ===================================================================
> --- a/drivers/ide/ide-io.c
> +++ b/drivers/ide/ide-io.c
> @@ -834,6 +834,26 @@ static ide_startstop_t do_special (ide_d
>  		s->b.set_tune = 0;
>  
>  		if (set_pio_mode_abuse(drive->hwif, req_pio)) {
> +			int mode = -1;
> +
> +			switch (req_pio) {
> +			case 200: mode = XFER_UDMA_0;	break;
> +			case 201: mode = XFER_UDMA_1;	break;
> +			case 202: mode = XFER_UDMA_2;	break;
> +			case 100: mode = XFER_MW_DMA_0;	break;
> +			case 101: mode = XFER_MW_DMA_1;	break;
> +			case 102: mode = XFER_MW_DMA_2;	break;
> +			}
> +
> +			if (mode != -1) {
> +				printk(KERN_INFO "%s: changing (U)DMA mode\n",
> +						 drive->name);
> +				hwif->dma_off_quietly(drive);
> +				if (ide_set_dma_mode(drive, mode) == 0)
> +					hwif->dma_host_on(drive);
> +				return ide_stopped;
> +			}
> +

    So, I'm doubtful about this part.  Could you clarify why/whether you deem
it necassary?

> Index: b/drivers/ide/ide-lib.c
> ===================================================================
> --- a/drivers/ide/ide-lib.c
> +++ b/drivers/ide/ide-lib.c
> @@ -349,7 +349,7 @@ void ide_set_pio(ide_drive_t *drive, u8 
>  			  drive->name, host_pio, req_pio,
>  			  req_pio == 255 ? "(auto-tune)" : "", pio);
>  
> -	hwif->set_pio_mode(drive, pio);
> +	(void)ide_set_pio_mode(drive, XFER_PIO_0 + pio);
>  }
>  
>  EXPORT_SYMBOL_GPL(ide_set_pio);
> @@ -378,39 +378,85 @@ void ide_toggle_bounce(ide_drive_t *driv
>  		blk_queue_bounce_limit(drive->queue, addr);
>  }
>  
> +int ide_set_pio_mode(ide_drive_t *drive, const u8 mode)
> +{
> +	ide_hwif_t *hwif = drive->hwif;
> +
> +	if (hwif->host_flags & IDE_HFLAG_NO_SET_MODE)
> +		return 0;

    I think that we should not a lie to a user if we can *not* set the
transfer mode that he requested. So, I suggest that this be replaced by:

	if (hwif->set_pio_mode == NULL)
		return -1;

> +
> +	/*
> +	 * TODO: temporary hack for some legacy host drivers that didn't
> +	 * set transfer mode on the device in ->set_pio_mode method...
> +	 */
> +	if (hwif->set_dma_mode == NULL) {
> +		hwif->set_pio_mode(drive, mode - XFER_PIO_0);
> +		return 0;
> +	}

    Er... I didn't quite get it. :-/
    You mean those that are still unfixed WRT not calling
ide_config_drive_speed()?

> +
> +	if (hwif->host_flags & IDE_HFLAG_POST_SET_MODE) {
> +		if (ide_config_drive_speed(drive, mode))
> +			return -1;
> +		hwif->set_pio_mode(drive, mode - XFER_PIO_0);
> +		return 0;
> +	} else {
> +		hwif->set_pio_mode(drive, mode - XFER_PIO_0);
> +		return ide_config_drive_speed(drive, mode);
> +	}
> +}
> +
> +int ide_set_dma_mode(ide_drive_t *drive, const u8 mode)
> +{
> +	ide_hwif_t *hwif = drive->hwif;
> +
> +	if (hwif->host_flags & IDE_HFLAG_NO_SET_MODE)
> +		return 0;

    I suggest that this be replaced by:

	if (hwif->set_dma_mode == NULL)
		return -1;

> +	if (hwif->host_flags & IDE_HFLAG_POST_SET_MODE) {
> +		if (ide_config_drive_speed(drive, mode))
> +			return -1;
> +		hwif->set_dma_mode(drive, mode);
> +		return 0;
> +	} else {
> +		hwif->set_dma_mode(drive, mode);
> +		return ide_config_drive_speed(drive, mode);
> +	}
> +}
> +
>  /**
>   *	ide_set_xfer_rate	-	set transfer rate
>   *	@drive: drive to set
> - *	@speed: speed to attempt to set
> + *	@rate: speed to attempt to set
>   *	
>   *	General helper for setting the speed of an IDE device. This
>   *	function knows about user enforced limits from the configuration
> - *	which speedproc() does not.  High level drivers should never
> - *	invoke speedproc() directly.
> + *	which ->set_pio_mode/->set_dma_mode does not.
>   */
> - 
> +
>  int ide_set_xfer_rate(ide_drive_t *drive, u8 rate)
>  {
>  	ide_hwif_t *hwif = drive->hwif;
>  
> -	if (hwif->speedproc == NULL)
> +	if (hwif->set_dma_mode == NULL)
>  		return -1;
>  
>  	rate = ide_rate_filter(drive, rate);
>  
>  	if (rate >= XFER_PIO_0 && rate <= XFER_PIO_5) {
>  		if (hwif->set_pio_mode)

    Won't be needed if we'll check it inside ide_set_pio_mode().

> -			hwif->set_pio_mode(drive, rate - XFER_PIO_0);
> +			return ide_set_pio_mode(drive, rate);
>  
> -		/*
> -		 * FIXME: this is incorrect to return zero here but
> -		 * since all users of ide_set_xfer_rate() ignore
> -		 * the return value it is not a problem currently
> -		 */
> -		return 0;
> +		return -1;
>  	}
>  
> -	return hwif->speedproc(drive, rate);
> +	/*
> +	 * TODO: transfer modes 0x00-0x07 passed from the user-space are
> +	 * currently handled here which needs fixing (please note that such
> +	 * case could happen iff the transfer mode has already been set on
> +	 * the device by ide-proc.c::set_xfer_rate()).
> +	 */

    Would be quite easy to hook and *properly* handle mode 0x00 here, however
mode 0x01 would certainly be much trickier -- unless we'd want to delegate it
to set_pio_mode() itself (I'm not suggesting it though :-)...

> +
> +	return ide_set_dma_mode(drive, rate);
>  }
>  
>  static void ide_dump_opcode(ide_drive_t *drive)
> Index: b/drivers/ide/mips/au1xxx-ide.c
> ===================================================================
> --- a/drivers/ide/mips/au1xxx-ide.c
> +++ b/drivers/ide/mips/au1xxx-ide.c
> @@ -101,11 +101,7 @@ void auide_outsw(unsigned long port, voi
>  
>  static void au1xxx_set_pio_mode(ide_drive_t *drive, const u8 pio)
>  {
> -	int mem_sttime;
> -	int mem_stcfg;
> -
> -	if (ide_config_drive_speed(drive, pio + XFER_PIO_0))
> -		return;
> +	int mem_sttime, mem_stcfg;
>  
>  	mem_sttime = 0;

    Could initialize mem_sttime right in the declaration.

>  	mem_stcfg  = au_readl(MEM_STCFG2);

    Well, this one too... :-)

> @@ -168,10 +164,9 @@ static void au1xxx_set_pio_mode(ide_driv
>  	au_writel(mem_stcfg,MEM_STCFG2);
>  }
>  
> -static int auide_tune_chipset(ide_drive_t *drive, const u8 speed)
> +static void auide_set_dma_mode(ide_drive_t *drive, const u8 speed)
>  {
> -	int mem_sttime;
> -	int mem_stcfg;
> +	int mem_sttime, mem_stcfg;
>  
>  	mem_sttime = 0;
>  	mem_stcfg  = au_readl(MEM_STCFG2);

    Same here...

> @@ -681,6 +671,7 @@ static int au_ide_probe(struct device *d
>  #endif
>  
>  	hwif->pio_mask = ATA_PIO4;
> +	hwif->host_flags = IDE_HFLAG_POST_SET_MODE;

    As I already said, this flag doesn't seem needed...

> Index: b/drivers/ide/pci/amd74xx.c
> ===================================================================
> --- a/drivers/ide/pci/amd74xx.c
> +++ b/drivers/ide/pci/amd74xx.c
> @@ -229,20 +229,16 @@ static void amd_set_speed(struct pci_dev
[...]
> @@ -437,7 +431,8 @@ static void __devinit init_hwif_amd74xx(
>  		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},	\
>  		.bootable	= ON_BOARD,				\
>  		.host_flags	= IDE_HFLAG_PIO_NO_BLACKLIST		\
> -				| IDE_HFLAG_PIO_NO_DOWNGRADE,		\
> +				| IDE_HFLAG_PIO_NO_DOWNGRADE		\
> +				| IDE_HFLAG_POST_SET_MODE,		\
>  		.pio_mask	= ATA_PIO5,				\
>  	}
>  
> @@ -450,7 +445,8 @@ static void __devinit init_hwif_amd74xx(
>  		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},	\
>  		.bootable	= ON_BOARD,				\
>  		.host_flags	= IDE_HFLAG_PIO_NO_BLACKLIST		\
> -				| IDE_HFLAG_PIO_NO_DOWNGRADE,		\
> +				| IDE_HFLAG_PIO_NO_DOWNGRADE		\
> +				| IDE_HFLAG_POST_SET_MODE,		\
>  		.pio_mask	= ATA_PIO5,				\
>  	}

    Maybe it worth fixing the driver to not enable Sesetting UltraDMA modes
after snooping Set Features command -- then this flags woouldn't be needed...

> Index: b/drivers/ide/pci/atiixp.c
> ===================================================================
> --- a/drivers/ide/pci/atiixp.c
> +++ b/drivers/ide/pci/atiixp.c
> @@ -122,14 +122,14 @@ static void atiixp_dma_host_off(ide_driv
>  }
>  
>  /**
> - *	atiixp_tune_pio	-	tune a drive attached to a ATIIXP
> - *	@drive: drive to tune
> - *	@pio: desired PIO mode
> + *	atiixp_set_pio_mode	-	set host controller for PIO mode
> + *	@drive: drive
> + *	@pio: PIO mode number
>   *
>   *	Set the interface PIO mode.
>   */
>  
> -static void atiixp_tune_pio(ide_drive_t *drive, u8 pio)
> +static void atiixp_set_pio_mode(ide_drive_t *drive, const u8 pio)
>  {
>  	struct pci_dev *dev = drive->hwif->pci_dev;
>  	unsigned long flags;
> @@ -153,23 +153,16 @@ static void atiixp_tune_pio(ide_drive_t 
>  	spin_unlock_irqrestore(&atiixp_lock, flags);
>  }
>  
> -static void atiixp_set_pio_mode(ide_drive_t *drive, const u8 pio)
> -{
> -	atiixp_tune_pio(drive, pio);
> -	(void)ide_config_drive_speed(drive, XFER_PIO_0 + pio);
> -}
> -
>  /**
> - *	atiixp_tune_chipset	-	tune a ATIIXP interface
> - *	@drive: IDE drive to tune
> - *	@speed: speed to configure
> + *	atiixp_set_dma_mode	-	set host controller for DMA mode
> + *	@drive: drive
> + *	@speed: DMA mode
>   *
> - *	Set a ATIIXP interface channel to the desired speeds. This involves
> - *	requires the right timing data into the ATIIXP configuration space
> - *	then setting the drive parameters appropriately
> + *	Set a ATIIXP host controller to the desired DMA mode.  This involves
> + *	programming the right timing data into the PCI configuration space.
>   */
>  
> -static int atiixp_speedproc(ide_drive_t *drive, const u8 speed)
> +static void atiixp_set_dma_mode(ide_drive_t *drive, const u8 speed)
>  {
>  	struct pci_dev *dev = drive->hwif->pci_dev;
>  	unsigned long flags;
> @@ -204,9 +197,7 @@ static int atiixp_speedproc(ide_drive_t 
>  	else
>  		pio = speed - XFER_PIO_0;
>  
> -	atiixp_tune_pio(drive, pio);
> -
> -	return ide_config_drive_speed(drive, speed);
> +	atiixp_set_pio_mode(drive, pio);

    Bleh... PIO/DMA needs "decoupling" here too.

> Index: b/drivers/ide/pci/cs5530.c
> ===================================================================
> --- a/drivers/ide/pci/cs5530.c
> +++ b/drivers/ide/pci/cs5530.c
[...]
> @@ -62,20 +46,12 @@ static unsigned int cs5530_pio_timings[2
>  #define CS5530_BAD_PIO(timings) (((timings)&~0x80000000)==0x0000e132)
>  #define CS5530_BASEREG(hwif)	(((hwif)->dma_base & ~0xf) + ((hwif)->channel 
? 0x30 : 0x20))
>
> -static void cs5530_tunepio(ide_drive_t *drive, u8 pio)
> -{
> -	unsigned long basereg = CS5530_BASEREG(drive->hwif);
> -	unsigned int format = (inl(basereg + 4) >> 31) & 1;
> -
> -	outl(cs5530_pio_timings[format][pio], basereg + ((drive->dn & 1)<<3));
> -}
> -
>  /**
> - *	cs5530_set_pio_mode	-	set PIO mode
> + *	cs5530_set_pio_mode	-	set host controller for PIO mode
>   *	@drive: drive
>   *	@pio: PIO mode number
>   *
> - *	Handles setting of PIO mode for both the chipset and drive.
> + *	Handles setting of PIO mode for both the chipset.

    Both the chipset and what? ;-)

>[...]
> @@ -334,6 +301,7 @@ static ide_pci_device_t cs5530_chipset _
>  	.autodma	= AUTODMA,
>  	.bootable	= ON_BOARD,
>  	.pio_mask	= ATA_PIO4,
> +	.host_flags	= IDE_HFLAG_POST_SET_MODE,
>  };

    Shouldn't be needed as well...

> Index: b/drivers/ide/pci/cs5535.c
> ===================================================================
> --- a/drivers/ide/pci/cs5535.c
> +++ b/drivers/ide/pci/cs5535.c
[...]
> @@ -227,7 +219,7 @@ static ide_pci_device_t cs5535_chipset _
>  	.init_hwif	= init_hwif_cs5535,
>  	.autodma	= AUTODMA,
>  	.bootable	= ON_BOARD,
> -	.host_flags	= IDE_HFLAG_SINGLE,
> +	.host_flags	= IDE_HFLAG_SINGLE | IDE_HFLAG_POST_SET_MODE,
>  	.pio_mask	= ATA_PIO4,
>  };

    ... and here either.

> Index: b/drivers/ide/pci/hpt366.c
> ===================================================================
> --- a/drivers/ide/pci/hpt366.c
> +++ b/drivers/ide/pci/hpt366.c
> @@ -625,24 +623,22 @@ static int hpt37x_tune_chipset(ide_drive
>  	if (speed < XFER_MW_DMA_0)
>  		new_itr &= ~0x80000000; /* Disable on-chip PIO FIFO/buffer */
>  	pci_write_config_dword(dev, itr_addr, new_itr);
> -
> -	return ide_config_drive_speed(drive, speed);
>  }
>  
> -static int hpt3xx_tune_chipset(ide_drive_t *drive, u8 speed)
> +static void hpt3xx_set_mode(ide_drive_t *drive, const u8 speed)
>  {
>  	ide_hwif_t *hwif	= HWIF(drive);
>  	struct hpt_info	*info	= pci_get_drvdata(hwif->pci_dev);
>  
>  	if (info->chip_type >= HPT370)
> -		return hpt37x_tune_chipset(drive, speed);
> +		hpt37x_set_mode(drive, speed);
>  	else	/* hpt368: hpt_minimum_revision(dev, 2) */
> -		return hpt36x_tune_chipset(drive, speed);
> +		hpt36x_set_mode(drive, speed);
>  }

    Sigh, I have a patch pending to deal with this stupid wrapper (and the
shared PIO/DMA timings) for about a year now (though I'm still going to rework
it)...

> Index: b/drivers/ide/pci/it821x.c
> ===================================================================
> --- a/drivers/ide/pci/it821x.c
> +++ b/drivers/ide/pci/it821x.c
> @@ -629,14 +596,16 @@ static void __devinit init_hwif_it821x(i
>  			printk(KERN_WARNING "it821x: Revision 0x10, workarounds activated.\n");
>  	}
>  
> -	hwif->speedproc = &it821x_tune_chipset;

    What I suggest would look like:

  	if (!idev->smart) {
	  	hwif->set_pio_mode = &it821x_set_pio_mode;
		hwif->set_dma_mode = &it821x_set_dma_mode;

	 	/* MWDMA/PIO clock switching for pass through mode */
  		hwif->dma_start = &it821x_dma_start;
  		hwif->ide_dma_end = &it821x_dma_end;
	}

> Index: b/drivers/ide/pci/piix.c
> ===================================================================
> --- a/drivers/ide/pci/piix.c
> +++ b/drivers/ide/pci/piix.c
[...]
> @@ -288,9 +273,7 @@ static int piix_tune_chipset(ide_drive_t
>  			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
>  	}
>  
> -	piix_tune_pio(drive, piix_dma_2_pio(speed));
> -
> -	return ide_config_drive_speed(drive, speed);
> +	piix_set_pio_mode(drive, piix_dma_2_pio(speed));

    Hm, I remember some earlier patches which have changed this code...

> Index: b/drivers/ide/pci/sc1200.c
> ===================================================================
> --- a/drivers/ide/pci/sc1200.c
> +++ b/drivers/ide/pci/sc1200.c
[...]
> @@ -423,7 +373,7 @@ static ide_pci_device_t sc1200_chipset _
>  	.init_hwif	= init_hwif_sc1200,
>  	.autodma	= AUTODMA,
>  	.bootable	= ON_BOARD,
> -	.host_flags	= IDE_HFLAG_ABUSE_DMA_MODES,
> +	.host_flags	= IDE_HFLAG_ABUSE_DMA_MODES | IDE_HFLAG_POST_SET_MODE,

    Doesn't seem needed as well...

> Index: b/drivers/ide/pci/siimage.c
> ===================================================================
> --- a/drivers/ide/pci/siimage.c
> +++ b/drivers/ide/pci/siimage.c
> @@ -234,21 +234,15 @@ static void sil_tune_pio(ide_drive_t *dr
>  	}
>  }
>  
> -static void sil_set_pio_mode(ide_drive_t *drive, const u8 pio)
> -{
> -	sil_tune_pio(drive, pio);
> -	(void)ide_config_drive_speed(drive, XFER_PIO_0 + pio);
> -}
> -
>  /**
> - *	siimage_tune_chipset	-	set controller timings
> - *	@drive: Drive to set up
> - *	@speed: speed we want to achieve
> + *	sil_set_dma_mode	-	set host controller for DMA mode
> + *	@drive: drive
> + *	@speed: DMA mode
>   *
> - *	Tune the SII chipset for the desired mode.
> + *	Tune the SII chipset for the desired DMA mode.

    It's rather SiI chipset.

> Index: b/drivers/ide/pci/slc90e66.c
> ===================================================================
> --- a/drivers/ide/pci/slc90e66.c
> +++ b/drivers/ide/pci/slc90e66.c
[...]
> @@ -144,9 +138,7 @@ static int slc90e66_tune_chipset(ide_dri
>  			pci_write_config_word(dev, 0x4a, reg4a & ~a_speed);
>  	}
>  
> -	slc90e66_tune_pio(drive, slc90e66_dma_2_pio(speed));
> -
> -	return ide_config_drive_speed(drive, speed);
> +	slc90e66_set_pio_mode(drive, slc90e66_dma_2_pio(speed));
>  }

    I remember a prior patch changing this code as well...

> Index: b/drivers/ide/pci/via82cxxx.c
> ===================================================================
> --- a/drivers/ide/pci/via82cxxx.c
> +++ b/drivers/ide/pci/via82cxxx.c
[...]
> @@ -488,7 +481,8 @@ static ide_pci_device_t via82cxxx_chipse
>  		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
>  		.bootable	= ON_BOARD,
>  		.host_flags	= IDE_HFLAG_PIO_NO_BLACKLIST
> -				| IDE_HFLAG_PIO_NO_DOWNGRADE,
> +				| IDE_HFLAG_PIO_NO_DOWNGRADE
> +				| IDE_HFLAG_POST_SET_MODE,
>  		.pio_mask	= ATA_PIO5,
>  	},{	/* 1 */
>  		.name		= "VP_IDE",
> @@ -498,7 +492,8 @@ static ide_pci_device_t via82cxxx_chipse
>  		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
>  		.bootable	= ON_BOARD,
>  		.host_flags	= IDE_HFLAG_PIO_NO_BLACKLIST
> -				| IDE_HFLAG_PIO_NO_DOWNGRADE,
> +				| IDE_HFLAG_PIO_NO_DOWNGRADE
> +				| IDE_HFLAG_POST_SET_MODE,
>  		.pio_mask	= ATA_PIO5,
>  	}
>  };

    The same comment about this driver enabling Set Feature command snoop for 
no apparent reason...

> Index: b/drivers/ide/ppc/pmac.c
> ===================================================================
> --- a/drivers/ide/ppc/pmac.c
> +++ b/drivers/ide/ppc/pmac.c
[...]
> @@ -1143,7 +1130,8 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
>  	hwif->cbl = pmif->cable_80 ? ATA_CBL_PATA80 : ATA_CBL_PATA40;
>  	hwif->drives[0].unmask = 1;
>  	hwif->drives[1].unmask = 1;
> -	hwif->host_flags = IDE_HFLAG_SET_PIO_MODE_KEEP_DMA;
> +	hwif->host_flags = IDE_HFLAG_SET_PIO_MODE_KEEP_DMA |
> +			   IDE_HFLAG_POST_SET_MODE,

    Er... have you tried to compile this before posting? ;-)

MBR, Sergei
