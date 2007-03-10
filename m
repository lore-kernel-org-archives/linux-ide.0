From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/13] ide: use ide_tune_dma() part #2
Date: Sat, 10 Mar 2007 22:08:19 +0100
Message-ID: <200703102208.19952.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:46174 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932256AbXCJVJN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Mar 2007 16:09:13 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1749114uga
        for <linux-ide@vger.kernel.org>; Sat, 10 Mar 2007 13:09:11 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

[PATCH] ide: use ide_tune_dma() part #2

Use ide_tune_dma() in ide-cris/it821x/pdc202xx_old/serverworks drivers.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---

 drivers/ide/cris/ide-cris.c    |   14 +-------------
 drivers/ide/pci/it821x.c       |   21 +--------------------
 drivers/ide/pci/pdc202xx_old.c |   14 +-------------
 drivers/ide/pci/serverworks.c  |   13 +------------
 4 files changed, 4 insertions(+), 58 deletions(-)

Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -1002,18 +1002,6 @@ static int cris_ide_build_dmatable (ide_
 	return 1;	/* let the PIO routines handle this weirdness */
 }
 
-static int cris_config_drive_for_dma (ide_drive_t *drive)
-{
-	u8 speed = ide_max_dma_mode(drive);
-
-	if (!speed)
-		return 0;
-
-	speed_cris_ide(drive, speed);
-
-	return ide_dma_enable(drive);
-}
-
 /*
  * cris_dma_intr() is the handler for disk read/write DMA interrupts
  */
@@ -1043,7 +1031,7 @@ static ide_startstop_t cris_dma_intr (id
 
 static int cris_dma_check(ide_drive_t *drive)
 {
-	if (ide_use_dma(drive) && cris_config_drive_for_dma(drive))
+	if (ide_tune_dma(drive))
 		return 0;
 
 	return -1;
Index: b/drivers/ide/pci/it821x.c
===================================================================
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -464,25 +464,6 @@ static int it821x_tune_chipset (ide_driv
 }
 
 /**
- *	config_chipset_for_dma	-	configure for DMA
- *	@drive: drive to configure
- *
- *	Called by the IDE layer when it wants the timings set up.
- */
-
-static int config_chipset_for_dma (ide_drive_t *drive)
-{
-	u8 speed = ide_max_dma_mode(drive);
-
-	if (speed == 0)
-		return 0;
-
-	it821x_tune_chipset(drive, speed);
-
-	return ide_dma_enable(drive);
-}
-
-/**
  *	it821x_configure_drive_for_dma	-	set up for DMA transfers
  *	@drive: drive we are going to set up
  *
@@ -494,7 +475,7 @@ static int config_chipset_for_dma (ide_d
 
 static int it821x_config_drive_for_dma (ide_drive_t *drive)
 {
-	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
+	if (ide_tune_dma(drive))
 		return 0;
 
 	it821x_tuneproc(drive, 255);
Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -181,23 +181,11 @@ static void pdc_old_disable_66MHz_clock(
 	outb(clock & ~(hwif->channel ? 0x08 : 0x02), clock_reg);
 }
 
-static int config_chipset_for_dma (ide_drive_t *drive)
-{
-	u8 speed = ide_max_dma_mode(drive);
-
-	if (!speed)
-		return 0;
-
-	(void)pdc202xx_tune_chipset(drive, speed);
-
-	return ide_dma_enable(drive);
-}
-
 static int pdc202xx_config_drive_xfer_rate (ide_drive_t *drive)
 {
 	drive->init_speed = 0;
 
-	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
+	if (ide_tune_dma(drive))
 		return 0;
 
 	if (ide_use_fast_pio(drive))
Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -270,22 +270,11 @@ static void svwks_tune_drive (ide_drive_
 	(void)svwks_tune_chipset(drive, XFER_PIO_0 + pio);
 }
 
-static int config_chipset_for_dma (ide_drive_t *drive)
-{
-	u8 speed = ide_max_dma_mode(drive);
-
-	if (!speed)
-		return 0;
-
-	(void) svwks_tune_chipset(drive, speed);
-	return ide_dma_enable(drive);
-}
-
 static int svwks_config_drive_xfer_rate (ide_drive_t *drive)
 {
 	drive->init_speed = 0;
 
-	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
+	if (ide_tune_dma(drive))
 		return 0;
 
 	if (ide_use_fast_pio(drive))
