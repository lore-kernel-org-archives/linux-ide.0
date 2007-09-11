From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 9/10] ide: add IDE_HFLAG_RQSIZE_256 host flag
Date: Tue, 11 Sep 2007 23:41:24 +0200
Message-ID: <200709112341.24655.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:27602 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756047AbXIKVk0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Sep 2007 17:40:26 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1153nfb
        for <linux-ide@vger.kernel.org>; Tue, 11 Sep 2007 14:40:25 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Add IDE_HFLAG_RQSIZE_256 host flag to tell ide_pci_setup_ports() to set
hwif->rqsize to 256 sectors.  Convert pdc202xx_old host driver to use it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/pdc202xx_old.c |   18 ++++++------------
 drivers/ide/setup-pci.c        |    3 +++
 include/linux/ide.h            |    2 ++
 3 files changed, 11 insertions(+), 12 deletions(-)

Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -302,13 +302,6 @@ static unsigned int __devinit init_chips
 
 static void __devinit init_hwif_pdc202xx(ide_hwif_t *hwif)
 {
-	struct pci_dev *dev = hwif->pci_dev;
-
-	/* PDC20265 has problems with large LBA48 requests */
-	if ((dev->device == PCI_DEVICE_ID_PROMISE_20267) ||
-	    (dev->device == PCI_DEVICE_ID_PROMISE_20265))
-		hwif->rqsize = 256;
-
 	hwif->set_pio_mode = &pdc202xx_set_pio_mode;
 	hwif->set_dma_mode = &pdc202xx_set_mode;
 
@@ -382,7 +375,7 @@ static void __devinit pdc202ata4_fixup_i
 	}
 }
 
-#define DECLARE_PDC2026X_DEV(name_str, udma) \
+#define DECLARE_PDC2026X_DEV(name_str, udma, extra_flags) \
 	{ \
 		.name		= name_str, \
 		.init_chipset	= init_chipset_pdc202xx, \
@@ -390,6 +383,7 @@ static void __devinit pdc202ata4_fixup_i
 		.init_dma	= init_dma_pdc202xx, \
 		.extra		= 48, \
 		.host_flags	= IDE_HFLAG_ERROR_STOPS_FIFO | \
+				  extra_flags | \
 				  IDE_HFLAG_OFF_BOARD, \
 		.pio_mask	= ATA_PIO4, \
 		.mwdma_mask	= ATA_MWDMA2, \
@@ -410,10 +404,10 @@ static ide_pci_device_t pdc202xx_chipset
 		.udma_mask	= ATA_UDMA2,
 	},
 
-	/* 1 */ DECLARE_PDC2026X_DEV("PDC20262", ATA_UDMA4),
-	/* 2 */ DECLARE_PDC2026X_DEV("PDC20263", ATA_UDMA4),
-	/* 3 */ DECLARE_PDC2026X_DEV("PDC20265", ATA_UDMA5),
-	/* 4 */ DECLARE_PDC2026X_DEV("PDC20267", ATA_UDMA5),
+	/* 1 */ DECLARE_PDC2026X_DEV("PDC20262", ATA_UDMA4, 0),
+	/* 2 */ DECLARE_PDC2026X_DEV("PDC20263", ATA_UDMA4, 0),
+	/* 3 */ DECLARE_PDC2026X_DEV("PDC20265", ATA_UDMA5, IDE_HFLAG_RQSIZE_256),
+	/* 4 */ DECLARE_PDC2026X_DEV("PDC20267", ATA_UDMA5, IDE_HFLAG_RQSIZE_256),
 };
 
 /**
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -582,6 +582,9 @@ void ide_pci_setup_ports(struct pci_dev 
 		hwif->drives[0].autotune = 1;
 		hwif->drives[1].autotune = 1;
 
+		if (d->host_flags & IDE_HFLAG_RQSIZE_256)
+			hwif->rqsize = 256;
+
 		if (d->init_hwif)
 			/* Call chipset-specific routine
 			 * for each enabled hwif
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1270,6 +1270,8 @@ enum {
 	IDE_HFLAG_LEGACY_IRQS		= (1 << 21),
 	/* force use of legacy IRQs */
 	IDE_HFLAG_FORCE_LEGACY_IRQS	= (1 << 22),
+	/* limit LBA48 requests to 256 sectors */
+	IDE_HFLAG_RQSIZE_256		= (1 << 23),
 };
 
 #ifdef CONFIG_BLK_DEV_OFFBOARD
