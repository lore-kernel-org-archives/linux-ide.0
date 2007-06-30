From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 9/15] ide: add PIO masks
Date: Sat, 30 Jun 2007 21:07:42 +0200
Message-ID: <200706302107.42458.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:51203 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334AbXF3TAQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jun 2007 15:00:16 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1759210mue
        for <linux-ide@vger.kernel.org>; Sat, 30 Jun 2007 12:00:14 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Add ATA_PIO[0-6] defines to <linux/ata.h>.

* Add ->pio_mask field to ide_pci_device_t and ide_hwif_t.

* Add PIO masks to host drivers.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/cris/ide-cris.c    |    1 +
 drivers/ide/ide.c              |    2 ++
 drivers/ide/legacy/ali14xx.c   |    2 ++
 drivers/ide/legacy/dtc2278.c   |    1 +
 drivers/ide/legacy/ht6560b.c   |    2 ++
 drivers/ide/legacy/qd65xx.c    |    1 +
 drivers/ide/legacy/umc8672.c   |    2 ++
 drivers/ide/mips/au1xxx-ide.c  |    2 ++
 drivers/ide/pci/aec62xx.c      |    5 +++++
 drivers/ide/pci/alim15x3.c     |    1 +
 drivers/ide/pci/amd74xx.c      |    2 ++
 drivers/ide/pci/atiixp.c       |    2 ++
 drivers/ide/pci/cmd640.c       |    2 ++
 drivers/ide/pci/cmd64x.c       |    4 ++++
 drivers/ide/pci/cs5520.c       |    1 +
 drivers/ide/pci/cs5530.c       |    1 +
 drivers/ide/pci/cs5535.c       |    1 +
 drivers/ide/pci/cy82c693.c     |    1 +
 drivers/ide/pci/hpt34x.c       |    3 ++-
 drivers/ide/pci/hpt366.c       |   18 ++++++++++++------
 drivers/ide/pci/it8213.c       |    1 +
 drivers/ide/pci/it821x.c       |    3 ++-
 drivers/ide/pci/jmicron.c      |    1 +
 drivers/ide/pci/opti621.c      |    2 ++
 drivers/ide/pci/pdc202xx_new.c |    7 +++++++
 drivers/ide/pci/pdc202xx_old.c |    5 +++++
 drivers/ide/pci/piix.c         |    2 ++
 drivers/ide/pci/sc1200.c       |    1 +
 drivers/ide/pci/scc_pata.c     |    1 +
 drivers/ide/pci/serverworks.c  |    5 +++++
 drivers/ide/pci/sgiioc4.c      |    1 +
 drivers/ide/pci/siimage.c      |    1 +
 drivers/ide/pci/sis5513.c      |    1 +
 drivers/ide/pci/sl82c105.c     |    1 +
 drivers/ide/pci/slc90e66.c     |    1 +
 drivers/ide/pci/tc86c001.c     |    1 +
 drivers/ide/pci/triflex.c      |    1 +
 drivers/ide/pci/via82cxxx.c    |    2 ++
 drivers/ide/ppc/mpc8xx.c       |    2 ++
 drivers/ide/ppc/pmac.c         |    1 +
 drivers/ide/setup-pci.c        |    1 +
 include/linux/ata.h            |    9 +++++++++
 include/linux/ide.h            |    3 +++
 43 files changed, 99 insertions(+), 8 deletions(-)

Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -820,6 +820,7 @@ init_e100_ide (void)
 		hwif->dma_host_on = &cris_dma_on;
 		hwif->dma_off_quietly = &cris_dma_off;
 		hwif->cbl = ATA_CBL_PATA40;
