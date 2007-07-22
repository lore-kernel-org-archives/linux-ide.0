From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/11] ide-pmac: remove pmac_ide_{m,u}dma_enable()
Date: Sun, 22 Jul 2007 20:24:14 +0200
Message-ID: <200707222024.14736.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:34931 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758034AbXGVSTG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jul 2007 14:19:06 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1001338ugf
        for <linux-ide@vger.kernel.org>; Sun, 22 Jul 2007 11:19:05 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>


* Fix pmac_ide_dma_check() to use pmac_ide_tune_chipset() and remove no longer
  necessary pmac_ide_{m,u}dma_enable().

* While at it remove some dead code from pmac_ide_dma_check() (leftovers from
  conversion to use ide_max_dma_mode()).

There should be no functionality changes caused by this patch.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ppc/pmac.c |  101 -------------------------------------------------
 1 file changed, 2 insertions(+), 99 deletions(-)

Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1669,105 +1669,13 @@ pmac_ide_destroy_dmatable (ide_drive_t *
 }
 
 /*
- * Pick up best MDMA timing for the drive and apply it
- */
-static int
-pmac_ide_mdma_enable(ide_drive_t *drive, u16 mode)
-{
-	ide_hwif_t *hwif = HWIF(drive);
-	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)hwif->hwif_data;
-	u32 *timings, *timings2;
-	u32 timing_local[2];
-	int ret;
-
-	/* which drive is it ? */
-	timings = &pmif->timings[drive->select.b.unit & 0x01];
-	timings2 = &pmif->timings[(drive->select.b.unit & 0x01) + 2];
-
-	/* Copy timings to local image */
-	timing_local[0] = *timings;
-	timing_local[1] = *timings2;
-
-	/* Calculate controller timings */
-	set_timings_mdma(drive, pmif->kind, &timing_local[0], &timing_local[1], mode);
-
-	/* Set feature on drive */
-    	printk(KERN_INFO "%s: Enabling MultiWord DMA %d\n", drive->name, mode & 0xf);
-	ret = pmac_ide_do_setfeature(drive, mode);
-	if (ret) {
-	    	printk(KERN_WARNING "%s: Failed !\n", drive->name);
-	    	return 0;
-	}
-
-	/* Apply timings to controller */
-	*timings = timing_local[0];
-	*timings2 = timing_local[1];
-
-	return 1;
-}
-
-/*
- * Pick up best UDMA timing for the drive and apply it
- */
-static int
-pmac_ide_udma_enable(ide_drive_t *drive, u16 mode)
-{
-	ide_hwif_t *hwif = HWIF(drive);
-	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)hwif->hwif_data;
-	u32 *timings, *timings2;
-	u32 timing_local[2];
-	int ret;
-		
-	/* which drive is it ? */
-	timings = &pmif->timings[drive->select.b.unit & 0x01];
-	timings2 = &pmif->timings[(drive->select.b.unit & 0x01) + 2];
-
-	/* Copy timings to local image */
-	timing_local[0] = *timings;
-	timing_local[1] = *timings2;
-	
-	/* Calculate timings for interface */
-	if (pmif->kind == controller_un_ata6
-	    || pmif->kind == controller_k2_ata6)
-		ret = set_timings_udma_ata6(	&timing_local[0],
-						&timing_local[1],
-						mode);
-	else if (pmif->kind == controller_sh_ata6)
-		ret = set_timings_udma_shasta(	&timing_local[0],
-						&timing_local[1],
-						mode);
-	else
-		ret = set_timings_udma_ata4(&timing_local[0], mode);
-	if (ret)
-		return 0;
-		
-	/* Set feature on drive */
-    	printk(KERN_INFO "%s: Enabling Ultra DMA %d\n", drive->name, mode & 0x0f);
-	ret = pmac_ide_do_setfeature(drive, mode);
-	if (ret) {
-		printk(KERN_WARNING "%s: Failed !\n", drive->name);
-		return 0;
-	}
-
-	/* Apply timings to controller */
-	*timings = timing_local[0];
-	*timings2 = timing_local[1];
-
-	return 1;
-}
-
-/*
  * Check what is the best DMA timing setting for the drive and
  * call appropriate functions to apply it.
  */
 static int
 pmac_ide_dma_check(ide_drive_t *drive)
 {
-	struct hd_driveid *id = drive->id;
-	ide_hwif_t *hwif = HWIF(drive);
-	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)hwif->hwif_data;
 	int enable = 1;
-	int map;
 	drive->using_dma = 0;
 	
 	if (drive->media == ide_floppy)
@@ -1780,13 +1688,8 @@ pmac_ide_dma_check(ide_drive_t *drive)
 	if (enable) {
 		u8 mode = ide_max_dma_mode(drive);
 
-		if (mode >= XFER_UDMA_0)
-			drive->using_dma = pmac_ide_udma_enable(drive, mode);
-		else if (mode >= XFER_MW_DMA_0)
-			drive->using_dma = pmac_ide_mdma_enable(drive, mode);
-
-		/* Apply settings to controller */
-		pmac_ide_do_update_timings(drive);
+		if (mode && pmac_ide_tune_chipset(drive, mode) == 0)
+			drive->using_dma = 1;
 	}
 	return 0;
 }
