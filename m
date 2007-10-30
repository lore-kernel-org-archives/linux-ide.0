From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/15] ide: remove atapi_ireason_t
Date: Wed, 31 Oct 2007 00:28:27 +0100
Message-ID: <200710310028.27935.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:45624 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbXJ3XuZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 19:50:25 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1788114nfb
        for <linux-ide@vger.kernel.org>; Tue, 30 Oct 2007 16:50:24 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Remove atapi_ireason_t.

While at it:
* replace 'HWIF(drive)' by 'drive->hwif' (or just 'hwif' where possible)

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-floppy.c |   25 ++++++++++++-------------
 drivers/ide/ide-tape.c   |   27 +++++++++++++--------------
 drivers/scsi/ide-scsi.c  |   17 ++++++++---------
 include/linux/ide.h      |   24 ------------------------
 4 files changed, 33 insertions(+), 60 deletions(-)

Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -788,12 +788,11 @@ static ide_startstop_t idefloppy_pc_intr
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	ide_hwif_t *hwif = drive->hwif;
-	atapi_ireason_t ireason;
 	idefloppy_pc_t *pc = floppy->pc;
 	struct request *rq = pc->rq;
 	unsigned int temp;
 	u16 bcount;
-	u8 stat;
+	u8 stat, ireason;
 
 	debug_log(KERN_INFO "ide-floppy: Reached %s interrupt handler\n",
 		__FUNCTION__);
@@ -852,18 +851,18 @@ static ide_startstop_t idefloppy_pc_intr
 	bcount = (hwif->INB(IDE_BCOUNTH_REG) << 8) |
 		  hwif->INB(IDE_BCOUNTL_REG);
 	/* on this interrupt */
-	ireason.all = HWIF(drive)->INB(IDE_IREASON_REG);
+	ireason = hwif->INB(IDE_IREASON_REG);
 
