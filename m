From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 9/10] serverworks: remove ->init_setup
Date: Wed, 29 Aug 2007 23:24:39 +0200
Message-ID: <200708292324.39918.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:44174 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756731AbXH2VZX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Aug 2007 17:25:23 -0400
Received: by nf-out-0910.google.com with SMTP id g13so293512nfb
        for <linux-ide@vger.kernel.org>; Wed, 29 Aug 2007 14:25:22 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Merge init_setup_{svwks,csb6}() into svwks_init_one().

While at it:

* Remove redundant dev->device checks.

* Operate on a local copy of serverworks_chipsets[] entry.

* Use pci_resource_start().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/serverworks.c |   45 +++++++++++++-----------------------------
 1 file changed, 14 insertions(+), 31 deletions(-)

Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -378,34 +378,9 @@ static void __devinit init_hwif_svwks (i
 	}
 }
 
-static int __devinit init_setup_svwks (struct pci_dev *dev, ide_pci_device_t *d)
-{
-	return ide_setup_pci_device(dev, d);
-}
-
-static int __devinit init_setup_csb6 (struct pci_dev *dev, ide_pci_device_t *d)
-{
-	if (!(PCI_FUNC(dev->devfn) & 1)) {
-		if (dev->resource[0].start == 0x01f1)
-			d->host_flags |= IDE_HFLAG_BOOTABLE;
-		else
-			d->host_flags &= ~IDE_HFLAG_BOOTABLE;
-	}
-
-	if ((dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE ||
-	    dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2) &&
-	    (!(PCI_FUNC(dev->devfn) & 1)))
-		d->host_flags |= IDE_HFLAG_SINGLE;
-	else
-		d->host_flags &= ~IDE_HFLAG_SINGLE;
-
-	return ide_setup_pci_device(dev, d);
-}
-
 static ide_pci_device_t serverworks_chipsets[] __devinitdata = {
 	{	/* 0 */
 		.name		= "SvrWks OSB4",
-		.init_setup	= init_setup_svwks,
 		.init_chipset	= init_chipset_svwks,
 		.init_hwif	= init_hwif_svwks,
 		.host_flags	= IDE_HFLAG_BOOTABLE,
@@ -414,7 +389,6 @@ static ide_pci_device_t serverworks_chip
 		.udma_mask	= 0x00, /* UDMA is problematic on OSB4 */
 	},{	/* 1 */
 		.name		= "SvrWks CSB5",
-		.init_setup	= init_setup_svwks,
 		.init_chipset	= init_chipset_svwks,
 		.init_hwif	= init_hwif_svwks,
 		.host_flags	= IDE_HFLAG_BOOTABLE,
@@ -423,7 +397,6 @@ static ide_pci_device_t serverworks_chip
 		.udma_mask	= ATA_UDMA5,
 	},{	/* 2 */
 		.name		= "SvrWks CSB6",
-		.init_setup	= init_setup_csb6,
 		.init_chipset	= init_chipset_svwks,
 		.init_hwif	= init_hwif_svwks,
 		.host_flags	= IDE_HFLAG_BOOTABLE,
@@ -432,7 +405,6 @@ static ide_pci_device_t serverworks_chip
 		.udma_mask	= ATA_UDMA5,
 	},{	/* 3 */
 		.name		= "SvrWks CSB6",
-		.init_setup	= init_setup_csb6,
 		.init_chipset	= init_chipset_svwks,
 		.init_hwif	= init_hwif_svwks,
 		.host_flags	= IDE_HFLAG_SINGLE | IDE_HFLAG_BOOTABLE,
@@ -441,7 +413,6 @@ static ide_pci_device_t serverworks_chip
 		.udma_mask	= ATA_UDMA5,
 	},{	/* 4 */
 		.name		= "SvrWks HT1000",
-		.init_setup	= init_setup_svwks,
 		.init_chipset	= init_chipset_svwks,
 		.init_hwif	= init_hwif_svwks,
 		.host_flags	= IDE_HFLAG_SINGLE | IDE_HFLAG_BOOTABLE,
@@ -462,9 +433,21 @@ static ide_pci_device_t serverworks_chip
  
 static int __devinit svwks_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &serverworks_chipsets[id->driver_data];
+	ide_pci_device_t d;
+	u8 idx = id->driver_data;
+
+	d = serverworks_chipsets[idx];
+
+	if (idx == 2 || idx == 3) {
+		if ((PCI_FUNC(dev->devfn) & 1) == 0) {
+			if (pci_resource_start(dev, 0) != 0x01f1)
+				d.host_flags &= ~IDE_HFLAG_BOOTABLE;
+			d.host_flags |= IDE_HFLAG_SINGLE;
+		} else
+			d.host_flags &= ~IDE_HFLAG_SINGLE;
+	}
 
-	return d->init_setup(dev, d);
+	return ide_setup_pci_device(dev, &d);
 }
 
 static const struct pci_device_id svwks_pci_tbl[] = {
