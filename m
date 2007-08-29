From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/10] hpt366: remove ->init_setup
Date: Wed, 29 Aug 2007 23:21:03 +0200
Message-ID: <200708292321.03722.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:44265 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756611AbXH2VZU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Aug 2007 17:25:20 -0400
Received: by nf-out-0910.google.com with SMTP id g13so293505nfb
        for <linux-ide@vger.kernel.org>; Wed, 29 Aug 2007 14:25:18 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>


* Split off hpt{374,371,366}_init() helper from init_setup_hpt{374,371,366}().

* Merge init_setup_{374,372n,371,372a,302,366}() into hpt366_init_one().

While at it:

* Use "HPT36x" name for HPT366/HPT368 chipsets.

* Add .chip_name to struct hpt_info and use it to set set d->name.

* Convert .max_ultra in struct hpt_info to .udma_mask and use it to set
  d->udma_mask.

* Fix hpt302 to use HPT302_ALLOW_ATA133_6 define.

* Change HPT366/HPT374 interrupt fixup message from KERN_WARNING to KERN_INFO.

* Use the second hpt366_chipsets[] entry for HPT37x chipsets using HPT36x PCI
  device ID and fix .enablebits/.host_flags for HPT36x hpt366_chipsets[] entry.

* Bump driver version.

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/hpt366.c |  306 +++++++++++++++++++----------------------------
 1 file changed, 127 insertions(+), 179 deletions(-)

Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -1,9 +1,10 @@
 /*
- * linux/drivers/ide/pci/hpt366.c		Version 1.13	Aug 20, 2007
+ * linux/drivers/ide/pci/hpt366.c		Version 1.14	Aug 28, 2007
  *
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
  * Portions Copyright (C) 2003		Red Hat Inc
+ * Portions Copyright (C) 2007		Bartlomiej Zolnierkiewicz
  * Portions Copyright (C) 2005-2007	MontaVista Software, Inc.
  *
  * Thanks to HighPoint Technologies for their assistance, and hardware.
@@ -393,8 +394,9 @@ enum ata_clock {
  */
 
 struct hpt_info {
+	char *chip_name;	/* Chip name */
 	u8 chip_type;		/* Chip type */
-	u8 max_ultra;		/* Max. UltraDMA mode allowed */
+	u8 udma_mask;		/* Allowed UltraDMA modes mask. */
 	u8 dpll_clk;		/* DPLL clock in MHz */
 	u8 pci_clk;		/* PCI  clock in MHz */
 	u32 **settings; 	/* Chipset settings table */
@@ -432,78 +434,89 @@ static u32 *hpt37x_settings[NUM_ATA_CLOC
 };
 
 static struct hpt_info hpt36x __devinitdata = {
+	.chip_name	= "HPT36x",
 	.chip_type	= HPT36x,
-	.max_ultra	= HPT366_ALLOW_ATA66_3 ? (HPT366_ALLOW_ATA66_4 ? 4 : 3) : 2,
+	.udma_mask	= HPT366_ALLOW_ATA66_3 ? (HPT366_ALLOW_ATA66_4 ? ATA_UDMA4 : ATA_UDMA3) : ATA_UDMA2,
 	.dpll_clk	= 0,	/* no DPLL */
 	.settings	= hpt36x_settings
 };
 
 static struct hpt_info hpt370 __devinitdata = {
+	.chip_name	= "HPT370",
 	.chip_type	= HPT370,
-	.max_ultra	= HPT370_ALLOW_ATA100_5 ? 5 : 4,
+	.udma_mask	= HPT370_ALLOW_ATA100_5 ? ATA_UDMA5 : ATA_UDMA4,
 	.dpll_clk	= 48,
 	.settings	= hpt37x_settings
 };
 
 static struct hpt_info hpt370a __devinitdata = {
+	.chip_name	= "HPT370A",
 	.chip_type	= HPT370A,
-	.max_ultra	= HPT370_ALLOW_ATA100_5 ? 5 : 4,
+	.udma_mask	= HPT370_ALLOW_ATA100_5 ? ATA_UDMA5 : ATA_UDMA4,
 	.dpll_clk	= 48,
 	.settings	= hpt37x_settings
 };
 
 static struct hpt_info hpt374 __devinitdata = {
+	.chip_name	= "HPT374",
 	.chip_type	= HPT374,
-	.max_ultra	= 5,
+	.udma_mask	= ATA_UDMA5,
 	.dpll_clk	= 48,
 	.settings	= hpt37x_settings
 };
 
 static struct hpt_info hpt372 __devinitdata = {
+	.chip_name	= "HPT372",
 	.chip_type	= HPT372,
-	.max_ultra	= HPT372_ALLOW_ATA133_6 ? 6 : 5,
+	.udma_mask	= HPT372_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
 	.dpll_clk	= 55,
 	.settings	= hpt37x_settings
 };
 
 static struct hpt_info hpt372a __devinitdata = {
+	.chip_name	= "HPT372A",
 	.chip_type	= HPT372A,
-	.max_ultra	= HPT372_ALLOW_ATA133_6 ? 6 : 5,
+	.udma_mask	= HPT372_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
 	.dpll_clk	= 66,
 	.settings	= hpt37x_settings
 };
 
 static struct hpt_info hpt302 __devinitdata = {
+	.chip_name	= "HPT302",
 	.chip_type	= HPT302,
-	.max_ultra	= HPT372_ALLOW_ATA133_6 ? 6 : 5,
+	.udma_mask	= HPT302_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
 	.dpll_clk	= 66,
 	.settings	= hpt37x_settings
 };
 
 static struct hpt_info hpt371 __devinitdata = {
+	.chip_name	= "HPT371",
 	.chip_type	= HPT371,
-	.max_ultra	= HPT371_ALLOW_ATA133_6 ? 6 : 5,
+	.udma_mask	= HPT371_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
 	.dpll_clk	= 66,
 	.settings	= hpt37x_settings
 };
 
 static struct hpt_info hpt372n __devinitdata = {
+	.chip_name	= "HPT372N",
 	.chip_type	= HPT372N,
-	.max_ultra	= HPT372_ALLOW_ATA133_6 ? 6 : 5,
+	.udma_mask	= HPT372_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
 	.dpll_clk	= 77,
 	.settings	= hpt37x_settings
 };
 
 static struct hpt_info hpt302n __devinitdata = {
+	.chip_name	= "HPT302N",
 	.chip_type	= HPT302N,
-	.max_ultra	= HPT302_ALLOW_ATA133_6 ? 6 : 5,
+	.udma_mask	= HPT302_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
 	.dpll_clk	= 77,
 	.settings	= hpt37x_settings
 };
 
 static struct hpt_info hpt371n __devinitdata = {
+	.chip_name	= "HPT371N",
 	.chip_type	= HPT371N,
-	.max_ultra	= HPT371_ALLOW_ATA133_6 ? 6 : 5,
+	.udma_mask	= HPT371_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
 	.dpll_clk	= 77,
 	.settings	= hpt37x_settings
 };
@@ -1118,7 +1131,7 @@ static unsigned int __devinit init_chips
 		  * Select 66 MHz DPLL clock only if UltraATA/133 mode is
 		  * supported/enabled, use 50 MHz DPLL clock otherwise...
 		  */
-		if (info->max_ultra == 6) {
+		if (info->udma_mask == ATA_UDMA6) {
 			dpll_clk = 66;
 			clock = ATA_CLOCK_66MHZ;
 		} else if (dpll_clk) {	/* HPT36x chips don't have DPLL */
@@ -1347,53 +1360,19 @@ static void __devinit init_dma_hpt366(id
 	ide_setup_dma(hwif, dmabase, 8);
 }
 
-static int __devinit init_setup_hpt374(struct pci_dev *dev, ide_pci_device_t *d)
+static void __devinit hpt374_init(struct pci_dev *dev, struct pci_dev *dev2)
 {
-	struct pci_dev *dev2;
-
-	if (PCI_FUNC(dev->devfn) & 1)
-		return -ENODEV;
-
-	pci_set_drvdata(dev, &hpt374);
-
-	if ((dev2 = pci_get_slot(dev->bus, dev->devfn + 1)) != NULL) {
-		int ret;
-
-		pci_set_drvdata(dev2, &hpt374);
-
-		if (dev2->irq != dev->irq) {
-			/* FIXME: we need a core pci_set_interrupt() */
-			dev2->irq = dev->irq;
-			printk(KERN_WARNING "%s: PCI config space interrupt "
-			       "fixed.\n", d->name);
-		}
-		ret = ide_setup_pci_devices(dev, dev2, d);
-		if (ret < 0)
-			pci_dev_put(dev2);
-		return ret;
+	if (dev2->irq != dev->irq) {
+		/* FIXME: we need a core pci_set_interrupt() */
+		dev2->irq = dev->irq;
+		printk(KERN_INFO "HPT374: PCI config space interrupt fixed\n");
 	}
-	return ide_setup_pci_device(dev, d);
-}
-
-static int __devinit init_setup_hpt372n(struct pci_dev *dev, ide_pci_device_t *d)
-{
-	pci_set_drvdata(dev, &hpt372n);
-
-	return ide_setup_pci_device(dev, d);
 }
 
-static int __devinit init_setup_hpt371(struct pci_dev *dev, ide_pci_device_t *d)
+static void __devinit hpt371_init(struct pci_dev *dev)
 {
-	struct hpt_info *info;
 	u8 mcr1 = 0;
 
-	if (dev->revision > 1) {
-		d->name = "HPT371N";
-
-		info = &hpt371n;
-	} else
-		info = &hpt371;
-
 	/*
 	 * HPT371 chips physically have only one channel, the secondary one,
 	 * but the primary channel registers do exist!  Go figure...
@@ -1403,173 +1382,83 @@ static int __devinit init_setup_hpt371(s
 	pci_read_config_byte(dev, 0x50, &mcr1);
 	if (mcr1 & 0x04)
 		pci_write_config_byte(dev, 0x50, mcr1 & ~0x04);
-
-	pci_set_drvdata(dev, info);
-
-	return ide_setup_pci_device(dev, d);
-}
-
-static int __devinit init_setup_hpt372a(struct pci_dev *dev, ide_pci_device_t *d)
-{
-	struct hpt_info *info;
-
-	if (dev->revision > 1) {
-		d->name = "HPT372N";
-
-		info = &hpt372n;
-	} else
-		info = &hpt372a;
-	pci_set_drvdata(dev, info);
-
-	return ide_setup_pci_device(dev, d);
 }
 
-static int __devinit init_setup_hpt302(struct pci_dev *dev, ide_pci_device_t *d)
+static int __devinit hpt36x_init(struct pci_dev *dev, struct pci_dev *dev2)
 {
-	struct hpt_info *info;
+	u8 mcr1 = 0, pin1 = 0, pin2 = 0;
 
-	if (dev->revision > 1) {
-		d->name = "HPT302N";
-
-		info = &hpt302n;
-	} else
-		info = &hpt302;
-	pci_set_drvdata(dev, info);
-
-	return ide_setup_pci_device(dev, d);
-}
-
-static int __devinit init_setup_hpt366(struct pci_dev *dev, ide_pci_device_t *d)
-{
-	struct pci_dev *dev2;
-	u8 rev = dev->revision;
-	static char   *chipset_names[] = { "HPT366", "HPT366",  "HPT368",
-					   "HPT370", "HPT370A", "HPT372",
-					   "HPT372N" };
-	static struct hpt_info *info[] = { &hpt36x,  &hpt36x,  &hpt36x,
-					   &hpt370,  &hpt370a, &hpt372,
-					   &hpt372n  };
+	/*
+	 * Now we'll have to force both channels enabled if
+	 * at least one of them has been enabled by BIOS...
+	 */
+	pci_read_config_byte(dev, 0x50, &mcr1);
+	if (mcr1 & 0x30)
+		pci_write_config_byte(dev, 0x50, mcr1 | 0x30);
 
-	if (PCI_FUNC(dev->devfn) & 1)
-		return -ENODEV;
+	pci_read_config_byte(dev,  PCI_INTERRUPT_PIN, &pin1);
+	pci_read_config_byte(dev2, PCI_INTERRUPT_PIN, &pin2);
 
-	switch (rev) {
-	case 0:
-	case 1:
-	case 2:
-		/*
-		 * HPT36x chips have one channel per function and have
-		 * both channel enable bits located differently and visible
-		 * to both functions -- really stupid design decision... :-(
-		 * Bit 4 is for the primary channel, bit 5 for the secondary.
-		 */
-		d->host_flags |= IDE_HFLAG_SINGLE;
-		d->enablebits[0].mask = d->enablebits[0].val = 0x10;
-
-		d->udma_mask = HPT366_ALLOW_ATA66_3 ? (HPT366_ALLOW_ATA66_4 ?
-			       ATA_UDMA4 : ATA_UDMA3) : ATA_UDMA2;
-		break;
-	case 3:
-	case 4:
-		d->udma_mask = HPT370_ALLOW_ATA100_5 ? ATA_UDMA5 : ATA_UDMA4;
-		break;
-	default:
-		rev = 6;
-		/* fall thru */
-	case 5:
-	case 6:
-		d->udma_mask = HPT372_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5;
-		break;
+	if (pin1 != pin2 && dev->irq == dev2->irq) {
+		printk(KERN_INFO "HPT36x: onboard version of chipset, "
+				 "pin1=%d pin2=%d\n", pin1, pin2);
+		return 1;
 	}
 
-	d->name = chipset_names[rev];
-
-	pci_set_drvdata(dev, info[rev]);
-
-	if (rev > 2)
-		goto init_single;
-
-	if ((dev2 = pci_get_slot(dev->bus, dev->devfn + 1)) != NULL) {
-		u8  mcr1 = 0, pin1 = 0, pin2 = 0;
-		int ret;
-
-		pci_set_drvdata(dev2, info[rev]);
-
-		/*
-		 * Now we'll have to force both channels enabled if
-		 * at least one of them has been enabled by BIOS...
-		 */
-		pci_read_config_byte(dev, 0x50, &mcr1);
-		if (mcr1 & 0x30)
-			pci_write_config_byte(dev, 0x50, mcr1 | 0x30);
-
-		pci_read_config_byte(dev,  PCI_INTERRUPT_PIN, &pin1);
-		pci_read_config_byte(dev2, PCI_INTERRUPT_PIN, &pin2);
-		if (pin1 != pin2 && dev->irq == dev2->irq) {
-			d->host_flags |= IDE_HFLAG_BOOTABLE;
-			printk("%s: onboard version of chipset, pin1=%d pin2=%d\n",
-			       d->name, pin1, pin2);
-		}
-		ret = ide_setup_pci_devices(dev, dev2, d);
-		if (ret < 0)
-			pci_dev_put(dev2);
-		return ret;
-	}
-init_single:
-	return ide_setup_pci_device(dev, d);
+	return 0;
 }
 
 static ide_pci_device_t hpt366_chipsets[] __devinitdata = {
 	{	/* 0 */
-		.name		= "HPT366",
-		.init_setup	= init_setup_hpt366,
+		.name		= "HPT36x",
 		.init_chipset	= init_chipset_hpt366,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
-		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
+		/*
+		 * HPT36x chips have one channel per function and have
+		 * both channel enable bits located differently and visible
+		 * to both functions -- really stupid design decision... :-(
+		 * Bit 4 is for the primary channel, bit 5 for the secondary.
+		 */
+		.enablebits	= {{0x50,0x10,0x10}, {0x54,0x04,0x04}},
 		.extra		= 240,
-		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
+		.host_flags	= IDE_HFLAG_SINGLE |
+				  IDE_HFLAG_NO_ATAPI_DMA |
+				  IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 	},{	/* 1 */
 		.name		= "HPT372A",
-		.init_setup	= init_setup_hpt372a,
 		.init_chipset	= init_chipset_hpt366,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
-		.udma_mask	= HPT372_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
 		.extra		= 240,
 		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 	},{	/* 2 */
 		.name		= "HPT302",
-		.init_setup	= init_setup_hpt302,
 		.init_chipset	= init_chipset_hpt366,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
-		.udma_mask	= HPT302_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
 		.extra		= 240,
 		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 	},{	/* 3 */
 		.name		= "HPT371",
-		.init_setup	= init_setup_hpt371,
 		.init_chipset	= init_chipset_hpt366,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
-		.udma_mask	= HPT371_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
 		.extra		= 240,
 		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 	},{	/* 4 */
 		.name		= "HPT374",
-		.init_setup	= init_setup_hpt374,
 		.init_chipset	= init_chipset_hpt366,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
@@ -1581,12 +1470,10 @@ static ide_pci_device_t hpt366_chipsets[
 		.mwdma_mask	= ATA_MWDMA2,
 	},{	/* 5 */
 		.name		= "HPT372N",
-		.init_setup	= init_setup_hpt372n,
 		.init_chipset	= init_chipset_hpt366,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
-		.udma_mask	= HPT372_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
 		.extra		= 240,
 		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
@@ -1601,16 +1488,77 @@ static ide_pci_device_t hpt366_chipsets[
  *
  *	Called when the PCI registration layer (or the IDE initialization)
  *	finds a device matching our IDE device tables.
- *
- *	NOTE: since we'll have to modify some fields of the ide_pci_device_t
- *	structure depending on the chip's revision, we'd better pass a local
- *	copy down the call chain...
  */
 static int __devinit hpt366_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t d = hpt366_chipsets[id->driver_data];
+	struct hpt_info *info = NULL;
+	struct pci_dev *dev2 = NULL;
+	ide_pci_device_t d;
+	u8 idx = id->driver_data;
+	u8 rev = dev->revision;
+
+	if ((idx == 0 || idx == 4) && (PCI_FUNC(dev->devfn) & 1))
+		return -ENODEV;
+
+	switch (idx) {
+	case 0:
+		if (rev < 3)
+			info = &hpt36x;
+		else {
+			static struct hpt_info *hpt37x_info[] =
+				{ &hpt370, &hpt370a, &hpt372, &hpt372n };
+
+			info = hpt37x_info[min_t(u8, rev, 6) - 3];
+			idx++;
+		}
+		break;
+	case 1:
+		info = (rev > 1) ? &hpt372n : &hpt372a;
+		break;
+	case 2:
+		info = (rev > 1) ? &hpt302n : &hpt302;
+		break;
+	case 3:
+		hpt371_init(dev);
+		info = (rev > 1) ? &hpt371n : &hpt371;
+		break;
+	case 4:
+		info = &hpt374;
+		break;
+	case 5:
+		info = &hpt372n;
+		break;
+	}
+
+	d = hpt366_chipsets[idx];
+
+	d.name = info->chip_name;
+	d.udma_mask = info->udma_mask;
+
+	pci_set_drvdata(dev, info);
+
+	if (info == &hpt36x || info == &hpt374)
+		dev2 = pci_get_slot(dev->bus, dev->devfn + 1);
+
+	if (dev2) {
+		int ret;
+
+		pci_set_drvdata(dev2, info);
+
+		if (info == &hpt374)
+			hpt374_init(dev, dev2);
+		else {
+			if (hpt36x_init(dev, dev2))
+				d.host_flags |= IDE_HFLAG_BOOTABLE;
+		}
+
+		ret = ide_setup_pci_devices(dev, dev2, &d);
+		if (ret < 0)
+			pci_dev_put(dev2);
+		return ret;
+	}
 
-	return d.init_setup(dev, &d);
+	return ide_setup_pci_device(dev, &d);
 }
 
 static const struct pci_device_id hpt366_pci_tbl[] = {
