From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/12] cs5535: add missing ->dma_base check
Date: Sun, 29 Jul 2007 19:51:21 +0200
Message-ID: <200707291951.21443.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:44316 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765373AbXG2SFR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jul 2007 14:05:17 -0400
Received: by nf-out-0910.google.com with SMTP id g13so123524nfb
        for <linux-ide@vger.kernel.org>; Sun, 29 Jul 2007 11:05:16 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


If ->dma_base is not set (== PCI BAR4 cannot be reserved) then DMA hooks
shouldn't be initialized or bad things will happen.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cs5535.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: b/drivers/ide/pci/cs5535.c
===================================================================
--- a/drivers/ide/pci/cs5535.c
+++ b/drivers/ide/pci/cs5535.c
@@ -190,12 +190,16 @@ static u8 __devinit cs5535_cable_detect(
  */
 static void __devinit init_hwif_cs5535(ide_hwif_t *hwif)
 {
-	int i;
-
 	hwif->autodma = 0;
 
 	hwif->set_pio_mode = &cs5535_set_pio_mode;
 	hwif->set_dma_mode = &cs5535_set_dma_mode;
+
+	hwif->drives[1].autotune = hwif->drives[0].autotune = 1;
+
+	if (hwif->dma_base == 0)
+		return;
+
 	hwif->ide_dma_check = &cs5535_dma_check;
 
 	hwif->atapi_dma = 1;
@@ -207,11 +211,7 @@ static void __devinit init_hwif_cs5535(i
 	if (!noautodma)
 		hwif->autodma = 1;
 
-	/* just setting autotune and not worrying about bios timings */
-	for (i = 0; i < 2; i++) {
-		hwif->drives[i].autotune = 1;
-		hwif->drives[i].autodma = hwif->autodma;
-	}
+	hwif->drives[1].autodma = hwif->drives[0].autodma = hwif->autodma;
 }
 
 static ide_pci_device_t cs5535_chipset __devinitdata = {
