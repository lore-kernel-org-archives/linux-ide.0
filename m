From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH v2 12/13] block: remove the checking for NULL queue in blk_put_request
Date: Thu,  1 May 2008 21:28:09 +0900
Message-ID: <1209644890-12040-13-git-send-email-fujita.tomonori@lab.ntt.co.jp>
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
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo10.iij4u.or.jp ([210.138.174.78]:49428 "EHLO mo10.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754694AbYEAM3V (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 May 2008 08:29:21 -0400
In-Reply-To: <1209644890-12040-12-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jens.axboe@oracle.com, bzolnier@gmail.com, petkovbb@gmail.com, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

Some uses blk_put_request asymmetrically, that is, they uses it with
requests that not allocated by blk_get_request. As a result,
blk_put_request has a hack to catch a NULL request_queue. Now such
callers are fixed (they use blk_get_request properly). So we can
safely remove the hack in blk_put_request.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Jens Axboe <jens.axboe@oracle.com>
---
 block/blk-core.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 5d09f8c..73337ee 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1043,15 +1043,9 @@ void blk_put_request(struct request *req)
 	unsigned long flags;
 	struct request_queue *q = req->q;
 
-	/*
-	 * Gee, IDE calls in w/ NULL q.  Fix IDE and remove the
-	 * following if (q) test.
-	 */
-	if (q) {
-		spin_lock_irqsave(q->queue_lock, flags);
-		__blk_put_request(q, req);
-		spin_unlock_irqrestore(q->queue_lock, flags);
-	}
+	spin_lock_irqsave(q->queue_lock, flags);
+	__blk_put_request(q, req);
+	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 EXPORT_SYMBOL(blk_put_request);
 
-- 
1.5.4.2