+		hwif->pio_mask = ATA_PIO4,
 		hwif->ultra_mask = cris_ultra_mask;
 		hwif->mwdma_mask = 0x07; /* Multiword DMA 0-2 */
 		hwif->autodma = 1;
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -457,6 +457,8 @@ static void ide_hwif_restore(ide_hwif_t 
 
 	hwif->host_flags		= tmp_hwif->host_flags;
 
+	hwif->pio_mask			= tmp_hwif->pio_mask;
+
 	hwif->atapi_dma			= tmp_hwif->atapi_dma;
 	hwif->ultra_mask		= tmp_hwif->ultra_mask;
 	hwif->mwdma_mask		= tmp_hwif->mwdma_mask;
Index: b/drivers/ide/legacy/ali14xx.c
===================================================================
--- a/drivers/ide/legacy/ali14xx.c
+++ b/drivers/ide/legacy/ali14xx.c
@@ -211,10 +211,12 @@ static int __init ali14xx_probe(void)
 	mate = &ide_hwifs[1];
 
 	hwif->chipset = ide_ali14xx;
+	hwif->pio_mask = ATA_PIO4;
 	hwif->tuneproc = &ali14xx_tune_drive;
 	hwif->mate = mate;
 
 	mate->chipset = ide_ali14xx;
+	mate->pio_mask = ATA_PIO4;
 	mate->tuneproc = &ali14xx_tune_drive;
 	mate->mate = hwif;
 	mate->channel = 1;
Index: b/drivers/ide/legacy/dtc2278.c
===================================================================
--- a/drivers/ide/legacy/dtc2278.c
+++ b/drivers/ide/legacy/dtc2278.c
@@ -123,6 +123,7 @@ static int __init dtc2278_probe(void)
 
 	hwif->serialized = 1;
 	hwif->chipset = ide_dtc2278;
+	hwif->pio_mask = ATA_PIO4;
 	hwif->tuneproc = &tune_dtc2278;
 	hwif->drives[0].no_unmask = 1;
 	hwif->drives[1].no_unmask = 1;
Index: b/drivers/ide/legacy/ht6560b.c
===================================================================
--- a/drivers/ide/legacy/ht6560b.c
+++ b/drivers/ide/legacy/ht6560b.c
@@ -333,12 +333,14 @@ int __init ht6560b_init(void)
 
 	hwif->chipset = ide_ht6560b;
 	hwif->selectproc = &ht6560b_selectproc;
+	hwif->pio_mask = ATA_PIO5;
 	hwif->tuneproc = &tune_ht6560b;
 	hwif->serialized = 1;	/* is this needed? */
 	hwif->mate = mate;
 
 	mate->chipset = ide_ht6560b;
 	mate->selectproc = &ht6560b_selectproc;
+	mate->pio_mask = ATA_PIO5;
 	mate->tuneproc = &tune_ht6560b;
 	mate->serialized = 1;	/* is this needed? */
 	mate->mate = hwif;
Index: b/drivers/ide/legacy/qd65xx.c
===================================================================
--- a/drivers/ide/legacy/qd65xx.c
+++ b/drivers/ide/legacy/qd65xx.c
@@ -346,6 +346,7 @@ static void __init qd_setup(ide_hwif_t *
 	hwif->drives[1].drive_data = data1;
 	hwif->drives[0].io_32bit =
 	hwif->drives[1].io_32bit = 1;
+	hwif->pio_mask = ATA_PIO4;
 	hwif->tuneproc = tuneproc;
 	probe_hwif_init(hwif);
 }
Index: b/drivers/ide/legacy/umc8672.c
===================================================================
--- a/drivers/ide/legacy/umc8672.c
+++ b/drivers/ide/legacy/umc8672.c
@@ -149,10 +149,12 @@ static int __init umc8672_probe(void)
 	mate = &ide_hwifs[1];
 
 	hwif->chipset = ide_umc8672;
+	hwif->pio_mask = ATA_PIO4;
 	hwif->tuneproc = &tune_umc;
 	hwif->mate = mate;
 
 	mate->chipset = ide_umc8672;
+	mate->pio_mask = ATA_PIO4;
 	mate->tuneproc = &tune_umc;
 	mate->mate = hwif;
 	mate->channel = 1;
Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -692,6 +692,8 @@ static int au_ide_probe(struct device *d
 	hwif->swdma_mask                = 0x0;
 #endif
 
+	hwif->pio_mask = ATA_PIO4;
+
 	hwif->noprobe = 0;
 	hwif->drives[0].unmask          = 1;
 	hwif->drives[1].unmask          = 1;
Index: b/drivers/ide/pci/aec62xx.c
===================================================================
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -268,6 +268,7 @@ static ide_pci_device_t aec62xx_chipsets
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
 		.bootable	= OFF_BOARD,
+		.pio_mask	= ATA_PIO4,
 		.udma_mask	= 0x07, /* udma0-2 */
 	},{	/* 1 */
 		.name		= "AEC6260",
@@ -276,6 +277,7 @@ static ide_pci_device_t aec62xx_chipsets
 		.init_hwif	= init_hwif_aec62xx,
 		.autodma	= NOAUTODMA,
 		.bootable	= OFF_BOARD,
+		.pio_mask	= ATA_PIO4,
 		.udma_mask	= 0x1f, /* udma0-4 */
 	},{	/* 2 */
 		.name		= "AEC6260R",
@@ -285,6 +287,7 @@ static ide_pci_device_t aec62xx_chipsets
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
 		.bootable	= NEVER_BOARD,
+		.pio_mask	= ATA_PIO4,
 		.udma_mask	= 0x1f, /* udma0-4 */
 	},{	/* 3 */
 		.name		= "AEC6280",
@@ -293,6 +296,7 @@ static ide_pci_device_t aec62xx_chipsets
 		.init_hwif	= init_hwif_aec62xx,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
+		.pio_mask	= ATA_PIO4,
 		.udma_mask	= 0x3f, /* udma0-5 */
 	},{	/* 4 */
 		.name		= "AEC6280R",
@@ -302,6 +306,7 @@ static ide_pci_device_t aec62xx_chipsets
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
 		.bootable	= OFF_BOARD,
+		.pio_mask	= ATA_PIO4,
 		.udma_mask	= 0x3f, /* udma0-5 */
 	}
 };
Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -818,6 +818,7 @@ static ide_pci_device_t ali15x3_chipset 
 	.init_dma	= init_dma_ali15x3,
 	.autodma	= AUTODMA,
 	.bootable	= ON_BOARD,
