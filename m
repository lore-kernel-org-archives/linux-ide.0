From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 9/12] cs5520: fix ->dma_base equal zero handling
Date: Sun, 29 Jul 2007 19:54:15 +0200
Message-ID: <200707291954.15700.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:44326 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765468AbXG2SFX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jul 2007 14:05:23 -0400
Received: by nf-out-0910.google.com with SMTP id g13so123536nfb
        for <linux-ide@vger.kernel.org>; Sun, 29 Jul 2007 11:05:22 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Set hwif->ide_dma_{check,on} and hwif->autodma to 1 after checking that
->dma_base exists.  If ->dma_base is not set (== PCI BAR4 cannot be reserved)
then DMA hooks shouldn't be initialized or bad things will happen.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cs5520.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -142,25 +142,24 @@ static void __devinit init_hwif_cs5520(i
 {
 	hwif->set_pio_mode = &cs5520_set_pio_mode;
 	hwif->set_dma_mode = &cs5520_set_dma_mode;
-	hwif->ide_dma_check = &cs5520_config_drive_xfer_rate;
-	hwif->ide_dma_on = &cs5520_dma_on;
 
-	if(!noautodma)
-		hwif->autodma = 1;
-	
-	if(!hwif->dma_base)
-	{
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
+	if (hwif->dma_base == 0) {
+		hwif->drives[1].autotune = hwif->drives[0].autotune = 1;
 		return;
 	}
 
+	hwif->ide_dma_check = &cs5520_config_drive_xfer_rate;
+	hwif->ide_dma_on = &cs5520_dma_on;
+
 	/* ATAPI is harder so leave it for now */
 	hwif->atapi_dma = 0;
 	hwif->ultra_mask = 0;
 	hwif->swdma_mask = 0;
 	hwif->mwdma_mask = 0;
-	
+
+	if (!noautodma)
+		hwif->autodma = 1;
+
 	hwif->drives[0].autodma = hwif->autodma;
 	hwif->drives[1].autodma = hwif->autodma;
 }
