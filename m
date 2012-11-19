From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 208/493] ide: remove use of __devinit
Date: Mon, 19 Nov 2012 13:22:37 -0500
Message-ID: <1353349642-3677-208-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41865 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754674Ab2KSSnO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2012 13:43:14 -0500
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: "David S. Miller" <davem@davemloft.net> 
Cc: linux-ide@vger.kernel.org 
---
 drivers/ide/aec62xx.c         |  2 +-
 drivers/ide/alim15x3.c        |  6 +++---
 drivers/ide/amd74xx.c         |  2 +-
 drivers/ide/atiixp.c          |  2 +-
 drivers/ide/cmd64x.c          |  2 +-
 drivers/ide/cs5520.c          |  2 +-
 drivers/ide/cs5530.c          |  4 ++--
 drivers/ide/cs5535.c          |  2 +-
 drivers/ide/cy82c693.c        |  4 ++--
 drivers/ide/delkin_cb.c       |  2 +-
 drivers/ide/hpt366.c          | 12 ++++++------
 drivers/ide/icside.c          |  6 +++---
 drivers/ide/ide-pci-generic.c |  2 +-
 drivers/ide/ide_platform.c    |  4 ++--
 drivers/ide/it8172.c          |  2 +-
 drivers/ide/it8213.c          |  2 +-
 drivers/ide/it821x.c          |  4 ++--
 drivers/ide/jmicron.c         |  2 +-
 drivers/ide/ns87415.c         |  6 +++---
 drivers/ide/opti621.c         |  2 +-
 drivers/ide/palm_bk3710.c     |  4 ++--
 drivers/ide/pdc202xx_new.c    |  4 ++--
 drivers/ide/pdc202xx_old.c    |  4 ++--
 drivers/ide/piix.c            |  6 +++---
 drivers/ide/pmac.c            | 10 +++++-----
 drivers/ide/rapide.c          |  2 +-
 drivers/ide/rz1000.c          |  4 ++--
 drivers/ide/sc1200.c          |  2 +-
 drivers/ide/scc_pata.c        | 12 ++++++------
 drivers/ide/serverworks.c     |  2 +-
 drivers/ide/sgiioc4.c         |  8 ++++----
 drivers/ide/siimage.c         |  6 +++---
 drivers/ide/sis5513.c         |  4 ++--
 drivers/ide/sl82c105.c        |  2 +-
 drivers/ide/slc90e66.c        |  2 +-
 drivers/ide/tc86c001.c        |  4 ++--
 drivers/ide/triflex.c         |  2 +-
 drivers/ide/trm290.c          |  4 ++--
 drivers/ide/via82cxxx.c       |  2 +-
 39 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/drivers/ide/aec62xx.c b/drivers/ide/aec62xx.c