+	.pio_mask	= ATA_PIO5,
 };
 
 /**
Index: b/drivers/ide/pci/amd74xx.c
===================================================================
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -457,6 +457,7 @@ static void __devinit init_hwif_amd74xx(
 		.bootable	= ON_BOARD,				\
 		.host_flags	= IDE_HFLAG_PIO_NO_BLACKLIST		\
 				| IDE_HFLAG_PIO_NO_DOWNGRADE,		\
+		.pio_mask	= ATA_PIO5,				\
 	}
 
 #define DECLARE_NV_DEV(name_str)					\
@@ -469,6 +470,7 @@ static void __devinit init_hwif_amd74xx(
 		.bootable	= ON_BOARD,				\
 		.host_flags	= IDE_HFLAG_PIO_NO_BLACKLIST		\
 				| IDE_HFLAG_PIO_NO_DOWNGRADE,		\
+		.pio_mask	= ATA_PIO5,				\
 	}
 
 static ide_pci_device_t amd74xx_chipsets[] __devinitdata = {
Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -294,6 +294,7 @@ static ide_pci_device_t atiixp_pci_info[
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x48,0x01,0x00}, {0x48,0x08,0x00}},
 		.bootable	= ON_BOARD,
+		.pio_mask	= ATA_PIO4,
 	},{	/* 1 */
 		.name		= "SB600_PATA",
 		.init_hwif	= init_hwif_atiixp,
@@ -301,6 +302,7 @@ static ide_pci_device_t atiixp_pci_info[
 		.enablebits	= {{0x48,0x01,0x00}, {0x00,0x00,0x00}},
  		.bootable	= ON_BOARD,
  		.host_flags	= IDE_HFLAG_SINGLE,
+		.pio_mask	= ATA_PIO4,
  	},
 };
 
Index: b/drivers/ide/pci/cmd640.c
===================================================================
--- a/drivers/ide/pci/cmd640.c
+++ b/drivers/ide/pci/cmd640.c
@@ -766,6 +766,7 @@ int __init ide_probe_for_cmd640x (void)
 	       cmd_hwif0->name, 'a' + cmd640_chip_version - 1, bus_type, cfr);
 	cmd_hwif0->chipset = ide_cmd640;
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
+	cmd_hwif0->pio_mask = ATA_PIO5;
 	cmd_hwif0->tuneproc = &cmd640_tune_drive;
 #endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
 
@@ -821,6 +822,7 @@ int __init ide_probe_for_cmd640x (void)
 		cmd_hwif1->mate = cmd_hwif0;
 		cmd_hwif1->channel = 1;
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
+		cmd_hwif1->pio_mask = ATA_PIO5;
 		cmd_hwif1->tuneproc = &cmd640_tune_drive;
 #endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
 	}
Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -627,6 +627,7 @@ static ide_pci_device_t cmd64x_chipsets[
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x51,0x08,0x08}},
 		.bootable	= ON_BOARD,
