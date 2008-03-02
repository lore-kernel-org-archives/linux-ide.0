From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 03/24] ide-tape: remove pipeline-specific code from idetape_add_chrdev_read_request
Date: Sun, 2 Mar 2008 19:36:12 +0100
Message-ID: <200803021936.12741.bzolnier@gmail.com>
References: <1204361928-30229-1-git-send-email-petkovbb@gmail.com> <1204361928-30229-4-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:37615 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758792AbYCBTDd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Mar 2008 14:03:33 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1533900ugc.16
        for <linux-ide@vger.kernel.org>; Sun, 02 Mar 2008 11:03:33 -0800 (PST)
In-Reply-To: <1204361928-30229-4-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Saturday 01 March 2008, Borislav Petkov wrote:
> We fall back to non-pipelined operation through idetape_queue_rw_tail with cmd
> set to REQ_IDETAPE_READ. Also, remove idetape_switch_buffers() since it becomes
> unused.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> ---
>  drivers/ide/ide-tape.c |   46 +---------------------------------------------
>  1 files changed, 1 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> index abf3efa..e919d41 100644
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -1776,16 +1776,6 @@ static void idetape_init_merge_stage(idetape_tape_t *tape)
>  	}
>  }
>  
> -static void idetape_switch_buffers(idetape_tape_t *tape, idetape_stage_t *stage)
> -{
> -	struct idetape_bh *tmp;
> -
> -	tmp = stage->bh;
> -	stage->bh = tape->merge_stage->bh;
> -	tape->merge_stage->bh = tmp;
> -	idetape_init_merge_stage(tape);
> -}
> -
>  /* Add a new stage at the end of the pipeline. */
>  static void idetape_add_stage_tail(ide_drive_t *drive, idetape_stage_t *stage)
>  {
> @@ -2403,9 +2393,6 @@ static int idetape_init_read(ide_drive_t *drive, int max_stages)
>  static int idetape_add_chrdev_read_request(ide_drive_t *drive, int blocks)
>  {
>  	idetape_tape_t *tape = drive->driver_data;
> -	unsigned long flags;
> -	struct request *rq_ptr;
> -	int bytes_read;
>  
>  	debug_log(DBG_PROCS, "Enter %s, %d blocks\n", __func__, blocks);
>  
> @@ -2413,39 +2400,8 @@ static int idetape_add_chrdev_read_request(ide_drive_t *drive, int blocks)
>  	if (test_bit(IDETAPE_FLAG_FILEMARK, &tape->flags))
>  		return 0;
>  
> -	/* Wait for the next block to reach the head of the pipeline. */
> -	idetape_init_read(drive, tape->max_stages);

Can it be simply removed?  Why?

> -	if (tape->first_stage == NULL) {
> -		if (test_bit(IDETAPE_FLAG_PIPELINE_ERR, &tape->flags))
> -			return 0;
> -		return idetape_queue_rw_tail(drive, REQ_IDETAPE_READ, blocks,
> +	return idetape_queue_rw_tail(drive, REQ_IDETAPE_READ, blocks,
>  					tape->merge_stage->bh);

Looking at the driver code tape->first_stage is not always NULL,
seems like ide_tape_add_stage_tail() should vanish first?
