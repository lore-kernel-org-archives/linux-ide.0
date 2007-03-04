From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] sis5513: PIO mode setup fixes
Date: Sun, 4 Mar 2007 23:02:58 +0100
Message-ID: <200703042302.58179.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:37882 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507AbXCDV4T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Mar 2007 16:56:19 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1096975uga
        for <linux-ide@vger.kernel.org>; Sun, 04 Mar 2007 13:56:18 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


[PATCH] sis5513: PIO mode setup fixes

* limit max PIO mode to PIO4, this driver doesn't support PIO5 and attempt
  to program PIO5 by config_art_rwp_pio() could result in incorrect PIO
  timings being programmed and possibly the data corruption (for < ATA100
  family chipsets PIO0 timings were used, for ATA100 and ATA100a - the random
  content of test1 variable was used, for ATA133 - MWDMA0 timings were used)

* BUG() in sis5513_tune_chipset() if somebody tries to force unsupported PIO5,
  also cleanup this function a bit while at it

* add comment about PIO0 timings for < ATA100 family chipsets

* remove open-coded best PIO mode selection from config_art_rwp_pio(),
  it contained numerous bugs:

  - it didn't check for validity of id->eide_pio_modes and id->eide_pio_iordy
    before using them

  - it tried to found out maximum PIO mode basing on minimum IORDY cycle time
    (moreover wrong cycle times were used for PIO1/5)

  - it was overriding PIO blacklist and conservative PIO "downgrade" done
    by ide_get_best_pio_mode()

* use sis5513_tune_drive() instead of config_art_rwp_pio()
  in sis5513_config_xfer_rate() so the correct PIO mode is also set
  on drive even if the device is not IORDY/DMA capable

* config_art_rwp_pio() was always setting the best possible mode and not
  the wanted one - fix it and move ide_get_best_pio_mode() call to
  config_chipset_for_pio()

* don't use ide_find_best_mode() in config_chipset_for_pio(), it was being
  overriden by config_art_rwp_pio() for the host timings anyway + we need to
  set the same PIO mode on the device and the host

* pass correct "pio" argument (255 instead of 5) to sis5513_tune_drive() call
  in sis5513_config_xfer_rate() so the best PIO mode is set on the drive
  and not PIO4

* rename sis5513_tune_drive() to sis5513_tuneproc()
  and config_chipset_for_pio() to sis5513_tune_driver()

* bump driver version

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---

 drivers/ide/pci/sis5513.c |   85 +++++++++++++++++++---------------------------
 1 file changed, 36 insertions(+), 49 deletions(-)

Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -1,9 +1,11 @@
 /*
- * linux/drivers/ide/pci/sis5513.c	Version 0.16ac+vp	Jun 18, 2003
+ * linux/drivers/ide/pci/sis5513.c	Version 0.20	Mar 4, 2007
  *
  * Copyright (C) 1999-2000	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2002		Lionel Bouton <Lionel.Bouton@inet6.fr>, Maintainer
  * Copyright (C) 2003		Vojtech Pavlik <vojtech@suse.cz>
+ * Copyright (C) 2007		Bartlomiej Zolnierkiewicz
+ *
  * May be copied or modified under the terms of the GNU General Public License
  *
  *
@@ -448,36 +450,15 @@ static void config_drive_art_rwp (ide_dr
 		pci_write_config_byte(dev, 0x4b, reg4bh|rw_prefetch);
 }
 
-
 /* Set per-drive active and recovery time */
 static void config_art_rwp_pio (ide_drive_t *drive, u8 pio)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
 
-	u8			timing, drive_pci, test1, test2;
-
-	u16 eide_pio_timing[6] = {600, 390, 240, 180, 120, 90};
-	u16 xfer_pio = drive->id->eide_pio_modes;
+	u8 drive_pci, test1, test2;
 
 	config_drive_art_rwp(drive);
-	pio = ide_get_best_pio_mode(drive, 255, pio, NULL);
-
-	if (xfer_pio> 4)
-		xfer_pio = 0;
-
-	if (drive->id->eide_pio_iordy > 0) {
-		for (xfer_pio = 5;
-			(xfer_pio > 0) &&
-			(drive->id->eide_pio_iordy > eide_pio_timing[xfer_pio]);
-			xfer_pio--);
-	} else {
-		xfer_pio = (drive->id->eide_pio_modes & 4) ? 0x05 :
-			   (drive->id->eide_pio_modes & 2) ? 0x04 :
-			   (drive->id->eide_pio_modes & 1) ? 0x03 : xfer_pio;
-	}
-
-	timing = (xfer_pio >= pio) ? xfer_pio : pio;
 
 	/* In pre ATA_133 case, drives sit at 0x40 + 4*drive->dn */
 	drive_pci = 0x40;
