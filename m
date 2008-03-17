From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 06/17] ide-tape: remove idetape_pipeline_size()
Date: Mon, 17 Mar 2008 07:41:19 +0100
Message-ID: <1205736090-4435-7-git-send-email-petkovbb@gmail.com>
References: <1205736090-4435-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.232]:29797 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbYCQGlg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Mar 2008 02:41:36 -0400
Received: by hu-out-0506.google.com with SMTP id 19so3301577hue.21
        for <linux-ide@vger.kernel.org>; Sun, 16 Mar 2008 23:41:36 -0700 (PDT)
In-Reply-To: <1205736090-4435-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

The computation of the block offset of the the tape position (MTIOCPOS,
MTIOCGET) is not influenced by the stages queued in the pipeline anymore but by
the size of the current buffer which is going to be sent to the drive.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |   23 +----------------------
 1 files changed, 1 insertions(+), 22 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 3b324bb..5a6b657 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -2128,27 +2128,6 @@ static void idetape_pad_zeros(ide_drive_t *drive, int bcount)
 	}
 }
 
-static int idetape_pipeline_size(ide_drive_t *drive)
-{
-	idetape_tape_t *tape = drive->driver_data;
-	idetape_stage_t *stage;
-	struct request *rq;
-	int size = 0;
-
-	idetape_wait_for_pipeline(drive);
-	stage = tape->first_stage;
-	while (stage != NULL) {
-		rq = &stage->rq;
-		size += tape->blk_size * (rq->nr_sectors -
-				rq->current_nr_sectors);
-		if (rq->errors == IDETAPE_ERROR_FILEMARK)
-			size += tape->blk_size;
-		stage = stage->next;
-	}
-	size += tape->merge_stage_size;
-	return size;
-}
-
 /*
  * Rewinds the tape to the Beginning Of the current Partition (BOP). We
  * currently support only one partition.
@@ -2580,7 +2559,7 @@ static int idetape_chrdev_ioctl(struct inode *inode, struct file *file,
 		idetape_flush_tape_buffers(drive);
 	}
 	if (cmd == MTIOCGET || cmd == MTIOCPOS) {
-		block_offset = idetape_pipeline_size(drive) /
+		block_offset = tape->merge_stage_size /
 			(tape->blk_size * tape->user_bs_factor);
 		position = idetape_read_position(drive);
 		if (position < 0)
-- 
1.5.4.1

