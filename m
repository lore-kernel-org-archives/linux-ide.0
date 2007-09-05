From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/13] aec62xx: no need to disable UDMA in ->init_hwif method for ATP850UF
Date: Wed, 5 Sep 2007 23:50:36 +0200
Message-ID: <200709052350.36494.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:65431 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbXIEV6p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Sep 2007 17:58:45 -0400
Received: by nf-out-0910.google.com with SMTP id f5so1828117nfh
        for <linux-ide@vger.kernel.org>; Wed, 05 Sep 2007 14:58:44 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* No need to disable UDMA in ->init_hwif method for ATP850UF (and since we
  now always tune PIO it will be disabled by ->set_pio_mode calls anyway).

* Bump driver version.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/aec62xx.c |   14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

Index: b/drivers/ide/pci/aec62xx.c
===================================================================
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/aec62xx.c		Version 0.25	Aug 1, 2007
+ * linux/drivers/ide/pci/aec62xx.c		Version 0.26	Sep 1, 2007
  *
  * Copyright (C) 1999-2002	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2007		MontaVista Software, Inc. <source@mvista.com>
@@ -184,8 +184,6 @@ static unsigned int __devinit init_chips
 static void __devinit init_hwif_aec62xx(ide_hwif_t *hwif)
 {
 	struct pci_dev *dev	= hwif->pci_dev;
-	u8 reg54 = 0,  mask	= hwif->channel ? 0xf0 : 0x0f;
-	unsigned long flags;
 
 	hwif->set_pio_mode = &aec_set_pio_mode;
 
@@ -203,12 +201,10 @@ static void __devinit init_hwif_aec62xx(
 
 	hwif->dma_lost_irq	= &aec62xx_dma_lost_irq;
 
-	if (dev->device == PCI_DEVICE_ID_ARTOP_ATP850UF) {
-		spin_lock_irqsave(&ide_lock, flags);
-		pci_read_config_byte (dev, 0x54, &reg54);
-		pci_write_config_byte(dev, 0x54, (reg54 & ~mask));
-		spin_unlock_irqrestore(&ide_lock, flags);
-	} else if (hwif->cbl != ATA_CBL_PATA40_SHORT) {
+	if (dev->device == PCI_DEVICE_ID_ARTOP_ATP850UF)
+		return;
+
+	if (hwif->cbl != ATA_CBL_PATA40_SHORT) {
 		u8 ata66 = 0, mask = hwif->channel ? 0x02 : 0x01;
 
 		pci_read_config_byte(hwif->pci_dev, 0x49, &ata66);
