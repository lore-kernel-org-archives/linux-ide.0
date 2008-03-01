From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 03/24] ide-tape: remove pipeline-specific code from idetape_add_chrdev_read_request
Date: Sat,  1 Mar 2008 09:58:27 +0100
Message-ID: <1204361928-30229-4-git-send-email-petkovbb@gmail.com>
References: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:13335 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709AbYCAI7O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Mar 2008 03:59:14 -0500
Received: by fk-out-0910.google.com with SMTP id z23so6043881fkz.5
        for <linux-ide@vger.kernel.org>; Sat, 01 Mar 2008 00:59:13 -0800 (PST)
In-Reply-To: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

We fall back to non-pipelined operation through idetape_queue_rw_tail with cmd
set to REQ_IDETAPE_READ. Also, remove idetape_switch_buffers() since it becomes
unused.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |   46 +---------------------------------------------
 1 files changed, 1 insertions(+), 45 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index abf3efa..e919d41 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1776,16 +1776,6 @@ static void idetape_init_merge_stage(idetape_tape_t *tape)
 	}
 }
 
-static void idetape_switch_buffers(idetape_tape_t *tape, idetape_stage_t *stage)
-{
-	struct idetape_bh *tmp;
-
-	tmp = stage->bh;
-	stage->bh = tape->merge_stage->bh;
-	tape->merge_stage->bh = tmp;
-	idetape_init_merge_stage(tape);
-}
-
 /* Add a new stage at the end of the pipeline. */
 static void idetape_add_stage_tail(ide_drive_t *drive, idetape_stage_t *stage)
 {
@@ -2403,9 +2393,6 @@ static int idetape_init_read(ide_drive_t *drive, int max_stages)
 static int idetape_add_chrdev_read_request(ide_drive_t *drive, int blocks)
 {
 	idetape_tape_t *tape = drive->driver_data;
-	unsigned long flags;
-	struct request *rq_ptr;
-	int bytes_read;
 
 	debug_log(DBG_PROCS, "Enter %s, %d blocks\n", __func__, blocks);
 
@@ -2413,39 +2400,8 @@ static int idetape_add_chrdev_read_request(ide_drive_t *drive, int blocks)
 	if (test_bit(IDETAPE_FLAG_FILEMARK, &tape->flags))
 		return 0;
 
-	/* Wait for the next block to reach the head of the pipeline. */
-	idetape_init_read(drive, tape->max_stages);
-	if (tape->first_stage == NULL) {
-		if (test_bit(IDETAPE_FLAG_PIPELINE_ERR, &tape->flags))
-			return 0;
-		return idetape_queue_rw_tail(drive, REQ_IDETAPE_READ, blocks,
+	return idetape_queue_rw_tail(drive, REQ_IDETAPE_READ, blocks,
 					tape->merge_stage->bh);
-	}
-	idetape_wait_first_stage(drive);
-	rq_ptr = &tape->first_stage->rq;
-	bytes_read = tape->blk_size * (rq_ptr->nr_sectors -
-					rq_ptr->current_nr_sectors);
-	rq_ptr->nr_sectors = 0;
-	rq_ptr->current_nr_sectors = 0;
-
-	if (rq_ptr->errors == IDETAPE_ERROR_EOD)
-		return 0;
-	else {
-		idetape_switch_buffers(tape, tape->first_stage);
-		if (rq_ptr->errors == IDETAPE_ERROR_FILEMARK)
-			set_bit(IDETAPE_FLAG_FILEMARK, &tape->flags);
-		spin_lock_irqsave(&tape->lock, flags);
-		idetape_remove_stage_head(drive);
-		spin_unlock_irqrestore(&tape->lock, flags);
-		tape->pipeline_head++;
-		idetape_calculate_speeds(drive);
-	}
-	if (bytes_read > blocks * tape->blk_size) {
-		printk(KERN_ERR "ide-tape: bug: trying to return more bytes"
-				" than requested\n");
-		bytes_read = blocks * tape->blk_size;
-	}
-	return (bytes_read);
 }
 
 static void idetape_pad_zeros(ide_drive_t *drive, int bcount)
-- 
1.5.4.1

