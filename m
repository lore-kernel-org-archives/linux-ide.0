From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/15] ide: add ide_pktcmd_tf_load() helper
Date: Wed, 31 Oct 2007 00:30:27 +0100
Message-ID: <200710310030.27565.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:45624 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044AbXJ3Xu1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 19:50:27 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1788114nfb
        for <linux-ide@vger.kernel.org>; Tue, 30 Oct 2007 16:50:26 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Add ide_pktcmd_tf_load() helper and convert ATAPI device drivers to use it.

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c     |   10 ++--------
 drivers/ide/ide-floppy.c |    9 ++-------
 drivers/ide/ide-io.c     |   16 ++++++++++++++++
 drivers/ide/ide-tape.c   |    9 +++------
 drivers/scsi/ide-scsi.c  |    6 +-----
 include/linux/ide.h      |    2 ++
 6 files changed, 26 insertions(+), 26 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -922,14 +922,8 @@ static ide_startstop_t cdrom_start_packe
 		info->dma = !hwif->dma_setup(drive);
 
 	/* Set up the controller registers. */
-	if (IDE_CONTROL_REG)
-		HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);
-	HWIF(drive)->OUTB(info->dma, IDE_FEATURE_REG);
-	HWIF(drive)->OUTB(0, IDE_IREASON_REG);
-	HWIF(drive)->OUTB(0, IDE_SECTOR_REG);
-
-	HWIF(drive)->OUTB(xferlen & 0xff, IDE_BCOUNTL_REG);
-	HWIF(drive)->OUTB(xferlen >> 8  , IDE_BCOUNTH_REG);
+	ide_pktcmd_tf_load(drive, IDE_TFLAG_OUT_NSECT | IDE_TFLAG_OUT_LBAL |
+			   IDE_TFLAG_NO_SELECT_MASK, xferlen, info->dma);
  
 	if (CDROM_CONFIG_FLAGS (drive)->drq_interrupt) {
 		/* waiting for CDB interrupt, not DMA yet. */
Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -1067,13 +1067,8 @@ static ide_startstop_t idefloppy_issue_p
 	if (test_bit(PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma)
 		dma = !hwif->dma_setup(drive);
 
-	if (IDE_CONTROL_REG)
-		HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);
-	/* Use PIO/DMA */
-	hwif->OUTB(dma, IDE_FEATURE_REG);
-	hwif->OUTB(bcount & 0xff, IDE_BCOUNTL_REG);
-	hwif->OUTB((bcount >> 8) & 0xff, IDE_BCOUNTH_REG);
-	HWIF(drive)->OUTB(drive->select.all, IDE_SELECT_REG);
+	ide_pktcmd_tf_load(drive, IDE_TFLAG_NO_SELECT_MASK |
+			   IDE_TFLAG_OUT_DEVICE, bcount, dma);
 
 	if (dma) {	/* Begin DMA, if necessary */
 		set_bit(PC_DMA_IN_PROGRESS, &pc->flags);
Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1732,3 +1732,19 @@ int ide_do_drive_cmd (ide_drive_t *drive
 }
 
 EXPORT_SYMBOL(ide_do_drive_cmd);
+
+void ide_pktcmd_tf_load(ide_drive_t *drive, u32 tf_flags, u16 bcount, u8 dma)
+{
+	ide_task_t task;
+
+	memset(&task, 0, sizeof(task));
+	task.tf_flags = IDE_TFLAG_OUT_LBAH | IDE_TFLAG_OUT_LBAM |
+			IDE_TFLAG_OUT_FEATURE | tf_flags;
+	task.tf.feature = dma;		/* Use PIO/DMA */
+	task.tf.lbam    = bcount & 0xff;
+	task.tf.lbah    = (bcount >> 8) & 0xff;
+
+	ide_tf_load(drive, &task);
+}
+
+EXPORT_SYMBOL_GPL(ide_pktcmd_tf_load);
Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -2171,12 +2171,9 @@ static ide_startstop_t idetape_issue_pac
 	if (test_bit(PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma)
 		dma_ok = !hwif->dma_setup(drive);
 
-	if (IDE_CONTROL_REG)
-		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
-	hwif->OUTB(dma_ok ? 1 : 0, IDE_FEATURE_REG);	/* Use PIO/DMA */
-	hwif->OUTB(bcount & 0xff, IDE_BCOUNTL_REG);
-	hwif->OUTB((bcount >> 8) & 0xff, IDE_BCOUNTH_REG);
-	hwif->OUTB(drive->select.all, IDE_SELECT_REG);
+	ide_pktcmd_tf_load(drive, IDE_TFLAG_NO_SELECT_MASK |
+			   IDE_TFLAG_OUT_DEVICE, bcount, dma_ok);
+
 	if (dma_ok)			/* Will begin DMA later */
 		set_bit(PC_DMA_IN_PROGRESS, &pc->flags);
 	if (test_bit(IDETAPE_DRQ_INTERRUPT, &tape->flags)) {
Index: b/drivers/scsi/ide-scsi.c
===================================================================
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -595,12 +595,8 @@ static ide_startstop_t idescsi_issue_pc 
 	}
 
 	SELECT_DRIVE(drive);
-	if (IDE_CONTROL_REG)
-		HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);
 
-	hwif->OUTB(dma, IDE_FEATURE_REG);
-	hwif->OUTB(bcount & 0xff, IDE_BCOUNTL_REG);
-	hwif->OUTB((bcount >> 8) & 0xff, IDE_BCOUNTH_REG);
+	ide_pktcmd_tf_load(drive, IDE_TFLAG_NO_SELECT_MASK, bcount, dma);
 
 	if (dma)
 		set_bit(PC_DMA_OK, &pc->flags);
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -975,6 +975,8 @@ extern void QUIRK_LIST(ide_drive_t *);
 
 extern int drive_is_ready(ide_drive_t *);
 
+void ide_pktcmd_tf_load(ide_drive_t *, u32, u16, u8);
+
 /*
  * taskfile io for disks for now...and builds request from ide_ioctl
  */
