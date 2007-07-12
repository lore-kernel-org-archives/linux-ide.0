From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/6] ide-pmac: PIO fixes
Date: Thu, 12 Jul 2007 21:33:08 +0200
Message-ID: <200707122133.09054.bzolnier@gmail.com>
References: <200707110204.07540.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:40492 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764220AbXGLTQR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jul 2007 15:16:17 -0400
Received: by ug-out-1314.google.com with SMTP id j3so406826ugf
        for <linux-ide@vger.kernel.org>; Thu, 12 Jul 2007 12:16:16 -0700 (PDT)
In-Reply-To: <200707110204.07540.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Kyle McMartin <kyle@mcmartin.ca>

On Wednesday 11 July 2007, Bartlomiej Zolnierkiewicz wrote:
> 
> * Add { 0, 0 } entry to {kauai,shasta}_pio_timings[] so kauai_lookup_timing()
>   always returns a valid PIO timing (fixes PIO timing not being set for devices
>   with minimum PIO cycle <= 120ns).
> 
> * Add setting transfer mode on the device to pmac_ide_set_pio_mode().
> 
> * Fix pmac_ide_set_pio() to always program chipset for given PIO timing instead
>   of only when the device we want to program PIO timing for is the currently
>   selected one.
> 
> * Now that pmac_ide_set_pio() is fixed there is no need to set transfer mode
>   on the device and program chipset for PIO in pmac_ide_tune_chipset()
>   (returning 0 == success is not entirely correct but is OK for now since
>   the upper layers are only checking ->speedproc return value for DMA modes).


> This patch should have no effect on the default kernel behavior because
> IDE pmac driver doesn't enable ->autotune (this would also explain why some
> of the above bugs remained unfixed for so long).

This part of the patch description is actually incorrect: ->tuneproc is used
unconditionally during suspend so the patch has the real effect (hopefully
positive :) on the default kernel behavior.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Kyle McMartin <kyle@mcmartin.ca>
> ---
>  drivers/ide/ppc/pmac.c |   19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> Index: b/drivers/ide/ppc/pmac.c
> ===================================================================
> --- a/drivers/ide/ppc/pmac.c
> +++ b/drivers/ide/ppc/pmac.c
> @@ -311,7 +311,8 @@ static struct kauai_timing	kauai_pio_tim
>  	{ 240	, 0x0800038b },
>  	{ 239	, 0x0800030c },
>  	{ 180	, 0x05000249 },
> -	{ 120	, 0x04000148 }
> +	{ 120	, 0x04000148 },
> +	{ 0	, 0 },
>  };
>  
>  static struct kauai_timing	kauai_mdma_timings[] =
> @@ -351,7 +352,8 @@ static struct kauai_timing	shasta_pio_ti
>  	{ 240	, 0x040003cd },
>  	{ 239	, 0x040003cd },
>  	{ 180	, 0x0400028b },
> -	{ 120	, 0x0400010a }
> +	{ 120	, 0x0400010a },
> +	{ 0	, 0 },
>  };
>  
>  static struct kauai_timing	shasta_mdma_timings[] =
> @@ -631,8 +633,6 @@ pmac_ide_set_pio_mode(ide_drive_t *drive
>  	case controller_sh_ata6: {
>  		/* 133Mhz cell */
>  		u32 tr = kauai_lookup_timing(shasta_pio_timings, cycle_time);
> -		if (tr == 0)
> -			return;
>  		*timings = ((*timings) & ~TR_133_PIOREG_PIO_MASK) | tr;
>  		break;
>  		}
> @@ -640,8 +640,6 @@ pmac_ide_set_pio_mode(ide_drive_t *drive
>  	case controller_k2_ata6: {
>  		/* 100Mhz cell */
>  		u32 tr = kauai_lookup_timing(kauai_pio_timings, cycle_time);
> -		if (tr == 0)
> -			return;
>  		*timings = ((*timings) & ~TR_100_PIOREG_PIO_MASK) | tr;
>  		break;
>  		}
> @@ -692,8 +690,11 @@ pmac_ide_set_pio_mode(ide_drive_t *drive
>  		drive->name, pio,  *timings);
>  #endif	
>  
> -	if (drive->select.all == HWIF(drive)->INB(IDE_SELECT_REG))
> -		pmac_ide_do_update_timings(drive);
> +	if (pmac_ide_do_setfeature(drive, speed))
> +		return;
> +
> +	pmac_ide_do_update_timings(drive);
> +	drive->current_speed = speed;
>  }
>  
>  #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
> @@ -962,7 +963,7 @@ static int pmac_ide_tune_chipset(ide_dri
>  		case XFER_PIO_1:
>  		case XFER_PIO_0:
>  			pmac_ide_set_pio_mode(drive, speed & 0x07);
> -			break;
> +			return 0;
>  		default:
>  			ret = 1;
>  	}
> 
