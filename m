From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/10] pdc202xx_old: remove ->init_setup
Date: Wed, 29 Aug 2007 23:23:21 +0200
Message-ID: <200708292323.21868.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:44403 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756416AbXH2VZW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Aug 2007 17:25:22 -0400
Received: by nf-out-0910.google.com with SMTP id g13so293536nfb
        for <linux-ide@vger.kernel.org>; Wed, 29 Aug 2007 14:25:20 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Split off pdc202ata4_fixup_irq() helper from init_setup_pdc202ata4().

* Merge init_setup_{pdc202ata4,pdc20265,pdc202xx}() into pdc202xx_init_one().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/pdc202xx_old.c |   57 +++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 32 deletions(-)

Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -369,8 +369,8 @@ static void __devinit init_dma_pdc202xx(
 	ide_setup_dma(hwif, dmabase, 8);
 }
 
-static int __devinit init_setup_pdc202ata4(struct pci_dev *dev,
-					   ide_pci_device_t *d)
+static void __devinit pdc202ata4_fixup_irq(struct pci_dev *dev,
+					   const char *name)
 {
 	if ((dev->class >> 8) != PCI_CLASS_STORAGE_IDE) {
 		u8 irq = 0, irq2 = 0;
@@ -380,37 +380,15 @@ static int __devinit init_setup_pdc202at
 		if (irq != irq2) {
 			pci_write_config_byte(dev,
 				(PCI_INTERRUPT_LINE)|0x80, irq);     /* 0xbc */
-			printk(KERN_INFO "%s: pci-config space interrupt "
-				"mirror fixed.\n", d->name);
+			printk(KERN_INFO "%s: PCI config space interrupt "
+					 "mirror fixed\n", name);
 		}
 	}
-	return ide_setup_pci_device(dev, d);
-}
-
-static int __devinit init_setup_pdc20265(struct pci_dev *dev,
-					 ide_pci_device_t *d)
-{
-	if ((dev->bus->self) &&
-	    (dev->bus->self->vendor == PCI_VENDOR_ID_INTEL) &&
-	    ((dev->bus->self->device == PCI_DEVICE_ID_INTEL_I960) ||
-	     (dev->bus->self->device == PCI_DEVICE_ID_INTEL_I960RM))) {
-		printk(KERN_INFO "ide: Skipping Promise PDC20265 "
-			"attached to I2O RAID controller.\n");
-		return -ENODEV;
-	}
-	return ide_setup_pci_device(dev, d);
-}
-
-static int __devinit init_setup_pdc202xx(struct pci_dev *dev,
-					 ide_pci_device_t *d)
-{
-	return ide_setup_pci_device(dev, d);
 }
 
 static ide_pci_device_t pdc202xx_chipsets[] __devinitdata = {
 	{	/* 0 */
 		.name		= "PDC20246",
-		.init_setup	= init_setup_pdc202ata4,
 		.init_chipset	= init_chipset_pdc202xx,
 		.init_hwif	= init_hwif_pdc202xx,
 		.init_dma	= init_dma_pdc202xx,
@@ -421,7 +399,6 @@ static ide_pci_device_t pdc202xx_chipset
 		.udma_mask	= ATA_UDMA2,
 	},{	/* 1 */
 		.name		= "PDC20262",
-		.init_setup	= init_setup_pdc202ata4,
 		.init_chipset	= init_chipset_pdc202xx,
 		.init_hwif	= init_hwif_pdc202xx,
 		.init_dma	= init_dma_pdc202xx,
@@ -432,7 +409,6 @@ static ide_pci_device_t pdc202xx_chipset
 		.udma_mask	= ATA_UDMA4,
 	},{	/* 2 */
 		.name		= "PDC20263",
-		.init_setup	= init_setup_pdc202ata4,
 		.init_chipset	= init_chipset_pdc202xx,
 		.init_hwif	= init_hwif_pdc202xx,
 		.init_dma	= init_dma_pdc202xx,
@@ -443,7 +419,6 @@ static ide_pci_device_t pdc202xx_chipset
 		.udma_mask	= ATA_UDMA4,
 	},{	/* 3 */
 		.name		= "PDC20265",
-		.init_setup	= init_setup_pdc20265,
 		.init_chipset	= init_chipset_pdc202xx,
 		.init_hwif	= init_hwif_pdc202xx,
 		.init_dma	= init_dma_pdc202xx,
@@ -454,7 +429,6 @@ static ide_pci_device_t pdc202xx_chipset
 		.udma_mask	= ATA_UDMA5,
 	},{	/* 4 */
 		.name		= "PDC20267",
-		.init_setup	= init_setup_pdc202xx,
 		.init_chipset	= init_chipset_pdc202xx,
 		.init_hwif	= init_hwif_pdc202xx,
 		.init_dma	= init_dma_pdc202xx,
@@ -477,9 +451,28 @@ static ide_pci_device_t pdc202xx_chipset
  
 static int __devinit pdc202xx_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &pdc202xx_chipsets[id->driver_data];
+	ide_pci_device_t *d;
+	u8 idx = id->driver_data;
+
+	d = &pdc202xx_chipsets[idx];
+
+	if (idx < 3)
+		pdc202ata4_fixup_irq(dev, d->name);
 
-	return d->init_setup(dev, d);
+	if (idx == 3) {
+		struct pci_dev *bridge = dev->bus->self;
+
+		if (bridge &&
+		    bridge->vendor == PCI_VENDOR_ID_INTEL &&
+		    (bridge->device == PCI_DEVICE_ID_INTEL_I960 ||
+		     bridge->device == PCI_DEVICE_ID_INTEL_I960RM)) {
+			printk(KERN_INFO "ide: Skipping Promise PDC20265 "
+				"attached to I2O RAID controller\n");
+			return -ENODEV;
+		}
+	}
+
+	return ide_setup_pci_device(dev, d);
 }
 
 static const struct pci_device_id pdc202xx_pci_tbl[] = {
