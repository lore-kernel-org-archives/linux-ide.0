From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 11/15] ide: remove unnecessary writes to HOB taskfile registers
Date: Sat, 27 Oct 2007 19:46:41 +0200
Message-ID: <200710271946.41585.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:48557 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755858AbXJ0Rqv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Oct 2007 13:46:51 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1026724nfb
        for <linux-ide@vger.kernel.org>; Sat, 27 Oct 2007 10:46:50 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Set taskfile flags for REQ_TYPE_ATA_TASKFILE requests before
  adding the request to the queue.

* Cleanup execute_drive_cmd().

* Remove unnecessary writes to HOB taskfile registers when using
  LBA48 disk for the following cases:

  - Power Management requests
    (WIN_FLUSH_CACHE[_EXT], WIN_STANDBYNOW1, WIN_IDLEIMMEDIATE commands)

  - special commands (WIN_SPECIFY, WIN_RESTORE, WIN_SETMULT)

  - Host Protected Area support (WIN_READ_NATIVE_MAX, WIN_SET_MAX)

  - /proc/ide/ SMART support (WIN_SMART with SMART_ENABLE,
    SMART_READ_VALUES and SMART_READ_THRESHOLDS subcommands)

  - write cache enabling/disabling in ide-disk
    (WIN_SETFEATURES with SETFEATURES_{EN,DIS}_WCACHE)

  - write cache flushing in ide-disk (WIN_FLUSH_CACHE[_EXT])

  - acoustic management in ide-disk
    (WIN_SETFEATURES with SETFEATURES_{EN,DIS}_AAM)

  - door (un)locking in ide-disk (WIN_DOORLOCK, WIN_DOORUNLOCK)

  - /proc/ide/hd?/identify support (WIN_IDENTIFY)

  - ACPI _GTF taskfiles

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-acpi.c     |    1 +
 drivers/ide/ide-disk.c     |   13 +++++++++++++
 drivers/ide/ide-io.c       |   12 ------------
 drivers/ide/ide-taskfile.c |    9 +++++++++
 4 files changed, 23 insertions(+), 12 deletions(-)

