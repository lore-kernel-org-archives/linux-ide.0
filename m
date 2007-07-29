From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/12] sc1200: fix ->dma_base equal zero handling
Date: Sun, 29 Jul 2007 19:54:50 +0200
Message-ID: <200707291954.50378.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:59072 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765631AbXG2SFX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jul 2007 14:05:23 -0400
Received: by ug-out-1314.google.com with SMTP id j3so945472ugf
        for <linux-ide@vger.kernel.org>; Sun, 29 Jul 2007 11:05:22 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Set hwif->atapi_dma/{ultra,mwdma}_mask and drive->autodma after checking that
->dma_base exists.  If ->dma_base is not set (== PCI BAR4 cannot be reserved)
then DMA hooks shouldn't be initialized or bad things will happen.

OTOH hwif->set_{pio,dma}_mode hooks should be set even if hwif->dma_base == 0.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sc1200.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -350,16 +350,20 @@ static void __devinit init_hwif_sc1200 (
 	if (hwif->mate)
 		hwif->serialized = hwif->mate->serialized = 1;
 	hwif->autodma = 0;
-	if (hwif->dma_base) {
-		hwif->udma_filter = sc1200_udma_filter;
-		hwif->ide_dma_check = &sc1200_config_dma;
-		hwif->ide_dma_end   = &sc1200_ide_dma_end;
-        	if (!noautodma)
-                	hwif->autodma = 1;
-
-		hwif->set_pio_mode = &sc1200_set_pio_mode;
-		hwif->set_dma_mode = &sc1200_set_dma_mode;
-	}
+
+	hwif->set_pio_mode = &sc1200_set_pio_mode;
+	hwif->set_dma_mode = &sc1200_set_dma_mode;
+
+	if (hwif->dma_base == 0)
+		return;
+
+	hwif->udma_filter = sc1200_udma_filter;
+	hwif->ide_dma_check = &sc1200_config_dma;
+	hwif->ide_dma_end   = &sc1200_ide_dma_end;
+
+	if (!noautodma)
+		hwif->autodma = 1;
+
         hwif->atapi_dma = 1;
         hwif->ultra_mask = 0x07;
         hwif->mwdma_mask = 0x07;
