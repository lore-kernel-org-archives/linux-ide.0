From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 11/15] ide: PCI BMDMA initialization fixes
Date: Mon, 1 Oct 2007 23:38:31 +0200
Message-ID: <200710012338.31404.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:61343 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757217AbXJAVjs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Oct 2007 17:39:48 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1977009ugc
        for <linux-ide@vger.kernel.org>; Mon, 01 Oct 2007 14:39:47 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Set hwif->dma_base only if allocation of extra ports succeeds.

* Allocate hwif->dmatable_cpu before reserving I/O ports.

While at it:

* Move setting of hwif->dma_{base,master} from ide_{mapped_mmio,iomio}_dma()
  to ide_setup_dma().

* Rename 'dma_base' argument to 'base' in ide_setup_dma().

* Remove stale ide_setup_dma() comment.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma.c |   30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -956,12 +956,6 @@ static int ide_mapped_mmio_dma(ide_hwif_
 {
 	printk(KERN_INFO "    %s: MMIO-DMA ", hwif->name);
 
- 	hwif->dma_base = base;
-
-	if(hwif->mate)
-		hwif->dma_master = (hwif->channel) ? hwif->mate->dma_base : base;
-	else
-		hwif->dma_master = base;
 	return 0;
 }
 
@@ -975,8 +969,6 @@ static int ide_iomio_dma(ide_hwif_t *hwi
 		return 1;
 	}
 
-	hwif->dma_base = base;
-
 	if (hwif->cds->extra) {
 		hwif->extra_base = base + (hwif->channel ? 8 : 16);
 
@@ -991,10 +983,6 @@ static int ide_iomio_dma(ide_hwif_t *hwi
 		}
 	}
 
-	if(hwif->mate)
-		hwif->dma_master = (hwif->channel) ? hwif->mate->dma_base:base;
-	else
-		hwif->dma_master = base;
 	return 0;
 }
 
@@ -1006,18 +994,20 @@ static int ide_dma_iobase(ide_hwif_t *hw
 	return ide_iomio_dma(hwif, base, ports);
 }
 
-/*
- * This can be called for a dynamically installed interface. Don't __init it
- */
-void ide_setup_dma (ide_hwif_t *hwif, unsigned long dma_base, unsigned int num_ports)
+void ide_setup_dma(ide_hwif_t *hwif, unsigned long base, unsigned num_ports)
 {
-	if (ide_dma_iobase(hwif, dma_base, num_ports))
+	if (ide_allocate_dma_engine(hwif))
 		return;
 
-	if (ide_allocate_dma_engine(hwif)) {
-		ide_release_dma(hwif);
+	if (ide_dma_iobase(hwif, base, num_ports))
 		return;
-	}
+
+	hwif->dma_base = base;
+
+	if (hwif->mate)
+		hwif->dma_master = hwif->channel ? hwif->mate->dma_base : base;
+	else
+		hwif->dma_master = base;
 
 	if (!(hwif->dma_command))
 		hwif->dma_command	= hwif->dma_base;
