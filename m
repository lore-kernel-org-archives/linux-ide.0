From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH v2 06/13] ide-tape: convert ide_do_drive_cmd path to use blk_execute_rq
Date: Thu,  1 May 2008 21:28:03 +0900
Message-ID: <1209644890-12040-7-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1209644890-12040-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-5-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-6-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo11.iij4u.or.jp ([210.138.174.79]:42689 "EHLO mo11.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754658AbYEAM3S (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 May 2008 08:29:18 -0400
In-Reply-To: <1209644890-12040-6-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jens.axboe@oracle.com, bzolnier@gmail.com, petkovbb@gmail.com, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

This converts the ide_do_drive_cmd path using ide_wait to use
blk_execute_rq.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Borislav Petkov <petkovbb@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-tape.c |   41 ++++++++++++++++++++++++++---------------
 1 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 1e1f263..30b29dd 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1518,12 +1518,16 @@ static void idetape_create_test_unit_ready_cmd(struct ide_atapi_pc *pc)
 static int idetape_queue_pc_tail(ide_drive_t *drive, struct ide_atapi_pc *pc)
 {
 	struct ide_tape_obj *tape = drive->driver_data;
-	struct request rq;
+	struct request *rq;
+	int error;
 
-	idetape_init_rq(&rq, REQ_IDETAPE_PC1);
-	rq.buffer = (char *) pc;
-	rq.rq_disk = tape->disk;
-	return ide_do_drive_cmd(drive, &rq, ide_wait);
+	rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
+	rq->cmd_type = REQ_TYPE_SPECIAL;
+	rq->cmd[0] = REQ_IDETAPE_PC1;
+	rq->buffer = (char *)pc;
+	error = blk_execute_rq(drive->queue, tape->disk, rq, 0);
+	blk_put_request(rq);
+	return error;
 }
 
 static void idetape_create_load_unload_cmd(ide_drive_t *drive,
@@ -1700,26 +1704,33 @@ static int idetape_queue_rw_tail(ide_drive_t *drive, int cmd, int blocks,
 				 struct idetape_bh *bh)
 {
 	idetape_tape_t *tape = drive->driver_data;
-	struct request rq;
+	struct request *rq;
+	int ret, errors;
 
 	debug_log(DBG_SENSE, "%s: cmd=%d\n", __func__, cmd);
 
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
+	blk_execute_rq(drive->queue, tape->disk, rq, 0);
+
+	errors = rq->errors;
+	ret = tape->blk_size * (blocks - rq->current_nr_sectors);
+	blk_put_request(rq);
 
 	if ((cmd & (REQ_IDETAPE_READ | REQ_IDETAPE_WRITE)) == 0)
 		return 0;
 
 	if (tape->merge_bh)
 		idetape_init_merge_buffer(tape);
-	if (rq.errors == IDETAPE_ERROR_GENERAL)
+	if (errors == IDETAPE_ERROR_GENERAL)
 		return -EIO;
-	return (tape->blk_size * (blocks-rq.current_nr_sectors));
+	return ret;
 }
 
 static void idetape_create_inquiry_cmd(struct ide_atapi_pc *pc)
-- 
1.5.4.2

