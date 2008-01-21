From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 16/16] ide: move check_dma_crc() to ide-dma.c
Date: Tue, 22 Jan 2008 00:32:26 +0100
Message-ID: <20080121233226.30311.40535.sendpatchset@localhost.localdomain>
References: <20080121233036.30311.76015.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:43625 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760809AbYAUXTW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 18:19:22 -0500
Received: by ug-out-1314.google.com with SMTP id z38so975308ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 15:19:20 -0800 (PST)
In-Reply-To: <20080121233036.30311.76015.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org


* Move check_dma_crc() to ide-dma.c and add inline version for
  CONFIG_BLK_DEV_IDEDMA=n case.

* Rename check_dma_crc() to ide_check_dma_crc().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma.c  |   20 ++++++++++++++++++++
 drivers/ide/ide-iops.c |   24 +-----------------------
 include/linux/ide.h    |    2 ++
 3 files changed, 23 insertions(+), 23 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -821,6 +821,26 @@ int ide_set_dma(ide_drive_t *drive)
 	return 0;
 }
 
+void ide_check_dma_crc(ide_drive_t *drive)
+{
+	u8 mode;
+
+	ide_dma_off_quietly(drive);
+	drive->crc_count = 0;
+	mode = drive->current_speed;
+	/*
+	 * Don't try non Ultra-DMA modes without iCRC's.  Force the
+	 * device to PIO and make the user enable SWDMA/MWDMA modes.
+	 */
+	if (mode > XFER_UDMA_0 && mode <= XFER_UDMA_7)
+		mode--;
+	else
+		mode = XFER_PIO_4;
+	ide_set_xfer_rate(drive, mode);
+	if (drive->current_speed >= XFER_SW_DMA_0)
+		ide_dma_on(drive);
+}
+
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 void ide_dma_lost_irq (ide_drive_t *drive)
 {
Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -938,28 +938,6 @@ static ide_startstop_t reset_pollfunc (i
 	return ide_stopped;
 }
 
-static void check_dma_crc(ide_drive_t *drive)
-{
-#ifdef CONFIG_BLK_DEV_IDEDMA
-	u8 mode;
-
-	ide_dma_off_quietly(drive);
-	drive->crc_count = 0;
-	mode = drive->current_speed;
-	/*
-	 * Don't try non Ultra-DMA modes without iCRC's.  Force the
-	 * device to PIO and make the user enable SWDMA/MWDMA modes.
-	 */
-	if (mode > XFER_UDMA_0 && mode <= XFER_UDMA_7)
-		mode--;
-	else
-		mode = XFER_PIO_4;
-	ide_set_xfer_rate(drive, mode);
-	if (drive->current_speed >= XFER_SW_DMA_0)
-		ide_dma_on(drive);
-#endif
-}
-
 static void ide_disk_pre_reset(ide_drive_t *drive)
 {
 	int legacy = (drive->id->cfs_enable_2 & 0x0400) ? 0 : 1;
@@ -983,7 +961,7 @@ static void pre_reset(ide_drive_t *drive
 
 	if (drive->using_dma) {
 		if (drive->crc_count)
-			check_dma_crc(drive);
+			ide_check_dma_crc(drive);
 		else
 			ide_dma_off(drive);
 	}
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1158,6 +1158,7 @@ void ide_dma_off_quietly(ide_drive_t *);
 void ide_dma_off(ide_drive_t *);
 void ide_dma_on(ide_drive_t *);
 int ide_set_dma(ide_drive_t *);
+void ide_check_dma_crc(ide_drive_t *);
 ide_startstop_t ide_dma_intr(ide_drive_t *);
 
 int ide_build_sglist(ide_drive_t *, struct request *);
@@ -1185,6 +1186,7 @@ static inline void ide_dma_off(ide_drive
 static inline void ide_dma_on(ide_drive_t *drive) { ; }
 static inline void ide_dma_verbose(ide_drive_t *drive) { ; }
 static inline int ide_set_dma(ide_drive_t *drive) { return 1; }
+static inline void ide_check_dma_crc(ide_drive_t *drive) { ; }
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 
 #ifndef CONFIG_BLK_DEV_IDEDMA_PCI
