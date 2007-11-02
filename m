From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/9] ide: use ->data_phase to set ->handler in do_rw_taskfile()
Date: Fri, 2 Nov 2007 23:05:30 +0100
Message-ID: <200711022305.30663.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:59724 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022AbXKBWIV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 18:08:21 -0400
Received: by nf-out-0910.google.com with SMTP id g13so940294nfb
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2007 15:08:20 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Use ->data_phase to set ->handler in do_rw_taskfile() instead of
  setting ->handler in callers of ide_raw_taskfile()/do_rw_taskfile().

* Unexport task_no_data_intr() and make it static.

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c     |    2 --
 drivers/ide/ide-io.c       |    1 -
 drivers/ide/ide-taskfile.c |   16 ++++++++++------
 include/linux/ide.h        |    1 -
 4 files changed, 10 insertions(+), 10 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -544,7 +544,6 @@ static int get_smart_data(ide_drive_t *d
 	tf->command = WIN_SMART;
 	args.tf_flags	= IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
 	args.data_phase	= TASKFILE_IN;
-	args.handler	= task_in_intr;
 	(void) smart_enable(drive);
 	return ide_raw_taskfile(drive, &args, buf, 1);
 }
@@ -634,7 +633,6 @@ static void idedisk_prepare_flush(struct
 		task.tf.command = WIN_FLUSH_CACHE;
 	task.tf_flags	= IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
 	task.data_phase	= TASKFILE_NO_DATA;
-	task.handler	= task_no_data_intr;
 
 	rq->cmd_type = REQ_TYPE_ATA_TASKFILE;
 	rq->cmd_flags |= REQ_SOFTBARRIER;
Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -234,7 +234,6 @@ static ide_startstop_t ide_start_power_s
 out_do_tf:
 	args->tf_flags	 = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
 	args->data_phase = TASKFILE_NO_DATA;
-	args->handler	 = task_no_data_intr;
 	return do_rw_taskfile(drive, args);
 }
 
Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -128,7 +128,6 @@ int taskfile_lib_get_identify (ide_drive
 		args.tf.command = WIN_PIDENTIFY;
 	args.tf_flags	= IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
 	args.data_phase	= TASKFILE_IN;
-	args.handler	= task_in_intr;
 	return ide_raw_taskfile(drive, &args, buf, 1);
 }
 
@@ -151,6 +150,9 @@ static int inline task_dma_ok(ide_task_t
 	return 0;
 }
 
+static ide_startstop_t task_no_data_intr(ide_drive_t *);
+static ide_startstop_t task_out_intr(ide_drive_t *);
+
 ide_startstop_t do_rw_taskfile (ide_drive_t *drive, ide_task_t *task)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
@@ -173,12 +175,18 @@ ide_startstop_t do_rw_taskfile (ide_driv
 	switch (task->data_phase) {
 	case TASKFILE_MULTI_OUT:
 	case TASKFILE_OUT:
+		task->handler = task_out_intr;
 		hwif->OUTBSYNC(drive, tf->command, IDE_COMMAND_REG);
 		ndelay(400);	/* FIXME */
 		return pre_task_out_intr(drive, task->rq);
 	case TASKFILE_MULTI_IN:
 	case TASKFILE_IN:
+		task->handler = task_in_intr;
+		/* fall-through */
 	case TASKFILE_NO_DATA:
+		/* WIN_{SPECIFY,RESTORE,SETMULT} use custom handlers */
+		if (task->handler == NULL)
+			task->handler = task_no_data_intr;
 		ide_execute_command(drive, tf->command, task->handler, WAIT_WORSTCASE, NULL);
 		return ide_started;
 	default:
@@ -248,7 +256,7 @@ ide_startstop_t recal_intr (ide_drive_t 
 /*
  * Handler for commands without a data phase
  */
-ide_startstop_t task_no_data_intr (ide_drive_t *drive)
+static ide_startstop_t task_no_data_intr(ide_drive_t *drive)
 {
 	ide_task_t *args	= HWGROUP(drive)->rq->special;
 	ide_hwif_t *hwif	= HWIF(drive);
@@ -544,7 +552,6 @@ EXPORT_SYMBOL(ide_raw_taskfile);
 int ide_no_data_taskfile(ide_drive_t *drive, ide_task_t *task)
 {
 	task->data_phase = TASKFILE_NO_DATA;
-	task->handler    = task_no_data_intr;
 
 	return ide_raw_taskfile(drive, task, NULL, 0);
 }
@@ -667,7 +674,6 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 			}
 			/* fall through */
 		case TASKFILE_OUT:
-			args.handler = &task_out_intr;
 			/* fall through */
 		case TASKFILE_OUT_DMAQ:
 		case TASKFILE_OUT_DMA:
@@ -685,7 +691,6 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 			}
 			/* fall through */
 		case TASKFILE_IN:
-			args.handler = &task_in_intr;
 			/* fall through */
 		case TASKFILE_IN_DMAQ:
 		case TASKFILE_IN_DMA:
@@ -693,7 +698,6 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 			data_buf = inbuf;
 			break;
 		case TASKFILE_NO_DATA:
-			args.handler = &task_no_data_intr;
 			break;
 		default:
 			err = -EFAULT;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -980,7 +980,6 @@ extern ide_startstop_t do_rw_taskfile(id
 extern ide_startstop_t set_multmode_intr(ide_drive_t *);
 extern ide_startstop_t set_geometry_intr(ide_drive_t *);
 extern ide_startstop_t recal_intr(ide_drive_t *);
-extern ide_startstop_t task_no_data_intr(ide_drive_t *);
 extern ide_startstop_t task_in_intr(ide_drive_t *);
 extern ide_startstop_t pre_task_out_intr(ide_drive_t *, struct request *);
 
