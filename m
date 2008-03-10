From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/4] ide-tape: remove pipeline-specific code from idetape_add_chrdev_write_request
Date: Tue, 11 Mar 2008 00:25:19 +0100
Message-ID: <200803110025.19650.bzolnier@gmail.com>
References: <1205082632-3418-1-git-send-email-petkovbb@gmail.com> <1205082632-3418-3-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:55390 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754025AbYCJXNB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Mar 2008 19:13:01 -0400
Received: by fg-out-1718.google.com with SMTP id e21so2142917fga.17
        for <linux-ide@vger.kernel.org>; Mon, 10 Mar 2008 16:13:00 -0700 (PDT)
In-Reply-To: <1205082632-3418-3-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Sunday 09 March 2008, Borislav Petkov wrote:
> Refrain from adding more write requests to the pipeline and queue them
> directly on the device's request queue instead. Prior to that flush all
> penging stages in the pipeline through idetape_wait_for_pipeline().

I would prefer to keep the original code for now
(it has some subtle differences).

> The remaining pipeline stage allocation code is used for the next current
> pipeline stage (tape->merge_stage) and data buffer for an upcoming
> request. The so allocated pipeline stage is rewired into the tape struct
> thru idetape_switch_buffers() and used during the next request for
> copying user data into it (see e.g. idetape_chrdev_write()). In case the
> allocation fails, the current request is still attempted prior to failing.

Is this really needed now that we've removed pipeline operation for write
requests?

> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

How's about this version?

From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 2/4] ide-tape: remove pipeline-specific code from idetape_add_chrdev_write_request

Refrain from adding more write requests to the pipeline and queue them
directly on the device's request queue instead.

[bart: re-do for minimal behavior changes]

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-tape.c |   55 +------------------------------------------------
 1 file changed, 2 insertions(+), 53 deletions(-)

Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -2202,28 +2202,16 @@ static void idetape_wait_first_stage(ide
 	spin_unlock_irqrestore(&tape->lock, flags);
 }
 
-/*
- * Try to add a character device originated write request to our pipeline. In
- * case we don't succeed, we revert to non-pipelined operation mode for this
- * request. In order to accomplish that, we
- *
- * 1. Try to allocate a new pipeline stage.
- * 2. If we can't, wait for more and more requests to be serviced and try again
- * each time.
- * 3. If we still can't allocate a stage, fallback to non-pipelined operation
- * mode for this request.
- */
+/* Queue up a character device originated write request. */
 static int idetape_add_chrdev_write_request(ide_drive_t *drive, int blocks)
 {
 	idetape_tape_t *tape = drive->driver_data;
-	idetape_stage_t *new_stage;
 	unsigned long flags;
-	struct request *rq;
 
 	debug_log(DBG_CHRDEV, "Enter %s\n", __func__);
 
 	/* Attempt to allocate a new stage. Beware possible race conditions. */
-	while ((new_stage = idetape_kmalloc_stage(tape)) == NULL) {
+	while (1) {
 		spin_lock_irqsave(&tape->lock, flags);
 		if (test_bit(IDETAPE_FLAG_PIPELINE_ACTIVE, &tape->flags)) {
 			idetape_wait_for_request(drive, tape->active_data_rq);
@@ -2234,49 +2222,10 @@ static int idetape_add_chrdev_write_requ
 			if (test_bit(IDETAPE_FLAG_PIPELINE_ACTIVE,
 					&tape->flags))
 				continue;
-			/*
-			 * The machine is short on memory. Fallback to non-
-			 * pipelined operation mode for this request.
-			 */
 			return idetape_queue_rw_tail(drive, REQ_IDETAPE_WRITE,
 						blocks, tape->merge_stage->bh);
 		}
 	}
-	rq = &new_stage->rq;
-	idetape_init_rq(rq, REQ_IDETAPE_WRITE);
-	/* Doesn't actually matter - We always assume sequential access */
-	rq->sector = tape->first_frame;
-	rq->current_nr_sectors = blocks;
-	rq->nr_sectors = blocks;
-
-	idetape_switch_buffers(tape, new_stage);
-	idetape_add_stage_tail(drive, new_stage);
-	tape->pipeline_head++;
-	idetape_calculate_speeds(drive);
-
-	/*
-	 * Estimate whether the tape has stopped writing by checking if our
-	 * write pipeline is currently empty. If we are not writing anymore,
-	 * wait for the pipeline to be almost completely full (90%) before
-	 * starting to service requests, so that we will be able to keep up with
-	 * the higher speeds of the tape.
-	 */
-	if (!test_bit(IDETAPE_FLAG_PIPELINE_ACTIVE, &tape->flags)) {
-		if (tape->nr_stages >= tape->max_stages * 9 / 10 ||
-			tape->nr_stages >= tape->max_stages -
-			tape->uncontrolled_pipeline_head_speed * 3 * 1024 /
-			tape->blk_size) {
-			tape->measure_insert_time = 1;
-			tape->insert_time = jiffies;
-			tape->insert_size = 0;
-			tape->insert_speed = 0;
-			idetape_plug_pipeline(drive);
-		}
-	}
-	if (test_and_clear_bit(IDETAPE_FLAG_PIPELINE_ERR, &tape->flags))
-		/* Return a deferred error */
-		return -EIO;
-	return blocks;
 }
 
 /*
