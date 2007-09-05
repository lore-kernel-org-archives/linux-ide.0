From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/13] piix: add DECLARE_ICH_DEV() macro
Date: Wed, 5 Sep 2007 23:52:25 +0200
Message-ID: <200709052352.25728.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:65452 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932087AbXIEV6t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Sep 2007 17:58:49 -0400
Received: by nf-out-0910.google.com with SMTP id f5so1828126nfh
        for <linux-ide@vger.kernel.org>; Wed, 05 Sep 2007 14:58:48 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Add DECLARE_ICH_DEV() macro.

While at it:

* Add init_hwif_ich() (->init_hwif method) for ICH controllers.

* Rename init_chipset_piix() to init_chipset_ich() and use it only for
  ICH controllers.

* Remove no longer needed piix_is_ichx() helper.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/piix.c |  110 ++++++++++++++++++++-----------------------------
 1 file changed, 47 insertions(+), 63 deletions(-)

Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -254,53 +254,20 @@ static void piix_set_dma_mode(ide_drive_
 }
 
 /**
- *	piix_is_ichx	-	check if ICHx
- *	@dev: PCI device to check
- *
- *	returns 1 if ICHx, 0 otherwise.
- */
-static int piix_is_ichx(struct pci_dev *dev)
-{
-        switch (dev->device) {
-		case PCI_DEVICE_ID_INTEL_82801EB_1:
-		case PCI_DEVICE_ID_INTEL_82801AA_1:
-		case PCI_DEVICE_ID_INTEL_82801AB_1:
-		case PCI_DEVICE_ID_INTEL_82801BA_8:
-		case PCI_DEVICE_ID_INTEL_82801BA_9:
-		case PCI_DEVICE_ID_INTEL_82801CA_10:
-		case PCI_DEVICE_ID_INTEL_82801CA_11:
-		case PCI_DEVICE_ID_INTEL_82801DB_1:
-		case PCI_DEVICE_ID_INTEL_82801DB_10:
-		case PCI_DEVICE_ID_INTEL_82801DB_11:
-		case PCI_DEVICE_ID_INTEL_82801EB_11:
-		case PCI_DEVICE_ID_INTEL_82801E_11:
-		case PCI_DEVICE_ID_INTEL_ESB_2:
-		case PCI_DEVICE_ID_INTEL_ICH6_19:
-		case PCI_DEVICE_ID_INTEL_ICH7_21:
-		case PCI_DEVICE_ID_INTEL_ESB2_18:
-		case PCI_DEVICE_ID_INTEL_ICH8_6:
-			return 1;
-	}
-
-	return 0;
-}
-
-/**
- *	init_chipset_piix	-	set up the PIIX chipset
+ *	init_chipset_ich	-	set up the ICH chipset
  *	@dev: PCI device to set up
  *	@name: Name of the device
  *
- *	Initialize the PCI device as required. For the PIIX this turns
- *	out to be nice and simple
+ *	Initialize the PCI device as required.  For the ICH this turns
+ *	out to be nice and simple.
  */
 
