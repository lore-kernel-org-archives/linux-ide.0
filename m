From: Tejun Heo <tj@kernel.org>
Subject: [PATCH] ide: remove unnecessary blk_queue_flushing() test in do_ide_request()
Date: Thu, 19 Aug 2010 15:35:37 +0200
Message-ID: <4C6D3329.7030901@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54082 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338Ab0HSNjY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Aug 2010 09:39:24 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Christoph Hellwig <hch@lst.de>

Unplugging from a request function doesn't really help much (it's
already in the request_fn) and soon block layer will be updated to mix
barrier sequence with other commands, so there's no need to treat
queue flushing any differently.

ide was the only user of blk_queue_flushing().  Remove it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
---
David, can I route this patch through block tree with other barrier
changes?

Thanks.

 drivers/ide/ide-io.c   |   13 -------------
 include/linux/blkdev.h |    1 -
 2 files changed, 14 deletions(-)

Index: block/drivers/ide/ide-io.c
===================================================================
--- block.orig/drivers/ide/ide-io.c
+++ block/drivers/ide/ide-io.c
@@ -441,19 +441,6 @@ void do_ide_request(struct request_queue
 	struct request	*rq = NULL;
 	ide_startstop_t	startstop;

-	/*
-	 * drive is doing pre-flush, ordered write, post-flush sequence. even
-	 * though that is 3 requests, it must be seen as a single transaction.
-	 * we must not preempt this drive until that is complete
-	 */
-	if (blk_queue_flushing(q))
-		/*
-		 * small race where queue could get replugged during
-		 * the 3-request flush cycle, just yank the plug since
-		 * we want it to finish asap
-		 */
-		blk_remove_plug(q);
-
 	spin_unlock_irq(q->queue_lock);

 	/* HLD do_request() callback might sleep, make sure it's okay */
Index: block/include/linux/blkdev.h
===================================================================
--- block.orig/include/linux/blkdev.h
+++ block/include/linux/blkdev.h
@@ -520,7 +520,6 @@ enum {
 #define blk_queue_nonrot(q)	test_bit(QUEUE_FLAG_NONROT, &(q)->queue_flags)
 #define blk_queue_io_stat(q)	test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
 #define blk_queue_add_random(q)	test_bit(QUEUE_FLAG_ADD_RANDOM, &(q)->queue_flags)
-#define blk_queue_flushing(q)	((q)->ordseq)
 #define blk_queue_stackable(q)	\
 	test_bit(QUEUE_FLAG_STACKABLE, &(q)->queue_flags)
 #define blk_queue_discard(q)	test_bit(QUEUE_FLAG_DISCARD, &(q)->queue_flags)
