From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/9] ide: replace ide_pci_device_t by struct ide_port_info
Date: Mon, 24 Sep 2007 22:47:27 +0200
Message-ID: <200709242247.27459.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:29636 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019AbXIXUqP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Sep 2007 16:46:15 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1485942nfb
        for <linux-ide@vger.kernel.org>; Mon, 24 Sep 2007 13:46:14 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Rename struct ide_pci_device_s to struct ide_port_info.

* Remove ide_pci_device_t typedef.

While at it:

* Fix __ide_pci_register_driver() comment.

* Fix aec62xx_init_one() comment.

* Remove unused 'cds' field from ide_hwgroup_t.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/aec62xx.c      |    8 ++--
 drivers/ide/pci/alim15x3.c     |    4 +-
 drivers/ide/pci/amd74xx.c      |    4 +-
 drivers/ide/pci/atiixp.c       |    3 -
 drivers/ide/pci/cmd64x.c       |    4 +-
 drivers/ide/pci/cs5520.c       |    4 +-
 drivers/ide/pci/cs5530.c       |    2 -
 drivers/ide/pci/cs5535.c       |    2 -
 drivers/ide/pci/cy82c693.c     |    2 -
 drivers/ide/pci/generic.c      |    4 +-
 drivers/ide/pci/hpt34x.c       |    4 +-
 drivers/ide/pci/hpt366.c       |    4 +-
 drivers/ide/pci/it8213.c       |    2 -
 drivers/ide/pci/it821x.c       |    2 -
 drivers/ide/pci/jmicron.c      |    2 -
 drivers/ide/pci/ns87415.c      |    2 -
 drivers/ide/pci/opti621.c      |    2 -
 drivers/ide/pci/pdc202xx_new.c |    4 +-
 drivers/ide/pci/pdc202xx_old.c |    4 +-
 drivers/ide/pci/piix.c         |    6 +--
 drivers/ide/pci/rz1000.c       |    2 -
 drivers/ide/pci/sc1200.c       |    2 -
 drivers/ide/pci/scc_pata.c     |   11 ++---
 drivers/ide/pci/serverworks.c  |    4 +-
 drivers/ide/pci/siimage.c      |    2 -
 drivers/ide/pci/sis5513.c      |    2 -
 drivers/ide/pci/sl82c105.c     |    2 -
 drivers/ide/pci/slc90e66.c     |    2 -
 drivers/ide/pci/tc86c001.c     |    2 -
 drivers/ide/pci/triflex.c      |    2 -
 drivers/ide/pci/trm290.c       |    2 -
 drivers/ide/pci/via82cxxx.c    |    4 +-
 drivers/ide/setup-pci.c        |   82 +++++++++++++++++++----------------------
 include/linux/ide.h            |   18 ++++-----
 34 files changed, 97 insertions(+), 109 deletions(-)

Index: b/drivers/ide/pci/aec62xx.c
===================================================================
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -194,7 +194,7 @@ static void __devinit init_hwif_aec62xx(
 	}
 }
 
