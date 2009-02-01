From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 11/15] ide: factor out completion of taskfile from ide_end_drive_cmd()
Date: Sun, 01 Feb 2009 18:50:26 +0100
Message-ID: <20090201175026.19144.95484.sendpatchset@localhost.localdomain>
References: <20090201174909.19144.67767.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:6833 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754035AbZBARtd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Feb 2009 12:49:33 -0500
In-Reply-To: <20090201174909.19144.67767.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: factor out completion of taskfile from ide_end_drive_cmd()

Factor out completion of taskfile from ide_end_drive_cmd()
to ide_complete_task().

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |   27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -144,6 +144,20 @@ int ide_end_dequeued_request(ide_drive_t
 }
 EXPORT_SYMBOL_GPL(ide_end_dequeued_request);
 
+static void ide_complete_task(ide_drive_t *drive, ide_task_t *task,
+			      u8 stat, u8 err)
+{
+	struct ide_taskfile *tf = &task->tf;
+
+	tf->error = err;
+	tf->status = stat;
+
+	drive->hwif->tp_ops->tf_read(drive, task);
+
+	if (task->tf_flags & IDE_TFLAG_DYN)
+		kfree(task);
+}
+
 /**
  *	ide_end_drive_cmd	-	end an explicit drive command
  *	@drive: command 
@@ -166,17 +180,8 @@ void ide_end_drive_cmd (ide_drive_t *dri
 	if (rq->cmd_type == REQ_TYPE_ATA_TASKFILE) {
 		ide_task_t *task = (ide_task_t *)rq->special;
 
-		if (task) {
-			struct ide_taskfile *tf = &task->tf;
-
-			tf->error = err;
-			tf->status = stat;
-
-			drive->hwif->tp_ops->tf_read(drive, task);
-
-			if (task->tf_flags & IDE_TFLAG_DYN)
-				kfree(task);
-		}
+		if (task)
+			ide_complete_task(drive, task, stat, err);
 	} else if (blk_pm_request(rq)) {
 		ide_complete_pm_rq(drive, rq);
 		return;
