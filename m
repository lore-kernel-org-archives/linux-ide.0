From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/15] serverworks: always tune PIO
Date: Sat, 30 Jun 2007 21:01:03 +0200
Message-ID: <200706302101.03318.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:51198 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbXF3TAG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jun 2007 15:00:06 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1759202mue
        for <linux-ide@vger.kernel.org>; Sat, 30 Jun 2007 12:00:03 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Always set ->autotune so PIO gets correctly auto-tuned (previously
  ->autotune was only set when ->dma_base wasn't available, however
  ->ide_dma_check()/->speedproc() was always trying to tune PIO when
  tuning DMA).

* Move code responsible for programming chipset for PIO mode from
  svwks_tune_chipset() to svwks_tune_pio().  Don't tune PIO when tuning
  DMA (this is no longer needed since ->autotune is always set now).

* Handle PIO modes early in svwks_tune_chipset() so DMA configuration
  registers don't get cleared when programming PIO mode.

* Bump driver version.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/serverworks.c |   76 +++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 40 deletions(-)

Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/serverworks.c		Version 0.20	Jun 3 2007
+ * linux/drivers/ide/pci/serverworks.c		Version 0.21	Jun 16 2007
  *
  * Copyright (C) 1998-2000 Michel Aubry
  * Copyright (C) 1998-2000 Andrzej Krzysztofowicz
@@ -127,23 +127,45 @@ static u8 svwks_csb_check (struct pci_de
 	}
 	return 0;
 }
