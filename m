From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH 04/11] ide-disk: use blk_get_request in the ide_do_drive_cmd path
Date: Tue, 22 Apr 2008 09:26:35 +0900
Message-ID: <1208824002-3596-5-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1208824002-3596-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo11.iij4u.or.jp ([210.138.174.79]:43213 "EHLO mo11.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759237AbYDVA2B (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Apr 2008 20:28:01 -0400
In-Reply-To: <1208824002-3596-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

This replaces struct request on the stack with blk_get_request in the
ide_do_drive_cmd path that uses ide_wait.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index 39501d1..497273a 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -617,7 +617,7 @@ static void idedisk_prepare_flush(struct request_queue *q, struct request *rq)
  */
 static int set_multcount(ide_drive_t *drive, int arg)
 {
-	struct request rq;
+	struct request *rq;
 
 	if (arg < 0 || arg > drive->id->max_multsect)
 		return -EINVAL;
@@ -625,12 +625,12 @@ static int set_multcount(ide_drive_t *drive, int arg)
 	if (drive->special.b.set_multmode)
 		return -EBUSY;
 
-	ide_init_drive_cmd (&rq);
-	rq.cmd_type = REQ_TYPE_ATA_TASKFILE;
+	rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
+	rq->cmd_type = REQ_TYPE_ATA_TASKFILE;
 
 	drive->mult_req = arg;
 	drive->special.b.set_multmode = 1;
-	(void) ide_do_drive_cmd (drive, &rq, ide_wait);
+	ide_do_drive_cmd(drive, rq, ide_wait);
 	return (drive->mult_count == arg) ? 0 : -EIO;
 }
 
-- 
1.5.4.2

