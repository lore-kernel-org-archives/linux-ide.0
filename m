From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH 03/11] ide-taskfile: use blk_get_request in the ide_do_drive_cmd path
Date: Tue, 22 Apr 2008 09:26:34 +0900
Message-ID: <1208824002-3596-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1208824002-3596-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo11.iij4u.or.jp ([210.138.174.79]:43208 "EHLO mo11.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759187AbYDVA2A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Apr 2008 20:28:00 -0400
In-Reply-To: <1208824002-3596-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

This replaces struct request on the stack with blk_get_request in the
ide_do_drive_cmd path that uses ide_wait.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-taskfile.c |   29 ++++++++++++++---------------
 1 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index 155cc90..fac7fad 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -530,12 +530,11 @@ static ide_startstop_t pre_task_out_intr(ide_drive_t *drive, struct request *rq)
 
 int ide_raw_taskfile(ide_drive_t *drive, ide_task_t *task, u8 *buf, u16 nsect)
 {
-	struct request rq;
+	struct request *rq;
 
-	memset(&rq, 0, sizeof(rq));
-	rq.ref_count = 1;
-	rq.cmd_type = REQ_TYPE_ATA_TASKFILE;
-	rq.buffer = buf;
+	rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
+	rq->cmd_type = REQ_TYPE_ATA_TASKFILE;
+	rq->buffer = buf;
 
 	/*
 	 * (ks) We transfer currently only whole sectors.
@@ -543,16 +542,16 @@ int ide_raw_taskfile(ide_drive_t *drive, ide_task_t *task, u8 *buf, u16 nsect)
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
+	return ide_do_drive_cmd(drive, rq, ide_wait);
 }
 
 EXPORT_SYMBOL(ide_raw_taskfile);
@@ -778,12 +777,12 @@ int ide_cmd_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned long arg)
 	struct hd_driveid *id = drive->id;
 
 	if (NULL == (void *) arg) {
-		struct request rq;
+		struct request *rq;
 
-		ide_init_drive_cmd(&rq);
-		rq.cmd_type = REQ_TYPE_ATA_TASKFILE;
+		rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
+		rq->cmd_type = REQ_TYPE_ATA_TASKFILE;
 
-		return ide_do_drive_cmd(drive, &rq, ide_wait);
+		return ide_do_drive_cmd(drive, rq, ide_wait);
 	}
 
 	if (copy_from_user(args, (void __user *)arg, 4))
-- 
1.5.4.2

