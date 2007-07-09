From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/12] ide: add missing ide_rate_filter() calls to ->speedproc()-s
Date: Mon, 09 Jul 2007 18:03:59 +0400
Message-ID: <4692404F.6050105@ru.mvista.com>
References: <200707081534.06163.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:2934 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752703AbXGIOB6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2007 10:01:58 -0400
In-Reply-To: <200707081534.06163.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:
> * Fix icside, cris-ide, au1xxx-ide, amd74xx, via82cxxx and pmac host drivers
>   to use ide_rate_filter().

>   This results in the following modes (from user requests) being clipped down:
>   - invalid modes (values 0x46-0xFF)  [ for all hosts ]
>   - unsupported by a host UDMA modes  [ for hosts which support UDMA]
>   - all UDMA modes and MWDMA3-4 modes [ for hosts which doesn't support UDMA ]
>   - invalid modes (values 0x25-0x39)  [ for hosts which doesn't support UDMA ]

    For plural 3rd person it would be "don't". ;-)
    Sorry for the grammar nitpicking

> * Host driver specific changes in behavior:

>   icside:
>     - no change

>   cris-ide
>     - clip unsupported UDMA3-6 modes down
>     - fix BUG() on trying to set unsupported UDMA3-6 modes

>   au1xxx-ide/pmac
>     - clip unsupported UDMA modes down

>   amd74xx/via82cxxx
>     - clip unsupported UDMA modes down
>     - fix random PIO timings being set for unsupported/invalid modes
>     - fix unsupported/invalid modes being set on the device

> * While at it remove no longer needed checks from pmac.c driver.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> ---
> This patch series goes before ide-add-ide-set-pio-take3.patch patch
> ("[PATCH] ide: add ide_set{_max}_pio() (take 3)") in the quilt tree.
> The rediffed ide-add-ide-set-pio-take3.patch is also included for
> completness.

> Index: b/drivers/ide/ppc/pmac.c
> ===================================================================
> --- a/drivers/ide/ppc/pmac.c
> +++ b/drivers/ide/ppc/pmac.c
> @@ -923,6 +923,8 @@ pmac_ide_tune_chipset (ide_drive_t *driv
>  	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)HWIF(drive)->hwif_data;
>  	u32 *timings, *timings2;
>  
> +	speed = ide_rate_filter(drive, speed);
> +
>  	if (pmif == NULL)
>  		return 1;
>  		
> @@ -932,17 +934,9 @@ pmac_ide_tune_chipset (ide_drive_t *driv
>  	switch(speed) {
>  #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
>  		case XFER_UDMA_6:
> -		        if (pmif->kind != controller_sh_ata6)
> -				return 1;
>  		case XFER_UDMA_5:
> -			if (pmif->kind != controller_un_ata6 &&
> -			    pmif->kind != controller_k2_ata6 &&
> -			    pmif->kind != controller_sh_ata6)
> -				return 1;
>  		case XFER_UDMA_4:
>  		case XFER_UDMA_3:
> -			if (drive->hwif->cbl != ATA_CBL_PATA80)
> -				return 1;
>  		case XFER_UDMA_2:
>  		case XFER_UDMA_1:
>  		case XFER_UDMA_0:

    BTW, I just saw a stange code in this driver that clips hwif->udma_mask 
depending on pmif->cable_80. I somewhat doubt that it's necessary...

MBR, Sergei
