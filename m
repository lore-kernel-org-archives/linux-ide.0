From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 12/24] ide-tape: remove idetape_empty_write_pipeline
Date: Sat,  1 Mar 2008 09:58:36 +0100
Message-ID: <1204361928-30229-13-git-send-email-petkovbb@gmail.com>
References: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:12899 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753856AbYCAI7O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Mar 2008 03:59:14 -0500
Received: by fk-out-0910.google.com with SMTP id z23so6043882fkz.5
        for <linux-ide@vger.kernel.org>; Sat, 01 Mar 2008 00:59:13 -0800 (PST)
In-Reply-To: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |   75 ------------------------------------------------
 1 files changed, 0 insertions(+), 75 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 0ebb745..3e80515 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -2173,80 +2173,6 @@ static void idetape_wait_for_pipeline(ide_drive_t *drive)
 	}
 }
 
-static void idetape_empty_write_pipeline(ide_drive_t *drive)
-{
-	idetape_tape_t *tape = drive->driver_data;
-	int blocks, min;
-	struct idetape_bh *bh;
-
-	if (tape->chrdev_dir != IDETAPE_DIR_WRITE) {
-		printk(KERN_ERR "ide-tape: bug: Trying to empty write pipeline,"
-				" but we are not writing.\n");
-		return;
-	}
-	if (tape->merge_stage_size > tape->stage_size) {
-		printk(KERN_ERR "ide-tape: bug: merge_buffer too big\n");
-		tape->merge_stage_size = tape->stage_size;
-	}
-	if (tape->merge_stage_size) {
-		blocks = tape->merge_stage_size / tape->blk_size;
-		if (tape->merge_stage_size % tape->blk_size) {
-			unsigned int i;
-
-			blocks++;
-			i = tape->blk_size - tape->merge_stage_size %
-				tape->blk_size;
-			bh = tape->bh->b_reqnext;
-			while (bh) {
-				atomic_set(&bh->b_count, 0);
-				bh = bh->b_reqnext;
-			}
-			bh = tape->bh;
-			while (i) {
-				if (bh == NULL) {
-					printk(KERN_INFO "ide-tape: bug,"
-							 " bh NULL\n");
-					break;
-				}
-				min = min(i, (unsigned int)(bh->b_size -
-						atomic_read(&bh->b_count)));
-				memset(bh->b_data + atomic_read(&bh->b_count),
-						0, min);
-				atomic_add(min, &bh->b_count);
-				i -= min;
-				bh = bh->b_reqnext;
-			}
-		}
-		(void) idetape_add_chrdev_write_request(drive, blocks);
-		tape->merge_stage_size = 0;
-	}
-	idetape_wait_for_pipeline(drive);
-	if (tape->merge_stage != NULL) {
-		__idetape_kfree_stage(tape->merge_stage);
-		tape->merge_stage = NULL;
-	}
-	clear_bit(IDETAPE_FLAG_PIPELINE_ERR, &tape->flags);
-	tape->chrdev_dir = IDETAPE_DIR_NONE;
-
-	/*
-	 * On the next backup, perform the feedback loop again. (I don't want to
-	 * keep sense information between backups, as some systems are
-	 * constantly on, and the system load can be totally different on the
-	 * next backup).
-	 */
-	tape->max_stages = tape->min_pipeline;
-	if (tape->first_stage != NULL ||
-	    tape->next_stage != NULL ||
-	    tape->last_stage != NULL ||
-	    tape->nr_stages != 0) {
-		printk(KERN_ERR "ide-tape: ide-tape pipeline bug, "
-			"first_stage %p, next_stage %p, "
-			"last_stage %p, nr_stages %d\n",
-			tape->first_stage, tape->next_stage,
-			tape->last_stage, tape->nr_stages);
-	}
-}
-
 static void idetape_restart_speed_control(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
@@ -2923,7 +2849,6 @@ static void idetape_write_release(ide_drive_t *drive, unsigned int minor)
 {
 	idetape_tape_t *tape = drive->driver_data;
 
-	idetape_empty_write_pipeline(drive);
 	tape->merge_stage = __idetape_kmalloc_stage(tape, 1, 0);
 	if (tape->merge_stage != NULL) {
 		idetape_pad_zeros(drive, tape->blk_size *
-- 
1.5.4.1

