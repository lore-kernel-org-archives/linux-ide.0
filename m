From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH 10/11] block: convert pd to use blk_get_request
Date: Tue, 22 Apr 2008 09:26:41 +0900
Message-ID: <1208824002-3596-11-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1208824002-3596-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-5-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-6-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-7-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-8-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-9-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-10-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo11.iij4u.or.jp ([210.138.174.79]:43241 "EHLO mo11.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759221AbYDVA2L (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Apr 2008 20:28:11 -0400
In-Reply-To: <1208824002-3596-10-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Jens Axboe <jens.axboe@oracle.com>

pd.c uses blk_put_request with struct request on the stack. As a
result, blk_put_request needs a hack to catch a NULL request_queue.
This converts pd.c to use blk_get_request.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Jens Axboe <jens.axboe@oracle.com>
---
 drivers/block/paride/pd.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index df819f8..e52babb 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -713,20 +713,19 @@ static int pd_special_command(struct pd_unit *disk,
 		      enum action (*func)(struct pd_unit *disk))
 {
 	DECLARE_COMPLETION_ONSTACK(wait);
-	struct request rq;
+	struct request *rq;
 	int err = 0;
 
-	memset(&rq, 0, sizeof(rq));
-	rq.errors = 0;
-	rq.rq_disk = disk->gd;
-	rq.ref_count = 1;
-	rq.end_io_data = &wait;
-	rq.end_io = blk_end_sync_rq;
-	blk_insert_request(disk->gd->queue, &rq, 0, func);
+	rq = blk_get_request(disk->gd->queue, READ, __GFP_WAIT);
+	rq->ref_count++;
+	rq->rq_disk = disk->gd;
+	rq->end_io_data = &wait;
+	rq->end_io = blk_end_sync_rq;
+	blk_insert_request(disk->gd->queue, rq, 0, func);
 	wait_for_completion(&wait);
-	if (rq.errors)
+	if (rq->errors)
 		err = -EIO;
-	blk_put_request(&rq);
+	blk_put_request(rq);
 	return err;
 }
 
-- 
1.5.4.2

