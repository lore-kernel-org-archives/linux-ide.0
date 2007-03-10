From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 11/13] ide: remove ide_dma_enable()
Date: Sat, 10 Mar 2007 22:10:34 +0100
Message-ID: <200703102210.34288.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:47143 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932286AbXCJVJQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Mar 2007 16:09:16 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1749117uga
        for <linux-ide@vger.kernel.org>; Sat, 10 Mar 2007 13:09:16 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

[PATCH] ide: remove ide_dma_enable()

* check ->speedproc return value in ide_tune_dma()
* use ide_tune_dma() in cmd64x/cs5530/sc1200/siimage/sl82c105/scc_pata drivers
* remove no longer needed ide_dma_enable()

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---

 drivers/ide/ide-dma.c      |    5 +++--
 drivers/ide/ide-lib.c      |   12 ------------
 drivers/ide/pci/cmd64x.c   |   15 +--------------
 drivers/ide/pci/cs5530.c   |    8 ++------
 drivers/ide/pci/sc1200.c   |    8 ++------
 drivers/ide/pci/siimage.c  |   24 +-----------------------
 drivers/ide/pci/sl82c105.c |   14 +-------------
 drivers/ide/ppc/scc_pata.c |   22 +---------------------
 include/linux/ide.h        |    1 -
 9 files changed, 11 insertions(+), 98 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -792,9 +792,10 @@ int ide_tune_dma(ide_drive_t *drive)
 	if (!speed)
 		return 0;
 
-	drive->hwif->speedproc(drive, speed);
+	if (drive->hwif->speedproc(drive, speed))
+		return 0;
 
