From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: add ide_set{_max}_pio() (take 2)
Date: Wed, 04 Jul 2007 00:04:40 +0400
Message-ID: <468AABD8.8060909@ru.mvista.com>
References: <200707010046.15532.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:25829 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757002AbXGCUC7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 16:02:59 -0400
In-Reply-To: <200707010046.15532.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Add IDE_HFLAG_ABUSE_{PREFETCH,FAST_DEVSEL,DMA_MODES} flags
>   and set them in ht6560, cmd640, cmd64x and sc1200 host drivers.

> * Add set_pio_mode_abuse() for checking if host driver has a non-standard
>   ->tuneproc() implementation and use it in do_special().

> * Add ide_set_pio() for setting PIO mode (it uses hwif->pio_mask to find
>   the maximum PIO mode supported by the host), also add ide_set_max_pio()
>   wrapper for ide_set_pio() to use for auto-tuning.  Convert users of
>   ->tuneproc to use ide_set{_max}_pio() where possible.  This leaves only
>   do_special(), set_using_pio(), ide_hwif_restore() and ide_set_pio() as
>   a direct users of ->tuneproc.

> * Remove no longer needed ide_get_best_pio_mode() calls and printk-s

    Wait... shouldn't we also un-export it then, and just make static? Well, 
just noticed that there'll be callers left...

>   reporting PIO mode selected from ->tuneproc implementations.

> * Rename ->tuneproc hook to ->set_pio_mode

    Well, tuneproc() went with speedproc() rather well. :-)

> and make 'pio' argument const.

    Isn't it too strict, const value argument?

> * Remove stale comment from ide_config_drive_speed().

    Hm, the next logical step would be to remove a call to 
ide_config_drive_speed() from the set_pio_mode() handler, wouldn't it?..

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

    Alas, had to NAK the patch -- mostly due to ancient QD65xx VLB chips. :-P
There are other nits though...

