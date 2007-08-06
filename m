From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 11/11] ide: remove ->ide_dma_check
Date: Mon, 06 Aug 2007 19:06:54 +0400
Message-ID: <46B7390E.5070408@ru.mvista.com>
References: <200708042213.15674.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:9581 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932849AbXHFPEw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Aug 2007 11:04:52 -0400
In-Reply-To: <200708042213.15674.bzolnier@gmail.com>
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

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/drivers/ide/arm/icside.c
> ===================================================================
> --- a/drivers/ide/arm/icside.c
> +++ b/drivers/ide/arm/icside.c
> @@ -309,14 +309,6 @@ static int icside_dma_on(ide_drive_t *dr
>  	return 0;
>  }
>  
> -static int icside_dma_check(ide_drive_t *drive)
> -{
> -	if (ide_tune_dma(drive))
> -		return 0;
> -
> -	return -1;
> -}
> -
>  static int icside_dma_end(ide_drive_t *drive)
>  {
>  	ide_hwif_t *hwif = HWIF(drive);

    Hm, looks like there's going to be some functionality change for this 
driver -- it didn't fallback to PIO before this patch... ;-)

MBR, Sergei
