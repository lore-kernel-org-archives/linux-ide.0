From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 16/21] ide: add ide_init_port_hw() helper
Date: Sun, 18 Nov 2007 23:28:15 +0100
Message-ID: <200711182328.15772.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:48323 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177AbXKRWgs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 17:36:48 -0500
Received: by ug-out-1314.google.com with SMTP id z38so873016ugc
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 14:36:47 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, Anton Vorontsov <avorontsov@ru.mvista.com>, Jeremy Higdon <jeremy@sgi.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>


* Add ide_init_port_hw() helper.

* rapide.c: convert rapide_locate_hwif() to rapide_setup_ports()
  and use ide_init_port_hw().

* ide_platform.c: convert plat_ide_locate_hwif() to plat_ide_setup_ports()
  and use ide_init_port_hw().

* sgiioc4.c: use ide_init_port_hw().

* pmac.c: add 'hw_regs_t *hw' argument to pmac_ide_setup_device(),
  setup 'hw' in pmac_ide_{macio,pci}_attach() and use ide_init_port_hw()
  in pmac_ide_setup_device().

This patch is a preparation for the future changes in the IDE probing code.

There should be no functionality changes caused by this patch.

Cc: Russell King <rmk@arm.linux.org.uk>
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Jeremy Higdon <jeremy@sgi.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/rapide.c          |   34 +++++++++++------------
 drivers/ide/ide.c                 |   19 ++++++++-----
 drivers/ide/legacy/ide_platform.c |   55 +++++++++++++++++++-------------------
 drivers/ide/pci/sgiioc4.c         |    9 ++----
 drivers/ide/ppc/pmac.c            |   29 ++++++++++++--------
 include/linux/ide.h               |    1 
 6 files changed, 81 insertions(+), 66 deletions(-)

Index: b/drivers/ide/arm/rapide.c
===================================================================
--- a/drivers/ide/arm/rapide.c
+++ b/drivers/ide/arm/rapide.c
@@ -13,26 +13,18 @@
 
 #include <asm/ecard.h>
 
-static ide_hwif_t *
-rapide_locate_hwif(void __iomem *base, void __iomem *ctrl, unsigned int sz, int irq)
+static void rapide_setup_ports(hw_regs_t *hw, void __iomem *base,
+			       void __iomem *ctrl, unsigned int sz, int irq)
 {
 	unsigned long port = (unsigned long)base;
-	ide_hwif_t *hwif = ide_find_port(port);
 	int i;
 
-	if (hwif == NULL)
-		goto out;
-
 	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hwif->io_ports[i] = port;
+		hw->io_ports[i] = port;
 		port += sz;
 	}
-	hwif->io_ports[IDE_CONTROL_OFFSET] = (unsigned long)ctrl;
-	hwif->irq = irq;
-	hwif->mmio = 1;
-	default_hwif_mmiops(hwif);
-out:
-	return hwif;
+	hw->io_ports[IDE_CONTROL_OFFSET] = (unsigned long)ctrl;
+	hw->irq = irq;
 }
 
 static int __devinit
