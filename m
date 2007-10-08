From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/12] ide: add ide_tf_load() helper
Date: Mon, 8 Oct 2007 23:17:46 +0200
Message-ID: <200710082317.46641.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:60474 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344AbXJHVj4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Oct 2007 17:39:56 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1370243nfb
        for <linux-ide@vger.kernel.org>; Mon, 08 Oct 2007 14:39:55 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>


Based on the earlier work by Tejun Heo.

* Add 'tf_flags' field (for taskfile flags) to ide_task_t.

* Add IDE_TFLAG_LBA48 taskfile flag for LBA48 taskfiles.

* Add IDE_TFLAG_NO_SELECT_MASK taskfile flag for __ide_do_rw_disk()
  which doesn't use SELECT_MASK() (looks like a bug but it requires
  some more investigation).

* Split off ide_tf_load() helper from do_rw_taskfile().

* Convert __ide_do_rw_disk() to use ide_tf_load().

There should be no functionality changes caused by this patch.

Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c     |   28 ++++------------------
 drivers/ide/ide-taskfile.c |   56 +++++++++++++++++++++++++++------------------
 include/linux/ide.h        |    8 ++++++
 3 files changed, 48 insertions(+), 44 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -166,7 +166,8 @@ static ide_startstop_t __ide_do_rw_disk(
 	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
 	u8 command		= WIN_NOP;
 	ata_nsector_t		nsectors;
-	struct ide_taskfile ltf, *tf = &ltf;
+	ide_task_t		task;
+	struct ide_taskfile	*tf = &task.tf;
 
 	nsectors.all		= (u16) rq->nr_sectors;
 
@@ -182,12 +183,8 @@ static ide_startstop_t __ide_do_rw_disk(
 		ide_map_sg(drive, rq);
 	}
 
-	if (IDE_CONTROL_REG)
-		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
-
-	/* FIXME: SELECT_MASK(drive, 0) ? */
-
-	memset(tf, 0, sizeof(*tf));
+	memset(&task, 0, sizeof(task));
+	task.tf_flags = IDE_TFLAG_NO_SELECT_MASK;  /* FIXME? */
 
 	if (drive->select.b.lba) {
 		if (lba48) {
@@ -211,6 +208,7 @@ static ide_startstop_t __ide_do_rw_disk(
 				tf->hob_lbah, tf->hob_lbam, tf->hob_lbal,
 				tf->lbah, tf->lbam, tf->lbal);
 #endif
+			task.tf_flags |= IDE_TFLAG_LBA48;
 		} else {
 			tf->nsect  = nsectors.b.low;
 			tf->lbal   = block;
@@ -234,21 +232,7 @@ static ide_startstop_t __ide_do_rw_disk(
 		tf->device = head;
 	}
 
-	if (drive->select.b.lba && lba48) {
-		hwif->OUTB(tf->hob_feature, IDE_FEATURE_REG);
-		hwif->OUTB(tf->hob_nsect, IDE_NSECTOR_REG);
-		hwif->OUTB(tf->hob_lbal, IDE_SECTOR_REG);
-		hwif->OUTB(tf->hob_lbam, IDE_LCYL_REG);
-		hwif->OUTB(tf->hob_lbah, IDE_HCYL_REG);
-	}
-
-	hwif->OUTB(tf->feature, IDE_FEATURE_REG);
-	hwif->OUTB(tf->nsect, IDE_NSECTOR_REG);
-	hwif->OUTB(tf->lbal, IDE_SECTOR_REG);
-	hwif->OUTB(tf->lbam, IDE_LCYL_REG);
-	hwif->OUTB(tf->lbah, IDE_HCYL_REG);
-
-	hwif->OUTB(tf->device | drive->select.all, IDE_SELECT_REG);
+	ide_tf_load(drive, &task);
 
 	if (dma) {
 		if (!hwif->dma_setup(drive)) {
Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -62,6 +62,37 @@ static void taskfile_output_data(ide_dri
 	}
 }
 
+void ide_tf_load(ide_drive_t *drive, ide_task_t *task)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct ide_taskfile *tf = &task->tf;
+	u8 HIHI = (task->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;
+
+	if (IDE_CONTROL_REG)
+		hwif->OUTB(drive->ctl, IDE_CONTROL_REG); /* clear nIEN */
+
+	if ((task->tf_flags & IDE_TFLAG_NO_SELECT_MASK) == 0)
+		SELECT_MASK(drive, 0);
+
+	if (task->tf_flags & IDE_TFLAG_LBA48) {
+		hwif->OUTB(tf->hob_feature, IDE_FEATURE_REG);
+		hwif->OUTB(tf->hob_nsect, IDE_NSECTOR_REG);
+		hwif->OUTB(tf->hob_lbal, IDE_SECTOR_REG);
+		hwif->OUTB(tf->hob_lbam, IDE_LCYL_REG);
+		hwif->OUTB(tf->hob_lbah, IDE_HCYL_REG);
+	}
+
+	hwif->OUTB(tf->feature, IDE_FEATURE_REG);
+	hwif->OUTB(tf->nsect, IDE_NSECTOR_REG);
+	hwif->OUTB(tf->lbal, IDE_SECTOR_REG);
+	hwif->OUTB(tf->lbam, IDE_LCYL_REG);
+	hwif->OUTB(tf->lbah, IDE_HCYL_REG);
+
+	hwif->OUTB((tf->device & HIHI) | drive->select.all, IDE_SELECT_REG);
+}
+
+EXPORT_SYMBOL_GPL(ide_tf_load);
+
 int taskfile_lib_get_identify (ide_drive_t *drive, u8 *buf)
 {
 	ide_task_t args;
@@ -82,30 +113,11 @@ ide_startstop_t do_rw_taskfile (ide_driv
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct ide_taskfile *tf = &task->tf;
-	u8 HIHI			= (drive->addressing == 1) ? 0xE0 : 0xEF;
 
-	/* ALL Command Block Executions SHALL clear nIEN, unless otherwise */
-	if (IDE_CONTROL_REG) {
-		/* clear nIEN */
-		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
-	}
-	SELECT_MASK(drive, 0);
+	if (drive->addressing == 1)
+		task->tf_flags |= IDE_TFLAG_LBA48;
 
-	if (drive->addressing == 1) {
-		hwif->OUTB(tf->hob_feature, IDE_FEATURE_REG);
-		hwif->OUTB(tf->hob_nsect, IDE_NSECTOR_REG);
-		hwif->OUTB(tf->hob_lbal, IDE_SECTOR_REG);
-		hwif->OUTB(tf->hob_lbam, IDE_LCYL_REG);
-		hwif->OUTB(tf->hob_lbah, IDE_HCYL_REG);
-	}
-
-	hwif->OUTB(tf->feature, IDE_FEATURE_REG);
-	hwif->OUTB(tf->nsect, IDE_NSECTOR_REG);
-	hwif->OUTB(tf->lbal, IDE_SECTOR_REG);
-	hwif->OUTB(tf->lbam, IDE_LCYL_REG);
-	hwif->OUTB(tf->lbah, IDE_HCYL_REG);
-
-	hwif->OUTB((tf->device & HIHI) | drive->select.all, IDE_SELECT_REG);
+	ide_tf_load(drive, task);
 
 	if (task->handler != NULL) {
 		if (task->prehandler != NULL) {
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1070,6 +1070,11 @@ extern void ide_end_drive_cmd(ide_drive_
  */
 extern int ide_wait_cmd(ide_drive_t *, u8, u8, u8, u8, u8 *);
 
+enum {
+	IDE_TFLAG_LBA48			= (1 << 0),
+	IDE_TFLAG_NO_SELECT_MASK	= (1 << 1),
+};
+
 struct ide_taskfile {
 	u8	hob_data;	/*  0: high data byte (for TASKFILE IOCTL) */
 
@@ -1097,6 +1102,7 @@ typedef struct ide_task_s {
 		struct ide_taskfile	tf;
 		u8			tf_array[14];
 	};
+	u8			tf_flags;
 	ide_reg_valid_t		tf_out_flags;
 	ide_reg_valid_t		tf_in_flags;
 	int			data_phase;
@@ -1107,6 +1113,8 @@ typedef struct ide_task_s {
 	void			*special;	/* valid_t generally */
 } ide_task_t;
 
+void ide_tf_load(ide_drive_t *, ide_task_t *);
+
 extern u32 ide_read_24(ide_drive_t *);
 
 extern void SELECT_DRIVE(ide_drive_t *);
