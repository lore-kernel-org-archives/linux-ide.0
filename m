From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH 07/11] ide-tape: use blk_get_request in the ide_do_drive_cmd path
Date: Tue, 22 Apr 2008 09:26:38 +0900
Message-ID: <1208824002-3596-8-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1208824002-3596-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-5-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-6-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-7-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo11.iij4u.or.jp ([210.138.174.79]:43218 "EHLO mo11.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759247AbYDVA2B (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Apr 2008 20:28:01 -0400
In-Reply-To: <1208824002-3596-7-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

This replaces struct request on the stack with blk_get_request in the
ide_do_drive_cmd path that uses ide_wait.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-tape.c |   35 ++++++++++++++++++++---------------
 1 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 02851b3..04c611e 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1910,13 +1910,15 @@ static void idetape_create_test_unit_ready_cmd(struct ide_atapi_pc *pc)
 static int __idetape_queue_pc_tail(ide_drive_t *drive, struct ide_atapi_pc *pc)
 {
 	struct ide_tape_obj *tape = drive->driver_data;
-	struct request rq;
+	struct request *rq;
 	int ret;
 
-	idetape_init_rq(&rq, REQ_IDETAPE_PC1);
-	rq.buffer = (char *) pc;
-	rq.rq_disk = tape->disk;
-	ret = ide_do_drive_cmd(drive, &rq, ide_wait);
+	rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
+	rq->cmd_type = REQ_TYPE_SPECIAL;
+	rq->cmd[0] = REQ_IDETAPE_PC1;
+	rq->buffer = (char *)pc;
+	rq->rq_disk = tape->disk;
+	ret = ide_do_drive_cmd(drive, rq, ide_wait);
 	return ret ? -EIO : 0;
 
 }
@@ -2130,7 +2132,8 @@ static int idetape_queue_rw_tail(ide_drive_t *drive, int cmd, int blocks,
 				 struct idetape_bh *bh)
 {
 	idetape_tape_t *tape = drive->driver_data;
-	struct request rq;
+	struct request *rq;
+	int ret;
 
 	debug_log(DBG_SENSE, "%s: cmd=%d\n", __func__, cmd);
 
@@ -2140,22 +2143,24 @@ static int idetape_queue_rw_tail(ide_drive_t *drive, int cmd, int blocks,
 		return (0);
 	}
 
-	idetape_init_rq(&rq, cmd);
-	rq.rq_disk = tape->disk;
-	rq.special = (void *)bh;
-	rq.sector = tape->first_frame;
-	rq.nr_sectors		= blocks;
-	rq.current_nr_sectors	= blocks;
-	(void) ide_do_drive_cmd(drive, &rq, ide_wait);
+	rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
+	rq->cmd_type = REQ_TYPE_SPECIAL;
+	rq->cmd[0] = cmd;
+	rq->rq_disk = tape->disk;
+	rq->special = (void *)bh;
+	rq->sector = tape->first_frame;
+	rq->nr_sectors = blocks;
+	rq->current_nr_sectors = blocks;
+	ret = ide_do_drive_cmd(drive, rq, ide_wait);
 
 	if ((cmd & (REQ_IDETAPE_READ | REQ_IDETAPE_WRITE)) == 0)
 		return 0;
 
 	if (tape->merge_stage)
 		idetape_init_merge_stage(tape);
-	if (rq.errors == IDETAPE_ERROR_GENERAL)
+	if (ret == IDETAPE_ERROR_GENERAL)
 		return -EIO;
-	return (tape->blk_size * (blocks-rq.current_nr_sectors));
+	return (tape->blk_size * (blocks-rq->current_nr_sectors));
 }
 
 /* start servicing the pipeline stages, starting from tape->next_stage. */
-- 
1.5.4.2

