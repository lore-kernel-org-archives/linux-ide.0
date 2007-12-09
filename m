From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 20/20] ide: remove REQ_TYPE_ATA_CMD
Date: Sun, 9 Dec 2007 22:22:52 +0100
Message-ID: <200712092222.53015.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:55855 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674AbXLIVVK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 16:21:10 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1381343ugc
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 13:21:09 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>


Based on the earlier work by Tejun Heo.

All users are gone so we can finally remove it.

Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c   |   98 ++-----------------------------------------------
 drivers/ide/ide-lib.c  |   25 +++---------
 include/linux/blkdev.h |    1 
 3 files changed, 11 insertions(+), 113 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -354,7 +354,6 @@ void ide_tf_read(ide_drive_t *drive, ide
  
 void ide_end_drive_cmd (ide_drive_t *drive, u8 stat, u8 err)
 {
-	ide_hwif_t *hwif = HWIF(drive);
 	unsigned long flags;
 	struct request *rq;
 
@@ -362,19 +361,7 @@ void ide_end_drive_cmd (ide_drive_t *dri
 	rq = HWGROUP(drive)->rq;
 	spin_unlock_irqrestore(&ide_lock, flags);
 
-	if (rq->cmd_type == REQ_TYPE_ATA_CMD) {
-		u8 *args = (u8 *) rq->buffer;
-		if (rq->errors == 0)
-			rq->errors = !OK_STAT(stat,READY_STAT,BAD_STAT);
-
-		if (args) {
-			args[0] = stat;
-			args[1] = err;
-			/* be sure we're looking at the low order bits */
-			hwif->OUTB(drive->ctl & ~0x80, IDE_CONTROL_REG);
-			args[2] = hwif->INB(IDE_NSECTOR_REG);
-		}
-	} else if (rq->cmd_type == REQ_TYPE_ATA_TASKFILE) {
+	if (rq->cmd_type == REQ_TYPE_ATA_TASKFILE) {
 		ide_task_t *args = (ide_task_t *) rq->special;
 		if (rq->errors == 0)
 			rq->errors = !OK_STAT(stat,READY_STAT,BAD_STAT);
@@ -624,48 +611,6 @@ ide_startstop_t ide_abort(ide_drive_t *d
 		return __ide_abort(drive, rq);
 }
 
-/**
- *	drive_cmd_intr		- 	drive command completion interrupt
- *	@drive: drive the completion interrupt occurred on
- *
- *	drive_cmd_intr() is invoked on completion of a special DRIVE_CMD.
- *	We do any necessary data reading and then wait for the drive to
- *	go non busy. At that point we may read the error data and complete
- *	the request
- */
- 
-static ide_startstop_t drive_cmd_intr (ide_drive_t *drive)
-{
-	struct request *rq = HWGROUP(drive)->rq;
-	ide_hwif_t *hwif = HWIF(drive);
-	u8 *args = (u8 *)rq->buffer, pio_in = (args && args[3]) ? 1 : 0, stat;
-
-	if (pio_in) {
-		u8 io_32bit = drive->io_32bit;
-		stat = hwif->INB(IDE_STATUS_REG);
-		if (!OK_STAT(stat, DRQ_STAT, BAD_R_STAT)) {
-			if (stat & (ERR_STAT | DRQ_STAT))
-				return ide_error(drive, __FUNCTION__, stat);
-			ide_set_handler(drive, &drive_cmd_intr, WAIT_WORSTCASE,
-					NULL);
-			return ide_started;
-		}
-		drive->io_32bit = 0;
-		hwif->ata_input_data(drive, &args[4], args[3] * SECTOR_WORDS);
-		drive->io_32bit = io_32bit;
-		stat = wait_drive_not_busy(drive);
-	} else {
-		local_irq_enable_in_hardirq();
-		stat = hwif->INB(IDE_STATUS_REG);
-	}
-
-	if (!OK_STAT(stat, (pio_in ? 0 : READY_STAT), BAD_STAT))
-		return ide_error(drive, __FUNCTION__, stat);
-		/* calls ide_end_drive_cmd */
-	ide_end_drive_cmd(drive, stat, hwif->INB(IDE_ERROR_REG));
-	return ide_stopped;
-}
-
 static void ide_tf_set_specify_cmd(ide_drive_t *drive, struct ide_taskfile *tf)
 {
 	tf->nsect   = drive->sect;
@@ -851,16 +796,9 @@ static ide_startstop_t execute_drive_cmd
 		struct request *rq)
 {
 	ide_hwif_t *hwif = HWIF(drive);
-	u8 *args = rq->buffer;
-	ide_task_t ltask;
-	struct ide_taskfile *tf = &ltask.tf;
-
-	if (rq->cmd_type == REQ_TYPE_ATA_TASKFILE) {
-		ide_task_t *task = rq->special;
- 
-		if (task == NULL)
-			goto done;
+	ide_task_t *task = rq->special;
 
+	if (task) {
 		hwif->data_phase = task->data_phase;
 
 		switch (hwif->data_phase) {
@@ -877,33 +815,6 @@ static ide_startstop_t execute_drive_cmd
 		return do_rw_taskfile(drive, task);
 	}
 
-	if (args == NULL)
-		goto done;
-
-	memset(&ltask, 0, sizeof(ltask));
-	if (rq->cmd_type == REQ_TYPE_ATA_CMD) {
-#ifdef DEBUG
-		printk("%s: DRIVE_CMD\n", drive->name);
-#endif
-		tf->feature = args[2];
-		if (args[0] == WIN_SMART) {
-			tf->nsect = args[3];
-			tf->lbal  = args[1];
-			tf->lbam  = 0x4f;
-			tf->lbah  = 0xc2;
-			ltask.tf_flags = IDE_TFLAG_OUT_TF;
-		} else {
-			tf->nsect = args[1];
-			ltask.tf_flags = IDE_TFLAG_OUT_FEATURE |
-					 IDE_TFLAG_OUT_NSECT;
-		}
- 	}
-	tf->command = args[0];
-	ide_tf_load(drive, &ltask);
-	ide_execute_command(drive, args[0], &drive_cmd_intr, WAIT_WORSTCASE, NULL);
-	return ide_started;
-
-done:
  	/*
  	 * NULL is actually a valid way of waiting for
  	 * all current requests to be flushed from the queue.
@@ -1006,8 +917,7 @@ static ide_startstop_t start_request (id
 		if (drive->current_speed == 0xff)
 			ide_config_drive_speed(drive, drive->desired_speed);
 
-		if (rq->cmd_type == REQ_TYPE_ATA_CMD ||
-		    rq->cmd_type == REQ_TYPE_ATA_TASKFILE)
+		if (rq->cmd_type == REQ_TYPE_ATA_TASKFILE)
 			return execute_drive_cmd(drive, rq);
 		else if (blk_pm_request(rq)) {
 			struct request_pm_state *pm = rq->data;
Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -454,8 +454,7 @@ int ide_set_xfer_rate(ide_drive_t *drive
 static void ide_dump_opcode(ide_drive_t *drive)
 {
 	struct request *rq;
-	u8 opcode = 0;
-	int found = 0;
+	ide_task_t *task = NULL;
 
 	spin_lock(&ide_lock);
 	rq = NULL;
@@ -464,25 +463,15 @@ static void ide_dump_opcode(ide_drive_t 
 	spin_unlock(&ide_lock);
 	if (!rq)
 		return;
-	if (rq->cmd_type == REQ_TYPE_ATA_CMD) {
-		char *args = rq->buffer;
-		if (args) {
-			opcode = args[0];
-			found = 1;
-		}
-	} else if (rq->cmd_type == REQ_TYPE_ATA_TASKFILE) {
-		ide_task_t *args = rq->special;
-		if (args) {
-			opcode = args->tf.command;
-			found = 1;
-		}
-	}
+
+	if (rq->cmd_type == REQ_TYPE_ATA_TASKFILE)
+		task = rq->special;
 
 	printk("ide: failed opcode was: ");
-	if (!found)
-		printk("unknown\n");
+	if (task == NULL)
+		printk(KERN_CONT "unknown\n");
 	else
-		printk("0x%02x\n", opcode);
+		printk(KERN_CONT "0x%02x\n", task->tf.command);
 }
 
 u64 ide_get_lba_addr(struct ide_taskfile *tf, int lba48)
Index: b/include/linux/blkdev.h
===================================================================
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -143,7 +143,6 @@ enum rq_cmd_type_bits {
 	 * use REQ_TYPE_SPECIAL and use rq->cmd[0] with the range of driver
 	 * private REQ_LB opcodes to differentiate what type of request this is
 	 */
-	REQ_TYPE_ATA_CMD,
 	REQ_TYPE_ATA_TASKFILE,
 	REQ_TYPE_ATA_PC,
 };
