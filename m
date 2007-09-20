From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: add ->mwdma_mask and ->swdma_mask to ide_pci_device_t (take 2)
Date: Fri, 21 Sep 2007 01:19:44 +0200
Message-ID: <200709210119.44354.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:39468 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbXITXRb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Sep 2007 19:17:31 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1064915mue
        for <linux-ide@vger.kernel.org>; Thu, 20 Sep 2007 16:17:29 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Add ->mwdma_mask and ->swdma_mask to ide_pci_device_t.

* Set ide_hwif_t DMA masks using DMA masks from ide_pci_device_t in
  setup-pci.c::ide_pci_setup_ports() (iff DMA base is valid and ->init_hwif
  method may still override them).

* Convert IDE PCI host drivers to use ide_pci_device_t DMA masks.

While at it:

* Use ATA_{UDMA,MWDMA,SWDMA}* defines.

* hpt34x.c: add separate ide_pci_device_t instances for HPT343 and HPT345.

* serverworks.c: fix DMA masks being set before checking DMA base.

v2:
* Add missing masks to DECLARE_GENERIC_PCI_DEV() macro.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
replacement patch for the one currently in IDE quilt tree

 drivers/ide/pci/aec62xx.c      |   18 +++++++------
 drivers/ide/pci/alim15x3.c     |   13 ++++-----
 drivers/ide/pci/amd74xx.c      |    9 ++++--
 drivers/ide/pci/atiixp.c       |    7 ++---
 drivers/ide/pci/cmd64x.c       |   13 +++++----
 drivers/ide/pci/cs5520.c       |    4 --
 drivers/ide/pci/cs5530.c       |    5 +--
 drivers/ide/pci/cs5535.c       |    5 +--
 drivers/ide/pci/cy82c693.c     |    5 +--
 drivers/ide/pci/generic.c      |   19 ++++++++------
 drivers/ide/pci/hpt34x.c       |   55 +++++++++++++++++++----------------------
 drivers/ide/pci/hpt366.c       |    9 ++++--
 drivers/ide/pci/it8213.c       |    7 ++---
 drivers/ide/pci/it821x.c       |    4 +-
 drivers/ide/pci/jmicron.c      |    5 +--
 drivers/ide/pci/opti621.c      |   10 ++-----
 drivers/ide/pci/pdc202xx_new.c |   24 ++++++++++-------
 drivers/ide/pci/pdc202xx_old.c |   18 +++++++------
 drivers/ide/pci/piix.c         |   54 +++++++++++++++++++---------------------
 drivers/ide/pci/sc1200.c       |    5 +--
 drivers/ide/pci/scc_pata.c     |   13 +++------
 drivers/ide/pci/serverworks.c  |   15 +++++++----
 drivers/ide/pci/sgiioc4.c      |    2 -
 drivers/ide/pci/siimage.c      |    5 +--
 drivers/ide/pci/sis5513.c      |    2 -
 drivers/ide/pci/sl82c105.c     |    2 -
 drivers/ide/pci/slc90e66.c     |    7 ++---
 drivers/ide/pci/tc86c001.c     |    5 +--
 drivers/ide/pci/triflex.c      |    8 +----
 drivers/ide/pci/via82cxxx.c    |    6 ++--
 drivers/ide/setup-pci.c        |    6 ++++
 include/linux/ide.h            |    2 +
 32 files changed, 185 insertions(+), 177 deletions(-)

Index: b/drivers/ide/pci/aec62xx.c
===================================================================
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -201,9 +201,6 @@ static void __devinit init_hwif_aec62xx(
 	if (hwif->dma_base == 0)
 		return;
 
-	hwif->ultra_mask = hwif->cds->udma_mask;
-	hwif->mwdma_mask = 0x07;
-
 	hwif->dma_lost_irq	= &aec62xx_dma_lost_irq;
 
 	if (dev->device == PCI_DEVICE_ID_ARTOP_ATP850UF) {
@@ -247,7 +244,8 @@ static ide_pci_device_t aec62xx_chipsets
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
 		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
-		.udma_mask	= 0x07, /* udma0-2 */
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA2,
 	},{	/* 1 */
 		.name		= "AEC6260",
 		.init_setup	= init_setup_aec62xx,
@@ -256,7 +254,8 @@ static ide_pci_device_t aec62xx_chipsets
 		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_NO_AUTODMA |
 				  IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
-		.udma_mask	= 0x1f, /* udma0-4 */
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA4,
 	},{	/* 2 */
 		.name		= "AEC6260R",
 		.init_setup	= init_setup_aec62xx,
@@ -265,7 +264,8 @@ static ide_pci_device_t aec62xx_chipsets
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
 		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA,
 		.pio_mask	= ATA_PIO4,
-		.udma_mask	= 0x1f, /* udma0-4 */
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA4,
 	},{	/* 3 */
 		.name		= "AEC6280",
 		.init_setup	= init_setup_aec6x80,
@@ -273,7 +273,8 @@ static ide_pci_device_t aec62xx_chipsets
 		.init_hwif	= init_hwif_aec62xx,
 		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
-		.udma_mask	= 0x3f, /* udma0-5 */
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA5,
 	},{	/* 4 */
 		.name		= "AEC6280R",
 		.init_setup	= init_setup_aec6x80,
@@ -282,7 +283,8 @@ static ide_pci_device_t aec62xx_chipsets
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
 		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
-		.udma_mask	= 0x3f, /* udma0-5 */
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA5,
 	}
 };
 
Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -684,16 +684,13 @@ static void __devinit init_hwif_common_a
 	if (m5229_revision <= 0x20)
 		hwif->ultra_mask = 0x00; /* no udma */
 	else if (m5229_revision < 0xC2)
-		hwif->ultra_mask = 0x07; /* udma0-2 */
+		hwif->ultra_mask = ATA_UDMA2;
 	else if (m5229_revision == 0xC2 || m5229_revision == 0xC3)
-		hwif->ultra_mask = 0x1f; /* udma0-4 */
+		hwif->ultra_mask = ATA_UDMA4;
 	else if (m5229_revision == 0xC4)
-		hwif->ultra_mask = 0x3f; /* udma0-5 */
+		hwif->ultra_mask = ATA_UDMA5;
 	else
-		hwif->ultra_mask = 0x7f; /* udma0-6 */
-
-	hwif->mwdma_mask = 0x07;
-	hwif->swdma_mask = 0x07;
+		hwif->ultra_mask = ATA_UDMA6;
 
 	hwif->dma_setup = &ali15x3_dma_setup;
 