+		.pio_mask	= ATA_PIO5,
 		.udma_mask	= 0x00, /* no udma */
 	},{	/* 1 */
 		.name		= "CMD646",
@@ -636,6 +637,7 @@ static ide_pci_device_t cmd64x_chipsets[
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
 		.bootable	= ON_BOARD,
+		.pio_mask	= ATA_PIO5,
 		.udma_mask	= 0x07, /* udma0-2 */
 	},{	/* 2 */
 		.name		= "CMD648",
@@ -645,6 +647,7 @@ static ide_pci_device_t cmd64x_chipsets[
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
 		.bootable	= ON_BOARD,
+		.pio_mask	= ATA_PIO5,
 		.udma_mask	= 0x1f, /* udma0-4 */
 	},{	/* 3 */
 		.name		= "CMD649",
@@ -654,6 +657,7 @@ static ide_pci_device_t cmd64x_chipsets[
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
 		.bootable	= ON_BOARD,
+		.pio_mask	= ATA_PIO5,
 		.udma_mask	= 0x3f, /* udma0-5 */
 	}
 };
Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -197,6 +197,7 @@ static void __devinit init_hwif_cs5520(i
 		.autodma	= AUTODMA,			\
 		.bootable	= ON_BOARD,			\
 		.host_flags	= IDE_HFLAG_ISA_PORTS,		\
+		.pio_mask	= ATA_PIO4,			\
 	}
 
 static ide_pci_device_t cyrix_chipsets[] __devinitdata = {
Index: b/drivers/ide/pci/cs5530.c
===================================================================
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -343,6 +343,7 @@ static ide_pci_device_t cs5530_chipset _
 	.init_hwif	= init_hwif_cs5530,
 	.autodma	= AUTODMA,
 	.bootable	= ON_BOARD,
+	.pio_mask	= ATA_PIO4,
 };
 
 static int __devinit cs5530_init_one(struct pci_dev *dev, const struct pci_device_id *id)
Index: b/drivers/ide/pci/cs5535.c
===================================================================
--- a/drivers/ide/pci/cs5535.c
+++ b/drivers/ide/pci/cs5535.c
@@ -231,6 +231,7 @@ static ide_pci_device_t cs5535_chipset _
 	.autodma	= AUTODMA,
 	.bootable	= ON_BOARD,
 	.host_flags	= IDE_HFLAG_SINGLE,
+	.pio_mask	= ATA_PIO4,
 };
 
 static int __devinit cs5535_init_one(struct pci_dev *dev,
Index: b/drivers/ide/pci/cy82c693.c
===================================================================
--- a/drivers/ide/pci/cy82c693.c
+++ b/drivers/ide/pci/cy82c693.c
@@ -486,6 +486,7 @@ static ide_pci_device_t cy82c693_chipset
 	.autodma	= AUTODMA,
 	.bootable	= ON_BOARD,
 	.host_flags	= IDE_HFLAG_SINGLE,
+	.pio_mask	= ATA_PIO4,
 };
 
 static int __devinit cy82c693_init_one(struct pci_dev *dev, const struct pci_device_id *id)
Index: b/drivers/ide/pci/hpt34x.c
===================================================================
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -177,7 +177,8 @@ static ide_pci_device_t hpt34x_chipset _
 	.init_hwif	= init_hwif_hpt34x,
 	.autodma	= NOAUTODMA,
 	.bootable	= NEVER_BOARD,
-	.extra		= 16
+	.extra		= 16,
+	.pio_mask	= ATA_PIO5,
 };
 
 static int __devinit hpt34x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -1548,7 +1548,8 @@ static ide_pci_device_t hpt366_chipsets[
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.bootable	= OFF_BOARD,
-		.extra		= 240
+		.extra		= 240,
+		.pio_mask	= ATA_PIO4,
 	},{	/* 1 */
 		.name		= "HPT372A",
 		.init_setup	= init_setup_hpt372a,
@@ -1559,7 +1560,8 @@ static ide_pci_device_t hpt366_chipsets[
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.udma_mask	= HPT372_ALLOW_ATA133_6 ? 0x7f : 0x3f,
 		.bootable	= OFF_BOARD,
-		.extra		= 240
+		.extra		= 240,
+		.pio_mask	= ATA_PIO4,
 	},{	/* 2 */
 		.name		= "HPT302",
 		.init_setup	= init_setup_hpt302,
@@ -1570,7 +1572,8 @@ static ide_pci_device_t hpt366_chipsets[
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.udma_mask	= HPT302_ALLOW_ATA133_6 ? 0x7f : 0x3f,
 		.bootable	= OFF_BOARD,
-		.extra		= 240
+		.extra		= 240,
+		.pio_mask	= ATA_PIO4,
 	},{	/* 3 */
 		.name		= "HPT371",
 		.init_setup	= init_setup_hpt371,
@@ -1581,7 +1584,8 @@ static ide_pci_device_t hpt366_chipsets[
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.udma_mask	= HPT371_ALLOW_ATA133_6 ? 0x7f : 0x3f,
 		.bootable	= OFF_BOARD,
-		.extra		= 240
+		.extra		= 240,
+		.pio_mask	= ATA_PIO4,
 	},{	/* 4 */
 		.name		= "HPT374",
 		.init_setup	= init_setup_hpt374,
@@ -1592,7 +1596,8 @@ static ide_pci_device_t hpt366_chipsets[
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.udma_mask	= 0x3f,
 		.bootable	= OFF_BOARD,
-		.extra		= 240
+		.extra		= 240,
+		.pio_mask	= ATA_PIO4,
 	},{	/* 5 */
 		.name		= "HPT372N",
 		.init_setup	= init_setup_hpt372n,
@@ -1603,7 +1608,8 @@ static ide_pci_device_t hpt366_chipsets[
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.udma_mask	= HPT372_ALLOW_ATA133_6 ? 0x7f : 0x3f,
 		.bootable	= OFF_BOARD,
-		.extra		= 240
+		.extra		= 240,
+		.pio_mask	= ATA_PIO4,
 	}
 };
 
Index: b/drivers/ide/pci/it8213.c
===================================================================
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -276,6 +276,7 @@ static void __devinit init_hwif_it8213(i
 		.enablebits	= {{0x41,0x80,0x80}}, \
 		.bootable	= ON_BOARD,		\
 		.host_flags	= IDE_HFLAG_SINGLE,	\
+		.pio_mask	= ATA_PIO4,		\
 	}
 
 static ide_pci_device_t it8213_chipsets[] __devinitdata = {
Index: b/drivers/ide/pci/it821x.c
===================================================================
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -721,7 +721,8 @@ static unsigned int __devinit init_chips
 		.init_hwif	= init_hwif_it821x,	\
 		.autodma	= AUTODMA,		\
 		.bootable	= ON_BOARD,		\
-		.fixup	 	= it821x_fixups		\
+		.fixup	 	= it821x_fixups,	\
+		.pio_mask	= ATA_PIO4,		\
 	}
 
 static ide_pci_device_t it821x_chipsets[] __devinitdata = {
Index: b/drivers/ide/pci/jmicron.c
===================================================================
--- a/drivers/ide/pci/jmicron.c
+++ b/drivers/ide/pci/jmicron.c
@@ -180,6 +180,7 @@ fallback:
 		.autodma	= AUTODMA,		\
 		.bootable	= ON_BOARD,		\
 		.enablebits	= { {0x40, 1, 1}, {0x40, 0x10, 0x10} }, \
+		.pio_mask	= ATA_PIO5,		\
 	}
 
 static ide_pci_device_t jmicron_chipsets[] __devinitdata = {
Index: b/drivers/ide/pci/opti621.c
===================================================================
--- a/drivers/ide/pci/opti621.c
+++ b/drivers/ide/pci/opti621.c
@@ -353,12 +353,14 @@ static ide_pci_device_t opti621_chipsets
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x45,0x80,0x00}, {0x40,0x08,0x00}},
 		.bootable	= ON_BOARD,
+		.pio_mask	= ATA_PIO3,
 	},{	/* 1 */
 		.name		= "OPTI621X",
 		.init_hwif	= init_hwif_opti621,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x45,0x80,0x00}, {0x40,0x08,0x00}},
 		.bootable	= ON_BOARD,
+		.pio_mask	= ATA_PIO3,
 	}
 };
 
Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -562,6 +562,7 @@ static ide_pci_device_t pdcnew_chipsets[
 		.init_hwif	= init_hwif_pdc202new,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
+		.pio_mask	= ATA_PIO4,
 		.udma_mask	= 0x3f, /* udma0-5 */
 	},{	/* 1 */
 		.name		= "PDC20269",
@@ -570,6 +571,7 @@ static ide_pci_device_t pdcnew_chipsets[
 		.init_hwif	= init_hwif_pdc202new,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
+		.pio_mask	= ATA_PIO4,
 		.udma_mask	= 0x7f, /* udma0-6*/
 	},{	/* 2 */
 		.name		= "PDC20270",
@@ -578,6 +580,7 @@ static ide_pci_device_t pdcnew_chipsets[
 		.init_hwif	= init_hwif_pdc202new,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
+		.pio_mask	= ATA_PIO4,
 		.udma_mask	= 0x3f, /* udma0-5 */
 	},{	/* 3 */
 		.name		= "PDC20271",
@@ -586,6 +589,7 @@ static ide_pci_device_t pdcnew_chipsets[
 		.init_hwif	= init_hwif_pdc202new,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
+		.pio_mask	= ATA_PIO4,
 		.udma_mask	= 0x7f, /* udma0-6*/
 	},{	/* 4 */
 		.name		= "PDC20275",
@@ -594,6 +598,7 @@ static ide_pci_device_t pdcnew_chipsets[
 		.init_hwif	= init_hwif_pdc202new,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
+		.pio_mask	= ATA_PIO4,
 		.udma_mask	= 0x7f, /* udma0-6*/
 	},{	/* 5 */
 		.name		= "PDC20276",
@@ -602,6 +607,7 @@ static ide_pci_device_t pdcnew_chipsets[
 		.init_hwif	= init_hwif_pdc202new,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
+		.pio_mask	= ATA_PIO4,
 		.udma_mask	= 0x7f, /* udma0-6*/
 	},{	/* 6 */
 		.name		= "PDC20277",
@@ -610,6 +616,7 @@ static ide_pci_device_t pdcnew_chipsets[
 		.init_hwif	= init_hwif_pdc202new,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
+		.pio_mask	= ATA_PIO4,
 		.udma_mask	= 0x7f, /* udma0-6*/
 	}
 };
Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -444,6 +444,7 @@ static ide_pci_device_t pdc202xx_chipset
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 		.extra		= 16,
+		.pio_mask	= ATA_PIO4,
 		.udma_mask	= 0x07, /* udma0-2 */
 	},{	/* 1 */
 		.name		= "PDC20262",
@@ -454,6 +455,7 @@ static ide_pci_device_t pdc202xx_chipset
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
+		.pio_mask	= ATA_PIO4,
 		.udma_mask	= 0x1f, /* udma0-4 */
 	},{	/* 2 */
 		.name		= "PDC20263",
@@ -464,6 +466,7 @@ static ide_pci_device_t pdc202xx_chipset
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
+		.pio_mask	= ATA_PIO4,
 		.udma_mask	= 0x1f, /* udma0-4 */
 	},{	/* 3 */
 		.name		= "PDC20265",
@@ -474,6 +477,7 @@ static ide_pci_device_t pdc202xx_chipset
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
+		.pio_mask	= ATA_PIO4,
 		.udma_mask	= 0x3f, /* udma0-5 */
 	},{	/* 4 */
 		.name		= "PDC20267",
@@ -484,6 +488,7 @@ static ide_pci_device_t pdc202xx_chipset
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
+		.pio_mask	= ATA_PIO4,
 		.udma_mask	= 0x3f, /* udma0-5 */
 	}
 };
Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -498,6 +498,7 @@ static void __devinit init_hwif_piix(ide
 		.autodma	= AUTODMA,		\
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, \
 		.bootable	= ON_BOARD,		\
+		.pio_mask	= ATA_PIO4,		\
 		.udma_mask	= udma,			\
 	}
 
@@ -517,6 +518,7 @@ static ide_pci_device_t piix_pci_info[] 
 		.enablebits	= {{0x6d,0xc0,0x80}, {0x6d,0xc0,0xc0}},
 		.bootable	= ON_BOARD,
 		.host_flags	= IDE_HFLAG_ISA_PORTS,
+		.pio_mask	= ATA_PIO4,
 	},
 
 	/*  3 */ DECLARE_PIIX_DEV("PIIX3", 0x00),	/* no udma */
Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -438,6 +438,7 @@ static ide_pci_device_t sc1200_chipset _
 	.init_hwif	= init_hwif_sc1200,
 	.autodma	= AUTODMA,
 	.bootable	= ON_BOARD,
+	.pio_mask	= ATA_PIO4,
 };
 
 static int __devinit sc1200_init_one(struct pci_dev *dev, const struct pci_device_id *id)
Index: b/drivers/ide/pci/scc_pata.c
===================================================================
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -734,6 +734,7 @@ static void __devinit init_hwif_scc(ide_
       .autodma	= AUTODMA,				\
       .bootable	= ON_BOARD,				\
       .host_flags	= IDE_HFLAG_SINGLE,		\
+      .pio_mask		= ATA_PIO4,			\
   }
 
 static ide_pci_device_t scc_chipsets[] __devinitdata = {
Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -462,6 +462,7 @@ static ide_pci_device_t serverworks_chip
 		.init_hwif	= init_hwif_svwks,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
+		.pio_mask	= ATA_PIO4,
 	},{	/* 1 */
 		.name		= "SvrWks CSB5",
 		.init_setup	= init_setup_svwks,
@@ -469,6 +470,7 @@ static ide_pci_device_t serverworks_chip
 		.init_hwif	= init_hwif_svwks,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
+		.pio_mask	= ATA_PIO4,
 	},{	/* 2 */
 		.name		= "SvrWks CSB6",
 		.init_setup	= init_setup_csb6,
@@ -476,6 +478,7 @@ static ide_pci_device_t serverworks_chip
 		.init_hwif	= init_hwif_svwks,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
+		.pio_mask	= ATA_PIO4,
 	},{	/* 3 */
 		.name		= "SvrWks CSB6",
 		.init_setup	= init_setup_csb6,
@@ -484,6 +487,7 @@ static ide_pci_device_t serverworks_chip
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
 		.host_flags	= IDE_HFLAG_SINGLE,
+		.pio_mask	= ATA_PIO4,
 	},{	/* 4 */
 		.name		= "SvrWks HT1000",
 		.init_setup	= init_setup_svwks,
@@ -492,6 +496,7 @@ static ide_pci_device_t serverworks_chip
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
 		.host_flags	= IDE_HFLAG_SINGLE,
+		.pio_mask	= ATA_PIO4,
 	}
 };
 
Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -586,6 +586,7 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
 	hwif->ultra_mask = 0x0;	/* Disable Ultra DMA */
 	hwif->mwdma_mask = 0x2;	/* Multimode-2 DMA  */
 	hwif->swdma_mask = 0x2;