+
+static void svwks_tune_pio(ide_drive_t *drive, const u8 pio)
+{
+	static const u8 pio_modes[] = { 0x5d, 0x47, 0x34, 0x22, 0x20 };
+	static const u8 drive_pci[] = { 0x41, 0x40, 0x43, 0x42 };
+
+	struct pci_dev *dev = drive->hwif->pci_dev;
+
+	pci_write_config_byte(dev, drive_pci[drive->dn], pio_modes[pio]);
+
+	if (svwks_csb_check(dev)) {
+		u16 csb_pio = 0;
+
+		pci_read_config_word(dev, 0x4a, &csb_pio);
+
+		csb_pio &= ~(0x0f << (4 * drive->dn));
+		csb_pio |= (pio << (4 * drive->dn));
+
+		pci_write_config_word(dev, 0x4a, csb_pio);
+	}
+}
+
 static int svwks_tune_chipset (ide_drive_t *drive, u8 xferspeed)
 {
 	static const u8 udma_modes[]		= { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05 };
 	static const u8 dma_modes[]		= { 0x77, 0x21, 0x20 };
-	static const u8 pio_modes[]		= { 0x5d, 0x47, 0x34, 0x22, 0x20 };
-	static const u8 drive_pci[]		= { 0x41, 0x40, 0x43, 0x42 };
 	static const u8 drive_pci2[]		= { 0x45, 0x44, 0x47, 0x46 };
 
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
 	u8 speed		= ide_rate_filter(drive, xferspeed);
-	u8 pio			= ide_get_best_pio_mode(drive, 255, 4, NULL);
 	u8 unit			= (drive->select.b.unit & 0x01);
-	u8 csb5			= svwks_csb_check(dev);
-	u8 ultra_enable		= 0, ultra_timing = 0;
-	u8 dma_timing		= 0, pio_timing = 0;
-	u16 csb5_pio		= 0;
+
+	u8 ultra_enable	 = 0, ultra_timing = 0, dma_timing = 0;
+
+	if (speed >= XFER_PIO_0 && speed <= XFER_PIO_4) {
+		svwks_tune_pio(drive, speed - XFER_PIO_0);
+		return ide_config_drive_speed(drive, speed);
+	}
 
 	/* If we are about to put a disk into UDMA mode we screwed up.
 	   Our code assumes we never _ever_ do this on an OSB4 */
@@ -153,31 +175,15 @@ static int svwks_tune_chipset (ide_drive
 			BUG();
 
 	pci_read_config_byte(dev, (0x56|hwif->channel), &ultra_timing);
-	pci_read_config_word(dev, 0x4A, &csb5_pio);
 	pci_read_config_byte(dev, 0x54, &ultra_enable);
 
 	ultra_timing	&= ~(0x0F << (4*unit));
 	ultra_enable	&= ~(0x01 << drive->dn);
-	csb5_pio	&= ~(0x0F << (4*drive->dn));
 
 	switch(speed) {
-		case XFER_PIO_4:
-		case XFER_PIO_3:
-		case XFER_PIO_2:
-		case XFER_PIO_1:
-		case XFER_PIO_0:
-			pio_timing |= pio_modes[speed - XFER_PIO_0];
-			csb5_pio   |= ((speed - XFER_PIO_0) << (4*drive->dn));
-			break;
-
 		case XFER_MW_DMA_2:
 		case XFER_MW_DMA_1:
 		case XFER_MW_DMA_0:
-			/*
-			 * TODO: always setup PIO mode so this won't be needed
-			 */
-			pio_timing |= pio_modes[pio];
-			csb5_pio   |= (pio << (4*drive->dn));
 			dma_timing |= dma_modes[speed - XFER_MW_DMA_0];
 			break;
 
@@ -187,11 +193,6 @@ static int svwks_tune_chipset (ide_drive
 		case XFER_UDMA_2:
 		case XFER_UDMA_1:
 		case XFER_UDMA_0:
-			/*
-			 * TODO: always setup PIO mode so this won't be needed
-			 */
-			pio_timing   |= pio_modes[pio];
-			csb5_pio     |= (pio << (4*drive->dn));
 			dma_timing   |= dma_modes[2];
 			ultra_timing |= ((udma_modes[speed - XFER_UDMA_0]) << (4*unit));
 			ultra_enable |= (0x01 << drive->dn);
@@ -199,10 +200,6 @@ static int svwks_tune_chipset (ide_drive
 			break;
 	}
 
-	pci_write_config_byte(dev, drive_pci[drive->dn], pio_timing);
-	if (csb5)
-		pci_write_config_word(dev, 0x4A, csb5_pio);
-
 	pci_write_config_byte(dev, drive_pci2[drive->dn], dma_timing);
 	pci_write_config_byte(dev, (0x56|hwif->channel), ultra_timing);
 	pci_write_config_byte(dev, 0x54, ultra_enable);
@@ -213,7 +210,8 @@ static int svwks_tune_chipset (ide_drive
 static void svwks_tune_drive (ide_drive_t *drive, u8 pio)
 {
 	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
-	(void)svwks_tune_chipset(drive, XFER_PIO_0 + pio);
+	svwks_tune_pio(drive, pio);
+	(void)ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
 
 static int svwks_config_drive_xfer_rate (ide_drive_t *drive)
@@ -414,11 +412,11 @@ static void __devinit init_hwif_svwks (i
 
 	hwif->autodma = 0;
 
-	if (!hwif->dma_base) {
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
+	hwif->drives[0].autotune = 1;
+	hwif->drives[1].autotune = 1;
+
+	if (!hwif->dma_base)
 		return;
-	}
 
 	hwif->ide_dma_check = &svwks_config_drive_xfer_rate;
 	if (hwif->pci_dev->device != PCI_DEVICE_ID_SERVERWORKS_OSB4IDE) {
@@ -431,8 +429,6 @@ static void __devinit init_hwif_svwks (i
 	dma_stat = inb(hwif->dma_status);
 	hwif->drives[0].autodma = (dma_stat & 0x20);
 	hwif->drives[1].autodma = (dma_stat & 0x40);
-	hwif->drives[0].autotune = (!(dma_stat & 0x20));
-	hwif->drives[1].autotune = (!(dma_stat & 0x40));
 }
 
 static int __devinit init_setup_svwks (struct pci_dev *dev, ide_pci_device_t *d)
