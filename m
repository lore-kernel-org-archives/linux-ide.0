From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/13] pdc202xx_new: add DECLARE_PDCNEW_DEV() macro
Date: Wed, 5 Sep 2007 23:51:16 +0200
Message-ID: <200709052351.16847.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:65452 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755593AbXIEV6q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Sep 2007 17:58:46 -0400
Received: by nf-out-0910.google.com with SMTP id f5so1828126nfh
        for <linux-ide@vger.kernel.org>; Wed, 05 Sep 2007 14:58:45 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/pdc202xx_new.c |   76 ++++++++++-------------------------------
 1 file changed, 19 insertions(+), 57 deletions(-)

Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -504,64 +504,26 @@ static struct pci_dev * __devinit pdc202
 	return NULL;
 }
 
-static ide_pci_device_t pdcnew_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "PDC20268",
-		.init_chipset	= init_chipset_pdcnew,
-		.init_hwif	= init_hwif_pdc202new,
-		.host_flags	= IDE_HFLAG_POST_SET_MODE | IDE_HFLAG_OFF_BOARD,
-		.pio_mask	= ATA_PIO4,
-		.mwdma_mask	= ATA_MWDMA2,
-		.udma_mask	= ATA_UDMA5,
-	},{	/* 1 */
-		.name		= "PDC20269",
-		.init_chipset	= init_chipset_pdcnew,
-		.init_hwif	= init_hwif_pdc202new,
-		.host_flags	= IDE_HFLAG_POST_SET_MODE | IDE_HFLAG_OFF_BOARD,
-		.pio_mask	= ATA_PIO4,
-		.mwdma_mask	= ATA_MWDMA2,
-		.udma_mask	= ATA_UDMA6,
-	},{	/* 2 */
-		.name		= "PDC20270",
-		.init_chipset	= init_chipset_pdcnew,
-		.init_hwif	= init_hwif_pdc202new,
-		.host_flags	= IDE_HFLAG_POST_SET_MODE | IDE_HFLAG_OFF_BOARD,
-		.pio_mask	= ATA_PIO4,
-		.mwdma_mask	= ATA_MWDMA2,
-		.udma_mask	= ATA_UDMA5,
-	},{	/* 3 */
-		.name		= "PDC20271",
-		.init_chipset	= init_chipset_pdcnew,
-		.init_hwif	= init_hwif_pdc202new,
-		.host_flags	= IDE_HFLAG_POST_SET_MODE | IDE_HFLAG_OFF_BOARD,
-		.pio_mask	= ATA_PIO4,
-		.mwdma_mask	= ATA_MWDMA2,
-		.udma_mask	= ATA_UDMA6,
-	},{	/* 4 */
-		.name		= "PDC20275",
-		.init_chipset	= init_chipset_pdcnew,
-		.init_hwif	= init_hwif_pdc202new,
-		.host_flags	= IDE_HFLAG_POST_SET_MODE | IDE_HFLAG_OFF_BOARD,
-		.pio_mask	= ATA_PIO4,
-		.mwdma_mask	= ATA_MWDMA2,
-		.udma_mask	= ATA_UDMA6,
-	},{	/* 5 */
-		.name		= "PDC20276",
-		.init_chipset	= init_chipset_pdcnew,
-		.init_hwif	= init_hwif_pdc202new,
-		.host_flags	= IDE_HFLAG_POST_SET_MODE | IDE_HFLAG_OFF_BOARD,
-		.pio_mask	= ATA_PIO4,
-		.mwdma_mask	= ATA_MWDMA2,
-		.udma_mask	= ATA_UDMA6,
-	},{	/* 6 */
-		.name		= "PDC20277",
-		.init_chipset	= init_chipset_pdcnew,
-		.init_hwif	= init_hwif_pdc202new,
-		.host_flags	= IDE_HFLAG_POST_SET_MODE | IDE_HFLAG_OFF_BOARD,
-		.pio_mask	= ATA_PIO4,
-		.mwdma_mask	= ATA_MWDMA2,
-		.udma_mask	= ATA_UDMA6,
+#define DECLARE_PDCNEW_DEV(name_str, udma) \
+	{ \
+		.name		= name_str, \
+		.init_chipset	= init_chipset_pdcnew, \
+		.init_hwif	= init_hwif_pdc202new, \
+		.host_flags	= IDE_HFLAG_POST_SET_MODE | \
+				  IDE_HFLAG_OFF_BOARD, \
+		.pio_mask	= ATA_PIO4, \
+		.mwdma_mask	= ATA_MWDMA2, \
+		.udma_mask	= udma, \
 	}
+
+static ide_pci_device_t pdcnew_chipsets[] __devinitdata = {
+	/* 0 */ DECLARE_PDCNEW_DEV("PDC20268", ATA_UDMA5),
+	/* 1 */ DECLARE_PDCNEW_DEV("PDC20269", ATA_UDMA6),
+	/* 2 */ DECLARE_PDCNEW_DEV("PDC20270", ATA_UDMA5),
+	/* 3 */ DECLARE_PDCNEW_DEV("PDC20271", ATA_UDMA6),
+	/* 4 */ DECLARE_PDCNEW_DEV("PDC20275", ATA_UDMA6),
+	/* 5 */ DECLARE_PDCNEW_DEV("PDC20276", ATA_UDMA6),
+	/* 6 */ DECLARE_PDCNEW_DEV("PDC20277", ATA_UDMA6),
 };
 
 /**
