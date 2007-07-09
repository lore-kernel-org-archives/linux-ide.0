From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/12] ide: mode limiting fixes for user requested speed
 changes
Date: Mon, 09 Jul 2007 23:48:15 +0400
Message-ID: <469290FF.1020307@ru.mvista.com>
References: <200707081534.13187.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:5676 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753858AbXGITqN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Jul 2007 15:46:13 -0400
In-Reply-To: <200707081534.13187.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

    Sorry, more grammar nitpicking follows (-:

> * Add an extra argument to ide_max_dma_mode() for passing requested transfer
>   mode.  Use it as an upper limit when finding the best DMA for device/host.

> * Rename ide_max_dma_mode() to ide_find_dma_mode() and at the same time add
>   ide_max_dma_mode() wrapper which passes XFER_UDMA_6 as a requested mode to
>   ide_find_dma_mode().  Also add inline ide_find_dma_mode() version for
>   CONFIG_BLK_DEV_IDEDMA=n case.

> * Pass requested transfer mode from ide_find_dma_mode() to ide_get_mode_mask()
>   to avoid false warning from eighty_ninty_three().

> * Use ide_find_dma_mode() to limit the user requested transfer mode in
>   ide_rate_filter().  Also limit the requested mode by host max PIO mode.


> Above changes make ide_rate_filter() to:

> * Clip desired transfer mode down if it is invalid (values 0x0F, 0x13-0x19
>   and 0x25-0x39, values > 0x46 values were already clipped down, same for

    Too many "values".

>   0x25-0x39 values but iff UDMA was not supported by the host).

> * Clip desired transfer mode down down if it is currently unsupported by

    Again, one "down" to many.

>   IDE core (PIO6 and MWDMA3-4, the latter were already clipped down but
>   iff UDMA was not supported by the host).

> * Clip desired transfer mode down according to the host capabilities
>   (UDMA modes were already clipped down but MWDMA/SWDMA/PIO weren't,
>   also ->atapi_dma flag was not respected).

> * Clip desired transfer mode down according to the device capabilities
>   (except PIO modes for now which require mode work) - shouldn't be a
>   problem since ide_set_xfer_rate() is called _after_ device has accepted
>   given transfer mode.

> and also result in a number of host driver specific bugfixes:

[...]

> * cs5530
>   - clip unsupported PIO5 and SWDMA0-2 modes down
>   - fix unsupported/invalid modes being set on the device
>   - fix bug BUG() on unsupported/invalid modes

    Buggy BUG()? :-)

>     (which happend if the device accepted the setting)

    So, "happens" or "happened"?

> * hpt366
>   - clip unsupported PIO5 and SWDMA0-2 modes down
>   - fix PIO0 timings being programmed for unsupported/invalid modes
>   - fix DMA timings being cleared for MWDMA3-4 and 0x25-0x39 modes
>   - fix unsupported/invalid modes being set on the device

    Oops, inherited that behavior from the old driver.

> * sc1200
>   - clip unsupported PIO5 and SWDMA0-2 modes down
>   - fix unsupported/invalid modes being set on the device
>   - fix bug BUG() on unsupported/invalid modes

    Buggy BUG() again? :-)

>     (which happend if the device accepted the setting)

    So, what tense? :-)

> * tc86c001
>   - clip unsupported PIO5 and SWDMA0-2 modes down
>   - fix PIO0 timings being programmed for PIO5/0x0F/SWDMA0-2/0x13-0x19 modes
>   - fix invalid 0x00 DMA timing being programmed for MWDMA3-4/0x25-0x39 modes
>   - fix unsupported/invalid modes being set on the device

    Oops, that's me who overlooked this. :-<

> While at it:

> * Use ide_rate_filter() in cs5520.c::cs5520_tune_chipset().

    Hm, I thought the previous patch was intended for adding the missing 
ide_rate_filter() calls...

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

... with a minor nit:

> Index: b/drivers/ide/ide-dma.c
> ===================================================================
> --- a/drivers/ide/ide-dma.c
> +++ b/drivers/ide/ide-dma.c
[...]
> @@ -694,8 +694,13 @@ static unsigned int ide_get_mode_mask(id
>  		if (hwif->udma_filter)
>  			mask &= hwif->udma_filter(drive);
>  
> -		if ((mask & 0x78) && (eighty_ninty_three(drive) == 0))
> -			mask &= 0x07;
> +		/*
> +		 * avoid false cable warning from eighty_ninty_three()
> +		 */
> +		if (req_mode > XFER_UDMA_2) {
> +			if ((mask & 0x78) && (eighty_ninty_three(drive) == 0))
> +				mask &= 0x07;
> +		}

    Unneeded curly braces, two if's could be collapsed into single one...

MBR, Sergei
