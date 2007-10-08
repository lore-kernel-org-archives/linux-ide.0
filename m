From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 12/12] ide: use do_rw_taskfile() in flagged_taskfile()
Date: Mon, 8 Oct 2007 23:20:30 +0200
Message-ID: <200710082320.31069.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:59889 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209AbXJHVj5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Oct 2007 17:39:57 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1370209nfb
        for <linux-ide@vger.kernel.org>; Mon, 08 Oct 2007 14:39:57 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>


Based on the earlier work by Tejun Heo.

* Move setting IDE_TFLAG_LBA48 taskfile flag from do_rw_taskfile()
  function to the callers.

* Add IDE_TFLAG_FLAGGED taskfile flag for flagged taskfiles coming
  from ide_taskfile_ioctl().  Check it instead of ->tf_out_flags.all.

* Add IDE_TFLAG_OUT_DATA taskfile flag to indicate the need to load
  IDE data register in ide_tf_load().

* Add IDE_TFLAG_OUT_* taskfile flags to indicate the need to load
  particular IDE taskfile registers in ide_tf_load().

* Update do_rw_taskfile() and ide_tf_load() users to set respective
  IDE_TFLAG_OUT_* taksfile flags.

* Add task_dma_ok() helper.

* Use IDE_TFLAG_FLAGGED taskfile flag to select HIHI mask in ide_tf_load().

* Use do_rw_taskfile() in flagged_taskfile().

* Remove no longer needed 'tf_out_flags' field from ide_task_t.

