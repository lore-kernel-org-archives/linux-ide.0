From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [git patch] atang tree: fix 2.6.32 SSD performance regression
Date: Mon, 22 Feb 2010 22:24:35 +0100
Message-ID: <201002222224.35860.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f219.google.com ([209.85.220.219]:59593 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753618Ab0BVV12 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Feb 2010 16:27:28 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Benjamin S." <sbenni@gmx.de>, Jens Axboe <jens.axboe@oracle.com>

DISCLAIMER: the fact of getting patches merged into atang tree means
that from now on they will be getting updates for changes happening
in atang tree and it should not be treated as an indication regarding
decisions taken by 'upstream' kernel trees


Fix 2.6.32 regression bringing back the desired SSD performance.

[ 'upstream' may want to wait for a proper resolution, for atang tree
  performance of big non-ATA boxes owned by a very few people is not
  of such a big concern as a major regression on a commodity hardware ]


The following changes since commit ded92e0d01fbb7f27bec7a35606847a2547e95e0:
  Bartlomiej Zolnierkiewicz (1):
        libata: enhanced SSD detection

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bart/misc.git atang-v4.8

Bartlomiej Zolnierkiewicz (1):
      block: fix SSD performance regression

 block/blk-core.c       |   11 ++---------
 include/linux/blkdev.h |    2 --
 2 files changed, 2 insertions(+), 11 deletions(-)

commit cad2f21db052f21beafd44d3396a565d9a485073
Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date:   Mon Feb 22 22:19:14 2010 +0100

    block: fix SSD performance regression
    
    Revert "block: improve queue_should_plug() by looking at IO depths".
    
    This reverts commit fb1e75389bd06fd5987e9cda1b4e0305c782f854 which was
    reported to negatively affect performance for SSD devices in 2.6.32:
    
    	http://article.gmane.org/gmane.linux.ide/45053
    
    "Without that patch my SSD (Super Talent Ultradrive GX MLC 64GB)
     reaches about 200MB/s sequentiell read. After applying the patch it
     reaches only 70MB/s."
    
    Reported-by: "Benjamin S." <sbenni@gmx.de>
    Cc: Jens Axboe <jens.axboe@oracle.com>
    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff --git a/block/blk-core.c b/block/blk-core.c
index 71da511..f8f01f2 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1147,7 +1147,7 @@ void init_request_from_bio(struct request *req, struct bio *bio)
  */
 static inline bool queue_should_plug(struct request_queue *q)
 {
-	return !(blk_queue_nonrot(q) && blk_queue_queuing(q));
+	return !(blk_queue_nonrot(q) && blk_queue_tagged(q));
 }
 
 static int __make_request(struct request_queue *q, struct bio *bio)
@@ -1859,15 +1859,8 @@ void blk_dequeue_request(struct request *rq)
 	 * and to it is freed is accounted as io that is in progress at
 	 * the driver side.
 	 */
-	if (blk_account_rq(rq)) {
+	if (blk_account_rq(rq))
 		q->in_flight[rq_is_sync(rq)]++;
-		/*
-		 * Mark this device as supporting hardware queuing, if
-		 * we have more IOs in flight than 4.
-		 */
-		if (!blk_queue_queuing(q) && queue_in_flight(q) > 4)
-			set_bit(QUEUE_FLAG_CQ, &q->queue_flags);
-	}
 }
 
 /**
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 221cecd..7db4f99 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -457,7 +457,6 @@ struct request_queue
 #define QUEUE_FLAG_NONROT      14	/* non-rotational device (SSD) */
 #define QUEUE_FLAG_VIRT        QUEUE_FLAG_NONROT /* paravirt device */
 #define QUEUE_FLAG_IO_STAT     15	/* do IO stats */
-#define QUEUE_FLAG_CQ	       16	/* hardware does queuing */
 #define QUEUE_FLAG_DISCARD     17	/* supports DISCARD */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
@@ -582,7 +581,6 @@ enum {
 
 #define blk_queue_plugged(q)	test_bit(QUEUE_FLAG_PLUGGED, &(q)->queue_flags)
 #define blk_queue_tagged(q)	test_bit(QUEUE_FLAG_QUEUED, &(q)->queue_flags)
-#define blk_queue_queuing(q)	test_bit(QUEUE_FLAG_CQ, &(q)->queue_flags)
 #define blk_queue_stopped(q)	test_bit(QUEUE_FLAG_STOPPED, &(q)->queue_flags)
 #define blk_queue_nomerges(q)	test_bit(QUEUE_FLAG_NOMERGES, &(q)->queue_flags)
 #define blk_queue_nonrot(q)	test_bit(QUEUE_FLAG_NONROT, &(q)->queue_flags)
