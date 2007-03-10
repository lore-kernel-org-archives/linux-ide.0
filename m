From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 13/13] ide: remove ide_use_dma()
Date: Sat, 10 Mar 2007 22:12:10 +0100
Message-ID: <200703102212.10920.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:46174 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932289AbXCJVJV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Mar 2007 16:09:21 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1749114uga
        for <linux-ide@vger.kernel.org>; Sat, 10 Mar 2007 13:09:19 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

[PATCH] ide: remove ide_use_dma()

ide_use_dma() duplicates a lot of ide_max_dma_mode() functionality
and as all users of ide_use_dma() were converted to use ide_tune_dma()
now it is possible to add missing checks to ide_tune_dma() and remove
ide_use_dma() completely, so do it.

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---

 drivers/ide/ide-dma.c |   42 +++++-------------------------------------
 include/linux/ide.h   |    2 --
 2 files changed, 5 insertions(+), 39 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -670,41 +670,6 @@ int __ide_dma_good_drive (ide_drive_t *d
 
 EXPORT_SYMBOL(__ide_dma_good_drive);
 
-int ide_use_dma(ide_drive_t *drive)
-{
-	struct hd_driveid *id = drive->id;
-	ide_hwif_t *hwif = drive->hwif;
-
-	if ((id->capability & 1) == 0 || drive->autodma == 0)
-		return 0;
-
-	/* consult the list of known "bad" drives */
-	if (__ide_dma_bad_drive(drive))
-		return 0;
-
-	/* capable of UltraDMA modes */
-	if (id->field_valid & 4) {
-		if (hwif->ultra_mask & id->dma_ultra)
-			return 1;
-	}
-
-	/* capable of regular DMA modes */
-	if (id->field_valid & 2) {
-		if (hwif->mwdma_mask & id->dma_mword)
-			return 1;
-		if (hwif->swdma_mask & id->dma_1word)
-			return 1;
-	}
-
-	/* consult the list of known "good" drives */
-	if (__ide_dma_good_drive(drive) && id->eide_dma_time < 150)
-		return 1;
-
-	return 0;
-}
-
-EXPORT_SYMBOL_GPL(ide_use_dma);
-
 static const u8 xfer_mode_bases[] = {
 	XFER_UDMA_0,
 	XFER_MW_DMA_0,
@@ -785,8 +750,11 @@ int ide_tune_dma(ide_drive_t *drive)
 {
 	u8 speed;
 
-	/* TODO: use only ide_max_dma_mode() */
-	if (!ide_use_dma(drive))
+	if ((drive->id->capability & 1) == 0 || drive->autodma == 0)
+		return 0;
+
+	/* consult the list of known "bad" drives */
+	if (__ide_dma_bad_drive(drive))
 		return 0;
 
 	speed = ide_max_dma_mode(drive);
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1278,7 +1278,6 @@ struct drive_list_entry {
 int ide_in_drive_list(struct hd_driveid *, const struct drive_list_entry *);
 int __ide_dma_bad_drive(ide_drive_t *);
 int __ide_dma_good_drive(ide_drive_t *);
-int ide_use_dma(ide_drive_t *);
 u8 ide_max_dma_mode(ide_drive_t *);
 int ide_tune_dma(ide_drive_t *);
 void ide_dma_off(ide_drive_t *);
@@ -1306,7 +1305,6 @@ extern int __ide_dma_timeout(ide_drive_t
 #endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
 
 #else
-static inline int ide_use_dma(ide_drive_t *drive) { return 0; }
 static inline u8 ide_max_dma_mode(ide_drive_t *drive) { return 0; }
 static inline int ide_tune_dma(ide_drive_t *drive) { return 0; }
 static inline void ide_dma_off(ide_drive_t *drive) { ; }
