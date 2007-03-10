From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/13] cs5530/sc1200: add ->udma_filter methods
Date: Sat, 10 Mar 2007 22:13:15 +0100
Message-ID: <200703102213.15715.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:46174 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932371AbXCJVJY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Mar 2007 16:09:24 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1749114uga
        for <linux-ide@vger.kernel.org>; Sat, 10 Mar 2007 13:09:24 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

[PATCH] cs5530/sc1200: add ->udma_filter methods

CS5530/SC1200 specifies that two drives on the same cable cannot mix
UDMA/MDMA.  Add {cs5530,sc1200}_udma_filter() to handle this.  This also
makes it possible to remove open-coded best DMA mode selection and use
standard ide_use_dma()/ide_max_dma_mode() helpers.  While at it bump
version numbers.

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---

 drivers/ide/pci/cs5530.c |  120 +++++++++++++++++++++--------------------------
 drivers/ide/pci/sc1200.c |   86 +++++++++++++--------------------
 2 files changed, 89 insertions(+), 117 deletions(-)

Index: b/drivers/ide/pci/cs5530.c
===================================================================
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -1,10 +1,10 @@
 /*
- * linux/drivers/ide/pci/cs5530.c		Version 0.7	Sept 10, 2002
+ * linux/drivers/ide/pci/cs5530.c		Version 0.71	Mar 10 2007
  *
  * Copyright (C) 2000			Andre Hedrick <andre@linux-ide.org>
- * Ditto of GNU General Public License.
- *
  * Copyright (C) 2000			Mark Lord <mlord@pobox.com>
+ * Copyright (C) 2007			Bartlomiej Zolnierkiewicz
+ *
  * May be copied or modified under the terms of the GNU General Public License
  *
  * Development of this chipset driver was funded
@@ -88,79 +88,66 @@ static void cs5530_tuneproc (ide_drive_t
 }
 
 /**
- *	cs5530_config_dma	-	select/set DMA and UDMA modes
+ *	cs5530_udma_filter	-	UDMA filter
+ *	@drive: drive
+ *
+ *	cs5530_udma_filter() does UDMA mask filtering for the given drive
+ *	taking into the consideration capabilities of the mate device.
+ *
+ *	The CS5530 specifies that two drives sharing a cable cannot mix
+ *	UDMA/MDMA.  It has to be one or the other, for the pair, though
+ *	different timings can still be chosen for each drive.  We could
+ *	set the appropriate timing bits on the fly, but that might be
+ *	a bit confusing.  So, for now we statically handle this requirement
+ *	by looking at our mate drive to see what it is capable of, before
+ *	choosing a mode for our own drive.
+ *
+ *	Note: This relies on the fact we never fail from UDMA to MWDMA2
+ *	but instead drop to PIO.
+ */
+
+static u8 cs5530_udma_filter(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	ide_drive_t *mate = &hwif->drives[(drive->dn & 1) ^ 1];
+	struct hd_driveid *mateid = mate->id;
+	u8 mask = hwif->ultra_mask;
+
+	if (mate->present == 0)
+		goto out;
+
+	if ((mateid->capability & 1) && __ide_dma_bad_drive(mate) == 0) {
+		if ((mateid->field_valid & 4) && (mateid->dma_ultra & 7))
+			goto out;
+		if ((mateid->field_valid & 2) && (mateid->dma_mword & 7))
+			mask = 0;
+	}
+out:
+	return mask;
+}
+
+/**
+ *	cs5530_config_dma	-	set DMA/UDMA mode
  *	@drive: drive to tune
  *
- *	cs5530_config_dma() handles selection/setting of DMA/UDMA modes
- *	for both the chipset and drive. The CS5530 has limitations about
- *	mixing DMA/UDMA on the same cable.
+ *	cs5530_config_dma() handles setting of DMA/UDMA mode
+ *	for both the chipset and drive.
  */