+	hwif->pio_mask = 0x00;
 	hwif->tuneproc = NULL;	/* Sets timing for PIO mode */
 	hwif->speedproc = NULL;	/* Sets timing for DMA &/or PIO modes */
 	hwif->selectproc = NULL;/* Use the default routine to select drive */
Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -982,6 +982,7 @@ static void __devinit init_hwif_siimage(
 		.fixup		= siimage_fixup,	\
 		.autodma	= AUTODMA,		\
 		.bootable	= ON_BOARD,		\
+		.pio_mask	= ATA_PIO4,		\
 	}
 
 static ide_pci_device_t siimage_chipsets[] __devinitdata = {
Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -885,6 +885,7 @@ static ide_pci_device_t sis5513_chipset 
 	.autodma	= NOAUTODMA,
 	.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
 	.bootable	= ON_BOARD,
+	.pio_mask	= ATA_PIO4,
 };
 
 static int __devinit sis5513_init_one(struct pci_dev *dev, const struct pci_device_id *id)
Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -458,6 +458,7 @@ static ide_pci_device_t sl82c105_chipset
 	.autodma	= NOAUTODMA,
 	.enablebits	= {{0x40,0x01,0x01}, {0x40,0x10,0x10}},
 	.bootable	= ON_BOARD,
+	.pio_mask	= ATA_PIO5,
 };
 
 static int __devinit sl82c105_init_one(struct pci_dev *dev, const struct pci_device_id *id)
