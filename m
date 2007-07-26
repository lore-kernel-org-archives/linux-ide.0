From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] icside: use ide_tune_dma()
Date: Thu, 26 Jul 2007 21:54:46 +0200
Message-ID: <200707262154.46144.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:63144 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936215AbXGZT74 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jul 2007 15:59:56 -0400
Received: by ug-out-1314.google.com with SMTP id j3so591347ugf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jul 2007 12:59:56 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>


* Add "good DMA drives" hack for icside to ide-dma.c::ide_find_dma_mode()
  (in the long-term it should be either removed or generalized for all hosts).

* Use ide_tune_dma() in icside.c::icside_dma_check().

  This results in the following changes in behavior:
  - pre-EIDE SWDMA modes are now also respected
  - drive->autodma is checked instead of hwif->autodma
    (doesn't really matter as icside sets both to "1")

* Make ide-dma.c::__ide_dma_good_drive() static and drop "__" prefix.

Cc: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/icside.c |   37 +++----------------------------------
 drivers/ide/ide-dma.c    |   23 ++++++++++++++---------
 include/linux/ide.h      |    1 -
 3 files changed, 17 insertions(+), 44 deletions(-)

Index: b/drivers/ide/arm/icside.c
===================================================================
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -313,41 +313,10 @@ static int icside_dma_on(ide_drive_t *dr
 
 static int icside_dma_check(ide_drive_t *drive)
 {
-	struct hd_driveid *id = drive->id;
-	ide_hwif_t *hwif = HWIF(drive);
-	int xfer_mode = 0;
-
-	if (!(id->capability & 1) || !hwif->autodma)
-		goto out;
-
-	/*
-	 * Consult the list of known "bad" drives
-	 */
-	if (__ide_dma_bad_drive(drive))
-		goto out;
-
-	/*
-	 * Enable DMA on any drive that has multiword DMA
-	 */
-	if (id->field_valid & 2) {
-		xfer_mode = ide_max_dma_mode(drive);
-		goto out;
-	}
-
-	/*
-	 * Consult the list of known "good" drives
-	 */
-	if (__ide_dma_good_drive(drive)) {
-		if (id->eide_dma_time > 150)
-			goto out;
-		xfer_mode = XFER_MW_DMA_1;
-	}
-
-out:
-	if (xfer_mode == 0)
-		return -1;
+	if (ide_tune_dma(drive))
+		return 0;
 
-	return icside_set_speed(drive, xfer_mode) ? -1 : 0;
+	return -1;
 }
 
 static int icside_dma_end(ide_drive_t *drive)
Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -169,6 +169,11 @@ ide_startstop_t ide_dma_intr (ide_drive_
 
 EXPORT_SYMBOL_GPL(ide_dma_intr);
 
+static int ide_dma_good_drive(ide_drive_t *drive)
+{
+	return ide_in_drive_list(drive->id, drive_whitelist);
+}
+
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 /**
  *	ide_build_sglist	-	map IDE scatter gather for DMA I/O
@@ -357,7 +362,7 @@ static int config_drive_for_dma (ide_dri
 				return 0;
 
 		/* Consult the list of known "good" drives */
-		if (__ide_dma_good_drive(drive))
+		if (ide_dma_good_drive(drive))
 			return 0;
 	}
 
@@ -639,14 +644,6 @@ int __ide_dma_bad_drive (ide_drive_t *dr
 
 EXPORT_SYMBOL(__ide_dma_bad_drive);
 
-int __ide_dma_good_drive (ide_drive_t *drive)
-{
-	struct hd_driveid *id = drive->id;
-	return ide_in_drive_list(id, drive_whitelist);
-}
-
-EXPORT_SYMBOL(__ide_dma_good_drive);
-
 static const u8 xfer_mode_bases[] = {
 	XFER_UDMA_0,
 	XFER_MW_DMA_0,
@@ -740,6 +737,14 @@ u8 ide_find_dma_mode(ide_drive_t *drive,
 		}
 	}
 
+	if (hwif->chipset == ide_acorn && mode == 0) {
+		/*
+		 * is this correct?
+		 */
+		if (ide_dma_good_drive(drive) && drive->id->eide_dma_time < 150)
+			mode = XFER_MW_DMA_1;
+	}
+
 	printk(KERN_DEBUG "%s: selected mode 0x%x\n", drive->name, mode);
 
 	return min(mode, req_mode);
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1295,7 +1295,6 @@ int ide_in_drive_list(struct hd_driveid 
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
 int __ide_dma_bad_drive(ide_drive_t *);
-int __ide_dma_good_drive(ide_drive_t *);
 
 u8 ide_find_dma_mode(ide_drive_t *, u8);
 
