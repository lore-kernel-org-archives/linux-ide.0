From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 6/9] ide: remove 'handler' field from ide_task_t
Date: Sat, 3 Nov 2007 04:00:11 +0100
Message-ID: <200711030400.11562.bzolnier@gmail.com>
References: <200711022305.33889.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:27323 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753241AbXKCNJN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Nov 2007 09:09:13 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1049028fkz
        for <linux-ide@vger.kernel.org>; Sat, 03 Nov 2007 06:09:11 -0700 (PDT)
In-Reply-To: <200711022305.33889.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Friday 02 November 2007, Bartlomiej Zolnierkiewicz wrote:
> 
> * Add IDE_TFLAG_CUSTOM_HANDLER taskfile flag and use it for internal requests
>   which require custom handlers.  Check the flag in do_rw_taskfile() and set
>   handler accordingly.
> 
> * Cleanup ide_init_{specify,restore,setmult}_cmd() and rename it to
>   ide_tf_set_{specify,restore,setmult}_cmd().
> 
> * Make {set_geometry,recal,set_multmode}_intr() static.
> 
> * Remove no longer needed 'handler' field from ide_task_t.
> 
> There should be no functionality changes caused by this patch.

except that it doesn't work 8) working version below

[PATCH] ide: remove 'handler' field from ide_task_t (take 2)

* Add IDE_TFLAG_CUSTOM_HANDLER taskfile flag and use it for internal requests
  which require custom handlers.  Check the flag in do_rw_taskfile() and set
  handler accordingly.

* Cleanup ide_init_{specify,restore,setmult}_cmd() and rename it to
  ide_tf_set_{specify,restore,setmult}_cmd().

* Make {set_geometry,recal,set_multmode}_intr() static.

* Remove no longer needed 'handler' field from ide_task_t.

v2:
* 'handler' in do_rw_taskfile() must be set to NULL initially.

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c       |   41 ++++++++++++++++++-----------------------
 drivers/ide/ide-taskfile.c |   28 +++++++++++++++++++---------
 include/linux/ide.h        |    5 +----
 3 files changed, 38 insertions(+), 36 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -637,32 +637,26 @@ static ide_startstop_t drive_cmd_intr (i
 	return ide_stopped;
 }
 
-static void ide_init_specify_cmd(ide_drive_t *drive, ide_task_t *task)
+static void ide_tf_set_specify_cmd(ide_drive_t *drive, struct ide_taskfile *tf)
 {
-	task->tf.nsect   = drive->sect;
-	task->tf.lbal    = drive->sect;
-	task->tf.lbam    = drive->cyl;
-	task->tf.lbah    = drive->cyl >> 8;
-	task->tf.device  = ((drive->head - 1) | drive->select.all) & ~ATA_LBA;
-	task->tf.command = WIN_SPECIFY;
-
-	task->handler = &set_geometry_intr;
+	tf->nsect   = drive->sect;
+	tf->lbal    = drive->sect;
+	tf->lbam    = drive->cyl;
+	tf->lbah    = drive->cyl >> 8;
+	tf->device  = ((drive->head - 1) | drive->select.all) & ~ATA_LBA;
+	tf->command = WIN_SPECIFY;
 }
 
-static void ide_init_restore_cmd(ide_drive_t *drive, ide_task_t *task)
+static void ide_tf_set_restore_cmd(ide_drive_t *drive, struct ide_taskfile *tf)
 {
-	task->tf.nsect   = drive->sect;
-	task->tf.command = WIN_RESTORE;
-
-	task->handler = &recal_intr;
+	tf->nsect   = drive->sect;
+	tf->command = WIN_RESTORE;
 }
 
-static void ide_init_setmult_cmd(ide_drive_t *drive, ide_task_t *task)
+static void ide_tf_set_setmult_cmd(ide_drive_t *drive, struct ide_taskfile *tf)
 {
-	task->tf.nsect   = drive->mult_req;
-	task->tf.command = WIN_SETMULT;
-
-	task->handler = &set_multmode_intr;
+	tf->nsect   = drive->mult_req;
+	tf->command = WIN_SETMULT;
 }
 
 static ide_startstop_t ide_disk_special(ide_drive_t *drive)
