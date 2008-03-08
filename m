From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/7] ide: don't display "BIOS" settings in ide_setup_dma()
Date: Sat, 8 Mar 2008 22:29:34 +0100
Message-ID: <200803082229.34542.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:49578 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbYCHVVb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Mar 2008 16:21:31 -0500
Received: by fk-out-0910.google.com with SMTP id z23so929294fkz.5
        for <linux-ide@vger.kernel.org>; Sat, 08 Mar 2008 13:21:29 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Nowadays BIOS info is not very useful and only confuses users since:

- IDE always tries to use DMA

- BIOS info may not be accurate with modular IDE/libata

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -840,12 +840,10 @@ static int ide_allocate_dma_engine(ide_h
 
 void ide_setup_dma(ide_hwif_t *hwif, unsigned long base)
 {
-	u8 dma_stat;
-
 	if (hwif->mmio)
-		printk(KERN_INFO "    %s: MMIO-DMA ", hwif->name);
+		printk(KERN_INFO "    %s: MMIO-DMA\n", hwif->name);
 	else
-		printk(KERN_INFO "    %s: BM-DMA at 0x%04lx-0x%04lx",
+		printk(KERN_INFO "    %s: BM-DMA at 0x%04lx-0x%04lx\n",
 				 hwif->name, base, base + 7);
 
 	hwif->extra_base = base + (hwif->channel ? 8 : 16);
@@ -884,11 +882,6 @@ void ide_setup_dma(ide_hwif_t *hwif, uns
 		hwif->dma_timeout = &ide_dma_timeout;
 	if (!hwif->dma_lost_irq)
 		hwif->dma_lost_irq = &ide_dma_lost_irq;
-
-	dma_stat = hwif->INB(hwif->dma_status);
-	printk(KERN_CONT ", BIOS settings: %s:%s, %s:%s\n",
-	       hwif->drives[0].name, (dma_stat & 0x20) ? "DMA" : "PIO",
-	       hwif->drives[1].name, (dma_stat & 0x40) ? "DMA" : "PIO");
 }
 
 EXPORT_SYMBOL_GPL(ide_setup_dma);
