From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/7] ide: export ide_allocate_dma_engine()
Date: Sat, 8 Mar 2008 22:32:35 +0100
Message-ID: <200803082232.35296.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.185]:48365 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbYCHVVi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Mar 2008 16:21:38 -0500
Received: by gv-out-0910.google.com with SMTP id s4so441262gve.37
        for <linux-ide@vger.kernel.org>; Sat, 08 Mar 2008 13:21:37 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Export ide_allocate_dma_engine() and use it in trm290 host driver.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma.c    |    3 ++-
 drivers/ide/pci/trm290.c |    9 ++-------
 include/linux/ide.h      |    3 ++-
 3 files changed, 6 insertions(+), 9 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -821,7 +821,7 @@ void ide_release_dma_engine(ide_hwif_t *
 	}
 }
 
-static int ide_allocate_dma_engine(ide_hwif_t *hwif)
+int ide_allocate_dma_engine(ide_hwif_t *hwif)
 {
 	struct pci_dev *pdev = to_pci_dev(hwif->dev);
 
@@ -837,6 +837,7 @@ static int ide_allocate_dma_engine(ide_h
 
 	return 1;
 }
+EXPORT_SYMBOL_GPL(ide_allocate_dma_engine);
 
 void ide_setup_dma(ide_hwif_t *hwif, unsigned long base)
 {
Index: b/drivers/ide/pci/trm290.c
===================================================================
--- a/drivers/ide/pci/trm290.c
+++ b/drivers/ide/pci/trm290.c
@@ -254,16 +254,11 @@ static void __devinit init_hwif_trm290(i
 	hwif->config_data = cfg_base;
 	hwif->dma_base = (cfg_base + 4) ^ (hwif->channel ? 0x80 : 0);
 
-	printk(KERN_INFO "    %s: BM-DMA at 0x%04lx-0x%04lx",
+	printk(KERN_INFO "    %s: BM-DMA at 0x%04lx-0x%04lx\n",
 	       hwif->name, hwif->dma_base, hwif->dma_base + 3);
 
-	hwif->dmatable_cpu = pci_alloc_consistent(dev, PRD_ENTRIES * PRD_BYTES,
-						  &hwif->dmatable_dma);
-	if (!hwif->dmatable_cpu) {
-		printk(KERN_CONT " -- Error, unable to allocate DMA table.\n");
+	if (ide_allocate_dma_engine(hwif))
 		return;
-	}
-	printk(KERN_CONT "\n");
 
 	local_irq_save(flags);
 	/* put config reg into first byte of hwif->select_data */
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1157,7 +1157,8 @@ void ide_destroy_dmatable(ide_drive_t *)
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_SFF
 extern int ide_build_dmatable(ide_drive_t *, struct request *);
-extern void ide_release_dma_engine(ide_hwif_t *);
+int ide_allocate_dma_engine(ide_hwif_t *);
+void ide_release_dma_engine(ide_hwif_t *);
 extern void ide_setup_dma(ide_hwif_t *, unsigned long);
 
 void ide_dma_host_set(ide_drive_t *, int);
