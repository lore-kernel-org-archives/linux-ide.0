From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/3] Don't change transfer speed while requests are in flight
Date: Wed, 21 Feb 2007 03:05:16 +0100
Message-ID: <200702210305.16793.bzolnier@gmail.com>
References: <20070221012112.GB1777@freefall.freebsd.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:51860 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965356AbXBUB7K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Feb 2007 20:59:10 -0500
Received: by ug-out-1314.google.com with SMTP id 44so950971uga
        for <linux-ide@vger.kernel.org>; Tue, 20 Feb 2007 17:59:08 -0800 (PST)
In-Reply-To: <20070221012112.GB1777@freefall.freebsd.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Suleiman Souhlal <ssouhlal@freebsd.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


On Wednesday 21 February 2007 02:21, Suleiman Souhlal wrote:
> Use ide_wait_cmd() in ide_config_drive_speed() if the drive has been
> initialized and we're not in an interrupt, to avoid changing the
> xfer speed while requests are in flight.

Many devices have problems with SETFEATURES_XFER if the WIN_SETFEATURES
command is driven by IRQ so we must resort to the polling mode.
This also implies that ide_config_drive_speed() generally does its
job right and the problem lies in the higher layers.

set_using_dma() should queue special driver specific request (same goes
for some other options from /proc/ide/hdx/settings / ioctls).

I have a patch re-writting /proc/ide/hdx/settings so that there are
->get/->set methods for each setting.  This should help in designing
special driver request but I need some more time to sync the patch
with the recent IDE changes.  I will get back to you on this one.

Thanks,
Bart

> An easy way to trigger the problem is to dd the disk while doing
> while :; do hdparm -d 1 /dev/hdc> /dev/null; done
> 
> While there, remove some commented-out code.
> 
> Signed-off-by:	Suleiman Souhlal <suleiman@google.com>
> 
> ---
>  drivers/ide/ide-iops.c |   35 ++++++++++++++++++++---------------
>  1 files changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
> index c67b3b1..35ab3af 100644
> --- a/drivers/ide/ide-iops.c
> +++ b/drivers/ide/ide-iops.c
> @@ -748,32 +748,36 @@ int ide_config_drive_speed (ide_drive_t 
>  	int	i, error	= 1;
>  	u8 stat;
>  
> -//	while (HWGROUP(drive)->busy)
> -//		msleep(50);
> +	/*
> +	 * Just use ide_wait_cmd() if the drive has been initialized and we
> +	 * aren't in an interrupt handler, to avoid changing the xfer speed
> +	 * while requests are in flight.
> +	 *
> +	 * If we are in an interrupt, it should be safe to issue
> +	 * SETFEATURES manually, since there shouldn't be any requests in
> +	 * flight.
> +	 */
> +	if (drive->queue != NULL && !in_interrupt()) {
> +		error = ide_wait_cmd(drive, WIN_SETFEATURES, speed,
> +		    SETFEATURES_XFER, 0, NULL);
> +		if (error) {
> +			stat = hwif->INB(IDE_STATUS_REG);
> +			ide_dump_status(drive, "set_drive_speed_status", stat);
> +			return (error);
> +		}
> +		goto done;
> +	}
>  
>  #ifdef CONFIG_BLK_DEV_IDEDMA
>  	if (hwif->ide_dma_check)	 /* check if host supports DMA */
>  		hwif->dma_host_off(drive);
>  #endif
>  
> -	/*
> -	 * Don't use ide_wait_cmd here - it will
> -	 * attempt to set_geometry and recalibrate,
> -	 * but for some reason these don't work at
> -	 * this point (lost interrupt).
> -	 */
>          /*
>           * Select the drive, and issue the SETFEATURES command
>           */
>  	disable_irq_nosync(hwif->irq);
>  	
> -	/*
> -	 *	FIXME: we race against the running IRQ here if
> -	 *	this is called from non IRQ context. If we use
> -	 *	disable_irq() we hang on the error path. Work
> -	 *	is needed.
> -	 */
> -	 
>  	udelay(1);
>  	SELECT_DRIVE(drive);
>  	SELECT_MASK(drive, 0);
> @@ -835,6 +839,7 @@ #ifdef CONFIG_BLK_DEV_IDEDMA
>  		hwif->dma_off_quietly(drive);
>  #endif
>  
> +done:
>  	switch(speed) {
>  		case XFER_UDMA_7:   drive->id->dma_ultra |= 0x8080; break;
>  		case XFER_UDMA_6:   drive->id->dma_ultra |= 0x4040; break;
> 
> 
