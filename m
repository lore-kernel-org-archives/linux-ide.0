From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH 11/11] block: remove the checking for NULL queue in blk_put_request
Date: Tue, 22 Apr 2008 09:26:42 +0900
Message-ID: <1208824002-3596-12-git-send-email-fujita.tomonori@lab.ntt.co.jp>
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
 <1208824002-3596-11-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo11.iij4u.or.jp ([210.138.174.79]:43243 "EHLO mo11.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759289AbYDVA2M (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Apr 2008 20:28:12 -0400
In-Reply-To: <1208824002-3596-11-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Jens Axboe <jens.axboe@oracle.com>

Some calls blk_put_request with struct request on the stack. As a
result, blk_put_request has a hack to catch a NULL request_queue. Now
such callers are fixed (they use blk_get_request properly). So we can
safely remove the hack in blk_put_request.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Jens Axboe <jens.axboe@oracle.com>
---
 block/blk-core.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 2a438a9..62f9b12 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1050,15 +1050,9 @@ void blk_put_request(struct request *req)
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

