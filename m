From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/6] aec62xx: remove aec62xx_dma_lost_irq()
Date: Mon, 17 Sep 2007 22:08:08 +0200
Message-ID: <200709172208.08968.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:4609 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756230AbXIQUIW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Sep 2007 16:08:22 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1242546nfb
        for <linux-ide@vger.kernel.org>; Mon, 17 Sep 2007 13:08:20 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Remove aec62xx_dma_lost_irq() (generic ide_dma_lost_irq() will be used now).

* Bump driver version.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/aec62xx.c |   17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

Index: b/drivers/ide/pci/aec62xx.c
===================================================================
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/aec62xx.c		Version 0.26	Sep 1, 2007
+ * linux/drivers/ide/pci/aec62xx.c		Version 0.27	Sep 16, 2007
  *
  * Copyright (C) 1999-2002	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2007		MontaVista Software, Inc. <source@mvista.com>
@@ -141,19 +141,6 @@ static void aec_set_pio_mode(ide_drive_t
 	drive->hwif->set_dma_mode(drive, pio + XFER_PIO_0);
 }
 
-static void aec62xx_dma_lost_irq (ide_drive_t *drive)
-{
-	switch (HWIF(drive)->pci_dev->device) {
-		case PCI_DEVICE_ID_ARTOP_ATP860:
-		case PCI_DEVICE_ID_ARTOP_ATP860R:
-		case PCI_DEVICE_ID_ARTOP_ATP865:
-		case PCI_DEVICE_ID_ARTOP_ATP865R:
-			printk(" AEC62XX time out ");
-		default:
-			break;
-	}
-}
-
 static unsigned int __devinit init_chipset_aec62xx(struct pci_dev *dev, const char *name)
 {
 	int bus_speed = system_bus_clock();
@@ -195,8 +182,6 @@ static void __devinit init_hwif_aec62xx(
 	if (hwif->dma_base == 0)
 		return;
 
-	hwif->dma_lost_irq	= &aec62xx_dma_lost_irq;
-
 	if (dev->device == PCI_DEVICE_ID_ARTOP_ATP850UF)
 		return;
 
