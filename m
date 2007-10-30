From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/15] ide: remove ata_status_t and atapi_status_t
Date: Wed, 31 Oct 2007 00:25:04 +0100
Message-ID: <200710310025.04369.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:45663 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196AbXJ3XuU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 19:50:20 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1788122nfb
        for <linux-ide@vger.kernel.org>; Tue, 30 Oct 2007 16:50:18 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Remove ata_status_t (unused) and atapi_status_t.

While at it:
* replace 'HWIF(drive)' by 'drive->hwif' (or just 'hwif' where possible)

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-floppy.c |   14 +++++++-------
 drivers/ide/ide-lib.c    |   21 +++++++++------------
 drivers/ide/ide-tape.c   |   34 +++++++++++++++++-----------------
 drivers/scsi/ide-scsi.c  |    9 ++++-----
 include/linux/ide.h      |   44 --------------------------------------------
 5 files changed, 37 insertions(+), 85 deletions(-)

Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -788,12 +788,12 @@ static void idefloppy_retry_pc (ide_driv
 static ide_startstop_t idefloppy_pc_intr (ide_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
-	atapi_status_t status;
 	atapi_bcount_t bcount;
 	atapi_ireason_t ireason;
 	idefloppy_pc_t *pc = floppy->pc;
 	struct request *rq = pc->rq;
 	unsigned int temp;
+	u8 stat;
 
 	debug_log(KERN_INFO "ide-floppy: Reached %s interrupt handler\n",
 		__FUNCTION__);
@@ -809,16 +809,16 @@ static ide_startstop_t idefloppy_pc_intr
 	}
 
 	/* Clear the interrupt */
-	status.all = HWIF(drive)->INB(IDE_STATUS_REG);
+	stat = drive->hwif->INB(IDE_STATUS_REG);
 
-	if (!status.b.drq) {			/* No more interrupts */
+	if ((stat & DRQ_STAT) == 0) {		/* No more interrupts */
 		debug_log(KERN_INFO "Packet command completed, %d bytes "
 			"transferred\n", pc->actually_transferred);
 		clear_bit(PC_DMA_IN_PROGRESS, &pc->flags);
 
 		local_irq_enable_in_hardirq();
 
-		if (status.b.check || test_bit(PC_DMA_ERROR, &pc->flags)) {
+		if ((stat & ERR_STAT) || test_bit(PC_DMA_ERROR, &pc->flags)) {
 			/* Error detected */
 			debug_log(KERN_INFO "ide-floppy: %s: I/O error\n",
 				drive->name);
@@ -1632,14 +1632,14 @@ static int idefloppy_get_format_progress
 		/* Else assume format_unit has finished, and we're
 		** at 0x10000 */
 	} else {
-		atapi_status_t status;
 		unsigned long flags;
+		u8 stat;
 
 		local_irq_save(flags);
-		status.all = HWIF(drive)->INB(IDE_STATUS_REG);
+		stat = drive->hwif->INB(IDE_STATUS_REG);
 		local_irq_restore(flags);
 
-		progress_indication = !status.b.dsc ? 0 : 0x10000;
+		progress_indication = ((stat & SEEK_STAT) == 0) ? 0 : 0x10000;
 	}
 	if (put_user(progress_indication, arg))
 		return (-EFAULT);
Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -558,27 +558,24 @@ static u8 ide_dump_ata_status(ide_drive_
 static u8 ide_dump_atapi_status(ide_drive_t *drive, const char *msg, u8 stat)
 {
 	unsigned long flags;
-
-	atapi_status_t status;
 	atapi_error_t error;
 
-	status.all = stat;
 	error.all = 0;
 	local_irq_save(flags);
 	printk("%s: %s: status=0x%02x { ", drive->name, msg, stat);
-	if (status.b.bsy)
+	if (stat & BUSY_STAT)
 		printk("Busy ");
 	else {
-		if (status.b.drdy)	printk("DriveReady ");
-		if (status.b.df)	printk("DeviceFault ");
-		if (status.b.dsc)	printk("SeekComplete ");
-		if (status.b.drq)	printk("DataRequest ");
-		if (status.b.corr)	printk("CorrectedError ");
-		if (status.b.idx)	printk("Index ");
-		if (status.b.check)	printk("Error ");
+		if (stat & READY_STAT)	printk("DriveReady ");
+		if (stat & WRERR_STAT)	printk("DeviceFault ");
+		if (stat & SEEK_STAT)	printk("SeekComplete ");
+		if (stat & DRQ_STAT)	printk("DataRequest ");
+		if (stat & ECC_STAT)	printk("CorrectedError ");
+		if (stat & INDEX_STAT)	printk("Index ");
+		if (stat & ERR_STAT)	printk("Error ");
 	}
 	printk("}\n");
-	if (status.b.check && !status.b.bsy) {
+	if ((stat & (BUSY_STAT|ERR_STAT)) == ERR_STAT) {
 		error.all = HWIF(drive)->INB(IDE_ERROR_REG);
 		printk("%s: %s: error=0x%02x { ", drive->name, msg, error.all);
 		if (error.b.ili)	printk("IllegalLengthIndication ");
Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1848,15 +1848,14 @@ static ide_startstop_t idetape_pc_intr (
 {
 	ide_hwif_t *hwif = drive->hwif;
 	idetape_tape_t *tape = drive->driver_data;
-	atapi_status_t status;
 	atapi_bcount_t bcount;
 	atapi_ireason_t ireason;
 	idetape_pc_t *pc = tape->pc;
-
 	unsigned int temp;
 #if SIMULATE_ERRORS
 	static int error_sim_count = 0;
 #endif
+	u8 stat;
 
 #if IDETAPE_DEBUG_LOG
 	if (tape->debug_level >= 4)
@@ -1865,10 +1864,10 @@ static ide_startstop_t idetape_pc_intr (
 #endif /* IDETAPE_DEBUG_LOG */	
 
 	/* Clear the interrupt */
-	status.all = HWIF(drive)->INB(IDE_STATUS_REG);
+	stat = hwif->INB(IDE_STATUS_REG);
 
 	if (test_bit(PC_DMA_IN_PROGRESS, &pc->flags)) {
-		if (HWIF(drive)->ide_dma_end(drive) || status.b.check) {
+		if (hwif->ide_dma_end(drive) || (stat & ERR_STAT)) {
 			/*
 			 * A DMA error is sometimes expected. For example,
 			 * if the tape is crossing a filemark during a
@@ -1902,7 +1901,7 @@ static ide_startstop_t idetape_pc_intr (
 	}
 
 	/* No more interrupts */
-	if (!status.b.drq) {
+	if ((stat & DRQ_STAT) == 0) {
 #if IDETAPE_DEBUG_LOG
 		if (tape->debug_level >= 2)
 			printk(KERN_INFO "ide-tape: Packet command completed, %d bytes transferred\n", pc->actually_transferred);
@@ -1917,12 +1916,13 @@ static ide_startstop_t idetape_pc_intr (
 		    (++error_sim_count % 100) == 0) {
 			printk(KERN_INFO "ide-tape: %s: simulating error\n",
 				tape->name);
-			status.b.check = 1;
+			stat |= ERR_STAT;
 		}
 #endif
-		if (status.b.check && pc->c[0] == IDETAPE_REQUEST_SENSE_CMD)
-			status.b.check = 0;
-		if (status.b.check || test_bit(PC_DMA_ERROR, &pc->flags)) {	/* Error detected */
+		if ((stat & ERR_STAT) && pc->c[0] == IDETAPE_REQUEST_SENSE_CMD)
+			stat &= ~ERR_STAT;
+		if ((stat & ERR_STAT) || test_bit(PC_DMA_ERROR, &pc->flags)) {
+			/* Error detected */
 #if IDETAPE_DEBUG_LOG
 			if (tape->debug_level >= 1)
 				printk(KERN_INFO "ide-tape: %s: I/O error\n",
@@ -1941,7 +1941,7 @@ static ide_startstop_t idetape_pc_intr (
 		}
 		pc->error = 0;
 		if (test_bit(PC_WAIT_FOR_DSC, &pc->flags) &&
-		    !status.b.dsc) {
+		    (stat & SEEK_STAT) == 0) {
 			/* Media access command */
 			tape->dsc_polling_start = jiffies;
 			tape->dsc_polling_frequency = IDETAPE_DSC_MA_FAST;
@@ -2285,11 +2285,11 @@ static ide_startstop_t idetape_media_acc
 {
 	idetape_tape_t *tape = drive->driver_data;
 	idetape_pc_t *pc = tape->pc;
-	atapi_status_t status;
+	u8 stat;
 
-	status.all = HWIF(drive)->INB(IDE_STATUS_REG);
-	if (status.b.dsc) {
-		if (status.b.check) {
+	stat = drive->hwif->INB(IDE_STATUS_REG);
+	if (stat & SEEK_STAT) {
+		if (stat & ERR_STAT) {
 			/* Error detected */
 			if (pc->c[0] != IDETAPE_TEST_UNIT_READY_CMD)
 				printk(KERN_ERR "ide-tape: %s: I/O error, ",
@@ -2407,7 +2407,7 @@ static ide_startstop_t idetape_do_reques
 	idetape_tape_t *tape = drive->driver_data;
 	idetape_pc_t *pc = NULL;
 	struct request *postponed_rq = tape->postponed_rq;
-	atapi_status_t status;
+	u8 stat;
 
 #if IDETAPE_DEBUG_LOG
 #if 0
@@ -2455,7 +2455,7 @@ static ide_startstop_t idetape_do_reques
 	 * If the tape is still busy, postpone our request and service
 	 * the other device meanwhile.
 	 */
-	status.all = HWIF(drive)->INB(IDE_STATUS_REG);
+	stat = drive->hwif->INB(IDE_STATUS_REG);
 
 	if (!drive->dsc_overlap && !(rq->cmd[0] & REQ_IDETAPE_PC2))
 		set_bit(IDETAPE_IGNORE_DSC, &tape->flags);
@@ -2471,7 +2471,7 @@ static ide_startstop_t idetape_do_reques
 		tape->insert_speed = tape->insert_size / 1024 * HZ / (jiffies - tape->insert_time);
 	calculate_speeds(drive);
 	if (!test_and_clear_bit(IDETAPE_IGNORE_DSC, &tape->flags) &&
-	    !status.b.dsc) {
+	    (stat & SEEK_STAT) == 0) {
 		if (postponed_rq == NULL) {
 			tape->dsc_polling_start = jiffies;
 			tape->dsc_polling_frequency = tape->best_dsc_rw_frequency;
Index: b/drivers/scsi/ide-scsi.c
===================================================================
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -403,11 +403,10 @@ static ide_startstop_t idescsi_pc_intr (
 	idescsi_pc_t *pc=scsi->pc;
 	struct request *rq = pc->rq;
 	atapi_bcount_t bcount;
-	atapi_status_t status;
 	atapi_ireason_t ireason;
 	atapi_feature_t feature;
-
 	unsigned int temp;
+	u8 stat;
 
 #if IDESCSI_DEBUG_LOG
 	printk (KERN_INFO "ide-scsi: Reached idescsi_pc_intr interrupt handler\n");
@@ -432,14 +431,14 @@ static ide_startstop_t idescsi_pc_intr (
 
 	feature.all = 0;
 	/* Clear the interrupt */
-	status.all = HWIF(drive)->INB(IDE_STATUS_REG);
+	stat = drive->hwif->INB(IDE_STATUS_REG);
 
-	if (!status.b.drq) {
+	if ((stat & DRQ_STAT) == 0) {
 		/* No more interrupts */
 		if (test_bit(IDESCSI_LOG_CMD, &scsi->log))
 			printk (KERN_INFO "Packet command completed, %d bytes transferred\n", pc->actually_transferred);
 		local_irq_enable_in_hardirq();
-		if (status.b.check)
+		if (stat & ERR_STAT)
 			rq->errors++;
 		idescsi_end_request (drive, 1, 0);
 		return ide_stopped;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -366,50 +366,6 @@ typedef union {
 } select_t, ata_select_t;
 
 /*
- * The ATA-IDE Status Register.
- * The ATAPI Status Register.
- *
- * check	: Error occurred
- * idx		: Index Error
- * corr		: Correctable error occurred
- * drq		: Data is request by the device
- * dsc		: Disk Seek Complete			: ata
- *		: Media access command finished		: atapi
- * df		: Device Fault				: ata
- *		: Reserved				: atapi
- * drdy		: Ready, Command Mode Capable		: ata
- *		: Ignored for ATAPI commands		: atapi
- * bsy		: Disk is Busy
- *		: The device has access to the command block
- */
-typedef union {
-	unsigned all			:8;
-	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned check		:1;
-		unsigned idx		:1;
-		unsigned corr		:1;
-		unsigned drq		:1;
-		unsigned dsc		:1;
-		unsigned df		:1;
-		unsigned drdy		:1;
-		unsigned bsy		:1;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned bsy		:1;
-		unsigned drdy		:1;
-		unsigned df		:1;
-		unsigned dsc		:1;
-		unsigned drq		:1;
-		unsigned corr           :1;
-		unsigned idx		:1;
-		unsigned check		:1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-	} b;
-} ata_status_t, atapi_status_t;
-
-/*
  * ATAPI Feature Register
  *
  * dma		: Using DMA or PIO
