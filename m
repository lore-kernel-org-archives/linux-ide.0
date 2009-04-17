From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 09/15] ide-atapi: don't abuse rq->buffer
Date: Fri, 17 Apr 2009 18:33:16 +0900
Message-ID: <1239960802-31978-10-git-send-email-tj@kernel.org>
References: <1239960802-31978-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39989 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759983AbZDQJdq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Apr 2009 05:33:46 -0400
In-Reply-To: <1239960802-31978-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@googlemail.com, bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

Impact: rq->buffer usage cleanup

ide-atapi uses rq->buffer as private opaque value for internal special
requests.  rq->special isn't used for these cases (the only case where
rq->special is used is for ide-tape rw requests).  Use rq->special
instead.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
---
 drivers/ide/ide-atapi.c  |    4 ++--
 drivers/ide/ide-floppy.c |    2 +-
 drivers/ide/ide-tape.c   |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 7201b17..2894577 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -90,7 +90,7 @@ static void ide_queue_pc_head(ide_drive_t *drive, struct gendisk *disk,
 	blk_rq_init(NULL, rq);
 	rq->cmd_type = REQ_TYPE_SPECIAL;
 	rq->cmd_flags |= REQ_PREEMPT;
-	rq->buffer = (char *)pc;
+	rq->special = (char *)pc;
 	rq->rq_disk = disk;
 
 	if (pc->req_xfer) {
@@ -119,7 +119,7 @@ int ide_queue_pc_tail(ide_drive_t *drive, struct gendisk *disk,
 
 	rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
 	rq->cmd_type = REQ_TYPE_SPECIAL;
-	rq->buffer = (char *)pc;
+	rq->special = (char *)pc;
 
 	if (pc->req_xfer) {
 		rq->data = pc->buf;
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 3b22e06..9460033 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -264,7 +264,7 @@ static ide_startstop_t ide_floppy_do_request(ide_drive_t *drive,
 		pc = &floppy->queued_pc;
 		idefloppy_create_rw_cmd(drive, pc, rq, (unsigned long)block);
 	} else if (blk_special_request(rq)) {
-		pc = (struct ide_atapi_pc *) rq->buffer;
+		pc = (struct ide_atapi_pc *)rq->special;
 	} else if (blk_pc_request(rq)) {
 		pc = &floppy->queued_pc;
 		idefloppy_blockpc_cmd(floppy, pc, rq);
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 3a53e08..aadf53c 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -828,7 +828,7 @@ static ide_startstop_t idetape_do_request(ide_drive_t *drive,
 		goto out;
 	}
 	if (rq->cmd[13] & REQ_IDETAPE_PC1) {
-		pc = (struct ide_atapi_pc *) rq->buffer;
+		pc = (struct ide_atapi_pc *)rq->special;
 		rq->cmd[13] &= ~(REQ_IDETAPE_PC1);
 		rq->cmd[13] |= REQ_IDETAPE_PC2;
 		goto out;
-- 
1.6.0.2

