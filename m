From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: remove ->ide_dma_check (take 2)
Date: Mon, 24 Sep 2007 21:18:14 +0400
Message-ID: <46F7F156.4000201@ru.mvista.com>
References: <200709210118.28047.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:7546 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758271AbXIXRSb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Sep 2007 13:18:31 -0400
In-Reply-To: <200709210118.28047.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Add IDE_HFLAG_TRUST_BIOS_FOR_DMA host flag for host drivers that depend
>   on BIOS for programming device/controller for DMA.  Set it in cy82c693,
>   generic, ns87415, opti621 and trm290 host drivers.

> * Add IDE_HFLAG_VDMA host flag for host drivers using VDMA.  Set it in cs5520
>   host driver.

> * Teach ide_tune_dma() about IDE_HFLAG_TRUST_BIOS_FOR_DMA flag.

> * Add generic ide_dma_check() helper and remove all open coded ->ide_dma_check
>   implementations.  Fix all places checking for presence of ->ide_dma_check
>   hook to check for ->ide_dma_on instead.

> * Remove no longer needed code from config_drive_for_dma().

> * Make ide_tune_dma() static.

> v2:
> * Fix config_drive_for_dma() return values.

    Yeah, this slipped past me in the 1st review...

> * Fix ide-dma.c build for CONFIG_BLK_DEV_IDEDMA_PCI=n by adding
>   dummy config_drive_for_dma() inline.

> * Fix IDE_HFLAG_TRUST_BIOS_FOR_DMA handling in ide_dma_check().

> * Fix init_hwif_it8213() comment.

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> Sergei: re-review is needed

    Sigh, I'm feeling swamped in [re]views...

> Index: b/drivers/ide/ide-dma.c
> ===================================================================
> --- a/drivers/ide/ide-dma.c
> +++ b/drivers/ide/ide-dma.c
> @@ -338,35 +338,30 @@ static int config_drive_for_dma (ide_dri
>  	ide_hwif_t *hwif = drive->hwif;
>  	struct hd_driveid *id = drive->id;
>  
> -	/* consult the list of known "bad" drives */
> -	if (__ide_dma_bad_drive(drive))
> -		return -1;
> -
>  	if (drive->media != ide_disk && hwif->atapi_dma == 0)
> -		return -1;
> +		return 0;
>  
> -	if ((id->capability & 1) && drive->autodma) {
> -		/*
> -		 * Enable DMA on any drive that has
> -		 * UltraDMA (mode 0/1/2/3/4/5/6) enabled
> -		 */
> -		if ((id->field_valid & 4) && ((id->dma_ultra >> 8) & 0x7f))
> -			return 0;
> -		/*
> -		 * Enable DMA on any drive that has mode2 DMA
> -		 * (multi or single) enabled
> -		 */
> -		if (id->field_valid & 2)	/* regular DMA */
> -			if ((id->dma_mword & 0x404) == 0x404 ||
> -			    (id->dma_1word & 0x404) == 0x404)
> -				return 0;
> +	/*
> +	 * Enable DMA on any drive that has
> +	 * UltraDMA (mode 0/1/2/3/4/5/6) enabled
> +	 */
> +	if ((id->field_valid & 4) && ((id->dma_ultra >> 8) & 0x7f))
> +		return 1;
>  
> -		/* Consult the list of known "good" drives */
> -		if (ide_dma_good_drive(drive))
> -			return 0;
> -	}
> +	/*
> +	 * Enable DMA on any drive that has mode2 DMA
> +	 * (multi or single) enabled
> +	 */
> +	if (id->field_valid & 2)	/* regular DMA */
> +		if ((id->dma_mword & 0x404) == 0x404 ||
> +		    (id->dma_1word & 0x404) == 0x404)
> +			return 1;
>  
> -	return -1;
> +	/* Consult the list of known "good" drives */
> +	if (ide_dma_good_drive(drive))
> +		return 1;
> +
> +	return 0;
>  }
>  
>  /**
> @@ -627,6 +622,8 @@ static int __ide_dma_test_irq(ide_drive_
>  			drive->name, __FUNCTION__);
>  	return 0;
>  }
> +#else
> +static inline int config_drive_for_dma(ide_drive_t *drive) { return 0; }
>  #endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
>  
>  int __ide_dma_bad_drive (ide_drive_t *drive)
> @@ -756,7 +753,7 @@ u8 ide_find_dma_mode(ide_drive_t *drive,
>  
>  EXPORT_SYMBOL_GPL(ide_find_dma_mode);
>  
> -int ide_tune_dma(ide_drive_t *drive)
> +static int ide_tune_dma(ide_drive_t *drive)
>  {
>  	u8 speed;
>  
> @@ -767,6 +764,9 @@ int ide_tune_dma(ide_drive_t *drive)
>  	if (__ide_dma_bad_drive(drive))
>  		return 0;
>  
> +	if (drive->hwif->host_flags & IDE_HFLAG_TRUST_BIOS_FOR_DMA)
> +		return config_drive_for_dma(drive);
> +
>  	speed = ide_max_dma_mode(drive);
>  
>  	if (!speed)
> @@ -783,6 +783,23 @@ int ide_tune_dma(ide_drive_t *drive)
>  
>  EXPORT_SYMBOL_GPL(ide_tune_dma);

    You're converting it to static and yet leaving exportable -- what for?

> Index: b/drivers/ide/ide-probe.c
> ===================================================================
> --- a/drivers/ide/ide-probe.c
> +++ b/drivers/ide/ide-probe.c
> @@ -844,7 +844,7 @@ static void probe_hwif(ide_hwif_t *hwif,
>  			 * Move here to prevent module loading clashing.
>  			 */
>  	//		drive->autodma = hwif->autodma;

    I hope this gets killed by the "autodma" patch?

> Index: b/drivers/ide/pci/hpt34x.c
> ===================================================================
> --- a/drivers/ide/pci/hpt34x.c
> +++ b/drivers/ide/pci/hpt34x.c
> @@ -80,16 +80,6 @@ static void hpt34x_set_pio_mode(ide_driv
>  	hpt34x_set_mode(drive, XFER_PIO_0 + pio);
>  }
>  
> -static int hpt34x_config_drive_xfer_rate (ide_drive_t *drive)
> -{
> -	if (ide_tune_dma(drive))
> -		return -1;

    Hm, why -1 in this driver and 0 in all the others? Looks like a 
functionality change?..

MBR, Sergei