@@ -42,6 +34,7 @@ rapide_probe(struct expansion_card *ec, 
 	void __iomem *base;
 	int ret;
 	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
+	hw_regs_t hw;
 
 	ret = ecard_request_resources(ec);
 	if (ret)
@@ -53,12 +46,19 @@ rapide_probe(struct expansion_card *ec, 
 		goto release;
 	}
 
-	hwif = rapide_locate_hwif(base, base + 0x818, 1 << 6, ec->irq);
+	hwif = ide_find_port((unsigned long)base);
 	if (hwif) {
-		hwif->chipset = ide_generic;
+		memset(&hw, 0, sizeof(hw));
+		rapide_setup_ports(&hw, base, base + 0x818, 1 << 6, ec->irq);
+		hw.chipset = ide_generic;
+		hw.dev = &ec->dev;
+
+		ide_init_port_hw(hwif, &hw);
+
+		hwif->mmio = 1;
+		default_hwif_mmiops(hwif);
+
 		hwif->hwif_data = base;
-		hwif->gendev.parent = &ec->dev;
-		hwif->noprobe = 0;
 
 		idx[0] = hwif->index;
 
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -675,6 +675,17 @@ void ide_setup_ports (	hw_regs_t *hw,
  */
 }
 
+void ide_init_port_hw(ide_hwif_t *hwif, hw_regs_t *hw)
+{
+	memcpy(hwif->io_ports, hw->io_ports, sizeof(hwif->io_ports));
+	hwif->irq = hw->irq;
+	hwif->noprobe = 0;
+	hwif->chipset = hw->chipset;
+	hwif->gendev.parent = hw->dev;
+	hwif->ack_intr = hw->ack_intr;
+}
+EXPORT_SYMBOL_GPL(ide_init_port_hw);
+
 /**
  *	ide_register_hw		-	register IDE interface
  *	@hw: hardware registers
@@ -729,13 +740,9 @@ found:
 	}
 	if (hwif->present)
 		return -1;
-	memcpy(hwif->io_ports, hw->io_ports, sizeof(hwif->io_ports));
-	hwif->irq = hw->irq;
-	hwif->noprobe = 0;
+
+	ide_init_port_hw(hwif, hw);
 	hwif->quirkproc = quirkproc;
-	hwif->chipset = hw->chipset;
-	hwif->gendev.parent = hw->dev;
-	hwif->ack_intr = hw->ack_intr;
 
 	if (initializing == 0) {
 		u8 idx[4] = { index, 0xff, 0xff, 0xff };
Index: b/drivers/ide/legacy/ide_platform.c
===================================================================
--- a/drivers/ide/legacy/ide_platform.c
+++ b/drivers/ide/legacy/ide_platform.c
@@ -28,39 +28,27 @@ static struct {
 	int index;
 } hwif_prop;
 
-static ide_hwif_t *__devinit plat_ide_locate_hwif(void __iomem *base,
-	    void __iomem *ctrl, struct pata_platform_info *pdata, int irq,
-	    int mmio)
+static void __devinit plat_ide_setup_ports(hw_regs_t *hw,
+					   void __iomem *base,
+					   void __iomem *ctrl,
+					   struct pata_platform_info *pdata,
+					   int irq)
 {
 	unsigned long port = (unsigned long)base;
-	ide_hwif_t *hwif = ide_find_port(port);
 	int i;
 
-	if (hwif == NULL)
-		goto out;
-
-	hwif->io_ports[IDE_DATA_OFFSET] = port;
+	hw->io_ports[IDE_DATA_OFFSET] = port;
 
 	port += (1 << pdata->ioport_shift);
 	for (i = IDE_ERROR_OFFSET; i <= IDE_STATUS_OFFSET;
 	     i++, port += (1 << pdata->ioport_shift))
-		hwif->io_ports[i] = port;
-
-	hwif->io_ports[IDE_CONTROL_OFFSET] = (unsigned long)ctrl;
+		hw->io_ports[i] = port;
 
-	hwif->irq = irq;
+	hw->io_ports[IDE_CONTROL_OFFSET] = (unsigned long)ctrl;
 
-	hwif->chipset = ide_generic;
+	hw->irq = irq;
 
-	if (mmio) {
-		hwif->mmio = 1;
-		default_hwif_mmiops(hwif);
-	}
-
-	hwif_prop.hwif = hwif;
-	hwif_prop.index = hwif->index;
-out:
-	return hwif;
+	hw->chipset = ide_generic;
 }
 
 static int __devinit plat_ide_probe(struct platform_device *pdev)
@@ -71,6 +59,7 @@ static int __devinit plat_ide_probe(stru
 	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 	int ret = 0;
 	int mmio = 0;
+	hw_regs_t hw;
 
 	pdata = pdev->dev.platform_data;
 
@@ -106,15 +95,27 @@ static int __devinit plat_ide_probe(stru
 			res_alt->start, res_alt->end - res_alt->start + 1);
 	}
 
-	hwif = plat_ide_locate_hwif(hwif_prop.plat_ide_mapbase,
-	         hwif_prop.plat_ide_alt_mapbase, pdata, res_irq->start, mmio);
-
+	hwif = ide_find_port((unsigned long)hwif_prop.plat_ide_mapbase);
 	if (!hwif) {
 		ret = -ENODEV;
 		goto out;
 	}
-	hwif->gendev.parent = &pdev->dev;
-	hwif->noprobe = 0;
+
+	memset(&hw, 0, sizeof(hw));
+	plat_ide_setup_ports(&hw, hwif_prop.plat_ide_mapbase,
+			     hwif_prop.plat_ide_alt_mapbase,
+			     pdata, res_irq->start);
+	hw.dev = &pdev->dev;
+
+	ide_init_port_hw(hwif, &hw);
+
+	if (mmio) {
+		hwif->mmio = 1;
+		default_hwif_mmiops(hwif);
+	}
+
+	hwif_prop.hwif = hwif;
+	hwif_prop.index = hwif->index;
 
 	idx[0] = hwif->index;
 
Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -636,14 +636,13 @@ sgiioc4_ide_setup_pci_device(struct pci_
 	/* Initialize the IO registers */
 	memset(&hw, 0, sizeof(hw));
 	sgiioc4_init_hwif_ports(&hw, cmd_base, ctl, irqport);
-	memcpy(hwif->io_ports, hw.io_ports, sizeof(hwif->io_ports));
-	hwif->noprobe = 0;
+	hw.irq = dev->irq;
+	hw.chipset = ide_pci;
+	hw.dev = &dev->dev;
+	ide_init_port_hw(hwif, &hw);
 
-	hwif->irq = dev->irq;
-	hwif->chipset = ide_pci;
 	hwif->pci_dev = dev;
 	hwif->channel = 0;	/* Single Channel chip */
-	hwif->gendev.parent = &dev->dev;/* setup proper ancestral information */
 
 	/* The IOC4 uses MMIO rather than Port IO. */
 	default_hwif_mmiops(hwif);
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1012,12 +1012,11 @@ pmac_ide_do_resume(ide_hwif_t *hwif)
  * rare machines unfortunately, but it's better this way.
  */
 static int
-pmac_ide_setup_device(pmac_ide_hwif_t *pmif, ide_hwif_t *hwif)
+pmac_ide_setup_device(pmac_ide_hwif_t *pmif, ide_hwif_t *hwif, hw_regs_t *hw)
 {
 	struct device_node *np = pmif->node;
 	const int *bidp;
 	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
-	hw_regs_t hw;
 
 	pmif->cable_80 = 0;
 	pmif->broken_dma = pmif->broken_dma_warn = 0;
@@ -1103,11 +1102,9 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
 	/* Tell common code _not_ to mess with resources */
 	hwif->mmio = 1;
 	hwif->hwif_data = pmif;
-	memset(&hw, 0, sizeof(hw));
-	pmac_ide_init_hwif_ports(&hw, pmif->regbase, 0, &hwif->irq);
-	memcpy(hwif->io_ports, hw.io_ports, sizeof(hwif->io_ports));
-	hwif->chipset = ide_pmac;
-	hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET] || pmif->mediabay;
+	hw->chipset = ide_pmac;
+	ide_init_port_hw(hwif, hw);
+	hwif->noprobe = pmif->mediabay;
 	hwif->hold = pmif->mediabay;
 	hwif->cbl = pmif->cable_80 ? ATA_CBL_PATA80 : ATA_CBL_PATA40;
 	hwif->drives[0].unmask = 1;
@@ -1163,6 +1160,7 @@ pmac_ide_macio_attach(struct macio_dev *
 	ide_hwif_t *hwif;
 	pmac_ide_hwif_t *pmif;
 	int i, rc;
+	hw_regs_t hw;
 
 	i = 0;
 	while (i < MAX_HWIFS && (ide_hwifs[i].io_ports[IDE_DATA_OFFSET] != 0
@@ -1205,7 +1203,6 @@ pmac_ide_macio_attach(struct macio_dev *
 	regbase = (unsigned long) base;
 
 	hwif->pci_dev = mdev->bus->pdev;
-	hwif->gendev.parent = &mdev->ofdev.dev;
 
 	pmif->mdev = mdev;
 	pmif->node = mdev->ofdev.node;
@@ -1223,7 +1220,12 @@ pmac_ide_macio_attach(struct macio_dev *
 #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
 	dev_set_drvdata(&mdev->ofdev.dev, hwif);
 
-	rc = pmac_ide_setup_device(pmif, hwif);
+	memset(&hw, 0, sizeof(hw));
+	pmac_ide_init_hwif_ports(&hw, pmif->regbase, 0, NULL);
+	hw.irq = irq;
+	hw.dev = &mdev->ofdev.dev;
+
+	rc = pmac_ide_setup_device(pmif, hwif, &hw);
 	if (rc != 0) {
 		/* The inteface is released to the common IDE layer */
 		dev_set_drvdata(&mdev->ofdev.dev, NULL);
@@ -1282,6 +1284,7 @@ pmac_ide_pci_attach(struct pci_dev *pdev
 	void __iomem *base;
 	unsigned long rbase, rlen;
 	int i, rc;
+	hw_regs_t hw;
 
 	np = pci_device_to_OF_node(pdev);
 	if (np == NULL) {
@@ -1315,7 +1318,6 @@ pmac_ide_pci_attach(struct pci_dev *pdev
 	}
 
 	hwif->pci_dev = pdev;
-	hwif->gendev.parent = &pdev->dev;
 	pmif->mdev = NULL;
 	pmif->node = np;
 
@@ -1332,7 +1334,12 @@ pmac_ide_pci_attach(struct pci_dev *pdev
 
 	pci_set_drvdata(pdev, hwif);
 
-	rc = pmac_ide_setup_device(pmif, hwif);
+	memset(&hw, 0, sizeof(hw));
+	pmac_ide_init_hwif_ports(&hw, pmif->regbase, 0, NULL);
+	hw.irq = pdev->irq;
+	hw.dev = &pdev->dev;
+
+	rc = pmac_ide_setup_device(pmif, hwif, &hw);
 	if (rc != 0) {
 		/* The inteface is released to the common IDE layer */
 		pci_set_drvdata(pdev, NULL);
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -198,6 +198,7 @@ typedef struct hw_regs_s {
 } hw_regs_t;
 
 struct hwif_s * ide_find_port(unsigned long);
+void ide_init_port_hw(struct hwif_s *, hw_regs_t *);
 
 struct ide_drive_s;
 int ide_register_hw(hw_regs_t *, void (*)(struct ide_drive_s *), int,
