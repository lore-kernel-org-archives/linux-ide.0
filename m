From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/7] ide: cleanup ide_setup_dma()
Date: Sat, 8 Mar 2008 22:34:01 +0100
Message-ID: <200803082234.01367.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.178]:44263 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154AbYCHVVl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Mar 2008 16:21:41 -0500
Received: by ik-out-1112.google.com with SMTP id c28so1411154ika.5
        for <linux-ide@vger.kernel.org>; Sat, 08 Mar 2008 13:21:39 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

* There is no need to call ide_release_dma_engine().

* Move the code up to (and including) ide_allocate_dma_engine()
  call to the callers of ide_setup_dma().

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/palm_bk3710.c |    5 ++++-
 drivers/ide/ide-dma.c         |   13 -------------
 drivers/ide/setup-pci.c       |   17 +++++++++++++----
 3 files changed, 17 insertions(+), 18 deletions(-)

Index: b/drivers/ide/arm/palm_bk3710.c
===================================================================
--- a/drivers/ide/arm/palm_bk3710.c
+++ b/drivers/ide/arm/palm_bk3710.c
@@ -392,7 +392,10 @@ static int __devinit palm_bk3710_probe(s
 	hwif->mmio = 1;
 	default_hwif_mmiops(hwif);
 
-	ide_setup_dma(hwif, mem->start);
+	printk(KERN_INFO "    %s: MMIO-DMA\n", hwif->name);
+
+	if (ide_allocate_dma_engine(hwif) == 0)
+		ide_setup_dma(hwif, mem->start);
 
 	idx[0] = i;
 
Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -841,19 +841,6 @@ EXPORT_SYMBOL_GPL(ide_allocate_dma_engin
 
 void ide_setup_dma(ide_hwif_t *hwif, unsigned long base)
 {
-	if (hwif->mmio)
-		printk(KERN_INFO "    %s: MMIO-DMA\n", hwif->name);
-	else
-		printk(KERN_INFO "    %s: BM-DMA at 0x%04lx-0x%04lx\n",
-				 hwif->name, base, base + 7);
-
-	hwif->extra_base = base + (hwif->channel ? 8 : 16);
-
-	if (ide_allocate_dma_engine(hwif)) {
-		ide_release_dma_engine(hwif);
-		return;
-	}
-
 	hwif->dma_base = base;
 
 	if (!hwif->dma_command)
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -366,15 +366,24 @@ void ide_hwif_setup_dma(ide_hwif_t *hwif
 	if ((d->host_flags & IDE_HFLAG_NO_AUTODMA) == 0 ||
 	    ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE &&
 	     (dev->class & 0x80))) {
-		unsigned long dma_base = ide_get_or_set_dma_base(d, hwif);
+		unsigned long base = ide_get_or_set_dma_base(d, hwif);
 
-		if (dma_base == 0 || ide_pci_set_master(dev, d->name) < 0)
+		if (base == 0 || ide_pci_set_master(dev, d->name) < 0)
 			goto out_disabled;
 
 		if (d->init_dma)
-			d->init_dma(hwif, dma_base);
+			d->init_dma(hwif, base);
 
-		ide_setup_dma(hwif, dma_base);
+		if (hwif->mmio)
+			printk(KERN_INFO "    %s: MMIO-DMA\n", hwif->name);
+		else
+			printk(KERN_INFO "    %s: BM-DMA at 0x%04lx-0x%04lx\n",
+					 hwif->name, base, base + 7);
+
+		hwif->extra_base = base + (hwif->channel ? 8 : 16);
+
+		if (ide_allocate_dma_engine(hwif) == 0)
+			ide_setup_dma(hwif, base);
 	}
 
 	return;
