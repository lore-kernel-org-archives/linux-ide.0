From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH v2 08/13] ide: remove ide_wait/head_wait path in ide_do_drive_cmd
Date: Thu,  1 May 2008 21:28:05 +0900
Message-ID: <1209644890-12040-9-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1209644890-12040-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-5-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-6-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-7-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-8-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo10.iij4u.or.jp ([210.138.174.78]:49420 "EHLO mo10.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754505AbYEAM3T (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 May 2008 08:29:19 -0400
In-Reply-To: <1209644890-12040-8-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jens.axboe@oracle.com, bzolnier@gmail.com, petkovbb@gmail.com, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

Now all the users of ide_do_drive_cmd using ide_wait/head_wait are
converted to use blk_execute_rq This removes the ide_wait/head_wait
path in ide_do_drive_cmd.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Borislav Petkov <petkovbb@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |   27 +++------------------------
 1 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 6965253..fae7c70 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1584,26 +1584,14 @@ int ide_do_drive_cmd (ide_drive_t *drive, struct request *rq, ide_action_t actio
 {
 	unsigned long flags;
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
-	DECLARE_COMPLETION_ONSTACK(wait);
-	int where = ELEVATOR_INSERT_BACK, err;
-	int must_wait = (action == ide_wait || action == ide_head_wait);
+	int where = ELEVATOR_INSERT_BACK;
 
 	rq->errors = 0;
 
-	/*
-	 * we need to hold an extra reference to request for safe inspection
-	 * after completion
-	 */
-	if (must_wait) {
-		rq->ref_count++;
-		rq->end_io_data = &wait;
-		rq->end_io = blk_end_sync_rq;
-	}
-
 	spin_lock_irqsave(&ide_lock, flags);
 	if (action == ide_preempt)
 		hwgroup->rq = NULL;
-	if (action == ide_preempt || action == ide_head_wait) {
+	if (action == ide_preempt) {
 		where = ELEVATOR_INSERT_FRONT;
 		rq->cmd_flags |= REQ_PREEMPT;
 	}
@@ -1611,16 +1599,7 @@ int ide_do_drive_cmd (ide_drive_t *drive, struct request *rq, ide_action_t actio
 	ide_do_request(hwgroup, IDE_NO_IRQ);
 	spin_unlock_irqrestore(&ide_lock, flags);
 
-	err = 0;
-	if (must_wait) {
-		wait_for_completion(&wait);
-		if (rq->errors)
-			err = -EIO;
-
-		blk_put_request(rq);
-	}
-
-	return err;
+	return 0;
 }
 
 EXPORT_SYMBOL(ide_do_drive_cmd);
-- 
1.5.4.2

