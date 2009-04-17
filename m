From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 10/15] ide-cd: don't abuse rq->buffer
Date: Fri, 17 Apr 2009 18:33:17 +0900
Message-ID: <1239960802-31978-11-git-send-email-tj@kernel.org>
References: <1239960802-31978-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39987 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759415AbZDQJdq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Apr 2009 05:33:46 -0400
In-Reply-To: <1239960802-31978-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@googlemail.com, bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

Impact: rq->buffer usage cleanup

ide-cd uses rq->buffer to carry pointer to the original request when
issuing REQUEST_SENSE.  Use rq->special instead.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
---
 drivers/ide/ide-cd.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 509f129..eb3c299 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -232,8 +232,8 @@ static void cdrom_queue_request_sense(ide_drive_t *drive, void *sense,
 	rq->cmd_type = REQ_TYPE_SENSE;
 	rq->cmd_flags |= REQ_PREEMPT;
 
-	/* NOTE! Save the failed command in "rq->buffer" */
-	rq->buffer = (void *) failed_command;
+	/* NOTE! Save the failed command in "rq->special" */
+	rq->special = (void *)failed_command;
 
 	if (failed_command)
 		ide_debug_log(IDE_DBG_SENSE, "failed_cmd: 0x%x",
@@ -247,10 +247,10 @@ static void cdrom_queue_request_sense(ide_drive_t *drive, void *sense,
 static void ide_cd_complete_failed_rq(ide_drive_t *drive, struct request *rq)
 {
 	/*
-	 * For REQ_TYPE_SENSE, "rq->buffer" points to the original
+	 * For REQ_TYPE_SENSE, "rq->special" points to the original
 	 * failed request
 	 */
-	struct request *failed = (struct request *)rq->buffer;
+	struct request *failed = (struct request *)rq->special;
 	struct cdrom_info *info = drive->driver_data;
 	void *sense = &info->sense_data;
 
-- 
1.6.0.2

