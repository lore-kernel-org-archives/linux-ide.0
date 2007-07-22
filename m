From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/11] ide-pmac: pmac_ide_tune_chipset() fixes
Date: Mon, 23 Jul 2007 07:55:27 +1000
Message-ID: <1185141328.5439.60.camel@localhost.localdomain>
References: <200707222021.38796.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:47984 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753421AbXGVVzd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Jul 2007 17:55:33 -0400
In-Reply-To: <200707222021.38796.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sun, 2007-07-22 at 20:21 +0200, Bartlomiej Zolnierkiewicz wrote:
> * Don't check check for pmif == NULL (it should never be NULL if we got here).
> 
> * Make a local copy of the timings and set the pmif->timings[] only after
>   setting the transfer mode on the device (otherwise SELECT_DRIVE() call in
>   pmac_ide_do_setfeature() will program new timings before the transfer mode
>   is set on the device - this was pointed out by Sergei).  This change makes
>   pmac_ide_tune_chipset() behavior match this of pmac_ide_{m,u}dma_enable().
> 

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ide/ppc/pmac.c |   27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> Index: b/drivers/ide/ppc/pmac.c
> ===================================================================
> --- a/drivers/ide/ppc/pmac.c
> +++ b/drivers/ide/ppc/pmac.c
> @@ -915,14 +915,15 @@ static int pmac_ide_tune_chipset(ide_dri
>  	int unit = (drive->select.b.unit & 0x01);
>  	int ret = 0;
>  	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)HWIF(drive)->hwif_data;
> -	u32 *timings, *timings2;
> +	u32 *timings, *timings2, tl[2];
>  
> -	if (pmif == NULL)
> -		return 1;
> -		
>  	timings = &pmif->timings[unit];
>  	timings2 = &pmif->timings[unit+2];
> -	
> +
> +	/* Copy timings to local image */
> +	tl[0] = *timings;
> +	tl[1] = *timings2;
> +
>  	switch(speed) {
>  #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
>  		case XFER_UDMA_6:
> @@ -933,19 +934,19 @@ static int pmac_ide_tune_chipset(ide_dri
>  		case XFER_UDMA_1:
>  		case XFER_UDMA_0:
>  			if (pmif->kind == controller_kl_ata4)
> -				ret = set_timings_udma_ata4(timings, speed);
> +				ret = set_timings_udma_ata4(&tl[0], speed);
>  			else if (pmif->kind == controller_un_ata6
>  				 || pmif->kind == controller_k2_ata6)
> -				ret = set_timings_udma_ata6(timings, timings2, speed);
> +				ret = set_timings_udma_ata6(&tl[0], &tl[1], speed);
>  			else if (pmif->kind == controller_sh_ata6)
> -				ret = set_timings_udma_shasta(timings, timings2, speed);
> +				ret = set_timings_udma_shasta(&tl[0], &tl[1], speed);
>  			else
> -				ret = 1;		
> +				ret = 1;
>  			break;
>  		case XFER_MW_DMA_2:
>  		case XFER_MW_DMA_1:
>  		case XFER_MW_DMA_0:
> -			ret = set_timings_mdma(drive, pmif->kind, timings, timings2, speed, 0);
> +			ret = set_timings_mdma(drive, pmif->kind, &tl[0], &tl[1], speed, 0);
>  			break;
>  		case XFER_SW_DMA_2:
>  		case XFER_SW_DMA_1:
> @@ -961,7 +962,11 @@ static int pmac_ide_tune_chipset(ide_dri
>  	ret = pmac_ide_do_setfeature(drive, speed);
>  	if (ret)
>  		return ret;
> -		
> +
> +	/* Apply timings to controller */
> +	*timings = tl[0];
> +	*timings2 = tl[1];
> +
>  	pmac_ide_do_update_timings(drive);	
>  
>  	return 0;

