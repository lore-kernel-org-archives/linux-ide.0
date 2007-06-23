From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/6] siimage: PIO mode setup fixes
Date: Sat, 23 Jun 2007 20:04:08 +0200
Message-ID: <200706232004.08914.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:28896 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755852AbXFWRw7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jun 2007 13:52:59 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1019618ugf
        for <linux-ide@vger.kernel.org>; Sat, 23 Jun 2007 10:52:59 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Add sil_tuneproc() wrapper for siimage_tuneproc() which also sets
  PIO mode on the device.

* Add missing ide_get_best_pio_mode() call to sil_tuneproc() so
  "pio" == 255 (autotune) is handled correctly (previously PIO0 was used)
  and "pio" values > 4 && < 255 are filtered to PIO4 (instead of PIO0).

* Add code limiting maximum PIO mode according to the pair device capabilities
  to sil_tuneproc().

* Convert users of config_siimage_chipset_for_pio() to use sil_tune_pio() and
  sil_tuneproc().  This fixes PIO fallback in siimage_config_drive_for_dma() to
  use max PIO mode available instead of PIO4 (config_siimage_chipset_for_pio()
  used wrong arguments for ide_get_best_pio_mode() and as a results always
  tried to set PIO4).

* Remove no longer needed siimage_taskfile_timing()
  and config_siimage_chipset_for_pio().

* Bump driver version.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/siimage.c |  108 +++++++++++++++-------------------------------
 1 file changed, 36 insertions(+), 72 deletions(-)

Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -1,9 +1,10 @@
 /*
- * linux/drivers/ide/pci/siimage.c		Version 1.12	Mar 10 2007
+ * linux/drivers/ide/pci/siimage.c		Version 1.15	Jun 16 2007
  *
  * Copyright (C) 2001-2002	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2003		Red Hat <alan@redhat.com>
  * Copyright (C) 2007		MontaVista Software, Inc.
+ * Copyright (C) 2007		Bartlomiej Zolnierkiewicz
  *
  *  May be copied or modified under the terms of the GNU General Public License
  *
@@ -31,6 +32,9 @@
  *  unplugging/replugging the virtual CD interface when the DRAC is reset.
  *  This often causes drivers/ide/siimage to panic but is ok with the rather
  *  smarter code in libata.
+ *
+ * TODO:
+ * - VDMA support
  */
 
 #include <linux/types.h>
@@ -160,54 +164,39 @@ out:
 }
 
 /**
- *	siimage_taskfile_timing	-	turn timing data to a mode
- *	@hwif: interface to query
- *
- *	Read the timing data for the interface and return the 
- *	mode that is being used.
- */
- 
-static byte siimage_taskfile_timing (ide_hwif_t *hwif)
-{
-	u16 timing	= 0x328a;
-	unsigned long addr = siimage_selreg(hwif, 2);
-
-	if (hwif->mmio)
-		timing = hwif->INW(addr);
-	else
-		pci_read_config_word(hwif->pci_dev, addr, &timing);
-
-	switch (timing) {
-		case 0x10c1:	return 4;
-		case 0x10c3:	return 3;
-		case 0x1104:
-		case 0x1281:	return 2;
-		case 0x2283:	return 1;
-		case 0x328a:
-		default:	return 0;
-	}
-}
-
-/**
- *	simmage_tuneproc	-	tune a drive
+ *	sil_tune_pio	-	tune a drive
  *	@drive: drive to tune
- *	@mode_wanted: the target operating mode
+ *	@pio: the desired PIO mode
  *
  *	Load the timing settings for this device mode into the
  *	controller. If we are in PIO mode 3 or 4 turn on IORDY
  *	monitoring (bit 9). The TF timing is bits 31:16
  */
- 
-static void siimage_tuneproc (ide_drive_t *drive, byte mode_wanted)
+
+static void sil_tune_pio(ide_drive_t *drive, u8 pio)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
+	ide_drive_t *pair	= &hwif->drives[1 - drive->select.b.unit];
 	u32 speedt		= 0;
 	u16 speedp		= 0;
 	unsigned long addr	= siimage_seldev(drive, 0x04);
 	unsigned long tfaddr	= siimage_selreg(hwif, 0x02);
-	
+
+	/*
+	 * Compute the best PIO mode we can for a given device. We must
+	 * pick a speed that does not cause problems with the other device
+	 * on the cable.
+	 */
+	if (pair) {
+		u8 pair_pio = ide_get_best_pio_mode(pair, 255, 4, NULL);
+
+		/* trim PIO to the slowest of the master/slave */
+		if (pair_pio < pio)
+			pio = pair_pio;
+	}
+
 	/* cheat for now and use the docs */
