From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/10] aec62xx: remove ->init_setup
Date: Wed, 29 Aug 2007 23:18:58 +0200
Message-ID: <200708292318.58193.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:44326 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756550AbXH2VZQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Aug 2007 17:25:16 -0400
Received: by nf-out-0910.google.com with SMTP id g13so293495nfb
        for <linux-ide@vger.kernel.org>; Wed, 29 Aug 2007 14:25:15 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Merge init_setup_{aec62xx,aec6x80}() into aec62xx_init_one().

While at it:

* Use id->driver_data instead of dev->device.

* Use ATA_UDMA6 define.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/aec62xx.c |   39 ++++++++++++++-------------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

Index: b/drivers/ide/pci/aec62xx.c
===================================================================
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -217,28 +217,9 @@ static void __devinit init_hwif_aec62xx(
 	}
 }
 
-static int __devinit init_setup_aec62xx(struct pci_dev *dev, ide_pci_device_t *d)
-{
-	return ide_setup_pci_device(dev, d);
-}
-
-static int __devinit init_setup_aec6x80(struct pci_dev *dev, ide_pci_device_t *d)
-{
-	unsigned long dma_base = pci_resource_start(dev, 4);
-
-	if (inb(dma_base + 2) & 0x10) {
-		d->name = (dev->device == PCI_DEVICE_ID_ARTOP_ATP865R) ?
-			  "AEC6880R" : "AEC6880";
-		d->udma_mask = 0x7f; /* udma0-6 */
-	}
-
-	return ide_setup_pci_device(dev, d);
-}
-
 static ide_pci_device_t aec62xx_chipsets[] __devinitdata = {
 	{	/* 0 */
 		.name		= "AEC6210",
-		.init_setup	= init_setup_aec62xx,
 		.init_chipset	= init_chipset_aec62xx,
 		.init_hwif	= init_hwif_aec62xx,
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
@@ -248,7 +229,6 @@ static ide_pci_device_t aec62xx_chipsets
 		.udma_mask	= ATA_UDMA2,
 	},{	/* 1 */
 		.name		= "AEC6260",
-		.init_setup	= init_setup_aec62xx,
 		.init_chipset	= init_chipset_aec62xx,
 		.init_hwif	= init_hwif_aec62xx,
 		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_NO_AUTODMA |
@@ -258,7 +238,6 @@ static ide_pci_device_t aec62xx_chipsets
 		.udma_mask	= ATA_UDMA4,
 	},{	/* 2 */
 		.name		= "AEC6260R",
-		.init_setup	= init_setup_aec62xx,
 		.init_chipset	= init_chipset_aec62xx,
 		.init_hwif	= init_hwif_aec62xx,
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
@@ -268,7 +247,6 @@ static ide_pci_device_t aec62xx_chipsets
 		.udma_mask	= ATA_UDMA4,
 	},{	/* 3 */
 		.name		= "AEC6280",
-		.init_setup	= init_setup_aec6x80,
 		.init_chipset	= init_chipset_aec62xx,
 		.init_hwif	= init_hwif_aec62xx,
 		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
@@ -277,7 +255,6 @@ static ide_pci_device_t aec62xx_chipsets
 		.udma_mask	= ATA_UDMA5,
 	},{	/* 4 */
 		.name		= "AEC6280R",
-		.init_setup	= init_setup_aec6x80,
 		.init_chipset	= init_chipset_aec62xx,
 		.init_hwif	= init_hwif_aec62xx,
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
@@ -302,9 +279,21 @@ static ide_pci_device_t aec62xx_chipsets
  
 static int __devinit aec62xx_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t d = aec62xx_chipsets[id->driver_data];
+	ide_pci_device_t d;
+	u8 idx = id->driver_data;
+
+	d = aec62xx_chipsets[idx];
+
+	if (idx == 3 || idx == 4) {
+		unsigned long dma_base = pci_resource_start(dev, 4);
+
+		if (inb(dma_base + 2) & 0x10) {
+			d.name = (idx == 4) ? "AEC6880R" : "AEC6880";
+			d.udma_mask = ATA_UDMA6;
+		}
+	}
 
-	return d.init_setup(dev, &d);
+	return ide_setup_pci_device(dev, &d);
 }
 
 static const struct pci_device_id aec62xx_pci_tbl[] = {
