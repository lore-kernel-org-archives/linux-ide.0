From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: convert ide_find_best_mode() users to use ide_max_dma_mode()
Date: Tue, 12 Jun 2007 17:30:56 +0400
Message-ID: <466EA010.7090108@ru.mvista.com>
References: <200706092210.52291.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:36764 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753818AbXFLN3L (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 Jun 2007 09:29:11 -0400
In-Reply-To: <200706092210.52291.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> ide-timing.h:

> * remove handling of DMA modes from ide_find_best_mode() and rename it to
>   ide_find_best_pio_mode()

> * drop no longer needed "map" argument from ide_find_best_pio_mode()
>   and delete needless ->id check

> * remove no longer needed XFER_SWDMA and XFER_UDMA* defines

> au1xxx-ide.c:

> * use ide_max_dma_mode() instead of ide_find_best_mode()

> * remove needless CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA #ifdef

> amd74xx.c:
> 
> * store UDMA masks in amd_ide_chip[] and while at it make "base" field
>   to be u8 instead of unsigned long
> 
> * convert the driver to use UDMA masks from amd_ide_chip[]
> 
> * use ide_max_dma_mode() and ide_find_best_pio_mode() instead
>   of ide_find_best_mode()
> 
> * delete stale comment from amd74xx_ide_dma_check()
> 
> * remove no longer needed AMD_UDMA* defines
> 
> via82cxxx.c:

> * remove unused DISPLAY_VIA_TIMINGS define

> * store UDMA masks in via_isa_bridges[] and while at it make "flags" field
>   to be u8 instead of u16

> * convert the driver to use UDMA masks from via_isa_bridges[]

> * use ide_max_dma_mode() and ide_find_best_pio_mode() instead
>   of ide_find_best_mode()

> * remove no longer needed VIA_UDMA* defines

> pmac.c:

> * use ide_max_dma_mode() instead of ide_find_best_mode()

> There should be no functionality changes caused by this patch.

    I'm afraid this hasn't been accomplished yet. ;-)

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> Index: b/drivers/ide/mips/au1xxx-ide.c
> ===================================================================
> --- a/drivers/ide/mips/au1xxx-ide.c
> +++ b/drivers/ide/mips/au1xxx-ide.c
> @@ -381,9 +381,7 @@ static int auide_dma_setup(ide_drive_t *
>  
>  static int auide_dma_check(ide_drive_t *drive)
>  {
> -	u8 speed;
> -
> -#ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
> +	u8 speed = ide_max_dma_mode(drive);
>  
>  	if( dbdma_init_done == 0 ){

    Ugh, coding style isnn't kosher here. :-)

>  		auide_hwif.white_list = ide_in_drive_list(drive->id,
> @@ -394,7 +392,6 @@ static int auide_dma_check(ide_drive_t *
>  		auide_ddma_init(&auide_hwif);
>  		dbdma_init_done = 1;
>  	}
> -#endif
>  
>  	/* Is the drive in our DMA black list? */
>  
> @@ -409,8 +406,6 @@ static int auide_dma_check(ide_drive_t *
>  	else
>  		drive->using_dma = 1;
>  
> -	speed = ide_find_best_mode(drive, XFER_PIO | XFER_MWDMA);
> -	
>  	if (drive->autodma && (speed & XFER_MODE) != XFER_PIO)

    ide_max_dma_mode() returns 0 if DMA not available, so that if should have 
looked this way:

  	if (drive->autodma && speed)

>  		return 0;

    But is this really equivalent? Why there's no fallback call to 
ide_find_best_pio_mode() like in other cases?

MBR, Sergei
