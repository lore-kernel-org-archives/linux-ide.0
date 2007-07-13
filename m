From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] siimage: fix ->set_pio_mode method to select PIO data transfer
Date: Fri, 13 Jul 2007 23:11:57 +0200
Message-ID: <200707132311.58022.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:44346 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895AbXGMVbK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 17:31:10 -0400
Received: by ug-out-1314.google.com with SMTP id j3so647444ugf
        for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 14:31:09 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Remember to select PIO data transfer (with IORDY monitored) in sil_tune_pio()
  (->set_pio_mode method) so the controller is always programmed correctly for
  PIO transfers (this is important if DMA is not going to be used).

* Don't set DMA/UDMA timings for PIO modes in siimage_tune_chipset().

* Bump driver version.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/siimage.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/siimage.c		Version 1.15	Jun 29 2007
+ * linux/drivers/ide/pci/siimage.c		Version 1.16	Jul 13 2007
  *
  * Copyright (C) 2001-2002	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2003		Red Hat <alan@redhat.com>
@@ -185,7 +185,12 @@ static void sil_tune_pio(ide_drive_t *dr
 	u16 speedp		= 0;
 	unsigned long addr	= siimage_seldev(drive, 0x04);
 	unsigned long tfaddr	= siimage_selreg(hwif, 0x02);
+	unsigned long base	= (unsigned long)hwif->hwif_data;
 	u8 tf_pio		= pio;
+	u8 addr_mask		= hwif->channel ? (hwif->mmio ? 0xF4 : 0x84)
+						: (hwif->mmio ? 0xB4 : 0x80);
+	u8 mode			= 0;
+	u8 unit			= drive->select.b.unit;
 
 	/* trim *taskfile* PIO to the slowest of the master/slave */
 	if (pair->present) {
@@ -207,6 +212,11 @@ static void sil_tune_pio(ide_drive_t *dr
 			hwif->OUTW(hwif->INW(tfaddr-2)|0x200, tfaddr-2);
 		else
 			hwif->OUTW(hwif->INW(tfaddr-2)&~0x200, tfaddr-2);
+
+		mode = hwif->INB(base + addr_mask);
+		mode &= ~(unit ? 0x30 : 0x03);
+		mode |= (unit ? 0x10 : 0x01);
+		hwif->OUTB(mode, base + addr_mask);
 	} else {
 		pci_write_config_word(hwif->pci_dev, addr, speedp);
 		pci_write_config_word(hwif->pci_dev, tfaddr, speedt);
@@ -216,6 +226,11 @@ static void sil_tune_pio(ide_drive_t *dr
 		if (pio > 2)
 			speedp |= 0x200;
 		pci_write_config_word(hwif->pci_dev, tfaddr-2, speedp);
+
+		pci_read_config_byte(hwif->pci_dev, addr_mask, &mode);
+		mode &= ~(unit ? 0x30 : 0x03);
+		mode |= (unit ? 0x10 : 0x01);
+		pci_write_config_byte(hwif->pci_dev, addr_mask, mode);
 	}
 }
 
@@ -275,8 +290,7 @@ static int siimage_tune_chipset(ide_driv
 		case XFER_PIO_1:
 		case XFER_PIO_0:
 			sil_tune_pio(drive, speed - XFER_PIO_0);
-			mode |= ((unit) ? 0x10 : 0x01);
-			break;
+			return ide_config_drive_speed(drive, speed);
 		case XFER_MW_DMA_2:
 		case XFER_MW_DMA_1:
 		case XFER_MW_DMA_0:
