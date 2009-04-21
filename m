From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #ide-phase2] ide-dma: don't reset request fields on dma_timeout_retry()
Date: Tue, 21 Apr 2009 12:23:16 +0900
Message-ID: <49ED3C24.4010709@kernel.org>
References: <1240099122-18381-1-git-send-email-tj@kernel.org> <200904201357.44507.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51590 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750931AbZDUDW2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Apr 2009 23:22:28 -0400
In-Reply-To: <200904201357.44507.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: petkovbb@googlemail.com, axboe@kernel.dk, linux-ide@vger.kernel.org

Impact: drop unnecessary code

Now that everything uses bio and block operations, there is no need to
reset request fields manually when retrying a request.  Every field is
guaranteed to be always valid.  Drop unnecessary request field
resetting from ide_dma_timeout_retry().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
This patch applies on top of this patchset.  I updated the #ide-phase2
git branch to include this patch.  Thanks.

 drivers/ide/ide-dma.c |   20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

Index: block/drivers/ide/ide-dma.c
===================================================================
--- block.orig/drivers/ide/ide-dma.c
+++ block/drivers/ide/ide-dma.c
@@ -510,23 +510,11 @@ ide_startstop_t ide_dma_timeout_retry(id
 	/*
 	 * un-busy drive etc and make sure request is sane
 	 */
-
 	rq = hwif->rq;
-	if (!rq)
-		goto out;
-
-	hwif->rq = NULL;
-
-	rq->errors = 0;
-
-	if (!rq->bio)
-		goto out;
-
-	rq->sector = rq->bio->bi_sector;
-	rq->current_nr_sectors = bio_iovec(rq->bio)->bv_len >> 9;
-	rq->hard_cur_sectors = rq->current_nr_sectors;
-	rq->buffer = bio_data(rq->bio);
-out:
+	if (rq) {
+		hwif->rq = NULL;
+		rq->errors = 0;
+	}
 	return ret;
 }
 
