From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 02/24] ide-tape: remove pipeline-specific code from idetape_add_chrdev_write_request
Date: Sat,  1 Mar 2008 09:58:26 +0100
Message-ID: <1204361928-30229-3-git-send-email-petkovbb@gmail.com>
References: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:64804 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbYCAI7H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Mar 2008 03:59:07 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2626779nfb.21
        for <linux-ide@vger.kernel.org>; Sat, 01 Mar 2008 00:59:05 -0800 (PST)
In-Reply-To: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Instead of plugging the request into the pipeline, queue it straight on the
device's request queue through idetape_queue_rw_tail().

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |   81 ++---------------------------------------------
 1 files changed, 4 insertions(+), 77 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 792c76e..abf3efa 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -2123,12 +2123,6 @@ static int idetape_queue_rw_tail(ide_drive_t *drive, int cmd, int blocks,
 
 	debug_log(DBG_SENSE, "%s: cmd=%d\n", __func__, cmd);
 
-	if (test_bit(IDETAPE_FLAG_PIPELINE_ACTIVE, &tape->flags)) {
-		printk(KERN_ERR "ide-tape: bug: the pipeline is active in %s\n",
-				__func__);
-		return (0);
-	}
-
 	idetape_init_rq(&rq, cmd);
 	rq.rq_disk = tape->disk;
 	rq.special = (void *)bh;
@@ -2140,10 +2134,9 @@ static int idetape_queue_rw_tail(ide_drive_t *drive, int cmd, int blocks,
 	if ((cmd & (REQ_IDETAPE_READ | REQ_IDETAPE_WRITE)) == 0)
 		return 0;
 
-	if (tape->merge_stage)
-		idetape_init_merge_stage(tape);
 	if (rq.errors == IDETAPE_ERROR_GENERAL)
 		return -EIO;
+
 	return (tape->blk_size * (blocks-rq.current_nr_sectors));
 }
 
@@ -2210,81 +2203,15 @@ static void idetape_wait_first_stage(ide_drive_t *drive)
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
-	unsigned long flags;
-	struct request *rq;
 
 	debug_log(DBG_CHRDEV, "Enter %s\n", __func__);
 
-	/* Attempt to allocate a new stage. Beware possible race conditions. */
-	while ((new_stage = idetape_kmalloc_stage(tape)) == NULL) {
-		spin_lock_irqsave(&tape->lock, flags);
-		if (test_bit(IDETAPE_FLAG_PIPELINE_ACTIVE, &tape->flags)) {
-			idetape_wait_for_request(drive, tape->active_data_rq);
-			spin_unlock_irqrestore(&tape->lock, flags);
-		} else {
-			spin_unlock_irqrestore(&tape->lock, flags);
-			idetape_plug_pipeline(drive);
-			if (test_bit(IDETAPE_FLAG_PIPELINE_ACTIVE,
-					&tape->flags))
-				continue;
-			/*
-			 * The machine is short on memory. Fallback to non-
-			 * pipelined operation mode for this request.
-			 */
-			return idetape_queue_rw_tail(drive, REQ_IDETAPE_WRITE,
-						blocks, tape->merge_stage->bh);
-		}
-	}
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
+	return idetape_queue_rw_tail(drive, REQ_IDETAPE_WRITE, blocks,
+					tape->merge_stage->bh);
 }
 
 /*
-- 
1.5.4.1

