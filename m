From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/9] via82cxxx: keep local ide_pci_device_t copy
Date: Mon, 24 Sep 2007 22:45:17 +0200
Message-ID: <200709242245.17303.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:29604 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949AbXIXUqQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Sep 2007 16:46:16 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1485932nfb
        for <linux-ide@vger.kernel.org>; Mon, 24 Sep 2007 13:46:15 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Keep local ide_pci_device_t copy in via_init_one().

* Adjust ide_pci_device_t copy according to id->driver_data in via_init_one()
  and remove no longer needed second via82cxxx_chipsets[] entry.

* via82cxxx_chipsets[] -> via82cxxx_chipset.

* Remove IDE_HFLAGS_VIA define.

* Bump driver version.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/via82cxxx.c |   62 +++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 35 deletions(-)

Index: b/drivers/ide/pci/via82cxxx.c
===================================================================
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -1,6 +1,6 @@
 /*
  *
- * Version 3.49
+ * Version 3.50
  *
  * VIA IDE driver for Linux. Supported southbridges:
  *
@@ -432,40 +432,29 @@ static void __devinit init_hwif_via82cxx
 		hwif->cbl = via82cxxx_cable_detect(hwif);
 }
 
-#define IDE_HFLAGS_VIA \
-	(IDE_HFLAG_PIO_NO_BLACKLIST | \
-	 IDE_HFLAG_PIO_NO_DOWNGRADE | \
-	 IDE_HFLAG_POST_SET_MODE | \
-	 IDE_HFLAG_IO_32BIT | \
-	 IDE_HFLAG_BOOTABLE)
-
-static ide_pci_device_t via82cxxx_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "VP_IDE",
-		.init_chipset	= init_chipset_via82cxxx,
-		.init_hwif	= init_hwif_via82cxxx,
-		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
-		.host_flags	= IDE_HFLAGS_VIA | IDE_HFLAG_NO_AUTODMA,
-		.pio_mask	= ATA_PIO5,
-		.swdma_mask	= ATA_SWDMA2,
-		.mwdma_mask	= ATA_MWDMA2,
-	},{	/* 1 */
-		.name		= "VP_IDE",
-		.init_chipset	= init_chipset_via82cxxx,
-		.init_hwif	= init_hwif_via82cxxx,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		.host_flags	= IDE_HFLAGS_VIA,
-		.pio_mask	= ATA_PIO5,
-		.swdma_mask	= ATA_SWDMA2,
-		.mwdma_mask	= ATA_MWDMA2,
-	}
+static ide_pci_device_t via82cxxx_chipset __devinitdata = {
+	.name		= "VP_IDE",
+	.init_chipset	= init_chipset_via82cxxx,
+	.init_hwif	= init_hwif_via82cxxx,
+	.enablebits	= { { 0x40, 0x02, 0x02 }, { 0x40, 0x01, 0x01 } },
+	.host_flags	= IDE_HFLAG_PIO_NO_BLACKLIST |
+			  IDE_HFLAG_PIO_NO_DOWNGRADE |
+			  IDE_HFLAG_POST_SET_MODE |
+			  IDE_HFLAG_IO_32BIT |
+			  IDE_HFLAG_BOOTABLE,
+	.pio_mask	= ATA_PIO5,
+	.swdma_mask	= ATA_SWDMA2,
+	.mwdma_mask	= ATA_MWDMA2,
 };
 
 static int __devinit via_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &via82cxxx_chipsets[id->driver_data];
 	struct pci_dev *isa = NULL;
 	struct via_isa_bridge *via_config;
+	u8 idx = id->driver_data;
+	ide_pci_device_t d;
+
+	d = via82cxxx_chipset;
 
 	/*
 	 * Find the ISA bridge and check we know what it is.
@@ -477,19 +466,22 @@ static int __devinit via_init_one(struct
 		return -ENODEV;
 	}
 
-	if (via_config->flags & VIA_NO_UNMASK)
-		d->host_flags &= ~IDE_HFLAG_UNMASK_IRQS;
+	if (idx == 0)
+		d.host_flags |= IDE_HFLAG_NO_AUTODMA;
 	else
-		d->host_flags |= IDE_HFLAG_UNMASK_IRQS;
+		d.enablebits[1].reg = d.enablebits[0].reg = 0;
+
+	if ((via_config->flags & VIA_NO_UNMASK) == 0)
+		d.host_flags |= IDE_HFLAG_UNMASK_IRQS;
 
 #ifdef CONFIG_PPC_CHRP
 	if (machine_is(chrp) && _chrp_type == _CHRP_Pegasos)
-		d->host_flags |= IDE_HFLAG_FORCE_LEGACY_IRQS;
+		d.host_flags |= IDE_HFLAG_FORCE_LEGACY_IRQS;
 #endif
 
-	d->udma_mask = via_config->udma_mask;
+	d.udma_mask = via_config->udma_mask;
 
-	return ide_setup_pci_device(dev, d);
+	return ide_setup_pci_device(dev, &d);
 }
 
 static const struct pci_device_id via_pci_tbl[] = {
