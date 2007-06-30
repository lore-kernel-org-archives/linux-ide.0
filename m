From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/15] ide: remove ide_find_best_pio_mode()
Date: Sat, 30 Jun 2007 21:06:01 +0200
Message-ID: <200706302106.01458.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:9948 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754254AbXF3TAO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jun 2007 15:00:14 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1014824ugf
        for <linux-ide@vger.kernel.org>; Sat, 30 Jun 2007 12:00:13 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Add ->host_flags to ide_hwif_t to store ide_pci_device_t.host_flags,
  assign it in setup-pci.c:ide_pci_setup_ports().

* Add IDE_HFLAG_PIO_NO_{BLACKLIST,DOWNGRADE} to ide_pci_device_t.host_flags
  and teach ide_get_best_pio_mode() about them.  Also remove needless
  !drive->id check while at it (drive->id is always present).

* Convert amd74xx, via82cxxx and ide-timing.h to use ide_get_best_pio_mode()
  and then remove no longer needed ide_find_best_pio_mode().

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-lib.c       |   13 +++++++------
 drivers/ide/ide-timing.h    |   18 ++----------------
 drivers/ide/ide.c           |    2 ++
 drivers/ide/pci/amd74xx.c   |   20 ++++++++++++--------
 drivers/ide/pci/via82cxxx.c |   22 +++++++++++++---------
 drivers/ide/setup-pci.c     |    2 ++
 include/linux/ide.h         |    7 +++++++
 7 files changed, 45 insertions(+), 39 deletions(-)

Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -291,11 +291,11 @@ u8 ide_get_best_pio_mode (ide_drive_t *d
 	struct hd_driveid* id = drive->id;
 	int overridden  = 0;
 
-	if (mode_wanted != 255) {
-		pio_mode = mode_wanted;
-	} else if (!drive->id) {
-		pio_mode = 0;
-	} else if ((pio_mode = ide_scan_pio_blacklist(id->model)) != -1) {
+	if (mode_wanted != 255)
+		return min_t(u8, mode_wanted, max_mode);
+
+	if ((drive->hwif->host_flags & IDE_HFLAG_PIO_NO_BLACKLIST) == 0 &&
+	    (pio_mode = ide_scan_pio_blacklist(id->model)) != -1) {
 		printk(KERN_INFO "%s: is on PIO blacklist\n", drive->name);
 	} else {
 		pio_mode = id->tPIO;
@@ -324,7 +324,8 @@ u8 ide_get_best_pio_mode (ide_drive_t *d
 		/*
 		 * Conservative "downgrade" for all pre-ATA2 drives
 		 */
-		if (pio_mode && pio_mode < 4) {
+		if ((drive->hwif->host_flags & IDE_HFLAG_PIO_NO_DOWNGRADE) == 0 &&
+		    pio_mode && pio_mode < 4) {
 			pio_mode--;
 			printk(KERN_INFO "%s: applying conservative "
 					 "PIO \"downgrade\"\n", drive->name);
Index: b/drivers/ide/ide-timing.h
===================================================================
--- a/drivers/ide/ide-timing.h
+++ b/drivers/ide/ide-timing.h
@@ -106,21 +106,6 @@ static struct ide_timing ide_timing[] = 
 #define XFER_EPIO	0x01
 #define XFER_PIO	0x00
 
-static short ide_find_best_pio_mode(ide_drive_t *drive)
-{
-	struct hd_driveid *id = drive->id;
-	short best = 0;
-
-	/* EIDE PIO modes */
-	if ((id->field_valid & 2) && (id->capability & 8)) {
-		if ((best = (drive->id->eide_pio_modes & 4) ? XFER_PIO_5 :
-			    (drive->id->eide_pio_modes & 2) ? XFER_PIO_4 :
-			    (drive->id->eide_pio_modes & 1) ? XFER_PIO_3 : 0)) return best;
-	}
-
-	return min_t(u8, id->tPIO, 2);
-}
-
 static void ide_timing_quantize(struct ide_timing *t, struct ide_timing *q, int T, int UT)
 {
 	q->setup   = EZ(t->setup   * 1000,  T);
@@ -210,7 +195,8 @@ static int ide_timing_compute(ide_drive_
  */
 
 	if ((speed & XFER_MODE) != XFER_PIO) {
-		ide_timing_compute(drive, ide_find_best_pio_mode(drive), &p, T, UT);
+		u8 pio = ide_get_best_pio_mode(drive, 255, 5);
+		ide_timing_compute(drive, XFER_PIO_0 + pio, &p, T, UT);
 		ide_timing_merge(&p, t, t, IDE_TIMING_ALL);
 	}
 
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -455,6 +455,8 @@ static void ide_hwif_restore(ide_hwif_t 
 	hwif->straight8			= tmp_hwif->straight8;
 	hwif->bus_state			= tmp_hwif->bus_state;
 
+	hwif->host_flags		= tmp_hwif->host_flags;
+
 	hwif->atapi_dma			= tmp_hwif->atapi_dma;
 	hwif->ultra_mask		= tmp_hwif->ultra_mask;
 	hwif->mwdma_mask		= tmp_hwif->mwdma_mask;
Index: b/drivers/ide/pci/amd74xx.c
===================================================================
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -1,5 +1,5 @@
 /*
- * Version 2.20
+ * Version 2.21
  *
  * AMD 755/756/766/8111 and nVidia nForce/2/2s/3/3s/CK804/MCP04
  * IDE driver for Linux.
@@ -275,10 +275,8 @@ static int amd_set_drive(ide_drive_t *dr
 
 static void amd74xx_tune_drive(ide_drive_t *drive, u8 pio)
 {
-	if (pio == 255) {
-		amd_set_drive(drive, ide_find_best_pio_mode(drive));
-		return;
-	}
+	if (pio == 255)
+		pio = ide_get_best_pio_mode(drive, 255, 5);
 
 	amd_set_drive(drive, XFER_PIO_0 + min_t(byte, pio, 5));
 }
@@ -287,12 +285,14 @@ static int amd74xx_ide_dma_check(ide_dri
 {
 	u8 speed = ide_max_dma_mode(drive);
 
-	if (speed == 0)
-		speed = ide_find_best_pio_mode(drive);
+	if (speed == 0) {
+		amd74xx_tune_drive(drive, 255);
+		return -1;
+	}
 
 	amd_set_drive(drive, speed);
 
-	if (drive->autodma && (speed & XFER_MODE) != XFER_PIO)
+	if (drive->autodma)
 		return 0;
 
 	return -1;
@@ -455,6 +455,8 @@ static void __devinit init_hwif_amd74xx(
 		.autodma	= AUTODMA,				\
 		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},	\
 		.bootable	= ON_BOARD,				\
+		.host_flags	= IDE_HFLAG_PIO_NO_BLACKLIST		\
+				| IDE_HFLAG_PIO_NO_DOWNGRADE,		\
 	}
 
 #define DECLARE_NV_DEV(name_str)					\
@@ -465,6 +467,8 @@ static void __devinit init_hwif_amd74xx(
 		.autodma	= AUTODMA,				\
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},	\
 		.bootable	= ON_BOARD,				\
+		.host_flags	= IDE_HFLAG_PIO_NO_BLACKLIST		\
+				| IDE_HFLAG_PIO_NO_DOWNGRADE,		\
 	}
 
 static ide_pci_device_t amd74xx_chipsets[] __devinitdata = {
Index: b/drivers/ide/pci/via82cxxx.c
===================================================================
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -1,6 +1,6 @@
 /*
  *
- * Version 3.45
+ * Version 3.46
  *
  * VIA IDE driver for Linux. Supported southbridges:
  *
@@ -203,10 +203,8 @@ static int via_set_drive(ide_drive_t *dr
 
 static void via82cxxx_tune_drive(ide_drive_t *drive, u8 pio)
 {
-	if (pio == 255) {
-		via_set_drive(drive, ide_find_best_pio_mode(drive));
-		return;
-	}
+	if (pio == 255)
+		pio = ide_get_best_pio_mode(drive, 255, 5);
 
 	via_set_drive(drive, XFER_PIO_0 + min_t(u8, pio, 5));
 }
@@ -223,12 +221,14 @@ static int via82cxxx_ide_dma_check (ide_
 {
 	u8 speed = ide_max_dma_mode(drive);
 
-	if (speed == 0)
-		speed = ide_find_best_pio_mode(drive);
+	if (speed == 0) {
+		via82cxxx_tune_drive(drive, 255);
+		return -1;
+	}
 
 	via_set_drive(drive, speed);
 
-	if (drive->autodma && (speed & XFER_MODE) != XFER_PIO)
+	if (drive->autodma)
 		return 0;
 
 	return -1;
@@ -503,7 +503,9 @@ static ide_pci_device_t via82cxxx_chipse
 		.init_hwif	= init_hwif_via82cxxx,
 		.autodma	= NOAUTODMA,
 		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
-		.bootable	= ON_BOARD
+		.bootable	= ON_BOARD,
+		.host_flags	= IDE_HFLAG_PIO_NO_BLACKLIST
+				| IDE_HFLAG_PIO_NO_DOWNGRADE,
 	},{	/* 1 */
 		.name		= "VP_IDE",
 		.init_chipset	= init_chipset_via82cxxx,
@@ -511,6 +513,8 @@ static ide_pci_device_t via82cxxx_chipse
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
+		.host_flags	= IDE_HFLAG_PIO_NO_BLACKLIST
+				| IDE_HFLAG_PIO_NO_DOWNGRADE,
 	}
 };
 
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -613,6 +613,8 @@ void ide_pci_setup_ports(struct pci_dev 
 		else
 			ide_hwif_setup_dma(dev, d, hwif);
 bypass_legacy_dma:
+		hwif->host_flags = d->host_flags;
+
 		if (d->init_hwif)
 			/* Call chipset-specific routine
 			 * for each enabled hwif
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -681,6 +681,8 @@ typedef struct hwif_s {
 	u8 straight8;	/* Alan's straight 8 check */
 	u8 bus_state;	/* power state of the IDE bus */
 
+	u8 host_flags;
+
 	u8 atapi_dma;	/* host supports atapi_dma */
 	u8 ultra_mask;
 	u8 mwdma_mask;
@@ -1245,7 +1247,12 @@ typedef struct ide_pci_enablebit_s {
 enum {
 	/* Uses ISA control ports not PCI ones. */
 	IDE_HFLAG_ISA_PORTS		= (1 << 0),
+	/* single port device */
 	IDE_HFLAG_SINGLE		= (1 << 1),
+	/* don't use legacy PIO blacklist */
+	IDE_HFLAG_PIO_NO_BLACKLIST	= (1 << 2),
+	/* don't use conservative PIO "downgrade" */
+	IDE_HFLAG_PIO_NO_DOWNGRADE	= (1 << 3),
 };
 
 typedef struct ide_pci_device_s {
