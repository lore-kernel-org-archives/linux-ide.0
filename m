From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: convert ide_find_best_mode() users to use ide_max_dma_mode()
Date: Sat, 9 Jun 2007 22:10:51 +0200
Message-ID: <200706092210.52291.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:56696 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759319AbXFIT5t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Jun 2007 15:57:49 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1192213ugf
        for <linux-ide@vger.kernel.org>; Sat, 09 Jun 2007 12:57:47 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


ide-timing.h:

* remove handling of DMA modes from ide_find_best_mode() and rename it to
  ide_find_best_pio_mode()

* drop no longer needed "map" argument from ide_find_best_pio_mode()
  and delete needless ->id check

* remove no longer needed XFER_SWDMA and XFER_UDMA* defines

au1xxx-ide.c:

* use ide_max_dma_mode() instead of ide_find_best_mode()

* remove needless CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA #ifdef

amd74xx.c:

* store UDMA masks in amd_ide_chip[] and while at it make "base" field
  to be u8 instead of unsigned long

* convert the driver to use UDMA masks from amd_ide_chip[]

* use ide_max_dma_mode() and ide_find_best_pio_mode() instead
  of ide_find_best_mode()

* delete stale comment from amd74xx_ide_dma_check()

* remove no longer needed AMD_UDMA* defines

via82cxxx.c:

* remove unused DISPLAY_VIA_TIMINGS define

* store UDMA masks in via_isa_bridges[] and while at it make "flags" field
  to be u8 instead of u16

* convert the driver to use UDMA masks from via_isa_bridges[]

* use ide_max_dma_mode() and ide_find_best_pio_mode() instead
  of ide_find_best_mode()

* remove no longer needed VIA_UDMA* defines

pmac.c:

* use ide_max_dma_mode() instead of ide_find_best_mode()

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-timing.h      |   56 -----------------
 drivers/ide/mips/au1xxx-ide.c |    7 --
 drivers/ide/pci/amd74xx.c     |  118 +++++++++++++++++--------------------
 drivers/ide/pci/via82cxxx.c   |  132 +++++++++++++++++++-----------------------
 drivers/ide/ppc/pmac.c        |   25 +------
 5 files changed, 123 insertions(+), 215 deletions(-)

Index: b/drivers/ide/ide-timing.h
===================================================================
--- a/drivers/ide/ide-timing.h
+++ b/drivers/ide/ide-timing.h
@@ -102,66 +102,16 @@ static struct ide_timing ide_timing[] = 
 #define EZ(v,unit)		((v)?ENOUGH(v,unit):0)
 
 #define XFER_MODE	0xf0
-#define XFER_UDMA_133	0x48
-#define XFER_UDMA_100	0x44
-#define XFER_UDMA_66	0x42
-#define XFER_UDMA	0x40
 #define XFER_MWDMA	0x20
-#define XFER_SWDMA	0x10
 #define XFER_EPIO	0x01
 #define XFER_PIO	0x00
 
