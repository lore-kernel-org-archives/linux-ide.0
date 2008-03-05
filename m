From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/3] ide: remove ->extra field from struct ide_port_info
Date: Thu, 6 Mar 2008 00:00:50 +0100
Message-ID: <200803060000.50990.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:55709 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758021AbYCEWwI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Mar 2008 17:52:08 -0500
Received: by ug-out-1314.google.com with SMTP id z38so3517432ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 05 Mar 2008 14:52:06 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Always setup hwif->extra_base in ide_iomio_dma() and remove
no longer needed ->extra field from struct ide_port_info.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma.c          |    3 +--
 drivers/ide/pci/hpt34x.c       |    2 --
 drivers/ide/pci/hpt366.c       |    6 ------
 drivers/ide/pci/pdc202xx_old.c |    2 --
 include/linux/ide.h            |    1 -
 5 files changed, 1 insertion(+), 13 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -850,8 +850,7 @@ static int ide_iomio_dma(ide_hwif_t *hwi
 	printk(KERN_INFO "    %s: BM-DMA at 0x%04lx-0x%04lx",
 	       hwif->name, base, base + 7);
 
-	if (hwif->cds->extra)
-		hwif->extra_base = base + (hwif->channel ? 8 : 16);
+	hwif->extra_base = base + (hwif->channel ? 8 : 16);
 
 	return 0;
 }
Index: b/drivers/ide/pci/hpt34x.c
===================================================================
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -130,7 +130,6 @@ static const struct ide_port_info hpt34x
 	{ /* 0 */
 		.name		= "HPT343",
 		.init_chipset	= init_chipset_hpt34x,
-		.extra		= 16,
 		.port_ops	= &hpt34x_port_ops,
 		.host_flags	= IDE_HFLAGS_HPT34X | IDE_HFLAG_NON_BOOTABLE,
 		.pio_mask	= ATA_PIO5,
@@ -138,7 +137,6 @@ static const struct ide_port_info hpt34x
 	{ /* 1 */
 		.name		= "HPT345",
 		.init_chipset	= init_chipset_hpt34x,
-		.extra		= 16,
 		.port_ops	= &hpt34x_port_ops,
 		.host_flags	= IDE_HFLAGS_HPT34X | IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO5,
Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -1428,7 +1428,6 @@ static const struct ide_port_info hpt366
 		 * Bit 4 is for the primary channel, bit 5 for the secondary.
 		 */
 		.enablebits	= {{0x50,0x10,0x10}, {0x54,0x04,0x04}},
-		.extra		= 240,
 		.port_ops	= &hpt3xx_port_ops,
 		.host_flags	= IDE_HFLAGS_HPT3XX | IDE_HFLAG_SINGLE,
 		.pio_mask	= ATA_PIO4,
@@ -1439,7 +1438,6 @@ static const struct ide_port_info hpt366
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
-		.extra		= 240,
 		.port_ops	= &hpt3xx_port_ops,
 		.host_flags	= IDE_HFLAGS_HPT3XX,
 		.pio_mask	= ATA_PIO4,
@@ -1450,7 +1448,6 @@ static const struct ide_port_info hpt366
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
-		.extra		= 240,
 		.port_ops	= &hpt3xx_port_ops,
 		.host_flags	= IDE_HFLAGS_HPT3XX,
 		.pio_mask	= ATA_PIO4,
@@ -1461,7 +1458,6 @@ static const struct ide_port_info hpt366
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
-		.extra		= 240,
 		.port_ops	= &hpt3xx_port_ops,
 		.host_flags	= IDE_HFLAGS_HPT3XX,
 		.pio_mask	= ATA_PIO4,
@@ -1473,7 +1469,6 @@ static const struct ide_port_info hpt366
 		.init_dma	= init_dma_hpt366,
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.udma_mask	= ATA_UDMA5,
-		.extra		= 240,
 		.port_ops	= &hpt3xx_port_ops,
 		.host_flags	= IDE_HFLAGS_HPT3XX,
 		.pio_mask	= ATA_PIO4,
@@ -1484,7 +1479,6 @@ static const struct ide_port_info hpt366
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
-		.extra		= 240,
 		.port_ops	= &hpt3xx_port_ops,
 		.host_flags	= IDE_HFLAGS_HPT3XX,
 		.pio_mask	= ATA_PIO4,
Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -358,7 +358,6 @@ static const struct ide_port_ops pdc2026
 		.init_chipset	= init_chipset_pdc202xx, \
 		.init_hwif	= init_hwif_pdc202xx, \
 		.init_dma	= init_dma_pdc202xx, \
-		.extra		= 48, \
 		.port_ops	= &pdc2026x_port_ops, \
 		.host_flags	= IDE_HFLAGS_PDC202XX | extra_flags, \
 		.pio_mask	= ATA_PIO4, \
@@ -373,7 +372,6 @@ static const struct ide_port_info pdc202
 		.init_hwif	= init_hwif_pdc202xx,
 		.init_dma	= init_dma_pdc202xx,
 		.port_ops	= &pdc20246_port_ops,
-		.extra		= 16,
 		.host_flags	= IDE_HFLAGS_PDC202XX,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1113,7 +1113,6 @@ struct ide_port_info {
 
 	ide_pci_enablebit_t	enablebits[2];
 	hwif_chipset_t		chipset;
-	u8			extra;
 	u32			host_flags;
 	u8			pio_mask;
 	u8			swdma_mask;
