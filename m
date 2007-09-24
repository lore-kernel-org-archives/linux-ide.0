From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 9/9] ide: constify struct ide_port_info
Date: Mon, 24 Sep 2007 22:48:09 +0200
Message-ID: <200709242248.09814.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:29636 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048AbXIXUqS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Sep 2007 16:46:18 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1485942nfb
        for <linux-ide@vger.kernel.org>; Mon, 24 Sep 2007 13:46:17 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/aec62xx.c      |    2 +-
 drivers/ide/pci/alim15x3.c     |    2 +-
 drivers/ide/pci/amd74xx.c      |    4 ++--
 drivers/ide/pci/atiixp.c       |    2 +-
 drivers/ide/pci/cmd64x.c       |    2 +-
 drivers/ide/pci/cs5520.c       |    4 ++--
 drivers/ide/pci/cs5530.c       |    2 +-
 drivers/ide/pci/cs5535.c       |    2 +-
 drivers/ide/pci/cy82c693.c     |    2 +-
 drivers/ide/pci/generic.c      |    4 ++--
 drivers/ide/pci/hpt34x.c       |    4 ++--
 drivers/ide/pci/hpt366.c       |    2 +-
 drivers/ide/pci/it8213.c       |    2 +-
 drivers/ide/pci/it821x.c       |    2 +-
 drivers/ide/pci/jmicron.c      |    2 +-
 drivers/ide/pci/ns87415.c      |    2 +-
 drivers/ide/pci/opti621.c      |    2 +-
 drivers/ide/pci/pdc202xx_new.c |    4 ++--
 drivers/ide/pci/pdc202xx_old.c |    4 ++--
 drivers/ide/pci/piix.c         |    2 +-
 drivers/ide/pci/rz1000.c       |    2 +-
 drivers/ide/pci/sc1200.c       |    2 +-
 drivers/ide/pci/scc_pata.c     |    4 ++--
 drivers/ide/pci/serverworks.c  |    2 +-
 drivers/ide/pci/siimage.c      |    2 +-
 drivers/ide/pci/sis5513.c      |    2 +-
 drivers/ide/pci/sl82c105.c     |    2 +-
 drivers/ide/pci/slc90e66.c     |    2 +-
 drivers/ide/pci/tc86c001.c     |    2 +-
 drivers/ide/pci/triflex.c      |    2 +-
 drivers/ide/pci/trm290.c       |    2 +-
 drivers/ide/pci/via82cxxx.c    |    2 +-
 drivers/ide/setup-pci.c        |   28 ++++++++++++++--------------
 include/linux/ide.h            |   10 +++++-----
 34 files changed, 58 insertions(+), 58 deletions(-)

Index: b/drivers/ide/pci/aec62xx.c
===================================================================
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -194,7 +194,7 @@ static void __devinit init_hwif_aec62xx(
 	}
 }
 