@@ -779,6 +776,8 @@ static ide_pci_device_t ali15x3_chipset 
 	.init_dma	= init_dma_ali15x3,
 	.host_flags	= IDE_HFLAG_BOOTABLE,
 	.pio_mask	= ATA_PIO5,
+	.swdma_mask	= ATA_SWDMA2,
+	.mwdma_mask	= ATA_MWDMA2,
 };
 
 /**
Index: b/drivers/ide/pci/amd74xx.c
===================================================================
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -261,9 +261,8 @@ static void __devinit init_hwif_amd74xx(
 		return;
 
 	hwif->ultra_mask = amd_config->udma_mask;
-	hwif->mwdma_mask = 0x07;
-	if ((amd_config->flags & AMD_BAD_SWDMA) == 0)
-		hwif->swdma_mask = 0x07;
+	if (amd_config->flags & AMD_BAD_SWDMA)
+		hwif->swdma_mask = 0x00;
 
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT) {
 		if ((amd_80w >> hwif->channel) & 1)
@@ -284,6 +283,8 @@ static void __devinit init_hwif_amd74xx(
 				  IDE_HFLAG_POST_SET_MODE |		\
 				  IDE_HFLAG_BOOTABLE,			\
 		.pio_mask	= ATA_PIO5,				\
+		.swdma_mask	= ATA_SWDMA2,				\
+		.mwdma_mask	= ATA_MWDMA2,				\
 	}
 
 #define DECLARE_NV_DEV(name_str)					\
@@ -297,6 +298,8 @@ static void __devinit init_hwif_amd74xx(
 				  IDE_HFLAG_POST_SET_MODE |		\
 				  IDE_HFLAG_BOOTABLE,			\
 		.pio_mask	= ATA_PIO5,				\
+		.swdma_mask	= ATA_SWDMA2,				\
+		.mwdma_mask	= ATA_MWDMA2,				\
 	}
 
 static ide_pci_device_t amd74xx_chipsets[] __devinitdata = {
Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -183,9 +183,6 @@ static void __devinit init_hwif_atiixp(i
 	if (!hwif->dma_base)
 		return;
 
-	hwif->ultra_mask = 0x3f;
-	hwif->mwdma_mask = 0x07;
-
 	pci_read_config_byte(pdev, ATIIXP_IDE_UDMA_MODE + ch, &udma_mode);
 
 	if ((udma_mode & 0x07) >= 0x04 || (udma_mode & 0x70) >= 0x40)
@@ -205,12 +202,16 @@ static ide_pci_device_t atiixp_pci_info[
 		.enablebits	= {{0x48,0x01,0x00}, {0x48,0x08,0x00}},
 		.host_flags	= IDE_HFLAG_BOOTABLE,
 		.pio_mask	= ATA_PIO4,
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA5,
 	},{	/* 1 */
 		.name		= "SB600_PATA",
 		.init_hwif	= init_hwif_atiixp,
 		.enablebits	= {{0x48,0x01,0x00}, {0x00,0x00,0x00}},
  		.host_flags	= IDE_HFLAG_SINGLE | IDE_HFLAG_BOOTABLE,
 		.pio_mask	= ATA_PIO4,
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA5,
  	},
 };
 
Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -517,9 +517,6 @@ static void __devinit init_hwif_cmd64x(i
 	if (!hwif->dma_base)
 		return;
 
-	hwif->mwdma_mask = 0x07;
-	hwif->ultra_mask = hwif->cds->udma_mask;
-
 	/*
 	 * UltraDMA only supported on PCI646U and PCI646U2, which
 	 * correspond to revisions 0x03, 0x05 and 0x07 respectively.
@@ -586,6 +583,7 @@ static ide_pci_device_t cmd64x_chipsets[
 		.enablebits	= {{0x00,0x00,0x00}, {0x51,0x08,0x08}},
 		.host_flags	= IDE_HFLAG_ABUSE_PREFETCH | IDE_HFLAG_BOOTABLE,
 		.pio_mask	= ATA_PIO5,
+		.mwdma_mask	= ATA_MWDMA2,
 		.udma_mask	= 0x00, /* no udma */
 	},{	/* 1 */
 		.name		= "CMD646",
@@ -595,7 +593,8 @@ static ide_pci_device_t cmd64x_chipsets[
 		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
 		.host_flags	= IDE_HFLAG_ABUSE_PREFETCH | IDE_HFLAG_BOOTABLE,
 		.pio_mask	= ATA_PIO5,
-		.udma_mask	= 0x07, /* udma0-2 */
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA2,
 	},{	/* 2 */
 		.name		= "CMD648",
 		.init_setup	= init_setup_cmd64x,
@@ -604,7 +603,8 @@ static ide_pci_device_t cmd64x_chipsets[
 		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
 		.host_flags	= IDE_HFLAG_ABUSE_PREFETCH | IDE_HFLAG_BOOTABLE,
 		.pio_mask	= ATA_PIO5,
-		.udma_mask	= 0x1f, /* udma0-4 */
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA4,
 	},{	/* 3 */
 		.name		= "CMD649",
 		.init_setup	= init_setup_cmd64x,
@@ -613,7 +613,8 @@ static ide_pci_device_t cmd64x_chipsets[
 		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
 		.host_flags	= IDE_HFLAG_ABUSE_PREFETCH | IDE_HFLAG_BOOTABLE,
 		.pio_mask	= ATA_PIO5,
-		.udma_mask	= 0x3f, /* udma0-5 */
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA5,
 	}
 };
 
Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -129,10 +129,6 @@ static void __devinit init_hwif_cs5520(i
 	}
 
 	hwif->ide_dma_on = &cs5520_dma_on;
-
-	hwif->ultra_mask = 0;
-	hwif->swdma_mask = 0;
-	hwif->mwdma_mask = 0;
 }
 
 #define DECLARE_CS_DEV(name_str)				\
Index: b/drivers/ide/pci/cs5530.c
===================================================================
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -264,9 +264,6 @@ static void __devinit init_hwif_cs5530 (
 	if (hwif->dma_base == 0)
 		return;
 
-	hwif->ultra_mask = 0x07;
-	hwif->mwdma_mask = 0x07;
-
 	hwif->udma_filter = cs5530_udma_filter;
 }
 
@@ -276,6 +273,8 @@ static ide_pci_device_t cs5530_chipset _
 	.init_hwif	= init_hwif_cs5530,
 	.host_flags	= IDE_HFLAG_POST_SET_MODE | IDE_HFLAG_BOOTABLE,
 	.pio_mask	= ATA_PIO4,
+	.mwdma_mask	= ATA_MWDMA2,
+	.udma_mask	= ATA_UDMA2,
 };
 
 static int __devinit cs5530_init_one(struct pci_dev *dev, const struct pci_device_id *id)
