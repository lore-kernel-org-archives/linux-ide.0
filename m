From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/9] ide-disk: add ide_tf_set_cmd() helper
Date: Fri, 2 Nov 2007 23:05:41 +0100
Message-ID: <200711022305.41127.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:59724 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754853AbXKBWIY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 18:08:24 -0400
Received: by nf-out-0910.google.com with SMTP id g13so940294nfb
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2007 15:08:23 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Add ide_tf_set_cmd() helper for selecting/setting command and data phase
  (note: DMA data phases are there for completness, they are not required ATM).

* Set IDE_TFLAG_WRITE taskfile flag for write requests in __ide_do_rw_disk().

* Convert __ide_do_rw_disk() to use the new ide_tf_set_cmd() helper.

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |   85 +++++++++++++++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 30 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -155,6 +155,50 @@ static int lba_capacity_is_ok (struct hd
 	return 0;	/* lba_capacity value may be bad */
 }
 
+static const u8 ide_rw_cmds[] = {
+	WIN_MULTREAD,
+	WIN_MULTWRITE,
+	WIN_MULTREAD_EXT,
+	WIN_MULTWRITE_EXT,
+	WIN_READ,
+	WIN_WRITE,
+	WIN_READ_EXT,
+	WIN_WRITE_EXT,
+	WIN_READDMA,
+	WIN_WRITEDMA,
+	WIN_READDMA_EXT,
+	WIN_WRITEDMA_EXT,
+};
+
+static const u8 ide_data_phases[] = {
+	TASKFILE_MULTI_IN,
+	TASKFILE_MULTI_OUT,
+	TASKFILE_IN,
+	TASKFILE_OUT,
+	TASKFILE_IN_DMA,
+	TASKFILE_OUT_DMA,
+};
+
+static void ide_tf_set_cmd(ide_drive_t *drive, ide_task_t *task, u8 dma)
+{
+	u8 index, lba48, write;
+
+	lba48 = (task->tf_flags & IDE_TFLAG_LBA48) ? 2 : 0;
+	write = (task->tf_flags & IDE_TFLAG_WRITE) ? 1 : 0;
+
+	if (dma)
+		index = drive->vdma ? 4 : 8;
+	else
+		index = drive->mult_count ? 0 : 4;
+
+	task->tf.command = ide_rw_cmds[index + lba48 + write];
+
+	if (dma)
+		index = 8; /* fixup index */
+
+	task->data_phase = ide_data_phases[index / 2 + write];
+}
+
 /*
  * __ide_do_rw_disk() issues READ and WRITE commands to a disk,
  * using LBA if supported, or CHS otherwise, to address sectors.
@@ -165,7 +209,6 @@ static ide_startstop_t __ide_do_rw_disk(
 	unsigned int dma	= drive->using_dma;
 	u16 nsectors		= (u16)rq->nr_sectors;
 	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
-	u8 command		= WIN_NOP;
 	ide_task_t		task;
 	struct ide_taskfile	*tf = &task.tf;
 
@@ -231,50 +274,32 @@ static ide_startstop_t __ide_do_rw_disk(
 		tf->device = head;
 	}
 
+	if (rq_data_dir(rq))
+		task.tf_flags |= IDE_TFLAG_WRITE;
+
+	ide_tf_set_cmd(drive, &task, dma);
+
 	ide_tf_load(drive, &task);
 
 	if (dma) {
 		if (!hwif->dma_setup(drive)) {
-			if (rq_data_dir(rq)) {
-				command = lba48 ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
-				if (drive->vdma)
-					command = lba48 ? WIN_WRITE_EXT: WIN_WRITE;
-			} else {
-				command = lba48 ? WIN_READDMA_EXT : WIN_READDMA;
-				if (drive->vdma)
-					command = lba48 ? WIN_READ_EXT: WIN_READ;
-			}
-			hwif->dma_exec_cmd(drive, command);
+			hwif->dma_exec_cmd(drive, tf->command);
 			hwif->dma_start(drive);
 			return ide_started;
 		}
 		/* fallback to PIO */
+		ide_tf_set_cmd(drive, &task, 0);
 		ide_init_sg_cmd(drive, rq);
 	}
 
-	if (rq_data_dir(rq) == READ) {
-
-		if (drive->mult_count) {
-			hwif->data_phase = TASKFILE_MULTI_IN;
-			command = lba48 ? WIN_MULTREAD_EXT : WIN_MULTREAD;
-		} else {
-			hwif->data_phase = TASKFILE_IN;
-			command = lba48 ? WIN_READ_EXT : WIN_READ;
-		}
+	hwif->data_phase = task.data_phase;
 
-		ide_execute_command(drive, command, &task_in_intr,
+	if (rq_data_dir(rq) == READ) {
+		ide_execute_command(drive, tf->command, &task_in_intr,
 				    WAIT_WORSTCASE, NULL);
 		return ide_started;
 	} else {
-		if (drive->mult_count) {
-			hwif->data_phase = TASKFILE_MULTI_OUT;
-			command = lba48 ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
-		} else {
-			hwif->data_phase = TASKFILE_OUT;
-			command = lba48 ? WIN_WRITE_EXT : WIN_WRITE;
-		}
-
-		hwif->OUTBSYNC(drive, command, IDE_COMMAND_REG);
+		hwif->OUTBSYNC(drive, tf->command, IDE_COMMAND_REG);
 		ndelay(400);	/* FIXME */
 
 		return pre_task_out_intr(drive, rq);
