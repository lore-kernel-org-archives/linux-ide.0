From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/12] sgiioc4: add missing ->dma_base check
Date: Sun, 29 Jul 2007 19:53:02 +0200
Message-ID: <200707291953.02499.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:44520 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765122AbXG2SFV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jul 2007 14:05:21 -0400
Received: by nf-out-0910.google.com with SMTP id g13so123533nfb
        for <linux-ide@vger.kernel.org>; Sun, 29 Jul 2007 11:05:20 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


If ->dma_base is not set (== PCI BAR4 cannot be reserved) then DMA hooks
shouldn't be initialized or bad things will happen.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sgiioc4.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -587,8 +587,6 @@ static void __devinit
 ide_init_sgiioc4(ide_hwif_t * hwif)
 {
 	hwif->mmio = 1;
-	hwif->atapi_dma = 1;
-	hwif->mwdma_mask = 0x04;
 	hwif->pio_mask = 0x00;
 	hwif->set_pio_mode = NULL; /* Sets timing for PIO mode */
 	hwif->set_dma_mode = &sgiioc4_set_dma_mode;
@@ -602,6 +600,14 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
 	hwif->quirkproc = NULL;
 	hwif->busproc = NULL;
 
+	hwif->INB = &sgiioc4_INB;
+
+	if (hwif->dma_base == 0)
+		return;
+
+	hwif->atapi_dma = 1;
+	hwif->mwdma_mask = 0x04;
+
 	hwif->dma_setup = &sgiioc4_ide_dma_setup;
 	hwif->dma_start = &sgiioc4_ide_dma_start;
 	hwif->ide_dma_end = &sgiioc4_ide_dma_end;
@@ -613,8 +619,6 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
 	hwif->dma_host_off = &sgiioc4_dma_host_off;
 	hwif->dma_lost_irq = &sgiioc4_dma_lost_irq;
 	hwif->dma_timeout = &ide_dma_timeout;
-
-	hwif->INB = &sgiioc4_INB;
 }
 
 static int __devinit
@@ -684,8 +688,6 @@ sgiioc4_ide_setup_pci_device(struct pci_
 	/* Initializing chipset IRQ Registers */
 	writel(0x03, (void __iomem *)(irqport + IOC4_INTR_SET * 4));
 
-	ide_init_sgiioc4(hwif);
-
 	hwif->autodma = 0;
 
 	if (dma_base && ide_dma_sgiioc4(hwif, dma_base) == 0) {
@@ -695,6 +697,8 @@ sgiioc4_ide_setup_pci_device(struct pci_
 		printk(KERN_INFO "%s: %s Bus-Master DMA disabled\n",
 				 hwif->name, DRV_NAME);
 
+	ide_init_sgiioc4(hwif);
+
 	if (probe_hwif_init(hwif))
 		return -EIO;
 
