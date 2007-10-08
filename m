From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 11/12] ide: add ide_no_data_taskfile() helper
Date: Mon, 8 Oct 2007 23:18:37 +0200
Message-ID: <200710082318.37597.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:59801 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753387AbXJHVj5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Oct 2007 17:39:57 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1370193nfb
        for <linux-ide@vger.kernel.org>; Mon, 08 Oct 2007 14:39:56 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Add ide_no_data_taskfile() helper and convert ide_raw_taskfile() w/ NO DATA
  protocol users to use it instead.

* Set ->data_phase explicitly in ide_no_data_taskfile()
  (TASKFILE_NO_DATA is defined as 0x0000).

* Unexport task_no_data_intr().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-acpi.c     |    7 ++-----
 drivers/ide/ide-disk.c     |   32 ++++++++------------------------
 drivers/ide/ide-taskfile.c |   13 +++++++++++--
 include/linux/ide.h        |    2 ++
 4 files changed, 23 insertions(+), 31 deletions(-)

Index: b/drivers/ide/ide-acpi.c
===================================================================
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -349,9 +349,6 @@ static int taskfile_load_raw(ide_drive_t
 	       gtf->tfa[3], gtf->tfa[4], gtf->tfa[5], gtf->tfa[6]);
 
 	memset(&args, 0, sizeof(ide_task_t));
-	args.command_type = IDE_DRIVE_TASK_NO_DATA;
-	args.data_phase   = TASKFILE_NO_DATA;
-	args.handler      = &task_no_data_intr;
 
 	/* convert gtf to IDE Taskfile */
 	memcpy(&args.tf_array[7], &gtf->tfa, 7);
@@ -361,9 +358,9 @@ static int taskfile_load_raw(ide_drive_t
 		return err;
 	}
 
-	err = ide_raw_taskfile(drive, &args, NULL);
+	err = ide_no_data_taskfile(drive, &args);
 	if (err)
