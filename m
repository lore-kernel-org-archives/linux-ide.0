From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/13] ide: add IDE_HFLAG_LEGACY_IRQS host flag
Date: Wed, 5 Sep 2007 23:54:03 +0200
Message-ID: <200709052354.03098.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:65431 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932144AbXIEV6z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Sep 2007 17:58:55 -0400
Received: by nf-out-0910.google.com with SMTP id f5so1828117nfh
        for <linux-ide@vger.kernel.org>; Wed, 05 Sep 2007 14:58:54 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Add IDE_HFLAG_LEGACY_IRQS host flag to tell ide_pci_setup_ports() to set
hwif->irq to legacy IRQ 14/15 (iff hwif->irq is not already set) and convert
atiixp, piix, serverworks, sis5513 and slc90e66 host drivers to use it.

While at it:

* In piix.c add IDE_HFLAGS_PIIX define and don't use ->init_hwif for MPIIX.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/atiixp.c      |    8 +++-----
 drivers/ide/pci/piix.c        |   24 ++++++++++--------------
 drivers/ide/pci/serverworks.c |   15 +++++++--------
 drivers/ide/pci/sis5513.c     |    6 ++----
 drivers/ide/pci/slc90e66.c    |    5 +----
 drivers/ide/setup-pci.c       |    3 +++
 include/linux/ide.h           |    2 ++
 7 files changed, 28 insertions(+), 35 deletions(-)

Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -172,9 +172,6 @@ static void __devinit init_hwif_atiixp(i
 	u8 ch = hwif->channel;
 	struct pci_dev *pdev = hwif->pci_dev;
 
-	if (!hwif->irq)
-		hwif->irq = ch ? 15 : 14;
-
 	hwif->set_pio_mode = &atiixp_set_pio_mode;
 	hwif->set_dma_mode = &atiixp_set_dma_mode;
 	hwif->drives[0].autotune = 1;
@@ -200,7 +197,7 @@ static ide_pci_device_t atiixp_pci_info[
 		.name		= "ATIIXP",
 		.init_hwif	= init_hwif_atiixp,
 		.enablebits	= {{0x48,0x01,0x00}, {0x48,0x08,0x00}},
-		.host_flags	= IDE_HFLAG_BOOTABLE,
+		.host_flags	= IDE_HFLAG_LEGACY_IRQS | IDE_HFLAG_BOOTABLE,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 		.udma_mask	= ATA_UDMA5,
@@ -208,7 +205,8 @@ static ide_pci_device_t atiixp_pci_info[
 		.name		= "SB600_PATA",
 		.init_hwif	= init_hwif_atiixp,
 		.enablebits	= {{0x48,0x01,0x00}, {0x00,0x00,0x00}},
- 		.host_flags	= IDE_HFLAG_SINGLE | IDE_HFLAG_BOOTABLE,
+ 		.host_flags	= IDE_HFLAG_SINGLE | IDE_HFLAG_LEGACY_IRQS |
+				  IDE_HFLAG_BOOTABLE,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 		.udma_mask	= ATA_UDMA5,
Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -341,16 +341,6 @@ static u8 __devinit piix_cable_detect(id
 
 static void __devinit init_hwif_piix(ide_hwif_t *hwif)
 {
-#ifndef CONFIG_IA64
-	if (!hwif->irq)
-		hwif->irq = hwif->channel ? 15 : 14;
-#endif /* CONFIG_IA64 */
-
-	if (hwif->pci_dev->device == PCI_DEVICE_ID_INTEL_82371MX) {
-		/* This is a painful system best to let it self tune for now */
-		return;
-	}
-
 	hwif->set_pio_mode = &piix_set_pio_mode;
 	hwif->set_dma_mode = &piix_set_dma_mode;
 
@@ -378,12 +368,18 @@ static void __devinit init_hwif_ich(ide_
 		hwif->ide_dma_clear_irq = &piix_dma_clear_irq;
 }
 
+#ifndef CONFIG_IA64
+ #define IDE_HFLAGS_PIIX (IDE_HFLAG_LEGACY_IRQS | IDE_HFLAG_BOOTABLE)
+#else
+ #define IDE_HFLAGS_PIIX IDE_HFLAG_BOOTABLE
+#endif
+
 #define DECLARE_PIIX_DEV(name_str, udma) \
 	{						\
 		.name		= name_str,		\
 		.init_hwif	= init_hwif_piix,	\
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, \
-		.host_flags	= IDE_HFLAG_BOOTABLE,	\
+		.host_flags	= IDE_HFLAGS_PIIX,	\
 		.pio_mask	= ATA_PIO4,		\
 		.swdma_mask	= ATA_SWDMA2_ONLY,	\
 		.mwdma_mask	= ATA_MWDMA12_ONLY,	\
@@ -396,7 +392,7 @@ static void __devinit init_hwif_ich(ide_
 		.init_chipset	= init_chipset_ich, \
 		.init_hwif	= init_hwif_ich, \
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, \
-		.host_flags	= IDE_HFLAG_BOOTABLE, \
+		.host_flags	= IDE_HFLAGS_PIIX, \
 		.pio_mask	= ATA_PIO4, \
 		.swdma_mask	= ATA_SWDMA2_ONLY, \
 		.mwdma_mask	= ATA_MWDMA12_ONLY, \
@@ -414,11 +410,11 @@ static ide_pci_device_t piix_pci_info[] 
 		 * of the bit 14 of the IDETIM register at offset 0x6c
 		 */
 		.name		= "MPIIX",
-		.init_hwif	= init_hwif_piix,
 		.enablebits	= {{0x6d,0xc0,0x80}, {0x6d,0xc0,0xc0}},
 		.host_flags	= IDE_HFLAG_ISA_PORTS | IDE_HFLAG_NO_DMA |
-				  IDE_HFLAG_BOOTABLE,
+				  IDE_HFLAGS_PIIX,
 		.pio_mask	= ATA_PIO4,
+		/* This is a painful system best to let it self tune for now */
 	},
 
 	/*  3 */ DECLARE_PIIX_DEV("PIIX3",	0x00),	/* no udma */
Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -359,9 +359,6 @@ static u8 __devinit ata66_svwks(ide_hwif
 
 static void __devinit init_hwif_svwks (ide_hwif_t *hwif)
 {
-	if (!hwif->irq)
-		hwif->irq = hwif->channel ? 15 : 14;
-
 	hwif->set_pio_mode = &svwks_set_pio_mode;
 	hwif->set_dma_mode = &svwks_set_dma_mode;
 	hwif->udma_filter = &svwks_udma_filter;
@@ -383,7 +380,7 @@ static ide_pci_device_t serverworks_chip
 		.name		= "SvrWks OSB4",
 		.init_chipset	= init_chipset_svwks,
 		.init_hwif	= init_hwif_svwks,
-		.host_flags	= IDE_HFLAG_BOOTABLE,
+		.host_flags	= IDE_HFLAG_LEGACY_IRQS | IDE_HFLAG_BOOTABLE,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 		.udma_mask	= 0x00, /* UDMA is problematic on OSB4 */
@@ -391,7 +388,7 @@ static ide_pci_device_t serverworks_chip
 		.name		= "SvrWks CSB5",
 		.init_chipset	= init_chipset_svwks,
 		.init_hwif	= init_hwif_svwks,
-		.host_flags	= IDE_HFLAG_BOOTABLE,
+		.host_flags	= IDE_HFLAG_LEGACY_IRQS | IDE_HFLAG_BOOTABLE,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 		.udma_mask	= ATA_UDMA5,
@@ -399,7 +396,7 @@ static ide_pci_device_t serverworks_chip
 		.name		= "SvrWks CSB6",
 		.init_chipset	= init_chipset_svwks,
 		.init_hwif	= init_hwif_svwks,
-		.host_flags	= IDE_HFLAG_BOOTABLE,
+		.host_flags	= IDE_HFLAG_LEGACY_IRQS | IDE_HFLAG_BOOTABLE,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 		.udma_mask	= ATA_UDMA5,
@@ -407,7 +404,8 @@ static ide_pci_device_t serverworks_chip
 		.name		= "SvrWks CSB6",
 		.init_chipset	= init_chipset_svwks,
 		.init_hwif	= init_hwif_svwks,
-		.host_flags	= IDE_HFLAG_SINGLE | IDE_HFLAG_BOOTABLE,
+		.host_flags	= IDE_HFLAG_LEGACY_IRQS | IDE_HFLAG_SINGLE |
+				  IDE_HFLAG_BOOTABLE,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 		.udma_mask	= ATA_UDMA5,
@@ -415,7 +413,8 @@ static ide_pci_device_t serverworks_chip
 		.name		= "SvrWks HT1000",
 		.init_chipset	= init_chipset_svwks,
 		.init_hwif	= init_hwif_svwks,
-		.host_flags	= IDE_HFLAG_SINGLE | IDE_HFLAG_BOOTABLE,
+		.host_flags	= IDE_HFLAG_LEGACY_IRQS | IDE_HFLAG_SINGLE |
+				  IDE_HFLAG_BOOTABLE,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 		.udma_mask	= ATA_UDMA5,
Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -564,9 +564,6 @@ static void __devinit init_hwif_sis5513 
 {
 	u8 udma_rates[] = { 0x00, 0x00, 0x07, 0x1f, 0x3f, 0x3f, 0x7f, 0x7f };
 
-	if (!hwif->irq)
-		hwif->irq = hwif->channel ? 15 : 14;
-
 	hwif->set_pio_mode = &sis_set_pio_mode;
 	hwif->set_dma_mode = &sis_set_dma_mode;
 
@@ -590,7 +587,8 @@ static ide_pci_device_t sis5513_chipset 
 	.init_chipset	= init_chipset_sis5513,
 	.init_hwif	= init_hwif_sis5513,
 	.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
-	.host_flags	= IDE_HFLAG_NO_AUTODMA | IDE_HFLAG_BOOTABLE,
+	.host_flags	= IDE_HFLAG_LEGACY_IRQS | IDE_HFLAG_NO_AUTODMA |
+			  IDE_HFLAG_BOOTABLE,
 	.pio_mask	= ATA_PIO4,
 	.mwdma_mask	= ATA_MWDMA2,
 };
Index: b/drivers/ide/pci/slc90e66.c
===================================================================
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -133,9 +133,6 @@ static void __devinit init_hwif_slc90e66
 	u8 reg47 = 0;
 	u8 mask = hwif->channel ? 0x01 : 0x02;  /* bit0:Primary */
 
-	if (!hwif->irq)
-		hwif->irq = hwif->channel ? 15 : 14;
-
 	hwif->set_pio_mode = &slc90e66_set_pio_mode;
 	hwif->set_dma_mode = &slc90e66_set_dma_mode;
 
@@ -156,7 +153,7 @@ static ide_pci_device_t slc90e66_chipset
 	.name		= "SLC90E66",
 	.init_hwif	= init_hwif_slc90e66,
 	.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
-	.host_flags	= IDE_HFLAG_BOOTABLE,
+	.host_flags	= IDE_HFLAG_LEGACY_IRQS | IDE_HFLAG_BOOTABLE,
 	.pio_mask	= ATA_PIO4,
 	.swdma_mask	= ATA_SWDMA2_ONLY,
 	.mwdma_mask	= ATA_MWDMA12_ONLY,
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -562,6 +562,9 @@ void ide_pci_setup_ports(struct pci_dev 
 		if ((d->host_flags & IDE_HFLAG_NO_DMA) == 0)
 			ide_hwif_setup_dma(dev, d, hwif);
 
+		if ((d->host_flags & IDE_HFLAG_LEGACY_IRQS) && hwif->irq == 0)
+			hwif->irq = port ? 15 : 14;
+
 		hwif->host_flags = d->host_flags;
 		hwif->pio_mask = d->pio_mask;
 
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1264,6 +1264,8 @@ enum {
 	IDE_HFLAG_ERROR_STOPS_FIFO	= (1 << 19),
 	/* serialize ports */
 	IDE_HFLAG_SERIALIZE		= (1 << 20),
+	/* use legacy IRQs */
+	IDE_HFLAG_LEGACY_IRQS		= (1 << 21),
 };
 
 #ifdef CONFIG_BLK_DEV_OFFBOARD