-static unsigned int __devinit init_chipset_piix (struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_ich(struct pci_dev *dev, const char *name)
 {
-	if (piix_is_ichx(dev)) {
-		unsigned int extra = 0;
-		pci_read_config_dword(dev, 0x54, &extra);
-		pci_write_config_dword(dev, 0x54, extra|0x400);
-	}
+	u32 extra = 0;
+
+	pci_read_config_dword(dev, 0x54, &extra);
+	pci_write_config_dword(dev, 0x54, extra | 0x400);
 
 	return 0;
 }
@@ -393,10 +360,6 @@ static void __devinit init_hwif_piix(ide
 	if (!hwif->dma_base)
 		return;
 
-	/* ICHx need to clear the bmdma status for all interrupts */
-	if (piix_is_ichx(hwif->pci_dev))
-		hwif->ide_dma_clear_irq = &piix_dma_clear_irq;
-
 	if (hwif->ultra_mask & 0x78) {
 		if (hwif->cbl != ATA_CBL_PATA40_SHORT)
 			hwif->cbl = piix_cable_detect(hwif);
@@ -406,10 +369,18 @@ static void __devinit init_hwif_piix(ide
 		hwif->ultra_mask = hwif->mwdma_mask = hwif->swdma_mask = 0;
 }
 
+static void __devinit init_hwif_ich(ide_hwif_t *hwif)
+{
+	init_hwif_piix(hwif);
+
+	/* ICHx need to clear the BMDMA status for all interrupts */
+	if (hwif->dma_base)
+		hwif->ide_dma_clear_irq = &piix_dma_clear_irq;
+}
+
 #define DECLARE_PIIX_DEV(name_str, udma) \
 	{						\
 		.name		= name_str,		\
-		.init_chipset	= init_chipset_piix,	\
 		.init_hwif	= init_hwif_piix,	\
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, \
 		.host_flags	= IDE_HFLAG_BOOTABLE,	\
@@ -419,6 +390,19 @@ static void __devinit init_hwif_piix(ide
 		.udma_mask	= udma,			\
 	}
 
+#define DECLARE_ICH_DEV(name_str, udma) \
+	{ \
+		.name		= name_str, \
+		.init_chipset	= init_chipset_ich, \
+		.init_hwif	= init_hwif_ich, \
+		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, \
+		.host_flags	= IDE_HFLAG_BOOTABLE, \
+		.pio_mask	= ATA_PIO4, \
+		.swdma_mask	= ATA_SWDMA2_ONLY, \
+		.mwdma_mask	= ATA_MWDMA12_ONLY, \
+		.udma_mask	= udma, \
+	}
+
 static ide_pci_device_t piix_pci_info[] __devinitdata = {
 	/*  0 */ DECLARE_PIIX_DEV("PIIXa",	0x00),	/* no udma */
 	/*  1 */ DECLARE_PIIX_DEV("PIIXb",	0x00),	/* no udma */
@@ -439,26 +423,26 @@ static ide_pci_device_t piix_pci_info[] 
 
 	/*  3 */ DECLARE_PIIX_DEV("PIIX3",	0x00),	/* no udma */
 	/*  4 */ DECLARE_PIIX_DEV("PIIX4",	ATA_UDMA2),
-	/*  5 */ DECLARE_PIIX_DEV("ICH0",	ATA_UDMA2),
+	/*  5 */ DECLARE_ICH_DEV("ICH0",	ATA_UDMA2),
 	/*  6 */ DECLARE_PIIX_DEV("PIIX4",	ATA_UDMA2),
-	/*  7 */ DECLARE_PIIX_DEV("ICH",	ATA_UDMA4),
+	/*  7 */ DECLARE_ICH_DEV("ICH",		ATA_UDMA4),
 	/*  8 */ DECLARE_PIIX_DEV("PIIX4",	ATA_UDMA4),
 	/*  9 */ DECLARE_PIIX_DEV("PIIX4",	ATA_UDMA2),
-	/* 10 */ DECLARE_PIIX_DEV("ICH2",	ATA_UDMA5),
-	/* 11 */ DECLARE_PIIX_DEV("ICH2M",	ATA_UDMA5),
-	/* 12 */ DECLARE_PIIX_DEV("ICH3M",	ATA_UDMA5),
-	/* 13 */ DECLARE_PIIX_DEV("ICH3",	ATA_UDMA5),
-	/* 14 */ DECLARE_PIIX_DEV("ICH4",	ATA_UDMA5),
-	/* 15 */ DECLARE_PIIX_DEV("ICH5",	ATA_UDMA5),
-	/* 16 */ DECLARE_PIIX_DEV("C-ICH",	ATA_UDMA5),
-	/* 17 */ DECLARE_PIIX_DEV("ICH4",	ATA_UDMA5),
-	/* 18 */ DECLARE_PIIX_DEV("ICH5-SATA",	ATA_UDMA5),
-	/* 19 */ DECLARE_PIIX_DEV("ICH5",	ATA_UDMA5),
-	/* 20 */ DECLARE_PIIX_DEV("ICH6",	ATA_UDMA5),
-	/* 21 */ DECLARE_PIIX_DEV("ICH7",	ATA_UDMA5),
-	/* 22 */ DECLARE_PIIX_DEV("ICH4",	ATA_UDMA5),
-	/* 23 */ DECLARE_PIIX_DEV("ESB2",	ATA_UDMA5),
-	/* 24 */ DECLARE_PIIX_DEV("ICH8M",	ATA_UDMA5),
+	/* 10 */ DECLARE_ICH_DEV("ICH2",	ATA_UDMA5),
+	/* 11 */ DECLARE_ICH_DEV("ICH2M",	ATA_UDMA5),
+	/* 12 */ DECLARE_ICH_DEV("ICH3M",	ATA_UDMA5),
+	/* 13 */ DECLARE_ICH_DEV("ICH3",	ATA_UDMA5),
+	/* 14 */ DECLARE_ICH_DEV("ICH4",	ATA_UDMA5),
+	/* 15 */ DECLARE_ICH_DEV("ICH5",	ATA_UDMA5),
+	/* 16 */ DECLARE_ICH_DEV("C-ICH",	ATA_UDMA5),
+	/* 17 */ DECLARE_ICH_DEV("ICH4",	ATA_UDMA5),
+	/* 18 */ DECLARE_ICH_DEV("ICH5-SATA",	ATA_UDMA5),
+	/* 19 */ DECLARE_ICH_DEV("ICH5",	ATA_UDMA5),
+	/* 20 */ DECLARE_ICH_DEV("ICH6",	ATA_UDMA5),
+	/* 21 */ DECLARE_ICH_DEV("ICH7",	ATA_UDMA5),
+	/* 22 */ DECLARE_ICH_DEV("ICH4",	ATA_UDMA5),
+	/* 23 */ DECLARE_ICH_DEV("ESB2",	ATA_UDMA5),
+	/* 24 */ DECLARE_ICH_DEV("ICH8M",	ATA_UDMA5),
 };
 
 /**
