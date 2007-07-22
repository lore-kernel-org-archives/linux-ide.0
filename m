From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 11/11] ide-pmac: remove pmac_ide_do_setfeature()
Date: Mon, 23 Jul 2007 08:04:37 +1000
Message-ID: <1185141877.5439.75.camel@localhost.localdomain>
References: <200707222034.28285.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:60440 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765393AbXGVWEm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Jul 2007 18:04:42 -0400
In-Reply-To: <200707222034.28285.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sun, 2007-07-22 at 20:34 +0200, Bartlomiej Zolnierkiewicz wrote:
> Use ide_config_drive_speed() instead of pmac_ide_do_setfeature() and remove
> the latter, also  ide-iops.c::__ide_wait_stat() could be static again.
> 
> Since for IDE PMAC host driver IDE_CONTROL_REG is always true, device's
> ->quirk_list is always zero and ->ide_dma_host_{on,off} are nops than
> the only changes in behavior are:
> 
> * if PIO mode is set then ->dma_off_queitly is called to disable DMA
> 
> * if setting transfer mode fails ide_dump_status() is called to dump status

This one needs to be on hold for the reason explained before. In the old
days, I did use the generic function and triggered the lockup. Things
changes and the generic function got several fixes, so it may well be
fine now, but I need to verify it.

> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ide/ide-iops.c |    2 -
>  drivers/ide/ppc/pmac.c |   79 +------------------------------------------------
>  include/linux/ide.h    |    1 
>  3 files changed, 3 insertions(+), 79 deletions(-)
> 
> Index: b/drivers/ide/ide-iops.c
> ===================================================================
> --- a/drivers/ide/ide-iops.c
> +++ b/drivers/ide/ide-iops.c
> @@ -483,7 +483,7 @@ EXPORT_SYMBOL(drive_is_ready);
>   * setting a timer to wake up at half second intervals thereafter,
>   * until timeout is achieved, before timing out.
>   */
> -int __ide_wait_stat(ide_drive_t *drive, u8 good, u8 bad, unsigned long timeout, u8 *rstat)
> +static int __ide_wait_stat(ide_drive_t *drive, u8 good, u8 bad, unsigned long timeout, u8 *rstat)
>  {
>  	ide_hwif_t *hwif = drive->hwif;
>  	unsigned long flags;
> Index: b/drivers/ide/ppc/pmac.c
> ===================================================================
> --- a/drivers/ide/ppc/pmac.c
> +++ b/drivers/ide/ppc/pmac.c
> @@ -529,81 +529,6 @@ pmac_outbsync(ide_drive_t *drive, u8 val
>  }
>  
>  /*
> - * Send the SET_FEATURE IDE command to the drive and update drive->id with
> - * the new state. We currently don't use the generic routine as it used to
> - * cause various trouble, especially with older mediabays.
> - * This code is sometimes triggering a spurrious interrupt though, I need
> - * to sort that out sooner or later and see if I can finally get the
> - * common version to work properly in all cases
> - */
> -static int
> -pmac_ide_do_setfeature(ide_drive_t *drive, u8 command)
> -{
> -	ide_hwif_t *hwif = HWIF(drive);
> -	int result;
> -	u8 stat;
> -	
> -	disable_irq_nosync(hwif->irq);
> -	udelay(1);
> -	SELECT_DRIVE(drive);
> -	SELECT_MASK(drive, 0);
> -	udelay(1);
> -	hwif->OUTB(drive->ctl | 2, IDE_CONTROL_REG);
> -	hwif->OUTB(command, IDE_NSECTOR_REG);
> -	hwif->OUTB(SETFEATURES_XFER, IDE_FEATURE_REG);
> -	hwif->OUTBSYNC(drive, WIN_SETFEATURES, IDE_COMMAND_REG);
> -	result = __ide_wait_stat(drive, drive->ready_stat,
> -				 BUSY_STAT|DRQ_STAT|ERR_STAT,
> -				 WAIT_CMD, &stat);
> -	if (result)
> -		printk(KERN_ERR "%s: pmac_ide_do_setfeature disk not ready "
> -			"after SET_FEATURE !\n", drive->name);
> -
> -	SELECT_MASK(drive, 0);
> -	if (result == 0) {
> -		drive->id->dma_ultra &= ~0xFF00;
> -		drive->id->dma_mword &= ~0x0F00;
> -		drive->id->dma_1word &= ~0x0F00;
> -		switch(command) {
> -			case XFER_UDMA_7:
> -				drive->id->dma_ultra |= 0x8080; break;
> -			case XFER_UDMA_6:
> -				drive->id->dma_ultra |= 0x4040; break;
> -			case XFER_UDMA_5:
> -				drive->id->dma_ultra |= 0x2020; break;
> -			case XFER_UDMA_4:
> -				drive->id->dma_ultra |= 0x1010; break;
> -			case XFER_UDMA_3:
> -				drive->id->dma_ultra |= 0x0808; break;
> -			case XFER_UDMA_2:
> -				drive->id->dma_ultra |= 0x0404; break;
> -			case XFER_UDMA_1:
> -				drive->id->dma_ultra |= 0x0202; break;
> -			case XFER_UDMA_0:
> -				drive->id->dma_ultra |= 0x0101; break;
> -			case XFER_MW_DMA_2:
> -				drive->id->dma_mword |= 0x0404; break;
> -			case XFER_MW_DMA_1:
> -				drive->id->dma_mword |= 0x0202; break;
> -			case XFER_MW_DMA_0:
> -				drive->id->dma_mword |= 0x0101; break;
> -			case XFER_SW_DMA_2:
> -				drive->id->dma_1word |= 0x0404; break;
> -			case XFER_SW_DMA_1:
> -				drive->id->dma_1word |= 0x0202; break;
> -			case XFER_SW_DMA_0:
> -				drive->id->dma_1word |= 0x0101; break;
> -			default: break;
> -		}
> -		if (!drive->init_speed)
> -			drive->init_speed = command;
> -		drive->current_speed = command;
> -	}
> -	enable_irq(hwif->irq);
> -	return result;
> -}
> -
> -/*
>   * Old tuning functions (called on hdparm -p), sets up drive PIO timings
>   */
>  static void
> @@ -684,7 +609,7 @@ pmac_ide_set_pio_mode(ide_drive_t *drive
>  		drive->name, pio,  *timings);
>  #endif	
>  
> -	if (pmac_ide_do_setfeature(drive, XFER_PIO + pio))
> +	if (ide_config_drive_speed(drive, XFER_PIO + pio))
>  		return;
>  
>  	pmac_ide_do_update_timings(drive);
> @@ -947,7 +872,7 @@ static int pmac_ide_tune_chipset(ide_dri
>  	if (ret)
>  		return ret;
>  
> -	ret = pmac_ide_do_setfeature(drive, speed);
> +	ret = ide_config_drive_speed(drive, speed);
>  	if (ret)
>  		return ret;
>  
> Index: b/include/linux/ide.h
> ===================================================================
> --- a/include/linux/ide.h
> +++ b/include/linux/ide.h
> @@ -1152,7 +1152,6 @@ extern void SELECT_MASK(ide_drive_t *, i
>  extern void QUIRK_LIST(ide_drive_t *);
>  
>  extern int drive_is_ready(ide_drive_t *);
> -int __ide_wait_stat(ide_drive_t *, u8, u8, unsigned long);
>  
>  /*
>   * taskfile io for disks for now...and builds request from ide_ioctl

