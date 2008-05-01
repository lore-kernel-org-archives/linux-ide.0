From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH v2 04/13] ide-floppy: convert ide_do_drive_cmd path to use blk_execute_rq
Date: Thu,  1 May 2008 21:28:01 +0900
Message-ID: <1209644890-12040-5-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1209644890-12040-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo11.iij4u.or.jp ([210.138.174.79]:42685 "EHLO mo11.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753639AbYEAM3R (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 May 2008 08:29:17 -0400
In-Reply-To: <1209644890-12040-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
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
 drivers/ide/ide-floppy.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index f05fbc2..6bd0021 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -886,14 +886,16 @@ static ide_startstop_t idefloppy_do_request(ide_drive_t *drive,
 static int idefloppy_queue_pc_tail(ide_drive_t *drive, struct ide_atapi_pc *pc)
 {
 	struct ide_floppy_obj *floppy = drive->driver_data;
-	struct request rq;
+	struct request *rq;
+	int error;
 
-	ide_init_drive_cmd(&rq);
-	rq.buffer = (char *) pc;
-	rq.cmd_type = REQ_TYPE_SPECIAL;
-	rq.rq_disk = floppy->disk;
+	rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
+	rq->buffer = (char *) pc;
+	rq->cmd_type = REQ_TYPE_SPECIAL;
+	error = blk_execute_rq(drive->queue, floppy->disk, rq, 0);
+	blk_put_request(rq);
 
-	return ide_do_drive_cmd(drive, &rq, ide_wait);
+	return error;
 }
 
 /*
-- 
1.5.4.2

