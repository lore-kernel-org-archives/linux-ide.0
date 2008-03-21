From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 04/17] ide-tape: remove idetape_empty_write_pipeline()
Date: Fri, 21 Mar 2008 01:09:19 +0100
Message-ID: <200803210109.20131.bzolnier@gmail.com>
References: <1205736090-4435-1-git-send-email-petkovbb@gmail.com> <1205736090-4435-5-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:63287 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756477AbYCTX40 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Mar 2008 19:56:26 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1587157ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 20 Mar 2008 16:56:25 -0700 (PDT)
In-Reply-To: <1205736090-4435-5-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Monday 17 March 2008, Borislav Petkov wrote:
> In order _not_ to skip over some pipeline stages left, we carefully flush any
> remaining ones. Nevertheless, this is only a temporary measure (git-bisect)
> before removing pipeline functionality completely.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> ---
>  drivers/ide/ide-tape.c |   80 ++----------------------------------------------
>  1 files changed, 3 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> index 429fed4..d4a94d5 100644
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -2041,80 +2041,6 @@ static void idetape_wait_for_pipeline(ide_drive_t *drive)
>  	}
>  }
>  
> -static void idetape_empty_write_pipeline(ide_drive_t *drive)
> -{
> -	idetape_tape_t *tape = drive->driver_data;
> -	int blocks, min;
> -	struct idetape_bh *bh;
> -
> -	if (tape->chrdev_dir != IDETAPE_DIR_WRITE) {
> -		printk(KERN_ERR "ide-tape: bug: Trying to empty write pipeline,"
> -				" but we are not writing.\n");
> -		return;
> -	}
> -	if (tape->merge_stage_size > tape->stage_size) {
> -		printk(KERN_ERR "ide-tape: bug: merge_buffer too big\n");
> -		tape->merge_stage_size = tape->stage_size;
> -	}
> -	if (tape->merge_stage_size) {
> -		blocks = tape->merge_stage_size / tape->blk_size;
> -		if (tape->merge_stage_size % tape->blk_size) {
> -			unsigned int i;
> -
> -			blocks++;
> -			i = tape->blk_size - tape->merge_stage_size %
> -				tape->blk_size;
> -			bh = tape->bh->b_reqnext;
> -			while (bh) {
> -				atomic_set(&bh->b_count, 0);
> -				bh = bh->b_reqnext;
> -			}
> -			bh = tape->bh;
> -			while (i) {
> -				if (bh == NULL) {
> -					printk(KERN_INFO "ide-tape: bug,"
> -							 " bh NULL\n");
> -					break;
> -				}
> -				min = min(i, (unsigned int)(bh->b_size -
> -						atomic_read(&bh->b_count)));
> -				memset(bh->b_data + atomic_read(&bh->b_count),
> -						0, min);
> -				atomic_add(min, &bh->b_count);
> -				i -= min;
> -				bh = bh->b_reqnext;
> -			}
> -		}
> -		(void) idetape_add_chrdev_write_request(drive, blocks);
> -		tape->merge_stage_size = 0;

this patch has the same problems as patch #3 => skipped

> -	}
> -	idetape_wait_for_pipeline(drive);
> -	if (tape->merge_stage != NULL) {
> -		__idetape_kfree_stage(tape->merge_stage);
> -		tape->merge_stage = NULL;
> -	}
> -	clear_bit(IDETAPE_FLAG_PIPELINE_ERR, &tape->flags);
> -	tape->chrdev_dir = IDETAPE_DIR_NONE;
> -
> -	/*
> -	 * On the next backup, perform the feedback loop again. (I don't want to
> -	 * keep sense information between backups, as some systems are
> -	 * constantly on, and the system load can be totally different on the
> -	 * next backup).
> -	 */
> -	tape->max_stages = tape->min_pipeline;
> -	if (tape->first_stage != NULL ||
> -	    tape->next_stage != NULL ||
> -	    tape->last_stage != NULL ||
> -	    tape->nr_stages != 0) {
> -		printk(KERN_ERR "ide-tape: ide-tape pipeline bug, "
> -			"first_stage %p, next_stage %p, "
> -			"last_stage %p, nr_stages %d\n",
> -			tape->first_stage, tape->next_stage,
> -			tape->last_stage, tape->nr_stages);
> -	}
> -}
> -
>  static int idetape_init_read(ide_drive_t *drive, int max_stages)
>  {
>  	idetape_tape_t *tape = drive->driver_data;
> @@ -2123,7 +2049,7 @@ static int idetape_init_read(ide_drive_t *drive, int max_stages)
>  	/* Initialize read operation */
>  	if (tape->chrdev_dir != IDETAPE_DIR_READ) {
>  		if (tape->chrdev_dir == IDETAPE_DIR_WRITE) {
> -			idetape_empty_write_pipeline(drive);
> +			idetape_wait_for_pipeline(drive);
>  			idetape_flush_tape_buffers(drive);
>  		}
>  		if (tape->merge_stage || tape->merge_stage_size) {
> @@ -2702,7 +2628,7 @@ static int idetape_chrdev_ioctl(struct inode *inode, struct file *file,
>  	debug_log(DBG_CHRDEV, "Enter %s, cmd=%u\n", __func__, cmd);
>  
>  	if (tape->chrdev_dir == IDETAPE_DIR_WRITE) {
> -		idetape_empty_write_pipeline(drive);
> +		idetape_wait_for_pipeline(drive);
>  		idetape_flush_tape_buffers(drive);
>  	}
>  	if (cmd == MTIOCGET || cmd == MTIOCPOS) {
> @@ -2852,7 +2778,7 @@ static void idetape_write_release(ide_drive_t *drive, unsigned int minor)
>  {
>  	idetape_tape_t *tape = drive->driver_data;
>  
> -	idetape_empty_write_pipeline(drive);
> +	idetape_wait_for_pipeline(drive);
>  	tape->merge_stage = __idetape_kmalloc_stage(tape, 1, 0);
>  	if (tape->merge_stage != NULL) {
>  		idetape_pad_zeros(drive, tape->blk_size *