Index: b/drivers/ide/pci/cs5535.c
===================================================================
--- a/drivers/ide/pci/cs5535.c
+++ b/drivers/ide/pci/cs5535.c
@@ -185,9 +185,6 @@ static void __devinit init_hwif_cs5535(i
 	if (hwif->dma_base == 0)
 		return;
 
-	hwif->ultra_mask = 0x1F;
-	hwif->mwdma_mask = 0x07;
-
 	hwif->cbl = cs5535_cable_detect(hwif->pci_dev);
 }
 
@@ -197,6 +194,8 @@ static ide_pci_device_t cs5535_chipset _
 	.host_flags	= IDE_HFLAG_SINGLE | IDE_HFLAG_POST_SET_MODE |
 			  IDE_HFLAG_BOOTABLE,
 	.pio_mask	= ATA_PIO4,
+	.mwdma_mask	= ATA_MWDMA2,
+	.udma_mask	= ATA_UDMA4,
 };
 
 static int __devinit cs5535_init_one(struct pci_dev *dev,
Index: b/drivers/ide/pci/cy82c693.c
===================================================================
--- a/drivers/ide/pci/cy82c693.c
+++ b/drivers/ide/pci/cy82c693.c
@@ -437,9 +437,6 @@ static void __devinit init_hwif_cy82c693
 		return;
 	}
 
-	hwif->mwdma_mask = 0x04;
-	hwif->swdma_mask = 0x04;
-
 	hwif->ide_dma_on = &cy82c693_ide_dma_on;
 }
 
@@ -463,6 +460,8 @@ static ide_pci_device_t cy82c693_chipset
 	.host_flags	= IDE_HFLAG_SINGLE | IDE_HFLAG_TRUST_BIOS_FOR_DMA |
 			  IDE_HFLAG_BOOTABLE,
 	.pio_mask	= ATA_PIO4,
+	.swdma_mask	= ATA_SWDMA2_ONLY,
+	.mwdma_mask	= ATA_MWDMA2_ONLY,
 };
 
 static int __devinit cy82c693_init_one(struct pci_dev *dev, const struct pci_device_id *id)
Index: b/drivers/ide/pci/generic.c
===================================================================
--- a/drivers/ide/pci/generic.c
+++ b/drivers/ide/pci/generic.c
@@ -65,13 +65,6 @@ static void __devinit init_hwif_generic 
 		default:
 			break;
 	}
-
-	if (!(hwif->dma_base))
-		return;
-
-	hwif->ultra_mask = 0x7f;
-	hwif->mwdma_mask = 0x07;
-	hwif->swdma_mask = 0x07;
 }
 
 #define DECLARE_GENERIC_PCI_DEV(name_str, dma_setting) \
@@ -81,6 +74,9 @@ static void __devinit init_hwif_generic 
 		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA | \
 				  dma_setting | \
 				  IDE_HFLAG_BOOTABLE, \
+		.swdma_mask	= ATA_SWDMA2, \
+		.mwdma_mask	= ATA_MWDMA2, \
+		.udma_mask	= ATA_UDMA6, \
 	}
 
 static ide_pci_device_t generic_chipsets[] __devinitdata = {
@@ -92,6 +88,9 @@ static ide_pci_device_t generic_chipsets
 		.enablebits	= {{0x43,0x08,0x08}, {0x47,0x08,0x08}},
 		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA |
 				  IDE_HFLAG_BOOTABLE,
+		.swdma_mask	= ATA_SWDMA2,
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA6,
 	},
 
 	/*  2 */ DECLARE_GENERIC_PCI_DEV("SAMURAI",	0),
@@ -108,6 +107,9 @@ static ide_pci_device_t generic_chipsets
 		.init_hwif	= init_hwif_generic,
 		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA |
 				  IDE_HFLAG_OFF_BOARD,
+		.swdma_mask	= ATA_SWDMA2,
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA6,
 	},
 
 	/* 11 */ DECLARE_GENERIC_PCI_DEV("Piccolo0102",	IDE_HFLAG_NO_AUTODMA),
@@ -119,6 +121,9 @@ static ide_pci_device_t generic_chipsets
 		.init_hwif	= init_hwif_generic,
 		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA |
 				  IDE_HFLAG_OFF_BOARD,
+		.swdma_mask	= ATA_SWDMA2,
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA6,
 	}
 };
 
Index: b/drivers/ide/pci/hpt34x.c
===================================================================
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -125,51 +125,48 @@ static unsigned int __devinit init_chips
 
 static void __devinit init_hwif_hpt34x(ide_hwif_t *hwif)
 {
-	u16 pcicmd = 0;
-
 	hwif->set_pio_mode = &hpt34x_set_pio_mode;
 	hwif->set_dma_mode = &hpt34x_set_mode;
 
 	hwif->drives[0].autotune = 1;
 	hwif->drives[1].autotune = 1;
+}
 
-	pci_read_config_word(hwif->pci_dev, PCI_COMMAND, &pcicmd);
-
-	if (!hwif->dma_base)
-		return;
-
+static ide_pci_device_t hpt34x_chipsets[] __devinitdata = {
+	{ /* 0 */
+		.name		= "HPT343",
+		.init_chipset	= init_chipset_hpt34x,
+		.init_hwif	= init_hwif_hpt34x,
+		.extra		= 16,
+		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA |
+				  IDE_HFLAG_NO_AUTODMA,
+		.pio_mask	= ATA_PIO5,
+	},
+	{ /* 1 */
+		.name		= "HPT345",
+		.init_chipset	= init_chipset_hpt34x,
+		.init_hwif	= init_hwif_hpt34x,
+		.extra		= 16,
+		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA |
+				  IDE_HFLAG_NO_AUTODMA |
+				  IDE_HFLAG_OFF_BOARD,
+		.pio_mask	= ATA_PIO5,
 #ifdef CONFIG_HPT34X_AUTODMA
-	if ((pcicmd & PCI_COMMAND_MEMORY) == 0)
-		return;
-
-	hwif->ultra_mask = 0x07;
-	hwif->mwdma_mask = 0x07;
-	hwif->swdma_mask = 0x07;
+		.swdma_mask	= ATA_SWDMA2,
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA2,
 #endif
-}
-
-static ide_pci_device_t hpt34x_chipset __devinitdata = {
-	.name		= "HPT34X",
-	.init_chipset	= init_chipset_hpt34x,
-	.init_hwif	= init_hwif_hpt34x,
-	.extra		= 16,
-	.host_flags	= IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_NO_AUTODMA,
-	.pio_mask	= ATA_PIO5,
+	}
 };
 
 static int __devinit hpt34x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &hpt34x_chipset;
