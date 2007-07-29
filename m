From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/12] pdc202xx_old: add missing ->dma_base check
Date: Sun, 29 Jul 2007 19:52:32 +0200
Message-ID: <200707291952.32929.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:44316 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765479AbXG2SFU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jul 2007 14:05:20 -0400
Received: by nf-out-0910.google.com with SMTP id g13so123524nfb
        for <linux-ide@vger.kernel.org>; Sun, 29 Jul 2007 11:05:19 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


If ->dma_base is not set (== PCI BAR4 cannot be reserved) then DMA hooks
shouldn't be initialized or bad things will happen.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/pdc202xx_old.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/pci/pdc202xx_old.c	Version 0.50	Mar 3, 2007
+ *  linux/drivers/ide/pci/pdc202xx_old.c	Version 0.51	Jul 27, 2007
  *
  *  Copyright (C) 1998-2002		Andre Hedrick <andre@linux-ide.org>
  *  Copyright (C) 2006-2007		MontaVista Software, Inc.
@@ -335,15 +335,18 @@ static void __devinit init_hwif_pdc202xx
 	if (hwif->pci_dev->device != PCI_DEVICE_ID_PROMISE_20246)
 		hwif->resetproc = &pdc202xx_reset;
 
+	hwif->err_stops_fifo = 1;
+
 	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
 
+	if (hwif->dma_base == 0)
+		return;
+
 	hwif->ultra_mask = hwif->cds->udma_mask;
 	hwif->mwdma_mask = 0x07;
 	hwif->swdma_mask = 0x07;
 	hwif->atapi_dma = 1;
 
-	hwif->err_stops_fifo = 1;
-
 	hwif->ide_dma_check = &pdc202xx_config_drive_xfer_rate;
 	hwif->dma_lost_irq = &pdc202xx_dma_lost_irq;
 	hwif->dma_timeout = &pdc202xx_dma_timeout;