-		printk(KERN_ERR "%s: ide_raw_taskfile failed: %u\n",
+		printk(KERN_ERR "%s: ide_no_data_taskfile failed: %u\n",
 		       __FUNCTION__, err);
 
 	return err;
Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -329,10 +329,8 @@ static u64 idedisk_read_native_max_addre
 	else
 		tf->command = WIN_READ_NATIVE_MAX;
 	tf->device  = ATA_LBA;
-	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
-	args.handler				= &task_no_data_intr;
 	/* submit command request */
-	ide_raw_taskfile(drive, &args, NULL);
+	ide_no_data_taskfile(drive, &args);
 
 	/* if OK, compute maximum address value */
 	if ((tf->command & 0x01) == 0) {
@@ -376,10 +374,8 @@ static u64 idedisk_set_max_address(ide_d
 		tf->command  = WIN_SET_MAX;
 	}
 	tf->device |= ATA_LBA;
-	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
-	args.handler				= &task_no_data_intr;
 	/* submit command request */
-	ide_raw_taskfile(drive, &args, NULL);
+	ide_no_data_taskfile(drive, &args);
 	/* if OK, compute maximum address value */
 	if ((tf->command & 0x01) == 0) {
 		u32 high, low;
@@ -525,9 +521,7 @@ static int smart_enable(ide_drive_t *dri
 	tf->lbam    = SMART_LCYL_PASS;
 	tf->lbah    = SMART_HCYL_PASS;
 	tf->command = WIN_SMART;
-	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
-	args.handler				= &task_no_data_intr;
-	return ide_raw_taskfile(drive, &args, NULL);
+	return ide_no_data_taskfile(drive, &args);
 }
 
 static int get_smart_data(ide_drive_t *drive, u8 *buf, u8 sub_cmd)
@@ -749,9 +743,7 @@ static int write_cache(ide_drive_t *driv
 		args.tf.feature = arg ?
 			SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
 		args.tf.command = WIN_SETFEATURES;
-		args.command_type		= IDE_DRIVE_TASK_NO_DATA;
-		args.handler			= &task_no_data_intr;
-		err = ide_raw_taskfile(drive, &args, NULL);
+		err = ide_no_data_taskfile(drive, &args);
 		if (err == 0)
 			drive->wcache = arg;
 	}
@@ -770,9 +762,7 @@ static int do_idedisk_flushcache (ide_dr
 		args.tf.command = WIN_FLUSH_CACHE_EXT;
 	else
 		args.tf.command = WIN_FLUSH_CACHE;
-	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
-	args.handler				= &task_no_data_intr;
-	return ide_raw_taskfile(drive, &args, NULL);
+	return ide_no_data_taskfile(drive, &args);
 }
 
 static int set_acoustic (ide_drive_t *drive, int arg)
@@ -786,9 +776,7 @@ static int set_acoustic (ide_drive_t *dr
 	args.tf.feature = arg ? SETFEATURES_EN_AAM : SETFEATURES_DIS_AAM;
 	args.tf.nsect   = arg;
 	args.tf.command = WIN_SETFEATURES;
-	args.command_type = IDE_DRIVE_TASK_NO_DATA;
-	args.handler	  = &task_no_data_intr;
-	ide_raw_taskfile(drive, &args, NULL);
+	ide_no_data_taskfile(drive, &args);
 	drive->acoustic = arg;
 	return 0;
 }
@@ -1053,15 +1041,13 @@ static int idedisk_open(struct inode *in
 		ide_task_t args;
 		memset(&args, 0, sizeof(ide_task_t));
 		args.tf.command = WIN_DOORLOCK;
-		args.command_type = IDE_DRIVE_TASK_NO_DATA;
-		args.handler	  = &task_no_data_intr;
 		check_disk_change(inode->i_bdev);
 		/*
 		 * Ignore the return code from door_lock,
 		 * since the open() has already succeeded,
 		 * and the door_lock is irrelevant at this point.
 		 */
-		if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
+		if (drive->doorlocking && ide_no_data_taskfile(drive, &args))
 			drive->doorlocking = 0;
 	}
 	return 0;
@@ -1080,9 +1066,7 @@ static int idedisk_release(struct inode 
 		ide_task_t args;
 		memset(&args, 0, sizeof(ide_task_t));
 		args.tf.command = WIN_DOORUNLOCK;
-		args.command_type = IDE_DRIVE_TASK_NO_DATA;
-		args.handler	  = &task_no_data_intr;
-		if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
+		if (drive->doorlocking && ide_no_data_taskfile(drive, &args))
 			drive->doorlocking = 0;
 	}
 
Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -228,8 +228,6 @@ ide_startstop_t task_no_data_intr (ide_d
 	return ide_stopped;
 }
 
-EXPORT_SYMBOL(task_no_data_intr);
-
 static u8 wait_drive_not_busy(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
@@ -513,6 +511,17 @@ int ide_raw_taskfile (ide_drive_t *drive
 
 EXPORT_SYMBOL(ide_raw_taskfile);
 
+int ide_no_data_taskfile(ide_drive_t *drive, ide_task_t *task)
+{
+	task->command_type = IDE_DRIVE_TASK_NO_DATA;
+	task->data_phase   = TASKFILE_NO_DATA;
+	task->handler      = task_no_data_intr;
+
+	return ide_raw_taskfile(drive, task, NULL);
+}
+
+EXPORT_SYMBOL_GPL(ide_no_data_taskfile);
+
 int ide_taskfile_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned long arg)
 {
 	ide_task_request_t	*req_task;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1143,6 +1143,8 @@ extern ide_startstop_t pre_task_out_intr
 
 extern int ide_raw_taskfile(ide_drive_t *, ide_task_t *, u8 *);
 
+int ide_no_data_taskfile(ide_drive_t *, ide_task_t *);
+
 int ide_taskfile_ioctl(ide_drive_t *, unsigned int, unsigned long);
 int ide_cmd_ioctl(ide_drive_t *, unsigned int, unsigned long);
 int ide_task_ioctl(ide_drive_t *, unsigned int, unsigned long);
