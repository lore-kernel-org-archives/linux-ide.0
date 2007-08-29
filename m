From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/10] pdc202xx_new: remove ->init_setup
Date: Wed, 29 Aug 2007 23:22:19 +0200
Message-ID: <200708292322.19990.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:44326 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756675AbXH2VZU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Aug 2007 17:25:20 -0400
Received: by nf-out-0910.google.com with SMTP id g13so293495nfb
        for <linux-ide@vger.kernel.org>; Wed, 29 Aug 2007 14:25:18 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Split off pdc20270_get_dev2() helper from init_setup_pdc20270().

* Merge init_setup_{pdcnew,pdc20270,pdc20276}() into pdc202new_init_one().

While at it:

* Change KERN_ level of interrupt fixup message from KERN_WARNING to KERN_INFO.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/pdc202xx_new.c |  106 ++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 58 deletions(-)

Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -482,66 +482,31 @@ static void __devinit init_hwif_pdc202ne
 		hwif->cbl = pdcnew_cable_detect(hwif);
 }
 
-static int __devinit init_setup_pdcnew(struct pci_dev *dev, ide_pci_device_t *d)
+static struct pci_dev * __devinit pdc20270_get_dev2(struct pci_dev *dev)
 {
-	return ide_setup_pci_device(dev, d);
-}
-
-static int __devinit init_setup_pdc20270(struct pci_dev *dev, ide_pci_device_t *d)
-{
-	struct pci_dev *bridge = dev->bus->self;
-
-	if (bridge != NULL &&
-	    bridge->vendor == PCI_VENDOR_ID_DEC &&
-	    bridge->device == PCI_DEVICE_ID_DEC_21150) {
-		struct pci_dev *dev2;
-
-		if (PCI_SLOT(dev->devfn) & 2)
-			return -ENODEV;
+	struct pci_dev *dev2;
 
-		dev2 = pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn) + 2,
-							PCI_FUNC(dev->devfn)));
-		if (dev2 != NULL &&
-		    dev2->vendor == dev->vendor &&
-		    dev2->device == dev->device) {
-			int ret;
-
-			if (dev2->irq != dev->irq) {
-				dev2->irq = dev->irq;
-
-				printk(KERN_WARNING "%s: PCI config space "
-				       "interrupt fixed.\n", d->name);
-			}
-
-			ret = ide_setup_pci_devices(dev, dev2, d);
-			if (ret < 0)
-				pci_dev_put(dev2);
-			return ret;
+	dev2 = pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn) + 2,
+						PCI_FUNC(dev->devfn)));
+	if (dev2 &&
+	    dev2->vendor == dev->vendor &&
+	    dev2->device == dev->device) {
+
+		if (dev2->irq != dev->irq) {
+			dev2->irq = dev->irq;
+			printk(KERN_INFO "PDC20270: PCI config space "
+					 "interrupt fixed\n");
 		}
-	}
-	return ide_setup_pci_device(dev, d);
-}
-
-static int __devinit init_setup_pdc20276(struct pci_dev *dev, ide_pci_device_t *d)
-{
-	struct pci_dev *bridge = dev->bus->self;
-
-	if (bridge != NULL &&
-	    bridge->vendor == PCI_VENDOR_ID_INTEL &&
-	   (bridge->device == PCI_DEVICE_ID_INTEL_I960 ||
-	    bridge->device == PCI_DEVICE_ID_INTEL_I960RM)) {
 
-		printk(KERN_INFO "%s: attached to I2O RAID controller, "
-				 "skipping.\n", d->name);
-		return -ENODEV;
+		return dev2;
 	}
-	return ide_setup_pci_device(dev, d);
+
+	return NULL;
 }
 
 static ide_pci_device_t pdcnew_chipsets[] __devinitdata = {
 	{	/* 0 */
 		.name		= "PDC20268",
-		.init_setup	= init_setup_pdcnew,
 		.init_chipset	= init_chipset_pdcnew,
 		.init_hwif	= init_hwif_pdc202new,
 		.host_flags	= IDE_HFLAG_POST_SET_MODE | IDE_HFLAG_OFF_BOARD,
@@ -550,7 +515,6 @@ static ide_pci_device_t pdcnew_chipsets[
 		.udma_mask	= ATA_UDMA5,
 	},{	/* 1 */
 		.name		= "PDC20269",
-		.init_setup	= init_setup_pdcnew,
 		.init_chipset	= init_chipset_pdcnew,
 		.init_hwif	= init_hwif_pdc202new,
 		.host_flags	= IDE_HFLAG_POST_SET_MODE | IDE_HFLAG_OFF_BOARD,
@@ -559,7 +523,6 @@ static ide_pci_device_t pdcnew_chipsets[
 		.udma_mask	= ATA_UDMA6,
 	},{	/* 2 */
 		.name		= "PDC20270",
-		.init_setup	= init_setup_pdc20270,
 		.init_chipset	= init_chipset_pdcnew,
 		.init_hwif	= init_hwif_pdc202new,
 		.host_flags	= IDE_HFLAG_POST_SET_MODE | IDE_HFLAG_OFF_BOARD,
@@ -568,7 +531,6 @@ static ide_pci_device_t pdcnew_chipsets[
 		.udma_mask	= ATA_UDMA5,
 	},{	/* 3 */
 		.name		= "PDC20271",
-		.init_setup	= init_setup_pdcnew,
 		.init_chipset	= init_chipset_pdcnew,
 		.init_hwif	= init_hwif_pdc202new,
 		.host_flags	= IDE_HFLAG_POST_SET_MODE | IDE_HFLAG_OFF_BOARD,
@@ -577,7 +539,6 @@ static ide_pci_device_t pdcnew_chipsets[
 		.udma_mask	= ATA_UDMA6,
 	},{	/* 4 */
 		.name		= "PDC20275",
-		.init_setup	= init_setup_pdcnew,
 		.init_chipset	= init_chipset_pdcnew,
 		.init_hwif	= init_hwif_pdc202new,
 		.host_flags	= IDE_HFLAG_POST_SET_MODE | IDE_HFLAG_OFF_BOARD,
@@ -586,7 +547,6 @@ static ide_pci_device_t pdcnew_chipsets[
 		.udma_mask	= ATA_UDMA6,
 	},{	/* 5 */
 		.name		= "PDC20276",
-		.init_setup	= init_setup_pdc20276,
 		.init_chipset	= init_chipset_pdcnew,
 		.init_hwif	= init_hwif_pdc202new,
 		.host_flags	= IDE_HFLAG_POST_SET_MODE | IDE_HFLAG_OFF_BOARD,
@@ -595,7 +555,6 @@ static ide_pci_device_t pdcnew_chipsets[
 		.udma_mask	= ATA_UDMA6,
 	},{	/* 6 */
 		.name		= "PDC20277",
-		.init_setup	= init_setup_pdcnew,
 		.init_chipset	= init_chipset_pdcnew,
 		.init_hwif	= init_hwif_pdc202new,
 		.host_flags	= IDE_HFLAG_POST_SET_MODE | IDE_HFLAG_OFF_BOARD,
@@ -616,9 +575,40 @@ static ide_pci_device_t pdcnew_chipsets[
  
 static int __devinit pdc202new_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &pdcnew_chipsets[id->driver_data];
+	ide_pci_device_t *d;
+	struct pci_dev *bridge = dev->bus->self;
+	u8 idx = id->driver_data;
+
+	d = &pdcnew_chipsets[idx];
+
+	if (idx == 2 && bridge &&
+	    bridge->vendor == PCI_VENDOR_ID_DEC &&
+	    bridge->device == PCI_DEVICE_ID_DEC_21150) {
+		struct pci_dev *dev2;
+
+		if (PCI_SLOT(dev->devfn) & 2)
+			return -ENODEV;
 
-	return d->init_setup(dev, d);
+		dev2 = pdc20270_get_dev2(dev);
+
+		if (dev2) {
+			int ret = ide_setup_pci_devices(dev, dev2, d);
+			if (ret < 0)
+				pci_dev_put(dev2);
+			return ret;
+		}
+	}
+
+	if (idx == 5 && bridge &&
+	    bridge->vendor == PCI_VENDOR_ID_INTEL &&
+	    (bridge->device == PCI_DEVICE_ID_INTEL_I960 ||
+	     bridge->device == PCI_DEVICE_ID_INTEL_I960RM)) {
+		printk(KERN_INFO "PDC20276: attached to I2O RAID controller, "
+				 "skipping\n");
+		return -ENODEV;
+	}
+
+	return ide_setup_pci_device(dev, d);
 }
 
 static const struct pci_device_id pdc202new_pci_tbl[] = {
