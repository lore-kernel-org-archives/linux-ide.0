From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/15] ide: execute_drive_cmd() cleanup
Date: Sat, 27 Oct 2007 19:46:19 +0200
Message-ID: <200710271946.19383.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:48557 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755858AbXJ0Rqp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Oct 2007 13:46:45 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1026724nfb
        for <linux-ide@vger.kernel.org>; Sat, 27 Oct 2007 10:46:45 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org



* Rename 'args' variable in 'if (rq->cmd_type == REQ_TYPE_ATA_TASKFILE)'
  block to 'task'.

* execute_drive_cmd() is used only for REQ_TYPE_ATA_{CMD,TASK,TASKFILE} so
  we can move the common code out from 'if (rq->cmd_type == REQ_TYPE_ATA_CMD)'
  and 'if (rq->cmd_type == REQ_TYPE_ATA_TASK)' blocks.

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |   42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -867,13 +867,15 @@ static ide_startstop_t execute_drive_cmd
 		struct request *rq)
 {
 	ide_hwif_t *hwif = HWIF(drive);
+	u8 *args = rq->buffer;
+
 	if (rq->cmd_type == REQ_TYPE_ATA_TASKFILE) {
- 		ide_task_t *args = rq->special;
+		ide_task_t *task = rq->special;
  
-		if (!args)
+		if (task == NULL)
 			goto done;
 
-		hwif->data_phase = args->data_phase;
+		hwif->data_phase = task->data_phase;
 
 		switch (hwif->data_phase) {
 		case TASKFILE_MULTI_OUT:
@@ -886,19 +888,20 @@ static ide_startstop_t execute_drive_cmd
 			break;
 		}
 
-		if (args->tf_flags & IDE_TFLAG_FLAGGED)
-			return flagged_taskfile(drive, args);
+		if (task->tf_flags & IDE_TFLAG_FLAGGED)
+			return flagged_taskfile(drive, task);
 
-		args->tf_flags |= IDE_TFLAG_OUT_TF;
+		task->tf_flags |= IDE_TFLAG_OUT_TF;
 		if (drive->addressing == 1)
-			args->tf_flags |= (IDE_TFLAG_LBA48 | IDE_TFLAG_OUT_HOB);
+			task->tf_flags |= (IDE_TFLAG_LBA48 | IDE_TFLAG_OUT_HOB);
 
-		return do_rw_taskfile(drive, args);
-	} else if (rq->cmd_type == REQ_TYPE_ATA_TASK) {
-		u8 *args = rq->buffer;
- 
-		if (!args)
-			goto done;
+		return do_rw_taskfile(drive, task);
+	}
+
+	if (args == NULL)
+		goto done;
+
+	if (rq->cmd_type == REQ_TYPE_ATA_TASK) {
 #ifdef DEBUG
  		printk("%s: DRIVE_TASK_CMD ", drive->name);
  		printk("cmd=0x%02x ", args[0]);
@@ -915,13 +918,7 @@ static ide_startstop_t execute_drive_cmd
  		hwif->OUTB(args[4], IDE_LCYL_REG);
  		hwif->OUTB(args[5], IDE_HCYL_REG);
  		hwif->OUTB((args[6] & 0xEF)|drive->select.all, IDE_SELECT_REG);
-		ide_cmd(drive, args[0], &drive_cmd_intr);
- 		return ide_started;
- 	} else if (rq->cmd_type == REQ_TYPE_ATA_CMD) {
- 		u8 *args = rq->buffer;
-
-		if (!args)
-			goto done;
+	} else { /* rq->cmd_type == REQ_TYPE_ATA_CMD */
 #ifdef DEBUG
  		printk("%s: DRIVE_CMD ", drive->name);
  		printk("cmd=0x%02x ", args[0]);
@@ -937,10 +934,11 @@ static ide_startstop_t execute_drive_cmd
 			hwif->OUTB(0xc2, IDE_HCYL_REG);
 		} else
 			hwif->OUTB(args[1], IDE_NSECTOR_REG);
-		ide_cmd(drive, args[0], &drive_cmd_intr);
- 		return ide_started;
  	}
 
+	ide_cmd(drive, args[0], &drive_cmd_intr);
+	return ide_started;
+
 done:
  	/*
  	 * NULL is actually a valid way of waiting for