-	if (ireason.b.cod) {
+	if (ireason & 1) {
 		printk(KERN_ERR "ide-floppy: CoD != 0 in idefloppy_pc_intr\n");
 		return ide_do_reset(drive);
 	}
-	if (ireason.b.io == test_bit(PC_WRITING, &pc->flags)) {
+	if ((ireason & 1) == test_bit(PC_WRITING, &pc->flags)) {
 		/* Hopefully, we will never get here */
 		printk(KERN_ERR "ide-floppy: We wanted to %s, ",
-			ireason.b.io ? "Write":"Read");
+				(ireason & 1) ? "Write" : "Read");
 		printk(KERN_ERR "but the floppy wants us to %s !\n",
-			ireason.b.io ? "Read":"Write");
+				(ireason & 1) ? "Read" : "Write");
 		return ide_do_reset(drive);
 	}
 	if (!test_bit(PC_WRITING, &pc->flags)) {
@@ -920,15 +919,15 @@ static ide_startstop_t idefloppy_transfe
 {
 	ide_startstop_t startstop;
 	idefloppy_floppy_t *floppy = drive->driver_data;
-	atapi_ireason_t ireason;
+	u8 ireason;
 
 	if (ide_wait_stat(&startstop, drive, DRQ_STAT, BUSY_STAT, WAIT_READY)) {
 		printk(KERN_ERR "ide-floppy: Strange, packet command "
 				"initiated yet DRQ isn't asserted\n");
 		return startstop;
 	}
-	ireason.all = HWIF(drive)->INB(IDE_IREASON_REG);
-	if (!ireason.b.cod || ireason.b.io) {
+	ireason = drive->hwif->INB(IDE_IREASON_REG);
+	if ((ireason & 2) == 0 || (ireason & 1)) {
 		printk(KERN_ERR "ide-floppy: (IO,CoD) != (0,1) while "
 				"issuing a packet command\n");
 		return ide_do_reset(drive);
@@ -968,15 +967,15 @@ static ide_startstop_t idefloppy_transfe
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	ide_startstop_t startstop;
-	atapi_ireason_t ireason;
+	u8 ireason;
 
 	if (ide_wait_stat(&startstop, drive, DRQ_STAT, BUSY_STAT, WAIT_READY)) {
 		printk(KERN_ERR "ide-floppy: Strange, packet command "
 				"initiated yet DRQ isn't asserted\n");
 		return startstop;
 	}
-	ireason.all = HWIF(drive)->INB(IDE_IREASON_REG);
-	if (!ireason.b.cod || ireason.b.io) {
+	ireason = drive->hwif->INB(IDE_IREASON_REG);
+	if ((ireason & 2) == 0 || (ireason & 1)) {
 		printk(KERN_ERR "ide-floppy: (IO,CoD) != (0,1) "
 				"while issuing a packet command\n");
 		return ide_do_reset(drive);
Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1847,14 +1847,13 @@ static ide_startstop_t idetape_pc_intr (
 {
 	ide_hwif_t *hwif = drive->hwif;
 	idetape_tape_t *tape = drive->driver_data;
-	atapi_ireason_t ireason;
 	idetape_pc_t *pc = tape->pc;
 	unsigned int temp;
 #if SIMULATE_ERRORS
 	static int error_sim_count = 0;
 #endif
 	u16 bcount;
-	u8 stat;
+	u8 stat, ireason;
 
 #if IDETAPE_DEBUG_LOG
 	if (tape->debug_level >= 4)
@@ -1965,18 +1964,18 @@ static ide_startstop_t idetape_pc_intr (
 	bcount = (hwif->INB(IDE_BCOUNTH_REG) << 8) |
 		  hwif->INB(IDE_BCOUNTL_REG);
 
-	ireason.all = hwif->INB(IDE_IREASON_REG);
+	ireason = hwif->INB(IDE_IREASON_REG);
 
-	if (ireason.b.cod) {
+	if (ireason & 2) {
 		printk(KERN_ERR "ide-tape: CoD != 0 in idetape_pc_intr\n");
 		return ide_do_reset(drive);
 	}
-	if (ireason.b.io == test_bit(PC_WRITING, &pc->flags)) {
+	if ((ireason & 1) == test_bit(PC_WRITING, &pc->flags)) {
 		/* Hopefully, we will never get here */
 		printk(KERN_ERR "ide-tape: We wanted to %s, ",
-			ireason.b.io ? "Write":"Read");
+				(ireason & 1) ? "Write" : "Read");
 		printk(KERN_ERR "ide-tape: but the tape wants us to %s !\n",
-			ireason.b.io ? "Read":"Write");
+				(ireason & 1) ? "Read" : "Write");
 		return ide_do_reset(drive);
 	}
 	if (!test_bit(PC_WRITING, &pc->flags)) {
@@ -2070,28 +2069,28 @@ static ide_startstop_t idetape_transfer_
 	ide_hwif_t *hwif = drive->hwif;
 	idetape_tape_t *tape = drive->driver_data;
 	idetape_pc_t *pc = tape->pc;
-	atapi_ireason_t ireason;
 	int retries = 100;
 	ide_startstop_t startstop;
+	u8 ireason;
 
 	if (ide_wait_stat(&startstop,drive,DRQ_STAT,BUSY_STAT,WAIT_READY)) {
 		printk(KERN_ERR "ide-tape: Strange, packet command initiated yet DRQ isn't asserted\n");
 		return startstop;
 	}
-	ireason.all = hwif->INB(IDE_IREASON_REG);
-	while (retries-- && (!ireason.b.cod || ireason.b.io)) {
+	ireason = hwif->INB(IDE_IREASON_REG);
+	while (retries-- && ((ireason & 2) == 0 || (ireason & 1))) {
 		printk(KERN_ERR "ide-tape: (IO,CoD != (0,1) while issuing "
 				"a packet command, retrying\n");
 		udelay(100);
-		ireason.all = hwif->INB(IDE_IREASON_REG);
+		ireason = hwif->INB(IDE_IREASON_REG);
 		if (retries == 0) {
 			printk(KERN_ERR "ide-tape: (IO,CoD != (0,1) while "
 					"issuing a packet command, ignoring\n");
-			ireason.b.cod = 1;
-			ireason.b.io = 0;
+			ireason |= 2;	/* set CoD */
+			ireason &= ~1;	/* clear IO */
 		}
 	}
-	if (!ireason.b.cod || ireason.b.io) {
+	if ((ireason & 2) == 0 || (ireason & 1)) {
 		printk(KERN_ERR "ide-tape: (IO,CoD) != (0,1) while issuing "
 				"a packet command\n");
 		return ide_do_reset(drive);
Index: b/drivers/scsi/ide-scsi.c
===================================================================
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -403,10 +403,9 @@ static ide_startstop_t idescsi_pc_intr (
 	ide_hwif_t *hwif = drive->hwif;
 	idescsi_pc_t *pc = scsi->pc;
 	struct request *rq = pc->rq;
-	atapi_ireason_t ireason;
 	unsigned int temp;
 	u16 bcount;
-	u8 stat;
+	u8 stat, ireason;
 
 #if IDESCSI_DEBUG_LOG
 	printk (KERN_INFO "ide-scsi: Reached idescsi_pc_intr interrupt handler\n");
@@ -444,13 +443,13 @@ static ide_startstop_t idescsi_pc_intr (
 	}
 	bcount = (hwif->INB(IDE_BCOUNTH_REG) << 8) |
 		  hwif->INB(IDE_BCOUNTL_REG);
-	ireason.all	= HWIF(drive)->INB(IDE_IREASON_REG);
+	ireason = hwif->INB(IDE_IREASON_REG);
 
-	if (ireason.b.cod) {
+	if (ireason & 2) {
 		printk(KERN_ERR "ide-scsi: CoD != 0 in idescsi_pc_intr\n");
 		return ide_do_reset (drive);
 	}
-	if (ireason.b.io) {
+	if (ireason & 1) {
 		temp = pc->actually_transferred + bcount;
 		if (temp > pc->request_transfer) {
 			if (temp > pc->buffer_size) {
@@ -479,7 +478,7 @@ static ide_startstop_t idescsi_pc_intr (
 #endif /* IDESCSI_DEBUG_LOG */
 		}
 	}
-	if (ireason.b.io) {
+	if (ireason & 1) {
 		clear_bit(PC_WRITING, &pc->flags);
 		if (pc->sg)
 			idescsi_input_buffers(drive, pc, bcount);
@@ -508,16 +507,16 @@ static ide_startstop_t idescsi_transfer_
 	ide_hwif_t *hwif = drive->hwif;
 	idescsi_scsi_t *scsi = drive_to_idescsi(drive);
 	idescsi_pc_t *pc = scsi->pc;
-	atapi_ireason_t ireason;
 	ide_startstop_t startstop;
+	u8 ireason;
 
 	if (ide_wait_stat(&startstop,drive,DRQ_STAT,BUSY_STAT,WAIT_READY)) {
 		printk(KERN_ERR "ide-scsi: Strange, packet command "
 			"initiated yet DRQ isn't asserted\n");
 		return startstop;
 	}
-	ireason.all	= HWIF(drive)->INB(IDE_IREASON_REG);
-	if (!ireason.b.cod || ireason.b.io) {
+	ireason = hwif->INB(IDE_IREASON_REG);
+	if ((ireason & 2) == 0 || (ireason & 1)) {
 		printk(KERN_ERR "ide-scsi: (IO,CoD) != (0,1) while "
 				"issuing a packet command\n");
 		return ide_do_reset (drive);
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -346,30 +346,6 @@ typedef union {
 } select_t, ata_select_t;
 
 /*
- * ATAPI Interrupt Reason Register.
- *
- * cod		: Information transferred is command (1) or data (0)
- * io		: The device requests us to read (1) or write (0)
- * reserved	: Reserved
- */
-typedef union {
-	unsigned all			:8;
-	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned cod		:1;
-		unsigned io		:1;
-		unsigned reserved	:6;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned reserved	:6;
-		unsigned io		:1;
-		unsigned cod		:1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-	} b;
-} atapi_ireason_t;
-
-/*
  * Status returned from various ide_ functions
  */
 typedef enum {
