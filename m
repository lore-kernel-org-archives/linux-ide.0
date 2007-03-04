From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] serverworks: PIO mode setup fixes
Date: Sun, 4 Mar 2007 23:01:42 +0100
Message-ID: <200703042301.42662.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:37143 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbXCDVzE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Mar 2007 16:55:04 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1096849uga
        for <linux-ide@vger.kernel.org>; Sun, 04 Mar 2007 13:55:02 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


[PATCH] serverworks: PIO mode setup fixes

* limit max PIO mode to PIO4, this driver doesn't support PIO5 and attempt
  to program PIO5 by svwks_tune_chipset() could result in incorrect PIO
  timings being programmed and possibly the data corruption (it seems that
  the minimum possible values were used but I lack the datasheets to be sure)

* select best PIO mode in svwks_tune_drive() and not in svwks_tune_chipset()
  when doing PIO autotuning (pio == 255)

* don't try to tune PIO in config_chipset_for_dma() as ide_dma_enable() could
  return 1 if DMA was previously enabled (svwks_config_drive_xfer_rate()
  takes care of PIO tuning if no suitable DMA mode is found)

* remove config_chipset_for_pio() and use svwks_tune_drive() instead,
  config_chipset_for_pio() contained numerous bugs when selecting PIO mode
  (luckily it was only used for devices limited to PIO by capabilities/BIOS):

  - it didn't check for validity of id->eide_pio_modes and id->eide_pio_iordy
    before using them

  - it tried to found out maximum PIO mode basing on minimum IORDY cycle time
    (moreover wrong cycle times were used for PIO0/1/5)

  - it was overriding PIO blacklist and conservative PIO "downgrade" done
    by ide_get_best_pio_mode()

  - if the max drive PIO was PIO5 then XFER_PIO_0/XFER_PIO_SLOW was selected
    (XFER_PIO_SLOW is not supported by svwks_tune_chipset() so the result
     was the same as if using XFER_PIO_5 => wrong PIO timings were set)

  - it was overriding drive->current_speed

* bump driver version

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---

 drivers/ide/pci/serverworks.c |   68 +++++++++---------------------------------
 1 file changed, 15 insertions(+), 53 deletions(-)

Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -1,9 +1,10 @@
 /*
- * linux/drivers/ide/pci/serverworks.c		Version 0.8	 25 Ebr 2003
+ * linux/drivers/ide/pci/serverworks.c		Version 0.9	Mar 4 2007
  *
  * Copyright (C) 1998-2000 Michel Aubry
  * Copyright (C) 1998-2000 Andrzej Krzysztofowicz
  * Copyright (C) 1998-2000 Andre Hedrick <andre@linux-ide.org>
+ * Copyright (C)      2007 Bartlomiej Zolnierkiewicz
  * Portions copyright (c) 2001 Sun Microsystems
  *
  *
@@ -136,19 +137,14 @@ static int svwks_tune_chipset (ide_drive
 
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
-	u8 speed;
-	u8 pio			= ide_get_best_pio_mode(drive, 255, 5, NULL);
+	u8 speed		= ide_rate_filter(drive, xferspeed);
+	u8 pio			= ide_get_best_pio_mode(drive, 255, 4, NULL);
 	u8 unit			= (drive->select.b.unit & 0x01);
 	u8 csb5			= svwks_csb_check(dev);
 	u8 ultra_enable		= 0, ultra_timing = 0;
 	u8 dma_timing		= 0, pio_timing = 0;
 	u16 csb5_pio		= 0;
 
-	if (xferspeed == 255)	/* PIO auto-tuning */
-		speed = XFER_PIO_0 + pio;
-	else
-		speed = ide_rate_filter(drive, xferspeed);
-
 	/* If we are about to put a disk into UDMA mode we screwed up.
 	   Our code assumes we never _ever_ do this on an OSB4 */
 	   
@@ -231,6 +227,9 @@ oem_setup_failed:
 		case XFER_MW_DMA_2:
 		case XFER_MW_DMA_1:
 		case XFER_MW_DMA_0:
+			/*
+			 * TODO: always setup PIO mode so this won't be needed
+			 */
 			pio_timing |= pio_modes[pio];
 			csb5_pio   |= (pio << (4*drive->dn));
 			dma_timing |= dma_modes[speed - XFER_MW_DMA_0];
@@ -242,6 +241,9 @@ oem_setup_failed:
 		case XFER_UDMA_2:
 		case XFER_UDMA_1:
 		case XFER_UDMA_0:
+			/*
+			 * TODO: always setup PIO mode so this won't be needed
+			 */
 			pio_timing   |= pio_modes[pio];
 			csb5_pio     |= (pio << (4*drive->dn));
 			dma_timing   |= dma_modes[2];
@@ -262,58 +264,18 @@ oem_setup_failed:
 	return (ide_config_drive_speed(drive, speed));
 }
 
-static void config_chipset_for_pio (ide_drive_t *drive)
-{
-	u16 eide_pio_timing[6] = {960, 480, 240, 180, 120, 90};
-	u16 xfer_pio = drive->id->eide_pio_modes;
-	u8 timing, speed, pio;
-
-	pio = ide_get_best_pio_mode(drive, 255, 5, NULL);
-
-	if (xfer_pio > 4)
-		xfer_pio = 0;
-
-	if (drive->id->eide_pio_iordy > 0)
-		for (xfer_pio = 5;
-			xfer_pio>0 &&
-			drive->id->eide_pio_iordy>eide_pio_timing[xfer_pio];
-			xfer_pio--);
-	else
-		xfer_pio = (drive->id->eide_pio_modes & 4) ? 0x05 :
-			   (drive->id->eide_pio_modes & 2) ? 0x04 :
-			   (drive->id->eide_pio_modes & 1) ? 0x03 :
-			   (drive->id->tPIO & 2) ? 0x02 :
-			   (drive->id->tPIO & 1) ? 0x01 : xfer_pio;
-
-	timing = (xfer_pio >= pio) ? xfer_pio : pio;
-
-	switch(timing) {
-		case 4: speed = XFER_PIO_4;break;
-		case 3: speed = XFER_PIO_3;break;
-		case 2: speed = XFER_PIO_2;break;
-		case 1: speed = XFER_PIO_1;break;
-		default:
-			speed = (!drive->id->tPIO) ? XFER_PIO_0 : XFER_PIO_SLOW;
-			break;
-	}
-	(void) svwks_tune_chipset(drive, speed);
-	drive->current_speed = speed;
-}
-
 static void svwks_tune_drive (ide_drive_t *drive, u8 pio)
 {
-	if(pio == 255)
-		(void) svwks_tune_chipset(drive, 255);
-	else
-		(void) svwks_tune_chipset(drive, (XFER_PIO_0 + pio));
+	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	(void)svwks_tune_chipset(drive, XFER_PIO_0 + pio);
 }
 
 static int config_chipset_for_dma (ide_drive_t *drive)
 {
 	u8 speed = ide_max_dma_mode(drive);
 
-	if (!(speed))
-		speed = XFER_PIO_0 + ide_get_best_pio_mode(drive, 255, 5, NULL);
+	if (!speed)
+		return 0;
 
 	(void) svwks_tune_chipset(drive, speed);
 	return ide_dma_enable(drive);
@@ -327,7 +289,7 @@ static int svwks_config_drive_xfer_rate 
 		return 0;
 
 	if (ide_use_fast_pio(drive))
-		config_chipset_for_pio(drive);
+		svwks_tune_drive(drive, 255);
 
 	return -1;
 }
