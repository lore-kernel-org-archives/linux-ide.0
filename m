From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/15] ide: don't set REQ_SOFTBARRIER
Date: Fri, 17 Apr 2009 18:33:11 +0900
Message-ID: <1239960802-31978-5-git-send-email-tj@kernel.org>
References: <1239960802-31978-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39978 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758141AbZDQJdj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Apr 2009 05:33:39 -0400
In-Reply-To: <1239960802-31978-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@googlemail.com, bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

ide doesn't have to worry about REQ_SOFTBARRIER.  Don't set it.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ide/ide-disk.c   |    1 -
 drivers/ide/ide-ioctls.c |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index a9fbe2c..c243880 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -411,7 +411,6 @@ static void idedisk_prepare_flush(struct request_queue *q, struct request *rq)
 	cmd->protocol = ATA_PROT_NODATA;
 
 	rq->cmd_type = REQ_TYPE_ATA_TASKFILE;
-	rq->cmd_flags |= REQ_SOFTBARRIER;
 	rq->special = cmd;
 }
 
diff --git a/drivers/ide/ide-ioctls.c b/drivers/ide/ide-ioctls.c
index c1c25eb..5991b23 100644
--- a/drivers/ide/ide-ioctls.c
+++ b/drivers/ide/ide-ioctls.c
@@ -231,7 +231,6 @@ static int generic_drive_reset(ide_drive_t *drive)
 	rq->cmd_type = REQ_TYPE_SPECIAL;
 	rq->cmd_len = 1;
 	rq->cmd[0] = REQ_DRIVE_RESET;
-	rq->cmd_flags |= REQ_SOFTBARRIER;
 	if (blk_execute_rq(drive->queue, NULL, rq, 1))
 		ret = rq->errors;
 	blk_put_request(rq);
-- 
1.6.0.2

