From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] sl82c105: DMA support fixes
Date: Tue, 30 Jan 2007 23:32:22 +0300
Message-ID: <200701302332.22543.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:35382 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751385AbXA3Uc2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jan 2007 15:32:28 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Fix a number of issues with the DMA support code:

- driver claims support for all SW/MW DMA modes while supporting only MWDMA2;

- ide_dma_check() method tries to enable DMA on the "known good" drives which
  don't support MWDMA2;

- ide_dma_on() method upon failure to set drive to MWDMA2 re-tunes already
  tuned PIO mode and calls ide_dma_off() method instead of returning error;

- ide_dma_off() method sets drive->current_speed while it doesn't actually
  change (only the PIO timings are re-loaded into the chip's registers);

- init_hwif() method forcibly sets/resets both "drive DMA capable" bits while
  this is properly handled by ide_dma_{on,off}() methods being called later...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 drivers/ide/pci/sl82c105.c |   18 ++++--------------
 1 files changed, 4 insertions(+), 14 deletions(-)

Index: linux-2.6/drivers/ide/pci/sl82c105.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/sl82c105.c
+++ linux-2.6/drivers/ide/pci/sl82c105.c
@@ -164,7 +164,7 @@ static int sl82c105_check_drive (ide_dri
 				return hwif->ide_dma_on(drive);
 		}
 
-		if (__ide_dma_good_drive(drive))
+		if (__ide_dma_good_drive(drive) && id->eide_dma_time < 150)
 			return hwif->ide_dma_on(drive);
 	} while (0);
 
@@ -259,10 +259,8 @@ static int sl82c105_ide_dma_on (ide_driv
 {
 	DBG(("sl82c105_ide_dma_on(drive:%s)\n", drive->name));
 
-	if (config_for_dma(drive)) {
-		config_for_pio(drive, 4, 0, 0);
-		return HWIF(drive)->ide_dma_off_quietly(drive);
-	}
+	if (config_for_dma(drive))
+		return 1;
 	printk(KERN_INFO "%s: DMA enabled\n", drive->name);
 	return __ide_dma_on(drive);
 }
@@ -278,7 +276,6 @@ static int sl82c105_ide_dma_off_quietly 
 	if (drive->pio_speed)
 		speed = drive->pio_speed - XFER_PIO_0;
 	config_for_pio(drive, speed, 0, 1);
-	drive->current_speed = drive->pio_speed;
 
 	return rc;
 }
@@ -401,11 +398,9 @@ static unsigned int __devinit init_chips
 /*
  * Initialise the chip
  */
-
 static void __devinit init_hwif_sl82c105(ide_hwif_t *hwif)
 {
 	unsigned int rev;
-	u8 dma_state;
 
 	DBG(("init_hwif_sl82c105(hwif: ide%d)\n", hwif->index));
 
@@ -431,7 +426,6 @@ static void __devinit init_hwif_sl82c105
 	if (!hwif->dma_base)
 		return;
 
-	dma_state = hwif->INB(hwif->dma_base + 2) & ~0x60;
 	rev = sl82c105_bridge_revision(hwif->pci_dev);
 	if (rev <= 5) {
 		/*
@@ -441,11 +435,8 @@ static void __devinit init_hwif_sl82c105
 		printk("    %s: Winbond 553 bridge revision %d, BM-DMA disabled\n",
 		       hwif->name, rev);
 	} else {
-		dma_state |= 0x60;
-
 		hwif->atapi_dma = 1;
-		hwif->mwdma_mask = 0x07;
-		hwif->swdma_mask = 0x07;
+		hwif->mwdma_mask = 0x04;
 
 		hwif->ide_dma_check = &sl82c105_check_drive;
 		hwif->ide_dma_on = &sl82c105_ide_dma_on;
@@ -462,7 +453,6 @@ static void __devinit init_hwif_sl82c105
 		if (hwif->mate)
 			hwif->serialized = hwif->mate->serialized = 1;
 	}
-	hwif->OUTB(dma_state, hwif->dma_base + 2);
 }
 
 static ide_pci_device_t sl82c105_chipset __devinitdata = {