- 
-static int cs5530_config_dma (ide_drive_t *drive)
+
+static int cs5530_config_dma(ide_drive_t *drive)
 {
-	int			udma_ok = 1, mode = 0;
-	ide_hwif_t		*hwif = HWIF(drive);
-	int			unit = drive->select.b.unit;
-	ide_drive_t		*mate = &hwif->drives[unit^1];
-	struct hd_driveid	*id = drive->id;
-	unsigned int		reg, timings = 0;
-	unsigned long		basereg;
+	ide_hwif_t *hwif = drive->hwif;
+	unsigned int reg, timings = 0;
+	unsigned long basereg;
+	u8 unit = drive->dn & 1, mode = 0;
 
 	/*
 	 * Default to DMA-off in case we run into trouble here.
 	 */
 	hwif->dma_off_quietly(drive);
 
-	/*
-	 * The CS5530 specifies that two drives sharing a cable cannot
-	 * mix UDMA/MDMA.  It has to be one or the other, for the pair,
-	 * though different timings can still be chosen for each drive.
-	 * We could set the appropriate timing bits on the fly,
-	 * but that might be a bit confusing.  So, for now we statically
-	 * handle this requirement by looking at our mate drive to see
-	 * what it is capable of, before choosing a mode for our own drive.
-	 *
-	 * Note: This relies on the fact we never fail from UDMA to MWDMA_2
-	 * but instead drop to PIO
-	 */
-	if (mate->present) {
-		struct hd_driveid *mateid = mate->id;
-		if (mateid && (mateid->capability & 1) &&
-		    !__ide_dma_bad_drive(mate)) {
-			if ((mateid->field_valid & 4) &&
-			    (mateid->dma_ultra & 7))
-				udma_ok = 1;
-			else if ((mateid->field_valid & 2) &&
-				 (mateid->dma_mword & 7))
-				udma_ok = 0;
-			else
-				udma_ok = 1;
-		}
-	}
-
-	/*
-	 * Now see what the current drive is capable of,
-	 * selecting UDMA only if the mate said it was ok.
-	 */
-	if (id && (id->capability & 1) && drive->autodma &&
-	    !__ide_dma_bad_drive(drive)) {
-		if (udma_ok && (id->field_valid & 4) && (id->dma_ultra & 7)) {
-			if      (id->dma_ultra & 4)
-				mode = XFER_UDMA_2;
-			else if (id->dma_ultra & 2)
-				mode = XFER_UDMA_1;
-			else if (id->dma_ultra & 1)
-				mode = XFER_UDMA_0;
-		}
-		if (!mode && (id->field_valid & 2) && (id->dma_mword & 7)) {
-			if      (id->dma_mword & 4)
-				mode = XFER_MW_DMA_2;
-			else if (id->dma_mword & 2)
-				mode = XFER_MW_DMA_1;
-			else if (id->dma_mword & 1)
-				mode = XFER_MW_DMA_0;
-		}
-	}
+	if (ide_use_dma(drive))
+		mode = ide_max_dma_mode(drive);
 
 	/*
 	 * Tell the drive to switch to the new mode; abort on failure.
@@ -332,6 +319,7 @@ static void __devinit init_hwif_cs5530 (
 	hwif->ultra_mask = 0x07;
 	hwif->mwdma_mask = 0x07;
 
+	hwif->udma_filter = cs5530_udma_filter;
 	hwif->ide_dma_check = &cs5530_config_dma;
 	if (!noautodma)
 		hwif->autodma = 1;
Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -1,7 +1,9 @@
 /*
- * linux/drivers/ide/pci/sc1200.c		Version 0.91	28-Jan-2003
+ * linux/drivers/ide/pci/sc1200.c		Version 0.92	Mar 10 2007
  *
  * Copyright (C) 2000-2002		Mark Lord <mlord@pobox.com>
+ * Copyright (C)      2007		Bartlomiej Zolnierkiewicz
+ *
  * May be copied or modified under the terms of the GNU General Public License
  *
  * Development of this chipset driver was funded
@@ -93,57 +95,33 @@ static const unsigned int sc1200_pio_tim
  */
 //#define SC1200_BAD_PIO(timings) (((timings)&~0x80000000)==0x00009172)
 
-static int sc1200_autoselect_dma_mode (ide_drive_t *drive)
+/*
+ *	The SC1200 specifies that two drives sharing a cable cannot mix
+ *	UDMA/MDMA.  It has to be one or the other, for the pair, though
+ *	different timings can still be chosen for each drive.  We could
+ *	set the appropriate timing bits on the fly, but that might be
+ *	a bit confusing.  So, for now we statically handle this requirement
+ *	by looking at our mate drive to see what it is capable of, before
+ *	choosing a mode for our own drive.
+ */
+static u8 sc1200_udma_filter(ide_drive_t *drive)
 {
-	int			udma_ok = 1, mode = 0;
-	ide_hwif_t		*hwif = HWIF(drive);
-	int			unit = drive->select.b.unit;
-	ide_drive_t		*mate = &hwif->drives[unit^1];
-	struct hd_driveid	*id = drive->id;
-
-	/*
-	 * The SC1200 specifies that two drives sharing a cable cannot
-	 * mix UDMA/MDMA.  It has to be one or the other, for the pair,
-	 * though different timings can still be chosen for each drive.
-	 * We could set the appropriate timing bits on the fly,
-	 * but that might be a bit confusing.  So, for now we statically
-	 * handle this requirement by looking at our mate drive to see
-	 * what it is capable of, before choosing a mode for our own drive.
-	 */
-	if (mate->present) {
-		struct hd_driveid *mateid = mate->id;
-		if (mateid && (mateid->capability & 1) && !__ide_dma_bad_drive(mate)) {
-			if ((mateid->field_valid & 4) && (mateid->dma_ultra & 7))
-				udma_ok = 1;
-			else if ((mateid->field_valid & 2) && (mateid->dma_mword & 7))
-				udma_ok = 0;
-			else
-				udma_ok = 1;
-		}
-	}
-	/*
-	 * Now see what the current drive is capable of,
-	 * selecting UDMA only if the mate said it was ok.
-	 */
-	if (id && (id->capability & 1) && hwif->autodma && !__ide_dma_bad_drive(drive)) {
-		if (udma_ok && (id->field_valid & 4) && (id->dma_ultra & 7)) {
-			if      (id->dma_ultra & 4)
-				mode = XFER_UDMA_2;
-			else if (id->dma_ultra & 2)
-				mode = XFER_UDMA_1;
-			else if (id->dma_ultra & 1)
-				mode = XFER_UDMA_0;
-		}
-		if (!mode && (id->field_valid & 2) && (id->dma_mword & 7)) {
-			if      (id->dma_mword & 4)
-				mode = XFER_MW_DMA_2;
-			else if (id->dma_mword & 2)
-				mode = XFER_MW_DMA_1;
-			else if (id->dma_mword & 1)
-				mode = XFER_MW_DMA_0;
-		}
+	ide_hwif_t *hwif = drive->hwif;
+	ide_drive_t *mate = &hwif->drives[(drive->dn & 1) ^ 1];
+	struct hd_driveid *mateid = mate->id;
+	u8 mask = hwif->ultra_mask;
+
+	if (mate->present == 0)
+		goto out;
+
+	if ((mateid->capability & 1) && __ide_dma_bad_drive(mate) == 0) {
+		if ((mateid->field_valid & 4) && (mateid->dma_ultra & 7))
+			goto out;
+		if ((mateid->field_valid & 2) && (mateid->dma_mword & 7))
+			mask = 0;
 	}
-	return mode;
+out:
+	return mask;
 }
 
 /*
@@ -250,7 +228,12 @@ static int sc1200_config_dma2 (ide_drive
  */
 static int sc1200_config_dma (ide_drive_t *drive)
 {
-	return sc1200_config_dma2(drive, sc1200_autoselect_dma_mode(drive));
+	u8 mode = 0;
+
+	if (ide_use_dma(drive))
+		mode = ide_max_dma_mode(drive);
+
+	return sc1200_config_dma2(drive, mode);
 }
 
 
@@ -461,6 +444,7 @@ static void __devinit init_hwif_sc1200 (
 		hwif->serialized = hwif->mate->serialized = 1;
 	hwif->autodma = 0;
 	if (hwif->dma_base) {
+		hwif->udma_filter = sc1200_udma_filter;
 		hwif->ide_dma_check = &sc1200_config_dma;
 		hwif->ide_dma_end   = &sc1200_ide_dma_end;
         	if (!noautodma)