Index: b/drivers/ide/pci/slc90e66.c
===================================================================
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -217,6 +217,7 @@ static ide_pci_device_t slc90e66_chipset
 	.autodma	= AUTODMA,
 	.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
 	.bootable	= ON_BOARD,
+	.pio_mask	= ATA_PIO4,
 };
 
 static int __devinit slc90e66_init_one(struct pci_dev *dev, const struct pci_device_id *id)
Index: b/drivers/ide/pci/tc86c001.c
===================================================================
--- a/drivers/ide/pci/tc86c001.c
+++ b/drivers/ide/pci/tc86c001.c
@@ -251,6 +251,7 @@ static ide_pci_device_t tc86c001_chipset
 	.autodma	= AUTODMA,
 	.bootable	= OFF_BOARD,
 	.host_flags	= IDE_HFLAG_SINGLE,
+	.pio_mask	= ATA_PIO4,
 };
 
 static int __devinit tc86c001_init_one(struct pci_dev *dev,
Index: b/drivers/ide/pci/triflex.c
===================================================================
--- a/drivers/ide/pci/triflex.c
+++ b/drivers/ide/pci/triflex.c
@@ -132,6 +132,7 @@ static ide_pci_device_t triflex_device _
 	.autodma	= AUTODMA,
 	.enablebits	= {{0x80, 0x01, 0x01}, {0x80, 0x02, 0x02}},
 	.bootable	= ON_BOARD,
+	.pio_mask	= ATA_PIO4,
 };
 
 static int __devinit triflex_init_one(struct pci_dev *dev, 
Index: b/drivers/ide/pci/via82cxxx.c
===================================================================
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -506,6 +506,7 @@ static ide_pci_device_t via82cxxx_chipse
 		.bootable	= ON_BOARD,
 		.host_flags	= IDE_HFLAG_PIO_NO_BLACKLIST
 				| IDE_HFLAG_PIO_NO_DOWNGRADE,
+		.pio_mask	= ATA_PIO5,
 	},{	/* 1 */
 		.name		= "VP_IDE",
 		.init_chipset	= init_chipset_via82cxxx,
@@ -515,6 +516,7 @@ static ide_pci_device_t via82cxxx_chipse
 		.bootable	= ON_BOARD,
 		.host_flags	= IDE_HFLAG_PIO_NO_BLACKLIST
 				| IDE_HFLAG_PIO_NO_DOWNGRADE,
+		.pio_mask	= ATA_PIO5,
 	}
 };
 
