From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/10] ide: add IDE_HFLAG_FORCE_LEGACY_IRQS host flag
Date: Tue, 11 Sep 2007 23:40:21 +0200
Message-ID: <200709112340.21552.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:27488 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755754AbXIKVkZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Sep 2007 17:40:25 -0400
Received: by ug-out-1314.google.com with SMTP id z38so138060ugc
        for <linux-ide@vger.kernel.org>; Tue, 11 Sep 2007 14:40:24 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Add IDE_HFLAG_FORCE_LEGACY_IRQS host flag to tell ide_pci_setup_ports()
to always set hwif->irq to legacy IRQ 14/15 and convert generic IDE PCI
and via82cxxx host drivers to use it.

While at it:

* Add IDE_HFLAGS_UMC define (generic IDE PCI host driver).

* Remove no longer needed init_hwif_generic() (generic IDE PCI host driver).

* Set d->udma_mask instead of hwif->ultra_mask (via82cxxx host driver).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/generic.c   |   27 ++++++---------------------
 drivers/ide/pci/via82cxxx.c |   20 +++++++++++---------
 drivers/ide/setup-pci.c     |    3 ++-
 include/linux/ide.h         |    2 ++
 4 files changed, 21 insertions(+), 31 deletions(-)

Index: b/drivers/ide/pci/generic.c
===================================================================
--- a/drivers/ide/pci/generic.c
+++ b/drivers/ide/pci/generic.c
@@ -54,25 +54,13 @@ __setup("all-generic-ide", ide_generic_a
 module_param_named(all_generic_ide, ide_generic_all, bool, 0444);
 MODULE_PARM_DESC(all_generic_ide, "IDE generic will claim all unknown PCI IDE storage controllers.");
 
-static void __devinit init_hwif_generic (ide_hwif_t *hwif)
-{
-	switch(hwif->pci_dev->device) {
-		case PCI_DEVICE_ID_UMC_UM8673F:
-		case PCI_DEVICE_ID_UMC_UM8886A:
-		case PCI_DEVICE_ID_UMC_UM8886BF:
-			hwif->irq = hwif->channel ? 15 : 14;
-			break;
-		default:
-			break;
-	}
-}
+#define IDE_HFLAGS_UMC (IDE_HFLAG_NO_DMA | IDE_HFLAG_FORCE_LEGACY_IRQS)
 
-#define DECLARE_GENERIC_PCI_DEV(name_str, dma_setting) \
+#define DECLARE_GENERIC_PCI_DEV(name_str, extra_flags) \
 	{ \
 		.name		= name_str, \
-		.init_hwif	= init_hwif_generic, \
 		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA | \
-				  dma_setting | \
+				  extra_flags | \
 				  IDE_HFLAG_BOOTABLE, \
 	}
 
@@ -81,7 +69,6 @@ static ide_pci_device_t generic_chipsets
 
 	{	/* 1 */
 		.name		= "NS87410",
-		.init_hwif	= init_hwif_generic,
 		.enablebits	= {{0x43,0x08,0x08}, {0x47,0x08,0x08}},
 		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA |
 				  IDE_HFLAG_BOOTABLE,
@@ -92,16 +79,15 @@ static ide_pci_device_t generic_chipsets
 
 	/*  2 */ DECLARE_GENERIC_PCI_DEV("SAMURAI",	0),
 	/*  3 */ DECLARE_GENERIC_PCI_DEV("HT6565",	0),
-	/*  4 */ DECLARE_GENERIC_PCI_DEV("UM8673F",	IDE_HFLAG_NO_DMA),
-	/*  5 */ DECLARE_GENERIC_PCI_DEV("UM8886A",	IDE_HFLAG_NO_DMA),
-	/*  6 */ DECLARE_GENERIC_PCI_DEV("UM8886BF",	IDE_HFLAG_NO_DMA),
+	/*  4 */ DECLARE_GENERIC_PCI_DEV("UM8673F",	IDE_HFLAGS_UMC),
+	/*  5 */ DECLARE_GENERIC_PCI_DEV("UM8886A",	IDE_HFLAGS_UMC),
+	/*  6 */ DECLARE_GENERIC_PCI_DEV("UM8886BF",	IDE_HFLAGS_UMC),
 	/*  7 */ DECLARE_GENERIC_PCI_DEV("HINT_IDE",	0),
 	/*  8 */ DECLARE_GENERIC_PCI_DEV("VIA_IDE",	IDE_HFLAG_NO_AUTODMA),
 	/*  9 */ DECLARE_GENERIC_PCI_DEV("OPTI621V",	IDE_HFLAG_NO_AUTODMA),
 
 	{	/* 10 */
 		.name		= "VIA8237SATA",
-		.init_hwif	= init_hwif_generic,
 		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA |
 				  IDE_HFLAG_OFF_BOARD,
 		.swdma_mask	= ATA_SWDMA2,
@@ -115,7 +101,6 @@ static ide_pci_device_t generic_chipsets
 
 	{	/* 14 */
 		.name		= "Revolution",
-		.init_hwif	= init_hwif_generic,
 		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA |
 				  IDE_HFLAG_OFF_BOARD,
 		.swdma_mask	= ATA_SWDMA2,
Index: b/drivers/ide/pci/via82cxxx.c
===================================================================
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -427,12 +427,6 @@ static void __devinit init_hwif_via82cxx
 	hwif->set_pio_mode = &via_set_pio_mode;
 	hwif->set_dma_mode = &via_set_drive;
 
-#ifdef CONFIG_PPC_CHRP
-	if(machine_is(chrp) && _chrp_type == _CHRP_Pegasos) {
-		hwif->irq = hwif->channel ? 15 : 14;
-	}
-#endif
-
 	for (i = 0; i < 2; i++) {
 		hwif->drives[i].io_32bit = 1;
 		hwif->drives[i].unmask = (vdev->via_config->flags & VIA_NO_UNMASK) ? 0 : 1;
@@ -441,8 +435,6 @@ static void __devinit init_hwif_via82cxx
 	if (!hwif->dma_base)
 		return;
 
-	hwif->ultra_mask = vdev->via_config->udma_mask;
-
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 		hwif->cbl = via82cxxx_cable_detect(hwif);
 }
@@ -478,8 +470,10 @@ static ide_pci_device_t via82cxxx_chipse
 
 static int __devinit via_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
+	ide_pci_device_t *d = &via82cxxx_chipsets[id->driver_data];
 	struct pci_dev *isa = NULL;
 	struct via_isa_bridge *via_config;
+
 	/*
 	 * Find the ISA bridge and check we know what it is.
 	 */
@@ -489,7 +483,15 @@ static int __devinit via_init_one(struct
 		printk(KERN_WARNING "VP_IDE: Unknown VIA SouthBridge, disabling DMA.\n");
 		return -ENODEV;
 	}
-	return ide_setup_pci_device(dev, &via82cxxx_chipsets[id->driver_data]);
+
+#ifdef CONFIG_PPC_CHRP
+	if (machine_is(chrp) && _chrp_type == _CHRP_Pegasos)
+		d->host_flags |= IDE_HFLAG_FORCE_LEGACY_IRQS;
+#endif
+
+	d->udma_mask = via_config->udma_mask;
+
+	return ide_setup_pci_device(dev, d);
 }
 
 static const struct pci_device_id via_pci_tbl[] = {
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -563,7 +563,8 @@ void ide_pci_setup_ports(struct pci_dev 
 		if ((d->host_flags & IDE_HFLAG_NO_DMA) == 0)
 			ide_hwif_setup_dma(dev, d, hwif);
 
-		if ((d->host_flags & IDE_HFLAG_LEGACY_IRQS) && hwif->irq == 0)
+		if ((!hwif->irq && (d->host_flags & IDE_HFLAG_LEGACY_IRQS)) ||
+		    (d->host_flags & IDE_HFLAG_FORCE_LEGACY_IRQS))
 			hwif->irq = port ? 15 : 14;
 
 		hwif->host_flags = d->host_flags;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1268,6 +1268,8 @@ enum {
 	IDE_HFLAG_SERIALIZE		= (1 << 20),
 	/* use legacy IRQs */
 	IDE_HFLAG_LEGACY_IRQS		= (1 << 21),
+	/* force use of legacy IRQs */
+	IDE_HFLAG_FORCE_LEGACY_IRQS	= (1 << 22),
 };
 
 #ifdef CONFIG_BLK_DEV_OFFBOARD
