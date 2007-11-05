From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/2] sl82c105: program DMA/PIO timings in ->dma_start/->ide_dma_end
Date: Tue, 6 Nov 2007 00:26:50 +0100
Message-ID: <200711060026.51049.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:52284 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754544AbXKEXWL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Nov 2007 18:22:11 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1517616nfb
        for <linux-ide@vger.kernel.org>; Mon, 05 Nov 2007 15:22:09 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>


* Program DMA timings in sl82c105_dma_start() (->dma_start method)
  before starting DMA transfer.

* Add sl82c105_dma_end() (->ide_dma_end method) to switch back to
  PIO timings when DMA transfer is complete.

* In sl82c105_set_pio_mode() program timings regardless of ->using_dma
  setting and in sl82c105_set_dma_mode() only cache the new timings.

* Remove no longer needed sl82c105_{ide_dma_on,off_quietly}().

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sl82c105.c |   55 ++++++++++++---------------------------------
 1 file changed, 15 insertions(+), 40 deletions(-)

Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -13,6 +13,7 @@
  *  -- Benjamin Herrenschmidt (01/11/03) benh@kernel.crashing.org
  *
  * Copyright (C) 2006-2007 MontaVista Software, Inc. <source@mvista.com>
+ * Copyright (C)      2007 Bartlomiej Zolnierkiewicz
  */
 
 #include <linux/types.h>
@@ -90,14 +91,8 @@ static void sl82c105_set_pio_mode(ide_dr
 	drive->drive_data &= 0xffff0000;
 	drive->drive_data |= drv_ctrl;
 
-	if (!drive->using_dma) {
-		/*
-		 * If we are actually using MW DMA, then we can not
-		 * reprogram the interface drive control register.
-		 */
-		pci_write_config_word(dev, reg,  drv_ctrl);
-		pci_read_config_word (dev, reg, &drv_ctrl);
-	}
+	pci_write_config_word(dev, reg,  drv_ctrl);
+	pci_read_config_word (dev, reg, &drv_ctrl);
 
 	printk(KERN_DEBUG "%s: selected %s (%dns) (%04X)\n", drive->name,
 			  ide_xfer_verbose(pio + XFER_PIO_0),
@@ -123,17 +118,6 @@ static void sl82c105_set_dma_mode(ide_dr
 	 */
 	drive->drive_data &= 0x0000ffff;
 	drive->drive_data |= (unsigned long)drv_ctrl << 16;
-
-	/*
-	 * If we are already using DMA, we just reprogram
-	 * the drive control register.
-	 */
-	if (drive->using_dma) {
-		struct pci_dev *dev	= HWIF(drive)->pci_dev;
-		int reg 		= 0x44 + drive->dn * 4;
-
-		pci_write_config_word(dev, reg, drv_ctrl);
-	}
 }
 
 /*
@@ -201,6 +185,11 @@ static void sl82c105_dma_start(ide_drive
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
+	int reg 		= 0x44 + drive->dn * 4;
+
+	DBG(("%s(drive:%s)\n", __FUNCTION__, drive->name));
+
+	pci_write_config_word(dev, reg, drive->drive_data >> 16);
 
 	sl82c105_reset_host(dev);
 	ide_dma_start(drive);
@@ -214,32 +203,19 @@ static void sl82c105_dma_timeout(ide_dri
 	ide_dma_timeout(drive);
 }
 
-static int sl82c105_ide_dma_on(ide_drive_t *drive)
-{
-	struct pci_dev *dev	= HWIF(drive)->pci_dev;
-	int rc, reg 		= 0x44 + drive->dn * 4;
-
-	DBG(("sl82c105_ide_dma_on(drive:%s)\n", drive->name));
-
-	rc = __ide_dma_on(drive);
-	if (rc == 0) {
-		pci_write_config_word(dev, reg, drive->drive_data >> 16);
-
-		printk(KERN_INFO "%s: DMA enabled\n", drive->name);
-	}
-	return rc;
-}
-
-static void sl82c105_dma_off_quietly(ide_drive_t *drive)
+static int sl82c105_dma_end(ide_drive_t *drive)
 {
 	struct pci_dev *dev	= HWIF(drive)->pci_dev;
 	int reg 		= 0x44 + drive->dn * 4;
+	int ret;
+
+	DBG(("%s(drive:%s)\n", __FUNCTION__, drive->name));
 
-	DBG(("sl82c105_dma_off_quietly(drive:%s)\n", drive->name));
+	ret = __ide_dma_end(drive);
 
 	pci_write_config_word(dev, reg, drive->drive_data);
 
-	ide_dma_off_quietly(drive);
+	return ret;
 }
 
 /*
@@ -369,10 +345,9 @@ static void __devinit init_hwif_sl82c105
 
 	hwif->mwdma_mask = ATA_MWDMA2;
 
-	hwif->ide_dma_on		= &sl82c105_ide_dma_on;
-	hwif->dma_off_quietly		= &sl82c105_dma_off_quietly;
 	hwif->dma_lost_irq		= &sl82c105_dma_lost_irq;
 	hwif->dma_start			= &sl82c105_dma_start;
+	hwif->ide_dma_end		= &sl82c105_dma_end;
 	hwif->dma_timeout		= &sl82c105_dma_timeout;
 
 	if (hwif->mate)
