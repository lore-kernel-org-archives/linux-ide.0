From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 05/17] ide-tape: remove pipeline-specific code in idetape_space_over_filemarks()
Date: Mon, 17 Mar 2008 07:41:18 +0100
Message-ID: <1205736090-4435-6-git-send-email-petkovbb@gmail.com>
References: <1205736090-4435-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.234]:30085 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718AbYCQGlg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Mar 2008 02:41:36 -0400
Received: by hu-out-0506.google.com with SMTP id 19so3301579hue.21
        for <linux-ide@vger.kernel.org>; Sun, 16 Mar 2008 23:41:36 -0700 (PDT)
In-Reply-To: <1205736090-4435-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Since we don't do pipeline read-ahead anymore, we don't have to look for
filemarks we have crossed. Therefore, remove the code chunk that does that and
pass on the command to the tape. As a side effect, remove unused
idetape_wait_first_stage().

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |   52 ------------------------------------------------
 1 files changed, 0 insertions(+), 52 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index d4a94d5..3b324bb 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1983,19 +1983,6 @@ static void idetape_create_space_cmd(struct ide_atapi_pc *pc, int count, u8 cmd)
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
@@ -2221,19 +2208,11 @@ static int idetape_blkdev_ioctl(ide_drive_t *drive, unsigned int cmd,
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
 
@@ -2246,42 +2225,11 @@ static int idetape_space_over_filemarks(ide_drive_t *drive, short mt_op,
 	}
 
 	if (tape->chrdev_dir == IDETAPE_DIR_READ) {
-		/* its a read-ahead buffer, scan it for crossed filemarks. */
 		tape->merge_stage_size = 0;
 		if (test_and_clear_bit(IDETAPE_FLAG_FILEMARK, &tape->flags))
 			++count;
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
 	}
 
-	/*
-	 * The filemark was not found in our internal pipeline;	now we can issue
-	 * the space command.
-	 */
 	switch (mt_op) {
 	case MTFSF:
 	case MTBSF:
-- 
1.5.4.1