index 2b94583..c3518bf 100644
--- a/drivers/ide/aec62xx.c
+++ b/drivers/ide/aec62xx.c
@@ -251,7 +251,7 @@ static const struct ide_port_info aec62xx_chipsets[] __devinitconst = {
  *	chips, pass a local copy of 'struct ide_port_info' down the call chain.
  */
 
-static int __devinit aec62xx_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int aec62xx_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	const struct chipset_bus_clock_list_entry *bus_clock;
 	struct ide_port_info d;
diff --git a/drivers/ide/alim15x3.c b/drivers/ide/alim15x3.c
index 911a27c..490ca5e 100644
--- a/drivers/ide/alim15x3.c
+++ b/drivers/ide/alim15x3.c
@@ -415,7 +415,7 @@ static u8 ali_cable_detect(ide_hwif_t *hwif)
  *	Sparc systems.
  */
 
-static void __devinit init_hwif_ali15x3 (ide_hwif_t *hwif)
+static void init_hwif_ali15x3 (ide_hwif_t *hwif)
 {
 	u8 ideic, inmir;
 	s8 irq_routing_table[] = { -1,  9, 3, 10, 4,  5, 7,  6,
@@ -464,7 +464,7 @@ static void __devinit init_hwif_ali15x3 (ide_hwif_t *hwif)
  *	Set up the DMA functionality on the ALi 15x3.
  */
 
-static int __devinit init_dma_ali15x3(ide_hwif_t *hwif,
+static int init_dma_ali15x3(ide_hwif_t *hwif,
 				      const struct ide_port_info *d)
 {
 	struct pci_dev *dev = to_pci_dev(hwif->dev);
@@ -532,7 +532,7 @@ static const struct ide_port_info ali15x3_chipset __devinitconst = {
  *	hot plug layer.
  */
  
-static int __devinit alim15x3_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int alim15x3_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct ide_port_info d = ali15x3_chipset;
 	u8 rev = dev->revision, idx = id->driver_data;
diff --git a/drivers/ide/amd74xx.c b/drivers/ide/amd74xx.c
index 56fc995..eee0d1e 100644
--- a/drivers/ide/amd74xx.c
+++ b/drivers/ide/amd74xx.c
@@ -235,7 +235,7 @@ static const struct ide_port_info amd74xx_chipsets[] __devinitconst = {
 	/* 6: AMD5536 */	DECLARE_AMD_DEV(ATA_SWDMA2, ATA_UDMA5),
 };
 
-static int __devinit amd74xx_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static int amd74xx_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct ide_port_info d;
 	u8 idx = id->driver_data;
diff --git a/drivers/ide/atiixp.c b/drivers/ide/atiixp.c
index cb43480..03b1116 100644
--- a/drivers/ide/atiixp.c
+++ b/drivers/ide/atiixp.c
@@ -168,7 +168,7 @@ static const struct ide_port_info atiixp_pci_info[] __devinitconst = {
  *	finds a device matching our IDE device tables.
  */
 
-static int __devinit atiixp_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int atiixp_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	return ide_pci_init_one(dev, &atiixp_pci_info[id->driver_data], NULL);
 }
diff --git a/drivers/ide/cmd64x.c b/drivers/ide/cmd64x.c
index d1fc438..80778cd 100644
--- a/drivers/ide/cmd64x.c
+++ b/drivers/ide/cmd64x.c
@@ -373,7 +373,7 @@ static const struct ide_port_info cmd64x_chipsets[] __devinitconst = {
 	}
 };
 
-static int __devinit cmd64x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int cmd64x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct ide_port_info d;
 	u8 idx = id->driver_data;
diff --git a/drivers/ide/cs5520.c b/drivers/ide/cs5520.c
index 1444762..8fe9e04 100644
--- a/drivers/ide/cs5520.c
+++ b/drivers/ide/cs5520.c
@@ -108,7 +108,7 @@ static const struct ide_port_info cyrix_chipset __devinitconst = {
  *	work longhand.
  */
  
-static int __devinit cs5520_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int cs5520_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	const struct ide_port_info *d = &cyrix_chipset;
 	struct ide_hw hw[2], *hws[] = { NULL, NULL };
diff --git a/drivers/ide/cs5530.c b/drivers/ide/cs5530.c
index 49b40ad..a8e3605 100644
--- a/drivers/ide/cs5530.c
+++ b/drivers/ide/cs5530.c
@@ -226,7 +226,7 @@ out:
  *	performs channel-specific pre-initialization before drive probing.
  */
 
-static void __devinit init_hwif_cs5530 (ide_hwif_t *hwif)
+static void init_hwif_cs5530 (ide_hwif_t *hwif)
 {
 	unsigned long basereg;
 	u32 d0_timings;
@@ -257,7 +257,7 @@ static const struct ide_port_info cs5530_chipset __devinitconst = {
 	.udma_mask	= ATA_UDMA2,
 };
 
-static int __devinit cs5530_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int cs5530_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	return ide_pci_init_one(dev, &cs5530_chipset, NULL);
 }
diff --git a/drivers/ide/cs5535.c b/drivers/ide/cs5535.c
index 18d4c85..bf9612a 100644
--- a/drivers/ide/cs5535.c
+++ b/drivers/ide/cs5535.c
@@ -179,7 +179,7 @@ static const struct ide_port_info cs5535_chipset __devinitconst = {
 	.udma_mask	= ATA_UDMA4,
 };
 
-static int __devinit cs5535_init_one(struct pci_dev *dev,
+static int cs5535_init_one(struct pci_dev *dev,
 					const struct pci_device_id *id)
 {
 	return ide_pci_init_one(dev, &cs5535_chipset, NULL);
diff --git a/drivers/ide/cy82c693.c b/drivers/ide/cy82c693.c
index 48326ad..eb4ed41 100644
--- a/drivers/ide/cy82c693.c
+++ b/drivers/ide/cy82c693.c
@@ -145,7 +145,7 @@ static void cy82c693_set_pio_mode(ide_hwif_t *hwif, ide_drive_t *drive)
 		pci_dev_put(dev);
 }
 
-static void __devinit init_iops_cy82c693(ide_hwif_t *hwif)
+static void init_iops_cy82c693(ide_hwif_t *hwif)
 {
 	static ide_hwif_t *primary;
 	struct pci_dev *dev = to_pci_dev(hwif->dev);
@@ -173,7 +173,7 @@ static const struct ide_port_info cy82c693_chipset __devinitconst = {
 	.mwdma_mask	= ATA_MWDMA2,
 };
 
-static int __devinit cy82c693_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int cy82c693_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct pci_dev *dev2;
 	int ret = -ENODEV;
diff --git a/drivers/ide/delkin_cb.c b/drivers/ide/delkin_cb.c
index 1e10eba..1b96393 100644
--- a/drivers/ide/delkin_cb.c
+++ b/drivers/ide/delkin_cb.c
@@ -71,7 +71,7 @@ static const struct ide_port_info delkin_cb_port_info = {
 	.chipset		= ide_pci,
 };
 
-static int __devinit
+static int
 delkin_cb_probe (struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct ide_host *host;
diff --git a/drivers/ide/hpt366.c b/drivers/ide/hpt366.c
index db6553a..dc74440 100644
--- a/drivers/ide/hpt366.c
+++ b/drivers/ide/hpt366.c
@@ -1197,7 +1197,7 @@ static u8 hpt3xx_cable_detect(ide_hwif_t *hwif)
 	return (scr1 & ata66) ? ATA_CBL_PATA40 : ATA_CBL_PATA80;
 }
 
-static void __devinit init_hwif_hpt366(ide_hwif_t *hwif)
+static void init_hwif_hpt366(ide_hwif_t *hwif)
 {
 	struct hpt_info *info	= hpt3xx_get_info(hwif->dev);
 	u8  chip_type		= info->chip_type;
@@ -1221,7 +1221,7 @@ static void __devinit init_hwif_hpt366(ide_hwif_t *hwif)
 	}
 }
 
-static int __devinit init_dma_hpt366(ide_hwif_t *hwif,
+static int init_dma_hpt366(ide_hwif_t *hwif,
 				     const struct ide_port_info *d)
 {
 	struct pci_dev *dev = to_pci_dev(hwif->dev);
@@ -1265,7 +1265,7 @@ static int __devinit init_dma_hpt366(ide_hwif_t *hwif,
 	return 0;
 }
 
-static void __devinit hpt374_init(struct pci_dev *dev, struct pci_dev *dev2)
+static void hpt374_init(struct pci_dev *dev, struct pci_dev *dev2)
 {
 	if (dev2->irq != dev->irq) {
 		/* FIXME: we need a core pci_set_interrupt() */
@@ -1275,7 +1275,7 @@ static void __devinit hpt374_init(struct pci_dev *dev, struct pci_dev *dev2)
 	}
 }
 
-static void __devinit hpt371_init(struct pci_dev *dev)
+static void hpt371_init(struct pci_dev *dev)
 {
 	u8 mcr1 = 0;
 
@@ -1290,7 +1290,7 @@ static void __devinit hpt371_init(struct pci_dev *dev)
 		pci_write_config_byte(dev, 0x50, mcr1 & ~0x04);
 }
 
-static int __devinit hpt36x_init(struct pci_dev *dev, struct pci_dev *dev2)
+static int hpt36x_init(struct pci_dev *dev, struct pci_dev *dev2)
 {
 	u8 mcr1 = 0, pin1 = 0, pin2 = 0;
 
@@ -1402,7 +1402,7 @@ static const struct ide_port_info hpt366_chipsets[] __devinitconst = {
  *	Called when the PCI registration layer (or the IDE initialization)
  *	finds a device matching our IDE device tables.
  */
-static int __devinit hpt366_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int hpt366_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	const struct hpt_info *info = NULL;
 	struct hpt_info *dyn_info;
diff --git a/drivers/ide/icside.c b/drivers/ide/icside.c
index 7a31f49..d17d3a7 100644
--- a/drivers/ide/icside.c
+++ b/drivers/ide/icside.c
@@ -406,7 +406,7 @@ static const struct ide_port_info icside_v5_port_info = {
 	.chipset		= ide_acorn,
 };
 
-static int __devinit
+static int
 icside_register_v5(struct icside_state *state, struct expansion_card *ec)
 {
 	void __iomem *base;
@@ -460,7 +460,7 @@ static const struct ide_port_info icside_v6_port_info __initconst = {
 	.chipset		= ide_acorn,
 };
 
-static int __devinit
+static int
 icside_register_v6(struct icside_state *state, struct expansion_card *ec)
 {
 	void __iomem *ioc_base, *easi_base;
@@ -537,7 +537,7 @@ out:
 	return ret;
 }
 
-static int __devinit
+static int
 icside_probe(struct expansion_card *ec, const struct ecard_id *id)
 {
 	struct icside_state *state;
diff --git a/drivers/ide/ide-pci-generic.c b/drivers/ide/ide-pci-generic.c
index dab5b67..d80da09 100644
--- a/drivers/ide/ide-pci-generic.c
+++ b/drivers/ide/ide-pci-generic.c
@@ -103,7 +103,7 @@ static const struct ide_port_info generic_chipsets[] __devinitconst = {
  *	finds a device matching our IDE device tables.
  */
 
-static int __devinit generic_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int generic_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	const struct ide_port_info *d = &generic_chipsets[id->driver_data];
 	int ret = -ENODEV;
diff --git a/drivers/ide/ide_platform.c b/drivers/ide/ide_platform.c
index 073d9b9..d2b648a 100644
--- a/drivers/ide/ide_platform.c
+++ b/drivers/ide/ide_platform.c
@@ -22,7 +22,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 
-static void __devinit plat_ide_setup_ports(struct ide_hw *hw,
+static void plat_ide_setup_ports(struct ide_hw *hw,
 					   void __iomem *base,
 					   void __iomem *ctrl,
 					   struct pata_platform_info *pdata,
@@ -48,7 +48,7 @@ static const struct ide_port_info platform_ide_port_info = {
 	.chipset		= ide_generic,
 };
 
-static int __devinit plat_ide_probe(struct platform_device *pdev)
+static int plat_ide_probe(struct platform_device *pdev)
 {
 	struct resource *res_base, *res_alt, *res_irq;
 	void __iomem *base, *alt_base;
diff --git a/drivers/ide/it8172.c b/drivers/ide/it8172.c
index d5dd180..bcae804 100644
--- a/drivers/ide/it8172.c
+++ b/drivers/ide/it8172.c
@@ -125,7 +125,7 @@ static const struct ide_port_info it8172_port_info __devinitconst = {
 	.udma_mask	= ATA_UDMA2,
 };
 
-static int __devinit it8172_init_one(struct pci_dev *dev,
+static int it8172_init_one(struct pci_dev *dev,
 					const struct pci_device_id *id)
 {
 	if ((dev->class >> 8) != PCI_CLASS_STORAGE_IDE)
diff --git a/drivers/ide/it8213.c b/drivers/ide/it8213.c
index 1847aeb..2709d6e 100644
--- a/drivers/ide/it8213.c
+++ b/drivers/ide/it8213.c
@@ -177,7 +177,7 @@ static const struct ide_port_info it8213_chipset __devinitconst = {
  *	standard helper functions to do almost all the work for us.
  */
 
-static int __devinit it8213_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int it8213_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	return ide_pci_init_one(dev, &it8213_chipset, NULL);
 }
diff --git a/drivers/ide/it821x.c b/drivers/ide/it821x.c
index 6b1c72e..9084463 100644
--- a/drivers/ide/it821x.c
+++ b/drivers/ide/it821x.c
@@ -528,7 +528,7 @@ static struct ide_dma_ops it821x_pass_through_dma_ops = {
  *	ide DMA handlers appropriately
  */
 
-static void __devinit init_hwif_it821x(ide_hwif_t *hwif)
+static void init_hwif_it821x(ide_hwif_t *hwif)
 {
 	struct pci_dev *dev = to_pci_dev(hwif->dev);
 	struct ide_host *host = pci_get_drvdata(dev);
@@ -647,7 +647,7 @@ static const struct ide_port_info it821x_chipset __devinitconst = {
  *	We then use the IDE PCI generic helper to do most of the work.
  */
 
-static int __devinit it821x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int it821x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct it821x_dev *itdevs;
 	int rc;
diff --git a/drivers/ide/jmicron.c b/drivers/ide/jmicron.c
index efddd7d..0f37ea1 100644
--- a/drivers/ide/jmicron.c
+++ b/drivers/ide/jmicron.c
@@ -120,7 +120,7 @@ static const struct ide_port_info jmicron_chipset __devinitconst = {
  *	We then use the IDE PCI generic helper to do most of the work.
  */
 
-static int __devinit jmicron_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int jmicron_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	return ide_pci_init_one(dev, &jmicron_chipset, NULL);
 }
diff --git a/drivers/ide/ns87415.c b/drivers/ide/ns87415.c
index 73f78d8..080fd7d 100644
--- a/drivers/ide/ns87415.c
+++ b/drivers/ide/ns87415.c
@@ -96,7 +96,7 @@ static const struct ide_tp_ops superio_tp_ops = {
 	.output_data		= ide_output_data,
 };
 
-static void __devinit superio_init_iops(struct hwif_s *hwif)
+static void superio_init_iops(struct hwif_s *hwif)
 {
 	struct pci_dev *pdev = to_pci_dev(hwif->dev);
 	u32 dma_stat;
@@ -201,7 +201,7 @@ static int ns87415_dma_end(ide_drive_t *drive)
 	return (dma_stat & 7) != 4;
 }
 
-static void __devinit init_hwif_ns87415 (ide_hwif_t *hwif)
+static void init_hwif_ns87415 (ide_hwif_t *hwif)
 {
 	struct pci_dev *dev = to_pci_dev(hwif->dev);
 	unsigned int ctrl, using_inta;
@@ -302,7 +302,7 @@ static const struct ide_port_info ns87415_chipset __devinitconst = {
 			  IDE_HFLAG_NO_ATAPI_DMA,
 };
 
-static int __devinit ns87415_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int ns87415_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct ide_port_info d = ns87415_chipset;
 
diff --git a/drivers/ide/opti621.c b/drivers/ide/opti621.c
index 39edc66..e38eb03 100644
--- a/drivers/ide/opti621.c
+++ b/drivers/ide/opti621.c
@@ -139,7 +139,7 @@ static const struct ide_port_info opti621_chipset __devinitconst = {
 	.pio_mask	= ATA_PIO4,
 };
 
-static int __devinit opti621_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int opti621_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	return ide_pci_init_one(dev, &opti621_chipset, NULL);
 }
diff --git a/drivers/ide/palm_bk3710.c b/drivers/ide/palm_bk3710.c
index 712c790..c4b0b8f 100644
--- a/drivers/ide/palm_bk3710.c
+++ b/drivers/ide/palm_bk3710.c
@@ -220,7 +220,7 @@ static void palm_bk3710_set_pio_mode(ide_hwif_t *hwif, ide_drive_t *drive)
 	palm_bk3710_setpiomode(base, mate, is_slave, cycle_time, pio);
 }
 
-static void __devinit palm_bk3710_chipinit(void __iomem *base)
+static void palm_bk3710_chipinit(void __iomem *base)
 {
 	/*
 	 * REVISIT:  the ATA reset signal needs to be managed through a
@@ -282,7 +282,7 @@ static u8 palm_bk3710_cable_detect(ide_hwif_t *hwif)
 	return ATA_CBL_PATA80;
 }
 
-static int __devinit palm_bk3710_init_dma(ide_hwif_t *hwif,
+static int palm_bk3710_init_dma(ide_hwif_t *hwif,
 					  const struct ide_port_info *d)
 {
 	printk(KERN_INFO "    %s: MMIO-DMA\n", hwif->name);
diff --git a/drivers/ide/pdc202xx_new.c b/drivers/ide/pdc202xx_new.c
index 98110f8..322071b 100644
--- a/drivers/ide/pdc202xx_new.c
+++ b/drivers/ide/pdc202xx_new.c
@@ -422,7 +422,7 @@ static int init_chipset_pdcnew(struct pci_dev *dev)
 	return 0;
 }
 
-static struct pci_dev * __devinit pdc20270_get_dev2(struct pci_dev *dev)
+static struct pci_dev *pdc20270_get_dev2(struct pci_dev *dev)
 {
 	struct pci_dev *dev2;
 
@@ -479,7 +479,7 @@ static const struct ide_port_info pdcnew_chipsets[] __devinitconst = {
  *	finds a device matching our IDE device tables.
  */
  
-static int __devinit pdc202new_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int pdc202new_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	const struct ide_port_info *d = &pdcnew_chipsets[id->driver_data];
 	struct pci_dev *bridge = dev->bus->self;
diff --git a/drivers/ide/pdc202xx_old.c b/drivers/ide/pdc202xx_old.c
index 5634510..8056d22 100644
--- a/drivers/ide/pdc202xx_old.c
+++ b/drivers/ide/pdc202xx_old.c
@@ -211,7 +211,7 @@ out:
 	return 0;
 }
 
-static void __devinit pdc202ata4_fixup_irq(struct pci_dev *dev,
+static void pdc202ata4_fixup_irq(struct pci_dev *dev,
 					   const char *name)
 {
 	if ((dev->class >> 8) != PCI_CLASS_STORAGE_IDE) {
@@ -297,7 +297,7 @@ static const struct ide_port_info pdc202xx_chipsets[] __devinitconst = {
  *	finds a device matching our IDE device tables.
  */
  
-static int __devinit pdc202xx_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int pdc202xx_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	const struct ide_port_info *d;
 	u8 idx = id->driver_data;
diff --git a/drivers/ide/piix.c b/drivers/ide/piix.c
index fe0fd60..be144c7b 100644
--- a/drivers/ide/piix.c
+++ b/drivers/ide/piix.c
@@ -297,7 +297,7 @@ static u8 piix_cable_detect(ide_hwif_t *hwif)
  *	capabilities of the hardware.
  */
 
-static void __devinit init_hwif_piix(ide_hwif_t *hwif)
+static void init_hwif_piix(ide_hwif_t *hwif)
 {
 	if (!hwif->dma_base)
 		return;
@@ -382,7 +382,7 @@ static const struct ide_port_info piix_pci_info[] __devinitconst = {
  *	finds a device matching our IDE device tables.
  */
  
-static int __devinit piix_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int piix_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	return ide_pci_init_one(dev, &piix_pci_info[id->driver_data], NULL);
 }
@@ -394,7 +394,7 @@ static int __devinit piix_init_one(struct pci_dev *dev, const struct pci_device_
  *	they are found, disable use of DMA IDE
  */
 
-static void __devinit piix_check_450nx(void)
+static void piix_check_450nx(void)
 {
 	struct pci_dev *pdev = NULL;
 	u16 cfg;
diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
index e944c7f..97a5ba2 100644
--- a/drivers/ide/pmac.c
+++ b/drivers/ide/pmac.c
@@ -1025,7 +1025,7 @@ static const struct ide_port_info pmac_port_info = {
  * Setup, register & probe an IDE channel driven by this driver, this is
  * called by one of the 2 probe functions (macio or PCI).
  */
-static int __devinit pmac_ide_setup_device(pmac_ide_hwif_t *pmif,
+static int pmac_ide_setup_device(pmac_ide_hwif_t *pmif,
 					   struct ide_hw *hw)
 {
 	struct device_node *np = pmif->node;
@@ -1126,7 +1126,7 @@ static int __devinit pmac_ide_setup_device(pmac_ide_hwif_t *pmif,
 	return rc;
 }
 
-static void __devinit pmac_ide_init_ports(struct ide_hw *hw, unsigned long base)
+static void pmac_ide_init_ports(struct ide_hw *hw, unsigned long base)
 {
 	int i;
 
@@ -1139,7 +1139,7 @@ static void __devinit pmac_ide_init_ports(struct ide_hw *hw, unsigned long base)
 /*
  * Attach to a macio probed interface
  */
-static int __devinit
+static int
 pmac_ide_macio_attach(struct macio_dev *mdev, const struct of_device_id *match)
 {
 	void __iomem *base;
@@ -1262,7 +1262,7 @@ pmac_ide_macio_resume(struct macio_dev *mdev)
 /*
  * Attach to a PCI probed interface
  */
-static int __devinit
+static int
 pmac_ide_pci_attach(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct device_node *np;
@@ -1692,7 +1692,7 @@ static const struct ide_dma_ops pmac_dma_ops = {
  * Allocate the data structures needed for using DMA with an interface
  * and fill the proper list of functions pointers
  */
-static int __devinit pmac_ide_init_dma(ide_hwif_t *hwif,
+static int pmac_ide_init_dma(ide_hwif_t *hwif,
 				       const struct ide_port_info *d)
 {
 	pmac_ide_hwif_t *pmif =
diff --git a/drivers/ide/rapide.c b/drivers/ide/rapide.c
index 200406d..052a33e 100644
--- a/drivers/ide/rapide.c
+++ b/drivers/ide/rapide.c
@@ -29,7 +29,7 @@ static void rapide_setup_ports(struct ide_hw *hw, void __iomem *base,
 	hw->irq = irq;
 }
 
-static int __devinit
+static int
 rapide_probe(struct expansion_card *ec, const struct ecard_id *id)
 {
 	void __iomem *base;
diff --git a/drivers/ide/rz1000.c b/drivers/ide/rz1000.c
index c04173e..2c158c7 100644
--- a/drivers/ide/rz1000.c
+++ b/drivers/ide/rz1000.c
@@ -22,7 +22,7 @@
 
 #define DRV_NAME "rz1000"
 
-static int __devinit rz1000_disable_readahead(struct pci_dev *dev)
+static int rz1000_disable_readahead(struct pci_dev *dev)
 {
 	u16 reg;
 
@@ -43,7 +43,7 @@ static const struct ide_port_info rz1000_chipset __devinitconst = {
 	.host_flags	= IDE_HFLAG_NO_DMA,
 };
 
-static int __devinit rz1000_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int rz1000_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct ide_port_info d = rz1000_chipset;
 	int rc;
diff --git a/drivers/ide/sc1200.c b/drivers/ide/sc1200.c
index d4758eb..9e0419b 100644
--- a/drivers/ide/sc1200.c
+++ b/drivers/ide/sc1200.c
@@ -303,7 +303,7 @@ static const struct ide_port_info sc1200_chipset __devinitconst = {
 	.udma_mask	= ATA_UDMA2,
 };
 
-static int __devinit sc1200_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int sc1200_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct sc1200_saved_state *ss = NULL;
 	int rc;
diff --git a/drivers/ide/scc_pata.c b/drivers/ide/scc_pata.c
index f5c66be..546c7e2 100644
--- a/drivers/ide/scc_pata.c
+++ b/drivers/ide/scc_pata.c
@@ -585,7 +585,7 @@ static int scc_ide_setup_pci_device(struct pci_dev *dev,
  *	Perform the initial set up for this device.
  */
 
-static int __devinit init_setup_scc(struct pci_dev *dev,
+static int init_setup_scc(struct pci_dev *dev,
 				    const struct ide_port_info *d)
 {
 	unsigned long ctl_base;
@@ -718,7 +718,7 @@ static void scc_output_data(ide_drive_t *drive,  struct ide_cmd *cmd,
  *
  */
 
-static void __devinit init_mmio_iops_scc(ide_hwif_t *hwif)
+static void init_mmio_iops_scc(ide_hwif_t *hwif)
 {
 	struct pci_dev *dev = to_pci_dev(hwif->dev);
 	struct scc_ports *ports = pci_get_drvdata(dev);
@@ -738,7 +738,7 @@ static void __devinit init_mmio_iops_scc(ide_hwif_t *hwif)
  *	and then do the MMIO setup.
  */
 
-static void __devinit init_iops_scc(ide_hwif_t *hwif)
+static void init_iops_scc(ide_hwif_t *hwif)
 {
 	struct pci_dev *dev = to_pci_dev(hwif->dev);
 
@@ -748,7 +748,7 @@ static void __devinit init_iops_scc(ide_hwif_t *hwif)
 	init_mmio_iops_scc(hwif);
 }
 
-static int __devinit scc_init_dma(ide_hwif_t *hwif,
+static int scc_init_dma(ide_hwif_t *hwif,
 				  const struct ide_port_info *d)
 {
 	return ide_allocate_dma_engine(hwif);
@@ -768,7 +768,7 @@ static u8 scc_cable_detect(ide_hwif_t *hwif)
  *	ide DMA handlers appropriately.
  */
 
-static void __devinit init_hwif_scc(ide_hwif_t *hwif)
+static void init_hwif_scc(ide_hwif_t *hwif)
 {
 	/* PTERADD */
 	out_be32((void __iomem *)(hwif->dma_base + 0x018), hwif->dmatable_dma);
@@ -834,7 +834,7 @@ static const struct ide_port_info scc_chipset __devinitconst = {
  *	We then use the IDE PCI generic helper to do most of the work.
  */
 
-static int __devinit scc_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int scc_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	return init_setup_scc(dev, &scc_chipset);
 }
diff --git a/drivers/ide/serverworks.c b/drivers/ide/serverworks.c
index 24d72ef..3e1935b 100644
--- a/drivers/ide/serverworks.c
+++ b/drivers/ide/serverworks.c
@@ -391,7 +391,7 @@ static const struct ide_port_info serverworks_chipsets[] __devinitconst = {
  *	finds a device matching our IDE device tables.
  */
  
-static int __devinit svwks_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int svwks_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct ide_port_info d;
 	u8 idx = id->driver_data;
diff --git a/drivers/ide/sgiioc4.c b/drivers/ide/sgiioc4.c
index e3ea591..62dffeb 100644
--- a/drivers/ide/sgiioc4.c
+++ b/drivers/ide/sgiioc4.c
@@ -307,7 +307,7 @@ static u8 sgiioc4_read_status(ide_hwif_t *hwif)
 }
 
 /* Creates a DMA map for the scatter-gather list entries */
-static int __devinit ide_dma_sgiioc4(ide_hwif_t *hwif,
+static int ide_dma_sgiioc4(ide_hwif_t *hwif,
 				     const struct ide_port_info *d)
 {
 	struct pci_dev *dev = to_pci_dev(hwif->dev);
@@ -532,7 +532,7 @@ static const struct ide_port_info sgiioc4_port_info __devinitconst = {
 	.mwdma_mask		= ATA_MWDMA2_ONLY,
 };
 
-static int __devinit sgiioc4_ide_setup_pci_device(struct pci_dev *dev)
+static int sgiioc4_ide_setup_pci_device(struct pci_dev *dev)
 {
 	unsigned long cmd_base, irqport;
 	unsigned long bar0, cmd_phys_base, ctl;
@@ -581,7 +581,7 @@ req_mem_rgn_err:
 	return rc;
 }
 
-static unsigned int __devinit pci_init_sgiioc4(struct pci_dev *dev)
+static unsigned int pci_init_sgiioc4(struct pci_dev *dev)
 {
 	int ret;
 
@@ -601,7 +601,7 @@ out:
 	return ret;
 }
 
-int __devinit ioc4_ide_attach_one(struct ioc4_driver_data *idd)
+int ioc4_ide_attach_one(struct ioc4_driver_data *idd)
 {
 	/*
 	 * PCI-RT does not bring out IDE connection.
diff --git a/drivers/ide/siimage.c b/drivers/ide/siimage.c
index d8d9c0b..ff2ea1e 100644
--- a/drivers/ide/siimage.c
+++ b/drivers/ide/siimage.c
@@ -546,7 +546,7 @@ static int init_chipset_siimage(struct pci_dev *dev)
  *	extended PRD tables. For better SI3112 support use the libata driver
  */
 
-static void __devinit init_mmio_iops_siimage(ide_hwif_t *hwif)
+static void init_mmio_iops_siimage(ide_hwif_t *hwif)
 {
 	struct pci_dev *dev	= to_pci_dev(hwif->dev);
 	struct ide_host *host	= pci_get_drvdata(dev);
@@ -646,7 +646,7 @@ static void sil_quirkproc(ide_drive_t *drive)
  *	can get the iops right before using them.
  */
 
-static void __devinit init_iops_siimage(ide_hwif_t *hwif)
+static void init_iops_siimage(ide_hwif_t *hwif)
 {
 	struct pci_dev *dev = to_pci_dev(hwif->dev);
 	struct ide_host *host = pci_get_drvdata(dev);
@@ -733,7 +733,7 @@ static const struct ide_port_info siimage_chipsets[] __devinitconst = {
  *	We then use the IDE PCI generic helper to do most of the work.
  */
 
-static int __devinit siimage_init_one(struct pci_dev *dev,
+static int siimage_init_one(struct pci_dev *dev,
 				      const struct pci_device_id *id)
 {
 	void __iomem *ioaddr = NULL;
diff --git a/drivers/ide/sis5513.c b/drivers/ide/sis5513.c
index 2680dd7..3c1148d 100644
--- a/drivers/ide/sis5513.c
+++ b/drivers/ide/sis5513.c
@@ -362,7 +362,7 @@ static u8 sis_ata133_udma_filter(ide_drive_t *drive)
 	return (regdw & 0x08) ? ATA_UDMA6 : ATA_UDMA5;
 }
 
-static int __devinit sis_find_family(struct pci_dev *dev)
+static int sis_find_family(struct pci_dev *dev)
 {
 	struct pci_dev *host;
 	int i = 0;
@@ -572,7 +572,7 @@ static const struct ide_port_info sis5513_chipset __devinitconst = {
 	.mwdma_mask	= ATA_MWDMA2,
 };
 
-static int __devinit sis5513_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int sis5513_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct ide_port_info d = sis5513_chipset;
 	u8 udma_rates[] = { 0x00, 0x00, 0x07, 0x1f, 0x3f, 0x3f, 0x7f, 0x7f };
diff --git a/drivers/ide/sl82c105.c b/drivers/ide/sl82c105.c
index d051cd2..000189a 100644
--- a/drivers/ide/sl82c105.c
+++ b/drivers/ide/sl82c105.c
@@ -313,7 +313,7 @@ static const struct ide_port_info sl82c105_chipset __devinitconst = {
 	.mwdma_mask	= ATA_MWDMA2,
 };
 
-static int __devinit sl82c105_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int sl82c105_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct ide_port_info d = sl82c105_chipset;
 	u8 rev = sl82c105_bridge_revision(dev);
diff --git a/drivers/ide/slc90e66.c b/drivers/ide/slc90e66.c
index 863a5e9..2db61eb 100644
--- a/drivers/ide/slc90e66.c
+++ b/drivers/ide/slc90e66.c
@@ -142,7 +142,7 @@ static const struct ide_port_info slc90e66_chipset __devinitconst = {
 	.udma_mask	= ATA_UDMA4,
 };
 
-static int __devinit slc90e66_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int slc90e66_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	return ide_pci_init_one(dev, &slc90e66_chipset, NULL);
 }
diff --git a/drivers/ide/tc86c001.c b/drivers/ide/tc86c001.c
index 1c74504..583891a 100644
--- a/drivers/ide/tc86c001.c
+++ b/drivers/ide/tc86c001.c
@@ -144,7 +144,7 @@ static u8 tc86c001_cable_detect(ide_hwif_t *hwif)
 	return (scr1 & 0x2000) ? ATA_CBL_PATA40 : ATA_CBL_PATA80;
 }
 
-static void __devinit init_hwif_tc86c001(ide_hwif_t *hwif)
+static void init_hwif_tc86c001(ide_hwif_t *hwif)
 {
 	struct pci_dev *dev	= to_pci_dev(hwif->dev);
 	unsigned long sc_base	= pci_resource_start(dev, 5);
@@ -203,7 +203,7 @@ static const struct ide_port_info tc86c001_chipset __devinitconst = {
 	.udma_mask	= ATA_UDMA4,
 };
 
-static int __devinit tc86c001_init_one(struct pci_dev *dev,
+static int tc86c001_init_one(struct pci_dev *dev,
 				       const struct pci_device_id *id)
 {
 	int rc;
diff --git a/drivers/ide/triflex.c b/drivers/ide/triflex.c
index 55ce1b8..2ff94c7 100644
--- a/drivers/ide/triflex.c
+++ b/drivers/ide/triflex.c
@@ -101,7 +101,7 @@ static const struct ide_port_info triflex_device __devinitconst = {
 	.mwdma_mask	= ATA_MWDMA2,
 };
 
-static int __devinit triflex_init_one(struct pci_dev *dev, 
+static int triflex_init_one(struct pci_dev *dev,
 		const struct pci_device_id *id)
 {
 	return ide_pci_init_one(dev, &triflex_device, NULL);
diff --git a/drivers/ide/trm290.c b/drivers/ide/trm290.c
index e494a98..b720d89 100644
--- a/drivers/ide/trm290.c
+++ b/drivers/ide/trm290.c
@@ -231,7 +231,7 @@ static void trm290_dma_host_set(ide_drive_t *drive, int on)
 {
 }
 
-static void __devinit init_hwif_trm290(ide_hwif_t *hwif)
+static void init_hwif_trm290(ide_hwif_t *hwif)
 {
 	struct pci_dev *dev	= to_pci_dev(hwif->dev);
 	unsigned int  cfg_base	= pci_resource_start(dev, 4);
@@ -338,7 +338,7 @@ static const struct ide_port_info trm290_chipset __devinitconst = {
 			  IDE_HFLAG_NO_LBA48,
 };
 
-static int __devinit trm290_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int trm290_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	return ide_pci_init_one(dev, &trm290_chipset, NULL);
 }
diff --git a/drivers/ide/via82cxxx.c b/drivers/ide/via82cxxx.c
index 7c98e5d..dada555 100644
--- a/drivers/ide/via82cxxx.c
+++ b/drivers/ide/via82cxxx.c
@@ -416,7 +416,7 @@ static const struct ide_port_info via82cxxx_chipset __devinitconst = {
 	.mwdma_mask	= ATA_MWDMA2,
 };
 
-static int __devinit via_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int via_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct pci_dev *isa = NULL;
 	struct via_isa_bridge *via_config;
-- 
1.8.0

