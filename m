From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] ide-dma.c: remove unused/obsoleted code for hwif->mmio == 1
Date: Tue, 16 Mar 2004 23:21:06 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200403162321.06998.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:56518 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261760AbUCPWOW
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Mar 2004 17:14:22 -0500
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


[IDE] ide-dma.c: remove unused/obsoleted code for hwif->mmio == 1

All users of hwif->mmio correctly handle resources themselves
(hwif->mmio == 2) so remove ide_mmio_dma() and ide_release_mmio_dma().

 linux-2.6.5-rc1-root/drivers/ide/ide-dma.c |   47 -----------------------------
 1 files changed, 1 insertion(+), 46 deletions(-)

diff -puN drivers/ide/ide-dma.c~ide_mmio_dma drivers/ide/ide-dma.c
--- linux-2.6.5-rc1/drivers/ide/ide-dma.c~ide_mmio_dma	2004-03-16 23:10:14.722153232 +0100
+++ linux-2.6.5-rc1-root/drivers/ide/ide-dma.c	2004-03-16 23:10:14.726152624 +0100
@@ -883,16 +883,6 @@ int ide_release_dma_engine (ide_hwif_t *
 	return 1;
 }
 
-int ide_release_mmio_dma (ide_hwif_t *hwif)
-{
-	if ((hwif->dma_extra) && (hwif->channel == 0))
-		release_mem_region((hwif->dma_base + 16), hwif->dma_extra);
-	release_mem_region(hwif->dma_base, 8);
-	if (hwif->dma_base2)
-		release_mem_region(hwif->dma_base, 8);
-	return 1;
-}
-
 int ide_release_iomio_dma (ide_hwif_t *hwif)
 {
 	if ((hwif->dma_extra) && (hwif->channel == 0))
@@ -914,8 +904,6 @@ int ide_release_dma (ide_hwif_t *hwif)
 		return 1;
 
 	ide_release_dma_engine(hwif);
-	if (hwif->mmio == 1)
-		return ide_release_mmio_dma(hwif);
 	return ide_release_iomio_dma(hwif);
 }
 
@@ -939,38 +927,6 @@ int ide_allocate_dma_engine (ide_hwif_t 
 	return 1;
 }
 
-int ide_mmio_dma (ide_hwif_t *hwif, unsigned long base, unsigned int ports)
-{
-	printk(KERN_INFO "    %s: MMIO-DMA at 0x%08lx-0x%08lx",
-		hwif->name, base, base + ports - 1);
-	if (!request_mem_region(base, ports, hwif->name))
-		goto fail;
-	hwif->dma_base = base;
-	if ((hwif->cds->extra) && (hwif->channel == 0)) {
-		if (!request_region(base+16, hwif->cds->extra, hwif->cds->name))
-			goto release_mem;
-		hwif->dma_extra = hwif->cds->extra;
-	}
-	
-	if(hwif->mate)
-		hwif->dma_master = (hwif->channel) ? hwif->mate->dma_base : base;
-	else
-		hwif->dma_master = base;
-	if (hwif->dma_base2) {
-		if (!request_mem_region(hwif->dma_base2, ports, hwif->name))
-			goto release_io;
-	}
-	return 0;
-
-release_mem:
-	release_mem_region(base, ports);
-release_io:
-	release_region(base+16, hwif->cds->extra);
-fail:
-	printk(" -- Error, MMIO ports already in use.\n");
-	return 1;
-}
-
 int ide_mapped_mmio_dma (ide_hwif_t *hwif, unsigned long base, unsigned int ports)
 {
 	printk(KERN_INFO "    %s: MMIO-DMA ", hwif->name);
@@ -1022,8 +978,7 @@ int ide_dma_iobase (ide_hwif_t *hwif, un
 {
 	if (hwif->mmio == 2)
 		return ide_mapped_mmio_dma(hwif, base,ports);
-	if (hwif->mmio == 1)
-		return ide_mmio_dma(hwif, base, ports);
+	BUG_ON(hwif->mmio == 1);
 	return ide_iomio_dma(hwif, base, ports);
 }
 

_

