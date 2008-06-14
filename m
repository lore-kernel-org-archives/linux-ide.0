From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 13/18] ide-floppy: replace pc->c with rq->cmd
Date: Sat, 14 Jun 2008 19:40:22 +0200
Message-ID: <200806141940.22838.bzolnier@gmail.com>
References: <1213252870-20474-1-git-send-email-petkovbb@gmail.com> <1213252870-20474-14-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:9239 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754345AbYFNRrU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Jun 2008 13:47:20 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3007232fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 14 Jun 2008 10:47:19 -0700 (PDT)
In-Reply-To: <1213252870-20474-14-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Thursday 12 June 2008, Borislav Petkov wrote:
> This is the first one in the series attempting to phase out ide_atapi_pc and use
> block request structs. Also, the pc request type is now REQ_TYPE_BLOCK_PC. As a result,
> idefloppy_blockpc_cmd becomes unused and can go.

Do not attack too many dragons at once or they will slay you... ;)

IOW this patch mixes too many changes (some _really_ non-trivial)
in one go which results in rather bad outcome...

[...]

> diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
> index b368943..ffebf83 100644
> --- a/drivers/ide/ide-floppy.c
> +++ b/drivers/ide/ide-floppy.c
> @@ -217,7 +217,7 @@ static int idefloppy_end_request(ide_drive_t *drive, int uptodate, int nsecs)
>  	/* Why does this happen? */
>  	if (!rq)
>  		return 0;
> -	if (!blk_special_request(rq)) {
> +	if (!blk_pc_request(rq)) {
>  		/* our real local end request function */
>  		ide_end_request(drive, uptodate, nsecs);
>  		return 0;
> @@ -282,13 +282,14 @@ static void idefloppy_update_buffers(ide_drive_t *drive,
>   * pass through the driver.
>   */
>  static void idefloppy_queue_pc_head(ide_drive_t *drive, struct ide_atapi_pc *pc,
> -		struct request *rq)
> +		struct request *rq, unsigned char *cmd)
>  {
>  	struct ide_floppy_obj *floppy = drive->driver_data;
>  
>  	blk_rq_init(NULL, rq);
>  	rq->buffer = (char *) pc;
> -	rq->cmd_type = REQ_TYPE_SPECIAL;
> +	rq->cmd_type = REQ_TYPE_BLOCK_PC;
> +	memcpy(rq->cmd, cmd, 12);
>  	rq->cmd_flags |= REQ_PREEMPT;
>  	rq->rq_disk = floppy->disk;
>  	ide_do_drive_cmd(drive, rq);

REQUEST SENSE command is switched from REQ_TYPE_SPECIAL to REQ_TYPE_BLOCK_PC
which should belong to a separate patch and is premature IMHO (the other
ATAPI drivers seem to still use REQ_TYPE_SPECIAL so probably it makes sense
to unify/move REQUEST_SENSE handling to ide-atapi.c first).

> @@ -323,10 +324,10 @@ static void ide_floppy_callback(ide_drive_t *drive)
>  	if (floppy->failed_pc == pc)
>  		floppy->failed_pc = NULL;
>  
> -	if (pc->c[0] == GPCMD_READ_10 || pc->c[0] == GPCMD_WRITE_10 ||
> -	    (pc->rq && blk_pc_request(pc->rq)))
> +	if (pc->rq->cmd[0] == GPCMD_READ_10 || pc->rq->cmd[0] == GPCMD_WRITE_10
> +			|| (pc->rq && blk_pc_request(pc->rq)))
>  		uptodate = 1; /* FIXME */

This actually seems to break REQUEST SENSE handling
(please note the blk_pc_request() check above)... :(

> -	else if (pc->c[0] == GPCMD_REQUEST_SENSE) {
> +	else if (pc->rq->cmd[0] == GPCMD_REQUEST_SENSE) {

[...]

> @@ -592,25 +601,6 @@ static void idefloppy_create_rw_cmd(idefloppy_floppy_t *floppy,
>  	pc->flags |= PC_FLAG_DMA_OK;
>  }
>  
> -static void idefloppy_blockpc_cmd(idefloppy_floppy_t *floppy,
> -		struct ide_atapi_pc *pc, struct request *rq)
> -{
> -	idefloppy_init_pc(pc);
> -	memcpy(pc->c, rq->cmd, sizeof(pc->c));
> -	pc->rq = rq;
> -	pc->b_count = rq->data_len;
> -	if (rq->data_len && rq_data_dir(rq) == WRITE)
> -		pc->flags |= PC_FLAG_WRITING;
> -	pc->buf = rq->data;
> -	if (rq->bio)
> -		pc->flags |= PC_FLAG_DMA_OK;
> -	/*
> -	 * possibly problematic, doesn't look like ide-floppy correctly
> -	 * handled scattered requests if dma fails...
> -	 */
> -	pc->req_xfer = pc->buf_size = rq->data_len;
> -}

[...]

> @@ -644,12 +634,9 @@ static ide_startstop_t idefloppy_do_request(ide_drive_t *drive,
>  		}
>  		pc = idefloppy_next_pc_storage(drive);
>  		idefloppy_create_rw_cmd(floppy, pc, rq, block);
> -	} else if (blk_special_request(rq)) {
> +	} else if (blk_pc_request(rq))
>  		pc = (struct ide_atapi_pc *) rq->buffer;
> -	} else if (blk_pc_request(rq)) {
> -		pc = idefloppy_next_pc_storage(drive);
> -		idefloppy_blockpc_cmd(floppy, pc, rq);
> -	} else {
> +	else {
>  		blk_dump_rq_flags(rq,
>  			"ide-floppy: unsupported command in queue");
>  		idefloppy_end_request(drive, 0, 0);

Also the above changes seem to break handling of blk_pc_request() requests
(i.e. SG_IO ioctl) because they will be no longer initialized properly.

OTOH the main change (pc->c to rq->cmd) looks OK (only minor complaint is
that 'u8' is both shorter and more readable than 'unsigned short')...

[ I had to also skip patches #16-17 because of skipping this patch. ]
