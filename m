From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/10] ide: add IDE_HFLAG_{IO_32BIT,UNMASK_IRQS} host flags
Date: Tue, 11 Sep 2007 23:42:08 +0200
Message-ID: <200709112342.09074.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:27120 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756081AbXIKVk1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Sep 2007 17:40:27 -0400
Received: by ug-out-1314.google.com with SMTP id z38so138055ugc
        for <linux-ide@vger.kernel.org>; Tue, 11 Sep 2007 14:40:26 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Add IDE_HFLAG_{IO_32BIT,UNMASK_IRQS} host flag to tell ide_pci_setup_ports()
to set drive->{io_32bit,unmask} for both drives on the interface.  Convert
amd74xx, sl82c105 and via82cxxx host drivers to use these new host flags.

While at it:

* Add IDE_HFLAGS_AMD define (amd74xx host driver).

* Add IDE_HFLAGS_VIA define (via82cxxx host driver).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/amd74xx.c   |   25 ++++++++++---------------
 drivers/ide/pci/sl82c105.c  |   12 ++++--------
 drivers/ide/pci/via82cxxx.c |   31 ++++++++++++++-----------------
 drivers/ide/setup-pci.c     |   10 ++++++++++
 include/linux/ide.h         |    4 ++++
 5 files changed, 42 insertions(+), 40 deletions(-)

Index: b/drivers/ide/pci/amd74xx.c
===================================================================
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -242,19 +242,12 @@ static unsigned int __devinit init_chips
 
 static void __devinit init_hwif_amd74xx(ide_hwif_t *hwif)
 {
-	int i;
-
 	if (hwif->irq == 0) /* 0 is bogus but will do for now */
 		hwif->irq = pci_get_legacy_ide_irq(hwif->pci_dev, hwif->channel);
 
 	hwif->set_pio_mode = &amd_set_pio_mode;
 	hwif->set_dma_mode = &amd_set_drive;
 
-	for (i = 0; i < 2; i++) {
-		hwif->drives[i].io_32bit = 1;
-		hwif->drives[i].unmask = 1;
-	}
-
 	if (!hwif->dma_base)
 		return;
 
@@ -270,16 +263,21 @@ static void __devinit init_hwif_amd74xx(
 	}
 }
 
+#define IDE_HFLAGS_AMD \
+	(IDE_HFLAG_PIO_NO_BLACKLIST | \
+	 IDE_HFLAG_PIO_NO_DOWNGRADE | \
+	 IDE_HFLAG_POST_SET_MODE | \
+	 IDE_HFLAG_IO_32BIT | \
+	 IDE_HFLAG_UNMASK_IRQS | \
+	 IDE_HFLAG_BOOTABLE)
+
 #define DECLARE_AMD_DEV(name_str)					\
 	{								\
 		.name		= name_str,				\
 		.init_chipset	= init_chipset_amd74xx,			\
 		.init_hwif	= init_hwif_amd74xx,			\
 		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},	\
-		.host_flags	= IDE_HFLAG_PIO_NO_BLACKLIST |		\
-				  IDE_HFLAG_PIO_NO_DOWNGRADE |		\
-				  IDE_HFLAG_POST_SET_MODE |		\
-				  IDE_HFLAG_BOOTABLE,			\
+		.host_flags	= IDE_HFLAGS_AMD,			\
 		.pio_mask	= ATA_PIO5,				\
 		.swdma_mask	= ATA_SWDMA2,				\
 		.mwdma_mask	= ATA_MWDMA2,				\
@@ -291,10 +289,7 @@ static void __devinit init_hwif_amd74xx(
 		.init_chipset	= init_chipset_amd74xx,			\
 		.init_hwif	= init_hwif_amd74xx,			\
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},	\
-		.host_flags	= IDE_HFLAG_PIO_NO_BLACKLIST |		\
-				  IDE_HFLAG_PIO_NO_DOWNGRADE |		\
-				  IDE_HFLAG_POST_SET_MODE |		\
-				  IDE_HFLAG_BOOTABLE,			\
+		.host_flags	= IDE_HFLAGS_AMD,			\
 		.pio_mask	= ATA_PIO5,				\
 		.swdma_mask	= ATA_SWDMA2,				\
 		.mwdma_mask	= ATA_MWDMA2,				\
Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -361,13 +361,6 @@ static void __devinit init_hwif_sl82c105
 	hwif->selectproc	= &sl82c105_selectproc;
 	hwif->resetproc 	= &sl82c105_resetproc;
 
-	/*
-	 * We support 32-bit I/O on this interface, and
-	 * it doesn't have problems with interrupts.
-	 */
-	hwif->drives[0].io_32bit = hwif->drives[1].io_32bit = 1;
-	hwif->drives[0].unmask   = hwif->drives[1].unmask   = 1;
-
 	if (!hwif->dma_base)
 		return;
 
@@ -399,7 +392,10 @@ static ide_pci_device_t sl82c105_chipset
 	.init_chipset	= init_chipset_sl82c105,
 	.init_hwif	= init_hwif_sl82c105,
 	.enablebits	= {{0x40,0x01,0x01}, {0x40,0x10,0x10}},
