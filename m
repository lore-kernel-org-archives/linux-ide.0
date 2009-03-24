From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 11/14] ide-cd: don't abuse rq->buffer
Date: Wed, 25 Mar 2009 01:06:13 +0900
Message-ID: <1237910776-10983-12-git-send-email-tj@kernel.org>
References: <1237910776-10983-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41838 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762212AbZCXQGk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Mar 2009 12:06:40 -0400
In-Reply-To: <1237910776-10983-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, linux-kernel@vger.kernel.org, axboe@kernel.dk, linux-ide@vger.kernel.org
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
index b3736b4..de6ce8d 100644
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