-	static char *chipset_names[] = {"HPT343", "HPT345"};
+	ide_pci_device_t *d;
 	u16 pcicmd = 0;
 
 	pci_read_config_word(dev, PCI_COMMAND, &pcicmd);
 
-	d->name = chipset_names[(pcicmd & PCI_COMMAND_MEMORY) ? 1 : 0];
-	if (pcicmd & PCI_COMMAND_MEMORY)
-		d->host_flags |= IDE_HFLAG_OFF_BOARD;
-	else
-		d->host_flags &= ~IDE_HFLAG_OFF_BOARD;
+	d = &hpt34x_chipsets[(pcicmd & PCI_COMMAND_MEMORY) ? 1 : 0];
 
 	return ide_setup_pci_device(dev, d);
 }
Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -1277,9 +1277,6 @@ static void __devinit init_hwif_hpt366(i
 	if (hwif->dma_base == 0)
 		return;
 
-	hwif->ultra_mask = hwif->cds->udma_mask;
-	hwif->mwdma_mask = 0x07;
-
 	/*
 	 * The HPT37x uses the CBLID pins as outputs for MA15/MA16
 	 * address lines to access an external EEPROM.  To read valid
@@ -1536,6 +1533,7 @@ static ide_pci_device_t hpt366_chipsets[
 		.extra		= 240,
 		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
+		.mwdma_mask	= ATA_MWDMA2,
 	},{	/* 1 */
 		.name		= "HPT372A",
 		.init_setup	= init_setup_hpt372a,
@@ -1547,6 +1545,7 @@ static ide_pci_device_t hpt366_chipsets[
 		.extra		= 240,
 		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
+		.mwdma_mask	= ATA_MWDMA2,
 	},{	/* 2 */
 		.name		= "HPT302",
 		.init_setup	= init_setup_hpt302,
@@ -1558,6 +1557,7 @@ static ide_pci_device_t hpt366_chipsets[
 		.extra		= 240,
 		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
+		.mwdma_mask	= ATA_MWDMA2,
 	},{	/* 3 */
 		.name		= "HPT371",
 		.init_setup	= init_setup_hpt371,
@@ -1569,6 +1569,7 @@ static ide_pci_device_t hpt366_chipsets[
 		.extra		= 240,
 		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
+		.mwdma_mask	= ATA_MWDMA2,
 	},{	/* 4 */
 		.name		= "HPT374",
 		.init_setup	= init_setup_hpt374,
@@ -1580,6 +1581,7 @@ static ide_pci_device_t hpt366_chipsets[
 		.extra		= 240,
 		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
+		.mwdma_mask	= ATA_MWDMA2,
 	},{	/* 5 */
 		.name		= "HPT372N",
 		.init_setup	= init_setup_hpt372n,
@@ -1591,6 +1593,7 @@ static ide_pci_device_t hpt366_chipsets[
 		.extra		= 240,
 		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
+		.mwdma_mask	= ATA_MWDMA2,
 	}
 };
 
Index: b/drivers/ide/pci/it8213.c
===================================================================
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -176,10 +176,6 @@ static void __devinit init_hwif_it8213(i
 	if (!hwif->dma_base)
 		return;
 
-	hwif->ultra_mask = 0x7f;
-	hwif->mwdma_mask = 0x06;
-	hwif->swdma_mask = 0x04;
-
 	pci_read_config_byte(hwif->pci_dev, 0x42, &reg42h);
 
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
@@ -195,6 +191,9 @@ static void __devinit init_hwif_it8213(i
 		.host_flags	= IDE_HFLAG_SINGLE |	\
 				  IDE_HFLAG_BOOTABLE,	\
 		.pio_mask	= ATA_PIO4,		\
+		.swdma_mask	= ATA_SWDMA2_ONLY,	\
+		.mwdma_mask	= ATA_MWDMA12_ONLY,	\
+		.udma_mask	= ATA_UDMA6,		\
 	}
 
 static ide_pci_device_t it8213_chipsets[] __devinitdata = {
Index: b/drivers/ide/pci/it821x.c
===================================================================
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -591,8 +591,8 @@ static void __devinit init_hwif_it821x(i
 	if (hwif->dma_base == 0)
 		return;
 
-	hwif->ultra_mask = 0x7f;
-	hwif->mwdma_mask = 0x07;
+	hwif->ultra_mask = ATA_UDMA6;
+	hwif->mwdma_mask = ATA_MWDMA2;
 
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 		hwif->cbl = ata66_it821x(hwif);
Index: b/drivers/ide/pci/jmicron.c
===================================================================
--- a/drivers/ide/pci/jmicron.c
+++ b/drivers/ide/pci/jmicron.c
@@ -117,9 +117,6 @@ static void __devinit init_hwif_jmicron(
 	if (hwif->dma_base == 0)
 		return;
 
-	hwif->ultra_mask = 0x7f;
-	hwif->mwdma_mask = 0x07;
-
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 		hwif->cbl = ata66_jmicron(hwif);
 }
@@ -131,6 +128,8 @@ static void __devinit init_hwif_jmicron(
 		.enablebits	= { {0x40, 1, 1}, {0x40, 0x10, 0x10} }, \
 		.host_flags	= IDE_HFLAG_BOOTABLE,	\
 		.pio_mask	= ATA_PIO5,		\
+		.mwdma_mask	= ATA_MWDMA2,		\
+		.udma_mask	= ATA_UDMA6,		\
 	}
 
 static ide_pci_device_t jmicron_chipsets[] __devinitdata = {
Index: b/drivers/ide/pci/opti621.c
===================================================================
--- a/drivers/ide/pci/opti621.c
+++ b/drivers/ide/pci/opti621.c
@@ -332,12 +332,6 @@ static void __devinit init_hwif_opti621 
 	hwif->drives[1].drive_data = PIO_DONT_KNOW;
 
 	hwif->set_pio_mode = &opti621_set_pio_mode;
-
-	if (!(hwif->dma_base))
-		return;
-
-	hwif->mwdma_mask = 0x07;
-	hwif->swdma_mask = 0x07;
 }
 
 static ide_pci_device_t opti621_chipsets[] __devinitdata = {
@@ -348,6 +342,8 @@ static ide_pci_device_t opti621_chipsets
 		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA |
 				  IDE_HFLAG_BOOTABLE,
 		.pio_mask	= ATA_PIO3,
+		.swdma_mask	= ATA_SWDMA2,
+		.mwdma_mask	= ATA_MWDMA2,
 	},{	/* 1 */
 		.name		= "OPTI621X",
 		.init_hwif	= init_hwif_opti621,
@@ -355,6 +351,8 @@ static ide_pci_device_t opti621_chipsets
 		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA |
 				  IDE_HFLAG_BOOTABLE,
 		.pio_mask	= ATA_PIO3,
+		.swdma_mask	= ATA_SWDMA2,
+		.mwdma_mask	= ATA_MWDMA2,
 	}
 };
 
Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -482,9 +482,6 @@ static void __devinit init_hwif_pdc202ne
 	if (hwif->dma_base == 0)
 		return;
 
-	hwif->ultra_mask = hwif->cds->udma_mask;
-	hwif->mwdma_mask = 0x07;
-
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 		hwif->cbl = pdcnew_cable_detect(hwif);
 }
@@ -553,7 +550,8 @@ static ide_pci_device_t pdcnew_chipsets[
 		.init_hwif	= init_hwif_pdc202new,
 		.host_flags	= IDE_HFLAG_POST_SET_MODE | IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
-		.udma_mask	= 0x3f, /* udma0-5 */
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA5,
 	},{	/* 1 */
 		.name		= "PDC20269",
 		.init_setup	= init_setup_pdcnew,
@@ -561,7 +559,8 @@ static ide_pci_device_t pdcnew_chipsets[
 		.init_hwif	= init_hwif_pdc202new,
 		.host_flags	= IDE_HFLAG_POST_SET_MODE | IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
-		.udma_mask	= 0x7f, /* udma0-6*/
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA6,
 	},{	/* 2 */
 		.name		= "PDC20270",
 		.init_setup	= init_setup_pdc20270,
@@ -569,7 +568,8 @@ static ide_pci_device_t pdcnew_chipsets[
 		.init_hwif	= init_hwif_pdc202new,
 		.host_flags	= IDE_HFLAG_POST_SET_MODE | IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
-		.udma_mask	= 0x3f, /* udma0-5 */
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA5,
 	},{	/* 3 */
 		.name		= "PDC20271",
 		.init_setup	= init_setup_pdcnew,
@@ -577,7 +577,8 @@ static ide_pci_device_t pdcnew_chipsets[
 		.init_hwif	= init_hwif_pdc202new,
 		.host_flags	= IDE_HFLAG_POST_SET_MODE | IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
-		.udma_mask	= 0x7f, /* udma0-6*/
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA6,
 	},{	/* 4 */
 		.name		= "PDC20275",
 		.init_setup	= init_setup_pdcnew,
@@ -585,7 +586,8 @@ static ide_pci_device_t pdcnew_chipsets[
 		.init_hwif	= init_hwif_pdc202new,
 		.host_flags	= IDE_HFLAG_POST_SET_MODE | IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
-		.udma_mask	= 0x7f, /* udma0-6*/
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA6,
 	},{	/* 5 */
 		.name		= "PDC20276",
 		.init_setup	= init_setup_pdc20276,
@@ -593,7 +595,8 @@ static ide_pci_device_t pdcnew_chipsets[
 		.init_hwif	= init_hwif_pdc202new,
 		.host_flags	= IDE_HFLAG_POST_SET_MODE | IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
-		.udma_mask	= 0x7f, /* udma0-6*/
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA6,
 	},{	/* 6 */
 		.name		= "PDC20277",
 		.init_setup	= init_setup_pdcnew,
@@ -601,7 +604,8 @@ static ide_pci_device_t pdcnew_chipsets[
 		.init_hwif	= init_hwif_pdc202new,
 		.host_flags	= IDE_HFLAG_POST_SET_MODE | IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
-		.udma_mask	= 0x7f, /* udma0-6*/
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA6,
 	}
 };
 
Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -324,9 +324,6 @@ static void __devinit init_hwif_pdc202xx
 	if (hwif->dma_base == 0)
 		return;
 
-	hwif->ultra_mask = hwif->cds->udma_mask;
-	hwif->mwdma_mask = 0x07;
-
 	hwif->dma_lost_irq = &pdc202xx_dma_lost_irq;
 	hwif->dma_timeout = &pdc202xx_dma_timeout;
 
@@ -420,7 +417,8 @@ static ide_pci_device_t pdc202xx_chipset
 		.extra		= 16,
 		.host_flags	= IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
-		.udma_mask	= 0x07, /* udma0-2 */
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA2,
 	},{	/* 1 */
 		.name		= "PDC20262",
 		.init_setup	= init_setup_pdc202ata4,
@@ -430,7 +428,8 @@ static ide_pci_device_t pdc202xx_chipset
 		.extra		= 48,
 		.host_flags	= IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
-		.udma_mask	= 0x1f, /* udma0-4 */
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA4,
 	},{	/* 2 */
 		.name		= "PDC20263",
 		.init_setup	= init_setup_pdc202ata4,
@@ -440,7 +439,8 @@ static ide_pci_device_t pdc202xx_chipset
 		.extra		= 48,
 		.host_flags	= IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
-		.udma_mask	= 0x1f, /* udma0-4 */
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA4,
 	},{	/* 3 */
 		.name		= "PDC20265",
 		.init_setup	= init_setup_pdc20265,
@@ -450,7 +450,8 @@ static ide_pci_device_t pdc202xx_chipset
 		.extra		= 48,
 		.host_flags	= IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
-		.udma_mask	= 0x3f, /* udma0-5 */
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA5,
 	},{	/* 4 */
 		.name		= "PDC20267",
 		.init_setup	= init_setup_pdc202xx,
@@ -460,7 +461,8 @@ static ide_pci_device_t pdc202xx_chipset
 		.extra		= 48,
 		.host_flags	= IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
-		.udma_mask	= 0x3f, /* udma0-5 */
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA5,
 	}
 };
 
Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -397,10 +397,6 @@ static void __devinit init_hwif_piix(ide
 	if (piix_is_ichx(hwif->pci_dev))
 		hwif->ide_dma_clear_irq = &piix_dma_clear_irq;
 
-	hwif->ultra_mask = hwif->cds->udma_mask;
-	hwif->mwdma_mask = 0x06;
-	hwif->swdma_mask = 0x04;
-
 	if (hwif->ultra_mask & 0x78) {
 		if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 			hwif->cbl = piix_cable_detect(hwif);
@@ -418,12 +414,14 @@ static void __devinit init_hwif_piix(ide
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, \
 		.host_flags	= IDE_HFLAG_BOOTABLE,	\
 		.pio_mask	= ATA_PIO4,		\
+		.swdma_mask	= ATA_SWDMA2_ONLY,	\
+		.mwdma_mask	= ATA_MWDMA12_ONLY,	\
 		.udma_mask	= udma,			\
 	}
 
 static ide_pci_device_t piix_pci_info[] __devinitdata = {
-	/*  0 */ DECLARE_PIIX_DEV("PIIXa", 0x00),	/* no udma */
-	/*  1 */ DECLARE_PIIX_DEV("PIIXb", 0x00),	/* no udma */
+	/*  0 */ DECLARE_PIIX_DEV("PIIXa",	0x00),	/* no udma */
+	/*  1 */ DECLARE_PIIX_DEV("PIIXb",	0x00),	/* no udma */
 
 	/*  2 */
 	{	/*
@@ -439,28 +437,28 @@ static ide_pci_device_t piix_pci_info[] 
 		.pio_mask	= ATA_PIO4,
 	},
 
-	/*  3 */ DECLARE_PIIX_DEV("PIIX3", 0x00),	/* no udma */
-	/*  4 */ DECLARE_PIIX_DEV("PIIX4", 0x07),	/* udma0-2 */
-	/*  5 */ DECLARE_PIIX_DEV("ICH0",  0x07),	/* udma0-2 */
-	/*  6 */ DECLARE_PIIX_DEV("PIIX4", 0x07),	/* udma0-2 */
-	/*  7 */ DECLARE_PIIX_DEV("ICH",   0x1f),	/* udma0-4 */
-	/*  8 */ DECLARE_PIIX_DEV("PIIX4", 0x1f),	/* udma0-4 */
-	/*  9 */ DECLARE_PIIX_DEV("PIIX4", 0x07),	/* udma0-2 */
-	/* 10 */ DECLARE_PIIX_DEV("ICH2",  0x3f),	/* udma0-5 */
-	/* 11 */ DECLARE_PIIX_DEV("ICH2M", 0x3f),	/* udma0-5 */
-	/* 12 */ DECLARE_PIIX_DEV("ICH3M", 0x3f),	/* udma0-5 */
-	/* 13 */ DECLARE_PIIX_DEV("ICH3",  0x3f),	/* udma0-5 */
-	/* 14 */ DECLARE_PIIX_DEV("ICH4",  0x3f),	/* udma0-5 */
-	/* 15 */ DECLARE_PIIX_DEV("ICH5",  0x3f),	/* udma0-5 */
-	/* 16 */ DECLARE_PIIX_DEV("C-ICH", 0x3f),	/* udma0-5 */
-	/* 17 */ DECLARE_PIIX_DEV("ICH4",  0x3f),	/* udma0-5 */
-	/* 18 */ DECLARE_PIIX_DEV("ICH5-SATA", 0x3f),	/* udma0-5 */
-	/* 19 */ DECLARE_PIIX_DEV("ICH5",  0x3f),	/* udma0-5 */
-	/* 20 */ DECLARE_PIIX_DEV("ICH6",  0x3f),	/* udma0-5 */
-	/* 21 */ DECLARE_PIIX_DEV("ICH7",  0x3f),	/* udma0-5 */
-	/* 22 */ DECLARE_PIIX_DEV("ICH4",  0x3f),	/* udma0-5 */
-	/* 23 */ DECLARE_PIIX_DEV("ESB2",  0x3f),	/* udma0-5 */
-	/* 24 */ DECLARE_PIIX_DEV("ICH8M", 0x3f),	/* udma0-5 */
+	/*  3 */ DECLARE_PIIX_DEV("PIIX3",	0x00),	/* no udma */
+	/*  4 */ DECLARE_PIIX_DEV("PIIX4",	ATA_UDMA2),
+	/*  5 */ DECLARE_PIIX_DEV("ICH0",	ATA_UDMA2),
+	/*  6 */ DECLARE_PIIX_DEV("PIIX4",	ATA_UDMA2),
+	/*  7 */ DECLARE_PIIX_DEV("ICH",	ATA_UDMA4),
+	/*  8 */ DECLARE_PIIX_DEV("PIIX4",	ATA_UDMA4),
+	/*  9 */ DECLARE_PIIX_DEV("PIIX4",	ATA_UDMA2),
+	/* 10 */ DECLARE_PIIX_DEV("ICH2",	ATA_UDMA5),
+	/* 11 */ DECLARE_PIIX_DEV("ICH2M",	ATA_UDMA5),
+	/* 12 */ DECLARE_PIIX_DEV("ICH3M",	ATA_UDMA5),
+	/* 13 */ DECLARE_PIIX_DEV("ICH3",	ATA_UDMA5),
+	/* 14 */ DECLARE_PIIX_DEV("ICH4",	ATA_UDMA5),
+	/* 15 */ DECLARE_PIIX_DEV("ICH5",	ATA_UDMA5),
+	/* 16 */ DECLARE_PIIX_DEV("C-ICH",	ATA_UDMA5),
+	/* 17 */ DECLARE_PIIX_DEV("ICH4",	ATA_UDMA5),
+	/* 18 */ DECLARE_PIIX_DEV("ICH5-SATA",	ATA_UDMA5),
+	/* 19 */ DECLARE_PIIX_DEV("ICH5",	ATA_UDMA5),
+	/* 20 */ DECLARE_PIIX_DEV("ICH6",	ATA_UDMA5),
+	/* 21 */ DECLARE_PIIX_DEV("ICH7",	ATA_UDMA5),
+	/* 22 */ DECLARE_PIIX_DEV("ICH4",	ATA_UDMA5),
+	/* 23 */ DECLARE_PIIX_DEV("ESB2",	ATA_UDMA5),
+	/* 24 */ DECLARE_PIIX_DEV("ICH8M",	ATA_UDMA5),
 };
 
 /**
Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -376,9 +376,6 @@ static void __devinit init_hwif_sc1200 (
 
 	hwif->udma_filter = sc1200_udma_filter;
 	hwif->ide_dma_end   = &sc1200_ide_dma_end;
-
-        hwif->ultra_mask = 0x07;
-        hwif->mwdma_mask = 0x07;
 }
 
 static ide_pci_device_t sc1200_chipset __devinitdata = {
@@ -387,6 +384,8 @@ static ide_pci_device_t sc1200_chipset _
 	.host_flags	= IDE_HFLAG_ABUSE_DMA_MODES | IDE_HFLAG_POST_SET_MODE |
 			  IDE_HFLAG_BOOTABLE,
 	.pio_mask	= ATA_PIO4,
+	.mwdma_mask	= ATA_MWDMA2,
+	.udma_mask	= ATA_UDMA2,
 };
 
 static int __devinit sc1200_init_one(struct pci_dev *dev, const struct pci_device_id *id)
Index: b/drivers/ide/pci/scc_pata.c
===================================================================
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -472,7 +472,7 @@ static u8 scc_udma_filter(ide_drive_t *d
 	if ((drive->media != ide_disk) && (mask & 0xE0)) {
 		printk(KERN_INFO "%s: limit %s to UDMA4\n",
 		       SCC_PATA_NAME, drive->name);
-		mask = 0x1F;
+		mask = ATA_UDMA4;
 	}
 
 	return mask;
@@ -686,13 +686,10 @@ static void __devinit init_hwif_scc(ide_
 	hwif->drives[0].autotune = IDE_TUNE_AUTO;
 	hwif->drives[1].autotune = IDE_TUNE_AUTO;
 
-	if (in_be32((void __iomem *)(hwif->config_data + 0xff0)) & CCKCTRL_ATACLKOEN) {
-		hwif->ultra_mask = 0x7f; /* 133MHz */
-	} else {
-		hwif->ultra_mask = 0x3f; /* 100MHz */
-	}
-	hwif->mwdma_mask = 0x00;
-	hwif->swdma_mask = 0x00;
+	if (in_be32((void __iomem *)(hwif->config_data + 0xff0)) & CCKCTRL_ATACLKOEN)
+		hwif->ultra_mask = ATA_UDMA6; /* 133MHz */
+	else
+		hwif->ultra_mask = ATA_UDMA5; /* 100MHz */
 
 	/* we support 80c cable only. */
 	hwif->cbl = ATA_CBL_PATA80;
Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -366,11 +366,6 @@ static void __devinit init_hwif_svwks (i
 	hwif->set_dma_mode = &svwks_set_dma_mode;
 	hwif->udma_filter = &svwks_udma_filter;
 
-	if (hwif->pci_dev->device != PCI_DEVICE_ID_SERVERWORKS_OSB4IDE)
-		hwif->ultra_mask = 0x3f;
-
-	hwif->mwdma_mask = 0x07;
-
 	hwif->drives[0].autotune = 1;
 	hwif->drives[1].autotune = 1;
 
@@ -415,6 +410,8 @@ static ide_pci_device_t serverworks_chip
 		.init_hwif	= init_hwif_svwks,
 		.host_flags	= IDE_HFLAG_BOOTABLE,
 		.pio_mask	= ATA_PIO4,
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= 0x00, /* UDMA is problematic on OSB4 */
 	},{	/* 1 */
 		.name		= "SvrWks CSB5",
 		.init_setup	= init_setup_svwks,
@@ -422,6 +419,8 @@ static ide_pci_device_t serverworks_chip
 		.init_hwif	= init_hwif_svwks,
 		.host_flags	= IDE_HFLAG_BOOTABLE,
 		.pio_mask	= ATA_PIO4,
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA5,
 	},{	/* 2 */
 		.name		= "SvrWks CSB6",
 		.init_setup	= init_setup_csb6,
@@ -429,6 +428,8 @@ static ide_pci_device_t serverworks_chip
 		.init_hwif	= init_hwif_svwks,
 		.host_flags	= IDE_HFLAG_BOOTABLE,
 		.pio_mask	= ATA_PIO4,
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA5,
 	},{	/* 3 */
 		.name		= "SvrWks CSB6",
 		.init_setup	= init_setup_csb6,
@@ -436,6 +437,8 @@ static ide_pci_device_t serverworks_chip
 		.init_hwif	= init_hwif_svwks,
 		.host_flags	= IDE_HFLAG_SINGLE | IDE_HFLAG_BOOTABLE,
 		.pio_mask	= ATA_PIO4,
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA5,
 	},{	/* 4 */
 		.name		= "SvrWks HT1000",
 		.init_setup	= init_setup_svwks,
@@ -443,6 +446,8 @@ static ide_pci_device_t serverworks_chip
 		.init_hwif	= init_hwif_svwks,
 		.host_flags	= IDE_HFLAG_SINGLE | IDE_HFLAG_BOOTABLE,
 		.pio_mask	= ATA_PIO4,
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA5,
 	}
 };
 
Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -591,7 +591,7 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
 	if (hwif->dma_base == 0)
 		return;
 
-	hwif->mwdma_mask = 0x04;
+	hwif->mwdma_mask = ATA_MWDMA2_ONLY;
 
 	hwif->dma_setup = &sgiioc4_ide_dma_setup;
 	hwif->dma_start = &sgiioc4_ide_dma_start;
Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -896,9 +896,6 @@ static void __devinit init_hwif_siimage(
 	if (hwif->dma_base == 0)
 		return;
 
-	hwif->ultra_mask = 0x7f;
-	hwif->mwdma_mask = 0x07;
-
 	if (is_sata(hwif))
 		hwif->host_flags |= IDE_HFLAG_NO_ATAPI_DMA;
 
@@ -921,6 +918,8 @@ static void __devinit init_hwif_siimage(
 		.fixup		= siimage_fixup,	\
 		.host_flags	= IDE_HFLAG_BOOTABLE,	\
 		.pio_mask	= ATA_PIO4,		\
+		.mwdma_mask	= ATA_MWDMA2,		\
+		.udma_mask	= ATA_UDMA6,		\
 	}
 
 static ide_pci_device_t siimage_chipsets[] __devinitdata = {
Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -580,7 +580,6 @@ static void __devinit init_hwif_sis5513 
 		return;
 
 	hwif->ultra_mask = udma_rates[chipset_family];
-	hwif->mwdma_mask = 0x07;
 
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 		hwif->cbl = ata66_sis5513(hwif);
@@ -593,6 +592,7 @@ static ide_pci_device_t sis5513_chipset 
 	.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
 	.host_flags	= IDE_HFLAG_NO_AUTODMA | IDE_HFLAG_BOOTABLE,
 	.pio_mask	= ATA_PIO4,
+	.mwdma_mask	= ATA_MWDMA2,
 };
 
 static int __devinit sis5513_init_one(struct pci_dev *dev, const struct pci_device_id *id)
Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -388,7 +388,7 @@ static void __devinit init_hwif_sl82c105
 		return;
 	}
 
-	hwif->mwdma_mask = 0x07;
+	hwif->mwdma_mask = ATA_MWDMA2;
 
 	hwif->ide_dma_on		= &sl82c105_ide_dma_on;
 	hwif->dma_off_quietly		= &sl82c105_dma_off_quietly;
Index: b/drivers/ide/pci/slc90e66.c
===================================================================
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -147,10 +147,6 @@ static void __devinit init_hwif_slc90e66
 	if (hwif->dma_base == 0)
 		return;
 
-	hwif->ultra_mask = 0x1f;
-	hwif->mwdma_mask = 0x06;
-	hwif->swdma_mask = 0x04;
-
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 		/* bit[0(1)]: 0:80, 1:40 */
 		hwif->cbl = (reg47 & mask) ? ATA_CBL_PATA40 : ATA_CBL_PATA80;
@@ -162,6 +158,9 @@ static ide_pci_device_t slc90e66_chipset
 	.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
 	.host_flags	= IDE_HFLAG_BOOTABLE,
 	.pio_mask	= ATA_PIO4,
+	.swdma_mask	= ATA_SWDMA2_ONLY,
+	.mwdma_mask	= ATA_MWDMA12_ONLY,
+	.udma_mask	= ATA_UDMA4,
 };
 
 static int __devinit slc90e66_init_one(struct pci_dev *dev, const struct pci_device_id *id)
Index: b/drivers/ide/pci/tc86c001.c
===================================================================
--- a/drivers/ide/pci/tc86c001.c
+++ b/drivers/ide/pci/tc86c001.c
@@ -198,9 +198,6 @@ static void __devinit init_hwif_tc86c001
 	/* Sector Count Register limit */
 	hwif->rqsize	 = 0xffff;
 
-	hwif->ultra_mask = 0x1f;
-	hwif->mwdma_mask = 0x07;
-
 	hwif->dma_start 	= &tc86c001_dma_start;
 
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT) {
@@ -229,6 +226,8 @@ static ide_pci_device_t tc86c001_chipset
 	.init_hwif	= init_hwif_tc86c001,
 	.host_flags	= IDE_HFLAG_SINGLE | IDE_HFLAG_OFF_BOARD,
 	.pio_mask	= ATA_PIO4,
+	.mwdma_mask	= ATA_MWDMA2,
+	.udma_mask	= ATA_UDMA4,
 };
 
 static int __devinit tc86c001_init_one(struct pci_dev *dev,
Index: b/drivers/ide/pci/triflex.c
===================================================================
--- a/drivers/ide/pci/triflex.c
+++ b/drivers/ide/pci/triflex.c
@@ -100,12 +100,6 @@ static void __devinit init_hwif_triflex(
 {
 	hwif->set_pio_mode = &triflex_set_pio_mode;
 	hwif->set_dma_mode = &triflex_set_mode;
-
-	if (hwif->dma_base == 0)
-		return;
-
-	hwif->mwdma_mask = 0x07;
-	hwif->swdma_mask = 0x07;
 }
 
 static ide_pci_device_t triflex_device __devinitdata = {
@@ -114,6 +108,8 @@ static ide_pci_device_t triflex_device _
 	.enablebits	= {{0x80, 0x01, 0x01}, {0x80, 0x02, 0x02}},
 	.host_flags	= IDE_HFLAG_BOOTABLE,
 	.pio_mask	= ATA_PIO4,
+	.swdma_mask	= ATA_SWDMA2,
+	.mwdma_mask	= ATA_MWDMA2,
 };
 
 static int __devinit triflex_init_one(struct pci_dev *dev, 
Index: b/drivers/ide/pci/via82cxxx.c
===================================================================
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -444,8 +444,6 @@ static void __devinit init_hwif_via82cxx
 		return;
 
 	hwif->ultra_mask = vdev->via_config->udma_mask;
-	hwif->mwdma_mask = 0x07;
-	hwif->swdma_mask = 0x07;
 
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 		hwif->cbl = via82cxxx_cable_detect(hwif);
@@ -463,6 +461,8 @@ static ide_pci_device_t via82cxxx_chipse
 				  IDE_HFLAG_NO_AUTODMA |
 				  IDE_HFLAG_BOOTABLE,
 		.pio_mask	= ATA_PIO5,
+		.swdma_mask	= ATA_SWDMA2,
+		.mwdma_mask	= ATA_MWDMA2,
 	},{	/* 1 */
 		.name		= "VP_IDE",
 		.init_chipset	= init_chipset_via82cxxx,
@@ -473,6 +473,8 @@ static ide_pci_device_t via82cxxx_chipse
 				  IDE_HFLAG_POST_SET_MODE |
 				  IDE_HFLAG_BOOTABLE,
 		.pio_mask	= ATA_PIO5,
+		.swdma_mask	= ATA_SWDMA2,
+		.mwdma_mask	= ATA_MWDMA2,
 	}
 };
 
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -567,6 +567,12 @@ void ide_pci_setup_ports(struct pci_dev 
 		hwif->host_flags = d->host_flags;
 		hwif->pio_mask = d->pio_mask;
 
+		if (hwif->dma_base) {
+			hwif->swdma_mask = d->swdma_mask;
+			hwif->mwdma_mask = d->mwdma_mask;
+			hwif->ultra_mask = d->udma_mask;
+		}
+
 		if (d->init_hwif)
 			/* Call chipset-specific routine
 			 * for each enabled hwif
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1282,6 +1282,8 @@ typedef struct ide_pci_device_s {
 	struct ide_pci_device_s	*next;
 	u32			host_flags;
 	u8			pio_mask;
+	u8			swdma_mask;
+	u8			mwdma_mask;
 	u8			udma_mask;
 } ide_pci_device_t;
 
