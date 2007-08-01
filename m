From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/3] sis5513: DMA setup fixes
Date: Wed, 1 Aug 2007 22:38:43 +0200
Message-ID: <200708012238.44022.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:40392 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbXHAUlU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 16:41:20 -0400
Received: by nf-out-0910.google.com with SMTP id g13so82885nfb
        for <linux-ide@vger.kernel.org>; Wed, 01 Aug 2007 13:41:18 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Add sis_ata133_get_base() helper function for obtaining the address of
  the drive control registers on chipset_family == ATA_133 chipsets.

* Add three helper functions for programming PIO/MWDMA timings:
  - sis_ata16_program_timings()  (for ATA_16/33/66/100a chipset families)
  - sis_ata100_program_timings() (for ATA_100/133a chipset families)
  - sis_ata133_program_timings() (for ATA_133 chipset family)

  MWDMA timings are taken from datasheets and they match ATA spec.

* Add generic helper function sis_program_timings() and use it in
  ->set_pio_mode and ->set_dma_mode methods (previously the driver
  depended on BIOS to program the correct MWDMA timings).

* Remove redundant !chipset_family check from init_hwif_sis5513()
  (init_chipset_sis5513() guarantees that we will never get here if
   chipset_family cannot be determined).

* SWDMA seems to be unsupported by SiS chipsets (no info about SWDMA in
  datasheets and for SWDMA0 mode timing requirements are impossible to
  fulfill) so remove ->swdma_mask from init_hwif_sis5513() and handling
  of SWDMA modes from sis_set_dma_mode().

* Enable DMA support for chipset_family == ATA_16.

* Bump driver version.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sis5513.c |  214 ++++++++++++++++++++++------------------------
 1 file changed, 106 insertions(+), 108 deletions(-)

Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/sis5513.c	Version 0.27	Jul 14, 2007
+ * linux/drivers/ide/pci/sis5513.c	Version 0.28	Aug 1, 2007
  *
  * Copyright (C) 1999-2000	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2002		Lionel Bouton <Lionel.Bouton@inet6.fr>, Maintainer
