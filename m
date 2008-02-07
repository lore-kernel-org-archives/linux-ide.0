From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/3] palm_bk3710: factor out cable detection
Date: Thu, 07 Feb 2008 17:41:06 +0300
Message-ID: <47AB1882.8060103@ru.mvista.com>
References: <200802071542.29628.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:40346 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754654AbYBGOkP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Feb 2008 09:40:15 -0500
In-Reply-To: <200802071542.29628.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Anton Salnikov <asalnikov@ru.mvista.com>

Bartlomiej Zolnierkiewicz wrote:

> Factor out cable detection to palm_bk3710_cable_detect().

> Cc: Anton Salnikov <asalnikov@ru.mvista.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> Index: b/drivers/ide/arm/palm_bk3710.c
> ===================================================================
> --- a/drivers/ide/arm/palm_bk3710.c
> +++ b/drivers/ide/arm/palm_bk3710.c
> @@ -311,6 +311,12 @@ static void __devinit palm_bk3710_chipin
>  	palm_bk3710_setpiomode(base, NULL, 0, 600, 0);
>  	palm_bk3710_setpiomode(base, NULL, 1, 600, 0);
>  }
> +
> +static u8 __devinit palm_bk3710_cable_detect(ide_hwif_t *hwif)
> +{
> +	return ATA_CBL_PATA80;
> +}
> +
>  static int __devinit palm_bk3710_probe(struct platform_device *pdev)
>  {
>  	struct clk *clkp;
> @@ -381,7 +387,7 @@ static int __devinit palm_bk3710_probe(s
>  	hwif->set_dma_mode = &palm_bk3710_set_dma_mode;
>  	hwif->mmio = 1;
>  	default_hwif_mmiops(hwif);
> -	hwif->cbl = ATA_CBL_PATA80;
> +	hwif->cbl = palm_bk3710_cable_detect(hwif);
>  	hwif->ultra_mask = 0x1f;	/* Ultra DMA Mode 4 Max
>  						(input clk 99MHz) */
>  	hwif->mwdma_mask = 0x7;

    Hm, how does it help if you don't make it into driver's method? :-O

MBR, Sergei
