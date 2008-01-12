From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 21/21] ide-floppy: remove atomic test_*bit macros
Date: Sat, 12 Jan 2008 21:19:34 +0100
Message-ID: <200801122119.34418.bzolnier@gmail.com>
References: <1200052699-28420-1-git-send-email-bbpetkov@yahoo.de> <1200052699-28420-21-git-send-email-bbpetkov@yahoo.de> <1200052699-28420-22-git-send-email-bbpetkov@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:20665 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759160AbYALUUJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Jan 2008 15:20:09 -0500
Received: by ug-out-1314.google.com with SMTP id z38so640522ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 12 Jan 2008 12:20:08 -0800 (PST)
In-Reply-To: <1200052699-28420-22-git-send-email-bbpetkov@yahoo.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Friday 11 January 2008, Borislav Petkov wrote:
> This change is temporary and after unification of the IDE subsystem proper
> bit setting and testing macros will be introduced.
> 
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
> ---
>  drivers/ide/ide-floppy.c |   82 +++++++++++++++++++++++++---------------------
>  1 files changed, 45 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
> index 4106eb4..29c1983 100644
> --- a/drivers/ide/ide-floppy.c
> +++ b/drivers/ide/ide-floppy.c
> @@ -479,12 +479,12 @@ static ide_startstop_t idefloppy_pc_intr(ide_drive_t *drive)
>  
>  	debug_log("Reached %s interrupt handler\n", __FUNCTION__);
>  
> -	if (test_bit(PC_DMA_IN_PROGRESS, &pc->flags)) {
> +	if ((1UL << PC_DMA_IN_PROGRESS) & pc->flags) {

How's about introducing new defines i.e.

enum {
	IDE_FLOPPY_FLAG_PC_ABORT		= (1 << 0),
	IDE_FLOPPY_FLAG_PC_DMA_RECOMMENDED	= (1 << 1),
	IDE_FLOPPY_FLAG_PC_DMA_IN_PROGRESS	= (1 << 2),
	...
}

instead of open-coding the bit-shifts?

>  		dma_error = HWIF(drive)->ide_dma_end(drive);
>  		if (dma_error) {
>  			printk(KERN_ERR "%s: DMA %s error\n", drive->name,
>  					write ?	"write" : "read");
> -			set_bit(PC_DMA_ERROR, &pc->flags);
> +			pc->flags |= (1UL << PC_DMA_ERROR);
>  		} else {
>  			pc->actually_transferred = pc->request_transfer;
>  			idefloppy_update_buffers(drive, pc);
> @@ -499,11 +499,11 @@ static ide_startstop_t idefloppy_pc_intr(ide_drive_t *drive)
>  		/* No more interrupts */
>  		debug_log("Packet command completed, %d bytes transferred\n",
>  				pc->actually_transferred);
> -		clear_bit(PC_DMA_IN_PROGRESS, &pc->flags);
> +		pc->flags &= ((1UL << PC_DMA_IN_PROGRESS) ^ ~0UL);

Same can be achieved with:

		pc->flags &= ~(1 << PC_DMA_IN_PROGRESS);