@@ -433,6 +433,95 @@ static int sis_get_info (char *buffer, c
 /*
  * Configuration functions
  */
+
+static u8 sis_ata133_get_base(ide_drive_t *drive)
+{
+	struct pci_dev *dev = drive->hwif->pci_dev;
+	u32 reg54 = 0;
+
+	pci_read_config_dword(dev, 0x54, &reg54);
+
+	return ((reg54 & 0x40000000) ? 0x70 : 0x40) + drive->dn * 4;
+}
+
+static void sis_ata16_program_timings(ide_drive_t *drive, const u8 mode)
+{
+	struct pci_dev *dev = drive->hwif->pci_dev;
+	u16 t1 = 0;
+	u8 drive_pci = 0x40 + drive->dn * 2;
+
+	const u16 pio_timings[]   = { 0x000, 0x607, 0x404, 0x303, 0x301 };
+	const u16 mwdma_timings[] = { 0x008, 0x302, 0x301 };
+
+	pci_read_config_word(dev, drive_pci, &t1);
+
+	/* clear active/recovery timings */
+	t1 &= ~0x070f;
+	if (mode >= XFER_MW_DMA_0) {
+		if (chipset_family > ATA_16)
+			t1 &= ~0x8000;	/* disable UDMA */
+		t1 |= mwdma_timings[mode - XFER_MW_DMA_0];
+	} else
+		t1 |= pio_timings[mode - XFER_PIO_0];
+
+	pci_write_config_word(dev, drive_pci, t1);
+}
+
+static void sis_ata100_program_timings(ide_drive_t *drive, const u8 mode)
+{
+	struct pci_dev *dev = drive->hwif->pci_dev;
+	u8 t1, drive_pci = 0x40 + drive->dn * 2;
+
+	/* timing bits: 7:4 active 3:0 recovery */
+	const u8 pio_timings[]   = { 0x00, 0x67, 0x44, 0x33, 0x31 };
+	const u8 mwdma_timings[] = { 0x08, 0x32, 0x31 };
+
+	if (mode >= XFER_MW_DMA_0) {
+		u8 t2 = 0;
+
+		pci_read_config_byte(dev, drive_pci, &t2);
+		t2 &= ~0x80;	/* disable UDMA */
+		pci_write_config_byte(dev, drive_pci, t2);
+
+		t1 = mwdma_timings[mode - XFER_MW_DMA_0];
+	} else
+		t1 = pio_timings[mode - XFER_PIO_0];
+
+	pci_write_config_byte(dev, drive_pci + 1, t1);
+}
+
+static void sis_ata133_program_timings(ide_drive_t *drive, const u8 mode)
+{
+	struct pci_dev *dev = drive->hwif->pci_dev;
+	u32 t1 = 0;
+	u8 drive_pci = sis_ata133_get_base(drive), clk, idx;
+
+	pci_read_config_dword(dev, drive_pci, &t1);
+
+	t1 &= 0xc0c00fff;
+	clk = (t1 & 0x08) ? ATA_133 : ATA_100;
+	if (mode >= XFER_MW_DMA_0) {
+		t1 &= ~0x04;	/* disable UDMA */
+		idx = mode - XFER_MW_DMA_0 + 5;
+	}
+		idx = mode - XFER_PIO_0;
+	t1 |= ini_time_value[clk][idx] << 12;
+	t1 |= act_time_value[clk][idx] << 16;
+	t1 |= rco_time_value[clk][idx] << 24;
+
+	pci_write_config_dword(dev, drive_pci, t1);
+}
+
+static void sis_program_timings(ide_drive_t *drive, const u8 mode)
+{
+	if (chipset_family < ATA_100)		/* ATA_16/33/66/100a */
+		sis_ata16_program_timings(drive, mode);
+	else if (chipset_family < ATA_133)	/* ATA_100/133a */
+		sis_ata100_program_timings(drive, mode);
+	else					/* ATA_133 */
+		sis_ata133_program_timings(drive, mode);
+}
+
 /* Enables per-drive prefetch and postwrite */
 static void config_drive_art_rwp (ide_drive_t *drive)
 {
@@ -450,105 +539,16 @@ static void config_drive_art_rwp (ide_dr
 		pci_write_config_byte(dev, 0x4b, reg4bh|rw_prefetch);
 }
 
-/* Set per-drive active and recovery time */
 static void sis_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct pci_dev *dev	= hwif->pci_dev;
-
-	u8 drive_pci, test1, test2;
-
 	config_drive_art_rwp(drive);
-
-	/* In pre ATA_133 case, drives sit at 0x40 + 4*drive->dn */
-	drive_pci = 0x40;
-	/* In SiS962 case drives sit at (0x40 or 0x70) + 8*drive->dn) */
-	if (chipset_family >= ATA_133) {
-		u32 reg54h;
-		pci_read_config_dword(dev, 0x54, &reg54h);
-		if (reg54h & 0x40000000) drive_pci = 0x70;
-		drive_pci += ((drive->dn)*0x4);
-	} else {
-		drive_pci += ((drive->dn)*0x2);
-	}
-
-	/* register layout changed with newer ATA100 chips */
-	if (chipset_family < ATA_100) {
-		pci_read_config_byte(dev, drive_pci, &test1);
-		pci_read_config_byte(dev, drive_pci+1, &test2);
-
-		/* Clear active and recovery timings */
-		test1 &= ~0x0F;
-		test2 &= ~0x07;
-
-		switch(pio) {
-			case 4:		test1 |= 0x01; test2 |= 0x03; break;
-			case 3:		test1 |= 0x03; test2 |= 0x03; break;
-			case 2:		test1 |= 0x04; test2 |= 0x04; break;
-			case 1:		test1 |= 0x07; test2 |= 0x06; break;
-			case 0:		/* PIO0: register setting == X000 */
-			default:	break;
-		}
-		pci_write_config_byte(dev, drive_pci, test1);
-		pci_write_config_byte(dev, drive_pci+1, test2);
-	} else if (chipset_family < ATA_133) {
-		switch(pio) { /*		active  recovery
-						  v     v */
-			case 4:		test1 = 0x30|0x01; break;
-			case 3:		test1 = 0x30|0x03; break;
-			case 2:		test1 = 0x40|0x04; break;
-			case 1:		test1 = 0x60|0x07; break;
-			case 0:		test1 = 0x00; break;
-			default:	break;
-		}
-		pci_write_config_byte(dev, drive_pci, test1);
-	} else { /* ATA_133 */
-		u32 test3;
-		pci_read_config_dword(dev, drive_pci, &test3);
-		test3 &= 0xc0c00fff;
-		if (test3 & 0x08) {
-			test3 |= ini_time_value[ATA_133][pio] << 12;
-			test3 |= act_time_value[ATA_133][pio] << 16;
-			test3 |= rco_time_value[ATA_133][pio] << 24;
-		} else {
-			test3 |= ini_time_value[ATA_100][pio] << 12;
-			test3 |= act_time_value[ATA_100][pio] << 16;
-			test3 |= rco_time_value[ATA_100][pio] << 24;
-		}
-		pci_write_config_dword(dev, drive_pci, test3);
-	}
+	sis_program_timings(drive, XFER_PIO_0 + pio);
 }
 
 static void sis_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
-	u32 regdw;
-	u8 drive_pci, reg;
-
-	/* See sis_set_pio_mode() for drive PCI config registers */
-	drive_pci = 0x40;
-	if (chipset_family >= ATA_133) {
-		u32 reg54h;
-		pci_read_config_dword(dev, 0x54, &reg54h);
-		if (reg54h & 0x40000000) drive_pci = 0x70;
-		drive_pci += ((drive->dn)*0x4);
-		pci_read_config_dword(dev, (unsigned long)drive_pci, &regdw);
-		/* Disable UDMA bit for non UDMA modes on UDMA chips */
-		if (speed < XFER_UDMA_0) {
-			regdw &= 0xfffffffb;
-			pci_write_config_dword(dev, (unsigned long)drive_pci, regdw);
-		}
-	
-	} else {
-		drive_pci += ((drive->dn)*0x2);
-		pci_read_config_byte(dev, drive_pci+1, &reg);
-		/* Disable UDMA bit for non UDMA modes on UDMA chips */
-		if ((speed < XFER_UDMA_0) && (chipset_family > ATA_16)) {
-			reg &= 0x7F;
-			pci_write_config_byte(dev, drive_pci+1, reg);
-		}
-	}
 
 	/* Config chip for mode */
 	switch(speed) {
@@ -560,6 +560,10 @@ static void sis_set_dma_mode(ide_drive_t
 		case XFER_UDMA_1:
 		case XFER_UDMA_0:
 			if (chipset_family >= ATA_133) {
+				u32 regdw = 0;
+				u8 drive_pci = sis_ata133_get_base(drive);
+
+				pci_read_config_dword(dev, drive_pci, &regdw);
 				regdw |= 0x04;
 				regdw &= 0xfffff00f;
 				/* check if ATA133 enable */
@@ -572,6 +576,9 @@ static void sis_set_dma_mode(ide_drive_t
 				}
 				pci_write_config_dword(dev, (unsigned long)drive_pci, regdw);
 			} else {
+				u8 drive_pci = 0x40 + drive->dn * 2, reg = 0;
+
+				pci_read_config_byte(dev, drive_pci+1, &reg);
 				/* Force the UDMA bit on if we want to use UDMA */
 				reg |= 0x80;
 				/* clean reg cycle time bits */
@@ -586,9 +593,7 @@ static void sis_set_dma_mode(ide_drive_t
 		case XFER_MW_DMA_2:
 		case XFER_MW_DMA_1:
 		case XFER_MW_DMA_0:
-		case XFER_SW_DMA_2:
-		case XFER_SW_DMA_1:
-		case XFER_SW_DMA_0:
+			sis_program_timings(drive, speed);
 			break;
 		default:
 			BUG();
@@ -617,11 +622,9 @@ static int sis5513_config_xfer_rate(ide_
 static u8 sis5513_ata133_udma_filter(ide_drive_t *drive)
 {
 	struct pci_dev *dev = drive->hwif->pci_dev;
-	int drive_pci;
-	u32 reg54 = 0, regdw = 0;
+	u32 regdw = 0;
+	u8 drive_pci = sis_ata133_get_base(drive);
 
-	pci_read_config_dword(dev, 0x54, &reg54);
-	drive_pci = ((reg54 & 0x40000000) ? 0x70 : 0x40) + drive->dn * 4;
 	pci_read_config_dword(dev, drive_pci, &regdw);
 
 	/* if ATA133 disable, we should not set speed above UDMA5 */
@@ -848,22 +851,17 @@ static void __devinit init_hwif_sis5513 
 
 	hwif->ultra_mask = udma_rates[chipset_family];
 	hwif->mwdma_mask = 0x07;
-	hwif->swdma_mask = 0x07;
-
-	if (!chipset_family)
-		return;
 
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 		hwif->cbl = ata66_sis5513(hwif);
 
-	if (chipset_family > ATA_16) {
-		hwif->ide_dma_check = &sis5513_config_xfer_rate;
-		if (!noautodma)
-			hwif->autodma = 1;
-	}
+	hwif->ide_dma_check = &sis5513_config_xfer_rate;
+
+	if (!noautodma)
+		hwif->autodma = 1;
+
 	hwif->drives[0].autodma = hwif->autodma;
 	hwif->drives[1].autodma = hwif->autodma;
-	return;
 }
 
 static ide_pci_device_t sis5513_chipset __devinitdata = {
