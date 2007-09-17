From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/6] ide: add ide_device_add()
Date: Mon, 17 Sep 2007 22:10:04 +0200
Message-ID: <200709172210.04509.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:8879 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756295AbXIQUIZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Sep 2007 16:08:25 -0400
Received: by ug-out-1314.google.com with SMTP id z38so8883ugc
        for <linux-ide@vger.kernel.org>; Mon, 17 Sep 2007 13:08:25 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Add ide_device_add() helper and convert host drivers to use it
  instead of open-coded variants.

* Make ide_pci_setup_ports() and do_ide_setup_pci_device()
  take 'u8 *idx' argument instead of 'ata_index_t *index'.

* Remove no longer needed ata_index_t.

* Unexport probe_hwif_init() and make it static.

* Unexport ide_proc_register_port().

There should be no functionality changes caused by this patch
(sgiioc4.c: ide_proc_register_port() requires hwif->present
 to be set and it won't be set if probe_hwif_init() fails).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/icside.c          |   13 +++----
 drivers/ide/arm/rapide.c          |    8 +++-
 drivers/ide/ide-probe.c           |   23 +++++++++++-
 drivers/ide/ide-proc.c            |    2 -
 drivers/ide/ide.c                 |    7 ++-
 drivers/ide/legacy/ali14xx.c      |    7 +--
 drivers/ide/legacy/dtc2278.c      |    7 +--
 drivers/ide/legacy/ht6560b.c      |    7 +--
 drivers/ide/legacy/ide_platform.c |    6 ++-
 drivers/ide/legacy/qd65xx.c       |   21 +++++------
 drivers/ide/legacy/umc8672.c      |    9 +---
 drivers/ide/mips/au1xxx-ide.c     |    5 +-
 drivers/ide/mips/swarm.c          |    5 +-
 drivers/ide/pci/cs5520.c          |   22 +-----------
 drivers/ide/pci/sgiioc4.c         |    8 ++--
 drivers/ide/ppc/pmac.c            |    6 +--
 drivers/ide/setup-pci.c           |   69 +++++++-------------------------------
 include/linux/ide.h               |    7 +--
 18 files changed, 93 insertions(+), 139 deletions(-)

Index: b/drivers/ide/arm/icside.c
===================================================================
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -500,6 +500,7 @@ icside_register_v5(struct icside_state *
 {
 	ide_hwif_t *hwif;
 	void __iomem *base;
+	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
 	base = ecardm_iomap(ec, ECARD_RES_MEMC, 0, 0);
 	if (!base)
@@ -523,9 +524,9 @@ icside_register_v5(struct icside_state *
 
 	state->hwif[0] = hwif;
 
-	probe_hwif_init(hwif);
+	idx[0] = hwif->index;
 
-	ide_proc_register_port(hwif);
+	ide_device_add(idx);
 
 	return 0;
 }
@@ -537,6 +538,7 @@ icside_register_v6(struct icside_state *
 	void __iomem *ioc_base, *easi_base;
 	unsigned int sel = 0;
 	int ret;
+	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
 	ioc_base = ecardm_iomap(ec, ECARD_RES_IOCFAST, 0, 0);
 	if (!ioc_base) {
@@ -608,11 +610,10 @@ icside_register_v6(struct icside_state *
 		icside_dma_init(mate);
 	}
 
-	probe_hwif_init(hwif);
-	probe_hwif_init(mate);
+	idx[0] = hwif->index;
+	idx[1] = mate->index;
 
-	ide_proc_register_port(hwif);
-	ide_proc_register_port(mate);
+	ide_device_add(idx);
 
 	return 0;
 
Index: b/drivers/ide/arm/rapide.c
===================================================================
--- a/drivers/ide/arm/rapide.c
+++ b/drivers/ide/arm/rapide.c
@@ -58,6 +58,7 @@ rapide_probe(struct expansion_card *ec, 
 	ide_hwif_t *hwif;
 	void __iomem *base;
 	int ret;
+	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
 	ret = ecard_request_resources(ec);
 	if (ret)
@@ -74,8 +75,11 @@ rapide_probe(struct expansion_card *ec, 
 		hwif->hwif_data = base;
 		hwif->gendev.parent = &ec->dev;
 		hwif->noprobe = 0;
-		probe_hwif_init(hwif);
-		ide_proc_register_port(hwif);
+
+		idx[0] = hwif->index;
+
+		ide_device_add(idx);
+
 		ecard_set_drvdata(ec, hwif);
 		goto out;
 	}
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -861,7 +861,7 @@ static void probe_hwif(ide_hwif_t *hwif)
 static int hwif_init(ide_hwif_t *hwif);
 static void hwif_register_devices(ide_hwif_t *hwif);
 
-int probe_hwif_init(ide_hwif_t *hwif)
+static int probe_hwif_init(ide_hwif_t *hwif)
 {
 	probe_hwif(hwif);
 
@@ -877,8 +877,6 @@ int probe_hwif_init(ide_hwif_t *hwif)
 	return 0;
 }
 
-EXPORT_SYMBOL(probe_hwif_init);
-
 #if MAX_HWIFS > 1
 /*
  * save_match() is used to simplify logic in init_irq() below.
@@ -1410,3 +1408,22 @@ int ideprobe_init (void)
 }
 
 EXPORT_SYMBOL_GPL(ideprobe_init);
+
+int ide_device_add(u8 idx[4])
+{
+	int i, rc = 0;
+
+	for (i = 0; i < 4; i++) {
+		if (idx[i] != 0xff)
+			rc |= probe_hwif_init(&ide_hwifs[idx[i]]);
+	}
+
+	for (i = 0; i < 4; i++) {
+		if (idx[i] != 0xff)
+			ide_proc_register_port(&ide_hwifs[idx[i]]);
+	}
+
+	return rc;
+}
+
+EXPORT_SYMBOL_GPL(ide_device_add);
Index: b/drivers/ide/ide-proc.c
===================================================================
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -804,8 +804,6 @@ void ide_proc_register_port(ide_hwif_t *
 	create_proc_ide_drives(hwif);
 }
 
-EXPORT_SYMBOL_GPL(ide_proc_register_port);
-
 #ifdef CONFIG_BLK_DEV_IDEPCI
 void ide_pci_create_host_proc(const char *name, get_info_t *get_info)
 {
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -717,9 +717,10 @@ found:
 	hwif->chipset = hw->chipset;
 	hwif->gendev.parent = hw->dev;
 
-	if (!initializing) {
-		probe_hwif_init(hwif);
-		ide_proc_register_port(hwif);
+	if (initializing == 0) {
+		u8 idx[4] = { index, 0xff, 0xff, 0xff };
+
+		ide_device_add(idx);
 	}
 
 	if (hwifp)
Index: b/drivers/ide/legacy/ali14xx.c
===================================================================
--- a/drivers/ide/legacy/ali14xx.c
+++ b/drivers/ide/legacy/ali14xx.c
@@ -193,6 +193,7 @@ static int __init initRegisters (void) {
 static int __init ali14xx_probe(void)
 {
 	ide_hwif_t *hwif, *mate;
+	static u8 idx[4] = { 0, 1, 0xff, 0xff };
 
 	printk(KERN_DEBUG "ali14xx: base=0x%03x, regOn=0x%02x.\n",
 			  basePort, regOn);
@@ -217,11 +218,7 @@ static int __init ali14xx_probe(void)
 	mate->mate = hwif;
 	mate->channel = 1;
 
-	probe_hwif_init(hwif);
-	probe_hwif_init(mate);
-
-	ide_proc_register_port(hwif);
-	ide_proc_register_port(mate);
+	ide_device_add(idx);
 
 	return 0;
 }
Index: b/drivers/ide/legacy/dtc2278.c
===================================================================
--- a/drivers/ide/legacy/dtc2278.c
+++ b/drivers/ide/legacy/dtc2278.c
@@ -94,6 +94,7 @@ static int __init dtc2278_probe(void)
 {
 	unsigned long flags;
 	ide_hwif_t *hwif, *mate;
+	static u8 idx[4] = { 0, 1, 0xff, 0xff };
 
 	hwif = &ide_hwifs[0];
 	mate = &ide_hwifs[1];
@@ -134,11 +135,7 @@ static int __init dtc2278_probe(void)
 	mate->mate = hwif;
 	mate->channel = 1;
 
-	probe_hwif_init(hwif);
-	probe_hwif_init(mate);
-
-	ide_proc_register_port(hwif);
-	ide_proc_register_port(mate);
+	ide_device_add(idx);
 
 	return 0;
 }
Index: b/drivers/ide/legacy/ht6560b.c
===================================================================
--- a/drivers/ide/legacy/ht6560b.c
+++ b/drivers/ide/legacy/ht6560b.c
@@ -311,6 +311,7 @@ MODULE_PARM_DESC(probe, "probe for HT656
 int __init ht6560b_init(void)
 {
 	ide_hwif_t *hwif, *mate;
+	static u8 idx[4] = { 0, 1, 0xff, 0xff };
 	int t;
 
 	if (probe_ht6560b == 0)
@@ -359,11 +360,7 @@ int __init ht6560b_init(void)
 	mate->drives[0].drive_data = t;
 	mate->drives[1].drive_data = t;
 
-	probe_hwif_init(hwif);
-	probe_hwif_init(mate);
-
-	ide_proc_register_port(hwif);
-	ide_proc_register_port(mate);
+	ide_device_add(idx);
 
 	return 0;
 
Index: b/drivers/ide/legacy/ide_platform.c
===================================================================
--- a/drivers/ide/legacy/ide_platform.c
+++ b/drivers/ide/legacy/ide_platform.c
@@ -83,6 +83,7 @@ static int __devinit plat_ide_probe(stru
 	struct resource *res_base, *res_alt, *res_irq;
 	ide_hwif_t *hwif;
 	struct pata_platform_info *pdata;
+	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 	int ret = 0;
 	int mmio = 0;
 
@@ -130,10 +131,11 @@ static int __devinit plat_ide_probe(stru
 	hwif->gendev.parent = &pdev->dev;
 	hwif->noprobe = 0;
 
-	probe_hwif_init(hwif);
+	idx[0] = hwif->index;
+
+	ide_device_add(idx);
 
 	platform_set_drvdata(pdev, hwif);
-	ide_proc_register_port(hwif);
 
 	return 0;
 
Index: b/drivers/ide/legacy/qd65xx.c
===================================================================
--- a/drivers/ide/legacy/qd65xx.c
+++ b/drivers/ide/legacy/qd65xx.c
@@ -389,6 +389,7 @@ static void __exit qd_unsetup(ide_hwif_t
 static int __init qd_probe(int base)
 {
 	ide_hwif_t *hwif;
+	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 	u8 config;
 	u8 unit;
 
@@ -419,9 +420,9 @@ static int __init qd_probe(int base)
 
 		hwif->set_pio_mode = &qd6500_set_pio_mode;
 
-		probe_hwif_init(hwif);
+		idx[0] = unit;
 
-		ide_proc_register_port(hwif);
+		ide_device_add(idx);
 
 		return 1;
 	}
@@ -453,11 +454,11 @@ static int __init qd_probe(int base)
 
 			hwif->set_pio_mode = &qd6580_set_pio_mode;
 
-			probe_hwif_init(hwif);
+			idx[0] = unit;
 
-			qd_write_reg(QD_DEF_CONTR,QD_CONTROL_PORT);
+			ide_device_add(idx);
 
-			ide_proc_register_port(hwif);
+			qd_write_reg(QD_DEF_CONTR, QD_CONTROL_PORT);
 
 			return 1;
 		} else {
@@ -474,19 +475,17 @@ static int __init qd_probe(int base)
 
 			hwif->set_pio_mode = &qd6580_set_pio_mode;
 
-			probe_hwif_init(hwif);
-
 			qd_setup(mate, base, config | (control << 8),
 				 QD6580_DEF_DATA2, QD6580_DEF_DATA2);
 
 			mate->set_pio_mode = &qd6580_set_pio_mode;
 
-			probe_hwif_init(mate);
+			idx[0] = 0;
+			idx[1] = 1;
 
-			qd_write_reg(QD_DEF_CONTR,QD_CONTROL_PORT);
+			ide_device_add(idx);
 
-			ide_proc_register_port(hwif);
-			ide_proc_register_port(mate);
+			qd_write_reg(QD_DEF_CONTR, QD_CONTROL_PORT);
 
 			return 0; /* no other qd65xx possible */
 		}
Index: b/drivers/ide/legacy/umc8672.c
===================================================================
--- a/drivers/ide/legacy/umc8672.c
+++ b/drivers/ide/legacy/umc8672.c
@@ -124,8 +124,9 @@ static void umc_set_pio_mode(ide_drive_t
 
 static int __init umc8672_probe(void)
 {
-	unsigned long flags;
 	ide_hwif_t *hwif, *mate;
+	unsigned long flags;
+	static u8 idx[4] = { 0, 1, 0xff, 0xff };
 
 	if (!request_region(0x108, 2, "umc8672")) {
 		printk(KERN_ERR "umc8672: ports 0x108-0x109 already in use.\n");
@@ -158,11 +159,7 @@ static int __init umc8672_probe(void)
 	mate->mate = hwif;
 	mate->channel = 1;
 
-	probe_hwif_init(hwif);
-	probe_hwif_init(mate);
-
-	ide_proc_register_port(hwif);
-	ide_proc_register_port(mate);
+	ide_device_add(idx);
 
 	return 0;
 }
Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -603,6 +603,7 @@ static int au_ide_probe(struct device *d
 	struct resource *res;
 	hw_regs_t *hw;
 	int ret = 0;
+	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
 #if defined(CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA)
 	char *mode = "MWDMA2";
@@ -717,9 +718,9 @@ static int au_ide_probe(struct device *d
 	dbdma_init_done = 1;
 #endif
 
-	probe_hwif_init(hwif);
+	idx[0] = hwif->index;
 
-	ide_proc_register_port(hwif);
+	ide_device_add(idx);
 
 	dev_set_drvdata(dev, hwif);
 
Index: b/drivers/ide/mips/swarm.c
===================================================================
--- a/drivers/ide/mips/swarm.c
+++ b/drivers/ide/mips/swarm.c
@@ -71,6 +71,7 @@ static int __devinit swarm_ide_probe(str
 	u8 __iomem *base;
 	phys_t offset, size;
 	int i;
+	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
 	if (!SIBYTE_HAVE_IDE)
 		return -ENODEV;
@@ -128,9 +129,9 @@ static int __devinit swarm_ide_probe(str
 	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
 	hwif->irq = hwif->hw.irq;
 
-	probe_hwif_init(hwif);
+	idx[0] = hwif->index;
 
-	ide_proc_register_port(hwif);
+	ide_device_add(idx);
 
 	dev_set_drvdata(dev, hwif);
 
Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -154,9 +154,8 @@ static ide_pci_device_t cyrix_chipsets[]
  
 static int __devinit cs5520_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_hwif_t *hwif = NULL, *mate = NULL;
-	ata_index_t index;
 	ide_pci_device_t *d = &cyrix_chipsets[id->driver_data];
+	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
 	ide_setup_pci_noise(dev, d);
 
@@ -172,29 +171,14 @@ static int __devinit cs5520_init_one(str
 		return -ENODEV;
 	}
 
-	index.all = 0xf0f0;
-
 	/*
 	 *	Now the chipset is configured we can let the core
 	 *	do all the device setup for us
 	 */
 
-	ide_pci_setup_ports(dev, d, 14, &index);
+	ide_pci_setup_ports(dev, d, 14, &idx[0]);
 
-	if ((index.b.low & 0xf0) != 0xf0)
-		hwif = &ide_hwifs[index.b.low];
-	if ((index.b.high & 0xf0) != 0xf0)
-		mate = &ide_hwifs[index.b.high];
-
-	if (hwif)
-		probe_hwif_init(hwif);
-	if (mate)
-		probe_hwif_init(mate);
-
-	if (hwif)
-		ide_proc_register_port(hwif);
-	if (mate)
-		ide_proc_register_port(mate);
+	ide_device_add(idx);
 
 	return 0;
 }
Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -613,6 +613,7 @@ sgiioc4_ide_setup_pci_device(struct pci_
 	void __iomem *virt_base;
 	ide_hwif_t *hwif;
 	int h;
+	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
 	/*
 	 * Find an empty HWIF; if none available, return -ENOMEM.
@@ -678,11 +679,10 @@ sgiioc4_ide_setup_pci_device(struct pci_
 
 	ide_init_sgiioc4(hwif);
 
-	if (probe_hwif_init(hwif))
-		return -EIO;
+	idx[0] = hwif->index;
 
-	/* Create /proc/ide entries */
-	ide_proc_register_port(hwif);
+	if (ide_device_add(idx))
+		return -EIO;
 
 	return 0;
 }
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1039,6 +1039,7 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
 {
 	struct device_node *np = pmif->node;
 	const int *bidp;
+	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
 	pmif->cable_80 = 0;
 	pmif->broken_dma = pmif->broken_dma_warn = 0;
@@ -1163,10 +1164,9 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
 		pmac_ide_setup_dma(pmif, hwif);
 #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
 
-	/* We probe the hwif now */
-	probe_hwif_init(hwif);
+	idx[0] = hwif->index;
 
-	ide_proc_register_port(hwif);
+	ide_device_add(idx);
 
 	return 0;
 }
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -512,7 +512,7 @@ out:
  *	@dev: PCI device
  *	@d: IDE pci device info
  *	@pciirq: IRQ line
- *	@index: ata index to update
+ *	@idx: ATA index table to update
  *
  *	Scan the interfaces attached to this device and do any
  *	necessary per port setup. Attach the devices and ask the
@@ -522,15 +522,13 @@ out:
  *	but is also used directly as a helper function by some controllers
  *	where the chipset setup is not the default PCI IDE one.
  */
- 
-void ide_pci_setup_ports(struct pci_dev *dev, ide_pci_device_t *d, int pciirq, ata_index_t *index)
+
+void ide_pci_setup_ports(struct pci_dev *dev, ide_pci_device_t *d, int pciirq, u8 *idx)
 {
 	int channels = (d->host_flags & IDE_HFLAG_SINGLE) ? 1 : 2, port;
 	ide_hwif_t *hwif, *mate = NULL;
 	u8 tmp;
 
-	index->all = 0xf0f0;
-
 	/*
 	 * Set up the IDE ports
 	 */
@@ -550,11 +548,7 @@ void ide_pci_setup_ports(struct pci_dev 
 		/* setup proper ancestral information */
 		hwif->gendev.parent = &dev->dev;
 
-		if (hwif->channel) {
-			index->b.high = hwif->index;
-		} else {
-			index->b.low = hwif->index;
-		}
+		*(idx + port) = hwif->index;
 
 		
 		if (d->init_iops)
@@ -620,9 +614,8 @@ EXPORT_SYMBOL_GPL(ide_pci_setup_ports);
  * for all other chipsets, we just assume both interfaces are enabled.
  */
 static int do_ide_setup_pci_device(struct pci_dev *dev, ide_pci_device_t *d,
-				   ata_index_t *index, u8 noisy)
+				   u8 *idx, u8 noisy)
 {
-	static ata_index_t ata_index = { .b = { .low = 0xff, .high = 0xff } };
 	int tried_config = 0;
 	int pciirq, ret;
 
@@ -672,37 +665,21 @@ static int do_ide_setup_pci_device(struc
 
 	/* FIXME: silent failure can happen */
 
-	*index = ata_index;
-	ide_pci_setup_ports(dev, d, pciirq, index);
+	ide_pci_setup_ports(dev, d, pciirq, idx);
 out:
 	return ret;
 }
 
 int ide_setup_pci_device(struct pci_dev *dev, ide_pci_device_t *d)
 {
-	ide_hwif_t *hwif = NULL, *mate = NULL;
-	ata_index_t index_list;
+	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 	int ret;
 
-	ret = do_ide_setup_pci_device(dev, d, &index_list, 1);
-	if (ret < 0)
-		goto out;
+	ret = do_ide_setup_pci_device(dev, d, &idx[0], 1);
+
+	if (ret >= 0)
+		ide_device_add(idx);
 
-	if ((index_list.b.low & 0xf0) != 0xf0)
-		hwif = &ide_hwifs[index_list.b.low];
-	if ((index_list.b.high & 0xf0) != 0xf0)
-		mate = &ide_hwifs[index_list.b.high];
-
-	if (hwif)
-		probe_hwif_init(hwif);
-	if (mate)
-		probe_hwif_init(mate);
-
-	if (hwif)
-		ide_proc_register_port(hwif);
-	if (mate)
-		ide_proc_register_port(mate);
-out:
 	return ret;
 }
 
@@ -712,11 +689,11 @@ int ide_setup_pci_devices(struct pci_dev
 			  ide_pci_device_t *d)
 {
 	struct pci_dev *pdev[] = { dev1, dev2 };
-	ata_index_t index_list[2];
 	int ret, i;
+	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
 	for (i = 0; i < 2; i++) {
-		ret = do_ide_setup_pci_device(pdev[i], d, index_list + i, !i);
+		ret = do_ide_setup_pci_device(pdev[i], d, &idx[i*2], !i);
 		/*
 		 * FIXME: Mom, mom, they stole me the helper function to undo
 		 * do_ide_setup_pci_device() on the first device!
@@ -725,25 +702,7 @@ int ide_setup_pci_devices(struct pci_dev
 			goto out;
 	}
 
-	for (i = 0; i < 2; i++) {
-		u8 idx[2] = { index_list[i].b.low, index_list[i].b.high };
-		int j;
-
-		for (j = 0; j < 2; j++) {
-			if ((idx[j] & 0xf0) != 0xf0)
-				probe_hwif_init(ide_hwifs + idx[j]);
-		}
-	}
-
-	for (i = 0; i < 2; i++) {
-		u8 idx[2] = { index_list[i].b.low, index_list[i].b.high };
-		int j;
-
-		for (j = 0; j < 2; j++) {
-			if ((idx[j] & 0xf0) != 0xf0)
-				ide_proc_register_port(ide_hwifs + idx[j]);
-		}
-	}
+	ide_device_add(idx);
 out:
 	return ret;
 }
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -361,7 +361,6 @@ typedef union {
  * ATA DATA Register Special.
  * ATA NSECTOR Count Register().
  * ATAPI Byte Count Register.
- * Channel index ordering pairs.
  */
 typedef union {
 	unsigned all			:16;
@@ -376,7 +375,7 @@ typedef union {
 #error "Please fix <asm/byteorder.h>"
 #endif
 	} b;
-} ata_nsector_t, ata_data_t, atapi_bcount_t, ata_index_t;
+} ata_nsector_t, ata_data_t, atapi_bcount_t;
 
 /*
  * ATA-IDE Select Register, aka Device-Head
@@ -1205,7 +1204,7 @@ extern int __ide_pci_register_driver(str
 #define ide_pci_register_driver(d) pci_register_driver(d)
 #endif
 
-void ide_pci_setup_ports(struct pci_dev *, struct ide_pci_device_s *, int, ata_index_t *);
+void ide_pci_setup_ports(struct pci_dev *, struct ide_pci_device_s *, int, u8 *);
 extern void ide_setup_pci_noise (struct pci_dev *dev, struct ide_pci_device_s *d);
 
 extern void default_hwif_iops(ide_hwif_t *);
@@ -1383,7 +1382,7 @@ void ide_unregister_region(struct gendis
 
 void ide_undecoded_slave(ide_hwif_t *);
 
-extern int probe_hwif_init(ide_hwif_t *);
+int ide_device_add(u8 idx[4]);
 
 static inline void *ide_get_hwifdata (ide_hwif_t * hwif)
 {