Index: b/drivers/ide/ppc/mpc8xx.c
===================================================================
--- a/drivers/ide/ppc/mpc8xx.c
+++ b/drivers/ide/ppc/mpc8xx.c
@@ -316,6 +316,7 @@ m8xx_ide_init_hwif_ports(hw_regs_t *hw, 
 	}
 
 	/* register routine to tune PIO mode */
+	ide_hwifs[data_port].pio_mask = ATA_PIO4;
 	ide_hwifs[data_port].tuneproc = m8xx_ide_tuneproc;
 
 	hw->ack_intr = (ide_ack_intr_t *) ide_interrupt_ack;
@@ -402,6 +403,7 @@ void m8xx_ide_init_hwif_ports (hw_regs_t
 	}
 
 	/* register routine to tune PIO mode */
+	ide_hwifs[data_port].pio_mask = ATA_PIO4;
 	ide_hwifs[data_port].tuneproc = m8xx_ide_tuneproc;
 
 	hw->ack_intr = (ide_ack_intr_t *) ide_interrupt_ack;
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1248,6 +1248,7 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
 	hwif->cbl = pmif->cable_80 ? ATA_CBL_PATA80 : ATA_CBL_PATA40;
 	hwif->drives[0].unmask = 1;
 	hwif->drives[1].unmask = 1;