> Index: b/drivers/ide/ide-io.c
> ===================================================================
> --- a/drivers/ide/ide-io.c
> +++ b/drivers/ide/ide-io.c
> @@ -196,8 +196,7 @@ static ide_startstop_t ide_start_power_s
>  		return do_rw_taskfile(drive, args);
>  
>  	case idedisk_pm_restore_pio:	/* Resume step 1 (restore PIO) */
> -		if (drive->hwif->tuneproc != NULL)
> -			drive->hwif->tuneproc(drive, 255);
> +		ide_set_max_pio(drive);
>  		/*
>  		 * skip idedisk_pm_idle for ATAPI devices
>  		 */
> @@ -783,6 +782,38 @@ static ide_startstop_t ide_disk_special(
>  	return ide_started;
>  }
>  
> +/*
> + * handle HDIO_SET_PIO_MODE ioctl abusers here, eventually it will go away
> + */
> +static int set_pio_mode_abuse(ide_hwif_t *hwif, u8 req_pio)
> +{
> +	int abuse;

    Do we really need this variable?

> +
> +	switch (req_pio) {
> +	case 202:
> +	case 201:
> +	case 200:
> +	case 102:
> +	case 101:
> +	case 100:
> +		abuse = (hwif->host_flags & IDE_HFLAG_ABUSE_DMA_MODES) ? 1 : 0;
> +		break;
> +	case 9:
> +	case 8:
> +		abuse = (hwif->host_flags & IDE_HFLAG_ABUSE_PREFETCH) ? 1 : 0;
> +		break;
> +	case 7:
> +	case 6:
> +		abuse = (hwif->host_flags & IDE_HFLAG_ABUSE_FAST_DEVSEL) ? 1 : 0;
> +		break;
> +	default:
> +		abuse = 0;
> +		break;
> +	}
> +
> +	return abuse;

     Why not just return from the switch stmt itself?

> Index: b/drivers/ide/legacy/qd65xx.c
> ===================================================================
> --- a/drivers/ide/legacy/qd65xx.c
> +++ b/drivers/ide/legacy/qd65xx.c
> @@ -224,15 +224,14 @@ static void qd_set_timing (ide_drive_t *
>  	printk(KERN_DEBUG "%s: %#x\n", drive->name, timing);
>  }
>  
> -/*
> - * qd6500_tune_drive
> - */
> -
> -static void qd6500_tune_drive (ide_drive_t *drive, u8 pio)
> +static void qd6500_set_pio_mode(ide_drive_t *drive, const u8 pio)
>  {
>  	int active_time   = 175;
>  	int recovery_time = 415; /* worst case values from the dos driver */
>  
> +	/*
> +	 * FIXME: use "pio" value
> +	 */

    The drive->id is also asking to be put into local variable...

>  	if (drive->id && !qd_find_disk_type(drive, &active_time, &recovery_time)
>  		&& drive->id->tPIO && (drive->id->field_valid & 0x02)
>  		&& drive->id->eide_pio >= 240) {
> @@ -246,11 +245,7 @@ static void qd6500_tune_drive (ide_drive
>  	qd_set_timing(drive, qd6500_compute_timing(HWIF(drive), active_time, recovery_time));
>  }
>  
> -/*
> - * qd6580_tune_drive
> - */
> -
> -static void qd6580_tune_drive (ide_drive_t *drive, u8 pio)
> +static void qd6580_set_pio_mode(ide_drive_t *drive, const u8 pio)
>  {
>  	int base = HWIF(drive)->select_data;
>  	unsigned int cycle_time;
[...]
> @@ -335,8 +329,7 @@ static int __init qd_testreg(int port)
>   */
>  
>  static void __init qd_setup(ide_hwif_t *hwif, int base, int config,
> -			    unsigned int data0, unsigned int data1,
> -			    void (*tuneproc) (ide_drive_t *, u8 pio))
> +			    unsigned int data0, unsigned int data1)
>  {
>  	hwif->chipset = ide_qd65xx;
>  	hwif->channel = hwif->index;
> @@ -347,8 +340,6 @@ static void __init qd_setup(ide_hwif_t *
>  	hwif->drives[0].io_32bit =
>  	hwif->drives[1].io_32bit = 1;
>  	hwif->pio_mask = ATA_PIO4;
> -	hwif->tuneproc = tuneproc;

    Not sure if repeating this line thrice instead was really an improvement...

> -	probe_hwif_init(hwif);
>  }
>  
>  /*
> @@ -361,7 +352,7 @@ static void __exit qd_unsetup(ide_hwif_t
>  {
>  	u8 config = hwif->config_data;
>  	int base = hwif->select_data;
> -	void *tuneproc = (void *) hwif->tuneproc;
> +	void *set_pio_mode = (void *)hwif->set_pio_mode;
>  
>  	if (hwif->chipset != ide_qd65xx)
>  		return;
> @@ -369,12 +360,12 @@ static void __exit qd_unsetup(ide_hwif_t
>  	printk(KERN_NOTICE "%s: back to defaults\n", hwif->name);
>  
>  	hwif->selectproc = NULL;
> -	hwif->tuneproc = NULL;
> +	hwif->set_pio_mode = NULL;
>  
> -	if (tuneproc == (void *) qd6500_tune_drive) {
> +	if (set_pio_mode == (void *)qd6500_tune_drive) {

    Wait, you've just renamed it to qd6580_set_pio_mode()!

>  		// will do it for both
>  		qd_write_reg(QD6500_DEF_DATA, QD_TIMREG(&hwif->drives[0]));
> -	} else if (tuneproc == (void *) qd6580_tune_drive) {
> +	} else if (set_pio_mode == (void *)qd6580_tune_drive) {

    Same here...

> Index: b/drivers/ide/pci/alim15x3.c
> ===================================================================
> --- a/drivers/ide/pci/alim15x3.c
> +++ b/drivers/ide/pci/alim15x3.c
> @@ -283,17 +283,14 @@ static int ali_get_info (char *buffer, c
>  #endif  /* defined(DISPLAY_ALI_TIMINGS) && defined(CONFIG_IDE_PROC_FS) */
>  
>  /**
> - *	ali15x3_tune_pio	-	set up chipset for PIO mode
> + *	ali_tune_pio	-	set up chipset for PIO mode
>   *	@drive: drive to tune
>   *	@pio: desired mode
>   *
> - *	Select the best PIO mode for the drive in question.
> - *	Then program the controller for this mode.
> - *
> - *	Returns the PIO mode programmed.
> + *	Program the controller for @pio PIO mode.

    Rather "for PIO mode @pio."

>   */
> - 
> -static u8 ali15x3_tune_pio (ide_drive_t *drive, u8 pio)
> +
> +void ali_tune_pio(ide_drive_t *drive, const u8 pio)

    Wait... shouldn't it remain static?

> Index: b/drivers/ide/pci/cs5535.c
> ===================================================================
> --- a/drivers/ide/pci/cs5535.c
> +++ b/drivers/ide/pci/cs5535.c
> @@ -144,24 +144,20 @@ static int cs5535_set_drive(ide_drive_t 
[...]
> +static void cs5535_set_pio_mode(ide_drive_t *drive, const u8 pio)
> +{
> +	ide_config_drive_speed(drive, XFER_PIO_0 + pio);
> +	/* FIXME: "XFER_PIO_0 + pio" should be passed instead of "pio" */

    Subject to a separate patch? Why not just push it ahead of this? I see -- 
lack of time... :-)

> +	cs5535_set_speed(drive, pio);
>  }
>  
>  static int cs5535_dma_check(ide_drive_t *drive)
> Index: b/drivers/ide/pci/it8213.c
> ===================================================================
> --- a/drivers/ide/pci/it8213.c
> +++ b/drivers/ide/pci/it8213.c
> @@ -4,6 +4,8 @@
>   * Copyright (C) 2006 Jack Lee
>   * Copyright (C) 2006 Alan Cox
>   * Copyright (C) 2007 Bartlomiej Zolnierkiewicz
> + *
> + * TODO: make ->set_pio_mode method set transfer mode on the device

    IMHO, this actually better be done outside of this method (if possible).
Sigh, that would undo many of my prior fixes...

> @@ -193,7 +194,9 @@ static int it8213_tune_chipset (ide_driv
>  		if (reg55 & w_flag)
>  			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
>  	}
> -	it8213_tuneproc(drive, it8213_dma_2_pio(speed));
> +
> +	it8213_set_pio_mode(drive, it8213_dma_2_pio(speed));

    Bleh... Still haven't "divorced" PIO/DMA timings -- need to get this done 
finally. :-/

> Index: b/drivers/ide/pci/it821x.c
> ===================================================================
> --- a/drivers/ide/pci/it821x.c
> +++ b/drivers/ide/pci/it821x.c
> @@ -274,9 +274,8 @@ static int it821x_tunepio(ide_drive_t *d
>  	return ide_config_drive_speed(drive, XFER_PIO_0 + set_pio);
>  }
>  
> -static void it821x_tuneproc(ide_drive_t *drive, u8 pio)
> +static void it821x_set_pio_mode(ide_drive_t *drive, const u8 pio)
>  {
> -	pio = ide_get_best_pio_mode(drive, pio, 4);
>  	(void)it821x_tunepio(drive, pio);
>  }

    This way, it turns into quite a useless wrapper for it821x_tunepio() --
I think ide_config_drive_speed() call should be removed from there at the 
expense of the callers...

> Index: b/drivers/ide/pci/jmicron.c
> ===================================================================
> --- a/drivers/ide/pci/jmicron.c
> +++ b/drivers/ide/pci/jmicron.c
> @@ -83,7 +83,7 @@ static u8 __devinit ata66_jmicron(ide_hw
>  	return ATA_CBL_PATA80;
>  }
>  
> -static void jmicron_tuneproc (ide_drive_t *drive, byte mode_wanted)
> +static void jmicron_set_pio_mode(ide_drive_t *drive, const u8 pio)
>  {
>  	return;

    Is it useful at all?! With a claimed support of PIO5, I guess this driver 
*at least* deserves FIXME.  Probably I'll have to withdraw my ACK on the PIO 
mask patch... :-|

> Index: b/drivers/ide/pci/opti621.c
> ===================================================================
> --- a/drivers/ide/pci/opti621.c
> +++ b/drivers/ide/pci/opti621.c
> @@ -147,12 +147,13 @@ static void compute_pios(ide_drive_t *dr
>  	int d;
>  	ide_hwif_t *hwif = HWIF(drive);
>  
> -	drive->drive_data = ide_get_best_pio_mode(drive, pio, OPTI621_MAX_PIO);
> +	drive->drive_data = pio;
> +
>  	for (d = 0; d < 2; ++d) {
>  		drive = &hwif->drives[d];
>  		if (drive->present) {
>  			if (drive->drive_data == PIO_DONT_KNOW)
> -				drive->drive_data = ide_get_best_pio_mode(drive, 255, OPTI621_MAX_PIO);
> +				drive->drive_data = ide_get_best_pio_mode(drive, 255, 3);

    Ah, I see there will still be ide_get_best_pio_mode() callers left...

> Index: b/drivers/ide/pci/pdc202xx_new.c
> ===================================================================
> --- a/drivers/ide/pci/pdc202xx_new.c
> +++ b/drivers/ide/pci/pdc202xx_new.c
> @@ -217,9 +217,8 @@ static int pdcnew_tune_chipset(ide_drive
>  	return err;
>  }
>  
> -static void pdcnew_tune_drive(ide_drive_t *drive, u8 pio)
> +static void pdc_set_pio_mode(ide_drive_t *drive, const u8 pio)

    Why not just keep it named pdcnew_* to not confuse with pdc202xx_old?

> Index: b/drivers/ide/pci/pdc202xx_old.c
> ===================================================================
> --- a/drivers/ide/pci/pdc202xx_old.c
> +++ b/drivers/ide/pci/pdc202xx_old.c
> @@ -143,9 +143,8 @@ static int pdc202xx_tune_chipset (ide_dr
>  	return ide_config_drive_speed(drive, speed);
>  }
>  
> -static void pdc202xx_tune_drive(ide_drive_t *drive, u8 pio)
> +static void pdc_set_pio_mode(ide_drive_t *drive, const u8 pio)

    Why not just keep it named pdc202xx_* or make it pdc[_]old_ to not confuse 
with pdc202xx_new?

> @@ -307,10 +306,11 @@ static void pdc202xx_reset (ide_drive_t 
>  {
>  	ide_hwif_t *hwif	= HWIF(drive);
>  	ide_hwif_t *mate	= hwif->mate;
> -	
> +
>  	pdc202xx_reset_host(hwif);
>  	pdc202xx_reset_host(mate);

    Bleh... this double reset horror still needs to be sorted out as well. I'm 
not at all sure it's useful -- its assumed purpose is to be able to set MWDMA 
modes after UDMA (can't do this w/o reset).

> -	pdc202xx_tune_drive(drive, 255);
> +
> +	ide_set_max_pio(drive);

    I wonder why the code doesn't retune all 4 drives? :-/

> Index: b/drivers/ide/pci/scc_pata.c
> ===================================================================
> --- a/drivers/ide/pci/scc_pata.c
> +++ b/drivers/ide/pci/scc_pata.c
> @@ -338,7 +320,7 @@ static int scc_config_drive_for_dma(ide_
>  		return 0;
>  
>  	if (ide_use_fast_pio(drive))
> -		scc_tuneproc(drive, 4);
> +		scc_set_pio_mode(drive, 4); /* FIXME */

    Well, such simplistic fixes would just better go ahead of the big patches...

> Index: b/drivers/ide/pci/sis5513.c
> ===================================================================
> --- a/drivers/ide/pci/sis5513.c
> +++ b/drivers/ide/pci/sis5513.c
> @@ -519,14 +519,13 @@ static void config_art_rwp_pio (ide_driv
>  	}
>  }
>  
> -static int sis5513_tune_drive(ide_drive_t *drive, u8 pio)
> +static int sis5513_tune_drive(ide_drive_t *drive, const u8 pio)
>  {
> -	pio = ide_get_best_pio_mode(drive, pio, 4);
>  	config_art_rwp_pio(drive, pio);
>  	return ide_config_drive_speed(drive, XFER_PIO_0 + pio);
>  }
>  
> -static void sis5513_tuneproc(ide_drive_t *drive, u8 pio)
> +static void sis_set_pio_mode(ide_drive_t *drive, const u8 pio)
>  {
>  	(void)sis5513_tune_drive(drive, pio);

    Nearly useless wrapper again... :-/

> Index: b/drivers/ide/pci/sl82c105.c
> ===================================================================
> --- a/drivers/ide/pci/sl82c105.c
> +++ b/drivers/ide/pci/sl82c105.c
> @@ -75,16 +75,12 @@ static unsigned int get_pio_timings(ide_
>  /*
>   * Configure the chipset for PIO mode.
>   */
> -static u8 sl82c105_tune_pio(ide_drive_t *drive, u8 pio)
> +static void sl82c105_tune_pio(ide_drive_t *drive, const u8 pio)
>  {
>  	struct pci_dev *dev	= HWIF(drive)->pci_dev;
>  	int reg			= 0x44 + drive->dn * 4;
>  	u16 drv_ctrl;
>  
> -	DBG(("sl82c105_tune_pio(drive:%s, pio:%u)\n", drive->name, pio));

> @@ -327,11 +321,10 @@ static void sl82c105_resetproc(ide_drive
>   * We only deal with PIO mode here - DMA mode 'using_dma' is not
>   * initialised at the point that this function is called.
>   */
> -static void sl82c105_tune_drive(ide_drive_t *drive, u8 pio)
> +static void sl82c105_set_pio_mode(ide_drive_t *drive, const u8 pio)
>  {
> -	DBG(("sl82c105_tune_drive(drive:%s, pio:%u)\n", drive->name, pio));

    You leave the DBG() stuff alone! :-D

> Index: b/drivers/ide/pci/tc86c001.c
> ===================================================================
> --- a/drivers/ide/pci/tc86c001.c
> +++ b/drivers/ide/pci/tc86c001.c
> @@ -45,9 +45,8 @@ static int tc86c001_tune_chipset(ide_dri
>  	return ide_config_drive_speed(drive, speed);
>  }
>  
> -static void tc86c001_tune_drive(ide_drive_t *drive, u8 pio)
> +static void tc86c001_set_pio_mode(ide_drive_t *drive, const u8 pio)
>  {
> -	pio = ide_get_best_pio_mode(drive, pio, 4);
>  	(void) tc86c001_tune_chipset(drive, XFER_PIO_0 + pio);

    Another wrapper... well, no -- this wraps around the speedproc() method.
Well, there'll be the same in quite a few drivers -- which makes me wonder 
whether we need the separate PIO tuning method at all.

> Index: b/include/linux/ide.h
> ===================================================================
> --- a/include/linux/ide.h
> +++ b/include/linux/ide.h
> @@ -634,7 +634,7 @@ typedef struct ide_drive_s {
>  
>  	unsigned int	bios_cyl;	/* BIOS/fdisk/LILO number of cyls */
>  	unsigned int	cyl;		/* "real" number of cyls */
> -	unsigned int	drive_data;	/* use by tuneproc/selectproc */
> +	unsigned int	drive_data;	/* use by set_pio_mode/selectproc */

    Wouldn't it sound better as "used by"?

MBR, Sergei
