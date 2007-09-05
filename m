From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/13] pdc202xx_old: add DECLARE_PDC2026X_DEV() macro
Date: Wed, 5 Sep 2007 23:51:45 +0200
Message-ID: <200709052351.45943.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:65431 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755578AbXIEV6r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Sep 2007 17:58:47 -0400
Received: by nf-out-0910.google.com with SMTP id f5so1828117nfh
        for <linux-ide@vger.kernel.org>; Wed, 05 Sep 2007 14:58:46 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/pdc202xx_old.c |   60 ++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 41 deletions(-)

Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -386,6 +386,19 @@ static void __devinit pdc202ata4_fixup_i
 	}
 }
 
+#define DECLARE_PDC2026X_DEV(name_str, udma) \
+	{ \
+		.name		= name_str, \
+		.init_chipset	= init_chipset_pdc202xx, \
+		.init_hwif	= init_hwif_pdc202xx, \
+		.init_dma	= init_dma_pdc202xx, \
+		.extra		= 48, \
+		.host_flags	= IDE_HFLAG_OFF_BOARD, \
+		.pio_mask	= ATA_PIO4, \
+		.mwdma_mask	= ATA_MWDMA2, \
+		.udma_mask	= udma, \
+	}
+
 static ide_pci_device_t pdc202xx_chipsets[] __devinitdata = {
 	{	/* 0 */
 		.name		= "PDC20246",
@@ -397,47 +410,12 @@ static ide_pci_device_t pdc202xx_chipset
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 		.udma_mask	= ATA_UDMA2,
-	},{	/* 1 */
-		.name		= "PDC20262",
-		.init_chipset	= init_chipset_pdc202xx,
-		.init_hwif	= init_hwif_pdc202xx,
-		.init_dma	= init_dma_pdc202xx,
-		.extra		= 48,
-		.host_flags	= IDE_HFLAG_OFF_BOARD,
-		.pio_mask	= ATA_PIO4,
-		.mwdma_mask	= ATA_MWDMA2,
-		.udma_mask	= ATA_UDMA4,
-	},{	/* 2 */
-		.name		= "PDC20263",
-		.init_chipset	= init_chipset_pdc202xx,
-		.init_hwif	= init_hwif_pdc202xx,
-		.init_dma	= init_dma_pdc202xx,
-		.extra		= 48,
-		.host_flags	= IDE_HFLAG_OFF_BOARD,
-		.pio_mask	= ATA_PIO4,
-		.mwdma_mask	= ATA_MWDMA2,
-		.udma_mask	= ATA_UDMA4,
-	},{	/* 3 */
-		.name		= "PDC20265",
-		.init_chipset	= init_chipset_pdc202xx,
-		.init_hwif	= init_hwif_pdc202xx,
-		.init_dma	= init_dma_pdc202xx,
-		.extra		= 48,
-		.host_flags	= IDE_HFLAG_OFF_BOARD,
-		.pio_mask	= ATA_PIO4,
-		.mwdma_mask	= ATA_MWDMA2,
-		.udma_mask	= ATA_UDMA5,
-	},{	/* 4 */
-		.name		= "PDC20267",
-		.init_chipset	= init_chipset_pdc202xx,
-		.init_hwif	= init_hwif_pdc202xx,
-		.init_dma	= init_dma_pdc202xx,
-		.extra		= 48,
-		.host_flags	= IDE_HFLAG_OFF_BOARD,
-		.pio_mask	= ATA_PIO4,
-		.mwdma_mask	= ATA_MWDMA2,
-		.udma_mask	= ATA_UDMA5,
-	}
+	},
+
+	/* 1 */ DECLARE_PDC2026X_DEV("PDC20262", ATA_UDMA4),
+	/* 2 */ DECLARE_PDC2026X_DEV("PDC20263", ATA_UDMA4),
+	/* 3 */ DECLARE_PDC2026X_DEV("PDC20265", ATA_UDMA5),
+	/* 4 */ DECLARE_PDC2026X_DEV("PDC20267", ATA_UDMA5),
 };
 
 /**