+	hwif->pio_mask = ATA_PIO4;
 	hwif->tuneproc = pmac_ide_tuneproc;
 	if (pmif->kind == controller_un_ata6
 	    || pmif->kind == controller_k2_ata6
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -614,6 +614,7 @@ void ide_pci_setup_ports(struct pci_dev 
 			ide_hwif_setup_dma(dev, d, hwif);
 bypass_legacy_dma:
 		hwif->host_flags = d->host_flags;
+		hwif->pio_mask = d->pio_mask;
 
 		if (d->init_hwif)
 			/* Call chipset-specific routine
Index: b/include/linux/ata.h
===================================================================
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -64,6 +64,15 @@ enum {
 	ATA_ID_PROD_LEN		= 40,
 
 	ATA_PCI_CTL_OFS		= 2,
+
+	ATA_PIO0		= (1 << 0),
+	ATA_PIO1		= ATA_PIO0 | (1 << 1),
+	ATA_PIO2		= ATA_PIO1 | (1 << 2),
+	ATA_PIO3		= ATA_PIO2 | (1 << 3),
+	ATA_PIO4		= ATA_PIO3 | (1 << 4),
+	ATA_PIO5		= ATA_PIO4 | (1 << 5),
+	ATA_PIO6		= ATA_PIO5 | (1 << 6),
+
 	ATA_UDMA0		= (1 << 0),
 	ATA_UDMA1		= ATA_UDMA0 | (1 << 1),
 	ATA_UDMA2		= ATA_UDMA1 | (1 << 2),
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -683,6 +683,8 @@ typedef struct hwif_s {
 
 	u8 host_flags;
 
+	u8 pio_mask;
+
 	u8 atapi_dma;	/* host supports atapi_dma */
 	u8 ultra_mask;
 	u8 mwdma_mask;
@@ -1270,6 +1272,7 @@ typedef struct ide_pci_device_s {
 	unsigned int		extra;
 	struct ide_pci_device_s	*next;
 	u8			host_flags;
+	u8			pio_mask;
 	u8			udma_mask;
 } ide_pci_device_t;
 
