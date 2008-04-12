From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/9] ide: factor out debugging code from ide_tf_load()
Date: Sat, 12 Apr 2008 14:34:01 +0200
Message-ID: <20080412123401.18751.17246.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:19942 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758352AbYDLMRy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Apr 2008 08:17:54 -0400
Received: by fg-out-1718.google.com with SMTP id l27so742003fgb.17
        for <linux-ide@vger.kernel.org>; Sat, 12 Apr 2008 05:17:53 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Factor out debugging code from ide_tf_load() to ide_tf_dump() helper
and update ide_tf_load() users accordingly.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c       |    1 +
 drivers/ide/ide-taskfile.c |   29 +++++++++++++++++------------
 include/linux/ide.h        |    2 ++
 3 files changed, 20 insertions(+), 12 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1680,6 +1680,7 @@ void ide_pktcmd_tf_load(ide_drive_t *dri
 	task.tf.lbam    = bcount & 0xff;
 	task.tf.lbah    = (bcount >> 8) & 0xff;
 
+	ide_tf_dump(drive->name, &task.tf);
 	ide_tf_load(drive, &task);
 }
 
Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -33,26 +33,29 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
-void ide_tf_load(ide_drive_t *drive, ide_task_t *task)
+void ide_tf_dump(const char *s, struct ide_taskfile *tf)
 {
-	ide_hwif_t *hwif = drive->hwif;
-	struct ide_io_ports *io_ports = &hwif->io_ports;
-	struct ide_taskfile *tf = &task->tf;
-	u8 HIHI = (task->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;
-
-	if (task->tf_flags & IDE_TFLAG_FLAGGED)
-		HIHI = 0xFF;
-
 #ifdef DEBUG
 	printk("%s: tf: feat 0x%02x nsect 0x%02x lbal 0x%02x "
 		"lbam 0x%02x lbah 0x%02x dev 0x%02x cmd 0x%02x\n",
-		drive->name, tf->feature, tf->nsect, tf->lbal,
+		s, tf->feature, tf->nsect, tf->lbal,
 		tf->lbam, tf->lbah, tf->device, tf->command);
 	printk("%s: hob: nsect 0x%02x lbal 0x%02x "
 		"lbam 0x%02x lbah 0x%02x\n",
-		drive->name, tf->hob_nsect, tf->hob_lbal,
+		s, tf->hob_nsect, tf->hob_lbal,
 		tf->hob_lbam, tf->hob_lbah);
 #endif
+}
+
+void ide_tf_load(ide_drive_t *drive, ide_task_t *task)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+	struct ide_taskfile *tf = &task->tf;
+	u8 HIHI = (task->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;
+
+	if (task->tf_flags & IDE_TFLAG_FLAGGED)
+		HIHI = 0xFF;
 
 	ide_set_irq(drive, 1);
 
@@ -149,8 +152,10 @@ ide_startstop_t do_rw_taskfile (ide_driv
 	if (task->tf_flags & IDE_TFLAG_FLAGGED)
 		task->tf_flags |= IDE_TFLAG_FLAGGED_SET_IN_FLAGS;
 
-	if ((task->tf_flags & IDE_TFLAG_DMA_PIO_FALLBACK) == 0)
+	if ((task->tf_flags & IDE_TFLAG_DMA_PIO_FALLBACK) == 0) {
+		ide_tf_dump(drive->name, tf);
 		ide_tf_load(drive, task);
+	}
 
 	switch (task->data_phase) {
 	case TASKFILE_MULTI_OUT:
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -949,6 +949,8 @@ typedef struct ide_task_s {
 	void			*special;	/* valid_t generally */
 } ide_task_t;
 
+void ide_tf_dump(const char *, struct ide_taskfile *);
+
 void ide_tf_load(ide_drive_t *, ide_task_t *);
 void ide_tf_read(ide_drive_t *, ide_task_t *);
 
