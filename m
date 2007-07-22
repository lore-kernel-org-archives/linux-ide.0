From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ide-pmac: fix drive->init_speed reporting
Date: Mon, 23 Jul 2007 07:50:37 +1000
Message-ID: <1185141037.5439.54.camel@localhost.localdomain>
References: <200707222019.03684.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:44668 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755010AbXGVVun (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Jul 2007 17:50:43 -0400
In-Reply-To: <200707222019.03684.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sun, 2007-07-22 at 20:19 +0200, Bartlomiej Zolnierkiewicz wrote:
> pmac_ide_tune_chipset() don't set drive->init_speed.
> 
> Fix it by setting drive->{current,init}_speed in pmac_ide_do_setfeature()
> and clean up pmac_ide_{tune_chipset,mdma_enable,udma_enable}().
> 

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
> Goes before "[PATCH] ide-pmac: PIO mode setup fixes (take 2)" patch
> in the IDE quilt tree.
> 
>  drivers/ide/ppc/pmac.c |   14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> Index: b/drivers/ide/ppc/pmac.c
> ===================================================================
> --- a/drivers/ide/ppc/pmac.c
> +++ b/drivers/ide/ppc/pmac.c
> @@ -602,6 +602,9 @@ out:
>  				drive->id->dma_1word |= 0x0101; break;
>  			default: break;
>  		}
> +		if (!drive->init_speed)
> +			drive->init_speed = command;
> +		drive->current_speed = command;
>  	}
>  	enable_irq(hwif->irq);
>  	return result;
> @@ -974,7 +977,6 @@ static int pmac_ide_tune_chipset(ide_dri
>  		return ret;
>  		
>  	pmac_ide_do_update_timings(drive);	
> -	drive->current_speed = speed;
>  
>  	return 0;
>  }
> @@ -1725,11 +1727,6 @@ pmac_ide_mdma_enable(ide_drive_t *drive,
>  	/* Apply timings to controller */
>  	*timings = timing_local[0];
>  	*timings2 = timing_local[1];
> -	
> -	/* Set speed info in drive */
> -	drive->current_speed = mode;	
> -	if (!drive->init_speed)
> -		drive->init_speed = mode;
>  
>  	return 1;
>  }
> @@ -1781,11 +1778,6 @@ pmac_ide_udma_enable(ide_drive_t *drive,
>  	*timings = timing_local[0];
>  	*timings2 = timing_local[1];
>  
> -	/* Set speed info in drive */
> -	drive->current_speed = mode;	
> -	if (!drive->init_speed)
> -		drive->init_speed = mode;
> -
>  	return 1;
>  }
>  

