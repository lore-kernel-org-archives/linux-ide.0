From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 13/15] ide: use __ide_end_request() in ide_end_dequeued_request()
Date: Mon, 1 Oct 2007 23:40:34 +0200
Message-ID: <200710012340.34627.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:61479 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757237AbXJAVjv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Oct 2007 17:39:51 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1977012ugc
        for <linux-ide@vger.kernel.org>; Mon, 01 Oct 2007 14:39:50 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Remove dead code for handling IDE TCQ from ide_end_dequeued_request().

* Add 'dequeue' parameter to __ide_end_request().

* Use __ide_end_request() in ide_end_dequeued_request().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |   44 ++++++++++----------------------------------
 1 file changed, 10 insertions(+), 34 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -55,7 +55,7 @@
 #include <asm/bitops.h>
 
 static int __ide_end_request(ide_drive_t *drive, struct request *rq,
-			     int uptodate, unsigned int nr_bytes)
+			     int uptodate, unsigned int nr_bytes, int dequeue)
 {
 	int ret = 1;
 
@@ -80,9 +80,11 @@ static int __ide_end_request(ide_drive_t
 
 	if (!end_that_request_chunk(rq, uptodate, nr_bytes)) {
 		add_disk_randomness(rq->rq_disk);
-		if (!list_empty(&rq->queuelist))
-			blkdev_dequeue_request(rq);
-		HWGROUP(drive)->rq = NULL;
+		if (dequeue) {
+			if (!list_empty(&rq->queuelist))
+				blkdev_dequeue_request(rq);
+			HWGROUP(drive)->rq = NULL;
+		}
 		end_that_request_last(rq, uptodate);
 		ret = 0;
 	}
@@ -122,7 +124,7 @@ int ide_end_request (ide_drive_t *drive,
 			nr_bytes = rq->hard_cur_sectors << 9;
 	}
 
-	ret = __ide_end_request(drive, rq, uptodate, nr_bytes);
+	ret = __ide_end_request(drive, rq, uptodate, nr_bytes, 1);
 
 	spin_unlock_irqrestore(&ide_lock, flags);
 	return ret;
@@ -255,39 +257,13 @@ int ide_end_dequeued_request(ide_drive_t
 			     int uptodate, int nr_sectors)
 {
 	unsigned long flags;
-	int ret = 1;
+	int ret;
 
 	spin_lock_irqsave(&ide_lock, flags);
-
 	BUG_ON(!blk_rq_started(rq));
-
-	/*
-	 * if failfast is set on a request, override number of sectors and
-	 * complete the whole request right now
-	 */
-	if (blk_noretry_request(rq) && end_io_error(uptodate))
-		nr_sectors = rq->hard_nr_sectors;
-
-	if (!blk_fs_request(rq) && end_io_error(uptodate) && !rq->errors)
-		rq->errors = -EIO;
-
-	/*
-	 * decide whether to reenable DMA -- 3 is a random magic for now,
-	 * if we DMA timeout more than 3 times, just stay in PIO
-	 */
-	if (drive->state == DMA_PIO_RETRY && drive->retry_pio <= 3) {
-		drive->state = 0;
-		HWGROUP(drive)->hwif->ide_dma_on(drive);
-	}
-
-	if (!end_that_request_first(rq, uptodate, nr_sectors)) {
-		add_disk_randomness(rq->rq_disk);
-		if (blk_rq_tagged(rq))
-			blk_queue_end_tag(drive->queue, rq);
-		end_that_request_last(rq, uptodate);
-		ret = 0;
-	}
+	ret = __ide_end_request(drive, rq, uptodate, nr_sectors << 9, 0);
 	spin_unlock_irqrestore(&ide_lock, flags);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(ide_end_dequeued_request);
