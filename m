From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 03/10] ide-atapi: teach ide atapi about drive->waiting_for_dma
Date: Mon, 15 Sep 2008 20:15:51 +0200
Message-ID: <200809152015.51684.bzolnier@gmail.com>
References: <1221392158-3848-1-git-send-email-petkovbb@gmail.com> <1221392158-3848-4-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:10054 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394AbYIOScK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Sep 2008 14:32:10 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2270271rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 15 Sep 2008 11:32:10 -0700 (PDT)
In-Reply-To: <1221392158-3848-4-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Sunday 14 September 2008 13:35:51 Borislav Petkov wrote:
> This is in preparation for converting ide-cd to generic code. The actual
> rewiring will be done later after the issue_pc/transfer_pc code knows all about
> ide-cd.
> 
> There should be no functional change resulting from this patch.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> ---
>  drivers/ide/ide-atapi.c |   16 +++++++++++++---
>  1 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
> index d557841..763acd7 100644
> --- a/drivers/ide/ide-atapi.c
> +++ b/drivers/ide/ide-atapi.c
> @@ -487,7 +487,13 @@ static ide_startstop_t ide_transfer_pc(ide_drive_t *drive)
>  	ide_startstop_t startstop;
>  	u8 ireason;
>  
> -	if (ide_wait_stat(&startstop, drive, ATA_DRQ, ATA_BUSY, WAIT_READY)) {
> +	if ((drive->media == ide_cdrom || drive->media == ide_optical) &&
> +	    (drive->atapi_flags & IDE_AFLAG_DRQ_INTERRUPT)) {
> +		if (drive->dma)
> +			drive->waiting_for_dma = 1;
> +	}

We really want to do this for all ATAPI devices (as a bugfix).

> +	else if (ide_wait_stat(&startstop, drive, ATA_DRQ, ATA_BUSY,
> +			       WAIT_READY)) {

IIRC similar check was removed from ide-cd so maybe this one
is also unnecessary?

>  		printk(KERN_ERR "%s: Strange, packet command initiated yet "
>  				"DRQ isn't asserted\n", drive->name);
>  		return startstop;
> @@ -562,8 +568,10 @@ ide_startstop_t ide_issue_pc(ide_drive_t *drive, unsigned int timeout,
>  		ide_dma_off(drive);
>  	}
>  
> -	if ((pc->flags & PC_FLAG_DMA_OK) &&
> -	    (drive->dev_flags & IDE_DFLAG_USING_DMA)) {
> +	if (((pc->flags & PC_FLAG_DMA_OK) &&
> +		(drive->dev_flags & IDE_DFLAG_USING_DMA)) ||
> +	    ((drive->media == ide_cdrom || drive->media == ide_optical) &&
> +	         drive->dma)) {

drive->dma is only set by ide-cd so no need to check for media type,
also I think that it better fits in some later patch.

>  		if (scsi)
>  			hwif->sg_mapped = 1;
>  		drive->dma = !hwif->dma_ops->dma_setup(drive);
> @@ -579,6 +587,8 @@ ide_startstop_t ide_issue_pc(ide_drive_t *drive, unsigned int timeout,
>  
>  	/* Issue the packet command */
>  	if (drive->atapi_flags & IDE_AFLAG_DRQ_INTERRUPT) {
> +		if (drive->dma)
> +			drive->waiting_for_dma = 0;
>  		ide_execute_command(drive, ATA_CMD_PACKET, ide_transfer_pc,
>  				    timeout, NULL);
>  		return ide_started;

Please recast the patch to have only ->waiting_for_dma change.  Thanks.
