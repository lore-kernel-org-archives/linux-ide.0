From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/15] ide: remove atapi_feature_t
Date: Wed, 31 Oct 2007 00:26:44 +0100
Message-ID: <200710310026.44486.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:45723 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbXJ3XuW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 19:50:22 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1788117nfb
        for <linux-ide@vger.kernel.org>; Tue, 30 Oct 2007 16:50:21 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Remove atapi_feature_t.

While at it:
* replace 'HWIF(drive)' by 'hwif'

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-floppy.c |   10 +++++-----
 drivers/scsi/ide-scsi.c  |   11 ++++-------
 include/linux/ide.h      |   27 ---------------------------
 3 files changed, 9 insertions(+), 39 deletions(-)

Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -1019,9 +1019,9 @@ static ide_startstop_t idefloppy_issue_p
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	ide_hwif_t *hwif = drive->hwif;
-	atapi_feature_t feature;
 	atapi_bcount_t bcount;
 	ide_handler_t *pkt_xfer_routine;
+	u8 dma;
 
 	if (floppy->failed_pc == NULL &&
 	    pc->c[0] != IDEFLOPPY_REQUEST_SENSE_CMD)
@@ -1064,20 +1064,20 @@ static ide_startstop_t idefloppy_issue_p
 	if (test_and_clear_bit(PC_DMA_ERROR, &pc->flags))
 		ide_dma_off(drive);
 
-	feature.all = 0;
+	dma = 0;
 
 	if (test_bit(PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma)
-		feature.b.dma = !hwif->dma_setup(drive);
+		dma = !hwif->dma_setup(drive);
 
 	if (IDE_CONTROL_REG)
 		HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);
 	/* Use PIO/DMA */
-	HWIF(drive)->OUTB(feature.all, IDE_FEATURE_REG);
+	hwif->OUTB(dma, IDE_FEATURE_REG);
 	HWIF(drive)->OUTB(bcount.b.high, IDE_BCOUNTH_REG);
 	HWIF(drive)->OUTB(bcount.b.low, IDE_BCOUNTL_REG);
 	HWIF(drive)->OUTB(drive->select.all, IDE_SELECT_REG);
 
-	if (feature.b.dma) {	/* Begin DMA, if necessary */
+	if (dma) {	/* Begin DMA, if necessary */
 		set_bit(PC_DMA_IN_PROGRESS, &pc->flags);
 		hwif->dma_start(drive);
 	}
Index: b/drivers/scsi/ide-scsi.c
===================================================================
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -404,7 +404,6 @@ static ide_startstop_t idescsi_pc_intr (
 	struct request *rq = pc->rq;
 	atapi_bcount_t bcount;
 	atapi_ireason_t ireason;
-	atapi_feature_t feature;
 	unsigned int temp;
 	u8 stat;
 
@@ -429,7 +428,6 @@ static ide_startstop_t idescsi_pc_intr (
 		(void) HWIF(drive)->ide_dma_end(drive);
 	}
 
-	feature.all = 0;
 	/* Clear the interrupt */
 	stat = drive->hwif->INB(IDE_STATUS_REG);
 
@@ -577,18 +575,17 @@ static ide_startstop_t idescsi_issue_pc 
 {
 	idescsi_scsi_t *scsi = drive_to_idescsi(drive);
 	ide_hwif_t *hwif = drive->hwif;
-	atapi_feature_t feature;
 	atapi_bcount_t bcount;
+	u8 dma = 0;
 
 	scsi->pc=pc;							/* Set the current packet command */
 	pc->actually_transferred=0;					/* We haven't transferred any data yet */
 	pc->current_position=pc->buffer;
 	bcount.all = min(pc->request_transfer, 63 * 1024);		/* Request to transfer the entire buffer at once */
 
-	feature.all = 0;
 	if (drive->using_dma && !idescsi_map_sg(drive, pc)) {
 		hwif->sg_mapped = 1;
-		feature.b.dma = !hwif->dma_setup(drive);
+		dma = !hwif->dma_setup(drive);
 		hwif->sg_mapped = 0;
 	}
 
@@ -596,11 +593,11 @@ static ide_startstop_t idescsi_issue_pc 
 	if (IDE_CONTROL_REG)
 		HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);
 
-	HWIF(drive)->OUTB(feature.all, IDE_FEATURE_REG);
+	hwif->OUTB(dma, IDE_FEATURE_REG);
 	HWIF(drive)->OUTB(bcount.b.high, IDE_BCOUNTH_REG);
 	HWIF(drive)->OUTB(bcount.b.low, IDE_BCOUNTL_REG);
 
-	if (feature.b.dma)
+	if (dma)
 		set_bit(PC_DMA_OK, &pc->flags);
 
 	if (test_bit(IDESCSI_DRQ_INTERRUPT, &scsi->flags)) {
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -366,33 +366,6 @@ typedef union {
 } select_t, ata_select_t;
 
 /*
- * ATAPI Feature Register
- *
- * dma		: Using DMA or PIO
- * reserved321	: Reserved
- * reserved654	: Reserved (Tag Type)
- * reserved7	: Reserved
- */
-typedef union {
-	unsigned all			:8;
-	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned dma		:1;
-		unsigned reserved321	:3;
-		unsigned reserved654	:3;
-		unsigned reserved7	:1;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned reserved7	:1;
-		unsigned reserved654	:3;
-		unsigned reserved321	:3;
-		unsigned dma		:1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-	} b;
-} atapi_feature_t;
-
-/*
  * ATAPI Interrupt Reason Register.
  *
  * cod		: Information transferred is command (1) or data (0)
