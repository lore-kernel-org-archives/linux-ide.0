From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/13] siimage: fix wrong ->swdma_mask
Date: Sun, 11 Mar 2007 00:22:36 +0300
Message-ID: <45F3219C.5040500@ru.mvista.com>
References: <200703102212.49447.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:50880 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750726AbXCJVWq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Mar 2007 16:22:46 -0500
In-Reply-To: <200703102212.49447.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> [PATCH] siimage: fix wrong ->swdma_mask

> This driver doesn't support SWDMA so use the correct ->swdma_mask.

> While at it:

> * no need to call config_chipset_for_pio() in config_chipset_for_dma(),
>   if DMA is not available config_chipset_for_pio() will be called
>   by siimage_config_drive_for_dma() and if DMA is available
>   config_siimage_chipset_for_pio() will be called by siimage_tune_chipset()

    Ugh, this driver has such a messy code PIO-wise!  There seems to be 
completely no point in calling config_siimage_chipset_for_pio() from 
siimage_tune_chipset().  Not mentioning that tuneproc() method fails to 
actually control IORDY (it only twiddles IORDY bits for taskfile access). Ah, 
and tuneproc() fails to set the drive's own mode (as usual)... :-)
    I was going to post patches but then figured out that we don't actually 
support this driver, so the priority has significatly dropped. :-)

> * remove needless config_chipset_for_pio() wrapper

> * bump driver version

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
> 
>  drivers/ide/pci/siimage.c |   12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> Index: b/drivers/ide/pci/siimage.c
> ===================================================================
> --- a/drivers/ide/pci/siimage.c
> +++ b/drivers/ide/pci/siimage.c
> @@ -1,5 +1,5 @@
>  /*
> - * linux/drivers/ide/pci/siimage.c		Version 1.11	Jan 27, 2007
> + * linux/drivers/ide/pci/siimage.c		Version 1.12	Mar 10 2007
>   *
>   * Copyright (C) 2001-2002	Andre Hedrick <andre@linux-ide.org>
>   * Copyright (C) 2003		Red Hat <alan@redhat.com>
> @@ -283,11 +283,6 @@ static void config_siimage_chipset_for_p
>  		(void) ide_config_drive_speed(drive, speed);
>  }
>  
> -static void config_chipset_for_pio (ide_drive_t *drive, byte set_speed)
> -{
> -	config_siimage_chipset_for_pio(drive, set_speed);
> -}
> -
>  /**
>   *	siimage_tune_chipset	-	set controller timings
>   *	@drive: Drive to set up
> @@ -392,8 +387,6 @@ static int config_chipset_for_dma (ide_d
>  {
>  	u8 speed = ide_max_dma_mode(drive);
>  
> -	config_chipset_for_pio(drive, !speed);
> -
>  	if (!speed)
>  		return 0;
>  
> @@ -419,7 +412,7 @@ static int siimage_config_drive_for_dma 
>  		return 0;
>  
>  	if (ide_use_fast_pio(drive))
> -		config_chipset_for_pio(drive, 1);
> +		config_siimage_chipset_for_pio(drive, 1);
>  
>  	return -1;
>  }
> @@ -1012,7 +1005,6 @@ static void __devinit init_hwif_siimage(
>  
>  	hwif->ultra_mask = 0x7f;
>  	hwif->mwdma_mask = 0x07;
> -	hwif->swdma_mask = 0x07;
>  
>  	if (!is_sata(hwif))
>  		hwif->atapi_dma = 1;
