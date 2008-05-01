From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH v2 13/13] block: unexport blk_end_sync_rq
Date: Thu,  1 May 2008 21:28:10 +0900
Message-ID: <1209644890-12040-14-git-send-email-fujita.tomonori@lab.ntt.co.jp>
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
 <1209644890-12040-12-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-13-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo11.iij4u.or.jp ([210.138.174.79]:42696 "EHLO mo11.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753639AbYEAM3V (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 May 2008 08:29:21 -0400
In-Reply-To: <1209644890-12040-13-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jens.axboe@oracle.com, bzolnier@gmail.com, petkovbb@gmail.com, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

All the users of blk_end_sync_rq has gone (they are converted to use
blk_execute_rq). This unexports blk_end_sync_rq.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Jens Axboe <jens.axboe@oracle.com>
---
 block/blk-exec.c       |    3 +--
 include/linux/blkdev.h |    1 -
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/block/blk-exec.c b/block/blk-exec.c
index 391dd62..f7213a3 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -18,7 +18,7 @@
  * @rq: request to complete
  * @error: end io status of the request
  */
-void blk_end_sync_rq(struct request *rq, int error)
+static void blk_end_sync_rq(struct request *rq, int error)
 {
 	struct completion *waiting = rq->end_io_data;
 
@@ -31,7 +31,6 @@ void blk_end_sync_rq(struct request *rq, int error)
 	 */
 	complete(waiting);
 }
-EXPORT_SYMBOL(blk_end_sync_rq);
 
 /**
  * blk_execute_rq_nowait - insert a request into queue for execution
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d2a1b71..1171abd 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -623,7 +623,6 @@ extern void generic_make_request(struct bio *bio);
 extern void blk_rq_init(struct request_queue *q, struct request *rq);
 extern void blk_put_request(struct request *);
 extern void __blk_put_request(struct request_queue *, struct request *);
-extern void blk_end_sync_rq(struct request *rq, int error);
 extern struct request *blk_get_request(struct request_queue *, int, gfp_t);
 extern void blk_insert_request(struct request_queue *, struct request *, int, void *);
 extern void blk_requeue_request(struct request_queue *, struct request *);
-- 
1.5.4.2

