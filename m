From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 9/9] ide-disk: use do_rw_taskfile()
Date: Fri, 2 Nov 2007 23:05:44 +0100
Message-ID: <200711022305.44833.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:61145 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755071AbXKBWI0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 18:08:26 -0400
Received: by nf-out-0910.google.com with SMTP id g13so940287nfb
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2007 15:08:25 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Add IDE_TFLAG_DMA_PIO_FALLBACK taskfile flag to indicate the need
  to skip loading taskfile registers in do_rw_taskfile().

* Export do_rw_taskfile().

* Convert __ide_do_rw_disk() to use do_rw_taskfile().

* Unexport ide_tf_load().

* Unexport {pre_task_out,task_in}_intr() and make it static.

* Remove incorrect comment about do_rw_taskfile() from <linux/ide.h>.

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c     |   29 ++++++++++-------------------
 drivers/ide/ide-taskfile.c |   14 +++++++-------
 include/linux/ide.h        |    9 ++-------
 3 files changed, 19 insertions(+), 33 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -211,6 +211,7 @@ static ide_startstop_t __ide_do_rw_disk(
 	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
 	ide_task_t		task;
 	struct ide_taskfile	*tf = &task.tf;
+	ide_startstop_t		rc;
 
 	if ((hwif->host_flags & IDE_HFLAG_NO_LBA48_DMA) && lba48 && dma) {
 		if (block + rq->nr_sectors > 1ULL << 28)
@@ -278,32 +279,22 @@ static ide_startstop_t __ide_do_rw_disk(
 		task.tf_flags |= IDE_TFLAG_WRITE;
 
 	ide_tf_set_cmd(drive, &task, dma);
+	if (!dma)
+		hwif->data_phase = task.data_phase;
+	task.rq = rq;
 
-	ide_tf_load(drive, &task);
+	rc = do_rw_taskfile(drive, &task);
 
-	if (dma) {
-		if (!hwif->dma_setup(drive)) {
-			hwif->dma_exec_cmd(drive, tf->command);
-			hwif->dma_start(drive);
-			return ide_started;
-		}
+	if (rc == ide_stopped && dma) {
 		/* fallback to PIO */
+		task.tf_flags |= IDE_TFLAG_DMA_PIO_FALLBACK;
 		ide_tf_set_cmd(drive, &task, 0);
+		hwif->data_phase = task.data_phase;
 		ide_init_sg_cmd(drive, rq);
+		rc = do_rw_taskfile(drive, &task);
 	}
 
-	hwif->data_phase = task.data_phase;
-
-	if (rq_data_dir(rq) == READ) {
-		ide_execute_command(drive, tf->command, &task_in_intr,
-				    WAIT_WORSTCASE, NULL);
-		return ide_started;
-	} else {
-		hwif->OUTBSYNC(drive, tf->command, IDE_COMMAND_REG);
-		ndelay(400);	/* FIXME */
-
-		return pre_task_out_intr(drive, rq);
-	}
+	return rc;
 }
 
 /*
Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -114,8 +114,6 @@ void ide_tf_load(ide_drive_t *drive, ide
 		hwif->OUTB((tf->device & HIHI) | drive->select.all, IDE_SELECT_REG);
 }
 
-EXPORT_SYMBOL_GPL(ide_tf_load);
-
 int taskfile_lib_get_identify (ide_drive_t *drive, u8 *buf)
 {
 	ide_task_t args;
@@ -154,6 +152,8 @@ static ide_startstop_t task_no_data_intr
 static ide_startstop_t set_geometry_intr(ide_drive_t *);
 static ide_startstop_t recal_intr(ide_drive_t *);
 static ide_startstop_t set_multmode_intr(ide_drive_t *);
+static ide_startstop_t pre_task_out_intr(ide_drive_t *, struct request *);
+static ide_startstop_t task_in_intr(ide_drive_t *);
 
 ide_startstop_t do_rw_taskfile (ide_drive_t *drive, ide_task_t *task)
 {
@@ -173,7 +173,8 @@ ide_startstop_t do_rw_taskfile (ide_driv
 	if (task->tf_flags & IDE_TFLAG_FLAGGED)
 		task->tf_flags |= IDE_TFLAG_FLAGGED_SET_IN_FLAGS;
 
-	ide_tf_load(drive, task);
+	if ((task->tf_flags & IDE_TFLAG_DMA_PIO_FALLBACK) == 0)
+		ide_tf_load(drive, task);
 
 	switch (task->data_phase) {
 	case TASKFILE_MULTI_OUT:
@@ -208,6 +209,7 @@ ide_startstop_t do_rw_taskfile (ide_driv
 		return ide_started;
 	}
 }
+EXPORT_SYMBOL_GPL(do_rw_taskfile);
 
 /*
  * set_multmode_intr() is invoked on completion of a WIN_SETMULT cmd.
@@ -446,7 +448,7 @@ static void task_end_request(ide_drive_t
 /*
  * Handler for command with PIO data-in phase (Read/Read Multiple).
  */
-ide_startstop_t task_in_intr (ide_drive_t *drive)
+static ide_startstop_t task_in_intr(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	struct request *rq = HWGROUP(drive)->rq;
@@ -477,7 +479,6 @@ ide_startstop_t task_in_intr (ide_drive_
 
 	return ide_started;
 }
-EXPORT_SYMBOL(task_in_intr);
 
 /*
  * Handler for command with PIO data-out phase (Write/Write Multiple).
@@ -507,7 +508,7 @@ static ide_startstop_t task_out_intr (id
 	return ide_started;
 }
 
-ide_startstop_t pre_task_out_intr (ide_drive_t *drive, struct request *rq)
+static ide_startstop_t pre_task_out_intr(ide_drive_t *drive, struct request *rq)
 {
 	ide_startstop_t startstop;
 
@@ -528,7 +529,6 @@ ide_startstop_t pre_task_out_intr (ide_d
 
 	return ide_started;
 }
-EXPORT_SYMBOL(pre_task_out_intr);
 
 int ide_raw_taskfile(ide_drive_t *drive, ide_task_t *task, u8 *buf, u16 nsect)
 {
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -919,6 +919,7 @@ enum {
 	IDE_TFLAG_FLAGGED_SET_IN_FLAGS	= (1 << 16),
 	IDE_TFLAG_IN_DATA		= (1 << 17),
 	IDE_TFLAG_CUSTOM_HANDLER	= (1 << 18),
+	IDE_TFLAG_DMA_PIO_FALLBACK	= (1 << 19),
 };
 
 struct ide_taskfile {
@@ -972,13 +973,7 @@ extern int drive_is_ready(ide_drive_t *)
 
 void ide_pktcmd_tf_load(ide_drive_t *, u32, u16, u8);
 
-/*
- * taskfile io for disks for now...and builds request from ide_ioctl
- */
-extern ide_startstop_t do_rw_taskfile(ide_drive_t *, ide_task_t *);
-
-extern ide_startstop_t task_in_intr(ide_drive_t *);
-extern ide_startstop_t pre_task_out_intr(ide_drive_t *, struct request *);
+ide_startstop_t do_rw_taskfile(ide_drive_t *, ide_task_t *);
 
 int ide_raw_taskfile(ide_drive_t *, ide_task_t *, u8 *, u16);
 int ide_no_data_taskfile(ide_drive_t *, ide_task_t *);
