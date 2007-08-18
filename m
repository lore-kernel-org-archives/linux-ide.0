From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/7] ide: remove hwif->autodma and drive->autodma
Date: Sat, 18 Aug 2007 20:49:32 +0200
Message-ID: <200708182049.32350.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:65378 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757006AbXHRTTJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Aug 2007 15:19:09 -0400
Received: by fk-out-0910.google.com with SMTP id z23so797152fkz
        for <linux-ide@vger.kernel.org>; Sat, 18 Aug 2007 12:19:07 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* hpt34x.c: disable DMA masks for HPT345
  (hwif->autodma is zero so DMA won't be enabled anyway).

* trm290.c: disable IDE_HFLAG_TRUST_BIOS_FOR_DMA flag
  (hwif->autodma is zero so DMA won't be enabled anyway).

* Check noautodma global variable instead of drive->autodma in ide_tune_dma().

  This fixes handling of "ide=nodma" kernel parameter for icside, ide-cris,
  au1xxx-ide, pmac, it821x, jmicron, sgiioc4 and siimage host drivers.

* Remove hwif->autodma (it was not checked by IDE core code anyway) and
  drive->autodma (was set by all host drivers - except HPT345/TRM290 special
  cases - unless "ide=nodma" was used).

While at it:
- remove needless printk() from icside.c
- remove stale FIXME/comment from ide-probe.c
- don't force DMA off if PCI bus-mastering had to be enabled in setup-pci.c
  (this setting was always later over-ridden by host drivers anyway)

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/icside.c       |    8 --------
 drivers/ide/cris/ide-cris.c    |    3 ---
 drivers/ide/ide-dma.c          |    2 +-
 drivers/ide/ide-probe.c        |    9 ---------
 drivers/ide/ide.c              |    1 -
 drivers/ide/mips/au1xxx-ide.c  |    5 -----
 drivers/ide/pci/aec62xx.c      |    4 ----
 drivers/ide/pci/alim15x3.c     |    7 -------
 drivers/ide/pci/amd74xx.c      |    7 -------
 drivers/ide/pci/atiixp.c       |    7 -------
 drivers/ide/pci/cmd64x.c       |    4 ----
 drivers/ide/pci/cs5520.c       |    6 ------
 drivers/ide/pci/cs5530.c       |    6 ------
 drivers/ide/pci/cs5535.c       |    7 -------
 drivers/ide/pci/cy82c693.c     |    6 ------
 drivers/ide/pci/generic.c      |    5 -----
 drivers/ide/pci/hpt34x.c       |   10 +++-------
 drivers/ide/pci/hpt366.c       |    4 ----
 drivers/ide/pci/it8213.c       |   12 ------------
 drivers/ide/pci/it821x.c       |   22 +++++-----------------
 drivers/ide/pci/jmicron.c      |   12 ++----------
 drivers/ide/pci/ns87415.c      |    6 ------
 drivers/ide/pci/opti621.c      |    6 ------
 drivers/ide/pci/pdc202xx_new.c |    6 ------
 drivers/ide/pci/pdc202xx_old.c |    6 ------
 drivers/ide/pci/piix.c         |    8 --------
 drivers/ide/pci/sc1200.c       |    7 -------
 drivers/ide/pci/scc_pata.c     |    6 ------
 drivers/ide/pci/serverworks.c  |    6 ------
 drivers/ide/pci/sgiioc4.c      |    7 +------
 drivers/ide/pci/siimage.c      |   11 -----------
 drivers/ide/pci/sis5513.c      |    8 --------
 drivers/ide/pci/sl82c105.c     |    4 ----
 drivers/ide/pci/slc90e66.c     |    7 -------
 drivers/ide/pci/tc86c001.c     |    4 ----
 drivers/ide/pci/triflex.c      |    5 -----
 drivers/ide/pci/trm290.c       |    5 ++---
 drivers/ide/pci/via82cxxx.c    |    7 -------
 drivers/ide/ppc/pmac.c         |    3 ---
 drivers/ide/setup-pci.c        |    2 --
 include/linux/ide.h            |    2 --
 41 files changed, 14 insertions(+), 249 deletions(-)

Index: b/drivers/ide/arm/icside.c
===================================================================
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -415,8 +415,6 @@ static void icside_dma_lost_irq(ide_driv
 
 static void icside_dma_init(ide_hwif_t *hwif)
 {
-	printk("    %s: SG-DMA", hwif->name);
-
 	hwif->atapi_dma		= 1;
 	hwif->mwdma_mask	= 7; /* MW0..2 */
 	hwif->swdma_mask	= 7; /* SW0..2 */
@@ -424,7 +422,6 @@ static void icside_dma_init(ide_hwif_t *
 	hwif->dmatable_cpu	= NULL;
 	hwif->dmatable_dma	= 0;
 	hwif->set_dma_mode	= icside_set_dma_mode;
-	hwif->autodma		= 1;
 
 	hwif->dma_host_off	= icside_dma_host_off;
 	hwif->dma_off_quietly	= icside_dma_off_quietly;
@@ -437,11 +434,6 @@ static void icside_dma_init(ide_hwif_t *
 	hwif->ide_dma_test_irq	= icside_dma_test_irq;
 	hwif->dma_timeout	= icside_dma_timeout;
 	hwif->dma_lost_irq	= icside_dma_lost_irq;
-
-	hwif->drives[0].autodma = hwif->autodma;
-	hwif->drives[1].autodma = hwif->autodma;
-
-	printk(" capable%s\n", hwif->autodma ? ", auto-enable" : "");
 }
 #else
 #define icside_dma_init(hwif)	(0)
Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -810,9 +810,6 @@ init_e100_ide (void)
 		hwif->drives[1].autotune = 1;
 		hwif->ultra_mask = cris_ultra_mask;
 		hwif->mwdma_mask = 0x07; /* Multiword DMA 0-2 */
-		hwif->autodma = 1;
-		hwif->drives[0].autodma = 1;
-		hwif->drives[1].autodma = 1;
 	}
 
 	/* Reset pulse */
Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -754,7 +754,7 @@ static int ide_tune_dma(ide_drive_t *dri
 {
 	u8 speed;
 
-	if ((drive->id->capability & 1) == 0 || drive->autodma == 0)
+	if (noautodma || (drive->id->capability & 1) == 0)
 		return 0;
 
 	/* consult the list of known "bad" drives */
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -835,15 +835,6 @@ static void probe_hwif(ide_hwif_t *hwif,
 
 			drive->nice1 = 1;
 
-			/*
-			 * MAJOR HACK BARF :-/
-			 *
-			 * FIXME: chipsets own this cruft!
-			 */
-			/*
-			 * Move here to prevent module loading clashing.
-			 */
-	//		drive->autodma = hwif->autodma;
 			if (hwif->ide_dma_on) {
 				/*
 				 * Force DMAing for the beginning of the check.
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -460,7 +460,6 @@ static void ide_hwif_restore(ide_hwif_t 
 	hwif->select_data		= tmp_hwif->select_data;
 	hwif->extra_base		= tmp_hwif->extra_base;
 	hwif->extra_ports		= tmp_hwif->extra_ports;
-	hwif->autodma			= tmp_hwif->autodma;
 
 	hwif->hwif_data			= tmp_hwif->hwif_data;
 }
Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -700,19 +700,14 @@ static int au_ide_probe(struct device *d
 	hwif->dma_lost_irq		= &auide_dma_lost_irq;
 	hwif->ide_dma_on                = &auide_dma_on;
 
-	hwif->autodma                   = 1;
-	hwif->drives[0].autodma         = hwif->autodma;
-	hwif->drives[1].autodma         = hwif->autodma;
 	hwif->atapi_dma                 = 1;
 
 #else /* !CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA */
-	hwif->autodma                   = 0;
 	hwif->channel                   = 0;
 	hwif->hold                      = 1;
 	hwif->select_data               = 0;    /* no chipset-specific code */
 	hwif->config_data               = 0;    /* no chipset-specific code */
 
-	hwif->drives[0].autodma         = 0;
 	hwif->drives[0].autotune        = 1;    /* 1=autotune, 2=noautotune, 0=default */
 #endif
 	hwif->drives[0].no_io_32bit     = 1;   
Index: b/drivers/ide/pci/aec62xx.c
===================================================================
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -218,10 +218,6 @@ static void __devinit init_hwif_aec62xx(
 
 		hwif->cbl = (ata66 & mask) ? ATA_CBL_PATA40 : ATA_CBL_PATA80;
 	}
-
-	if (!noautodma)
-		hwif->autodma = 1;
-	hwif->drives[0].autodma = hwif->drives[1].autodma = hwif->autodma;
 }
 
 static int __devinit init_setup_aec62xx(struct pci_dev *dev, ide_pci_device_t *d)
Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -653,7 +653,6 @@ static u8 __devinit ata66_ali15x3(ide_hw
  
 static void __devinit init_hwif_common_ali15x3 (ide_hwif_t *hwif)
 {
-	hwif->autodma = 0;
 	hwif->set_pio_mode = &ali_set_pio_mode;
 	hwif->set_dma_mode = &ali_set_dma_mode;
 	hwif->udma_filter = &ali_udma_filter;
@@ -692,12 +691,6 @@ static void __devinit init_hwif_common_a
 
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 		hwif->cbl = ata66_ali15x3(hwif);
-
-	if (!noautodma)
-		hwif->autodma = 1;
-
-	hwif->drives[0].autodma = hwif->autodma;
-	hwif->drives[1].autodma = hwif->autodma;
 }
 
 /**
Index: b/drivers/ide/pci/amd74xx.c
===================================================================
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -376,8 +376,6 @@ static void __devinit init_hwif_amd74xx(
 	if (hwif->irq == 0) /* 0 is bogus but will do for now */
 		hwif->irq = pci_get_legacy_ide_irq(hwif->pci_dev, hwif->channel);
 
-	hwif->autodma = 0;
-
 	hwif->set_pio_mode = &amd_set_pio_mode;
 	hwif->set_dma_mode = &amd_set_drive;
 
@@ -404,11 +402,6 @@ static void __devinit init_hwif_amd74xx(
 		else
 			hwif->cbl = ATA_CBL_PATA40;
 	}
-
-        if (!noautodma)
-                hwif->autodma = 1;
-        hwif->drives[0].autodma = hwif->autodma;
-        hwif->drives[1].autodma = hwif->autodma;
 }
 
 #define DECLARE_AMD_DEV(name_str)					\
Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -175,7 +175,6 @@ static void __devinit init_hwif_atiixp(i
 	if (!hwif->irq)
 		hwif->irq = ch ? 15 : 14;
 
-	hwif->autodma = 0;
 	hwif->set_pio_mode = &atiixp_set_pio_mode;
 	hwif->set_dma_mode = &atiixp_set_dma_mode;
 	hwif->drives[0].autotune = 1;
@@ -197,12 +196,6 @@ static void __devinit init_hwif_atiixp(i
 
 	hwif->dma_host_on = &atiixp_dma_host_on;
 	hwif->dma_host_off = &atiixp_dma_host_off;
-
-	if (!noautodma)
-		hwif->autodma = 1;
-
-	hwif->drives[1].autodma = hwif->autodma;
-	hwif->drives[0].autodma = hwif->autodma;
 }
 
 
Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -559,10 +559,6 @@ static void __devinit init_hwif_cmd64x(i
 		hwif->ide_dma_test_irq	= &cmd64x_ide_dma_test_irq;
 		break;
 	}
-
-	if (!noautodma)
-		hwif->autodma = 1;
-	hwif->drives[0].autodma = hwif->drives[1].autodma = hwif->autodma;
 }
 
 static int __devinit init_setup_cmd64x(struct pci_dev *dev, ide_pci_device_t *d)
Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -146,12 +146,6 @@ static void __devinit init_hwif_cs5520(i
 	hwif->ultra_mask = 0;
 	hwif->swdma_mask = 0;
 	hwif->mwdma_mask = 0;
-
-	if (!noautodma)
-		hwif->autodma = 1;
-
-	hwif->drives[0].autodma = hwif->autodma;
-	hwif->drives[1].autodma = hwif->autodma;
 }
 
 #define DECLARE_CS_DEV(name_str)				\
Index: b/drivers/ide/pci/cs5530.c
===================================================================
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -244,7 +244,6 @@ static void __devinit init_hwif_cs5530 (
 {
 	unsigned long basereg;
 	u32 d0_timings;
-	hwif->autodma = 0;
 
 	if (hwif->mate)
 		hwif->serialized = hwif->mate->serialized = 1;
@@ -270,11 +269,6 @@ static void __devinit init_hwif_cs5530 (
 	hwif->mwdma_mask = 0x07;
 
 	hwif->udma_filter = cs5530_udma_filter;
-
-	if (!noautodma)
-		hwif->autodma = 1;
-	hwif->drives[0].autodma = hwif->autodma;
-	hwif->drives[1].autodma = hwif->autodma;
 }
 
 static ide_pci_device_t cs5530_chipset __devinitdata = {
Index: b/drivers/ide/pci/cs5535.c
===================================================================
--- a/drivers/ide/pci/cs5535.c
+++ b/drivers/ide/pci/cs5535.c
@@ -177,8 +177,6 @@ static u8 __devinit cs5535_cable_detect(
  */
 static void __devinit init_hwif_cs5535(ide_hwif_t *hwif)
 {
-	hwif->autodma = 0;
-
 	hwif->set_pio_mode = &cs5535_set_pio_mode;
 	hwif->set_dma_mode = &cs5535_set_dma_mode;
 
@@ -192,11 +190,6 @@ static void __devinit init_hwif_cs5535(i
 	hwif->mwdma_mask = 0x07;
 
 	hwif->cbl = cs5535_cable_detect(hwif->pci_dev);
-
-	if (!noautodma)
-		hwif->autodma = 1;
-
-	hwif->drives[1].autodma = hwif->drives[0].autodma = hwif->autodma;
 }
 
 static ide_pci_device_t cs5535_chipset __devinitdata = {
Index: b/drivers/ide/pci/cy82c693.c
===================================================================
--- a/drivers/ide/pci/cy82c693.c
+++ b/drivers/ide/pci/cy82c693.c
@@ -428,8 +428,6 @@ static unsigned int __devinit init_chips
  */
 static void __devinit init_hwif_cy82c693(ide_hwif_t *hwif)
 {
-	hwif->autodma = 0;
-
 	hwif->chipset = ide_cy82c693;
 	hwif->set_pio_mode = &cy82c693_set_pio_mode;
 
@@ -444,10 +442,6 @@ static void __devinit init_hwif_cy82c693
 	hwif->swdma_mask = 0x04;
 
 	hwif->ide_dma_on = &cy82c693_ide_dma_on;
-	if (!noautodma)
-		hwif->autodma = 1;
-	hwif->drives[0].autodma = hwif->autodma;
-	hwif->drives[1].autodma = hwif->autodma;
 }
 
 static __devinitdata ide_hwif_t *primary;
Index: b/drivers/ide/pci/generic.c
===================================================================
--- a/drivers/ide/pci/generic.c
+++ b/drivers/ide/pci/generic.c
@@ -73,11 +73,6 @@ static void __devinit init_hwif_generic 
 	hwif->ultra_mask = 0x7f;
 	hwif->mwdma_mask = 0x07;
 	hwif->swdma_mask = 0x07;
-
-	if (!noautodma)
-		hwif->autodma = 1;
-	hwif->drives[0].autodma = hwif->autodma;
-	hwif->drives[1].autodma = hwif->autodma;
 }
 
 #if 0
Index: b/drivers/ide/pci/hpt34x.c
===================================================================
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -127,8 +127,6 @@ static void __devinit init_hwif_hpt34x(i
 {
 	u16 pcicmd = 0;
 
-	hwif->autodma = 0;
-
 	hwif->set_pio_mode = &hpt34x_set_pio_mode;
 	hwif->set_dma_mode = &hpt34x_set_mode;
 
@@ -141,15 +139,13 @@ static void __devinit init_hwif_hpt34x(i
 		return;
 
 #ifdef CONFIG_HPT34X_AUTODMA
+	if ((pcicmd & PCI_COMMAND_MEMORY) == 0)
+		return;
+
 	hwif->ultra_mask = 0x07;
 	hwif->mwdma_mask = 0x07;
 	hwif->swdma_mask = 0x07;
 #endif
-
-	if (!noautodma)
-		hwif->autodma = (pcicmd & PCI_COMMAND_MEMORY) ? 1 : 0;
-	hwif->drives[0].autodma = hwif->autodma;
-	hwif->drives[1].autodma = hwif->autodma;
 }
 
 static ide_pci_device_t hpt34x_chipset __devinitdata = {
Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -1328,10 +1328,6 @@ static void __devinit init_hwif_hpt366(i
 		hwif->dma_timeout	= &hpt370_dma_timeout;
 	} else
 		hwif->dma_lost_irq	= &hpt366_dma_lost_irq;
-
-	if (!noautodma)
-		hwif->autodma = 1;
-	hwif->drives[0].autodma = hwif->drives[1].autodma = hwif->autodma;
 }
 
 static void __devinit init_dma_hpt366(ide_hwif_t *hwif, unsigned long dmabase)
Index: b/drivers/ide/pci/it8213.c
===================================================================
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -172,8 +172,6 @@ static void __devinit init_hwif_it8213(i
 	hwif->set_dma_mode = &it8213_set_dma_mode;
 	hwif->set_pio_mode = &it8213_set_pio_mode;
 
-	hwif->autodma = 0;
-
 	hwif->drives[0].autotune = 1;
 	hwif->drives[1].autotune = 1;
 
@@ -189,16 +187,6 @@ static void __devinit init_hwif_it8213(i
 
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 		hwif->cbl = (reg42h & 0x02) ? ATA_CBL_PATA40 : ATA_CBL_PATA80;
-
-	/*
-	 *	The BIOS often doesn't set up DMA on this controller
-	 *	so we always do it.
-	 */
-	if (!noautodma)
-		hwif->autodma = 1;
-
-	hwif->drives[0].autodma = hwif->autodma;
-	hwif->drives[1].autodma = hwif->autodma;
 }
 
 
Index: b/drivers/ide/pci/it821x.c
===================================================================
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -537,10 +537,11 @@ static void __devinit init_hwif_it821x(i
 	struct it821x_dev *idev = kzalloc(sizeof(struct it821x_dev), GFP_KERNEL);
 	u8 conf;
 
-	if(idev == NULL) {
+	if (idev == NULL) {
 		printk(KERN_ERR "it821x: out of memory, falling back to legacy behaviour.\n");
-		goto fallback;
+		return;
 	}
+
 	ide_set_hwifdata(hwif, idev);
 
 	hwif->atapi_dma = 1;
@@ -589,27 +590,14 @@ static void __devinit init_hwif_it821x(i
 	hwif->drives[0].autotune = 1;
 	hwif->drives[1].autotune = 1;
 
-	if (!hwif->dma_base)
-		goto fallback;
+	if (hwif->dma_base == 0)
+		return;
 
 	hwif->ultra_mask = 0x7f;
 	hwif->mwdma_mask = 0x07;
 
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 		hwif->cbl = ata66_it821x(hwif);
-
-	/*
-	 *	The BIOS often doesn't set up DMA on this controller
-	 *	so we always do it.
-	 */
-
-	hwif->autodma = 1;
-	hwif->drives[0].autodma = hwif->autodma;
-	hwif->drives[1].autodma = hwif->autodma;
-	return;
-fallback:
-	hwif->autodma = 0;
-	return;
 }
 
 static void __devinit it8212_disable_raid(struct pci_dev *dev)
Index: b/drivers/ide/pci/jmicron.c
===================================================================
--- a/drivers/ide/pci/jmicron.c
+++ b/drivers/ide/pci/jmicron.c
@@ -114,8 +114,8 @@ static void __devinit init_hwif_jmicron(
 	hwif->drives[0].autotune = 1;
 	hwif->drives[1].autotune = 1;
 
-	if (!hwif->dma_base)
-		goto fallback;
+	if (hwif->dma_base == 0)
+		return;
 
 	hwif->atapi_dma = 1;
 	hwif->ultra_mask = 0x7f;
@@ -123,14 +123,6 @@ static void __devinit init_hwif_jmicron(
 
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 		hwif->cbl = ata66_jmicron(hwif);
-
-	hwif->autodma = 1;
-	hwif->drives[0].autodma = hwif->autodma;
-	hwif->drives[1].autodma = hwif->autodma;
-	return;
-fallback:
-	hwif->autodma = 0;
-	return;
 }
 
 #define DECLARE_JMB_DEV(name_str)			\
Index: b/drivers/ide/pci/ns87415.c
===================================================================
--- a/drivers/ide/pci/ns87415.c
+++ b/drivers/ide/pci/ns87415.c
@@ -197,7 +197,6 @@ static void __devinit init_hwif_ns87415 
 	u8 stat;
 #endif
 
-	hwif->autodma = 0;
 	hwif->selectproc = &ns87415_selectproc;
 
 	/*
@@ -259,11 +258,6 @@ static void __devinit init_hwif_ns87415 
 	outb(0x60, hwif->dma_status);
 	hwif->dma_setup = &ns87415_ide_dma_setup;
 	hwif->ide_dma_end = &ns87415_ide_dma_end;
-
-	if (!noautodma)
-		hwif->autodma = 1;
-	hwif->drives[0].autodma = hwif->autodma;
-	hwif->drives[1].autodma = hwif->autodma;
 }
 
 static ide_pci_device_t ns87415_chipset __devinitdata = {
Index: b/drivers/ide/pci/opti621.c
===================================================================
--- a/drivers/ide/pci/opti621.c
+++ b/drivers/ide/pci/opti621.c
@@ -328,7 +328,6 @@ static void opti621_set_pio_mode(ide_dri
  */
 static void __devinit init_hwif_opti621 (ide_hwif_t *hwif)
 {
-	hwif->autodma = 0;
 	hwif->drives[0].drive_data = PIO_DONT_KNOW;
 	hwif->drives[1].drive_data = PIO_DONT_KNOW;
 
@@ -340,11 +339,6 @@ static void __devinit init_hwif_opti621 
 	hwif->atapi_dma = 1;
 	hwif->mwdma_mask = 0x07;
 	hwif->swdma_mask = 0x07;
-
-	if (!noautodma)
-		hwif->autodma = 1;
-	hwif->drives[0].autodma = hwif->autodma;
-	hwif->drives[1].autodma = hwif->autodma;
 }
 
 static ide_pci_device_t opti621_chipsets[] __devinitdata = {
Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -469,8 +469,6 @@ static unsigned int __devinit init_chips
 
 static void __devinit init_hwif_pdc202new(ide_hwif_t *hwif)
 {
-	hwif->autodma = 0;
-
 	hwif->set_pio_mode = &pdcnew_set_pio_mode;
 	hwif->set_dma_mode = &pdcnew_set_mode;
 
@@ -491,10 +489,6 @@ static void __devinit init_hwif_pdc202ne
 
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 		hwif->cbl = pdcnew_cable_detect(hwif);
-
-	if (!noautodma)
-		hwif->autodma = 1;
-	hwif->drives[0].autodma = hwif->drives[1].autodma = hwif->autodma;
 }
 
 static int __devinit init_setup_pdcnew(struct pci_dev *dev, ide_pci_device_t *d)
Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -312,8 +312,6 @@ static void __devinit init_hwif_pdc202xx
 	    (dev->device == PCI_DEVICE_ID_PROMISE_20265))
 		hwif->rqsize = 256;
 
-	hwif->autodma = 0;
-
 	hwif->set_pio_mode = &pdc202xx_set_pio_mode;
 	hwif->set_dma_mode = &pdc202xx_set_mode;
 
@@ -345,10 +343,6 @@ static void __devinit init_hwif_pdc202xx
 		hwif->ide_dma_end = &pdc202xx_old_ide_dma_end;
 	} 
 	hwif->ide_dma_test_irq = &pdc202xx_old_ide_dma_test_irq;
-
-	if (!noautodma)
-		hwif->autodma = 1;
-	hwif->drives[0].autodma = hwif->drives[1].autodma = hwif->autodma;
 }
 
 static void __devinit init_dma_pdc202xx(ide_hwif_t *hwif, unsigned long dmabase)
Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -384,8 +384,6 @@ static void __devinit init_hwif_piix(ide
 		return;
 	}
 
-	hwif->autodma = 0;
-
 	hwif->set_pio_mode = &piix_set_pio_mode;
 	hwif->set_dma_mode = &piix_set_dma_mode;
 
@@ -412,12 +410,6 @@ static void __devinit init_hwif_piix(ide
 
 	if (no_piix_dma)
 		hwif->ultra_mask = hwif->mwdma_mask = hwif->swdma_mask = 0;
-
-	if (!noautodma)
-		hwif->autodma = 1;
-
-	hwif->drives[1].autodma = hwif->autodma;
-	hwif->drives[0].autodma = hwif->autodma;
 }
 
 #define DECLARE_PIIX_DEV(name_str, udma) \
Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -364,7 +364,6 @@ static void __devinit init_hwif_sc1200 (
 {
 	if (hwif->mate)
 		hwif->serialized = hwif->mate->serialized = 1;
-	hwif->autodma = 0;
 
 	hwif->set_pio_mode = &sc1200_set_pio_mode;
 	hwif->set_dma_mode = &sc1200_set_dma_mode;
@@ -378,15 +377,9 @@ static void __devinit init_hwif_sc1200 (
 	hwif->udma_filter = sc1200_udma_filter;
 	hwif->ide_dma_end   = &sc1200_ide_dma_end;
 
-	if (!noautodma)
-		hwif->autodma = 1;
-
         hwif->atapi_dma = 1;
         hwif->ultra_mask = 0x07;
         hwif->mwdma_mask = 0x07;
-
-        hwif->drives[0].autodma = hwif->autodma;
-        hwif->drives[1].autodma = hwif->autodma;
 }
 
 static ide_pci_device_t sc1200_chipset __devinitdata = {
Index: b/drivers/ide/pci/scc_pata.c
===================================================================
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -697,12 +697,6 @@ static void __devinit init_hwif_scc(ide_
 
 	/* we support 80c cable only. */
 	hwif->cbl = ATA_CBL_PATA80;
-
-	hwif->autodma = 0;
-	if (!noautodma)
-		hwif->autodma = 1;
-	hwif->drives[0].autodma = hwif->autodma;
-	hwif->drives[1].autodma = hwif->autodma;
 }
 
 #define DECLARE_SCC_DEV(name_str)			\
Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -373,8 +373,6 @@ static void __devinit init_hwif_svwks (i
 
 	hwif->mwdma_mask = 0x07;
 
-	hwif->autodma = 0;
-
 	hwif->drives[0].autotune = 1;
 	hwif->drives[1].autotune = 1;
 
@@ -385,10 +383,6 @@ static void __devinit init_hwif_svwks (i
 		if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 			hwif->cbl = ata66_svwks(hwif);
 	}
-	if (!noautodma)
-		hwif->autodma = 1;
-
-	hwif->drives[0].autodma = hwif->drives[1].autodma = 1;
 }
 
 static int __devinit init_setup_svwks (struct pci_dev *dev, ide_pci_device_t *d)
Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -673,12 +673,7 @@ sgiioc4_ide_setup_pci_device(struct pci_
 	/* Initializing chipset IRQ Registers */
 	writel(0x03, (void __iomem *)(irqport + IOC4_INTR_SET * 4));
 
-	hwif->autodma = 0;
-
-	if (dma_base && ide_dma_sgiioc4(hwif, dma_base) == 0) {
-		hwif->autodma = 1;
-		hwif->drives[1].autodma = hwif->drives[0].autodma = 1;
-	} else
+	if (dma_base == 0 || ide_dma_sgiioc4(hwif, dma_base))
 		printk(KERN_INFO "%s: %s Bus-Master DMA disabled\n",
 				 hwif->name, DRV_NAME);
 
Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -873,8 +873,6 @@ static u8 __devinit ata66_siimage(ide_hw
 
 static void __devinit init_hwif_siimage(ide_hwif_t *hwif)
 {
-	hwif->autodma = 0;
-	
 	hwif->resetproc = &siimage_reset;
 	hwif->set_pio_mode = &sil_set_pio_mode;
 	hwif->set_dma_mode = &sil_set_dma_mode;
@@ -912,15 +910,6 @@ static void __devinit init_hwif_siimage(
 	} else {
 		hwif->ide_dma_test_irq = & siimage_io_ide_dma_test_irq;
 	}
-	
-	/*
-	 *	The BIOS often doesn't set up DMA on this controller
-	 *	so we always do it.
-	 */
-
-	hwif->autodma = 1;
-	hwif->drives[0].autodma = hwif->autodma;
-	hwif->drives[1].autodma = hwif->autodma;
 }
 
 #define DECLARE_SII_DEV(name_str)			\
Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -564,8 +564,6 @@ static void __devinit init_hwif_sis5513 
 {
 	u8 udma_rates[] = { 0x00, 0x00, 0x07, 0x1f, 0x3f, 0x3f, 0x7f, 0x7f };
 
-	hwif->autodma = 0;
-
 	if (!hwif->irq)
 		hwif->irq = hwif->channel ? 15 : 14;
 
@@ -588,12 +586,6 @@ static void __devinit init_hwif_sis5513 
 
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 		hwif->cbl = ata66_sis5513(hwif);
-
-	if (!noautodma)
-		hwif->autodma = 1;
-
-	hwif->drives[0].autodma = hwif->autodma;
-	hwif->drives[1].autodma = hwif->autodma;
 }
 
 static ide_pci_device_t sis5513_chipset __devinitdata = {
Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -397,10 +397,6 @@ static void __devinit init_hwif_sl82c105
 	hwif->dma_start			= &sl82c105_dma_start;
 	hwif->dma_timeout		= &sl82c105_dma_timeout;
 
-	if (!noautodma)
-		hwif->autodma = 1;
-	hwif->drives[0].autodma = hwif->drives[1].autodma = hwif->autodma;
-
 	if (hwif->mate)
 		hwif->serialized = hwif->mate->serialized = 1;
 }
Index: b/drivers/ide/pci/slc90e66.c
===================================================================
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -133,8 +133,6 @@ static void __devinit init_hwif_slc90e66
 	u8 reg47 = 0;
 	u8 mask = hwif->channel ? 0x01 : 0x02;  /* bit0:Primary */
 
-	hwif->autodma = 0;
-
 	if (!hwif->irq)
 		hwif->irq = hwif->channel ? 15 : 14;
 
@@ -157,11 +155,6 @@ static void __devinit init_hwif_slc90e66
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 		/* bit[0(1)]: 0:80, 1:40 */
 		hwif->cbl = (reg47 & mask) ? ATA_CBL_PATA40 : ATA_CBL_PATA80;
-
-	if (!noautodma)
-		hwif->autodma = 1;
-	hwif->drives[0].autodma = hwif->autodma;
-	hwif->drives[1].autodma = hwif->autodma;
 }
 
 static ide_pci_device_t slc90e66_chipset __devinitdata = {
Index: b/drivers/ide/pci/tc86c001.c
===================================================================
--- a/drivers/ide/pci/tc86c001.c
+++ b/drivers/ide/pci/tc86c001.c
@@ -212,10 +212,6 @@ static void __devinit init_hwif_tc86c001
 		scr1 = hwif->INW(sc_base + 0x00);
 		hwif->cbl = (scr1 & 0x2000) ? ATA_CBL_PATA40 : ATA_CBL_PATA80;
 	}
-
-	if (!noautodma)
-		hwif->autodma = 1;
-	hwif->drives[0].autodma = hwif->drives[1].autodma = hwif->autodma;
 }
 
 static unsigned int __devinit init_chipset_tc86c001(struct pci_dev *dev,
Index: b/drivers/ide/pci/triflex.c
===================================================================
--- a/drivers/ide/pci/triflex.c
+++ b/drivers/ide/pci/triflex.c
@@ -107,11 +107,6 @@ static void __devinit init_hwif_triflex(
 	hwif->atapi_dma  = 1;
 	hwif->mwdma_mask = 0x07;
 	hwif->swdma_mask = 0x07;
-	
-	if (!noautodma)
-		hwif->autodma = 1;
-	hwif->drives[0].autodma = hwif->autodma;
-	hwif->drives[1].autodma = hwif->autodma;
 }
 
 static ide_pci_device_t triflex_device __devinitdata = {
Index: b/drivers/ide/pci/trm290.c
===================================================================
--- a/drivers/ide/pci/trm290.c
+++ b/drivers/ide/pci/trm290.c
@@ -292,9 +292,6 @@ static void __devinit init_hwif_trm290(i
 	hwif->ide_dma_test_irq = &trm290_ide_dma_test_irq;
 
 	hwif->selectproc = &trm290_selectproc;
-	hwif->autodma = 0;		/* play it safe for now */
-	hwif->drives[0].autodma = hwif->autodma;
-	hwif->drives[1].autodma = hwif->autodma;
 #if 1
 	{
 	/*
@@ -329,7 +326,9 @@ static ide_pci_device_t trm290_chipset _
 	.init_hwif	= init_hwif_trm290,
 	.autodma	= NOAUTODMA,
 	.bootable	= ON_BOARD,
+#if 0 /* play it safe for now */
 	.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
+#endif
 };
 
 static int __devinit trm290_init_one(struct pci_dev *dev, const struct pci_device_id *id)
Index: b/drivers/ide/pci/via82cxxx.c
===================================================================
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -417,8 +417,6 @@ static void __devinit init_hwif_via82cxx
 	struct via82cxxx_dev *vdev = pci_get_drvdata(hwif->pci_dev);
 	int i;
 
-	hwif->autodma = 0;
-
 	hwif->set_pio_mode = &via_set_pio_mode;
 	hwif->set_dma_mode = &via_set_drive;
 
@@ -446,11 +444,6 @@ static void __devinit init_hwif_via82cxx
 
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 		hwif->cbl = via82cxxx_cable_detect(hwif);
-
-	if (!noautodma)
-		hwif->autodma = 1;
-	hwif->drives[0].autodma = hwif->autodma;
-	hwif->drives[1].autodma = hwif->autodma;
 }
 
 static ide_pci_device_t via82cxxx_chipsets[] __devinitdata = {
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1803,9 +1803,6 @@ pmac_ide_setup_dma(pmac_ide_hwif_t *pmif
 			hwif->swdma_mask = 0x00;
 			break;
 	}
-
-	hwif->autodma = 1;
-	hwif->drives[1].autodma = hwif->drives[0].autodma = hwif->autodma;
 }
 
 #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -438,8 +438,6 @@ static void ide_hwif_setup_dma(struct pc
  			 * Set up BM-DMA capability
 			 * (PnP BIOS should have done this)
  			 */
-			/* default DMA off if we had to configure it here */
-			hwif->autodma = 0;
 			pci_set_master(dev);
 			if (pci_read_config_word(dev, PCI_COMMAND, &pcicmd) || !(pcicmd & PCI_COMMAND_MASTER)) {
 				printk(KERN_ERR "%s: %s error updating PCICMD\n",
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -576,7 +576,6 @@ typedef struct ide_drive_s {
 	select_t	select;		/* basic drive/head select reg value */
 
 	u8	keep_settings;		/* restore settings after drive reset */
-	u8	autodma;		/* device can safely use dma on host */
 	u8	using_dma;		/* disk is using dma for read/write */
 	u8	retry_pio;		/* retrying dma capable host in pio */
 	u8	state;			/* retry state */
@@ -797,7 +796,6 @@ typedef struct hwif_s {
 	unsigned	serialized : 1;	/* serialized all channel operation */
 	unsigned	sharing_irq: 1;	/* 1 = sharing irq with another hwif */
 	unsigned	reset      : 1;	/* reset after probe */
-	unsigned	autodma    : 1;	/* auto-attempt using DMA at boot */
 	unsigned	no_lba48   : 1; /* 1 = cannot do LBA48 */
 	unsigned	no_lba48_dma : 1; /* 1 = cannot do LBA48 DMA */
 	unsigned	auto_poll  : 1; /* supports nop auto-poll */
