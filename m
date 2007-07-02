From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 12/15] alim15x3: ->speedproc, filter out invalid modes
 passed from user-space
Date: Mon, 02 Jul 2007 19:42:12 +0400
Message-ID: <46891CD4.7020703@ru.mvista.com>
References: <200706302110.20766.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:15624 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752331AbXGBPka (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jul 2007 11:40:30 -0400
In-Reply-To: <200706302110.20766.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> * ->speedproc, filter out invalid modes passed from user-space.

> * Add FIXME about DMA timings never being set.

> * Bump driver version.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> Index: b/drivers/ide/pci/alim15x3.c
> ===================================================================
> --- a/drivers/ide/pci/alim15x3.c
> +++ b/drivers/ide/pci/alim15x3.c
> @@ -425,6 +425,17 @@ static int ali15x3_tune_chipset (ide_dri
>  	u8 tmpbyte		= 0x00;
>  	int m5229_udma		= (hwif->channel) ? 0x57 : 0x56;
>  
> +	/*
> +	 * Paranoia, filter out invalid modes passed from user-space
> +	 * (unsupported UDMA modes are dealt by ide_rate_filter() call).
> +	 *
> +	 * This will go away once ide_set_xfer() is fixed.
> +	 */
> +	if ((speed > XFER_PIO_5 && speed < XFER_SW_DMA_0) ||
> +	    (speed > XFER_SW_DMA_2 && speed < XFER_MW_DMA_0) ||
> +	    (speed > XFER_MW_DMA_2 && speed < XFER_UDMA_0))
> +		return -1;
> +
>  	if (speed == XFER_UDMA_6)
>  		speed1 = 0x47;
>  
> @@ -437,6 +448,10 @@ static int ali15x3_tune_chipset (ide_dri
>  		tmpbyte &= ultra_enable;
>  		pci_write_config_byte(dev, m5229_udma, tmpbyte);
>  
> +		/*
> +		 * FIXME: Oh, my... DMA timings are never set.
> +		 */
> +

    Erm, wouldn't it have been better to mark them as unsupported while at it?

>  		if (speed < XFER_SW_DMA_0)
>  			(void) ali15x3_tune_pio(drive, speed - XFER_PIO_0);
>  	} else {

MBR, Sergei
