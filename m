From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH v2 11/13] block: convert pd_special_command to use blk_execute_rq
Date: Thu,  1 May 2008 21:28:08 +0900
Message-ID: <1209644890-12040-12-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1209644890-12040-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-5-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-6-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-7-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-8-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-9-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-10-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-11-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo10.iij4u.or.jp ([210.138.174.78]:49424 "EHLO mo10.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754793AbYEAM3T (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 May 2008 08:29:19 -0400
In-Reply-To: <1209644890-12040-11-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jens.axboe@oracle.com, bzolnier@gmail.com, petkovbb@gmail.com, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

pd_special_command uses blk_put_request with struct request on the
stack. As a result, blk_put_request needs a hack to catch a NULL
request_queue.  This converts pd_special_command to use
blk_execute_rq.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Jens Axboe <jens.axboe@oracle.com>
---
 drivers/block/paride/pd.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index 570f3b7..5fdfa7c 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -712,19 +712,17 @@ static void do_pd_request(struct request_queue * q)
 static int pd_special_command(struct pd_unit *disk,
 		      enum action (*func)(struct pd_unit *disk))
 {
-	DECLARE_COMPLETION_ONSTACK(wait);
-	struct request rq;
+	struct request *rq;
 	int err = 0;
 
-	blk_rq_init(NULL, &rq);
-	rq.rq_disk = disk->gd;
-	rq.end_io_data = &wait;
-	rq.end_io = blk_end_sync_rq;
-	blk_insert_request(disk->gd->queue, &rq, 0, func);
-	wait_for_completion(&wait);
-	if (rq.errors)
-		err = -EIO;
-	blk_put_request(&rq);
+	rq = blk_get_request(disk->gd->queue, READ, __GFP_WAIT);
+
+	rq->cmd_type = REQ_TYPE_SPECIAL;
+	rq->special = func;
+
+	err = blk_execute_rq(disk->gd->queue, disk->gd, rq, 0);
+
+	blk_put_request(rq);
 	return err;
 }
 
-- 
1.5.4.2