There should be no functionality changes caused by this patch.

Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c     |    3 
 drivers/ide/ide-io.c       |   31 +++++--
 drivers/ide/ide-taskfile.c |  180 ++++++++++++++++++---------------------------
 include/linux/ide.h        |   25 +++++-
 4 files changed, 119 insertions(+), 120 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -185,6 +185,7 @@ static ide_startstop_t __ide_do_rw_disk(
 
 	memset(&task, 0, sizeof(task));
 	task.tf_flags = IDE_TFLAG_NO_SELECT_MASK;  /* FIXME? */
+	task.tf_flags |= IDE_TFLAG_OUT_TF;
 
 	if (drive->select.b.lba) {
 		if (lba48) {
@@ -208,7 +209,7 @@ static ide_startstop_t __ide_do_rw_disk(
 				tf->hob_lbah, tf->hob_lbam, tf->hob_lbal,
 				tf->lbah, tf->lbam, tf->lbal);
 #endif
-			task.tf_flags |= IDE_TFLAG_LBA48;
+			task.tf_flags |= (IDE_TFLAG_LBA48 | IDE_TFLAG_OUT_HOB);
 		} else {
 			tf->nsect  = nsectors.b.low;
 			tf->lbal   = block;
Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -192,15 +192,11 @@ static ide_startstop_t ide_start_power_s
 			args->tf.command = WIN_FLUSH_CACHE_EXT;
 		else
 			args->tf.command = WIN_FLUSH_CACHE;
-		args->command_type = IDE_DRIVE_TASK_NO_DATA;
-		args->handler	   = &task_no_data_intr;
-		return do_rw_taskfile(drive, args);
+		goto out_do_tf;
 
 	case idedisk_pm_standby:	/* Suspend step 2 (standby) */
 		args->tf.command = WIN_STANDBYNOW1;
-		args->command_type = IDE_DRIVE_TASK_NO_DATA;
-		args->handler	   = &task_no_data_intr;
-		return do_rw_taskfile(drive, args);
+		goto out_do_tf;
 
 	case idedisk_pm_restore_pio:	/* Resume step 1 (restore PIO) */
 		ide_set_max_pio(drive);
@@ -215,9 +211,7 @@ static ide_startstop_t ide_start_power_s
 
 	case idedisk_pm_idle:		/* Resume step 2 (idle) */
 		args->tf.command = WIN_IDLEIMMEDIATE;
-		args->command_type = IDE_DRIVE_TASK_NO_DATA;
-		args->handler = task_no_data_intr;
-		return do_rw_taskfile(drive, args);
+		goto out_do_tf;
 
 	case ide_pm_restore_dma:	/* Resume step 3 (restore DMA) */
 		/*
@@ -236,6 +230,14 @@ static ide_startstop_t ide_start_power_s
 	}
 	pm->pm_step = ide_pm_state_completed;
 	return ide_stopped;
+
+out_do_tf:
+	args->tf_flags = IDE_TFLAG_OUT_TF;
+	if (drive->addressing == 1)
+		args->tf_flags |= (IDE_TFLAG_LBA48 | IDE_TFLAG_OUT_HOB);
+	args->command_type = IDE_DRIVE_TASK_NO_DATA;
+	args->handler      = task_no_data_intr;
+	return do_rw_taskfile(drive, args);
 }
 
 /**
@@ -761,6 +763,10 @@ static ide_startstop_t ide_disk_special(
 		return ide_stopped;
 	}
 
+	args.tf_flags = IDE_TFLAG_OUT_TF;
+	if (drive->addressing == 1)
+		args.tf_flags |= (IDE_TFLAG_LBA48 | IDE_TFLAG_OUT_HOB);
+
 	do_rw_taskfile(drive, &args);
 
 	return ide_started;
@@ -913,8 +919,13 @@ static ide_startstop_t execute_drive_cmd
 			break;
 		}
 
-		if (args->tf_out_flags.all != 0) 
+		if (args->tf_flags & IDE_TFLAG_FLAGGED)
 			return flagged_taskfile(drive, args);
+
+		args->tf_flags |= IDE_TFLAG_OUT_TF;
+		if (drive->addressing == 1)
+			args->tf_flags |= (IDE_TFLAG_LBA48 | IDE_TFLAG_OUT_HOB);
+
 		return do_rw_taskfile(drive, args);
 	} else if (rq->cmd_type == REQ_TYPE_ATA_TASK) {
 		u8 *args = rq->buffer;
Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -68,25 +68,39 @@ void ide_tf_load(ide_drive_t *drive, ide
 	struct ide_taskfile *tf = &task->tf;
 	u8 HIHI = (task->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;
 
+	if (task->tf_flags & IDE_TFLAG_FLAGGED)
+		HIHI = 0xFF;
+
 	if (IDE_CONTROL_REG)
 		hwif->OUTB(drive->ctl, IDE_CONTROL_REG); /* clear nIEN */
 
 	if ((task->tf_flags & IDE_TFLAG_NO_SELECT_MASK) == 0)
 		SELECT_MASK(drive, 0);
 
-	if (task->tf_flags & IDE_TFLAG_LBA48) {
+	if (task->tf_flags & IDE_TFLAG_OUT_DATA)
+		hwif->OUTW((tf->hob_data << 8) | tf->data, IDE_DATA_REG);
+
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_FEATURE)
 		hwif->OUTB(tf->hob_feature, IDE_FEATURE_REG);
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_NSECT)
 		hwif->OUTB(tf->hob_nsect, IDE_NSECTOR_REG);
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_LBAL)
 		hwif->OUTB(tf->hob_lbal, IDE_SECTOR_REG);
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_LBAM)
 		hwif->OUTB(tf->hob_lbam, IDE_LCYL_REG);
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_LBAH)
 		hwif->OUTB(tf->hob_lbah, IDE_HCYL_REG);
-	}
 
-	hwif->OUTB(tf->feature, IDE_FEATURE_REG);
-	hwif->OUTB(tf->nsect, IDE_NSECTOR_REG);
-	hwif->OUTB(tf->lbal, IDE_SECTOR_REG);
-	hwif->OUTB(tf->lbam, IDE_LCYL_REG);
-	hwif->OUTB(tf->lbah, IDE_HCYL_REG);
+	if (task->tf_flags & IDE_TFLAG_OUT_FEATURE)
+		hwif->OUTB(tf->feature, IDE_FEATURE_REG);
+	if (task->tf_flags & IDE_TFLAG_OUT_NSECT)
+		hwif->OUTB(tf->nsect, IDE_NSECTOR_REG);
+	if (task->tf_flags & IDE_TFLAG_OUT_LBAL)
+		hwif->OUTB(tf->lbal, IDE_SECTOR_REG);
+	if (task->tf_flags & IDE_TFLAG_OUT_LBAM)
+		hwif->OUTB(tf->lbam, IDE_LCYL_REG);
+	if (task->tf_flags & IDE_TFLAG_OUT_LBAH)
+		hwif->OUTB(tf->lbah, IDE_HCYL_REG);
 
 	hwif->OUTB((tf->device & HIHI) | drive->select.all, IDE_SELECT_REG);
 }
