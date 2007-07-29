From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 11/12] alim15x3: remove redundant m5229_revision check
Date: Sun, 29 Jul 2007 19:56:36 +0200
Message-ID: <200707291956.36710.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:59697 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765148AbXG2SFY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jul 2007 14:05:24 -0400
Received: by ug-out-1314.google.com with SMTP id j3so945455ugf
        for <linux-ide@vger.kernel.org>; Sun, 29 Jul 2007 11:05:23 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


init_dma_ali15x3() guarantees that hwif->dma_base will never be set for
m5229_revision < 0x20 so remove redundant m5229_revision >= 0x20 check from
init_hwif_common_ali15x3().

While at it remove incorrect comment.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/alim15x3.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -687,6 +687,10 @@ static void __devinit init_hwif_common_a
 		return;
 	}
 
+	/*
+	 * check in ->init_dma guarantees m5229_revision >= 0x20 here
+	 */
+
 	if (m5229_revision > 0x20)
 		hwif->atapi_dma = 1;
 
@@ -704,18 +708,15 @@ static void __devinit init_hwif_common_a
 	hwif->mwdma_mask = 0x07;
 	hwif->swdma_mask = 0x07;
 
-        if (m5229_revision >= 0x20) {
-                /*
-                 * M1543C or newer for DMAing
-                 */
-                hwif->ide_dma_check = &ali15x3_config_drive_for_dma;
-		hwif->dma_setup = &ali15x3_dma_setup;
-		if (!noautodma)
-			hwif->autodma = 1;
+	hwif->ide_dma_check = &ali15x3_config_drive_for_dma;
+	hwif->dma_setup = &ali15x3_dma_setup;
+
+	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
+		hwif->cbl = ata66_ali15x3(hwif);
+
+	if (!noautodma)
+		hwif->autodma = 1;
 
-		if (hwif->cbl != ATA_CBL_PATA40_SHORT)
-			hwif->cbl = ata66_ali15x3(hwif);
-	}
 	hwif->drives[0].autodma = hwif->autodma;
 	hwif->drives[1].autodma = hwif->autodma;
 }
