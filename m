From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/10] cmd64x: remove ->init_setup
Date: Wed, 29 Aug 2007 23:20:02 +0200
Message-ID: <200708292320.02730.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:44174 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756669AbXH2VZR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Aug 2007 17:25:17 -0400
Received: by nf-out-0910.google.com with SMTP id g13so293512nfb
        for <linux-ide@vger.kernel.org>; Wed, 29 Aug 2007 14:25:15 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>


Merge init_setup_{cmd64x,cmd646}() into cmd64x_init_one().

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cmd64x.c |   39 ++++++++++++---------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -551,27 +551,9 @@ static void __devinit init_hwif_cmd64x(i
 	}
 }
 
-static int __devinit init_setup_cmd64x(struct pci_dev *dev, ide_pci_device_t *d)
-{
-	return ide_setup_pci_device(dev, d);
-}
-
-static int __devinit init_setup_cmd646(struct pci_dev *dev, ide_pci_device_t *d)
-{
-	/*
-	 * The original PCI0646 didn't have the primary channel enable bit,
-	 * it appeared starting with PCI0646U (i.e. revision ID 3).
-	 */
-	if (dev->revision < 3)
-		d->enablebits[0].reg = 0;
-
-	return ide_setup_pci_device(dev, d);
-}
-
 static ide_pci_device_t cmd64x_chipsets[] __devinitdata = {
 	{	/* 0 */
 		.name		= "CMD643",
-		.init_setup	= init_setup_cmd64x,
 		.init_chipset	= init_chipset_cmd64x,
 		.init_hwif	= init_hwif_cmd64x,
 		.enablebits	= {{0x00,0x00,0x00}, {0x51,0x08,0x08}},
@@ -581,7 +563,6 @@ static ide_pci_device_t cmd64x_chipsets[
 		.udma_mask	= 0x00, /* no udma */
 	},{	/* 1 */
 		.name		= "CMD646",
-		.init_setup	= init_setup_cmd646,
 		.init_chipset	= init_chipset_cmd64x,
 		.init_hwif	= init_hwif_cmd64x,
 		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
@@ -591,7 +572,6 @@ static ide_pci_device_t cmd64x_chipsets[
 		.udma_mask	= ATA_UDMA2,
 	},{	/* 2 */
 		.name		= "CMD648",
-		.init_setup	= init_setup_cmd64x,
 		.init_chipset	= init_chipset_cmd64x,
 		.init_hwif	= init_hwif_cmd64x,
 		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
@@ -601,7 +581,6 @@ static ide_pci_device_t cmd64x_chipsets[
 		.udma_mask	= ATA_UDMA4,
 	},{	/* 3 */
 		.name		= "CMD649",
-		.init_setup	= init_setup_cmd64x,
 		.init_chipset	= init_chipset_cmd64x,
 		.init_hwif	= init_hwif_cmd64x,
 		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
@@ -612,15 +591,21 @@ static ide_pci_device_t cmd64x_chipsets[
 	}
 };
 
-/*
- * We may have to modify enablebits for PCI0646, so we'd better pass
- * a local copy of the ide_pci_device_t structure down the call chain...
- */
 static int __devinit cmd64x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t d = cmd64x_chipsets[id->driver_data];
+	ide_pci_device_t d;
+	u8 idx = id->driver_data;
+
+	d = cmd64x_chipsets[idx];
+
+	/*
+	 * The original PCI0646 didn't have the primary channel enable bit,
+	 * it appeared starting with PCI0646U (i.e. revision ID 3).
+	 */
+	if (idx == 1 && dev->revision < 3)
+		d.enablebits[0].reg = 0;
 
-	return d.init_setup(dev, &d);
+	return ide_setup_pci_device(dev, &d);
 }
 
 static const struct pci_device_id cmd64x_pci_tbl[] = {