-	.host_flags	= IDE_HFLAG_NO_AUTODMA | IDE_HFLAG_BOOTABLE,
+	.host_flags	= IDE_HFLAG_IO_32BIT |
+			  IDE_HFLAG_UNMASK_IRQS |
+			  IDE_HFLAG_NO_AUTODMA |
+			  IDE_HFLAG_BOOTABLE,
 	.pio_mask	= ATA_PIO5,
 };
 
Index: b/drivers/ide/pci/via82cxxx.c
===================================================================
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -421,17 +421,9 @@ static u8 __devinit via82cxxx_cable_dete
 
 static void __devinit init_hwif_via82cxxx(ide_hwif_t *hwif)
 {
-	struct via82cxxx_dev *vdev = pci_get_drvdata(hwif->pci_dev);
-	int i;
-
 	hwif->set_pio_mode = &via_set_pio_mode;
 	hwif->set_dma_mode = &via_set_drive;
 
-	for (i = 0; i < 2; i++) {
-		hwif->drives[i].io_32bit = 1;
-		hwif->drives[i].unmask = (vdev->via_config->flags & VIA_NO_UNMASK) ? 0 : 1;
-	}
-
 	if (!hwif->dma_base)
 		return;
 
@@ -439,17 +431,20 @@ static void __devinit init_hwif_via82cxx
 		hwif->cbl = via82cxxx_cable_detect(hwif);
 }
 
+#define IDE_HFLAGS_VIA \
+	(IDE_HFLAG_PIO_NO_BLACKLIST | \
+	 IDE_HFLAG_PIO_NO_DOWNGRADE | \
+	 IDE_HFLAG_POST_SET_MODE | \
+	 IDE_HFLAG_IO_32BIT | \
+	 IDE_HFLAG_BOOTABLE)
+
 static ide_pci_device_t via82cxxx_chipsets[] __devinitdata = {
 	{	/* 0 */
 		.name		= "VP_IDE",
 		.init_chipset	= init_chipset_via82cxxx,
 		.init_hwif	= init_hwif_via82cxxx,
 		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
-		.host_flags	= IDE_HFLAG_PIO_NO_BLACKLIST |
-				  IDE_HFLAG_PIO_NO_DOWNGRADE |
-				  IDE_HFLAG_POST_SET_MODE |
-				  IDE_HFLAG_NO_AUTODMA |
-				  IDE_HFLAG_BOOTABLE,
+		.host_flags	= IDE_HFLAGS_VIA | IDE_HFLAG_NO_AUTODMA,
 		.pio_mask	= ATA_PIO5,
 		.swdma_mask	= ATA_SWDMA2,
 		.mwdma_mask	= ATA_MWDMA2,
@@ -458,10 +453,7 @@ static ide_pci_device_t via82cxxx_chipse
 		.init_chipset	= init_chipset_via82cxxx,
 		.init_hwif	= init_hwif_via82cxxx,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		.host_flags	= IDE_HFLAG_PIO_NO_BLACKLIST |
-				  IDE_HFLAG_PIO_NO_DOWNGRADE |
-				  IDE_HFLAG_POST_SET_MODE |
-				  IDE_HFLAG_BOOTABLE,
+		.host_flags	= IDE_HFLAGS_VIA,
 		.pio_mask	= ATA_PIO5,
 		.swdma_mask	= ATA_SWDMA2,
 		.mwdma_mask	= ATA_MWDMA2,
@@ -484,6 +476,11 @@ static int __devinit via_init_one(struct
 		return -ENODEV;
 	}
 
+	if (via_config->flags & VIA_NO_UNMASK)
+		d->host_flags &= ~IDE_HFLAG_UNMASK_IRQS;
+	else
+		d->host_flags |= IDE_HFLAG_UNMASK_IRQS;
+
 #ifdef CONFIG_PPC_CHRP
 	if (machine_is(chrp) && _chrp_type == _CHRP_Pegasos)
 		d->host_flags |= IDE_HFLAG_FORCE_LEGACY_IRQS;
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -573,6 +573,16 @@ void ide_pci_setup_ports(struct pci_dev 
 		if ((d->host_flags & IDE_HFLAG_SERIALIZE) && hwif->mate)
 			hwif->mate->serialized = hwif->serialized = 1;
 
+		if (d->host_flags & IDE_HFLAG_IO_32BIT) {
+			hwif->drives[0].io_32bit = 1;
+			hwif->drives[1].io_32bit = 1;
+		}
+
+		if (d->host_flags & IDE_HFLAG_UNMASK_IRQS) {
+			hwif->drives[0].unmask = 1;
+			hwif->drives[1].unmask = 1;
+		}
+
 		if (hwif->dma_base) {
 			hwif->swdma_mask = d->swdma_mask;
 			hwif->mwdma_mask = d->mwdma_mask;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1272,6 +1272,10 @@ enum {
 	IDE_HFLAG_FORCE_LEGACY_IRQS	= (1 << 22),
 	/* limit LBA48 requests to 256 sectors */
 	IDE_HFLAG_RQSIZE_256		= (1 << 23),
+	/* use 32-bit I/O ops */
+	IDE_HFLAG_IO_32BIT		= (1 << 24),
+	/* unmask IRQs */
+	IDE_HFLAG_UNMASK_IRQS		= (1 << 25),
 };
 
 #ifdef CONFIG_BLK_DEV_OFFBOARD
