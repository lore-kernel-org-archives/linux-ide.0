From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/15] ide: remove ata_nsector_t, ata_data_t and atapi_bcount_t
Date: Wed, 31 Oct 2007 00:27:27 +0100
Message-ID: <200710310027.27423.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:45663 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196AbXJ3XuY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 19:50:24 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1788122nfb
        for <linux-ide@vger.kernel.org>; Tue, 30 Oct 2007 16:50:23 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Remove ata_nsector_t, ata_data_t (unused) and atapi_bcount_t.

While at it:
* replace 'HWIF(drive)' by 'hwif'

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c   |   12 +++++-------
 drivers/ide/ide-floppy.c |   37 ++++++++++++++++++-------------------
 drivers/ide/ide-tape.c   |   35 +++++++++++++++++++----------------
 drivers/scsi/ide-scsi.c  |   40 +++++++++++++++++++++++-----------------
 include/linux/ide.h      |   20 --------------------
 5 files changed, 65 insertions(+), 79 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -163,14 +163,12 @@ static ide_startstop_t __ide_do_rw_disk(
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	unsigned int dma	= drive->using_dma;
+	u16 nsectors		= (u16)rq->nr_sectors;
 	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
 	u8 command		= WIN_NOP;
-	ata_nsector_t		nsectors;
 	ide_task_t		task;
 	struct ide_taskfile	*tf = &task.tf;
 
-	nsectors.all		= (u16) rq->nr_sectors;
-
 	if ((hwif->host_flags & IDE_HFLAG_NO_LBA48_DMA) && lba48 && dma) {
 		if (block + rq->nr_sectors > 1ULL << 28)
 			dma = 0;
@@ -192,14 +190,14 @@ static ide_startstop_t __ide_do_rw_disk(
 			pr_debug("%s: LBA=0x%012llx\n", drive->name,
 					(unsigned long long)block);
 
-			tf->hob_nsect = nsectors.b.high;
+			tf->hob_nsect = (nsectors >> 8) & 0xff;
 			tf->hob_lbal  = (u8)(block >> 24);
 			if (sizeof(block) != 4) {
 				tf->hob_lbam = (u8)((u64)block >> 32);
 				tf->hob_lbah = (u8)((u64)block >> 40);
 			}
 
-			tf->nsect  = nsectors.b.low;
+			tf->nsect  = nsectors & 0xff;
 			tf->lbal   = (u8) block;
 			tf->lbam   = (u8)(block >>  8);
 			tf->lbah   = (u8)(block >> 16);
@@ -211,7 +209,7 @@ static ide_startstop_t __ide_do_rw_disk(
 #endif
 			task.tf_flags |= (IDE_TFLAG_LBA48 | IDE_TFLAG_OUT_HOB);
 		} else {
-			tf->nsect  = nsectors.b.low;
+			tf->nsect  = nsectors & 0xff;
 			tf->lbal   = block;
 			tf->lbam   = block >>= 8;
 			tf->lbah   = block >>= 8;
@@ -226,7 +224,7 @@ static ide_startstop_t __ide_do_rw_disk(
 
 		pr_debug("%s: CHS=%u/%u/%u\n", drive->name, cyl, head, sect);
 
-		tf->nsect  = nsectors.b.low;
+		tf->nsect  = nsectors & 0xff;
 		tf->lbal   = sect;
 		tf->lbam   = cyl;
 		tf->lbah   = cyl >> 8;
Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -787,11 +787,12 @@ static void idefloppy_retry_pc (ide_driv
 static ide_startstop_t idefloppy_pc_intr (ide_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
-	atapi_bcount_t bcount;
+	ide_hwif_t *hwif = drive->hwif;
 	atapi_ireason_t ireason;
 	idefloppy_pc_t *pc = floppy->pc;
 	struct request *rq = pc->rq;
 	unsigned int temp;
+	u16 bcount;
 	u8 stat;
 
 	debug_log(KERN_INFO "ide-floppy: Reached %s interrupt handler\n",
@@ -848,8 +849,8 @@ static ide_startstop_t idefloppy_pc_intr
 	}
 
 	/* Get the number of bytes to transfer */
-	bcount.b.high = HWIF(drive)->INB(IDE_BCOUNTH_REG);
-	bcount.b.low = HWIF(drive)->INB(IDE_BCOUNTL_REG);
+	bcount = (hwif->INB(IDE_BCOUNTH_REG) << 8) |
+		  hwif->INB(IDE_BCOUNTL_REG);
 	/* on this interrupt */
 	ireason.all = HWIF(drive)->INB(IDE_IREASON_REG);
 
@@ -867,13 +868,13 @@ static ide_startstop_t idefloppy_pc_intr
 	}
 	if (!test_bit(PC_WRITING, &pc->flags)) {
 		/* Reading - Check that we have enough space */
-		temp = pc->actually_transferred + bcount.all;
+		temp = pc->actually_transferred + bcount;
 		if (temp > pc->request_transfer) {
 			if (temp > pc->buffer_size) {
 				printk(KERN_ERR "ide-floppy: The floppy wants "
 					"to send us more data than expected "
 					"- discarding data\n");
-				idefloppy_discard_data(drive,bcount.all);
+				idefloppy_discard_data(drive, bcount);
 				BUG_ON(HWGROUP(drive)->handler != NULL);
 				ide_set_handler(drive,
 						&idefloppy_pc_intr,
@@ -889,23 +890,21 @@ static ide_startstop_t idefloppy_pc_intr
 	if (test_bit(PC_WRITING, &pc->flags)) {
 		if (pc->buffer != NULL)
 			/* Write the current buffer */
-			HWIF(drive)->atapi_output_bytes(drive,
-						pc->current_position,
-						bcount.all);
+			hwif->atapi_output_bytes(drive, pc->current_position,
+						 bcount);
 		else
-			idefloppy_output_buffers(drive, pc, bcount.all);
+			idefloppy_output_buffers(drive, pc, bcount);
 	} else {
 		if (pc->buffer != NULL)
 			/* Read the current buffer */
-			HWIF(drive)->atapi_input_bytes(drive,
-						pc->current_position,
-						bcount.all);
+			hwif->atapi_input_bytes(drive, pc->current_position,
+						bcount);
 		else
-			idefloppy_input_buffers(drive, pc, bcount.all);
+			idefloppy_input_buffers(drive, pc, bcount);
 	}
 	/* Update the current position */
-	pc->actually_transferred += bcount.all;
-	pc->current_position += bcount.all;
+	pc->actually_transferred += bcount;
+	pc->current_position += bcount;
 
 	BUG_ON(HWGROUP(drive)->handler != NULL);
 	ide_set_handler(drive, &idefloppy_pc_intr, IDEFLOPPY_WAIT_CMD, NULL);		/* And set the interrupt handler again */
@@ -1019,8 +1018,8 @@ static ide_startstop_t idefloppy_issue_p
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	ide_hwif_t *hwif = drive->hwif;
-	atapi_bcount_t bcount;
 	ide_handler_t *pkt_xfer_routine;
+	u16 bcount;
 	u8 dma;
 
 	if (floppy->failed_pc == NULL &&
@@ -1059,7 +1058,7 @@ static ide_startstop_t idefloppy_issue_p
 	/* We haven't transferred any data yet */
 	pc->actually_transferred = 0;
 	pc->current_position = pc->buffer;
-	bcount.all = min(pc->request_transfer, 63 * 1024);
+	bcount = min(pc->request_transfer, 63 * 1024);
 
 	if (test_and_clear_bit(PC_DMA_ERROR, &pc->flags))
 		ide_dma_off(drive);
@@ -1073,8 +1072,8 @@ static ide_startstop_t idefloppy_issue_p
 		HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);
 	/* Use PIO/DMA */
 	hwif->OUTB(dma, IDE_FEATURE_REG);
-	HWIF(drive)->OUTB(bcount.b.high, IDE_BCOUNTH_REG);
-	HWIF(drive)->OUTB(bcount.b.low, IDE_BCOUNTL_REG);
+	hwif->OUTB((bcount >> 8) & 0xff, IDE_BCOUNTH_REG);
+	hwif->OUTB(bcount & 0xff, IDE_BCOUNTL_REG);
 	HWIF(drive)->OUTB(drive->select.all, IDE_SELECT_REG);
 
 	if (dma) {	/* Begin DMA, if necessary */
Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1847,13 +1847,13 @@ static ide_startstop_t idetape_pc_intr (
 {
 	ide_hwif_t *hwif = drive->hwif;
 	idetape_tape_t *tape = drive->driver_data;
-	atapi_bcount_t bcount;
 	atapi_ireason_t ireason;
 	idetape_pc_t *pc = tape->pc;
 	unsigned int temp;
 #if SIMULATE_ERRORS
 	static int error_sim_count = 0;
 #endif
+	u16 bcount;
 	u8 stat;
 
 #if IDETAPE_DEBUG_LOG
@@ -1962,8 +1962,8 @@ static ide_startstop_t idetape_pc_intr (
 		return ide_do_reset(drive);
 	}
 	/* Get the number of bytes to transfer on this interrupt. */
-	bcount.b.high = hwif->INB(IDE_BCOUNTH_REG);
-	bcount.b.low = hwif->INB(IDE_BCOUNTL_REG);
+	bcount = (hwif->INB(IDE_BCOUNTH_REG) << 8) |
+		  hwif->INB(IDE_BCOUNTL_REG);
 
 	ireason.all = hwif->INB(IDE_IREASON_REG);
 
@@ -1981,11 +1981,11 @@ static ide_startstop_t idetape_pc_intr (
 	}
 	if (!test_bit(PC_WRITING, &pc->flags)) {
 		/* Reading - Check that we have enough space */
-		temp = pc->actually_transferred + bcount.all;
+		temp = pc->actually_transferred + bcount;
 		if (temp > pc->request_transfer) {
 			if (temp > pc->buffer_size) {
 				printk(KERN_ERR "ide-tape: The tape wants to send us more data than expected - discarding data\n");
-				idetape_discard_data(drive, bcount.all);
+				idetape_discard_data(drive, bcount);
 				ide_set_handler(drive, &idetape_pc_intr, IDETAPE_WAIT_CMD, NULL);
 				return ide_started;
 			}
@@ -1997,23 +1997,26 @@ static ide_startstop_t idetape_pc_intr (
 	}
 	if (test_bit(PC_WRITING, &pc->flags)) {
 		if (pc->bh != NULL)
-			idetape_output_buffers(drive, pc, bcount.all);
+			idetape_output_buffers(drive, pc, bcount);
 		else
 			/* Write the current buffer */
-			HWIF(drive)->atapi_output_bytes(drive, pc->current_position, bcount.all);
+			hwif->atapi_output_bytes(drive, pc->current_position,
+						 bcount);
 	} else {
 		if (pc->bh != NULL)
-			idetape_input_buffers(drive, pc, bcount.all);
+			idetape_input_buffers(drive, pc, bcount);
 		else
 			/* Read the current buffer */
-			HWIF(drive)->atapi_input_bytes(drive, pc->current_position, bcount.all);
+			hwif->atapi_input_bytes(drive, pc->current_position,
+						bcount);
 	}
 	/* Update the current position */
-	pc->actually_transferred += bcount.all;
-	pc->current_position += bcount.all;
+	pc->actually_transferred += bcount;
+	pc->current_position += bcount;
 #if IDETAPE_DEBUG_LOG
 	if (tape->debug_level >= 2)
-		printk(KERN_INFO "ide-tape: [cmd %x] transferred %d bytes on that interrupt\n", pc->c[0], bcount.all);
+		printk(KERN_INFO "ide-tape: [cmd %x] transferred %d bytes "
+				 "on that interrupt\n", pc->c[0], bcount);
 #endif
 	/* And set the interrupt handler again */
 	ide_set_handler(drive, &idetape_pc_intr, IDETAPE_WAIT_CMD, NULL);
@@ -2109,8 +2112,8 @@ static ide_startstop_t idetape_issue_pac
 {
 	ide_hwif_t *hwif = drive->hwif;
 	idetape_tape_t *tape = drive->driver_data;
-	atapi_bcount_t bcount;
 	int dma_ok = 0;
+	u16 bcount;
 
 #if IDETAPE_DEBUG_BUGS
 	if (tape->pc->c[0] == IDETAPE_REQUEST_SENSE_CMD &&
@@ -2159,7 +2162,7 @@ static ide_startstop_t idetape_issue_pac
 	pc->actually_transferred = 0;
 	pc->current_position = pc->buffer;
 	/* Request to transfer the entire buffer at once */
-	bcount.all = pc->request_transfer;
+	bcount = pc->request_transfer;
 
 	if (test_and_clear_bit(PC_DMA_ERROR, &pc->flags)) {
 		printk(KERN_WARNING "ide-tape: DMA disabled, "
@@ -2172,8 +2175,8 @@ static ide_startstop_t idetape_issue_pac
 	if (IDE_CONTROL_REG)
 		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
 	hwif->OUTB(dma_ok ? 1 : 0, IDE_FEATURE_REG);	/* Use PIO/DMA */
-	hwif->OUTB(bcount.b.high, IDE_BCOUNTH_REG);
-	hwif->OUTB(bcount.b.low, IDE_BCOUNTL_REG);
+	hwif->OUTB((bcount >> 8) & 0xff, IDE_BCOUNTH_REG);
+	hwif->OUTB(bcount & 0xff, IDE_BCOUNTL_REG);
 	hwif->OUTB(drive->select.all, IDE_SELECT_REG);
 	if (dma_ok)			/* Will begin DMA later */
 		set_bit(PC_DMA_IN_PROGRESS, &pc->flags);
Index: b/drivers/scsi/ide-scsi.c
===================================================================
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -400,11 +400,12 @@ static int idescsi_expiry(ide_drive_t *d
 static ide_startstop_t idescsi_pc_intr (ide_drive_t *drive)
 {
 	idescsi_scsi_t *scsi = drive_to_idescsi(drive);
-	idescsi_pc_t *pc=scsi->pc;
+	ide_hwif_t *hwif = drive->hwif;
+	idescsi_pc_t *pc = scsi->pc;
 	struct request *rq = pc->rq;
-	atapi_bcount_t bcount;
 	atapi_ireason_t ireason;
 	unsigned int temp;
+	u16 bcount;
 	u8 stat;
 
 #if IDESCSI_DEBUG_LOG
@@ -441,8 +442,8 @@ static ide_startstop_t idescsi_pc_intr (
 		idescsi_end_request (drive, 1, 0);
 		return ide_stopped;
 	}
-	bcount.b.low	= HWIF(drive)->INB(IDE_BCOUNTL_REG);
-	bcount.b.high	= HWIF(drive)->INB(IDE_BCOUNTH_REG);
+	bcount = (hwif->INB(IDE_BCOUNTH_REG) << 8) |
+		  hwif->INB(IDE_BCOUNTL_REG);
 	ireason.all	= HWIF(drive)->INB(IDE_IREASON_REG);
 
 	if (ireason.b.cod) {
@@ -450,7 +451,7 @@ static ide_startstop_t idescsi_pc_intr (
 		return ide_do_reset (drive);
 	}
 	if (ireason.b.io) {
-		temp = pc->actually_transferred + bcount.all;
+		temp = pc->actually_transferred + bcount;
 		if (temp > pc->request_transfer) {
 			if (temp > pc->buffer_size) {
 				printk(KERN_ERR "ide-scsi: The scsi wants to "
@@ -463,11 +464,13 @@ static ide_startstop_t idescsi_pc_intr (
 						idescsi_input_buffers(drive, pc, temp);
 					else
 						drive->hwif->atapi_input_bytes(drive, pc->current_position, temp);
-					printk(KERN_ERR "ide-scsi: transferred %d of %d bytes\n", temp, bcount.all);
+					printk(KERN_ERR "ide-scsi: transferred"
+							" %d of %d bytes\n",
+							temp, bcount);
 				}
 				pc->actually_transferred += temp;
 				pc->current_position += temp;
-				idescsi_discard_data(drive, bcount.all - temp);
+				idescsi_discard_data(drive, bcount - temp);
 				ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), idescsi_expiry);
 				return ide_started;
 			}
@@ -479,19 +482,21 @@ static ide_startstop_t idescsi_pc_intr (
 	if (ireason.b.io) {
 		clear_bit(PC_WRITING, &pc->flags);
 		if (pc->sg)
-			idescsi_input_buffers(drive, pc, bcount.all);
+			idescsi_input_buffers(drive, pc, bcount);
 		else
-			HWIF(drive)->atapi_input_bytes(drive, pc->current_position, bcount.all);
+			hwif->atapi_input_bytes(drive, pc->current_position,
+						bcount);
 	} else {
 		set_bit(PC_WRITING, &pc->flags);
 		if (pc->sg)
-			idescsi_output_buffers (drive, pc, bcount.all);
+			idescsi_output_buffers(drive, pc, bcount);
 		else
-			HWIF(drive)->atapi_output_bytes(drive, pc->current_position, bcount.all);
+			hwif->atapi_output_bytes(drive, pc->current_position,
+						 bcount);
 	}
 	/* Update the current position */
-	pc->actually_transferred += bcount.all;
-	pc->current_position += bcount.all;
+	pc->actually_transferred += bcount;
+	pc->current_position += bcount;
 
 	/* And set the interrupt handler again */
 	ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), idescsi_expiry);
@@ -575,13 +580,14 @@ static ide_startstop_t idescsi_issue_pc 
 {
 	idescsi_scsi_t *scsi = drive_to_idescsi(drive);
 	ide_hwif_t *hwif = drive->hwif;
-	atapi_bcount_t bcount;
+	u16 bcount;
 	u8 dma = 0;
 
 	scsi->pc=pc;							/* Set the current packet command */
 	pc->actually_transferred=0;					/* We haven't transferred any data yet */
 	pc->current_position=pc->buffer;
-	bcount.all = min(pc->request_transfer, 63 * 1024);		/* Request to transfer the entire buffer at once */
+	/* Request to transfer the entire buffer at once */
+	bcount = min(pc->request_transfer, 63 * 1024);
 
 	if (drive->using_dma && !idescsi_map_sg(drive, pc)) {
 		hwif->sg_mapped = 1;
@@ -594,8 +600,8 @@ static ide_startstop_t idescsi_issue_pc 
 		HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);
 
 	hwif->OUTB(dma, IDE_FEATURE_REG);
-	HWIF(drive)->OUTB(bcount.b.high, IDE_BCOUNTH_REG);
-	HWIF(drive)->OUTB(bcount.b.low, IDE_BCOUNTL_REG);
+	hwif->OUTB((bcount >> 8) & 0xff, IDE_BCOUNTH_REG);
+	hwif->OUTB(bcount & 0xff, IDE_BCOUNTL_REG);
 
 	if (dma)
 		set_bit(PC_DMA_OK, &pc->flags);
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -316,26 +316,6 @@ typedef union {
 } special_t;
 
 /*
- * ATA DATA Register Special.
- * ATA NSECTOR Count Register().
- * ATAPI Byte Count Register.
- */
-typedef union {
-	unsigned all			:16;
-	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned low		:8;	/* LSB */
-		unsigned high		:8;	/* MSB */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned high		:8;	/* MSB */
-		unsigned low		:8;	/* LSB */
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-	} b;
-} ata_nsector_t, ata_data_t, atapi_bcount_t;
-
-/*
  * ATA-IDE Select Register, aka Device-Head
  *
  * head		: always zeros here
