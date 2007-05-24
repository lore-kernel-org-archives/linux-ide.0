From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH pata-2.6] aec62xx: remove init_dma() method (take 2)
Date: Thu, 24 May 2007 20:44:13 +0400
Message-ID: <200705242044.13927.sshtylyov@ru.mvista.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702040004.24918.sshtylyov@ru.mvista.com> <200702162321.40813.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:1615 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750707AbXEXQmo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 May 2007 12:42:44 -0400
In-Reply-To: <200702162321.40813.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Get rid of the init_dma() method (which had no particular reason to exist) by
folding it into the init_hwif() method. While at it, also perform some cleanup
in the latter method:

- get rid of the useless clearing of hwif->autodma;

- fold the serialization code into one 'if' statement;

- fold setting the drives' 'autotune' and 'autodma' fields into the single
  statements...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
In this version of the patch I decided not to introduce 'switch' statement into
the init_hwif() method.  Again, the patch has only been compile tested...

 drivers/ide/pci/aec62xx.c |   51 ++++++++++++++--------------------------------
 1 files changed, 16 insertions(+), 35 deletions(-)

Index: linux-2.6/drivers/ide/pci/aec62xx.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/aec62xx.c
+++ linux-2.6/drivers/ide/pci/aec62xx.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/aec62xx.c		Version 0.22	Apr 23, 2007
+ * linux/drivers/ide/pci/aec62xx.c		Version 0.23	May 23, 2007
  *
  * Copyright (C) 1999-2002	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2007		MontaVista Software, Inc. <source@mvista.com>
@@ -220,21 +220,18 @@ static unsigned int __devinit init_chips
 
 static void __devinit init_hwif_aec62xx(ide_hwif_t *hwif)
 {
-	struct pci_dev *dev = hwif->pci_dev;
+	struct pci_dev *dev	= hwif->pci_dev;
+	u8 reg54 = 0,  mask	= hwif->channel ? 0xf0 : 0x0f;
+	unsigned long flags;
 
-	hwif->autodma = 0;
 	hwif->tuneproc = &aec62xx_tune_drive;
 	hwif->speedproc = &aec62xx_tune_chipset;
 
-	if (dev->device == PCI_DEVICE_ID_ARTOP_ATP850UF)
-		hwif->serialized = hwif->channel;
-
-	if (hwif->mate)
-		hwif->mate->serialized = hwif->serialized;
+	if (dev->device == PCI_DEVICE_ID_ARTOP_ATP850UF && hwif->mate)
+		hwif->mate->serialized = hwif->serialized = 1;
 
 	if (!hwif->dma_base) {
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
+		hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
 		return;
 	}
 
@@ -244,32 +241,21 @@ static void __devinit init_hwif_aec62xx(
 	hwif->ide_dma_check	= &aec62xx_config_drive_xfer_rate;
 	hwif->dma_lost_irq	= &aec62xx_dma_lost_irq;
 
-	if (!noautodma)
-		hwif->autodma = 1;
-	hwif->drives[0].autodma = hwif->autodma;
-	hwif->drives[1].autodma = hwif->autodma;
-}
-
-static void __devinit init_dma_aec62xx(ide_hwif_t *hwif, unsigned long dmabase)
-{
-	struct pci_dev *dev	= hwif->pci_dev;
-
 	if (dev->device == PCI_DEVICE_ID_ARTOP_ATP850UF) {
-		u8 reg54h = 0;
-		unsigned long flags;
-
 		spin_lock_irqsave(&ide_lock, flags);
-		pci_read_config_byte(dev, 0x54, &reg54h);
-		pci_write_config_byte(dev, 0x54, reg54h & ~(hwif->channel ? 0xF0 : 0x0F));
+		pci_read_config_byte (dev, 0x54, &reg54);
+		pci_write_config_byte(dev, 0x54, (reg54 & ~mask));
 		spin_unlock_irqrestore(&ide_lock, flags);
-	} else {
-		u8 ata66	= 0;
+	} else if (!hwif->udma_four)
+		u8 ata66 = 0, mask = hwif->channel ? 0x02 : 0x01;
+
 		pci_read_config_byte(hwif->pci_dev, 0x49, &ata66);
-	        if (!(hwif->udma_four))
-			hwif->udma_four = (ata66&(hwif->channel?0x02:0x01))?0:1;
+		hwif->udma_four = (ata66 & mask) ? 0 : 1;
 	}
 
-	ide_setup_dma(hwif, dmabase, 8);
+	if (!noautodma)
+		hwif->autodma = 1;
+	hwif->drives[0].autodma = hwif->drives[1].autodma = hwif->autodma;
 }
 
 static int __devinit init_setup_aec62xx(struct pci_dev *dev, ide_pci_device_t *d)
@@ -296,7 +282,6 @@ static ide_pci_device_t aec62xx_chipsets
 		.init_setup	= init_setup_aec62xx,
 		.init_chipset	= init_chipset_aec62xx,
 		.init_hwif	= init_hwif_aec62xx,
-		.init_dma	= init_dma_aec62xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
@@ -307,7 +292,6 @@ static ide_pci_device_t aec62xx_chipsets
 		.init_setup	= init_setup_aec62xx,
 		.init_chipset	= init_chipset_aec62xx,
 		.init_hwif	= init_hwif_aec62xx,
-		.init_dma	= init_dma_aec62xx,
 		.channels	= 2,
 		.autodma	= NOAUTODMA,
 		.bootable	= OFF_BOARD,
@@ -317,7 +301,6 @@ static ide_pci_device_t aec62xx_chipsets
 		.init_setup	= init_setup_aec62xx,
 		.init_chipset	= init_chipset_aec62xx,
 		.init_hwif	= init_hwif_aec62xx,
-		.init_dma	= init_dma_aec62xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
@@ -328,7 +311,6 @@ static ide_pci_device_t aec62xx_chipsets
 		.init_setup	= init_setup_aec6x80,
 		.init_chipset	= init_chipset_aec62xx,
 		.init_hwif	= init_hwif_aec62xx,
-		.init_dma	= init_dma_aec62xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
@@ -338,7 +320,6 @@ static ide_pci_device_t aec62xx_chipsets
 		.init_setup	= init_setup_aec6x80,
 		.init_chipset	= init_chipset_aec62xx,
 		.init_hwif	= init_hwif_aec62xx,
-		.init_dma	= init_dma_aec62xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},

