From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/8] alim15x3: use ide_tune_dma()
Date: Wed, 14 Feb 2007 02:56:10 +0100
Message-ID: <20070214015610.4619.55740.sendpatchset@localhost.localdomain>
References: <20070214015603.4619.41923.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:46567 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbXBNBua (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Feb 2007 20:50:30 -0500
Received: by ug-out-1314.google.com with SMTP id 44so28107uga
        for <linux-ide@vger.kernel.org>; Tue, 13 Feb 2007 17:50:28 -0800 (PST)
In-Reply-To: <20070214015603.4619.41923.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

[PATCH] alim15x3: use ide_tune_dma()

Use ide_tune_dma() in ali15x3_config_drive_for_dma() and remove all the open
coded DMA tuning code and also config_chipset_for_dma().  Set ->atapi_dma flag
correctly in init_hwif_common_ali15x3() so ide_tune_dma() can take care of
checking if ATAPI DMA is allowed and remove open coded ATAPI DMA check from
ali15x3_config_drive_for_dma().

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/pci/alim15x3.c |   69 ++++-----------------------------------------
 1 file changed, 7 insertions(+), 62 deletions(-)

Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -455,28 +455,6 @@ static int ali15x3_tune_chipset (ide_dri
 	return (ide_config_drive_speed(drive, speed));
 }
 
-
-/**
- *	config_chipset_for_dma	-	set up DMA mode
- *	@drive: drive to configure for
- *
- *	Place a drive into DMA mode and tune the chipset for
- *	the selected speed.
- *
- *	Returns true if DMA mode can be used
- */
- 
-static int config_chipset_for_dma (ide_drive_t *drive)
-{
-	u8 speed = ide_max_dma_mode(drive);
-
-	if (!(speed))
-		return 0;
-
-	(void) ali15x3_tune_chipset(drive, speed);
-	return ide_dma_enable(drive);
-}
-
 /**
  *	ali15x3_config_drive_for_dma	-	configure for DMA
  *	@drive: drive to configure
@@ -487,48 +465,14 @@ static int config_chipset_for_dma (ide_d
 
 static int ali15x3_config_drive_for_dma(ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct hd_driveid *id	= drive->id;
-
-	if ((m5229_revision<=0x20) && (drive->media!=ide_disk))
-		goto ata_pio;
-
 	drive->init_speed = 0;
 
-	if ((id != NULL) && ((id->capability & 1) != 0) && drive->autodma) {
-		/* Consult the list of known "bad" drives */
-		if (__ide_dma_bad_drive(drive))
-			goto ata_pio;
-		if ((id->field_valid & 4) && (m5229_revision >= 0xC2)) {
-			if (id->dma_ultra & hwif->ultra_mask) {
-				/* Force if Capable UltraDMA */
-				int dma = config_chipset_for_dma(drive);
-				if ((id->field_valid & 2) && !dma)
-					goto try_dma_modes;
-			}
-		} else if (id->field_valid & 2) {
-try_dma_modes:
-			if ((id->dma_mword & hwif->mwdma_mask) ||
-			    (id->dma_1word & hwif->swdma_mask)) {
-				/* Force if Capable regular DMA modes */
-				if (!config_chipset_for_dma(drive))
-					goto ata_pio;
-			}
-		} else if (__ide_dma_good_drive(drive) &&
-			   (id->eide_dma_time < 150)) {
-			/* Consult the list of known "good" drives */
-			if (!config_chipset_for_dma(drive))
-				goto ata_pio;
-		} else {
-			goto ata_pio;
-		}
-	} else {
-ata_pio:
-		hwif->tuneproc(drive, 255);
-		return -1;
-	}
+	if (ide_tune_dma(drive))
+		return 0;
 
-	return 0;
+	ali15x3_tune_drive(drive, 255);
+
+	return -1;
 }
 
 /**
@@ -739,7 +683,8 @@ static void __devinit init_hwif_common_a
 		return;
 	}
 
-	hwif->atapi_dma = 1;
+	if (m5229_revision > 0x20)
+		hwif->atapi_dma = 1;
 
 	if (m5229_revision <= 0x20)
 		hwif->ultra_mask = 0x00; /* no udma */
