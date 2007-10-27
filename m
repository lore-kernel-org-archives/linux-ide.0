From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 13/15] ide: switch idedisk_prepare_flush() to use REQ_TYPE_ATA_TASKFILE requests
Date: Sat, 27 Oct 2007 19:47:52 +0200
Message-ID: <200710271947.52445.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:9451 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756020AbXJ0Rqy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Oct 2007 13:46:54 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1942010mue
        for <linux-ide@vger.kernel.org>; Sat, 27 Oct 2007 10:46:53 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>


Based on the earlier work by Tejun Heo.

There should be no functionality changes caused by this patch.

Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -627,19 +627,21 @@ static ide_proc_entry_t idedisk_proc[] =
 static void idedisk_prepare_flush(struct request_queue *q, struct request *rq)
 {
 	ide_drive_t *drive = q->queuedata;
+	ide_task_t task;
 
-	memset(rq->cmd, 0, sizeof(rq->cmd));
-
+	memset(&task, 0, sizeof(task));
 	if (ide_id_has_flush_cache_ext(drive->id) &&
 	    (drive->capacity64 >= (1UL << 28)))
-		rq->cmd[0] = WIN_FLUSH_CACHE_EXT;
+		task.tf.command = WIN_FLUSH_CACHE_EXT;
 	else
-		rq->cmd[0] = WIN_FLUSH_CACHE;
-
+		task.tf.command = WIN_FLUSH_CACHE;
+	task.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	task.command_type = IDE_DRIVE_TASK_NO_DATA;
+	task.handler = task_no_data_intr;
 
-	rq->cmd_type = REQ_TYPE_ATA_TASK;
+	rq->cmd_type = REQ_TYPE_ATA_TASKFILE;
 	rq->cmd_flags |= REQ_SOFTBARRIER;
-	rq->buffer = rq->cmd;
+	rq->special = &task;
 }
 
 /*
