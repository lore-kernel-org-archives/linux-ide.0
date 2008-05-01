From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH v2 05/13] ide-taskfile: convert ide_do_drive_cmd path to use blk_execute_rq
Date: Thu,  1 May 2008 21:28:02 +0900
Message-ID: <1209644890-12040-6-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1209644890-12040-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-5-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo11.iij4u.or.jp ([210.138.174.79]:42684 "EHLO mo11.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753182AbYEAM3R (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 May 2008 08:29:17 -0400
In-Reply-To: <1209644890-12040-5-git-send-email-fujita.tomonori@lab.ntt.co.jp>
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
 drivers/ide/ide-taskfile.c |   34 ++++++++++++++++++++--------------
 1 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index 0c908ca..43e23ff 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -492,11 +492,12 @@ static ide_startstop_t pre_task_out_intr(ide_drive_t *drive, struct request *rq)
 
 int ide_raw_taskfile(ide_drive_t *drive, ide_task_t *task, u8 *buf, u16 nsect)
 {
-	struct request rq;
+	struct request *rq;
+	int error;
 
-	blk_rq_init(NULL, &rq);
-	rq.cmd_type = REQ_TYPE_ATA_TASKFILE;
-	rq.buffer = buf;
+	rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
+	rq->cmd_type = REQ_TYPE_ATA_TASKFILE;
+	rq->buffer = buf;
 
 	/*
 	 * (ks) We transfer currently only whole sectors.
@@ -504,16 +505,19 @@ int ide_raw_taskfile(ide_drive_t *drive, ide_task_t *task, u8 *buf, u16 nsect)
 	 * if we would find a solution to transfer any size.
 	 * To support special commands like READ LONG.
 	 */
-	rq.hard_nr_sectors = rq.nr_sectors = nsect;
-	rq.hard_cur_sectors = rq.current_nr_sectors = nsect;
+	rq->hard_nr_sectors = rq->nr_sectors = nsect;
+	rq->hard_cur_sectors = rq->current_nr_sectors = nsect;
 
 	if (task->tf_flags & IDE_TFLAG_WRITE)
-		rq.cmd_flags |= REQ_RW;
+		rq->cmd_flags |= REQ_RW;
 
-	rq.special = task;
-	task->rq = &rq;
+	rq->special = task;
+	task->rq = rq;
 
-	return ide_do_drive_cmd(drive, &rq, ide_wait);
+	error = blk_execute_rq(drive->queue, NULL, rq, 0);
+	blk_put_request(rq);
+
+	return error;
 }
 
 EXPORT_SYMBOL(ide_raw_taskfile);
@@ -739,12 +743,14 @@ int ide_cmd_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned long arg)
 	struct hd_driveid *id = drive->id;
 
 	if (NULL == (void *) arg) {
-		struct request rq;
+		struct request *rq;
 
-		ide_init_drive_cmd(&rq);
-		rq.cmd_type = REQ_TYPE_ATA_TASKFILE;
+		rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
+		rq->cmd_type = REQ_TYPE_ATA_TASKFILE;
+		err = blk_execute_rq(drive->queue, NULL, rq, 0);
+		blk_put_request(rq);
 
-		return ide_do_drive_cmd(drive, &rq, ide_wait);
+		return err;
 	}
 
 	if (copy_from_user(args, (void __user *)arg, 4))
-- 
1.5.4.2

