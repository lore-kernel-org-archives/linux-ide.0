From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/15] block: clear req->errors on bio completion only for fs requests
Date: Fri, 17 Apr 2009 18:33:08 +0900
Message-ID: <1239960802-31978-2-git-send-email-tj@kernel.org>
References: <1239960802-31978-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39972 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754271AbZDQJdj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Apr 2009 05:33:39 -0400
In-Reply-To: <1239960802-31978-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@googlemail.com, bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

Impact: subtle behavior change

For fs requests, rq is only carrier of bios and rq error status as a
whole doesn't mean much.  This is the reason why rq->errors is being
cleared on each partial completion of a request as on each partial
completion the error status is transferred to the respective bios.

For pc requests, rq->errors is used to carry error status to the
issuer and thus __end_that_request_first() doesn't clear it on such
cases.

The condition was fine till now as only fs and pc requests have used
bio and thus the bio completion path.  However, future changes will
unify data accesses to bio and all non fs users care about rq error
status.  Clear rq->errors on bio completion only for fs requests.

In general, the implicit clearing is a bit too subtle especially as
the meaning of rq->errors is completely dependent on low level
drivers.  Unifying / cleaning up rq->errors usage and letting llds
manage it would be better.  TODO comment added.

Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 07ab754..cce7a88 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1739,10 +1739,14 @@ static int __end_that_request_first(struct request *req, int error,
 	trace_block_rq_complete(req->q, req);
 
 	/*
-	 * for a REQ_TYPE_BLOCK_PC request, we want to carry any eventual
-	 * sense key with us all the way through
+	 * For fs requests, rq is just carrier of independent bio's
+	 * and each partial completion should be handled separately.
+	 * Reset per-request error on each partial completion.
+	 *
+	 * TODO: tj: This is too subtle.  It would be better to let
+	 * low level drivers do what they see fit.
 	 */
-	if (!blk_pc_request(req))
+	if (blk_fs_request(req))
 		req->errors = 0;
 
 	if (error && (blk_fs_request(req) && !(req->cmd_flags & REQ_QUIET))) {
-- 
1.6.0.2

