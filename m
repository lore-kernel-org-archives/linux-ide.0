From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/9] au1xxx-ide: use hwif->dev
Date: Thu, 27 Dec 2007 20:12:38 +0100
Message-ID: <20071227191238.1357.62168.sendpatchset@localhost.localdomain>
References: <20071227191153.1357.63211.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:6105 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754604AbXL0TBo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Dec 2007 14:01:44 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1692943ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 27 Dec 2007 11:01:44 -0800 (PST)
In-Reply-To: <20071227191153.1357.63211.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

* Setup hwif->dev in au_ide_probe().

* Use hwif->dev instead of ahwif->dev in auide_build_sglist(),
  auide_build_dmatable(), auide_dma_end() and auide_ddma_init().

* Remove no longer needed 'dev' field from _auide_hwif type.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/mips/au1xxx-ide.c             |   15 ++++++---------
 include/asm-mips/mach-au1x00/au1xxx_ide.h |    1 -
 2 files changed, 6 insertions(+), 10 deletions(-)

Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -213,7 +213,6 @@ static void auide_set_dma_mode(ide_drive
 static int auide_build_sglist(ide_drive_t *drive,  struct request *rq)
 {
 	ide_hwif_t *hwif = drive->hwif;
-	_auide_hwif *ahwif = (_auide_hwif*)hwif->hwif_data;
 	struct scatterlist *sg = hwif->sg_table;
 
 	ide_map_sg(drive, rq);
@@ -223,7 +222,7 @@ static int auide_build_sglist(ide_drive_
 	else
 		hwif->sg_dma_direction = DMA_TO_DEVICE;
 
-	return dma_map_sg(ahwif->dev, sg, hwif->sg_nents,
+	return dma_map_sg(hwif->dev, sg, hwif->sg_nents,
 			  hwif->sg_dma_direction);
 }
 
@@ -300,7 +299,7 @@ static int auide_build_dmatable(ide_driv
 		return 1;
 
  use_pio_instead:
-	dma_unmap_sg(ahwif->dev,
+	dma_unmap_sg(hwif->dev,
 		     hwif->sg_table,
 		     hwif->sg_nents,
 		     hwif->sg_dma_direction);
@@ -311,10 +310,9 @@ static int auide_build_dmatable(ide_driv
 static int auide_dma_end(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
-	_auide_hwif *ahwif = (_auide_hwif*)hwif->hwif_data;
 
 	if (hwif->sg_nents) {
-		dma_unmap_sg(ahwif->dev, hwif->sg_table, hwif->sg_nents,
+		dma_unmap_sg(hwif->dev, hwif->sg_table, hwif->sg_nents,
 			     hwif->sg_dma_direction);
 		hwif->sg_nents = 0;
 	}
@@ -504,7 +502,7 @@ static int auide_ddma_init(_auide_hwif *
 	auide->rx_desc_head = (void*)au1xxx_dbdma_ring_alloc(auide->rx_chan,
 							     NUM_DESCRIPTORS);
  
-	hwif->dmatable_cpu = dma_alloc_coherent(auide->dev,
+	hwif->dmatable_cpu = dma_alloc_coherent(hwif->dev,
 						PRD_ENTRIES * PRD_BYTES,        /* 1 Page */
 						&hwif->dmatable_dma, GFP_KERNEL);
 	
@@ -592,9 +590,6 @@ static int au_ide_probe(struct device *d
 #endif
 
 	memset(&auide_hwif, 0, sizeof(_auide_hwif));
-	auide_hwif.dev                  = 0;
-
-	ahwif->dev = dev;
 	ahwif->irq = platform_get_irq(pdev, 0);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -633,6 +628,8 @@ static int au_ide_probe(struct device *d
 
 	ide_init_port_hw(hwif, &hw);
 
+	hwif->dev = dev;
+
 	hwif->ultra_mask                = 0x0;  /* Disable Ultra DMA */
 #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
 	hwif->mwdma_mask                = 0x07; /* Multimode-2 DMA  */
Index: b/include/asm-mips/mach-au1x00/au1xxx_ide.h
===================================================================
--- a/include/asm-mips/mach-au1x00/au1xxx_ide.h
+++ b/include/asm-mips/mach-au1x00/au1xxx_ide.h
@@ -74,7 +74,6 @@ typedef struct
         struct dbdma_cmd        *dma_table_cpu;
         dma_addr_t              dma_table_dma;
 #endif
-        struct device           *dev;
 	int			irq;
 	u32			regbase;
 #ifdef CONFIG_PM