-	return ide_dma_enable(drive);
+	return 1;
 }
 
 EXPORT_SYMBOL_GPL(ide_tune_dma);
Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -111,18 +111,6 @@ u8 ide_rate_filter(ide_drive_t *drive, u
 
 EXPORT_SYMBOL(ide_rate_filter);
 
-int ide_dma_enable (ide_drive_t *drive)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct hd_driveid *id	= drive->id;
-
-	return ((int)	((((id->dma_ultra >> 8) & hwif->ultra_mask) ||
-			  ((id->dma_mword >> 8) & hwif->mwdma_mask) ||
-			  ((id->dma_1word >> 8) & hwif->swdma_mask)) ? 1 : 0));
-}
-
-EXPORT_SYMBOL(ide_dma_enable);
-
 int ide_use_fast_pio(ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -350,22 +350,9 @@ static int cmd64x_tune_chipset (ide_driv
 	return ide_config_drive_speed(drive, speed);
 }
 
-static int config_chipset_for_dma (ide_drive_t *drive)
-{
-	u8 speed = ide_max_dma_mode(drive);
-
-	if (!speed)
-		return 0;
-
-	if (cmd64x_tune_chipset(drive, speed))
-		return 0;
-
-	return ide_dma_enable(drive);
-}
-
 static int cmd64x_config_drive_for_dma (ide_drive_t *drive)
 {
-	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
+	if (ide_tune_dma(drive))
 		return 0;
 
 	if (ide_use_fast_pio(drive))
Index: b/drivers/ide/pci/cs5530.c
===================================================================
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -137,12 +137,8 @@ out:
 
 static int cs5530_config_dma(ide_drive_t *drive)
 {
-	if (ide_use_dma(drive)) {
-		u8 mode = ide_max_dma_mode(drive);
-
-		if (mode && drive->hwif->speedproc(drive, mode) == 0)
-			return 0;
-	}
+	if (ide_tune_dma(drive))
+		return 0;
 
 	return 1;
 }
Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -240,12 +240,8 @@ static int sc1200_tune_chipset(ide_drive
  */
 static int sc1200_config_dma (ide_drive_t *drive)
 {
-	if (ide_use_dma(drive)) {
-		u8 mode = ide_max_dma_mode(drive);
-
-		if (mode && drive->hwif->speedproc(drive, mode) == 0)
-			return 0;
-	}
+	if (ide_tune_dma(drive))
+		return 0;
 
 	return 1;
 }
Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -375,28 +375,6 @@ static int siimage_tune_chipset (ide_dri
 }
 
 /**
- *	config_chipset_for_dma	-	configure for DMA
- *	@drive: drive to configure
- *
- *	Called by the IDE layer when it wants the timings set up.
- *	For the CMD680 we also need to set up the PIO timings and
- *	enable DMA.
- */
- 
-static int config_chipset_for_dma (ide_drive_t *drive)
-{
-	u8 speed = ide_max_dma_mode(drive);
-
-	if (!speed)
-		return 0;
-
-	if (siimage_tune_chipset(drive, speed))
-		return 0;
-
-	return ide_dma_enable(drive);
-}
-
-/**
  *	siimage_configure_drive_for_dma	-	set up for DMA transfers
  *	@drive: drive we are going to set up
  *
@@ -408,7 +386,7 @@ static int config_chipset_for_dma (ide_d
  
 static int siimage_config_drive_for_dma (ide_drive_t *drive)
 {
-	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
+	if (ide_tune_dma(drive))
 		return 0;
 
 	if (ide_use_fast_pio(drive))
Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -146,18 +146,6 @@ static int sl82c105_tune_chipset(ide_dri
 	return ide_config_drive_speed(drive, mode);
 }
 
-static int config_for_dma (ide_drive_t *drive)
-{
-	u8 mode = ide_max_dma_mode(drive);
-
-	DBG(("config_for_dma(drive:%s)\n", drive->name));
-
-	if (mode == 0 || sl82c105_tune_chipset(drive, mode))
-		return 0;
-
-	return ide_dma_enable(drive);
-}
-
 /*
  * Check to see if the drive and chipset are capable of DMA mode.
  */
@@ -165,7 +153,7 @@ static int sl82c105_ide_dma_check (ide_d
 {
 	DBG(("sl82c105_ide_dma_check(drive:%s)\n", drive->name));
 
-	if (ide_use_dma(drive) && config_for_dma(drive))
+	if (ide_tune_dma(drive))
 		return 0;
 
 	return -1;
Index: b/drivers/ide/ppc/scc_pata.c
===================================================================
--- a/drivers/ide/ppc/scc_pata.c
+++ b/drivers/ide/ppc/scc_pata.c
@@ -322,26 +322,6 @@ static int scc_tune_chipset(ide_drive_t 
 }
 
 /**
- *	scc_config_chipset_for_dma	-	configure for DMA
- *	@drive: drive to configure
- *
- *	Called by scc_config_drive_for_dma().
- */
-
-static int scc_config_chipset_for_dma(ide_drive_t *drive)
-{
-	u8 speed = ide_max_dma_mode(drive);
-
-	if (!speed)
-		return 0;
-
-	if (scc_tune_chipset(drive, speed))
-		return 0;
-
-	return ide_dma_enable(drive);
-}
-
-/**
  *	scc_configure_drive_for_dma	-	set up for DMA transfers
  *	@drive: drive we are going to set up
  *
@@ -354,7 +334,7 @@ static int scc_config_chipset_for_dma(id
 
 static int scc_config_drive_for_dma(ide_drive_t *drive)
 {
-	if (ide_use_dma(drive) && scc_config_chipset_for_dma(drive))
+	if (ide_tune_dma(drive))
 		return 0;
 
 	if (ide_use_fast_pio(drive))
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1354,7 +1354,6 @@ static inline void ide_set_hwifdata (ide
 
 /* ide-lib.c */
 u8 ide_rate_filter(ide_drive_t *, u8);
-extern int ide_dma_enable(ide_drive_t *drive);
 extern char *ide_xfer_verbose(u8 xfer_rate);
 extern void ide_toggle_bounce(ide_drive_t *drive, int on);
 extern int ide_set_xfer_rate(ide_drive_t *drive, u8 rate);
