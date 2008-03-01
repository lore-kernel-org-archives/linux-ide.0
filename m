From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 08/24] ide-tape: remove pipeline-specific code from idetape_space_over_filemarks
Date: Sat,  1 Mar 2008 09:58:32 +0100
Message-ID: <1204361928-30229-9-git-send-email-petkovbb@gmail.com>
References: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:64772 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbYCAI7H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Mar 2008 03:59:07 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2626781nfb.21
        for <linux-ide@vger.kernel.org>; Sat, 01 Mar 2008 00:59:05 -0800 (PST)
In-Reply-To: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Also, remove idetape_wait_first_stage() too since it becomes unused.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |   65 +-----------------------------------------------
 1 files changed, 1 insertions(+), 64 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 99d6b29..d4a2e73 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -2143,19 +2143,6 @@ static void idetape_create_space_cmd(struct ide_atapi_pc *pc, int count, u8 cmd)
 	pc->idetape_callback = &idetape_pc_callback;
 }
 
-static void idetape_wait_first_stage(ide_drive_t *drive)
-{
-	idetape_tape_t *tape = drive->driver_data;
-	unsigned long flags;
-
-	if (tape->first_stage == NULL)
-		return;
-	spin_lock_irqsave(&tape->lock, flags);
-	if (tape->active_stage == tape->first_stage)
-		idetape_wait_for_request(drive, tape->active_data_rq);
-	spin_unlock_irqrestore(&tape->lock, flags);
-}
-
 /* Queue up a character device originated write request. */
 static int idetape_add_chrdev_write_request(ide_drive_t *drive, int blocks)
 {
@@ -2446,73 +2433,23 @@ static int idetape_blkdev_ioctl(ide_drive_t *drive, unsigned int cmd,
 	return 0;
 }
 
-/*
- * The function below is now a bit more complicated than just passing the
- * command to the tape since we may have crossed some filemarks during our
- * pipelined read-ahead mode. As a minor side effect, the pipeline enables us to
- * support MTFSFM when the filemark is in our internal pipeline even if the tape
- * doesn't support spacing over filemarks in the reverse direction.
- */
 static int idetape_space_over_filemarks(ide_drive_t *drive, short mt_op,
 					int mt_count)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	struct ide_atapi_pc pc;
-	unsigned long flags;
 	int retval, count = 0;
 	int sprev = !!(tape->caps[4] & 0x20);
 
 	if (mt_count == 0)
 		return 0;
+
 	if (MTBSF == mt_op || MTBSFM == mt_op) {
 		if (!sprev)
 			return -EIO;
 		mt_count = -mt_count;
 	}
 
-	if (tape->chrdev_dir == IDETAPE_DIR_READ) {
-		/* its a read-ahead buffer, scan it for crossed filemarks. */
-		tape->merge_stage_size = 0;
-		if (test_and_clear_bit(IDETAPE_FLAG_FILEMARK, &tape->flags))
-			++count;
-		while (tape->first_stage != NULL) {
-			if (count == mt_count) {
-				if (mt_op == MTFSFM)
-					set_bit(IDETAPE_FLAG_FILEMARK,
-						&tape->flags);
-				return 0;
-			}
-			spin_lock_irqsave(&tape->lock, flags);
-			if (tape->first_stage == tape->active_stage) {
-				/*
-				 * We have reached the active stage in the read
-				 * pipeline. There is no point in allowing the
-				 * drive to continue reading any farther, so we
-				 * stop the pipeline.
-				 *
-				 * This section should be moved to a separate
-				 * subroutine because similar operations are
-				 * done in __idetape_discard_read_pipeline(),
-				 * for example.
-				 */
-				tape->next_stage = NULL;
-				spin_unlock_irqrestore(&tape->lock, flags);
-				idetape_wait_first_stage(drive);
-				tape->next_stage = tape->first_stage->next;
-			} else
-				spin_unlock_irqrestore(&tape->lock, flags);
-			if (tape->first_stage->rq.errors ==
-					IDETAPE_ERROR_FILEMARK)
-				++count;
-			idetape_remove_stage_head(drive);
-		}
-		idetape_discard_read_pipeline(drive, 0);
-	}
-
-	/*
-	 * The filemark was not found in our internal pipeline;	now we can issue
-	 * the space command.
-	 */
 	switch (mt_op) {
 	case MTFSF:
 	case MTBSF:
-- 
1.5.4.1

