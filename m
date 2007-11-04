From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 9/18] ide: kill duplicate code in ide_dump_{ata,atapi}_status()
Date: Mon, 5 Nov 2007 00:23:56 +0100
Message-ID: <200711050023.56112.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:53675 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163AbXKDX3l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Nov 2007 18:29:41 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1219918nfb
        for <linux-ide@vger.kernel.org>; Sun, 04 Nov 2007 15:29:40 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Move the common code from ide_dump_{ata,atapi}_status() to
  ide_dump_status().

* ide_dump_{ata,atapi}_status() -> ide_dump_{ata,atapi}_error().

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-lib.c |  105 +++++++++++++++++---------------------------------
 1 file changed, 37 insertions(+), 68 deletions(-)

Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -513,61 +513,51 @@ static void ide_dump_sector(ide_drive_t 
 					 tf->device & 0xf, tf->lbal);
 }
 
-static u8 ide_dump_ata_status(ide_drive_t *drive, const char *msg, u8 stat)
+static void ide_dump_ata_error(ide_drive_t *drive, u8 err)
 {
-	ide_hwif_t *hwif = HWIF(drive);
-	unsigned long flags;
-	u8 err = 0;
-
-	local_irq_save(flags);
-	printk("%s: %s: status=0x%02x { ", drive->name, msg, stat);
-	if (stat & BUSY_STAT)
-		printk("Busy ");
-	else {
-		if (stat & READY_STAT)	printk("DriveReady ");
-		if (stat & WRERR_STAT)	printk("DeviceFault ");
-		if (stat & SEEK_STAT)	printk("SeekComplete ");
-		if (stat & DRQ_STAT)	printk("DataRequest ");
-		if (stat & ECC_STAT)	printk("CorrectedError ");
-		if (stat & INDEX_STAT)	printk("Index ");
-		if (stat & ERR_STAT)	printk("Error ");
+	printk("{ ");
+	if (err & ABRT_ERR)	printk("DriveStatusError ");
+	if (err & ICRC_ERR)
+		printk((err & ABRT_ERR) ? "BadCRC " : "BadSector ");
+	if (err & ECC_ERR)	printk("UncorrectableError ");
+	if (err & ID_ERR)	printk("SectorIdNotFound ");
+	if (err & TRK0_ERR)	printk("TrackZeroNotFound ");
+	if (err & MARK_ERR)	printk("AddrMarkNotFound ");
+	printk("}");
+	if ((err & (BBD_ERR | ABRT_ERR)) == BBD_ERR ||
+	    (err & (ECC_ERR|ID_ERR|MARK_ERR))) {
+		ide_dump_sector(drive);
+		if (HWGROUP(drive) && HWGROUP(drive)->rq)
+			printk(", sector=%llu",
+			       (unsigned long long)HWGROUP(drive)->rq->sector);
 	}
+	printk("\n");
+}
+
+static void ide_dump_atapi_error(ide_drive_t *drive, u8 err)
+{
+	printk("{ ");
+	if (err & ILI_ERR)	printk("IllegalLengthIndication ");
+	if (err & EOM_ERR)	printk("EndOfMedia ");
+	if (err & ABRT_ERR)	printk("AbortedCommand ");
+	if (err & MCR_ERR)	printk("MediaChangeRequested ");
+	if (err & LFS_ERR)	printk("LastFailedSense=0x%02x ",
+				       (err & LFS_ERR) >> 4);
 	printk("}\n");
-	if ((stat & (BUSY_STAT|ERR_STAT)) == ERR_STAT) {
-		err = hwif->INB(IDE_ERROR_REG);
-		printk("%s: %s: error=0x%02x { ", drive->name, msg, err);
-		if (err & ABRT_ERR)	printk("DriveStatusError ");
-		if (err & ICRC_ERR)
-			printk((err & ABRT_ERR) ? "BadCRC " : "BadSector ");
-		if (err & ECC_ERR)	printk("UncorrectableError ");
-		if (err & ID_ERR)	printk("SectorIdNotFound ");
-		if (err & TRK0_ERR)	printk("TrackZeroNotFound ");
-		if (err & MARK_ERR)	printk("AddrMarkNotFound ");
-		printk("}");
-		if ((err & (BBD_ERR | ABRT_ERR)) == BBD_ERR ||
-		    (err & (ECC_ERR|ID_ERR|MARK_ERR))) {
-			ide_dump_sector(drive);
-			if (HWGROUP(drive) && HWGROUP(drive)->rq)
-				printk(", sector=%llu",
-					(unsigned long long)HWGROUP(drive)->rq->sector);
-		}
-		printk("\n");
-	}
-	ide_dump_opcode(drive);
-	local_irq_restore(flags);
-	return err;
 }
 
 /**
- *	ide_dump_atapi_status       -       print human readable atapi status
+ *	ide_dump_status		-	translate ATA/ATAPI error
  *	@drive: drive that status applies to
  *	@msg: text message to print
  *	@stat: status byte to decode
  *
  *	Error reporting, in human readable form (luxurious, but a memory hog).
+ *	Combines the drive name, message and status byte to provide a
+ *	user understandable explanation of the device error.
  */
 
-static u8 ide_dump_atapi_status(ide_drive_t *drive, const char *msg, u8 stat)
+u8 ide_dump_status(ide_drive_t *drive, const char *msg, u8 stat)
 {
 	unsigned long flags;
 	u8 err = 0;
@@ -588,36 +578,15 @@ static u8 ide_dump_atapi_status(ide_driv
 	printk("}\n");
 	if ((stat & (BUSY_STAT|ERR_STAT)) == ERR_STAT) {
 		err = drive->hwif->INB(IDE_ERROR_REG);
-		printk("%s: %s: error=0x%02x { ", drive->name, msg, err);
-		if (err & ILI_ERR)	printk("IllegalLengthIndication ");
-		if (err & EOM_ERR)	printk("EndOfMedia ");
-		if (err & ABRT_ERR)	printk("AbortedCommand ");
-		if (err & MCR_ERR)	printk("MediaChangeRequested ");
-		if (err & LFS_ERR)	printk("LastFailedSense=0x%02x ",
-						(err & LFS_ERR) >> 4);
-		printk("}\n");
+		printk("%s: %s: error=0x%02x ", drive->name, msg, err);
+		if (drive->media == ide_disk)
+			ide_dump_ata_error(drive, err);
+		else
+			ide_dump_atapi_error(drive, err);
 	}
 	ide_dump_opcode(drive);
 	local_irq_restore(flags);
 	return err;
 }
 
-/**
- *	ide_dump_status		-	translate ATA/ATAPI error
- *	@drive: drive the error occured on
- *	@msg: information string
- *	@stat: status byte
- *
- *	Error reporting, in human readable form (luxurious, but a memory hog).
- *	Combines the drive name, message and status byte to provide a
- *	user understandable explanation of the device error.
- */
-
-u8 ide_dump_status(ide_drive_t *drive, const char *msg, u8 stat)
-{
-	if (drive->media == ide_disk)
-		return ide_dump_ata_status(drive, msg, stat);
-	return ide_dump_atapi_status(drive, msg, stat);
-}
-
 EXPORT_SYMBOL(ide_dump_status);
