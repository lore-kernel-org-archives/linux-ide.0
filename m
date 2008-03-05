From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/3] ide: remove ide_dma_iobase()
Date: Thu, 6 Mar 2008 00:01:24 +0100
Message-ID: <200803060001.24459.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.186]:21982 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758737AbYCEWwK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Mar 2008 17:52:10 -0500
Received: by gv-out-0910.google.com with SMTP id s4so1270253gve.37
        for <linux-ide@vger.kernel.org>; Wed, 05 Mar 2008 14:52:08 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

* ide_mapped_mmio_dma() and ide_iomio_dma() are called only by
  ide_dma_iobase() so inline them there.

* ide_dma_iobase() is called only by ide_setup_dma() so inline
  it there.

* Setup hwif->extra_base also if hwif->mmio flag is set.

There should be no functional changes casued by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma.c |   34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -838,37 +838,17 @@ static int ide_allocate_dma_engine(ide_h
 	return 1;
 }
 
-static int ide_mapped_mmio_dma(ide_hwif_t *hwif, unsigned long base)
-{
-	printk(KERN_INFO "    %s: MMIO-DMA ", hwif->name);
-
-	return 0;
-}
-
-static int ide_iomio_dma(ide_hwif_t *hwif, unsigned long base)
-{
-	printk(KERN_INFO "    %s: BM-DMA at 0x%04lx-0x%04lx",
-	       hwif->name, base, base + 7);
-
-	hwif->extra_base = base + (hwif->channel ? 8 : 16);
-
-	return 0;
-}
-
-static int ide_dma_iobase(ide_hwif_t *hwif, unsigned long base)
-{
-	if (hwif->mmio)
-		return ide_mapped_mmio_dma(hwif, base);
-
-	return ide_iomio_dma(hwif, base);
-}
-
 void ide_setup_dma(ide_hwif_t *hwif, unsigned long base)
 {
 	u8 dma_stat;
 
-	if (ide_dma_iobase(hwif, base))
-		return;
+	if (hwif->mmio)
+		printk(KERN_INFO "    %s: MMIO-DMA ", hwif->name);
+	else
+		printk(KERN_INFO "    %s: BM-DMA at 0x%04lx-0x%04lx",
+				 hwif->name, base, base + 7);
+
+	hwif->extra_base = base + (hwif->channel ? 8 : 16);
 
 	if (ide_allocate_dma_engine(hwif)) {
 		ide_release_dma_engine(hwif);