@@ -500,17 +481,18 @@ static void config_art_rwp_pio (ide_driv
 		test1 &= ~0x0F;
 		test2 &= ~0x07;
 
-		switch(timing) {
+		switch(pio) {
 			case 4:		test1 |= 0x01; test2 |= 0x03; break;
 			case 3:		test1 |= 0x03; test2 |= 0x03; break;
 			case 2:		test1 |= 0x04; test2 |= 0x04; break;
 			case 1:		test1 |= 0x07; test2 |= 0x06; break;
+			case 0:		/* PIO0: register setting == X000 */
 			default:	break;
 		}
 		pci_write_config_byte(dev, drive_pci, test1);
 		pci_write_config_byte(dev, drive_pci+1, test2);
 	} else if (chipset_family < ATA_133) {
-		switch(timing) { /*		active  recovery
+		switch(pio) { /*		active  recovery
 						  v     v */
 			case 4:		test1 = 0x30|0x01; break;
 			case 3:		test1 = 0x30|0x03; break;
@@ -525,24 +507,28 @@ static void config_art_rwp_pio (ide_driv
 		pci_read_config_dword(dev, drive_pci, &test3);
 		test3 &= 0xc0c00fff;
 		if (test3 & 0x08) {
-			test3 |= (unsigned long)ini_time_value[ATA_133][timing] << 12;
-			test3 |= (unsigned long)act_time_value[ATA_133][timing] << 16;
-			test3 |= (unsigned long)rco_time_value[ATA_133][timing] << 24;
+			test3 |= ini_time_value[ATA_133][pio] << 12;
+			test3 |= act_time_value[ATA_133][pio] << 16;
+			test3 |= rco_time_value[ATA_133][pio] << 24;
 		} else {
-			test3 |= (unsigned long)ini_time_value[ATA_100][timing] << 12;
-			test3 |= (unsigned long)act_time_value[ATA_100][timing] << 16;
-			test3 |= (unsigned long)rco_time_value[ATA_100][timing] << 24;
+			test3 |= ini_time_value[ATA_100][pio] << 12;
+			test3 |= act_time_value[ATA_100][pio] << 16;
+			test3 |= rco_time_value[ATA_100][pio] << 24;
 		}
 		pci_write_config_dword(dev, drive_pci, test3);
 	}
 }
 
-static int config_chipset_for_pio (ide_drive_t *drive, u8 pio)
+static int sis5513_tune_drive(ide_drive_t *drive, u8 pio)
 {
-	if (pio == 255)
-		pio = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
+	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
 	config_art_rwp_pio(drive, pio);
-	return ide_config_drive_speed(drive, XFER_PIO_0 + min_t(u8, pio, 4));
+	return ide_config_drive_speed(drive, XFER_PIO_0 + pio);
+}
+
+static void sis5513_tuneproc(ide_drive_t *drive, u8 pio)
+{
+	(void)sis5513_tune_drive(drive, pio);
 }
 
 static int sis5513_tune_chipset (ide_drive_t *drive, u8 xferspeed)
@@ -622,25 +608,26 @@ static int sis5513_tune_chipset (ide_dri
 		case XFER_SW_DMA_1:
 		case XFER_SW_DMA_0:
 			break;
-		case XFER_PIO_4: return((int) config_chipset_for_pio(drive, 4));
-		case XFER_PIO_3: return((int) config_chipset_for_pio(drive, 3));
-		case XFER_PIO_2: return((int) config_chipset_for_pio(drive, 2));
-		case XFER_PIO_1: return((int) config_chipset_for_pio(drive, 1));
+		case XFER_PIO_4:
+		case XFER_PIO_3:
+		case XFER_PIO_2:
+		case XFER_PIO_1:
 		case XFER_PIO_0:
-		default:	 return((int) config_chipset_for_pio(drive, 0));	
+			return sis5513_tune_drive(drive, speed - XFER_PIO_0);
+		default:
+			BUG();
+			break;
 	}
 
-	return ((int) ide_config_drive_speed(drive, speed));
-}
-
-static void sis5513_tune_drive (ide_drive_t *drive, u8 pio)
-{
-	(void) config_chipset_for_pio(drive, pio);
+	return ide_config_drive_speed(drive, speed);
 }
 
 static int sis5513_config_xfer_rate(ide_drive_t *drive)
 {
-	config_art_rwp_pio(drive, 5);
+	/*
+	 * TODO: always set PIO mode and remove this
+	 */
+	sis5513_tuneproc(drive, 255);
 
 	drive->init_speed = 0;
 
@@ -648,7 +635,7 @@ static int sis5513_config_xfer_rate(ide_
 		return 0;
 
 	if (ide_use_fast_pio(drive))
-		sis5513_tune_drive(drive, 5);
+		sis5513_tuneproc(drive, 255);
 
 	return -1;
 }
@@ -836,7 +823,7 @@ static void __devinit init_hwif_sis5513 
 	if (!hwif->irq)
 		hwif->irq = hwif->channel ? 15 : 14;
 
-	hwif->tuneproc = &sis5513_tune_drive;
+	hwif->tuneproc = &sis5513_tuneproc;
 	hwif->speedproc = &sis5513_tune_chipset;
 
 	if (!(hwif->dma_base)) {