-static struct ide_port_info aec62xx_chipsets[] __devinitdata = {
+static const struct ide_port_info aec62xx_chipsets[] __devinitdata = {
 	{	/* 0 */
 		.name		= "AEC6210",
 		.init_chipset	= init_chipset_aec62xx,
Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -746,7 +746,7 @@ static void __devinit init_dma_ali15x3 (
 	ide_setup_dma(hwif, dmabase, 8);
 }
 
-static struct ide_port_info ali15x3_chipset __devinitdata = {
+static const struct ide_port_info ali15x3_chipset __devinitdata = {
 	.name		= "ALI15X3",
 	.init_chipset	= init_chipset_ali15x3,
 	.init_hwif	= init_hwif_ali15x3,
Index: b/drivers/ide/pci/amd74xx.c
===================================================================
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -77,7 +77,7 @@ static struct amd_ide_chip {
 };
 
 static struct amd_ide_chip *amd_config;
-static struct ide_port_info *amd_chipset;
+static const struct ide_port_info *amd_chipset;
 static unsigned int amd_80w;
 static unsigned int amd_clock;
 
@@ -295,7 +295,7 @@ static void __devinit init_hwif_amd74xx(
 		.mwdma_mask	= ATA_MWDMA2,				\
 	}
 
-static struct ide_port_info amd74xx_chipsets[] __devinitdata = {
+static const struct ide_port_info amd74xx_chipsets[] __devinitdata = {
 	/*  0 */ DECLARE_AMD_DEV("AMD7401"),
 	/*  1 */ DECLARE_AMD_DEV("AMD7409"),
 	/*  2 */ DECLARE_AMD_DEV("AMD7411"),
Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -189,7 +189,7 @@ static void __devinit init_hwif_atiixp(i
 	hwif->dma_host_off = &atiixp_dma_host_off;
 }
 
-static struct ide_port_info atiixp_pci_info[] __devinitdata = {
+static const struct ide_port_info atiixp_pci_info[] __devinitdata = {
 	{	/* 0 */
 		.name		= "ATIIXP",
 		.init_hwif	= init_hwif_atiixp,
Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -548,7 +548,7 @@ static void __devinit init_hwif_cmd64x(i
 	}
 }
 
-static struct ide_port_info cmd64x_chipsets[] __devinitdata = {
+static const struct ide_port_info cmd64x_chipsets[] __devinitdata = {
 	{	/* 0 */
 		.name		= "CMD643",
 		.init_chipset	= init_chipset_cmd64x,
Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -141,7 +141,7 @@ static void __devinit init_hwif_cs5520(i
 		.pio_mask	= ATA_PIO4,			\
 	}
 
-static struct ide_port_info cyrix_chipsets[] __devinitdata = {
+static const struct ide_port_info cyrix_chipsets[] __devinitdata = {
 	/* 0 */ DECLARE_CS_DEV("Cyrix 5510"),
 	/* 1 */ DECLARE_CS_DEV("Cyrix 5520")
 };
@@ -154,7 +154,7 @@ static struct ide_port_info cyrix_chipse
  
 static int __devinit cs5520_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	struct ide_port_info *d = &cyrix_chipsets[id->driver_data];
+	const struct ide_port_info *d = &cyrix_chipsets[id->driver_data];
 	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
 	ide_setup_pci_noise(dev, d);
Index: b/drivers/ide/pci/cs5530.c
===================================================================
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -261,7 +261,7 @@ static void __devinit init_hwif_cs5530 (
 	hwif->udma_filter = cs5530_udma_filter;
 }
 
-static struct ide_port_info cs5530_chipset __devinitdata = {
+static const struct ide_port_info cs5530_chipset __devinitdata = {
 	.name		= "CS5530",
 	.init_chipset	= init_chipset_cs5530,
 	.init_hwif	= init_hwif_cs5530,
Index: b/drivers/ide/pci/cs5535.c
===================================================================
--- a/drivers/ide/pci/cs5535.c
+++ b/drivers/ide/pci/cs5535.c
@@ -186,7 +186,7 @@ static void __devinit init_hwif_cs5535(i
 	hwif->cbl = cs5535_cable_detect(hwif->pci_dev);
 }
 
-static struct ide_port_info cs5535_chipset __devinitdata = {
+static const struct ide_port_info cs5535_chipset __devinitdata = {
 	.name		= "CS5535",
 	.init_hwif	= init_hwif_cs5535,
 	.host_flags	= IDE_HFLAG_SINGLE | IDE_HFLAG_POST_SET_MODE |
Index: b/drivers/ide/pci/cy82c693.c
===================================================================
--- a/drivers/ide/pci/cy82c693.c
+++ b/drivers/ide/pci/cy82c693.c
@@ -448,7 +448,7 @@ static void __devinit init_iops_cy82c693
 	}
 }
 
-static struct ide_port_info cy82c693_chipset __devinitdata = {
+static const struct ide_port_info cy82c693_chipset __devinitdata = {
 	.name		= "CY82C693",
 	.init_chipset	= init_chipset_cy82c693,
 	.init_iops	= init_iops_cy82c693,
Index: b/drivers/ide/pci/generic.c
===================================================================
--- a/drivers/ide/pci/generic.c
+++ b/drivers/ide/pci/generic.c
@@ -67,7 +67,7 @@ MODULE_PARM_DESC(all_generic_ide, "IDE g
 		.udma_mask	= ATA_UDMA6, \
 	}
 
-static struct ide_port_info generic_chipsets[] __devinitdata = {
+static const struct ide_port_info generic_chipsets[] __devinitdata = {
 	/*  0 */ DECLARE_GENERIC_PCI_DEV("Unknown",	0),
 
 	{	/* 1 */
@@ -123,7 +123,7 @@ static struct ide_port_info generic_chip
  
 static int __devinit generic_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	struct ide_port_info *d = &generic_chipsets[id->driver_data];
+	const struct ide_port_info *d = &generic_chipsets[id->driver_data];
 	int ret = -ENODEV;
 
 	/* Don't use the generic entry unless instructed to do so */
Index: b/drivers/ide/pci/hpt34x.c
===================================================================
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -129,7 +129,7 @@ static void __devinit init_hwif_hpt34x(i
 	hwif->set_dma_mode = &hpt34x_set_mode;
 }
 
-static struct ide_port_info hpt34x_chipsets[] __devinitdata = {
+static const struct ide_port_info hpt34x_chipsets[] __devinitdata = {
 	{ /* 0 */
 		.name		= "HPT343",
 		.init_chipset	= init_chipset_hpt34x,
@@ -158,7 +158,7 @@ static struct ide_port_info hpt34x_chips
 
 static int __devinit hpt34x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	struct ide_port_info *d;
+	const struct ide_port_info *d;
 	u16 pcicmd = 0;
 
 	pci_read_config_word(dev, PCI_COMMAND, &pcicmd);
Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -1406,7 +1406,7 @@ static int __devinit hpt36x_init(struct 
 	return 0;
 }
 
-static struct ide_port_info hpt366_chipsets[] __devinitdata = {
+static const struct ide_port_info hpt366_chipsets[] __devinitdata = {
 	{	/* 0 */
 		.name		= "HPT36x",
 		.init_chipset	= init_chipset_hpt366,
Index: b/drivers/ide/pci/it8213.c
===================================================================
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -193,7 +193,7 @@ static void __devinit init_hwif_it8213(i
 		.udma_mask	= ATA_UDMA6,		\
 	}
 
-static struct ide_port_info it8213_chipsets[] __devinitdata = {
+static const struct ide_port_info it8213_chipsets[] __devinitdata = {
 	/* 0 */ DECLARE_ITE_DEV("IT8213"),
 };
 
Index: b/drivers/ide/pci/it821x.c
===================================================================
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -638,7 +638,7 @@ static unsigned int __devinit init_chips
 		.pio_mask	= ATA_PIO4,		\
 	}
 
-static struct ide_port_info it821x_chipsets[] __devinitdata = {
+static const struct ide_port_info it821x_chipsets[] __devinitdata = {
 	/* 0 */ DECLARE_ITE_DEV("IT8212"),
 };
 
Index: b/drivers/ide/pci/jmicron.c
===================================================================
--- a/drivers/ide/pci/jmicron.c
+++ b/drivers/ide/pci/jmicron.c
@@ -129,7 +129,7 @@ static void __devinit init_hwif_jmicron(
 		.udma_mask	= ATA_UDMA6,		\
 	}
 
-static struct ide_port_info jmicron_chipsets[] __devinitdata = {
+static const struct ide_port_info jmicron_chipsets[] __devinitdata = {
 	/* 0 */ DECLARE_JMB_DEV("JMB361"),
 	/* 1 */ DECLARE_JMB_DEV("JMB363"),
 	/* 2 */ DECLARE_JMB_DEV("JMB365"),
Index: b/drivers/ide/pci/ns87415.c
===================================================================
--- a/drivers/ide/pci/ns87415.c
+++ b/drivers/ide/pci/ns87415.c
@@ -260,7 +260,7 @@ static void __devinit init_hwif_ns87415 
 	hwif->ide_dma_end = &ns87415_ide_dma_end;
 }
 
-static struct ide_port_info ns87415_chipset __devinitdata = {
+static const struct ide_port_info ns87415_chipset __devinitdata = {
 	.name		= "NS87415",
 #ifdef CONFIG_SUPERIO
 	.init_iops	= init_iops_ns87415,
Index: b/drivers/ide/pci/opti621.c
===================================================================
--- a/drivers/ide/pci/opti621.c
+++ b/drivers/ide/pci/opti621.c
@@ -331,7 +331,7 @@ static void __devinit init_hwif_opti621 
 	hwif->set_pio_mode = &opti621_set_pio_mode;
 }
 
-static struct ide_port_info opti621_chipsets[] __devinitdata = {
+static const struct ide_port_info opti621_chipsets[] __devinitdata = {
 	{	/* 0 */
 		.name		= "OPTI621",
 		.init_hwif	= init_hwif_opti621,
Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -513,7 +513,7 @@ static struct pci_dev * __devinit pdc202
 		.udma_mask	= udma, \
 	}
 
-static struct ide_port_info pdcnew_chipsets[] __devinitdata = {
+static const struct ide_port_info pdcnew_chipsets[] __devinitdata = {
 	/* 0 */ DECLARE_PDCNEW_DEV("PDC20268", ATA_UDMA5),
 	/* 1 */ DECLARE_PDCNEW_DEV("PDC20269", ATA_UDMA6),
 	/* 2 */ DECLARE_PDCNEW_DEV("PDC20270", ATA_UDMA5),
@@ -534,7 +534,7 @@ static struct ide_port_info pdcnew_chips
  
 static int __devinit pdc202new_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	struct ide_port_info *d;
+	const struct ide_port_info *d;
 	struct pci_dev *bridge = dev->bus->self;
 	u8 idx = id->driver_data;
 
Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -390,7 +390,7 @@ static void __devinit pdc202ata4_fixup_i
 		.udma_mask	= udma, \
 	}
 
-static struct ide_port_info pdc202xx_chipsets[] __devinitdata = {
+static const struct ide_port_info pdc202xx_chipsets[] __devinitdata = {
 	{	/* 0 */
 		.name		= "PDC20246",
 		.init_chipset	= init_chipset_pdc202xx,
@@ -421,7 +421,7 @@ static struct ide_port_info pdc202xx_chi
  
 static int __devinit pdc202xx_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	struct ide_port_info *d;
+	const struct ide_port_info *d;
 	u8 idx = id->driver_data;
 
 	d = &pdc202xx_chipsets[idx];
Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -396,7 +396,7 @@ static void __devinit init_hwif_ich(ide_
 		.udma_mask	= udma, \
 	}
 
-static struct ide_port_info piix_pci_info[] __devinitdata = {
+static const struct ide_port_info piix_pci_info[] __devinitdata = {
 	/*  0 */ DECLARE_PIIX_DEV("PIIXa",	0x00),	/* no udma */
 	/*  1 */ DECLARE_PIIX_DEV("PIIXb",	0x00),	/* no udma */
 
Index: b/drivers/ide/pci/rz1000.c
===================================================================
--- a/drivers/ide/pci/rz1000.c
+++ b/drivers/ide/pci/rz1000.c
@@ -49,7 +49,7 @@ static void __devinit init_hwif_rz1000 (
 	}
 }
 
-static struct ide_port_info rz1000_chipset __devinitdata = {
+static const struct ide_port_info rz1000_chipset __devinitdata = {
 	.name		= "RZ100x",
 	.init_hwif	= init_hwif_rz1000,
 	.chipset	= ide_rz1000,
Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -372,7 +372,7 @@ static void __devinit init_hwif_sc1200 (
 	hwif->ide_dma_end   = &sc1200_ide_dma_end;
 }
 
-static struct ide_port_info sc1200_chipset __devinitdata = {
+static const struct ide_port_info sc1200_chipset __devinitdata = {
 	.name		= "SC1200",
 	.init_hwif	= init_hwif_sc1200,
 	.host_flags	= IDE_HFLAG_SERIALIZE |
Index: b/drivers/ide/pci/scc_pata.c
===================================================================
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -544,7 +544,7 @@ static int setup_mmio_scc (struct pci_de
  */
 
 static int __devinit init_setup_scc(struct pci_dev *dev,
-				    struct ide_port_info *d)
+				    const struct ide_port_info *d)
 {
 	unsigned long ctl_base;
 	unsigned long dma_base;
@@ -703,7 +703,7 @@ static void __devinit init_hwif_scc(ide_
       .pio_mask		= ATA_PIO4,			\
   }
 
-static struct ide_port_info scc_chipsets[] __devinitdata = {
+static const struct ide_port_info scc_chipsets[] __devinitdata = {
 	/* 0 */ DECLARE_SCC_DEV("sccIDE"),
 };
 
Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -365,7 +365,7 @@ static void __devinit init_hwif_svwks (i
 	}
 }
 
-static struct ide_port_info serverworks_chipsets[] __devinitdata = {
+static const struct ide_port_info serverworks_chipsets[] __devinitdata = {
 	{	/* 0 */
 		.name		= "SvrWks OSB4",
 		.init_chipset	= init_chipset_svwks,
Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -905,7 +905,7 @@ static void __devinit init_hwif_siimage(
 		.udma_mask	= ATA_UDMA6,		\
 	}
 
-static struct ide_port_info siimage_chipsets[] __devinitdata = {
+static const struct ide_port_info siimage_chipsets[] __devinitdata = {
 	/* 0 */ DECLARE_SII_DEV("SiI680"),
 	/* 1 */ DECLARE_SII_DEV("SiI3112 Serial ATA"),
 	/* 2 */ DECLARE_SII_DEV("Adaptec AAR-1210SA")
Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -579,7 +579,7 @@ static void __devinit init_hwif_sis5513 
 		hwif->cbl = ata66_sis5513(hwif);
 }
 
-static struct ide_port_info sis5513_chipset __devinitdata = {
+static const struct ide_port_info sis5513_chipset __devinitdata = {
 	.name		= "SIS5513",
 	.init_chipset	= init_chipset_sis5513,
 	.init_hwif	= init_hwif_sis5513,
Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -387,7 +387,7 @@ static void __devinit init_hwif_sl82c105
 		hwif->serialized = hwif->mate->serialized = 1;
 }
 
-static struct ide_port_info sl82c105_chipset __devinitdata = {
+static const struct ide_port_info sl82c105_chipset __devinitdata = {
 	.name		= "W82C105",
 	.init_chipset	= init_chipset_sl82c105,
 	.init_hwif	= init_hwif_sl82c105,
Index: b/drivers/ide/pci/slc90e66.c
===================================================================
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -146,7 +146,7 @@ static void __devinit init_hwif_slc90e66
 		hwif->cbl = (reg47 & mask) ? ATA_CBL_PATA40 : ATA_CBL_PATA80;
 }
 
-static struct ide_port_info slc90e66_chipset __devinitdata = {
+static const struct ide_port_info slc90e66_chipset __devinitdata = {
 	.name		= "SLC90E66",
 	.init_hwif	= init_hwif_slc90e66,
 	.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
Index: b/drivers/ide/pci/tc86c001.c
===================================================================
--- a/drivers/ide/pci/tc86c001.c
+++ b/drivers/ide/pci/tc86c001.c
@@ -218,7 +218,7 @@ static unsigned int __devinit init_chips
 	return err;
 }
 
-static struct ide_port_info tc86c001_chipset __devinitdata = {
+static const struct ide_port_info tc86c001_chipset __devinitdata = {
 	.name		= "TC86C001",
 	.init_chipset	= init_chipset_tc86c001,
 	.init_hwif	= init_hwif_tc86c001,
Index: b/drivers/ide/pci/triflex.c
===================================================================
--- a/drivers/ide/pci/triflex.c
+++ b/drivers/ide/pci/triflex.c
@@ -102,7 +102,7 @@ static void __devinit init_hwif_triflex(
 	hwif->set_dma_mode = &triflex_set_mode;
 }
 
-static struct ide_port_info triflex_device __devinitdata = {
+static const struct ide_port_info triflex_device __devinitdata = {
 	.name		= "TRIFLEX",
 	.init_hwif	= init_hwif_triflex,
 	.enablebits	= {{0x80, 0x01, 0x01}, {0x80, 0x02, 0x02}},
Index: b/drivers/ide/pci/trm290.c
===================================================================
--- a/drivers/ide/pci/trm290.c
+++ b/drivers/ide/pci/trm290.c
@@ -319,7 +319,7 @@ static void __devinit init_hwif_trm290(i
 #endif
 }
 
-static struct ide_port_info trm290_chipset __devinitdata = {
+static const struct ide_port_info trm290_chipset __devinitdata = {
 	.name		= "TRM290",
 	.init_hwif	= init_hwif_trm290,
 	.chipset	= ide_trm290,
Index: b/drivers/ide/pci/via82cxxx.c
===================================================================
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -432,7 +432,7 @@ static void __devinit init_hwif_via82cxx
 		hwif->cbl = via82cxxx_cable_detect(hwif);
 }
 
-static struct ide_port_info via82cxxx_chipset __devinitdata = {
+static const struct ide_port_info via82cxxx_chipset __devinitdata = {
 	.name		= "VP_IDE",
 	.init_chipset	= init_chipset_via82cxxx,
 	.init_hwif	= init_hwif_via82cxxx,
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -155,7 +155,7 @@ static int ide_setup_pci_baseregs (struc
  *	and enforce IDE simplex rules.
  */
 
-static unsigned long ide_get_or_set_dma_base(struct ide_port_info *d, ide_hwif_t *hwif)
+static unsigned long ide_get_or_set_dma_base(const struct ide_port_info *d, ide_hwif_t *hwif)
 {
 	unsigned long	dma_base = 0;
 	struct pci_dev	*dev = hwif->pci_dev;
@@ -225,7 +225,7 @@ static unsigned long ide_get_or_set_dma_
 }
 #endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
 
-void ide_setup_pci_noise(struct pci_dev *dev, struct ide_port_info *d)
+void ide_setup_pci_noise(struct pci_dev *dev, const struct ide_port_info *d)
 {
 	printk(KERN_INFO "%s: IDE controller at PCI slot %s\n",
 			 d->name, pci_name(dev));
@@ -245,7 +245,7 @@ EXPORT_SYMBOL_GPL(ide_setup_pci_noise);
  *	Returns zero on success or an error code
  */
 
-static int ide_pci_enable(struct pci_dev *dev, struct ide_port_info *d)
+static int ide_pci_enable(struct pci_dev *dev, const struct ide_port_info *d)
 {
 	int ret;
 
@@ -290,7 +290,7 @@ out:
  *	Returns zero on success or an error code.
  */
 
-static int ide_pci_configure(struct pci_dev *dev, struct ide_port_info *d)
+static int ide_pci_configure(struct pci_dev *dev, const struct ide_port_info *d)
 {
 	u16 pcicmd = 0;
 	/*
@@ -326,7 +326,7 @@ static int ide_pci_configure(struct pci_
  *	print an error and return an error code. Otherwise return 0
  */
 
-static int ide_pci_check_iomem(struct pci_dev *dev, struct ide_port_info *d, int bar)
+static int ide_pci_check_iomem(struct pci_dev *dev, const struct ide_port_info *d, int bar)
 {
 	ulong flags = pci_resource_flags(dev, bar);
 	
@@ -358,7 +358,7 @@ static int ide_pci_check_iomem(struct pc
  *	Returns the new hardware interface structure, or NULL on a failure
  */
 
-static ide_hwif_t *ide_hwif_configure(struct pci_dev *dev, struct ide_port_info *d, ide_hwif_t *mate, int port, int irq)
+static ide_hwif_t *ide_hwif_configure(struct pci_dev *dev, const struct ide_port_info *d, ide_hwif_t *mate, int port, int irq)
 {
 	unsigned long ctl = 0, base = 0;
 	ide_hwif_t *hwif;
@@ -423,7 +423,7 @@ static ide_hwif_t *ide_hwif_configure(st
  *	state
  */
 
-static void ide_hwif_setup_dma(struct pci_dev *dev, struct ide_port_info *d, ide_hwif_t *hwif)
+static void ide_hwif_setup_dma(struct pci_dev *dev, const struct ide_port_info *d, ide_hwif_t *hwif)
 {
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 	u16 pcicmd;
@@ -472,7 +472,7 @@ static void ide_hwif_setup_dma(struct pc
  *	and enables it if need be
  */
 
-static int ide_setup_pci_controller(struct pci_dev *dev, struct ide_port_info *d, int noisy, int *config)
+static int ide_setup_pci_controller(struct pci_dev *dev, const struct ide_port_info *d, int noisy, int *config)
 {
 	int ret;
 	u16 pcicmd;
@@ -520,7 +520,7 @@ out:
  *	where the chipset setup is not the default PCI IDE one.
  */
 
-void ide_pci_setup_ports(struct pci_dev *dev, struct ide_port_info *d, int pciirq, u8 *idx)
+void ide_pci_setup_ports(struct pci_dev *dev, const struct ide_port_info *d, int pciirq, u8 *idx)
 {
 	int channels = (d->host_flags & IDE_HFLAG_SINGLE) ? 1 : 2, port;
 	ide_hwif_t *hwif, *mate = NULL;
@@ -531,8 +531,8 @@ void ide_pci_setup_ports(struct pci_dev 
 	 */
 
 	for (port = 0; port < channels; ++port) {
-		ide_pci_enablebit_t *e = &(d->enablebits[port]);
-	
+		const ide_pci_enablebit_t *e = &(d->enablebits[port]);
+
 		if (e->reg && (pci_read_config_byte(dev, e->reg, &tmp) ||
 		    (tmp & e->mask) != e->val)) {
 			printk(KERN_INFO "%s: IDE port disabled\n", d->name);
@@ -611,7 +611,7 @@ EXPORT_SYMBOL_GPL(ide_pci_setup_ports);
  * for all other chipsets, we just assume both interfaces are enabled.
  */
 static int do_ide_setup_pci_device(struct pci_dev *dev,
-				   struct ide_port_info *d,
+				   const struct ide_port_info *d,
 				   u8 *idx, u8 noisy)
 {
 	int tried_config = 0;
@@ -668,7 +668,7 @@ out:
 	return ret;
 }
 
-int ide_setup_pci_device(struct pci_dev *dev, struct ide_port_info *d)
+int ide_setup_pci_device(struct pci_dev *dev, const struct ide_port_info *d)
 {
 	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 	int ret;
@@ -684,7 +684,7 @@ int ide_setup_pci_device(struct pci_dev 
 EXPORT_SYMBOL_GPL(ide_setup_pci_device);
 
 int ide_setup_pci_devices(struct pci_dev *dev1, struct pci_dev *dev2,
-			  struct ide_port_info *d)
+			  const struct ide_port_info *d)
 {
 	struct pci_dev *pdev[] = { dev1, dev2 };
 	int ret, i;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -669,7 +669,7 @@ typedef struct hwif_s {
 	hwif_chipset_t chipset;	/* sub-module for tuning.. */
 
 	struct pci_dev  *pci_dev;	/* for pci chipsets */
-	struct ide_port_info *cds;	/* chipset device struct */
+	const struct ide_port_info *cds;	/* chipset device struct */
 
 	void (*rw_disk)(ide_drive_t *, struct request *);
 
@@ -1142,8 +1142,8 @@ extern int __ide_pci_register_driver(str
 #define ide_pci_register_driver(d) pci_register_driver(d)
 #endif
 
-void ide_pci_setup_ports(struct pci_dev *, struct ide_port_info *, int, u8 *);
-void ide_setup_pci_noise(struct pci_dev *, struct ide_port_info *);
+void ide_pci_setup_ports(struct pci_dev *, const struct ide_port_info *, int, u8 *);
+void ide_setup_pci_noise(struct pci_dev *, const struct ide_port_info *);
 
 extern void default_hwif_iops(ide_hwif_t *);
 extern void default_hwif_mmiops(ide_hwif_t *);
@@ -1236,8 +1236,8 @@ struct ide_port_info {
 	u8			udma_mask;
 };
 
-int ide_setup_pci_device(struct pci_dev *, struct ide_port_info *);
-int ide_setup_pci_devices(struct pci_dev *, struct pci_dev *, struct ide_port_info *);
+int ide_setup_pci_device(struct pci_dev *, const struct ide_port_info *);
+int ide_setup_pci_devices(struct pci_dev *, struct pci_dev *, const struct ide_port_info *);
 
 void ide_map_sg(ide_drive_t *, struct request *);
 void ide_init_sg_cmd(ide_drive_t *, struct request *);
