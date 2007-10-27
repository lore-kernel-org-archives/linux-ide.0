From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 9/15] ide: use ide_tf_load() in execute_drive_cmd()
Date: Sat, 27 Oct 2007 19:46:30 +0200
Message-ID: <200710271946.30546.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:48608 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755514AbXJ0Rqs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Oct 2007 13:46:48 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1026731nfb
        for <linux-ide@vger.kernel.org>; Sat, 27 Oct 2007 10:46:47 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Add IDE_TFLAG_OUT_DEVICE taskfile flag to indicate the need of writing
  the Device register and handle it in ide_tf_load().

  Update ide_tf_load() and {do_rw,flagged}_taskfile() users accordingly.

* Use struct ide_taskfile and ide_tf_load() in execute_drive_cmd().

* Make the debugging code dump all taskfile registers for both
  REQ_ATA_TYPE_{CMD,TASK} requests and move it to ide_tf_load()
  so it also covers REQ_ATA_TYPE_TASKFILE requests.

There should be no functionality changes caused by this patch
(unless DEBUG is defined).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c     |    2 -
 drivers/ide/ide-io.c       |   60 ++++++++++++++++++---------------------------
 drivers/ide/ide-taskfile.c |   10 ++++++-
 include/linux/ide.h        |    1 
 4 files changed, 36 insertions(+), 37 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -185,7 +185,7 @@ static ide_startstop_t __ide_do_rw_disk(
 
 	memset(&task, 0, sizeof(task));
 	task.tf_flags = IDE_TFLAG_NO_SELECT_MASK;  /* FIXME? */
-	task.tf_flags |= IDE_TFLAG_OUT_TF;
+	task.tf_flags |= (IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE);
 
 	if (drive->select.b.lba) {
 		if (lba48) {
Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -232,7 +232,7 @@ static ide_startstop_t ide_start_power_s
 	return ide_stopped;
 
 out_do_tf:
-	args->tf_flags = IDE_TFLAG_OUT_TF;
+	args->tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
 	if (drive->addressing == 1)
 		args->tf_flags |= (IDE_TFLAG_LBA48 | IDE_TFLAG_OUT_HOB);
 	args->command_type = IDE_DRIVE_TASK_NO_DATA;
@@ -710,7 +710,7 @@ static ide_startstop_t ide_disk_special(
 		return ide_stopped;
 	}
 
-	args.tf_flags = IDE_TFLAG_OUT_TF;
+	args.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
 	if (drive->addressing == 1)
 		args.tf_flags |= (IDE_TFLAG_LBA48 | IDE_TFLAG_OUT_HOB);
 
@@ -849,6 +849,8 @@ static ide_startstop_t execute_drive_cmd
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	u8 *args = rq->buffer;
+	ide_task_t ltask;
+	struct ide_taskfile *tf = &ltask.tf;
 
 	if (rq->cmd_type == REQ_TYPE_ATA_TASKFILE) {
 		ide_task_t *task = rq->special;
@@ -869,6 +871,8 @@ static ide_startstop_t execute_drive_cmd
 			break;
 		}
 
+		task->tf_flags |= IDE_TFLAG_OUT_DEVICE;
+
 		if (task->tf_flags & IDE_TFLAG_FLAGGED)
 			return flagged_taskfile(drive, task);
 
@@ -882,46 +886,32 @@ static ide_startstop_t execute_drive_cmd
 	if (args == NULL)
 		goto done;
 
-	if (IDE_CONTROL_REG)
-		hwif->OUTB(drive->ctl, IDE_CONTROL_REG); /* clear nIEN */
-
-	SELECT_MASK(drive, 0);
-
+	memset(&ltask, 0, sizeof(ltask));
 	if (rq->cmd_type == REQ_TYPE_ATA_TASK) {
 #ifdef DEBUG
- 		printk("%s: DRIVE_TASK_CMD ", drive->name);
- 		printk("cmd=0x%02x ", args[0]);
- 		printk("fr=0x%02x ", args[1]);
- 		printk("ns=0x%02x ", args[2]);
- 		printk("sc=0x%02x ", args[3]);
- 		printk("lcyl=0x%02x ", args[4]);
- 		printk("hcyl=0x%02x ", args[5]);
- 		printk("sel=0x%02x\n", args[6]);
+		printk("%s: DRIVE_TASK_CMD\n", drive->name);
 #endif
- 		hwif->OUTB(args[1], IDE_FEATURE_REG);
-		hwif->OUTB(args[2], IDE_NSECTOR_REG);
- 		hwif->OUTB(args[3], IDE_SECTOR_REG);
- 		hwif->OUTB(args[4], IDE_LCYL_REG);
- 		hwif->OUTB(args[5], IDE_HCYL_REG);
- 		hwif->OUTB((args[6] & 0xEF)|drive->select.all, IDE_SELECT_REG);
+		memcpy(&ltask.tf_array[7], &args[1], 6);
+		ltask.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
 	} else { /* rq->cmd_type == REQ_TYPE_ATA_CMD */
 #ifdef DEBUG
- 		printk("%s: DRIVE_CMD ", drive->name);
- 		printk("cmd=0x%02x ", args[0]);
- 		printk("sc=0x%02x ", args[1]);
- 		printk("fr=0x%02x ", args[2]);
- 		printk("xx=0x%02x\n", args[3]);
+		printk("%s: DRIVE_CMD\n", drive->name);
 #endif
-		hwif->OUTB(args[2], IDE_FEATURE_REG);
- 		if (args[0] == WIN_SMART) {
-			hwif->OUTB(args[3],IDE_NSECTOR_REG);
- 			hwif->OUTB(args[1],IDE_SECTOR_REG);
-			hwif->OUTB(0x4f, IDE_LCYL_REG);
-			hwif->OUTB(0xc2, IDE_HCYL_REG);
-		} else
-			hwif->OUTB(args[1], IDE_NSECTOR_REG);
+		tf->feature = args[2];
+		if (args[0] == WIN_SMART) {
+			tf->nsect = args[3];
+			tf->lbal  = args[1];
+			tf->lbam  = 0x4f;
+			tf->lbah  = 0xc2;
+			ltask.tf_flags = IDE_TFLAG_OUT_TF;
+		} else {
+			tf->nsect = args[1];
+			ltask.tf_flags = IDE_TFLAG_OUT_FEATURE |
+					 IDE_TFLAG_OUT_NSECT;
+		}
  	}
-
+	tf->command = args[0];
+	ide_tf_load(drive, &ltask);
 	ide_execute_command(drive, args[0], &drive_cmd_intr, WAIT_CMD, NULL);
 	return ide_started;
 
Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -72,6 +72,13 @@ void ide_tf_load(ide_drive_t *drive, ide
 	if (task->tf_flags & IDE_TFLAG_FLAGGED)
 		HIHI = 0xFF;
 
+#ifdef DEBUG
+	printk("%s: tf: feat 0x%02x nsect 0x%02x lbal 0x%02x "
+		"lbam 0x%02x lbah 0x%02x dev 0x%02x cmd 0x%02x\n",
+		drive->name, tf->feature, tf->nsect, tf->lbal,
+		tf->lbam, tf->lbah, tf->device, tf->command);
+#endif
+
 	if (IDE_CONTROL_REG)
 		hwif->OUTB(drive->ctl, IDE_CONTROL_REG); /* clear nIEN */
 
@@ -103,7 +110,8 @@ void ide_tf_load(ide_drive_t *drive, ide
 	if (task->tf_flags & IDE_TFLAG_OUT_LBAH)
 		hwif->OUTB(tf->lbah, IDE_HCYL_REG);
 
-	hwif->OUTB((tf->device & HIHI) | drive->select.all, IDE_SELECT_REG);
+	if (task->tf_flags & IDE_TFLAG_OUT_DEVICE)
+		hwif->OUTB((tf->device & HIHI) | drive->select.all, IDE_SELECT_REG);
 }
 
 EXPORT_SYMBOL_GPL(ide_tf_load);
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1073,6 +1073,7 @@ enum {
 					  IDE_TFLAG_OUT_LBAL |
 					  IDE_TFLAG_OUT_LBAM |
 					  IDE_TFLAG_OUT_LBAH,
+	IDE_TFLAG_OUT_DEVICE		= (1 << 14),
 };
 
 struct ide_taskfile {
