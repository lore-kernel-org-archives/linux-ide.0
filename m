From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/7] ide: add DECLARE_GENERIC_PCI_DEV() macro to generic IDE PCI host driver
Date: Sat, 18 Aug 2007 20:51:56 +0200
Message-ID: <200708182051.56133.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:65378 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757042AbXHRTTM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Aug 2007 15:19:12 -0400
Received: by fk-out-0910.google.com with SMTP id z23so797152fkz
        for <linux-ide@vger.kernel.org>; Sat, 18 Aug 2007 12:19:11 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Add DECLARE_GENERIC_PCI_DEV() macro to generic IDE PCI host driver
  and use it to cleanup generic_chipsets[].

* Remove dead/obsolete code while at it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/generic.c |  113 +++++++++++-----------------------------------
 1 file changed, 29 insertions(+), 84 deletions(-)

Index: b/drivers/ide/pci/generic.c
===================================================================
--- a/drivers/ide/pci/generic.c
+++ b/drivers/ide/pci/generic.c
@@ -75,104 +75,49 @@ static void __devinit init_hwif_generic 
 	hwif->swdma_mask = 0x07;
 }
 
-#if 0
-	/* Logic to add back later on */
-
-	if ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
-		ide_pci_device_t *unknown = unknown_chipset;
-		init_setup_unknown(dev, unknown);
-		return 1;
+#define DECLARE_GENERIC_PCI_DEV(name_str, dma_setting) \
+	{ \
+		.name		= name_str, \
+		.init_hwif	= init_hwif_generic, \
+		.autodma	= dma_setting, \
+		.bootable	= ON_BOARD, \
+		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA, \
 	}
-	return 0;
-#endif	
 
 static ide_pci_device_t generic_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "Unknown",
-		.init_hwif	= init_hwif_generic,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
-	},{	/* 1 */
+	/*  0 */ DECLARE_GENERIC_PCI_DEV("Unknown",		AUTODMA),
+
+	{	/* 1 */
 		.name		= "NS87410",
 		.init_hwif	= init_hwif_generic,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x43,0x08,0x08}, {0x47,0x08,0x08}},
 		.bootable	= ON_BOARD,
 		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
-        },{	/* 2 */
-		.name		= "SAMURAI",
-		.init_hwif	= init_hwif_generic,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
-	},{	/* 3 */
-		.name		= "HT6565",
-		.init_hwif	= init_hwif_generic,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
-	},{	/* 4 */
-		.name		= "UM8673F",
-		.init_hwif	= init_hwif_generic,
-		.autodma	= NODMA,
-		.bootable	= ON_BOARD,
-		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
-	},{	/* 5 */
-		.name		= "UM8886A",
-		.init_hwif	= init_hwif_generic,
-		.autodma	= NODMA,
-		.bootable	= ON_BOARD,
-		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
-	},{	/* 6 */
-		.name		= "UM8886BF",
-		.init_hwif	= init_hwif_generic,
-		.autodma	= NODMA,
-		.bootable	= ON_BOARD,
-		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
-	},{	/* 7 */
-		.name		= "HINT_IDE",
-		.init_hwif	= init_hwif_generic,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
-	},{	/* 8 */
-		.name		= "VIA_IDE",
-		.init_hwif	= init_hwif_generic,
-		.autodma	= NOAUTODMA,
-		.bootable	= ON_BOARD,
-		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
-	},{	/* 9 */
-		.name		= "OPTI621V",
-		.init_hwif	= init_hwif_generic,
-		.autodma	= NOAUTODMA,
-		.bootable	= ON_BOARD,
-		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
-	},{	/* 10 */
+	},
+
+	/*  2 */ DECLARE_GENERIC_PCI_DEV("SAMURAI",		AUTODMA),
+	/*  3 */ DECLARE_GENERIC_PCI_DEV("HT6565",		AUTODMA),
+	/*  4 */ DECLARE_GENERIC_PCI_DEV("UM8673F",		NODMA),
+	/*  5 */ DECLARE_GENERIC_PCI_DEV("UM8886A",		NODMA),
+	/*  6 */ DECLARE_GENERIC_PCI_DEV("UM8886BF",		NODMA),
+	/*  7 */ DECLARE_GENERIC_PCI_DEV("HINT_IDE",		AUTODMA),
+	/*  8 */ DECLARE_GENERIC_PCI_DEV("VIA_IDE",		NOAUTODMA),
+	/*  9 */ DECLARE_GENERIC_PCI_DEV("OPTI621V",		NOAUTODMA),
+
+	{	/* 10 */
 		.name		= "VIA8237SATA",
 		.init_hwif	= init_hwif_generic,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
-	},{	/* 11 */
-		.name 		= "Piccolo0102",
-		.init_hwif	= init_hwif_generic,
-		.autodma	= NOAUTODMA,
-		.bootable	= ON_BOARD,
-		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
-	},{	/* 12 */
-		.name 		= "Piccolo0103",
-		.init_hwif	= init_hwif_generic,
-		.autodma	= NOAUTODMA,
-		.bootable	= ON_BOARD,
-		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
-	},{	/* 13 */
-		.name 		= "Piccolo0105",
-		.init_hwif	= init_hwif_generic,
-		.autodma	= NOAUTODMA,
-		.bootable	= ON_BOARD,
-		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
-	},{	/* 14 */
+	},
+
+	/* 11 */ DECLARE_GENERIC_PCI_DEV("Piccolo0102",		NOAUTODMA),
+	/* 12 */ DECLARE_GENERIC_PCI_DEV("Piccolo0103",		NOAUTODMA),
+	/* 13 */ DECLARE_GENERIC_PCI_DEV("Piccolo0105",		NOAUTODMA),
+
+	{	/* 14 */
 		.name		= "Revolution",
 		.init_hwif	= init_hwif_generic,
 		.autodma	= AUTODMA,
