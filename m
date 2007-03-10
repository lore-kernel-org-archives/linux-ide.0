From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 9/13] cs5530/sc1200: add ->speedproc support
Date: Sat, 10 Mar 2007 22:09:30 +0100
Message-ID: <200703102209.30529.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:46176 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932293AbXCJVJO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Mar 2007 16:09:14 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1749119uga
        for <linux-ide@vger.kernel.org>; Sat, 10 Mar 2007 13:09:13 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

[PATCH] cs5530/sc1200: add ->speedproc support

* add {cs5530,sc1200}_tunepio() for programming PIO timings

* add {cs5530,sc1200}_tune_chipset() (->speedproc method) for setting
  transfer mode and convert {cs5530,sc1200}_config_dma() to use it

* bump driver version

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---

 drivers/ide/pci/cs5530.c |   57 +++++++++++++++++++++++++-------------
 drivers/ide/pci/sc1200.c |   70 ++++++++++++++++++++++++++++-------------------
 2 files changed, 81 insertions(+), 46 deletions(-)

Index: b/drivers/ide/pci/cs5530.c
===================================================================
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/cs5530.c		Version 0.72	Mar 10 2007
+ * linux/drivers/ide/pci/cs5530.c		Version 0.73	Mar 10 2007
  *
  * Copyright (C) 2000			Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2000			Mark Lord <mlord@pobox.com>