-static short ide_find_best_mode(ide_drive_t *drive, int map)
+static short ide_find_best_pio_mode(ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
 	short best = 0;
 
-	if (!id)
-		return XFER_PIO_SLOW;
-
-	if ((map & XFER_UDMA) && (id->field_valid & 4)) {	/* Want UDMA and UDMA bitmap valid */
-
-		if ((map & XFER_UDMA_133) == XFER_UDMA_133)
-			if ((best = (id->dma_ultra & 0x0040) ? XFER_UDMA_6 : 0)) return best;
-
-		if ((map & XFER_UDMA_100) == XFER_UDMA_100)
-			if ((best = (id->dma_ultra & 0x0020) ? XFER_UDMA_5 : 0)) return best;
-
-		if ((map & XFER_UDMA_66) == XFER_UDMA_66)
-			if ((best = (id->dma_ultra & 0x0010) ? XFER_UDMA_4 :
-                	    	    (id->dma_ultra & 0x0008) ? XFER_UDMA_3 : 0)) return best;
-
-                if ((best = (id->dma_ultra & 0x0004) ? XFER_UDMA_2 :
-                	    (id->dma_ultra & 0x0002) ? XFER_UDMA_1 :
-                	    (id->dma_ultra & 0x0001) ? XFER_UDMA_0 : 0)) return best;
-	}
-
-	if ((map & XFER_MWDMA) && (id->field_valid & 2)) {	/* Want MWDMA and drive has EIDE fields */
-
-		if ((best = (id->dma_mword & 0x0004) ? XFER_MW_DMA_2 :
-                	    (id->dma_mword & 0x0002) ? XFER_MW_DMA_1 :
-                	    (id->dma_mword & 0x0001) ? XFER_MW_DMA_0 : 0)) return best;
-	}
-
-	if (map & XFER_SWDMA) {					/* Want SWDMA */
-
- 		if (id->field_valid & 2) {			/* EIDE SWDMA */
-
-			if ((best = (id->dma_1word & 0x0004) ? XFER_SW_DMA_2 :
-      				    (id->dma_1word & 0x0002) ? XFER_SW_DMA_1 :
-				    (id->dma_1word & 0x0001) ? XFER_SW_DMA_0 : 0)) return best;
-		}
-
-		if (id->capability & 1) {			/* Pre-EIDE style SWDMA */
-
-			if ((best = (id->tDMA == 2) ? XFER_SW_DMA_2 :
-				    (id->tDMA == 1) ? XFER_SW_DMA_1 :
-				    (id->tDMA == 0) ? XFER_SW_DMA_0 : 0)) return best;
-		}
-	}
-
-
-	if ((map & XFER_EPIO) && (id->field_valid & 2)) {	/* EIDE PIO modes */
+	if (id->field_valid & 2) {	/* EIDE PIO modes */
 
 		if ((best = (drive->id->eide_pio_modes & 4) ? XFER_PIO_5 :
 			    (drive->id->eide_pio_modes & 2) ? XFER_PIO_4 :
@@ -262,7 +212,7 @@ static int ide_timing_compute(ide_drive_
  */
 
 	if ((speed & XFER_MODE) != XFER_PIO) {
-		ide_timing_compute(drive, ide_find_best_mode(drive, XFER_PIO | XFER_EPIO), &p, T, UT);
+		ide_timing_compute(drive, ide_find_best_pio_mode(drive), &p, T, UT);
 		ide_timing_merge(&p, t, t, IDE_TIMING_ALL);
 	}
 
Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -381,9 +381,7 @@ static int auide_dma_setup(ide_drive_t *
 
 static int auide_dma_check(ide_drive_t *drive)
 {
-	u8 speed;
-
-#ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
+	u8 speed = ide_max_dma_mode(drive);
 
 	if( dbdma_init_done == 0 ){
 		auide_hwif.white_list = ide_in_drive_list(drive->id,
@@ -394,7 +392,6 @@ static int auide_dma_check(ide_drive_t *
 		auide_ddma_init(&auide_hwif);
 		dbdma_init_done = 1;
 	}
-#endif
 
 	/* Is the drive in our DMA black list? */
 
@@ -409,8 +406,6 @@ static int auide_dma_check(ide_drive_t *
 	else
 		drive->using_dma = 1;
 
-	speed = ide_find_best_mode(drive, XFER_PIO | XFER_MWDMA);
-	
 	if (drive->autodma && (speed & XFER_MODE) != XFER_PIO)
 		return 0;
 
Index: b/drivers/ide/pci/amd74xx.c
===================================================================
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -1,10 +1,11 @@
 /*
- * Version 2.15
+ * Version 2.20
  *
  * AMD 755/756/766/8111 and nVidia nForce/2/2s/3/3s/CK804/MCP04
  * IDE driver for Linux.
  *
  * Copyright (c) 2000-2002 Vojtech Pavlik
+ * Copyright (c) 2007 Bartlomiej Zolnierkiewicz
  *
  * Based on the work of:
  *      Andre Hedrick
@@ -37,11 +38,6 @@
 #define AMD_ADDRESS_SETUP	(0x0c + amd_config->base)
 #define AMD_UDMA_TIMING		(0x10 + amd_config->base)
 
-#define AMD_UDMA		0x07
-#define AMD_UDMA_33		0x01
-#define AMD_UDMA_66		0x02
-#define AMD_UDMA_100		0x03
-#define AMD_UDMA_133		0x04
 #define AMD_CHECK_SWDMA		0x08
 #define AMD_BAD_SWDMA		0x10
 #define AMD_BAD_FIFO		0x20
@@ -53,32 +49,33 @@
 
 static struct amd_ide_chip {
 	unsigned short id;
-	unsigned long base;
-	unsigned char flags;
+	u8 base;
+	u8 udma_mask;
+	u8 flags;
 } amd_ide_chips[] = {
-	{ PCI_DEVICE_ID_AMD_COBRA_7401,		0x40, AMD_UDMA_33 | AMD_BAD_SWDMA },
-	{ PCI_DEVICE_ID_AMD_VIPER_7409,		0x40, AMD_UDMA_66 | AMD_CHECK_SWDMA },
-	{ PCI_DEVICE_ID_AMD_VIPER_7411,		0x40, AMD_UDMA_100 | AMD_BAD_FIFO },
-	{ PCI_DEVICE_ID_AMD_OPUS_7441,		0x40, AMD_UDMA_100 },
-	{ PCI_DEVICE_ID_AMD_8111_IDE,		0x40, AMD_UDMA_133 | AMD_CHECK_SERENADE },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE_IDE,	0x50, AMD_UDMA_100 },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE,	0x50, AMD_UDMA_133 },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE,	0x50, AMD_UDMA_133 },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA,	0x50, AMD_UDMA_133 },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE,	0x50, AMD_UDMA_133 },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE,	0x50, AMD_UDMA_133 },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,	0x50, AMD_UDMA_133 },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,	0x50, AMD_UDMA_133 },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,	0x50, AMD_UDMA_133 },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	0x50, AMD_UDMA_133 },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,	0x50, AMD_UDMA_133 },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,	0x50, AMD_UDMA_133 },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_IDE,	0x50, AMD_UDMA_133 },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_IDE,	0x50, AMD_UDMA_133 },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_IDE,	0x50, AMD_UDMA_133 },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP73_IDE,	0x50, AMD_UDMA_133 },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP77_IDE,	0x50, AMD_UDMA_133 },
-	{ PCI_DEVICE_ID_AMD_CS5536_IDE,			0x40, AMD_UDMA_100 },
+	{ PCI_DEVICE_ID_AMD_COBRA_7401,		 0x40, ATA_UDMA2, AMD_BAD_SWDMA },
+	{ PCI_DEVICE_ID_AMD_VIPER_7409,		 0x40, ATA_UDMA4, AMD_CHECK_SWDMA },
+	{ PCI_DEVICE_ID_AMD_VIPER_7411,		 0x40, ATA_UDMA5, AMD_BAD_FIFO },
+	{ PCI_DEVICE_ID_AMD_OPUS_7441,		 0x40, ATA_UDMA5, },
+	{ PCI_DEVICE_ID_AMD_8111_IDE,		 0x40, ATA_UDMA6, AMD_CHECK_SERENADE },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_IDE,	 0x50, ATA_UDMA5, },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE,	 0x50, ATA_UDMA6, },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE,	 0x50, ATA_UDMA6, },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA,	 0x50, ATA_UDMA6, },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE,	 0x50, ATA_UDMA6, },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE,	 0x50, ATA_UDMA6, },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,	 0x50, ATA_UDMA6, },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,	 0x50, ATA_UDMA6, },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE, 0x50, ATA_UDMA6, },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE, 0x50, ATA_UDMA6, },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE, 0x50, ATA_UDMA6, },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE, 0x50, ATA_UDMA6, },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_IDE, 0x50, ATA_UDMA6, },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_IDE, 0x50, ATA_UDMA6, },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_IDE, 0x50, ATA_UDMA6, },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP73_IDE, 0x50, ATA_UDMA6, },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP77_IDE, 0x50, ATA_UDMA6, },
+	{ PCI_DEVICE_ID_AMD_CS5536_IDE,		 0x40, ATA_UDMA5, },
 	{ 0 }
 };
 
@@ -87,7 +84,7 @@ static ide_pci_device_t *amd_chipset;
 static unsigned int amd_80w;
 static unsigned int amd_clock;
 
-static char *amd_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA100", "UDMA133" };
+static char *amd_dma[] = { "16", "25", "33", "44", "66", "100", "133" };
 static unsigned char amd_cyc2udma[] = { 6, 6, 5, 4, 0, 1, 1, 2, 2, 3, 3, 3, 3, 3, 3, 7 };
 
 /*
@@ -128,7 +125,7 @@ static int amd74xx_get_info(char *buffer
 
 	pci_read_config_byte(dev, PCI_REVISION_ID, &t);
 	amd_print("Revision:                           IDE %#x", t);
-	amd_print("Highest DMA rate:                   %s", amd_dma[amd_config->flags & AMD_UDMA]);
+	amd_print("Highest DMA rate:                   UDMA%s", amd_dma[fls(amd_config->udma_mask) - 1]);
 
 	amd_print("BM-DMA base:                        %#lx", amd_base);
 	amd_print("PCI clock:                          %d.%dMHz", amd_clock / 1000, amd_clock / 100 % 10);
@@ -221,12 +218,12 @@ static void amd_set_speed(struct pci_dev
 	pci_write_config_byte(dev, AMD_DRIVE_TIMING + (3 - dn),
 		((FIT(timing->active, 1, 16) - 1) << 4) | (FIT(timing->recover, 1, 16) - 1));
 
-	switch (amd_config->flags & AMD_UDMA) {
-		case AMD_UDMA_33:  t = timing->udma ? (0xc0 | (FIT(timing->udma, 2, 5) - 2)) : 0x03; break;
-		case AMD_UDMA_66:  t = timing->udma ? (0xc0 | amd_cyc2udma[FIT(timing->udma, 2, 10)]) : 0x03; break;
-		case AMD_UDMA_100: t = timing->udma ? (0xc0 | amd_cyc2udma[FIT(timing->udma, 1, 10)]) : 0x03; break;
-		case AMD_UDMA_133: t = timing->udma ? (0xc0 | amd_cyc2udma[FIT(timing->udma, 1, 15)]) : 0x03; break;
-		default: return;
+	switch (amd_config->udma_mask) {
+	case ATA_UDMA2: t = timing->udma ? (0xc0 | (FIT(timing->udma, 2, 5) - 2)) : 0x03; break;
+	case ATA_UDMA4: t = timing->udma ? (0xc0 | amd_cyc2udma[FIT(timing->udma, 2, 10)]) : 0x03; break;
+	case ATA_UDMA5: t = timing->udma ? (0xc0 | amd_cyc2udma[FIT(timing->udma, 1, 10)]) : 0x03; break;
+	case ATA_UDMA6: t = timing->udma ? (0xc0 | amd_cyc2udma[FIT(timing->udma, 1, 15)]) : 0x03; break;
+	default: return;
 	}
 
 	pci_write_config_byte(dev, AMD_UDMA_TIMING + (3 - dn), t);
@@ -250,7 +247,7 @@ static int amd_set_drive(ide_drive_t *dr
 				drive->dn >> 1, drive->dn & 1);
 
 	T = 1000000000 / amd_clock;
-	UT = T / min_t(int, max_t(int, amd_config->flags & AMD_UDMA, 1), 2);
+	UT = (amd_config->udma_mask == ATA_UDMA2) ? T : (T / 2);
 
 	ide_timing_compute(drive, speed, &t, T, UT);
 
@@ -279,29 +276,19 @@ static int amd_set_drive(ide_drive_t *dr
 static void amd74xx_tune_drive(ide_drive_t *drive, u8 pio)
 {
 	if (pio == 255) {
-		amd_set_drive(drive, ide_find_best_mode(drive, XFER_PIO | XFER_EPIO));
+		amd_set_drive(drive, ide_find_best_pio_mode(drive));
 		return;
 	}
 
 	amd_set_drive(drive, XFER_PIO_0 + min_t(byte, pio, 5));
 }
 
-/*
- * amd74xx_dmaproc() is a callback from upper layers that can do
- * a lot, but we use it for DMA/PIO tuning only, delegating everything
- * else to the default ide_dmaproc().
- */
-
 static int amd74xx_ide_dma_check(ide_drive_t *drive)
 {
-	int w80 = HWIF(drive)->udma_four;
+	u8 speed = ide_max_dma_mode(drive);
 
-	u8 speed = ide_find_best_mode(drive,
-		XFER_PIO | XFER_EPIO | XFER_MWDMA | XFER_UDMA |
-		((amd_config->flags & AMD_BAD_SWDMA) ? 0 : XFER_SWDMA) |
-		(w80 && (amd_config->flags & AMD_UDMA) >= AMD_UDMA_66 ? XFER_UDMA_66 : 0) |
-		(w80 && (amd_config->flags & AMD_UDMA) >= AMD_UDMA_100 ? XFER_UDMA_100 : 0) |
-		(w80 && (amd_config->flags & AMD_UDMA) >= AMD_UDMA_133 ? XFER_UDMA_133 : 0));
+	if (speed == 0)
+		speed = ide_find_best_pio_mode(drive);
 
 	amd_set_drive(drive, speed);
 
@@ -336,10 +323,10 @@ static unsigned int __devinit init_chips
  * Check 80-wire cable presence.
  */
 
-	switch (amd_config->flags & AMD_UDMA) {
+	switch (amd_config->udma_mask) {
 
-		case AMD_UDMA_133:
-		case AMD_UDMA_100:
+		case ATA_UDMA6:
+		case ATA_UDMA5:
 			pci_read_config_byte(dev, AMD_CABLE_DETECT, &t);
 			pci_read_config_dword(dev, AMD_UDMA_TIMING, &u);
 			amd_80w = ((t & 0x3) ? 1 : 0) | ((t & 0xc) ? 2 : 0);
@@ -351,7 +338,7 @@ static unsigned int __devinit init_chips
 				}
 			break;
 
-		case AMD_UDMA_66:
+		case ATA_UDMA4:
 			/* no host side cable detection */
 			amd_80w = 0x03;
 			break;
@@ -372,7 +359,7 @@ static unsigned int __devinit init_chips
 	if ((amd_config->flags & AMD_CHECK_SERENADE) &&
 		dev->subsystem_vendor == PCI_VENDOR_ID_AMD &&
 		dev->subsystem_device == PCI_DEVICE_ID_AMD_SERENADE)
-			amd_config->flags = AMD_UDMA_100;
+			amd_config->udma_mask = ATA_UDMA5;
 
 /*
  * Determine the system bus clock.
@@ -397,8 +384,9 @@ static unsigned int __devinit init_chips
  */
 
 	pci_read_config_byte(dev, PCI_REVISION_ID, &t);
-	printk(KERN_INFO "%s: %s (rev %02x) %s controller\n",
-		amd_chipset->name, pci_name(dev), t, amd_dma[amd_config->flags & AMD_UDMA]);
+	printk(KERN_INFO "%s: %s (rev %02x) UDMA%s controller\n",
+		amd_chipset->name, pci_name(dev), t,
+		amd_dma[fls(amd_config->udma_mask) - 1]);
 
 /*
  * Register /proc/ide/amd74xx entry
@@ -439,9 +427,11 @@ static void __devinit init_hwif_amd74xx(
 		return;
 
         hwif->atapi_dma = 1;
-        hwif->ultra_mask = 0x7f;
-        hwif->mwdma_mask = 0x07;
-        hwif->swdma_mask = 0x07;
+
+	hwif->ultra_mask = amd_config->udma_mask;
+	hwif->mwdma_mask = 0x07;
+	if ((amd_config->flags & AMD_BAD_SWDMA) == 0)
+		hwif->swdma_mask = 0x07;
 
 	if (!hwif->udma_four)
 		hwif->udma_four = (amd_80w >> hwif->channel) & 1;
Index: b/drivers/ide/pci/via82cxxx.c
===================================================================
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -1,6 +1,6 @@
 /*
  *
- * Version 3.38
+ * Version 3.40
  *
  * VIA IDE driver for Linux. Supported southbridges:
  *
@@ -9,6 +9,7 @@
  *   vt8235, vt8237, vt8237a
  *
  * Copyright (c) 2000-2002 Vojtech Pavlik
+ * Copyright (c) 2007 Bartlomiej Zolnierkiewicz
  *
  * Based on the work of:
  *	Michel Aubry
@@ -41,8 +42,6 @@
 
 #include "ide-timing.h"
 
-#define DISPLAY_VIA_TIMINGS
-
 #define VIA_IDE_ENABLE		0x40
 #define VIA_IDE_CONFIG		0x41
 #define VIA_FIFO_CONFIG		0x43
@@ -54,18 +53,12 @@
 #define VIA_ADDRESS_SETUP	0x4c
 #define VIA_UDMA_TIMING		0x50
 
-#define VIA_UDMA		0x007
-#define VIA_UDMA_NONE		0x000
-#define VIA_UDMA_33		0x001
-#define VIA_UDMA_66		0x002
-#define VIA_UDMA_100		0x003
-#define VIA_UDMA_133		0x004
-#define VIA_BAD_PREQ		0x010	/* Crashes if PREQ# till DDACK# set */
-#define VIA_BAD_CLK66		0x020	/* 66 MHz clock doesn't work correctly */
-#define VIA_SET_FIFO		0x040	/* Needs to have FIFO split set */
-#define VIA_NO_UNMASK		0x080	/* Doesn't work with IRQ unmasking on */
-#define VIA_BAD_ID		0x100	/* Has wrong vendor ID (0x1107) */
-#define VIA_BAD_AST		0x200	/* Don't touch Address Setup Timing */
+#define VIA_BAD_PREQ		0x01 /* Crashes if PREQ# till DDACK# set */
+#define VIA_BAD_CLK66		0x02 /* 66 MHz clock doesn't work correctly */
+#define VIA_SET_FIFO		0x04 /* Needs to have FIFO split set */
+#define VIA_NO_UNMASK		0x08 /* Doesn't work with IRQ unmasking on */
+#define VIA_BAD_ID		0x10 /* Has wrong vendor ID (0x1107) */
+#define VIA_BAD_AST		0x20 /* Don't touch Address Setup Timing */
 
 /*
  * VIA SouthBridge chips.
@@ -76,36 +69,37 @@ static struct via_isa_bridge {
 	u16 id;
 	u8 rev_min;
 	u8 rev_max;
-	u16 flags;
+	u8 udma_mask;
+	u8 flags;
 } via_isa_bridges[] = {
-	{ "cx700",	PCI_DEVICE_ID_VIA_CX700,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
-	{ "vt8237s",	PCI_DEVICE_ID_VIA_8237S,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
-	{ "vt6410",	PCI_DEVICE_ID_VIA_6410,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
-	{ "vt8251",	PCI_DEVICE_ID_VIA_8251,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
-	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
-	{ "vt8237a",	PCI_DEVICE_ID_VIA_8237A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
-	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
-	{ "vt8233a",	PCI_DEVICE_ID_VIA_8233A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
-	{ "vt8233c",	PCI_DEVICE_ID_VIA_8233C_0,  0x00, 0x2f, VIA_UDMA_100 },
-	{ "vt8233",	PCI_DEVICE_ID_VIA_8233_0,   0x00, 0x2f, VIA_UDMA_100 },
-	{ "vt8231",	PCI_DEVICE_ID_VIA_8231,     0x00, 0x2f, VIA_UDMA_100 },
-	{ "vt82c686b",	PCI_DEVICE_ID_VIA_82C686,   0x40, 0x4f, VIA_UDMA_100 },
-	{ "vt82c686a",	PCI_DEVICE_ID_VIA_82C686,   0x10, 0x2f, VIA_UDMA_66 },
-	{ "vt82c686",	PCI_DEVICE_ID_VIA_82C686,   0x00, 0x0f, VIA_UDMA_33 | VIA_BAD_CLK66 },
-	{ "vt82c596b",	PCI_DEVICE_ID_VIA_82C596,   0x10, 0x2f, VIA_UDMA_66 },
-	{ "vt82c596a",	PCI_DEVICE_ID_VIA_82C596,   0x00, 0x0f, VIA_UDMA_33 | VIA_BAD_CLK66 },
-	{ "vt82c586b",	PCI_DEVICE_ID_VIA_82C586_0, 0x47, 0x4f, VIA_UDMA_33 | VIA_SET_FIFO },
-	{ "vt82c586b",	PCI_DEVICE_ID_VIA_82C586_0, 0x40, 0x46, VIA_UDMA_33 | VIA_SET_FIFO | VIA_BAD_PREQ },
-	{ "vt82c586b",	PCI_DEVICE_ID_VIA_82C586_0, 0x30, 0x3f, VIA_UDMA_33 | VIA_SET_FIFO },
-	{ "vt82c586a",	PCI_DEVICE_ID_VIA_82C586_0, 0x20, 0x2f, VIA_UDMA_33 | VIA_SET_FIFO },
-	{ "vt82c586",	PCI_DEVICE_ID_VIA_82C586_0, 0x00, 0x0f, VIA_UDMA_NONE | VIA_SET_FIFO },
-	{ "vt82c576",	PCI_DEVICE_ID_VIA_82C576,   0x00, 0x2f, VIA_UDMA_NONE | VIA_SET_FIFO | VIA_NO_UNMASK },
-	{ "vt82c576",	PCI_DEVICE_ID_VIA_82C576,   0x00, 0x2f, VIA_UDMA_NONE | VIA_SET_FIFO | VIA_NO_UNMASK | VIA_BAD_ID },
+	{ "cx700",	PCI_DEVICE_ID_VIA_CX700,    0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST },
+	{ "vt8237s",	PCI_DEVICE_ID_VIA_8237S,    0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST },
+	{ "vt6410",	PCI_DEVICE_ID_VIA_6410,     0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST },
+	{ "vt8251",	PCI_DEVICE_ID_VIA_8251,     0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST },
+	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST },
+	{ "vt8237a",	PCI_DEVICE_ID_VIA_8237A,    0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST },
+	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST },
+	{ "vt8233a",	PCI_DEVICE_ID_VIA_8233A,    0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST },
+	{ "vt8233c",	PCI_DEVICE_ID_VIA_8233C_0,  0x00, 0x2f, ATA_UDMA5, },
+	{ "vt8233",	PCI_DEVICE_ID_VIA_8233_0,   0x00, 0x2f, ATA_UDMA5, },
+	{ "vt8231",	PCI_DEVICE_ID_VIA_8231,     0x00, 0x2f, ATA_UDMA5, },
+	{ "vt82c686b",	PCI_DEVICE_ID_VIA_82C686,   0x40, 0x4f, ATA_UDMA5, },
+	{ "vt82c686a",	PCI_DEVICE_ID_VIA_82C686,   0x10, 0x2f, ATA_UDMA4, },
+	{ "vt82c686",	PCI_DEVICE_ID_VIA_82C686,   0x00, 0x0f, ATA_UDMA2, VIA_BAD_CLK66 },
+	{ "vt82c596b",	PCI_DEVICE_ID_VIA_82C596,   0x10, 0x2f, ATA_UDMA4, },
+	{ "vt82c596a",	PCI_DEVICE_ID_VIA_82C596,   0x00, 0x0f, ATA_UDMA2, VIA_BAD_CLK66 },
+	{ "vt82c586b",	PCI_DEVICE_ID_VIA_82C586_0, 0x47, 0x4f, ATA_UDMA2, VIA_SET_FIFO },
+	{ "vt82c586b",	PCI_DEVICE_ID_VIA_82C586_0, 0x40, 0x46, ATA_UDMA2, VIA_SET_FIFO | VIA_BAD_PREQ },
+	{ "vt82c586b",	PCI_DEVICE_ID_VIA_82C586_0, 0x30, 0x3f, ATA_UDMA2, VIA_SET_FIFO },
+	{ "vt82c586a",	PCI_DEVICE_ID_VIA_82C586_0, 0x20, 0x2f, ATA_UDMA2, VIA_SET_FIFO },
+	{ "vt82c586",	PCI_DEVICE_ID_VIA_82C586_0, 0x00, 0x0f,      0x00, VIA_SET_FIFO },
+	{ "vt82c576",	PCI_DEVICE_ID_VIA_82C576,   0x00, 0x2f,      0x00, VIA_SET_FIFO | VIA_NO_UNMASK },
+	{ "vt82c576",	PCI_DEVICE_ID_VIA_82C576,   0x00, 0x2f,      0x00, VIA_SET_FIFO | VIA_NO_UNMASK | VIA_BAD_ID },
 	{ NULL }
 };
 
 static unsigned int via_clock;
-static char *via_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA100", "UDMA133" };
+static char *via_dma[] = { "16", "25", "33", "44", "66", "100", "133" };
 
 struct via82cxxx_dev
 {
@@ -140,12 +134,12 @@ static void via_set_speed(ide_hwif_t *hw
 	pci_write_config_byte(dev, VIA_DRIVE_TIMING + (3 - dn),
 		((FIT(timing->active, 1, 16) - 1) << 4) | (FIT(timing->recover, 1, 16) - 1));
 
-	switch (vdev->via_config->flags & VIA_UDMA) {
-		case VIA_UDMA_33:  t = timing->udma ? (0xe0 | (FIT(timing->udma, 2, 5) - 2)) : 0x03; break;
-		case VIA_UDMA_66:  t = timing->udma ? (0xe8 | (FIT(timing->udma, 2, 9) - 2)) : 0x0f; break;
-		case VIA_UDMA_100: t = timing->udma ? (0xe0 | (FIT(timing->udma, 2, 9) - 2)) : 0x07; break;
-		case VIA_UDMA_133: t = timing->udma ? (0xe0 | (FIT(timing->udma, 2, 9) - 2)) : 0x07; break;
-		default: return;
+	switch (vdev->via_config->udma_mask) {
+	case ATA_UDMA2: t = timing->udma ? (0xe0 | (FIT(timing->udma, 2, 5) - 2)) : 0x03; break;
+	case ATA_UDMA4: t = timing->udma ? (0xe8 | (FIT(timing->udma, 2, 9) - 2)) : 0x0f; break;
+	case ATA_UDMA5: t = timing->udma ? (0xe0 | (FIT(timing->udma, 2, 9) - 2)) : 0x07; break;
+	case ATA_UDMA6: t = timing->udma ? (0xe0 | (FIT(timing->udma, 2, 9) - 2)) : 0x07; break;
+	default: return;
 	}
 
 	pci_write_config_byte(dev, VIA_UDMA_TIMING + (3 - dn), t);
@@ -173,12 +167,12 @@ static int via_set_drive(ide_drive_t *dr
 
 	T = 1000000000 / via_clock;
 
-	switch (vdev->via_config->flags & VIA_UDMA) {
-		case VIA_UDMA_33:   UT = T;   break;
-		case VIA_UDMA_66:   UT = T/2; break;
-		case VIA_UDMA_100:  UT = T/3; break;
-		case VIA_UDMA_133:  UT = T/4; break;
-		default: UT = T;
+	switch (vdev->via_config->udma_mask) {
+	case ATA_UDMA2: UT = T;   break;
+	case ATA_UDMA4: UT = T/2; break;
+	case ATA_UDMA5: UT = T/3; break;
+	case ATA_UDMA6: UT = T/4; break;
+	default:	UT = T;
 	}
 
 	ide_timing_compute(drive, speed, &t, T, UT);
@@ -208,8 +202,7 @@ static int via_set_drive(ide_drive_t *dr
 static void via82cxxx_tune_drive(ide_drive_t *drive, u8 pio)
 {
 	if (pio == 255) {
-		via_set_drive(drive,
-			ide_find_best_mode(drive, XFER_PIO | XFER_EPIO));
+		via_set_drive(drive, ide_find_best_pio_mode(drive));
 		return;
 	}
 
@@ -226,16 +219,10 @@ static void via82cxxx_tune_drive(ide_dri
  
 static int via82cxxx_ide_dma_check (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif = HWIF(drive);
-	struct via82cxxx_dev *vdev = pci_get_drvdata(hwif->pci_dev);
-	u16 w80 = hwif->udma_four;
+	u8 speed = ide_max_dma_mode(drive);
 
-	u16 speed = ide_find_best_mode(drive,
-		XFER_PIO | XFER_EPIO | XFER_SWDMA | XFER_MWDMA |
-		(vdev->via_config->flags & VIA_UDMA ? XFER_UDMA : 0) |
-		(w80 && (vdev->via_config->flags & VIA_UDMA) >= VIA_UDMA_66 ? XFER_UDMA_66 : 0) |
-		(w80 && (vdev->via_config->flags & VIA_UDMA) >= VIA_UDMA_100 ? XFER_UDMA_100 : 0) |
-		(w80 && (vdev->via_config->flags & VIA_UDMA) >= VIA_UDMA_133 ? XFER_UDMA_133 : 0));
+	if (speed == 0)
+		speed = ide_find_best_pio_mode(drive);
 
 	via_set_drive(drive, speed);
 
@@ -272,8 +259,8 @@ static void __devinit via_cable_detect(s
 {
 	int i;
 
-	switch (vdev->via_config->flags & VIA_UDMA) {
-		case VIA_UDMA_66:
+	switch (vdev->via_config->udma_mask) {
+		case ATA_UDMA4:
 			for (i = 24; i >= 0; i -= 8)
 				if (((u >> (i & 16)) & 8) &&
 				    ((u >> i) & 0x20) &&
@@ -286,7 +273,7 @@ static void __devinit via_cable_detect(s
 				}
 			break;
 
-		case VIA_UDMA_100:
+		case ATA_UDMA5:
 			for (i = 24; i >= 0; i -= 8)
 				if (((u >> i) & 0x10) ||
 				    (((u >> i) & 0x20) &&
@@ -298,7 +285,7 @@ static void __devinit via_cable_detect(s
 				}
 			break;
 
-		case VIA_UDMA_133:
+		case ATA_UDMA6:
 			for (i = 24; i >= 0; i -= 8)
 				if (((u >> i) & 0x10) ||
 				    (((u >> i) & 0x20) &&
@@ -353,7 +340,7 @@ static unsigned int __devinit init_chips
 
 	via_cable_detect(vdev, u);
 
-	if ((via_config->flags & VIA_UDMA) == VIA_UDMA_66) {
+	if (via_config->udma_mask == ATA_UDMA4) {
 		/* Enable Clk66 */
 		pci_write_config_dword(dev, VIA_UDMA_TIMING, u|0x80008);
 	} else if (via_config->flags & VIA_BAD_CLK66) {
@@ -416,10 +403,12 @@ static unsigned int __devinit init_chips
 	 */
 
 	pci_read_config_byte(isa, PCI_REVISION_ID, &t);
-	printk(KERN_INFO "VP_IDE: VIA %s (rev %02x) IDE %s "
+	printk(KERN_INFO "VP_IDE: VIA %s (rev %02x) IDE %sDMA%s "
 		"controller on pci%s\n",
 		via_config->name, t,
-		via_dma[via_config->flags & VIA_UDMA],
+		via_config->udma_mask ? "U" : "MW",
+		via_dma[via_config->udma_mask ?
+			(fls(via_config->udma_mask) - 1) : 0],
 		pci_name(dev));
 
 	pci_dev_put(isa);
@@ -454,7 +443,8 @@ static void __devinit init_hwif_via82cxx
 		return;
 
 	hwif->atapi_dma = 1;
-	hwif->ultra_mask = 0x7f;
+
+	hwif->ultra_mask = vdev->via_config->udma_mask;
 	hwif->mwdma_mask = 0x07;
 	hwif->swdma_mask = 0x07;
 
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1821,28 +1821,11 @@ pmac_ide_dma_check(ide_drive_t *drive)
 		enable = 0;
 
 	if (enable) {
-		short mode;
-		
-		map = XFER_MWDMA;
-		if (pmif->kind == controller_kl_ata4
-		    || pmif->kind == controller_un_ata6
-		    || pmif->kind == controller_k2_ata6
-		    || pmif->kind == controller_sh_ata6) {
-			map |= XFER_UDMA;
-			if (pmif->cable_80) {
-				map |= XFER_UDMA_66;
-				if (pmif->kind == controller_un_ata6 ||
-				    pmif->kind == controller_k2_ata6 ||
-				    pmif->kind == controller_sh_ata6)
-					map |= XFER_UDMA_100;
-				if (pmif->kind == controller_sh_ata6)
-					map |= XFER_UDMA_133;
-			}
-		}
-		mode = ide_find_best_mode(drive, map);
-		if (mode & XFER_UDMA)
+		u8 mode = ide_max_dma_mode(drive);
+
+		if (mode >= XFER_UDMA_0)
 			drive->using_dma = pmac_ide_udma_enable(drive, mode);
-		else if (mode & XFER_MWDMA)
+		else if (mode >= XFER_MW_DMA_0)
 			drive->using_dma = pmac_ide_mdma_enable(drive, mode);
 		hwif->OUTB(0, IDE_CONTROL_REG);
 		/* Apply settings to controller */
