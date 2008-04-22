From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH 02/11] ide-floppy: use blk_get_request in the ide_do_drive_cmd path
Date: Tue, 22 Apr 2008 09:26:33 +0900
Message-ID: <1208824002-3596-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1208824002-3596-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo11.iij4u.or.jp ([210.138.174.79]:43205 "EHLO mo11.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759190AbYDVA2A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Apr 2008 20:28:00 -0400
In-Reply-To: <1208824002-3596-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

This replaces struct request on the stack with blk_get_request in the
ide_do_drive_cmd path that uses ide_wait.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-floppy.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 5f133df..d75b2aa 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -885,14 +885,14 @@ static ide_startstop_t idefloppy_do_request(ide_drive_t *drive,
 static int idefloppy_queue_pc_tail(ide_drive_t *drive, struct ide_atapi_pc *pc)
 {
 	struct ide_floppy_obj *floppy = drive->driver_data;
-	struct request rq;
+	struct request *rq;
 
-	ide_init_drive_cmd(&rq);
-	rq.buffer = (char *) pc;
-	rq.cmd_type = REQ_TYPE_SPECIAL;
-	rq.rq_disk = floppy->disk;
+	rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
+	rq->buffer = (char *) pc;
+	rq->cmd_type = REQ_TYPE_SPECIAL;
+	rq->rq_disk = floppy->disk;
 
-	return ide_do_drive_cmd(drive, &rq, ide_wait);
+	return ide_do_drive_cmd(drive, rq, ide_wait);
 }
 
 /*
-- 
1.5.4.2