@@ -62,6 +62,14 @@ static unsigned int cs5530_pio_timings[2
 #define CS5530_BAD_PIO(timings) (((timings)&~0x80000000)==0x0000e132)
 #define CS5530_BASEREG(hwif)	(((hwif)->dma_base & ~0xf) + ((hwif)->channel ? 0x30 : 0x20))
 
+static void cs5530_tunepio(ide_drive_t *drive, u8 pio)
+{
+	unsigned long basereg = CS5530_BASEREG(drive->hwif);
+	unsigned int format = (inl(basereg + 4) >> 31) & 1;
+
+	outl(cs5530_pio_timings[format][pio], basereg + ((drive->dn & 1)<<3));
+}
+
 /**
  *	cs5530_tuneproc		-	select/set PIO modes
  *
@@ -74,17 +82,10 @@ static unsigned int cs5530_pio_timings[2
 
 static void cs5530_tuneproc (ide_drive_t *drive, u8 pio)	/* pio=255 means "autotune" */
 {
-	ide_hwif_t	*hwif = HWIF(drive);
-	unsigned int	format;
-	unsigned long basereg = CS5530_BASEREG(hwif);
-	static u8	modes[5] = { XFER_PIO_0, XFER_PIO_1, XFER_PIO_2, XFER_PIO_3, XFER_PIO_4};
-
 	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
-	if (!cs5530_set_xfer_mode(drive, modes[pio])) {
-		format = (inl(basereg + 4) >> 31) & 1;
-		outl(cs5530_pio_timings[format][pio],
-			basereg+(drive->select.b.unit<<3));
-	}
+
+	if (cs5530_set_xfer_mode(drive, XFER_PIO_0 + pio) == 0)
+		cs5530_tunepio(drive, pio);
 }
 
 /**
@@ -136,18 +137,27 @@ out:
 
 static int cs5530_config_dma(ide_drive_t *drive)
 {
-	ide_hwif_t *hwif = drive->hwif;
-	unsigned int reg, timings = 0;
+	if (ide_use_dma(drive)) {
+		u8 mode = ide_max_dma_mode(drive);
+
+		if (mode && drive->hwif->speedproc(drive, mode) == 0)
+			return 0;
+	}
+
+	return 1;
+}
+
+static int cs5530_tune_chipset(ide_drive_t *drive, u8 mode)
+{
 	unsigned long basereg;
-	u8 unit = drive->dn & 1, mode = 0;
+	unsigned int reg, timings = 0;
 
-	if (ide_use_dma(drive))
-		mode = ide_max_dma_mode(drive);
+	mode = ide_rate_filter(drive, mode);
 
 	/*
 	 * Tell the drive to switch to the new mode; abort on failure.
 	 */
-	if (!mode || cs5530_set_xfer_mode(drive, mode))
+	if (cs5530_set_xfer_mode(drive, mode))
 		return 1;	/* failure */
 
 	/*
@@ -160,14 +170,21 @@ static int cs5530_config_dma(ide_drive_t
 		case XFER_MW_DMA_0:	timings = 0x00077771; break;
 		case XFER_MW_DMA_1:	timings = 0x00012121; break;
 		case XFER_MW_DMA_2:	timings = 0x00002020; break;
+		case XFER_PIO_4:
+		case XFER_PIO_3:
+		case XFER_PIO_2:
+		case XFER_PIO_1:
+		case XFER_PIO_0:
+			cs5530_tunepio(drive, mode - XFER_PIO_0);
+			return 0;
 		default:
 			BUG();
 			break;
 	}
-	basereg = CS5530_BASEREG(hwif);
+	basereg = CS5530_BASEREG(drive->hwif);
 	reg = inl(basereg + 4);			/* get drive0 config register */
 	timings |= reg & 0x80000000;		/* preserve PIO format bit */
-	if (unit == 0) {			/* are we configuring drive0? */
+	if ((drive-> dn & 1) == 0) {		/* are we configuring drive0? */
 		outl(timings, basereg + 4);	/* write drive0 config register */
 	} else {
 		if (timings & 0x00100000)
@@ -293,6 +310,8 @@ static void __devinit init_hwif_cs5530 (
 		hwif->serialized = hwif->mate->serialized = 1;
 
 	hwif->tuneproc = &cs5530_tuneproc;
+	hwif->speedproc = &cs5530_tune_chipset;
+
 	basereg = CS5530_BASEREG(hwif);
 	d0_timings = inl(basereg + 0);
 	if (CS5530_BAD_PIO(d0_timings)) {
Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/sc1200.c		Version 0.93	Mar 10 2007
+ * linux/drivers/ide/pci/sc1200.c		Version 0.94	Mar 10 2007
  *
  * Copyright (C) 2000-2002		Mark Lord <mlord@pobox.com>
  * Copyright (C)      2007		Bartlomiej Zolnierkiewicz
@@ -95,6 +95,20 @@ static const unsigned int sc1200_pio_tim
  */
 //#define SC1200_BAD_PIO(timings) (((timings)&~0x80000000)==0x00009172)
 
+static void sc1200_tunepio(ide_drive_t *drive, u8 pio)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct pci_dev *pdev = hwif->pci_dev;
+	unsigned int basereg = hwif->channel ? 0x50 : 0x40, format = 0;
+
+	pci_read_config_dword(pdev, basereg + 4, &format);
+	format = (format >> 31) & 1;
+	if (format)
+		format += sc1200_get_pci_clock();
+	pci_write_config_dword(pdev, basereg + ((drive->dn & 1) << 3),
+			       sc1200_pio_timings[format][pio]);
+}
+
 /*
  *	The SC1200 specifies that two drives sharing a cable cannot mix
  *	UDMA/MDMA.  It has to be one or the other, for the pair, though
@@ -124,11 +138,7 @@ out:
 	return mask;
 }
 
-/*
- * sc1200_config_dma2() handles selection/setting of DMA/UDMA modes
- * for both the chipset and drive.
- */
-static int sc1200_config_dma2 (ide_drive_t *drive, int mode)
+static int sc1200_tune_chipset(ide_drive_t *drive, u8 mode)
 {
 	ide_hwif_t		*hwif = HWIF(drive);
 	int			unit = drive->select.b.unit;
@@ -136,14 +146,26 @@ static int sc1200_config_dma2 (ide_drive
 	unsigned short		pci_clock;
 	unsigned int		basereg = hwif->channel ? 0x50 : 0x40;
 
+	mode = ide_rate_filter(drive, mode);
+
 	/*
 	 * Tell the drive to switch to the new mode; abort on failure.
 	 */
-	if (!mode || sc1200_set_xfer_mode(drive, mode)) {
+	if (sc1200_set_xfer_mode(drive, mode)) {
 		printk("SC1200: set xfer mode failure\n");
 		return 1;	/* failure */
 	}
 
+	switch (mode) {
+	case XFER_PIO_4:
+	case XFER_PIO_3:
+	case XFER_PIO_2:
+	case XFER_PIO_1:
+	case XFER_PIO_0:
+		sc1200_tunepio(drive, mode - XFER_PIO_0);
+		return 0;
+	}
+
 	pci_clock = sc1200_get_pci_clock();
 
 	/*
@@ -196,11 +218,9 @@ static int sc1200_config_dma2 (ide_drive
 				case PCI_CLK_66:	timings = 0x00015151;	break;
 			}
 			break;
-	}
-
-	if (timings == 0) {
-		printk("%s: sc1200_config_dma: huh? mode=%02x clk=%x \n", drive->name, mode, pci_clock);
-		return 1;	/* failure */
+		default:
+			BUG();
+			break;
 	}
 
 	if (unit == 0) {			/* are we configuring drive0? */
@@ -220,12 +240,14 @@ static int sc1200_config_dma2 (ide_drive
  */
 static int sc1200_config_dma (ide_drive_t *drive)
 {
-	u8 mode = 0;
+	if (ide_use_dma(drive)) {
+		u8 mode = ide_max_dma_mode(drive);
 
-	if (ide_use_dma(drive))
-		mode = ide_max_dma_mode(drive);
+		if (mode && drive->hwif->speedproc(drive, mode) == 0)
+			return 0;
+	}
 
-	return sc1200_config_dma2(drive, mode);
+	return 1;
 }
 
 
@@ -265,8 +287,6 @@ static int sc1200_ide_dma_end (ide_drive
 static void sc1200_tuneproc (ide_drive_t *drive, byte pio)	/* mode=255 means "autotune" */
 {
 	ide_hwif_t	*hwif = HWIF(drive);
-	unsigned int	format;
-	static byte	modes[5] = {XFER_PIO_0, XFER_PIO_1, XFER_PIO_2, XFER_PIO_3, XFER_PIO_4};
 	int		mode = -1;
 
 	/*
@@ -283,21 +303,16 @@ static void sc1200_tuneproc (ide_drive_t
 	if (mode != -1) {
 		printk("SC1200: %s: changing (U)DMA mode\n", drive->name);
 		hwif->dma_off_quietly(drive);
-		if (sc1200_config_dma2(drive, mode) == 0)
+		if (sc1200_tune_chipset(drive, mode) == 0)
 			hwif->dma_host_on(drive);
 		return;
 	}
 
 	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
 	printk("SC1200: %s: setting PIO mode%d\n", drive->name, pio);
-	if (!sc1200_set_xfer_mode(drive, modes[pio])) {
-		unsigned int basereg = hwif->channel ? 0x50 : 0x40;
-		pci_read_config_dword (hwif->pci_dev, basereg+4, &format);
-		format = (format >> 31) & 1;
-		if (format)
-			format += sc1200_get_pci_clock();
-		pci_write_config_dword(hwif->pci_dev, basereg + (drive->select.b.unit << 3), sc1200_pio_timings[format][pio]);
- 	}
+
+	if (sc1200_set_xfer_mode(drive, XFER_PIO_0 + pio) == 0)
+		sc1200_tunepio(drive, pio);
 }
 
 #ifdef CONFIG_PM
@@ -447,6 +462,7 @@ static void __devinit init_hwif_sc1200 (
         	if (!noautodma)
                 	hwif->autodma = 1;
 		hwif->tuneproc = &sc1200_tuneproc;
+		hwif->speedproc = &sc1200_tune_chipset;
 	}
         hwif->atapi_dma = 1;
         hwif->ultra_mask = 0x07;
