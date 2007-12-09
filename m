From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/20] ide: set IDE_TFLAG_IN_* flags before queuing/executing command
Date: Sun, 9 Dec 2007 22:12:02 +0100
Message-ID: <200712092212.02712.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:55432 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbXLIVU6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 16:20:58 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1381308ugc
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 13:20:57 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Add IDE_TFLAG_{HOB,TF,DEVICE} defines.

* Set IDE_TFLAG_IN_* flags in {do_rw,ide_no_data,ide_raw}_taskfile() users.

* Remove no longer needed ->tf_flags setup from ide_end_drive_cmd().

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-acpi.c     |    2 +-
 drivers/ide/ide-disk.c     |   24 ++++++++++++------------
 drivers/ide/ide-io.c       |    8 ++------
 drivers/ide/ide-taskfile.c |    9 +++++----
 include/linux/ide.h        |    6 ++++++
 5 files changed, 26 insertions(+), 23 deletions(-)

Index: b/drivers/ide/ide-acpi.c
===================================================================
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -352,7 +352,7 @@ static int taskfile_load_raw(ide_drive_t
 
 	/* convert gtf to IDE Taskfile */
 	memcpy(&args.tf_array[7], &gtf->tfa, 7);
-	args.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	args.tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
 
 	if (ide_noacpitfs) {
 		DEBPRINT("_GTF execution disabled\n");
Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -201,7 +201,7 @@ static ide_startstop_t __ide_do_rw_disk(
 
 	memset(&task, 0, sizeof(task));
 	task.tf_flags = IDE_TFLAG_NO_SELECT_MASK;  /* FIXME? */
-	task.tf_flags |= (IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE);
+	task.tf_flags |= (IDE_TFLAG_TF | IDE_TFLAG_DEVICE);
 
 	if (drive->select.b.lba) {
 		if (lba48) {
@@ -220,7 +220,7 @@ static ide_startstop_t __ide_do_rw_disk(
 			tf->lbam   = (u8)(block >>  8);
 			tf->lbah   = (u8)(block >> 16);
 
-			task.tf_flags |= (IDE_TFLAG_LBA48 | IDE_TFLAG_OUT_HOB);
+			task.tf_flags |= (IDE_TFLAG_LBA48 | IDE_TFLAG_HOB);
 		} else {
 			tf->nsect  = nsectors & 0xff;
 			tf->lbal   = block;
@@ -314,9 +314,9 @@ static u64 idedisk_read_native_max_addre
 	else
 		tf->command = WIN_READ_NATIVE_MAX;
 	tf->device  = ATA_LBA;
-	args.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	args.tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
 	if (lba48)
-		args.tf_flags |= (IDE_TFLAG_LBA48 | IDE_TFLAG_OUT_HOB);
+		args.tf_flags |= (IDE_TFLAG_LBA48 | IDE_TFLAG_HOB);
 	/* submit command request */
 	ide_no_data_taskfile(drive, &args);
 
@@ -353,9 +353,9 @@ static u64 idedisk_set_max_address(ide_d
 		tf->command  = WIN_SET_MAX;
 	}
 	tf->device |= ATA_LBA;
-	args.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	args.tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
 	if (lba48)
-		args.tf_flags |= (IDE_TFLAG_LBA48 | IDE_TFLAG_OUT_HOB);
+		args.tf_flags |= (IDE_TFLAG_LBA48 | IDE_TFLAG_HOB);
 	/* submit command request */
 	ide_no_data_taskfile(drive, &args);
 	/* if OK, compute maximum address value */
@@ -495,7 +495,7 @@ static int smart_enable(ide_drive_t *dri
 	tf->lbam    = SMART_LCYL_PASS;
 	tf->lbah    = SMART_HCYL_PASS;
 	tf->command = WIN_SMART;
-	args.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	args.tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
 	return ide_no_data_taskfile(drive, &args);
 }
 
@@ -510,7 +510,7 @@ static int get_smart_data(ide_drive_t *d
 	tf->lbam    = SMART_LCYL_PASS;
 	tf->lbah    = SMART_HCYL_PASS;
 	tf->command = WIN_SMART;
-	args.tf_flags	= IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	args.tf_flags	= IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
 	args.data_phase	= TASKFILE_IN;
 	(void) smart_enable(drive);
 	return ide_raw_taskfile(drive, &args, buf, 1);
@@ -689,7 +689,7 @@ static int write_cache(ide_drive_t *driv
 		args.tf.feature = arg ?
 			SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
 		args.tf.command = WIN_SETFEATURES;
-		args.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+		args.tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
 		err = ide_no_data_taskfile(drive, &args);
 		if (err == 0)
 			drive->wcache = arg;
@@ -709,7 +709,7 @@ static int do_idedisk_flushcache (ide_dr
 		args.tf.command = WIN_FLUSH_CACHE_EXT;
 	else
 		args.tf.command = WIN_FLUSH_CACHE;
-	args.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	args.tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
 	return ide_no_data_taskfile(drive, &args);
 }
 
@@ -724,7 +724,7 @@ static int set_acoustic (ide_drive_t *dr
 	args.tf.feature = arg ? SETFEATURES_EN_AAM : SETFEATURES_DIS_AAM;
 	args.tf.nsect   = arg;
 	args.tf.command = WIN_SETFEATURES;
-	args.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	args.tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
 	ide_no_data_taskfile(drive, &args);
 	drive->acoustic = arg;
 	return 0;
@@ -975,7 +975,7 @@ static int idedisk_set_doorlock(ide_driv
 
 	memset(&task, 0, sizeof(task));
 	task.tf.command = on ? WIN_DOORLOCK : WIN_DOORUNLOCK;
-	task.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	task.tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
 
 	return ide_no_data_taskfile(drive, &task);
 }
Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -231,7 +231,7 @@ static ide_startstop_t ide_start_power_s
 	return ide_stopped;
 
 out_do_tf:
-	args->tf_flags	 = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	args->tf_flags	 = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
 	args->data_phase = TASKFILE_NO_DATA;
 	return do_rw_taskfile(drive, args);
 }
@@ -383,10 +383,6 @@ void ide_end_drive_cmd (ide_drive_t *dri
 			tf->error = err;
 			tf->status = stat;
 
-			args->tf_flags |= (IDE_TFLAG_IN_TF|IDE_TFLAG_IN_DEVICE);
-			if (args->tf_flags & IDE_TFLAG_LBA48)
-				args->tf_flags |= IDE_TFLAG_IN_HOB;
-
 			ide_tf_read(drive, args);
 		}
 	} else if (blk_pm_request(rq)) {
@@ -710,7 +706,7 @@ static ide_startstop_t ide_disk_special(
 		return ide_stopped;
 	}
 
-	args.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE |
+	args.tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE |
 			IDE_TFLAG_CUSTOM_HANDLER;
 
 	do_rw_taskfile(drive, &args);
Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -99,7 +99,7 @@ int taskfile_lib_get_identify (ide_drive
 		args.tf.command = WIN_IDENTIFY;
 	else
 		args.tf.command = WIN_PIDENTIFY;
-	args.tf_flags	= IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	args.tf_flags	= IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
 	args.data_phase	= TASKFILE_IN;
 	return ide_raw_taskfile(drive, &args, buf, 1);
 }
@@ -618,9 +618,10 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 
 	args.data_phase = req_task->data_phase;
 
-	args.tf_flags = IDE_TFLAG_IO_16BIT | IDE_TFLAG_OUT_DEVICE;
+	args.tf_flags = IDE_TFLAG_IO_16BIT | IDE_TFLAG_DEVICE |
+			IDE_TFLAG_IN_TF;
 	if (drive->addressing == 1)
-		args.tf_flags |= IDE_TFLAG_LBA48;
+		args.tf_flags |= (IDE_TFLAG_LBA48 | IDE_TFLAG_IN_HOB);
 
 	if (req_task->out_flags.all) {
 		args.tf_flags |= IDE_TFLAG_FLAGGED;
@@ -836,7 +837,7 @@ int ide_task_ioctl (ide_drive_t *drive, 
 	memset(&task, 0, sizeof(task));
 	memcpy(&task.tf_array[7], &args[1], 6);
 	task.tf.command = args[0];
-	task.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	task.tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
 
 	err = ide_no_data_taskfile(drive, &task);
 
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -931,6 +931,12 @@ enum {
 	IDE_TFLAG_IN_TF			= IDE_TFLAG_IN_NSECT |
 					  IDE_TFLAG_IN_LBA,
 	IDE_TFLAG_IN_DEVICE		= (1 << 29),
+	IDE_TFLAG_HOB			= IDE_TFLAG_OUT_HOB |
+					  IDE_TFLAG_IN_HOB,
+	IDE_TFLAG_TF			= IDE_TFLAG_OUT_TF |
+					  IDE_TFLAG_IN_TF,
+	IDE_TFLAG_DEVICE		= IDE_TFLAG_OUT_DEVICE |
+					  IDE_TFLAG_IN_DEVICE,
 	/* force 16-bit I/O operations */
 	IDE_TFLAG_IO_16BIT		= (1 << 30),
 };