-	switch (mode_wanted) {
+	switch (pio) {
 	case 4:
 		speedp = 0x10c1;
 		speedt = 0x10c1;
@@ -235,7 +224,7 @@ static void siimage_tuneproc (ide_drive_
 		hwif->OUTW(speedp, addr);
 		hwif->OUTW(speedt, tfaddr);
 		/* Now set up IORDY */
-		if(mode_wanted == 3 || mode_wanted == 4)
+		if (pio == 3 || pio == 4)
 			hwif->OUTW(hwif->INW(tfaddr-2)|0x200, tfaddr-2);
 		else
 			hwif->OUTW(hwif->INW(tfaddr-2)&~0x200, tfaddr-2);
@@ -245,42 +234,17 @@ static void siimage_tuneproc (ide_drive_
 		pci_read_config_word(hwif->pci_dev, tfaddr-2, &speedp);
 		speedp &= ~0x200;
 		/* Set IORDY for mode 3 or 4 */
-		if(mode_wanted == 3 || mode_wanted == 4)
+		if (pio == 3 || pio == 4)
 			speedp |= 0x200;
 		pci_write_config_word(hwif->pci_dev, tfaddr-2, speedp);
 	}
 }
 
-/**
- *	config_siimage_chipset_for_pio	-	set drive timings
- *	@drive: drive to tune
- *	@speed we want
- *
- *	Compute the best pio mode we can for a given device. Also honour
- *	the timings for the driver when dealing with mixed devices. Some
- *	of this is ugly but its all wrapped up here
- *
- *	The SI680 can also do VDMA - we need to start using that
- *
- *	FIXME: we use the BIOS channel timings to avoid driving the task
- *	files too fast at the disk. We need to compute the master/slave
- *	drive PIO mode properly so that we can up the speed on a hotplug
- *	system.
- */
- 
-static void config_siimage_chipset_for_pio (ide_drive_t *drive, byte set_speed)
+static void sil_tuneproc(ide_drive_t *drive, u8 pio)
 {
-	u8 channel_timings	= siimage_taskfile_timing(HWIF(drive));
-	u8 speed = 0, set_pio	= ide_get_best_pio_mode(drive, 4, 5, NULL);
-
-	/* WARNING PIO timing mess is going to happen b/w devices, argh */
-	if ((channel_timings != set_pio) && (set_pio > channel_timings))
-		set_pio = channel_timings;
-
-	siimage_tuneproc(drive, set_pio);
-	speed = XFER_PIO_0 + set_pio;
-	if (set_speed)
-		(void) ide_config_drive_speed(drive, speed);
+	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	sil_tune_pio(drive, pio);
+	(void)ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
 
 /**
@@ -335,7 +299,7 @@ static int siimage_tune_chipset (ide_dri
 		case XFER_PIO_2:
 		case XFER_PIO_1:
 		case XFER_PIO_0:
-			siimage_tuneproc(drive, (speed - XFER_PIO_0));
+			sil_tune_pio(drive, speed - XFER_PIO_0);
 			mode |= ((unit) ? 0x10 : 0x01);
 			break;
 		case XFER_MW_DMA_2:
@@ -343,7 +307,7 @@ static int siimage_tune_chipset (ide_dri
 		case XFER_MW_DMA_0:
 			multi = dma[speed - XFER_MW_DMA_0];
 			mode |= ((unit) ? 0x20 : 0x02);
-			config_siimage_chipset_for_pio(drive, 0);
+			sil_tune_pio(drive, 4); /* FIXME */
 			break;
 		case XFER_UDMA_6:
 		case XFER_UDMA_5:
@@ -356,7 +320,7 @@ static int siimage_tune_chipset (ide_dri
 			ultra |= ((scsc) ? (ultra6[speed - XFER_UDMA_0]) :
 					   (ultra5[speed - XFER_UDMA_0]));
 			mode |= ((unit) ? 0x30 : 0x03);
-			config_siimage_chipset_for_pio(drive, 0);
+			sil_tune_pio(drive, 4); /* FIXME */
 			break;
 		default:
 			return 1;
@@ -390,7 +354,7 @@ static int siimage_config_drive_for_dma 
 		return 0;
 
 	if (ide_use_fast_pio(drive))
-		config_siimage_chipset_for_pio(drive, 1);
+		sil_tuneproc(drive, 255);
 
 	return -1;
 }
@@ -961,7 +925,7 @@ static void __devinit init_hwif_siimage(
 	
 	hwif->resetproc = &siimage_reset;
 	hwif->speedproc = &siimage_tune_chipset;
-	hwif->tuneproc	= &siimage_tuneproc;
+	hwif->tuneproc	= &sil_tuneproc;
 	hwif->reset_poll = &siimage_reset_poll;
 	hwif->pre_reset = &siimage_pre_reset;
 	hwif->udma_filter = &sil_udma_filter;
