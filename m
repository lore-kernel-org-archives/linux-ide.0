From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/11] atiixp: DMA setup fixes
Date: Sat, 4 Aug 2007 22:05:37 +0200
Message-ID: <200708042205.37590.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:51446 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757260AbXHDUQF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Aug 2007 16:16:05 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1014326fkz
        for <linux-ide@vger.kernel.org>; Sat, 04 Aug 2007 13:16:04 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Fix handling of unsupported/invalid modes in atiixp_set_dma_mode().

* ATI controllers allow separate PIO and DMA timings so remove programming
  of PIO modes from atiixp_set_dma_mode().  Also remove no longer needed
  atiixp_dma_2_pio() helper.

* SWDMA timings are not programmed by atiixp_set_dma_mode() and if SWDMA
  mode is chosen atiixp_dma_host_on() erroneously enables UDMA, just disable
  support for SWDMA modes for now.

* Enable support for MWDMA0 mode.

* Bump driver version.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/atiixp.c |   53 ++++-------------------------------------------
 1 file changed, 5 insertions(+), 48 deletions(-)

Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/pci/atiixp.c	Version 0.02	Jun 16 2007
+ *  linux/drivers/ide/pci/atiixp.c	Version 0.03	Aug 3 2007
  *
  *  Copyright (C) 2003 ATI Inc. <hyu@ati.com>
  *  Copyright (C) 2004,2007 Bartlomiej Zolnierkiewicz
@@ -47,43 +47,6 @@ static int save_mdma_mode[4];
 
 static DEFINE_SPINLOCK(atiixp_lock);
 
-/**
- *	atiixp_dma_2_pio		-	return the PIO mode matching DMA
- *	@xfer_rate: transfer speed
- *
- *	Returns the nearest equivalent PIO timing for the PIO or DMA
- *	mode requested by the controller.
- */
-
-static u8 atiixp_dma_2_pio(u8 xfer_rate) {
-	switch(xfer_rate) {
-		case XFER_UDMA_6:
-		case XFER_UDMA_5:
-		case XFER_UDMA_4:
-		case XFER_UDMA_3:
-		case XFER_UDMA_2:
-		case XFER_UDMA_1:
-		case XFER_UDMA_0:
-		case XFER_MW_DMA_2:
-		case XFER_PIO_4:
-			return 4;
-		case XFER_MW_DMA_1:
-		case XFER_PIO_3:
-			return 3;
-		case XFER_SW_DMA_2:
-		case XFER_PIO_2:
-			return 2;
-		case XFER_MW_DMA_0:
-		case XFER_SW_DMA_1:
-		case XFER_SW_DMA_0:
-		case XFER_PIO_1:
-		case XFER_PIO_0:
-		case XFER_PIO_SLOW:
-		default:
-			return 0;
-	}
-}
-
 static void atiixp_dma_host_on(ide_drive_t *drive)
 {
 	struct pci_dev *dev = drive->hwif->pci_dev;
@@ -169,7 +132,9 @@ static void atiixp_set_dma_mode(ide_driv
 	int timing_shift = (drive->dn & 2) ? 16 : 0 + (drive->dn & 1) ? 0 : 8;
 	u32 tmp32;
 	u16 tmp16;
-	u8 pio;
+
+	if (speed < XFER_MW_DMA_0)
+		return;
 
 	spin_lock_irqsave(&atiixp_lock, flags);
 
@@ -191,13 +156,6 @@ static void atiixp_set_dma_mode(ide_driv
 	}
 
 	spin_unlock_irqrestore(&atiixp_lock, flags);
-
-	if (speed >= XFER_SW_DMA_0)
-		pio = atiixp_dma_2_pio(speed);
-	else
-		pio = speed - XFER_PIO_0;
-
-	atiixp_set_pio_mode(drive, pio);
 }
 
 /**
@@ -249,8 +207,7 @@ static void __devinit init_hwif_atiixp(i
 
 	hwif->atapi_dma = 1;
 	hwif->ultra_mask = 0x3f;
-	hwif->mwdma_mask = 0x06;
-	hwif->swdma_mask = 0x04;
+	hwif->mwdma_mask = 0x07;
 
 	pci_read_config_byte(pdev, ATIIXP_IDE_UDMA_MODE + ch, &udma_mode);
 
