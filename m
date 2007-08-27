From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 9/8] pdc202xx_old: remove broken SWDMA support
Date: Mon, 27 Aug 2007 21:56:44 +0200
Message-ID: <200708272156.44552.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:15143 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757457AbXH0T7H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Aug 2007 15:59:07 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1259941nfb
        for <linux-ide@vger.kernel.org>; Mon, 27 Aug 2007 12:59:05 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Documentation doesn't mention SWDMA and moreover all timings used
for SWDMA modes were over-clocked when compared to ATA spec.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/pdc202xx_old.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/pci/pdc202xx_old.c	Version 0.51	Jul 27, 2007
+ *  linux/drivers/ide/pci/pdc202xx_old.c	Version 0.52	Aug 27, 2007
  *
  *  Copyright (C) 1998-2002		Andre Hedrick <andre@linux-ide.org>
  *  Copyright (C) 2006-2007		MontaVista Software, Inc.
@@ -97,9 +97,6 @@ static void pdc202xx_set_mode(ide_drive_
 		case XFER_MW_DMA_2:	TB = 0x60; TC = 0x03; break;
 		case XFER_MW_DMA_1:	TB = 0x60; TC = 0x04; break;
 		case XFER_MW_DMA_0:	TB = 0xE0; TC = 0x0F; break;
-		case XFER_SW_DMA_2:	TB = 0x60; TC = 0x05; break;
-		case XFER_SW_DMA_1:	TB = 0x80; TC = 0x06; break;
-		case XFER_SW_DMA_0:	TB = 0xC0; TC = 0x0B; break;
 		case XFER_PIO_4:	TA = 0x01; TB = 0x04; break;
 		case XFER_PIO_3:	TA = 0x02; TB = 0x06; break;
 		case XFER_PIO_2:	TA = 0x03; TB = 0x08; break;
@@ -329,7 +326,6 @@ static void __devinit init_hwif_pdc202xx
 
 	hwif->ultra_mask = hwif->cds->udma_mask;
 	hwif->mwdma_mask = 0x07;
-	hwif->swdma_mask = 0x07;
 
 	hwif->dma_lost_irq = &pdc202xx_dma_lost_irq;
 	hwif->dma_timeout = &pdc202xx_dma_timeout;
