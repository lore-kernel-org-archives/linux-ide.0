From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/13] cy82c693: add ->set_dma_mode method
Date: Tue, 13 Nov 2007 00:01:38 +0100
Message-ID: <200711130001.38822.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:63392 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758169AbXKLW6T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 17:58:19 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1250510nfb
        for <linux-ide@vger.kernel.org>; Mon, 12 Nov 2007 14:58:19 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Fix SWDMA/MWDMA masks in cy82c693_chipset.

* Add IDE_HFLAG_CY82C693 host flag and use it in ide_tune_dma() to
  check whether the DMA should be enabled even if ide_max_dma_mode()
  fails.

* Convert cy82c693_dma_enable() to become cy82c693_set_dma_mode()
  and remove no longer needed cy82c693_ide_dma_on().  Then set
  IDE_HFLAG_CY82C693 instead of IDE_HFLAG_TRUST_BIOS_FOR_DMA in
  cy82c693_chipset.

* Bump driver version.

As a result of this patch cy82c693 driver will configure and use DMA on
all SWDMA0-2 and MWDMA0-2 capable ATA devices instead of relying on BIOS.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma.c      |   15 +++++++---
 drivers/ide/pci/cy82c693.c |   64 +++++++--------------------------------------
 include/linux/ide.h        |    2 +
 3 files changed, 24 insertions(+), 57 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -758,6 +758,7 @@ EXPORT_SYMBOL_GPL(ide_find_dma_mode);
 
 static int ide_tune_dma(ide_drive_t *drive)
 {
+	ide_hwif_t *hwif = drive->hwif;
 	u8 speed;
 
 	if (noautodma || drive->nodma || (drive->id->capability & 1) == 0)
@@ -767,15 +768,21 @@ static int ide_tune_dma(ide_drive_t *dri
 	if (__ide_dma_bad_drive(drive))
 		return 0;
 
-	if (drive->hwif->host_flags & IDE_HFLAG_TRUST_BIOS_FOR_DMA)
+	if (hwif->host_flags & IDE_HFLAG_TRUST_BIOS_FOR_DMA)
 		return config_drive_for_dma(drive);
 
 	speed = ide_max_dma_mode(drive);
 
-	if (!speed)
-		return 0;
+	if (!speed) {
+		 /* is this really correct/needed? */
+		if ((hwif->host_flags & IDE_HFLAG_CY82C693) &&
+		    ide_dma_good_drive(drive))
+			return 1;
+		else
+			return 0;
+	}
 
-	if (drive->hwif->host_flags & IDE_HFLAG_NO_SET_MODE)
+	if (hwif->host_flags & IDE_HFLAG_NO_SET_MODE)
 		return 0;
 
 	if (ide_set_dma_mode(drive, speed))
Index: b/drivers/ide/pci/cy82c693.c
===================================================================
--- a/drivers/ide/pci/cy82c693.c
+++ b/drivers/ide/pci/cy82c693.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/cy82c693.c		Version 0.43	Nov 7, 2007
+ * linux/drivers/ide/pci/cy82c693.c		Version 0.44	Nov 8, 2007
  *
  *  Copyright (C) 1998-2000 Andreas S. Krebs (akrebs@altavista.net), Maintainer
  *  Copyright (C) 1998-2002 Andre Hedrick <andre@linux-ide.org>, Integrator
@@ -176,14 +176,12 @@ static void compute_clocks (u8 pio, pio_
  * set DMA mode a specific channel for CY82C693
  */
 
-static void cy82c693_dma_enable (ide_drive_t *drive, int mode, int single)
+static void cy82c693_set_dma_mode(ide_drive_t *drive, const u8 mode)
 {
-	u8 index = 0, data = 0;
+	ide_hwif_t *hwif = drive->hwif;
+	u8 single = (mode & 0x10) >> 4, index = 0, data = 0;
 
-	if (mode>2)	/* make sure we set a valid mode */
-		mode = 2;
-
-	index = (HWIF(drive)->channel==0) ? CY82_INDEX_CHANNEL0 : CY82_INDEX_CHANNEL1;
+	index = hwif->channel ? CY82_INDEX_CHANNEL1 : CY82_INDEX_CHANNEL0;
 
 #if CY82C693_DEBUG_LOGS
 	/* for debug let's show the previous values */
@@ -196,7 +194,7 @@ static void cy82c693_dma_enable (ide_dri
 		(data&0x3), ((data>>2)&1));
 #endif /* CY82C693_DEBUG_LOGS */
 
-	data = (u8)mode|(u8)(single<<2);
+	data = (mode & 3) | (single << 2);
 
 	outb(index, CY82_INDEX_PORT);
 	outb(data, CY82_DATA_PORT);
@@ -204,7 +202,7 @@ static void cy82c693_dma_enable (ide_dri
 #if CY82C693_DEBUG_INFO
 	printk(KERN_INFO "%s (ch=%d, dev=%d): set DMA mode to %d (single=%d)\n",
 		drive->name, HWIF(drive)->channel, drive->select.b.unit,
-		mode, single);
+		mode & 3, single);
 #endif /* CY82C693_DEBUG_INFO */
 
 	/* 
@@ -227,42 +225,6 @@ static void cy82c693_dma_enable (ide_dri
 #endif /* CY82C693_DEBUG_INFO */
 }
 
-/* 
- * used to set DMA mode for CY82C693 (single and multi modes)
- */
-static int cy82c693_ide_dma_on (ide_drive_t *drive)
-{
-	struct hd_driveid *id = drive->id;
-
-#if CY82C693_DEBUG_INFO
-	printk (KERN_INFO "dma_on: %s\n", drive->name);
-#endif /* CY82C693_DEBUG_INFO */
-
-	if (id != NULL) {		
-		/* Enable DMA on any drive that has DMA
-		 * (multi or single) enabled
-		 */
-		if (id->field_valid & 2) {	/* regular DMA */
-			int mmode, smode;
-
-			mmode = id->dma_mword & (id->dma_mword >> 8);
-			smode = id->dma_1word & (id->dma_1word >> 8);
-
-			mmode &= ATA_MWDMA2;
-			smode &= ATA_SWDMA2;
-
-			if (mmode != 0) {
-				/* enable multi */
-				cy82c693_dma_enable(drive, (mmode >> 1), 0);
-			} else if (smode != 0) {
-				/* enable single */
-				cy82c693_dma_enable(drive, (smode >> 1), 1);
-			}
-		}
-	}
-        return __ide_dma_on(drive);
-}
-
 static void cy82c693_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	ide_hwif_t *hwif = HWIF(drive);
@@ -429,11 +391,7 @@ static unsigned int __devinit init_chips
 static void __devinit init_hwif_cy82c693(ide_hwif_t *hwif)
 {
 	hwif->set_pio_mode = &cy82c693_set_pio_mode;
-
-	if (hwif->dma_base == 0)
-		return;
-
-	hwif->ide_dma_on = &cy82c693_ide_dma_on;
+	hwif->set_dma_mode = &cy82c693_set_dma_mode;
 }
 
 static void __devinit init_iops_cy82c693(ide_hwif_t *hwif)
@@ -454,11 +412,11 @@ static const struct ide_port_info cy82c6
 	.init_iops	= init_iops_cy82c693,
 	.init_hwif	= init_hwif_cy82c693,
 	.chipset	= ide_cy82c693,
-	.host_flags	= IDE_HFLAG_SINGLE | IDE_HFLAG_TRUST_BIOS_FOR_DMA |
+	.host_flags	= IDE_HFLAG_SINGLE | IDE_HFLAG_CY82C693 |
 			  IDE_HFLAG_BOOTABLE,
 	.pio_mask	= ATA_PIO4,
-	.swdma_mask	= ATA_SWDMA2_ONLY,
-	.mwdma_mask	= ATA_MWDMA2_ONLY,
+	.swdma_mask	= ATA_SWDMA2,
+	.mwdma_mask	= ATA_MWDMA2,
 };
 
 static int __devinit cy82c693_init_one(struct pci_dev *dev, const struct pci_device_id *id)
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1095,6 +1095,8 @@ enum {
 	/* unmask IRQs */
 	IDE_HFLAG_UNMASK_IRQS		= (1 << 25),
 	IDE_HFLAG_ABUSE_SET_DMA_MODE	= (1 << 26),
+	/* host is CY82C693 */
+	IDE_HFLAG_CY82C693		= (1 << 27),
 };
 
 #ifdef CONFIG_BLK_DEV_OFFBOARD
