From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/9] ide: factor out processing of special commands from ide_special_rq()
Date: Thu, 15 Jan 2009 21:01:15 +0100
Message-ID: <20090115200115.17294.71947.sendpatchset@localhost.localdomain>
References: <20090115200032.17294.84745.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f17.google.com ([209.85.219.17]:56109 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761594AbZAOUBB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Jan 2009 15:01:01 -0500
In-Reply-To: <20090115200032.17294.84745.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: factor out processing of special commands from ide_special_rq()

Factor out processing of special commands from ide_special_rq()
to ide_do_devset() and ide_do_park_unpark().

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |   75 +++++++++++++++++++++++++++------------------------
 1 file changed, 41 insertions(+), 34 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -511,46 +511,53 @@ int ide_devset_execute(ide_drive_t *driv
 	return ret;
 }
 
+static ide_startstop_t ide_do_devset(ide_drive_t *drive, struct request *rq)
+{
+	int err, (*setfunc)(ide_drive_t *, int) = rq->special;
+
+	err = setfunc(drive, *(int *)&rq->cmd[1]);
+	if (err)
+		rq->errors = err;
+	else
+		err = 1;
+	ide_end_request(drive, err, 0);
+	return ide_stopped;
+}
+
+static ide_startstop_t ide_do_park_unpark(ide_drive_t *drive, struct request *rq)
+{
+	ide_task_t task;
+	struct ide_taskfile *tf = &task.tf;
+
+	memset(&task, 0, sizeof(task));
+	if (rq->cmd[0] == REQ_PARK_HEADS) {
+		drive->sleep = *(unsigned long *)rq->special;
+		drive->dev_flags |= IDE_DFLAG_SLEEPING;
+		tf->command = ATA_CMD_IDLEIMMEDIATE;
+		tf->feature = 0x44;
+		tf->lbal = 0x4c;
+		tf->lbam = 0x4e;
+		tf->lbah = 0x55;
+		task.tf_flags |= IDE_TFLAG_CUSTOM_HANDLER;
+	} else		/* cmd == REQ_UNPARK_HEADS */
+		tf->command = ATA_CMD_CHK_POWER;
+
+	task.tf_flags |= IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
+	task.rq = rq;
+	drive->hwif->data_phase = task.data_phase = TASKFILE_NO_DATA;
+	return do_rw_taskfile(drive, &task);
+}
+
 static ide_startstop_t ide_special_rq(ide_drive_t *drive, struct request *rq)
 {
 	u8 cmd = rq->cmd[0];
 
-	if (cmd == REQ_PARK_HEADS || cmd == REQ_UNPARK_HEADS) {
-		ide_task_t task;
-		struct ide_taskfile *tf = &task.tf;
-
-		memset(&task, 0, sizeof(task));
-		if (cmd == REQ_PARK_HEADS) {
-			drive->sleep = *(unsigned long *)rq->special;
-			drive->dev_flags |= IDE_DFLAG_SLEEPING;
-			tf->command = ATA_CMD_IDLEIMMEDIATE;
-			tf->feature = 0x44;
-			tf->lbal = 0x4c;
-			tf->lbam = 0x4e;
-			tf->lbah = 0x55;
-			task.tf_flags |= IDE_TFLAG_CUSTOM_HANDLER;
-		} else		/* cmd == REQ_UNPARK_HEADS */
-			tf->command = ATA_CMD_CHK_POWER;
-
-		task.tf_flags |= IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
-		task.rq = rq;
-		drive->hwif->data_phase = task.data_phase = TASKFILE_NO_DATA;
-		return do_rw_taskfile(drive, &task);
-	}
-
 	switch (cmd) {
+	case REQ_PARK_HEADS:
+	case REQ_UNPARK_HEADS:
+		return ide_do_park_unpark(drive, rq);
 	case REQ_DEVSET_EXEC:
-	{
-		int err, (*setfunc)(ide_drive_t *, int) = rq->special;
-
-		err = setfunc(drive, *(int *)&rq->cmd[1]);
-		if (err)
-			rq->errors = err;
-		else
-			err = 1;
-		ide_end_request(drive, err, 0);
-		return ide_stopped;
-	}
+		return ide_do_devset(drive, rq);
 	case REQ_DRIVE_RESET:
 		return ide_do_reset(drive);
 	default:
