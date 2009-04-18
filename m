From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 10/10] ide: drop rq->data handling from ide_map_sg()
Date: Sun, 19 Apr 2009 08:58:42 +0900
Message-ID: <1240099122-18381-11-git-send-email-tj@kernel.org>
References: <1240099122-18381-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57783 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754320AbZDRX7A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 18 Apr 2009 19:59:00 -0400
In-Reply-To: <1240099122-18381-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@googlemail.com, bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

Impact: remove code path which is no longer necessary

All IDE data transfers now use rq->bio.  Simplify ide_map_sg()
accordingly.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
---
 drivers/ide/ide-io.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 6e3094e..a0309ea 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -248,11 +248,7 @@ void ide_map_sg(ide_drive_t *drive, struct ide_cmd *cmd)
 	struct scatterlist *sg = hwif->sg_table;
 	struct request *rq = cmd->rq;
 
-	if (!rq->bio) {
-		sg_init_one(sg, rq->data, rq->data_len);
-		cmd->sg_nents = 1;
-	} else
-		cmd->sg_nents = blk_rq_map_sg(drive->queue, rq, sg);
+	cmd->sg_nents = blk_rq_map_sg(drive->queue, rq, sg);
 }
 EXPORT_SYMBOL_GPL(ide_map_sg);
 
-- 
1.6.0.2

