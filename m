From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 14/18] ide: add IDE_HFLAG_ABUSE_SET_DMA_MODE host flag
Date: Thu, 15 Nov 2007 13:21:16 +0300
Message-ID: <473C1D9C.5000208@ru.mvista.com>
References: <200711050031.10290.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:55681 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756957AbXKOKVE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Nov 2007 05:21:04 -0500
In-Reply-To: <200711050031.10290.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Add IDE_HFLAG_ABUSE_SET_DMA_MODE host flag and use it to decide
>   what to do with transfer modes < XFER_PIO_0 in ide_set_xfer_rate().

> * Set IDE_HFLAG_ABUSE_SET_DMA_MODE in host drivers that need it
>   (aec62xx, amd74xx, cs5520, cs5535, hpt34x, hpt366, pdc202xx_old,
>   serverworks, tc86c001 and via82cxxx) and cleanup ->set_dma_mode
>   methods in host drivers that don't (IDE core code guarantees that
>   ->set_dma_mode will be called only for modes which are present
>   in SWDMA/MWDMA/UDMA masks).

> While at it:

> * Add IDE_HFLAGS_HPT34X/HPT3XX/PDC202XX/SVWKS define in
>   hpt34x/hpt366/pdc202xx_old/serverworks host driver.

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/drivers/ide/ide-lib.c
> ===================================================================
> --- a/drivers/ide/ide-lib.c
> +++ b/drivers/ide/ide-lib.c
> @@ -438,6 +438,12 @@ int ide_set_xfer_rate(ide_drive_t *drive
>  	 * case could happen iff the transfer mode has already been set on
>  	 * the device by ide-proc.c::set_xfer_rate()).
>  	 */
> +	if (rate < XFER_PIO_0) {
> +		if (hwif->host_flags & IDE_HFLAG_ABUSE_SET_DMA_MODE)
> +			return ide_set_dma_mode(drive, rate);

    Not sure if it was worth the effort at all...

> +		else
> +			return ide_config_drive_speed(drive, rate);

    It's tome that I go and make a patch which deals with 0x00 (default PIO 
mode)...

> +	}
>  
>  	return ide_set_dma_mode(drive, rate);
>  }

MBR, Sergei