-static ide_pci_device_t aec62xx_chipsets[] __devinitdata = {
+static struct ide_port_info aec62xx_chipsets[] __devinitdata = {
 	{	/* 0 */
 		.name		= "AEC6210",
 		.init_chipset	= init_chipset_aec62xx,
@@ -253,12 +253,12 @@ static ide_pci_device_t aec62xx_chipsets
  *	finds a device matching our IDE device tables.
  *
  *	NOTE: since we're going to modify the 'name' field for AEC-6[26]80[R]
- *	chips, pass a local copy of 'struct pci_device_id' down the call chain.
+ *	chips, pass a local copy of 'struct ide_port_info' down the call chain.
  */
- 
+
 static int __devinit aec62xx_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t d;
+	struct ide_port_info d;
 	u8 idx = id->driver_data;
 
 	d = aec62xx_chipsets[idx];
Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -746,7 +746,7 @@ static void __devinit init_dma_ali15x3 (
 	ide_setup_dma(hwif, dmabase, 8);
 }
 
-static ide_pci_device_t ali15x3_chipset __devinitdata = {
+static struct ide_port_info ali15x3_chipset __devinitdata = {
 	.name		= "ALI15X3",
 	.init_chipset	= init_chipset_ali15x3,
 	.init_hwif	= init_hwif_ali15x3,
@@ -772,7 +772,7 @@ static int __devinit alim15x3_init_one(s
 		{ },
 	};
 
-	ide_pci_device_t d = ali15x3_chipset;
+	struct ide_port_info d = ali15x3_chipset;
 	u8 rev = dev->revision;
 
 	if (pci_dev_present(ati_rs100))
Index: b/drivers/ide/pci/amd74xx.c
===================================================================
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -77,7 +77,7 @@ static struct amd_ide_chip {
 };
 
 static struct amd_ide_chip *amd_config;
-static ide_pci_device_t *amd_chipset;
+static struct ide_port_info *amd_chipset;
 static unsigned int amd_80w;
 static unsigned int amd_clock;
 
@@ -295,7 +295,7 @@ static void __devinit init_hwif_amd74xx(
 		.mwdma_mask	= ATA_MWDMA2,				\
 	}
 
-static ide_pci_device_t amd74xx_chipsets[] __devinitdata = {
+static struct ide_port_info amd74xx_chipsets[] __devinitdata = {
 	/*  0 */ DECLARE_AMD_DEV("AMD7401"),
 	/*  1 */ DECLARE_AMD_DEV("AMD7409"),
 	/*  2 */ DECLARE_AMD_DEV("AMD7411"),
Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -189,8 +189,7 @@ static void __devinit init_hwif_atiixp(i
 	hwif->dma_host_off = &atiixp_dma_host_off;
 }
 
-
-static ide_pci_device_t atiixp_pci_info[] __devinitdata = {
+static struct ide_port_info atiixp_pci_info[] __devinitdata = {
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
 
-static ide_pci_device_t cmd64x_chipsets[] __devinitdata = {
+static struct ide_port_info cmd64x_chipsets[] __devinitdata = {
 	{	/* 0 */
 		.name		= "CMD643",
 		.init_chipset	= init_chipset_cmd64x,
@@ -591,7 +591,7 @@ static ide_pci_device_t cmd64x_chipsets[
 
 static int __devinit cmd64x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t d;
+	struct ide_port_info d;
 	u8 idx = id->driver_data;
 
 	d = cmd64x_chipsets[idx];
Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -141,7 +141,7 @@ static void __devinit init_hwif_cs5520(i
 		.pio_mask	= ATA_PIO4,			\
 	}
 
-static ide_pci_device_t cyrix_chipsets[] __devinitdata = {
+static struct ide_port_info cyrix_chipsets[] __devinitdata = {
 	/* 0 */ DECLARE_CS_DEV("Cyrix 5510"),
 	/* 1 */ DECLARE_CS_DEV("Cyrix 5520")
 };
@@ -154,7 +154,7 @@ static ide_pci_device_t cyrix_chipsets[]
  
 static int __devinit cs5520_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &cyrix_chipsets[id->driver_data];
+	struct ide_port_info *d = &cyrix_chipsets[id->driver_data];
 	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
 	ide_setup_pci_noise(dev, d);
Index: b/drivers/ide/pci/cs5530.c
===================================================================
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -261,7 +261,7 @@ static void __devinit init_hwif_cs5530 (
 	hwif->udma_filter = cs5530_udma_filter;
 }
 
-static ide_pci_device_t cs5530_chipset __devinitdata = {
+static struct ide_port_info cs5530_chipset __devinitdata = {
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
 
-static ide_pci_device_t cs5535_chipset __devinitdata = {
+static struct ide_port_info cs5535_chipset __devinitdata = {
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
 
-static ide_pci_device_t cy82c693_chipset __devinitdata = {
+static struct ide_port_info cy82c693_chipset __devinitdata = {
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
 
-static ide_pci_device_t generic_chipsets[] __devinitdata = {
+static struct ide_port_info generic_chipsets[] __devinitdata = {
 	/*  0 */ DECLARE_GENERIC_PCI_DEV("Unknown",	0),
 
 	{	/* 1 */
@@ -123,7 +123,7 @@ static ide_pci_device_t generic_chipsets
  
 static int __devinit generic_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &generic_chipsets[id->driver_data];
+	struct ide_port_info *d = &generic_chipsets[id->driver_data];
 	int ret = -ENODEV;
 
 	/* Don't use the generic entry unless instructed to do so */
Index: b/drivers/ide/pci/hpt34x.c
===================================================================
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -129,7 +129,7 @@ static void __devinit init_hwif_hpt34x(i
 	hwif->set_dma_mode = &hpt34x_set_mode;
 }
 
-static ide_pci_device_t hpt34x_chipsets[] __devinitdata = {
+static struct ide_port_info hpt34x_chipsets[] __devinitdata = {
 	{ /* 0 */
 		.name		= "HPT343",
 		.init_chipset	= init_chipset_hpt34x,
@@ -158,7 +158,7 @@ static ide_pci_device_t hpt34x_chipsets[
 
 static int __devinit hpt34x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d;
+	struct ide_port_info *d;
 	u16 pcicmd = 0;
 
 	pci_read_config_word(dev, PCI_COMMAND, &pcicmd);
Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -1406,7 +1406,7 @@ static int __devinit hpt36x_init(struct 
 	return 0;
 }
 
-static ide_pci_device_t hpt366_chipsets[] __devinitdata = {
+static struct ide_port_info hpt366_chipsets[] __devinitdata = {
 	{	/* 0 */
 		.name		= "HPT36x",
 		.init_chipset	= init_chipset_hpt366,
@@ -1491,7 +1491,7 @@ static int __devinit hpt366_init_one(str
 {
 	struct hpt_info *info = NULL;
 	struct pci_dev *dev2 = NULL;
-	ide_pci_device_t d;
+	struct ide_port_info d;
 	u8 idx = id->driver_data;
 	u8 rev = dev->revision;
 
Index: b/drivers/ide/pci/it8213.c
===================================================================
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -193,7 +193,7 @@ static void __devinit init_hwif_it8213(i
 		.udma_mask	= ATA_UDMA6,		\
 	}
 
-static ide_pci_device_t it8213_chipsets[] __devinitdata = {
+static struct ide_port_info it8213_chipsets[] __devinitdata = {
 	/* 0 */ DECLARE_ITE_DEV("IT8213"),
 };
 
Index: b/drivers/ide/pci/it821x.c
===================================================================
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -638,7 +638,7 @@ static unsigned int __devinit init_chips
 		.pio_mask	= ATA_PIO4,		\
 	}
 
-static ide_pci_device_t it821x_chipsets[] __devinitdata = {
+static struct ide_port_info it821x_chipsets[] __devinitdata = {
 	/* 0 */ DECLARE_ITE_DEV("IT8212"),
 };
 
Index: b/drivers/ide/pci/jmicron.c
===================================================================
--- a/drivers/ide/pci/jmicron.c
+++ b/drivers/ide/pci/jmicron.c
@@ -129,7 +129,7 @@ static void __devinit init_hwif_jmicron(
 		.udma_mask	= ATA_UDMA6,		\
 	}
 
-static ide_pci_device_t jmicron_chipsets[] __devinitdata = {
+static struct ide_port_info jmicron_chipsets[] __devinitdata = {
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
 
-static ide_pci_device_t ns87415_chipset __devinitdata = {
+static struct ide_port_info ns87415_chipset __devinitdata = {
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
 
-static ide_pci_device_t opti621_chipsets[] __devinitdata = {
+static struct ide_port_info opti621_chipsets[] __devinitdata = {
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
 
-static ide_pci_device_t pdcnew_chipsets[] __devinitdata = {
+static struct ide_port_info pdcnew_chipsets[] __devinitdata = {
 	/* 0 */ DECLARE_PDCNEW_DEV("PDC20268", ATA_UDMA5),
 	/* 1 */ DECLARE_PDCNEW_DEV("PDC20269", ATA_UDMA6),
 	/* 2 */ DECLARE_PDCNEW_DEV("PDC20270", ATA_UDMA5),
@@ -534,7 +534,7 @@ static ide_pci_device_t pdcnew_chipsets[
  
 static int __devinit pdc202new_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d;
+	struct ide_port_info *d;
 	struct pci_dev *bridge = dev->bus->self;
 	u8 idx = id->driver_data;
 
Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -390,7 +390,7 @@ static void __devinit pdc202ata4_fixup_i
 		.udma_mask	= udma, \
 	}
 
-static ide_pci_device_t pdc202xx_chipsets[] __devinitdata = {
+static struct ide_port_info pdc202xx_chipsets[] __devinitdata = {
 	{	/* 0 */
 		.name		= "PDC20246",
 		.init_chipset	= init_chipset_pdc202xx,
@@ -421,7 +421,7 @@ static ide_pci_device_t pdc202xx_chipset
  
 static int __devinit pdc202xx_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d;
+	struct ide_port_info *d;
 	u8 idx = id->driver_data;
 
 	d = &pdc202xx_chipsets[idx];
Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -396,7 +396,7 @@ static void __devinit init_hwif_ich(ide_
 		.udma_mask	= udma, \
 	}
 
-static ide_pci_device_t piix_pci_info[] __devinitdata = {
+static struct ide_port_info piix_pci_info[] __devinitdata = {
 	/*  0 */ DECLARE_PIIX_DEV("PIIXa",	0x00),	/* no udma */
 	/*  1 */ DECLARE_PIIX_DEV("PIIXb",	0x00),	/* no udma */
 
@@ -449,9 +449,7 @@ static ide_pci_device_t piix_pci_info[] 
  
 static int __devinit piix_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &piix_pci_info[id->driver_data];
-
-	return ide_setup_pci_device(dev, d);
+	return ide_setup_pci_device(dev, &piix_pci_info[id->driver_data]);
 }
 
 /**
Index: b/drivers/ide/pci/rz1000.c
===================================================================
--- a/drivers/ide/pci/rz1000.c
+++ b/drivers/ide/pci/rz1000.c
@@ -49,7 +49,7 @@ static void __devinit init_hwif_rz1000 (
 	}
 }
 
-static ide_pci_device_t rz1000_chipset __devinitdata = {
+static struct ide_port_info rz1000_chipset __devinitdata = {
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
 
-static ide_pci_device_t sc1200_chipset __devinitdata = {
+static struct ide_port_info sc1200_chipset __devinitdata = {
 	.name		= "SC1200",
 	.init_hwif	= init_hwif_sc1200,
 	.host_flags	= IDE_HFLAG_SERIALIZE |
Index: b/drivers/ide/pci/scc_pata.c
===================================================================
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -538,12 +538,13 @@ static int setup_mmio_scc (struct pci_de
 /**
  *	init_setup_scc	-	set up an SCC PATA Controller
  *	@dev: PCI device
- *	@d: IDE PCI device
+ *	@d: IDE port info
  *
  *	Perform the initial set up for this device.
  */
 
-static int __devinit init_setup_scc(struct pci_dev *dev, ide_pci_device_t *d)
+static int __devinit init_setup_scc(struct pci_dev *dev,
+				    struct ide_port_info *d)
 {
 	unsigned long ctl_base;
 	unsigned long dma_base;
@@ -702,7 +703,7 @@ static void __devinit init_hwif_scc(ide_
       .pio_mask		= ATA_PIO4,			\
   }
 
-static ide_pci_device_t scc_chipsets[] __devinitdata = {
+static struct ide_port_info scc_chipsets[] __devinitdata = {
 	/* 0 */ DECLARE_SCC_DEV("sccIDE"),
 };
 
@@ -717,9 +718,7 @@ static ide_pci_device_t scc_chipsets[] _
 
 static int __devinit scc_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &scc_chipsets[id->driver_data];
-
-	return init_setup_scc(dev, d);
+	return init_setup_scc(dev, &scc_chipsets[id->driver_data]);
 }
 
 /**
Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -365,7 +365,7 @@ static void __devinit init_hwif_svwks (i
 	}
 }
 
-static ide_pci_device_t serverworks_chipsets[] __devinitdata = {
+static struct ide_port_info serverworks_chipsets[] __devinitdata = {
 	{	/* 0 */
 		.name		= "SvrWks OSB4",
 		.init_chipset	= init_chipset_svwks,
@@ -422,7 +422,7 @@ static ide_pci_device_t serverworks_chip
  
 static int __devinit svwks_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t d;
+	struct ide_port_info d;
 	u8 idx = id->driver_data;
 
 	d = serverworks_chipsets[idx];
Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -905,7 +905,7 @@ static void __devinit init_hwif_siimage(
 		.udma_mask	= ATA_UDMA6,		\
 	}
 
-static ide_pci_device_t siimage_chipsets[] __devinitdata = {
+static struct ide_port_info siimage_chipsets[] __devinitdata = {
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
 
-static ide_pci_device_t sis5513_chipset __devinitdata = {
+static struct ide_port_info sis5513_chipset __devinitdata = {
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
 
-static ide_pci_device_t sl82c105_chipset __devinitdata = {
+static struct ide_port_info sl82c105_chipset __devinitdata = {
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
 
-static ide_pci_device_t slc90e66_chipset __devinitdata = {
+static struct ide_port_info slc90e66_chipset __devinitdata = {
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
 
-static ide_pci_device_t tc86c001_chipset __devinitdata = {
+static struct ide_port_info tc86c001_chipset __devinitdata = {
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
 
-static ide_pci_device_t triflex_device __devinitdata = {
+static struct ide_port_info triflex_device __devinitdata = {
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
 
-static ide_pci_device_t trm290_chipset __devinitdata = {
+static struct ide_port_info trm290_chipset __devinitdata = {
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
 
-static ide_pci_device_t via82cxxx_chipset __devinitdata = {
+static struct ide_port_info via82cxxx_chipset __devinitdata = {
 	.name		= "VP_IDE",
 	.init_chipset	= init_chipset_via82cxxx,
 	.init_hwif	= init_hwif_via82cxxx,
@@ -452,7 +452,7 @@ static int __devinit via_init_one(struct
 	struct pci_dev *isa = NULL;
 	struct via_isa_bridge *via_config;
 	u8 idx = id->driver_data;
-	ide_pci_device_t d;
+	struct ide_port_info d;
 
 	d = via82cxxx_chipset;
 
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -147,15 +147,15 @@ static int ide_setup_pci_baseregs (struc
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 /**
  *	ide_get_or_set_dma_base		-	setup BMIBA
- *	@d: IDE pci device data
- *	@hwif: Interface
+ *	@d: IDE port info
+ *	@hwif: IDE interface
  *
  *	Fetch the DMA Bus-Master-I/O-Base-Address (BMIBA) from PCI space.
  *	Where a device has a partner that is already in DMA mode we check
  *	and enforce IDE simplex rules.
  */
 
-static unsigned long ide_get_or_set_dma_base(ide_pci_device_t *d, ide_hwif_t *hwif)
+static unsigned long ide_get_or_set_dma_base(struct ide_port_info *d, ide_hwif_t *hwif)
 {
 	unsigned long	dma_base = 0;
 	struct pci_dev	*dev = hwif->pci_dev;
@@ -225,7 +225,7 @@ static unsigned long ide_get_or_set_dma_
 }
 #endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
 
-void ide_setup_pci_noise (struct pci_dev *dev, ide_pci_device_t *d)
+void ide_setup_pci_noise(struct pci_dev *dev, struct ide_port_info *d)
 {
 	printk(KERN_INFO "%s: IDE controller at PCI slot %s\n",
 			 d->name, pci_name(dev));
@@ -237,15 +237,15 @@ EXPORT_SYMBOL_GPL(ide_setup_pci_noise);
 /**
  *	ide_pci_enable	-	do PCI enables
  *	@dev: PCI device
- *	@d: IDE pci device data
+ *	@d: IDE port info
  *
  *	Enable the IDE PCI device. We attempt to enable the device in full
  *	but if that fails then we only need BAR4 so we will enable that.
  *	
  *	Returns zero on success or an error code
  */
- 
-static int ide_pci_enable(struct pci_dev *dev, ide_pci_device_t *d)
+
+static int ide_pci_enable(struct pci_dev *dev, struct ide_port_info *d)
 {
 	int ret;
 
@@ -260,9 +260,9 @@ static int ide_pci_enable(struct pci_dev
 	}
 
 	/*
-	 * assume all devices can do 32-bit dma for now. we can add a
-	 * dma mask field to the ide_pci_device_t if we need it (or let
-	 * lower level driver set the dma mask)
+	 * assume all devices can do 32-bit DMA for now, we can add
+	 * a DMA mask field to the struct ide_port_info if we need it
+	 * (or let lower level driver set the DMA mask)
 	 */
 	ret = pci_set_dma_mask(dev, DMA_32BIT_MASK);
 	if (ret < 0) {
@@ -284,13 +284,13 @@ out:
 /**
  *	ide_pci_configure	-	configure an unconfigured device
  *	@dev: PCI device
- *	@d: IDE pci device data
+ *	@d: IDE port info
  *
  *	Enable and configure the PCI device we have been passed.
  *	Returns zero on success or an error code.
  */
- 
-static int ide_pci_configure(struct pci_dev *dev, ide_pci_device_t *d)
+
+static int ide_pci_configure(struct pci_dev *dev, struct ide_port_info *d)
 {
 	u16 pcicmd = 0;
 	/*
@@ -318,15 +318,15 @@ static int ide_pci_configure(struct pci_
 
 /**
  *	ide_pci_check_iomem	-	check a register is I/O
- *	@dev: pci device
- *	@d: ide_pci_device
- *	@bar: bar number
+ *	@dev: PCI device
+ *	@d: IDE port info
+ *	@bar: BAR number
  *
  *	Checks if a BAR is configured and points to MMIO space. If so
  *	print an error and return an error code. Otherwise return 0
  */
- 
-static int ide_pci_check_iomem(struct pci_dev *dev, ide_pci_device_t *d, int bar)
+
+static int ide_pci_check_iomem(struct pci_dev *dev, struct ide_port_info *d, int bar)
 {
 	ulong flags = pci_resource_flags(dev, bar);
 	
@@ -348,7 +348,7 @@ static int ide_pci_check_iomem(struct pc
 /**
  *	ide_hwif_configure	-	configure an IDE interface
  *	@dev: PCI device holding interface
- *	@d: IDE pci data
+ *	@d: IDE port info
  *	@mate: Paired interface if any
  *
  *	Perform the initial set up for the hardware interface structure. This
@@ -357,8 +357,8 @@ static int ide_pci_check_iomem(struct pc
  *
  *	Returns the new hardware interface structure, or NULL on a failure
  */
- 
-static ide_hwif_t *ide_hwif_configure(struct pci_dev *dev, ide_pci_device_t *d, ide_hwif_t *mate, int port, int irq)
+
+static ide_hwif_t *ide_hwif_configure(struct pci_dev *dev, struct ide_port_info *d, ide_hwif_t *mate, int port, int irq)
 {
 	unsigned long ctl = 0, base = 0;
 	ide_hwif_t *hwif;
@@ -400,7 +400,7 @@ static ide_hwif_t *ide_hwif_configure(st
 	}
 	hwif->chipset = d->chipset ? d->chipset : ide_pci;
 	hwif->pci_dev = dev;
-	hwif->cds = (struct ide_pci_device_s *) d;
+	hwif->cds = d;
 	hwif->channel = port;
 
 	if (!hwif->irq)
@@ -415,21 +415,17 @@ static ide_hwif_t *ide_hwif_configure(st
 /**
  *	ide_hwif_setup_dma	-	configure DMA interface
  *	@dev: PCI device
- *	@d: IDE pci data
- *	@hwif: Hardware interface we are configuring
+ *	@d: IDE port info
+ *	@hwif: IDE interface
  *
  *	Set up the DMA base for the interface. Enable the master bits as
  *	necessary and attempt to bring the device DMA into a ready to use
  *	state
  */
- 
-#ifndef CONFIG_BLK_DEV_IDEDMA_PCI
-static void ide_hwif_setup_dma(struct pci_dev *dev, ide_pci_device_t *d, ide_hwif_t *hwif)
-{
-}
-#else
-static void ide_hwif_setup_dma(struct pci_dev *dev, ide_pci_device_t *d, ide_hwif_t *hwif)
+
+static void ide_hwif_setup_dma(struct pci_dev *dev, struct ide_port_info *d, ide_hwif_t *hwif)
 {
+#ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 	u16 pcicmd;
 
 	pci_read_config_word(dev, PCI_COMMAND, &pcicmd);
@@ -461,13 +457,13 @@ static void ide_hwif_setup_dma(struct pc
 				"(BIOS)\n", hwif->name, d->name);
 		}
 	}
-}
 #endif /* CONFIG_BLK_DEV_IDEDMA_PCI*/
+}
 
 /**
  *	ide_setup_pci_controller	-	set up IDE PCI
  *	@dev: PCI device
- *	@d: IDE PCI data
+ *	@d: IDE port info
  *	@noisy: verbose flag
  *	@config: returned as 1 if we configured the hardware
  *
@@ -475,8 +471,8 @@ static void ide_hwif_setup_dma(struct pc
  *	up the PCI side of the device, checks that the device is enabled
  *	and enables it if need be
  */
- 
-static int ide_setup_pci_controller(struct pci_dev *dev, ide_pci_device_t *d, int noisy, int *config)
+
+static int ide_setup_pci_controller(struct pci_dev *dev, struct ide_port_info *d, int noisy, int *config)
 {
 	int ret;
 	u16 pcicmd;
@@ -511,7 +507,7 @@ out:
 /**
  *	ide_pci_setup_ports	-	configure ports/devices on PCI IDE
  *	@dev: PCI device
- *	@d: IDE pci device info
+ *	@d: IDE port info
  *	@pciirq: IRQ line
  *	@idx: ATA index table to update
  *
@@ -524,7 +520,7 @@ out:
  *	where the chipset setup is not the default PCI IDE one.
  */
 
-void ide_pci_setup_ports(struct pci_dev *dev, ide_pci_device_t *d, int pciirq, u8 *idx)
+void ide_pci_setup_ports(struct pci_dev *dev, struct ide_port_info *d, int pciirq, u8 *idx)
 {
 	int channels = (d->host_flags & IDE_HFLAG_SINGLE) ? 1 : 2, port;
 	ide_hwif_t *hwif, *mate = NULL;
@@ -611,10 +607,11 @@ EXPORT_SYMBOL_GPL(ide_pci_setup_ports);
  *
  * One thing that is not standardized is the location of the
  * primary/secondary interface "enable/disable" bits.  For chipsets that
- * we "know" about, this information is in the ide_pci_device_t struct;
+ * we "know" about, this information is in the struct ide_port_info;
  * for all other chipsets, we just assume both interfaces are enabled.
  */
-static int do_ide_setup_pci_device(struct pci_dev *dev, ide_pci_device_t *d,
+static int do_ide_setup_pci_device(struct pci_dev *dev,
+				   struct ide_port_info *d,
 				   u8 *idx, u8 noisy)
 {
 	int tried_config = 0;
@@ -671,7 +668,7 @@ out:
 	return ret;
 }
 
-int ide_setup_pci_device(struct pci_dev *dev, ide_pci_device_t *d)
+int ide_setup_pci_device(struct pci_dev *dev, struct ide_port_info *d)
 {
 	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 	int ret;
@@ -687,7 +684,7 @@ int ide_setup_pci_device(struct pci_dev 
 EXPORT_SYMBOL_GPL(ide_setup_pci_device);
 
 int ide_setup_pci_devices(struct pci_dev *dev1, struct pci_dev *dev2,
-			  ide_pci_device_t *d)
+			  struct ide_port_info *d)
 {
 	struct pci_dev *pdev[] = { dev1, dev2 };
 	int ret, i;
@@ -728,9 +725,6 @@ static LIST_HEAD(ide_pci_drivers);
  *	hands the controllers off to the core PCI code to do the rest of
  *	the work.
  *
- *	The driver_data of the driver table must point to an ide_pci_device_t
- *	describing the interface.
- *
  *	Returns are the same as for pci_register_driver
  */
 
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -633,7 +633,7 @@ typedef struct ide_drive_s {
     ((1<<ide_pci)|(1<<ide_cmd646)|(1<<ide_ali14xx))
 #define IDE_CHIPSET_IS_PCI(c)	((IDE_CHIPSET_PCI_MASK >> (c)) & 1)
 
-struct ide_pci_device_s;
+struct ide_port_info;
 
 typedef struct hwif_s {
 	struct hwif_s *next;		/* for linked-list in ide_hwgroup_t */
@@ -669,7 +669,7 @@ typedef struct hwif_s {
 	hwif_chipset_t chipset;	/* sub-module for tuning.. */
 
 	struct pci_dev  *pci_dev;	/* for pci chipsets */
-	struct ide_pci_device_s	*cds;	/* chipset device struct */
+	struct ide_port_info *cds;	/* chipset device struct */
 
 	void (*rw_disk)(ide_drive_t *, struct request *);
 
@@ -818,8 +818,6 @@ typedef struct hwgroup_s {
 
 		/* for pci chipsets */
 	struct pci_dev *pci_dev;
-		/* chipset device struct */
-	struct ide_pci_device_s *cds;
 
 		/* current request */
 	struct request *rq;
@@ -1144,8 +1142,8 @@ extern int __ide_pci_register_driver(str
 #define ide_pci_register_driver(d) pci_register_driver(d)
 #endif
 
-void ide_pci_setup_ports(struct pci_dev *, struct ide_pci_device_s *, int, u8 *);
-extern void ide_setup_pci_noise (struct pci_dev *dev, struct ide_pci_device_s *d);
+void ide_pci_setup_ports(struct pci_dev *, struct ide_port_info *, int, u8 *);
+void ide_setup_pci_noise(struct pci_dev *, struct ide_port_info *);
 
 extern void default_hwif_iops(ide_hwif_t *);
 extern void default_hwif_mmiops(ide_hwif_t *);
@@ -1221,7 +1219,7 @@ enum {
 # define IDE_HFLAG_OFF_BOARD	0
 #endif
 
-typedef struct ide_pci_device_s {
+struct ide_port_info {
 	char			*name;
 	unsigned int		(*init_chipset)(struct pci_dev *, const char *);
 	void			(*init_iops)(ide_hwif_t *);
@@ -1236,10 +1234,10 @@ typedef struct ide_pci_device_s {
 	u8			swdma_mask;
 	u8			mwdma_mask;
 	u8			udma_mask;
-} ide_pci_device_t;
+};
 
-extern int ide_setup_pci_device(struct pci_dev *, ide_pci_device_t *);
-extern int ide_setup_pci_devices(struct pci_dev *, struct pci_dev *, ide_pci_device_t *);
+int ide_setup_pci_device(struct pci_dev *, struct ide_port_info *);
+int ide_setup_pci_devices(struct pci_dev *, struct pci_dev *, struct ide_port_info *);
 
 void ide_map_sg(ide_drive_t *, struct request *);
 void ide_init_sg_cmd(ide_drive_t *, struct request *);
