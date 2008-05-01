From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH v2 03/13] ide-disk: convert ide_do_drive_cmd path to use blk_execute_rq
Date: Thu,  1 May 2008 21:28:00 +0900
Message-ID: <1209644890-12040-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1209644890-12040-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo11.iij4u.or.jp ([210.138.174.79]:42764 "EHLO mo11.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752115AbYEAM36 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 May 2008 08:29:58 -0400
In-Reply-To: <1209644890-12040-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
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
 drivers/ide/ide-disk.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index 8e08d08..c5f22ef 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -617,7 +617,8 @@ static void idedisk_prepare_flush(struct request_queue *q, struct request *rq)
  */
 static int set_multcount(ide_drive_t *drive, int arg)
 {
-	struct request rq;
+	struct request *rq;
+	int error;
 
 	if (arg < 0 || arg > drive->id->max_multsect)
 		return -EINVAL;
@@ -625,12 +626,13 @@ static int set_multcount(ide_drive_t *drive, int arg)
 	if (drive->special.b.set_multmode)
 		return -EBUSY;
 
-	ide_init_drive_cmd(&rq);
-	rq.cmd_type = REQ_TYPE_ATA_TASKFILE;
+	rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
+	rq->cmd_type = REQ_TYPE_ATA_TASKFILE;
 
 	drive->mult_req = arg;
 	drive->special.b.set_multmode = 1;
-	(void)ide_do_drive_cmd(drive, &rq, ide_wait);
+	error = blk_execute_rq(drive->queue, NULL, rq, 0);
+	blk_put_request(rq);
 
 	return (drive->mult_count == arg) ? 0 : -EIO;
 }
-- 
1.5.4.2

