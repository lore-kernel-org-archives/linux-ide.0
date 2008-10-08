From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/7] ide: push ide_lock to __ide_end_request()
Date: Wed, 08 Oct 2008 22:30:10 +0200
Message-ID: <20081008203010.19112.41726.sendpatchset@localhost.localdomain>
References: <20081008202930.19112.90371.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.181]:16922 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756501AbYJHUbq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Oct 2008 16:31:46 -0400
Received: by ik-out-1112.google.com with SMTP id c30so2646846ika.5
        for <linux-ide@vger.kernel.org>; Wed, 08 Oct 2008 13:31:44 -0700 (PDT)
In-Reply-To: <20081008202930.19112.90371.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: push ide_lock to __ide_end_request()

__ide_end_request() needs ide_lock only for __blk_end_request()
call so push ide_lock taking inside __ide_end_requests().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |   28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -58,6 +58,7 @@
 static int __ide_end_request(ide_drive_t *drive, struct request *rq,
 			     int uptodate, unsigned int nr_bytes, int dequeue)
 {
+	unsigned long flags;
 	int ret = 1;
 	int error = 0;
 
@@ -84,11 +85,13 @@ static int __ide_end_request(ide_drive_t
 		ide_dma_on(drive);
 	}
 
-	if (!__blk_end_request(rq, error, nr_bytes)) {
-		if (dequeue)
-			HWGROUP(drive)->rq = NULL;
+	spin_lock_irqsave(&ide_lock, flags);
+	if (!__blk_end_request(rq, error, nr_bytes))
 		ret = 0;
-	}
+	spin_unlock_irqrestore(&ide_lock, flags);
+
+	if (ret == 0 && dequeue)
+		drive->hwif->hwgroup->rq = NULL;
 
 	return ret;
 }
@@ -108,8 +111,6 @@ int ide_end_request (ide_drive_t *drive,
 {
 	unsigned int nr_bytes = nr_sectors << 9;
 	struct request *rq = drive->hwif->hwgroup->rq;
-	unsigned long flags;
-	int ret = 1;
 
 	if (!nr_bytes) {
 		if (blk_pc_request(rq))
@@ -118,11 +119,7 @@ int ide_end_request (ide_drive_t *drive,
 			nr_bytes = rq->hard_cur_sectors << 9;
 	}
 
-	spin_lock_irqsave(&ide_lock, flags);
-	ret = __ide_end_request(drive, rq, uptodate, nr_bytes, 1);
-	spin_unlock_irqrestore(&ide_lock, flags);
-
-	return ret;
+	return __ide_end_request(drive, rq, uptodate, nr_bytes, 1);
 }
 EXPORT_SYMBOL(ide_end_request);
 
@@ -232,16 +229,9 @@ out_do_tf:
 int ide_end_dequeued_request(ide_drive_t *drive, struct request *rq,
 			     int uptodate, int nr_sectors)
 {
-	unsigned long flags;
-	int ret;
-
 	BUG_ON(!blk_rq_started(rq));
 
-	spin_lock_irqsave(&ide_lock, flags);
-	ret = __ide_end_request(drive, rq, uptodate, nr_sectors << 9, 0);
-	spin_unlock_irqrestore(&ide_lock, flags);
-
-	return ret;
+	return __ide_end_request(drive, rq, uptodate, nr_sectors << 9, 0);
 }
 EXPORT_SYMBOL_GPL(ide_end_dequeued_request);
 
