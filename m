From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/9] ide: use ide_destroy_dmatable() instead of pci_unmap_sg()
Date: Thu, 27 Dec 2007 20:12:23 +0100
Message-ID: <20071227191223.1357.78845.sendpatchset@localhost.localdomain>
References: <20071227191153.1357.63211.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:6105 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754523AbXL0TB3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Dec 2007 14:01:29 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1692943ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 27 Dec 2007 11:01:29 -0800 (PST)
In-Reply-To: <20071227191153.1357.63211.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Use ide_destroy_dmatable() in:
* ide-dma.c::ide_build_dmatable()
* sgiioc4.c::sgiioc4_build_dma_table()
* pmac.c::pmac_ide_{build,destroy}_dmatable()

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma.c     |    8 ++++----
 drivers/ide/pci/sgiioc4.c |    3 +--
 drivers/ide/ppc/pmac.c    |   14 +++++---------
 3 files changed, 10 insertions(+), 15 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -282,12 +282,12 @@ int ide_build_dmatable (ide_drive_t *dri
 			*--table |= cpu_to_le32(0x80000000);
 		return count;
 	}
+
 	printk(KERN_ERR "%s: empty DMA table?\n", drive->name);
+
 use_pio_instead:
-	pci_unmap_sg(hwif->pci_dev,
-		     hwif->sg_table,
-		     hwif->sg_nents,
-		     hwif->sg_dma_direction);
+	ide_destroy_dmatable(drive);
+
 	return 0; /* revert to PIO for this request */
 }
 
Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -517,8 +517,7 @@ sgiioc4_build_dma_table(ide_drive_t * dr
 	}
 
 use_pio_instead:
-	pci_unmap_sg(hwif->pci_dev, hwif->sg_table, hwif->sg_nents,
-		     hwif->sg_dma_direction);
+	ide_destroy_dmatable(drive);
 
 	return 0;		/* revert to PIO for this request */
 }
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1535,11 +1535,10 @@ pmac_ide_build_dmatable(ide_drive_t *dri
 	}
 
 	printk(KERN_DEBUG "%s: empty DMA table?\n", drive->name);
- use_pio_instead:
-	pci_unmap_sg(hwif->pci_dev,
-		     hwif->sg_table,
-		     hwif->sg_nents,
-		     hwif->sg_dma_direction);
+
+use_pio_instead:
+	ide_destroy_dmatable(drive);
+
 	return 0; /* revert to PIO for this request */
 }
 
@@ -1548,12 +1547,9 @@ static void
 pmac_ide_destroy_dmatable (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
-	struct pci_dev *dev = HWIF(drive)->pci_dev;
-	struct scatterlist *sg = hwif->sg_table;
-	int nents = hwif->sg_nents;
 
 	if (nents) {
-		pci_unmap_sg(dev, sg, nents, hwif->sg_dma_direction);
+		ide_destroy_dmatable(drive);
 		hwif->sg_nents = 0;
 	}
 }