@@ -675,15 +669,15 @@ static ide_startstop_t ide_disk_special(
 
 	if (s->b.set_geometry) {
 		s->b.set_geometry = 0;
-		ide_init_specify_cmd(drive, &args);
+		ide_tf_set_specify_cmd(drive, &args.tf);
 	} else if (s->b.recalibrate) {
 		s->b.recalibrate = 0;
-		ide_init_restore_cmd(drive, &args);
+		ide_tf_set_restore_cmd(drive, &args.tf);
 	} else if (s->b.set_multmode) {
 		s->b.set_multmode = 0;
 		if (drive->mult_req > drive->id->max_multsect)
 			drive->mult_req = drive->id->max_multsect;
-		ide_init_setmult_cmd(drive, &args);
+		ide_tf_set_setmult_cmd(drive, &args.tf);
 	} else if (s->all) {
 		int special = s->all;
 		s->all = 0;
@@ -691,7 +685,8 @@ static ide_startstop_t ide_disk_special(
 		return ide_stopped;
 	}
 
-	args.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	args.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE |
+			IDE_TFLAG_CUSTOM_HANDLER;
 
 	do_rw_taskfile(drive, &args);
 
Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -151,12 +151,15 @@ static int inline task_dma_ok(ide_task_t
 }
 
 static ide_startstop_t task_no_data_intr(ide_drive_t *);
-static ide_startstop_t task_out_intr(ide_drive_t *);
+static ide_startstop_t set_geometry_intr(ide_drive_t *);
+static ide_startstop_t recal_intr(ide_drive_t *);
+static ide_startstop_t set_multmode_intr(ide_drive_t *);
 
 ide_startstop_t do_rw_taskfile (ide_drive_t *drive, ide_task_t *task)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct ide_taskfile *tf = &task->tf;
+	ide_handler_t *handler = NULL;
 
 	if (task->data_phase == TASKFILE_MULTI_IN ||
 	    task->data_phase == TASKFILE_MULTI_OUT) {
@@ -175,19 +178,26 @@ ide_startstop_t do_rw_taskfile (ide_driv
 	switch (task->data_phase) {
 	case TASKFILE_MULTI_OUT:
 	case TASKFILE_OUT:
-		task->handler = task_out_intr;
 		hwif->OUTBSYNC(drive, tf->command, IDE_COMMAND_REG);
 		ndelay(400);	/* FIXME */
 		return pre_task_out_intr(drive, task->rq);
 	case TASKFILE_MULTI_IN:
 	case TASKFILE_IN:
-		task->handler = task_in_intr;
+		handler = task_in_intr;
 		/* fall-through */
 	case TASKFILE_NO_DATA:
+		if (handler == NULL)
+			handler = task_no_data_intr;
 		/* WIN_{SPECIFY,RESTORE,SETMULT} use custom handlers */
-		if (task->handler == NULL)
-			task->handler = task_no_data_intr;
-		ide_execute_command(drive, tf->command, task->handler, WAIT_WORSTCASE, NULL);
+		if (task->tf_flags & IDE_TFLAG_CUSTOM_HANDLER) {
+			switch (tf->command) {
+			case WIN_SPECIFY: handler = set_geometry_intr;	break;
+			case WIN_RESTORE: handler = recal_intr;		break;
+			case WIN_SETMULT: handler = set_multmode_intr;	break;
+			}
+		}
+		ide_execute_command(drive, tf->command, handler,
+				    WAIT_WORSTCASE, NULL);
 		return ide_started;
 	default:
 		if (task_dma_ok(task) == 0 || drive->using_dma == 0 ||
@@ -202,7 +212,7 @@ ide_startstop_t do_rw_taskfile (ide_driv
 /*
  * set_multmode_intr() is invoked on completion of a WIN_SETMULT cmd.
  */
-ide_startstop_t set_multmode_intr (ide_drive_t *drive)
+static ide_startstop_t set_multmode_intr(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	u8 stat;
@@ -220,7 +230,7 @@ ide_startstop_t set_multmode_intr (ide_d
 /*
  * set_geometry_intr() is invoked on completion of a WIN_SPECIFY cmd.
  */
-ide_startstop_t set_geometry_intr (ide_drive_t *drive)
+static ide_startstop_t set_geometry_intr(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	int retries = 5;
@@ -243,7 +253,7 @@ ide_startstop_t set_geometry_intr (ide_d
 /*
  * recal_intr() is invoked on completion of a WIN_RESTORE (recalibrate) cmd.
  */
-ide_startstop_t recal_intr (ide_drive_t *drive)
+static ide_startstop_t recal_intr(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	u8 stat;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -918,6 +918,7 @@ enum {
 	IDE_TFLAG_WRITE			= (1 << 15),
 	IDE_TFLAG_FLAGGED_SET_IN_FLAGS	= (1 << 16),
 	IDE_TFLAG_IN_DATA		= (1 << 17),
+	IDE_TFLAG_CUSTOM_HANDLER	= (1 << 18),
 };
 
 struct ide_taskfile {
@@ -956,7 +957,6 @@ typedef struct ide_task_s {
 	};
 	u32			tf_flags;
 	int			data_phase;
-	ide_handler_t		*handler;
 	struct request		*rq;		/* copy of request */
 	void			*special;	/* valid_t generally */
 } ide_task_t;
@@ -977,9 +977,6 @@ void ide_pktcmd_tf_load(ide_drive_t *, u
  */
 extern ide_startstop_t do_rw_taskfile(ide_drive_t *, ide_task_t *);
 
-extern ide_startstop_t set_multmode_intr(ide_drive_t *);
-extern ide_startstop_t set_geometry_intr(ide_drive_t *);
-extern ide_startstop_t recal_intr(ide_drive_t *);
 extern ide_startstop_t task_in_intr(ide_drive_t *);
 extern ide_startstop_t pre_task_out_intr(ide_drive_t *, struct request *);
 