Index: b/drivers/ide/ide-acpi.c
===================================================================
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -352,6 +352,7 @@ static int taskfile_load_raw(ide_drive_t
 
 	/* convert gtf to IDE Taskfile */
 	memcpy(&args.tf_array[7], &gtf->tfa, 7);
+	args.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
 
 	if (ide_noacpitfs) {
 		DEBPRINT("_GTF execution disabled\n");
Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -330,6 +330,9 @@ static u64 idedisk_read_native_max_addre
 	else
 		tf->command = WIN_READ_NATIVE_MAX;
 	tf->device  = ATA_LBA;
+	args.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	if (lba48)
+		args.tf_flags |= (IDE_TFLAG_LBA48 | IDE_TFLAG_OUT_HOB);
 	/* submit command request */
 	ide_no_data_taskfile(drive, &args);
 
@@ -375,6 +378,9 @@ static u64 idedisk_set_max_address(ide_d
 		tf->command  = WIN_SET_MAX;
 	}
 	tf->device |= ATA_LBA;
+	args.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	if (lba48)
+		args.tf_flags |= (IDE_TFLAG_LBA48 | IDE_TFLAG_OUT_HOB);
 	/* submit command request */
 	ide_no_data_taskfile(drive, &args);
 	/* if OK, compute maximum address value */
@@ -523,6 +529,7 @@ static int smart_enable(ide_drive_t *dri
 	tf->lbam    = SMART_LCYL_PASS;
 	tf->lbah    = SMART_HCYL_PASS;
 	tf->command = WIN_SMART;
+	args.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
 	return ide_no_data_taskfile(drive, &args);
 }
 
@@ -537,6 +544,7 @@ static int get_smart_data(ide_drive_t *d
 	tf->lbam    = SMART_LCYL_PASS;
 	tf->lbah    = SMART_HCYL_PASS;
 	tf->command = WIN_SMART;
+	args.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
 	args.command_type			= IDE_DRIVE_TASK_IN;
 	args.data_phase				= TASKFILE_IN;
 	args.handler				= &task_in_intr;
@@ -716,6 +724,7 @@ static int write_cache(ide_drive_t *driv
 		args.tf.feature = arg ?
 			SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
 		args.tf.command = WIN_SETFEATURES;
+		args.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
 		err = ide_no_data_taskfile(drive, &args);
 		if (err == 0)
 			drive->wcache = arg;
@@ -735,6 +744,7 @@ static int do_idedisk_flushcache (ide_dr
 		args.tf.command = WIN_FLUSH_CACHE_EXT;
 	else
 		args.tf.command = WIN_FLUSH_CACHE;
+	args.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
 	return ide_no_data_taskfile(drive, &args);
 }
 
@@ -749,6 +759,7 @@ static int set_acoustic (ide_drive_t *dr
 	args.tf.feature = arg ? SETFEATURES_EN_AAM : SETFEATURES_DIS_AAM;
 	args.tf.nsect   = arg;
 	args.tf.command = WIN_SETFEATURES;
+	args.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
 	ide_no_data_taskfile(drive, &args);
 	drive->acoustic = arg;
 	return 0;
@@ -1014,6 +1025,7 @@ static int idedisk_open(struct inode *in
 		ide_task_t args;
 		memset(&args, 0, sizeof(ide_task_t));
 		args.tf.command = WIN_DOORLOCK;
+		args.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
 		check_disk_change(inode->i_bdev);
 		/*
 		 * Ignore the return code from door_lock,
@@ -1039,6 +1051,7 @@ static int idedisk_release(struct inode 
 		ide_task_t args;
 		memset(&args, 0, sizeof(ide_task_t));
 		args.tf.command = WIN_DOORUNLOCK;
+		args.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
 		if (drive->doorlocking && ide_no_data_taskfile(drive, &args))
 			drive->doorlocking = 0;
 	}
Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -233,8 +233,6 @@ static ide_startstop_t ide_start_power_s
 
 out_do_tf:
 	args->tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
-	if (drive->addressing == 1)
-		args->tf_flags |= (IDE_TFLAG_LBA48 | IDE_TFLAG_OUT_HOB);
 	args->command_type = IDE_DRIVE_TASK_NO_DATA;
 	args->handler      = task_no_data_intr;
 	return do_rw_taskfile(drive, args);
@@ -711,8 +709,6 @@ static ide_startstop_t ide_disk_special(
 	}
 
 	args.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
-	if (drive->addressing == 1)
-		args.tf_flags |= (IDE_TFLAG_LBA48 | IDE_TFLAG_OUT_HOB);
 
 	do_rw_taskfile(drive, &args);
 
@@ -871,17 +867,9 @@ static ide_startstop_t execute_drive_cmd
 			break;
 		}
 
-		task->tf_flags |= IDE_TFLAG_OUT_DEVICE;
-		if (drive->addressing == 1)
-			task->tf_flags |= IDE_TFLAG_LBA48;
-
 		if (task->tf_flags & IDE_TFLAG_FLAGGED)
 			return flagged_taskfile(drive, task);
 
-		task->tf_flags |= IDE_TFLAG_OUT_TF;
-		if (task->tf_flags & IDE_TFLAG_LBA48)
-			task->tf_flags |= IDE_TFLAG_OUT_HOB;
-
 		return do_rw_taskfile(drive, task);
 	}
 
Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -126,6 +126,7 @@ int taskfile_lib_get_identify (ide_drive
 		args.tf.command = WIN_IDENTIFY;
 	else
 		args.tf.command = WIN_PIDENTIFY;
+	args.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
 	args.command_type = IDE_DRIVE_TASK_IN;
 	args.data_phase   = TASKFILE_IN;
 	args.handler	  = &task_in_intr;
@@ -619,6 +620,10 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 	args.data_phase   = req_task->data_phase;
 	args.command_type = req_task->req_cmd;
 
+	args.tf_flags = IDE_TFLAG_OUT_DEVICE;
+	if (drive->addressing == 1)
+		args.tf_flags |= IDE_TFLAG_LBA48;
+
 	if (req_task->out_flags.all) {
 		args.tf_flags |= IDE_TFLAG_FLAGGED;
 
@@ -644,6 +649,10 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 			args.tf_flags |= IDE_TFLAG_OUT_LBAM;
 		if (req_task->out_flags.b.hcyl)
 			args.tf_flags |= IDE_TFLAG_OUT_LBAH;
+	} else {
+		args.tf_flags |= IDE_TFLAG_OUT_TF;
+		if (args.tf_flags & IDE_TFLAG_LBA48)
+			args.tf_flags |= IDE_TFLAG_OUT_HOB;
 	}
 
 	drive->io_32bit = 0;