@@ -109,14 +123,30 @@ int taskfile_lib_get_identify (ide_drive
 	return ide_raw_taskfile(drive, &args, buf);
 }
 
+static int inline task_dma_ok(ide_task_t *task)
+{
+	if (task->tf_flags & IDE_TFLAG_FLAGGED)
+		return 1;
+
+	switch (task->tf.command) {
+		case WIN_WRITEDMA_ONCE:
+		case WIN_WRITEDMA:
+		case WIN_WRITEDMA_EXT:
+		case WIN_READDMA_ONCE:
+		case WIN_READDMA:
+		case WIN_READDMA_EXT:
+		case WIN_IDENTIFY_DMA:
+			return 1;
+	}
+
+	return 0;
+}
+
 ide_startstop_t do_rw_taskfile (ide_drive_t *drive, ide_task_t *task)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct ide_taskfile *tf = &task->tf;
 
-	if (drive->addressing == 1)
-		task->tf_flags |= IDE_TFLAG_LBA48;
-
 	ide_tf_load(drive, task);
 
 	if (task->handler != NULL) {
@@ -129,26 +159,10 @@ ide_startstop_t do_rw_taskfile (ide_driv
 		return ide_started;
 	}
 
-	if (!drive->using_dma)
-		return ide_stopped;
-
-	switch (tf->command) {
-		case WIN_WRITEDMA_ONCE:
-		case WIN_WRITEDMA:
-		case WIN_WRITEDMA_EXT:
-		case WIN_READDMA_ONCE:
-		case WIN_READDMA:
-		case WIN_READDMA_EXT:
-		case WIN_IDENTIFY_DMA:
-			if (!hwif->dma_setup(drive)) {
-				hwif->dma_exec_cmd(drive, tf->command);
-				hwif->dma_start(drive);
-				return ide_started;
-			}
-			break;
-		default:
-			if (task->handler == NULL)
-				return ide_stopped;
+	if (task_dma_ok(task) && drive->using_dma && !hwif->dma_setup(drive)) {
+		hwif->dma_exec_cmd(drive, tf->command);
+		hwif->dma_start(drive);
+		return ide_started;
 	}
 
 	return ide_stopped;
@@ -363,7 +377,7 @@ static void task_end_request(ide_drive_t
 	if (rq->cmd_type == REQ_TYPE_ATA_TASKFILE) {
 		ide_task_t *task = rq->special;
 
-		if (task->tf_out_flags.all) {
+		if (task->tf_flags & IDE_TFLAG_FLAGGED) {
 			u8 err = drive->hwif->INB(IDE_ERROR_REG);
 			ide_end_drive_cmd(drive, stat, err);
 			return;
@@ -583,10 +597,36 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 	memcpy(&args.tf_array[0], req_task->hob_ports, HDIO_DRIVE_HOB_HDR_SIZE - 2);
 	memcpy(&args.tf_array[6], req_task->io_ports, HDIO_DRIVE_TASK_HDR_SIZE);
 	args.tf_in_flags  = req_task->in_flags;
-	args.tf_out_flags = req_task->out_flags;
 	args.data_phase   = req_task->data_phase;
 	args.command_type = req_task->req_cmd;
 
+	if (req_task->out_flags.all) {
+		args.tf_flags |= IDE_TFLAG_FLAGGED;
+
+		if (req_task->out_flags.b.data)
+			args.tf_flags |= IDE_TFLAG_OUT_DATA;
+
+		if (req_task->out_flags.b.nsector_hob)
+			args.tf_flags |= IDE_TFLAG_OUT_HOB_NSECT;
+		if (req_task->out_flags.b.sector_hob)
+			args.tf_flags |= IDE_TFLAG_OUT_HOB_LBAL;
+		if (req_task->out_flags.b.lcyl_hob)
+			args.tf_flags |= IDE_TFLAG_OUT_HOB_LBAM;
+		if (req_task->out_flags.b.hcyl_hob)
+			args.tf_flags |= IDE_TFLAG_OUT_HOB_LBAH;
+
+		if (req_task->out_flags.b.error_feature)
+			args.tf_flags |= IDE_TFLAG_OUT_FEATURE;
+		if (req_task->out_flags.b.nsector)
+			args.tf_flags |= IDE_TFLAG_OUT_NSECT;
+		if (req_task->out_flags.b.sector)
+			args.tf_flags |= IDE_TFLAG_OUT_LBAL;
+		if (req_task->out_flags.b.lcyl)
+			args.tf_flags |= IDE_TFLAG_OUT_LBAM;
+		if (req_task->out_flags.b.hcyl)
+			args.tf_flags |= IDE_TFLAG_OUT_LBAH;
+	}
+
 	drive->io_32bit = 0;
 	switch(req_task->data_phase) {
 		case TASKFILE_OUT_DMAQ:
@@ -638,7 +678,6 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 	memcpy(req_task->hob_ports, &args.tf_array[0], HDIO_DRIVE_HOB_HDR_SIZE - 2);
 	memcpy(req_task->io_ports, &args.tf_array[6], HDIO_DRIVE_TASK_HDR_SIZE);
 	req_task->in_flags  = args.tf_in_flags;
-	req_task->out_flags = args.tf_out_flags;
 
 	if (copy_to_user(buf, req_task, tasksize)) {
 		err = -EFAULT;
@@ -770,9 +809,6 @@ int ide_task_ioctl (ide_drive_t *drive, 
  */
 ide_startstop_t flagged_taskfile (ide_drive_t *drive, ide_task_t *task)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct ide_taskfile *tf = &task->tf;
-
 	if (task->data_phase == TASKFILE_MULTI_IN ||
 	    task->data_phase == TASKFILE_MULTI_OUT) {
 		if (!drive->mult_count) {
@@ -795,75 +831,5 @@ ide_startstop_t flagged_taskfile (ide_dr
 			task->tf_in_flags.all |= (IDE_HOB_STD_IN_FLAGS  << 8);
         }
 
-	/* ALL Command Block Executions SHALL clear nIEN, unless otherwise */
-	if (IDE_CONTROL_REG)
-		/* clear nIEN */
-		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
-	SELECT_MASK(drive, 0);
-
-	if (task->tf_out_flags.b.data)
-		hwif->OUTW((tf->hob_data << 8) | tf->data, IDE_DATA_REG);
-
-	/* (ks) send hob registers first */
-	if (task->tf_out_flags.b.nsector_hob)
-		hwif->OUTB(tf->hob_nsect, IDE_NSECTOR_REG);
-	if (task->tf_out_flags.b.sector_hob)
-		hwif->OUTB(tf->hob_lbal, IDE_SECTOR_REG);
-	if (task->tf_out_flags.b.lcyl_hob)
-		hwif->OUTB(tf->hob_lbam, IDE_LCYL_REG);
-	if (task->tf_out_flags.b.hcyl_hob)
-		hwif->OUTB(tf->hob_lbah, IDE_HCYL_REG);
-
-	/* (ks) Send now the standard registers */
-	if (task->tf_out_flags.b.error_feature)
-		hwif->OUTB(tf->feature, IDE_FEATURE_REG);
-	/* refers to number of sectors to transfer */
-	if (task->tf_out_flags.b.nsector)
-		hwif->OUTB(tf->nsect, IDE_NSECTOR_REG);
-	/* refers to sector offset or start sector */
-	if (task->tf_out_flags.b.sector)
-		hwif->OUTB(tf->lbal, IDE_SECTOR_REG);
-	if (task->tf_out_flags.b.lcyl)
-		hwif->OUTB(tf->lbam, IDE_LCYL_REG);
-	if (task->tf_out_flags.b.hcyl)
-		hwif->OUTB(tf->lbah, IDE_HCYL_REG);
-
-        /*
-	 * (ks) In the flagged taskfile approch, we will use all specified
-	 * registers and the register value will not be changed, except the
-	 * select bit (master/slave) in the drive_head register. We must make
-	 * sure that the desired drive is selected.
-	 */
-	hwif->OUTB(tf->device | drive->select.all, IDE_SELECT_REG);
-	switch(task->data_phase) {
-
-   	        case TASKFILE_OUT_DMAQ:
-		case TASKFILE_OUT_DMA:
-		case TASKFILE_IN_DMAQ:
-		case TASKFILE_IN_DMA:
-			if (!drive->using_dma)
-				break;
-
-			if (!hwif->dma_setup(drive)) {
-				hwif->dma_exec_cmd(drive, tf->command);
-				hwif->dma_start(drive);
-				return ide_started;
-			}
-			break;
-
-	        default:
- 			if (task->handler == NULL)
-				return ide_stopped;
-
-			/* Issue the command */
-			if (task->prehandler) {
-				hwif->OUTBSYNC(drive, tf->command, IDE_COMMAND_REG);
-				ndelay(400);	/* FIXME */
-				return task->prehandler(drive, task->rq);
-			}
-			ide_execute_command(drive, tf->command, task->handler, WAIT_WORSTCASE, NULL);
-			return ide_started;
-	}
-
-	return ide_stopped;
+	return do_rw_taskfile(drive, task);
 }
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1073,6 +1073,28 @@ extern int ide_wait_cmd(ide_drive_t *, u
 enum {
 	IDE_TFLAG_LBA48			= (1 << 0),
 	IDE_TFLAG_NO_SELECT_MASK	= (1 << 1),
+	IDE_TFLAG_FLAGGED		= (1 << 2),
+	IDE_TFLAG_OUT_DATA		= (1 << 3),
+	IDE_TFLAG_OUT_HOB_FEATURE	= (1 << 4),
+	IDE_TFLAG_OUT_HOB_NSECT		= (1 << 5),
+	IDE_TFLAG_OUT_HOB_LBAL		= (1 << 6),
+	IDE_TFLAG_OUT_HOB_LBAM		= (1 << 7),
+	IDE_TFLAG_OUT_HOB_LBAH		= (1 << 8),
+	IDE_TFLAG_OUT_HOB		= IDE_TFLAG_OUT_HOB_FEATURE |
+					  IDE_TFLAG_OUT_HOB_NSECT |
+					  IDE_TFLAG_OUT_HOB_LBAL |
+					  IDE_TFLAG_OUT_HOB_LBAM |
+					  IDE_TFLAG_OUT_HOB_LBAH,
+	IDE_TFLAG_OUT_FEATURE		= (1 << 9),
+	IDE_TFLAG_OUT_NSECT		= (1 << 10),
+	IDE_TFLAG_OUT_LBAL		= (1 << 11),
+	IDE_TFLAG_OUT_LBAM		= (1 << 12),
+	IDE_TFLAG_OUT_LBAH		= (1 << 13),
+	IDE_TFLAG_OUT_TF		= IDE_TFLAG_OUT_FEATURE |
+					  IDE_TFLAG_OUT_NSECT |
+					  IDE_TFLAG_OUT_LBAL |
+					  IDE_TFLAG_OUT_LBAM |
+					  IDE_TFLAG_OUT_LBAH,
 };
 
 struct ide_taskfile {
@@ -1102,8 +1124,7 @@ typedef struct ide_task_s {
 		struct ide_taskfile	tf;
 		u8			tf_array[14];
 	};
-	u8			tf_flags;
-	ide_reg_valid_t		tf_out_flags;
+	u16			tf_flags;
 	ide_reg_valid_t		tf_in_flags;
 	int			data_phase;
 	int			command_type;
