From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/12] pdc202xx_new: add missing ->dma_base check
Date: Sun, 29 Jul 2007 19:52:02 +0200
Message-ID: <200707291952.02391.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:59697 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765188AbXG2SFS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jul 2007 14:05:18 -0400
Received: by ug-out-1314.google.com with SMTP id j3so945455ugf
        for <linux-ide@vger.kernel.org>; Sun, 29 Jul 2007 11:05:17 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


If ->dma_base is not set (== PCI BAR4 cannot be reserved) then DMA hooks
shouldn't be initialized or bad things will happen.

Also this host driver requires valid PCI BAR4 for normal operation so
check it in ->init_chipset and fail initialization if not set.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/pdc202xx_new.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -370,6 +370,9 @@ static unsigned int __devinit init_chips
 	int f, r;
 	u8 pll_ctl0, pll_ctl1;
 
+	if (dma_base == 0)
+		return -EFAULT;
+
 #ifdef CONFIG_PPC_PMAC
 	apple_kiwi_init(dev);
 #endif
@@ -487,15 +490,18 @@ static void __devinit init_hwif_pdc202ne
 	hwif->quirkproc = &pdcnew_quirkproc;
 	hwif->resetproc = &pdcnew_reset;
 
+	hwif->err_stops_fifo = 1;
+
 	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
 
+	if (hwif->dma_base == 0)
+		return;
+
 	hwif->atapi_dma  = 1;
 
 	hwif->ultra_mask = hwif->cds->udma_mask;
 	hwif->mwdma_mask = 0x07;
 
-	hwif->err_stops_fifo = 1;
-
 	hwif->ide_dma_check = &pdcnew_config_drive_xfer_rate;
 
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
