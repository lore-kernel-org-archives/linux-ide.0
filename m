From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/13] ide: add IDE_HFLAG_SERIALIZE host flag
Date: Wed, 5 Sep 2007 23:53:28 +0200
Message-ID: <200709052353.28577.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:65452 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932124AbXIEV6x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Sep 2007 17:58:53 -0400
Received: by nf-out-0910.google.com with SMTP id f5so1828126nfh
        for <linux-ide@vger.kernel.org>; Wed, 05 Sep 2007 14:58:52 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Add IDE_HFLAG_SERIALIZE host flag to tell ide_pci_setup_ports() to set
hwif/mate->serialized and convert aec62xx, cs5530 and sc1200 host drivers
to use it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/aec62xx.c |   10 +++++-----
 drivers/ide/pci/cs5530.c  |    7 +++----
 drivers/ide/pci/sc1200.c  |    7 +++----
 drivers/ide/setup-pci.c   |    3 +++
 include/linux/ide.h       |    2 ++
 5 files changed, 16 insertions(+), 13 deletions(-)

Index: b/drivers/ide/pci/aec62xx.c
===================================================================
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -187,11 +187,9 @@ static void __devinit init_hwif_aec62xx(
 
 	hwif->set_pio_mode = &aec_set_pio_mode;
 
-	if (dev->device == PCI_DEVICE_ID_ARTOP_ATP850UF) {
-		if(hwif->mate)
-			hwif->mate->serialized = hwif->serialized = 1;
+	if (dev->device == PCI_DEVICE_ID_ARTOP_ATP850UF)
 		hwif->set_dma_mode = &aec6210_set_mode;
-	} else
+	else
 		hwif->set_dma_mode = &aec6260_set_mode;
 
 	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
@@ -219,7 +217,9 @@ static ide_pci_device_t aec62xx_chipsets
 		.init_chipset	= init_chipset_aec62xx,
 		.init_hwif	= init_hwif_aec62xx,
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
-		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
+		.host_flags	= IDE_HFLAG_SERIALIZE |
+				  IDE_HFLAG_NO_ATAPI_DMA |
+				  IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 		.udma_mask	= ATA_UDMA2,
Index: b/drivers/ide/pci/cs5530.c
===================================================================
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -245,9 +245,6 @@ static void __devinit init_hwif_cs5530 (
 	unsigned long basereg;
 	u32 d0_timings;
 
-	if (hwif->mate)
-		hwif->serialized = hwif->mate->serialized = 1;
-
 	hwif->set_pio_mode = &cs5530_set_pio_mode;
 	hwif->set_dma_mode = &cs5530_set_dma_mode;
 
@@ -271,7 +268,9 @@ static ide_pci_device_t cs5530_chipset _
 	.name		= "CS5530",
 	.init_chipset	= init_chipset_cs5530,
 	.init_hwif	= init_hwif_cs5530,
-	.host_flags	= IDE_HFLAG_POST_SET_MODE | IDE_HFLAG_BOOTABLE,
+	.host_flags	= IDE_HFLAG_SERIALIZE |
+			  IDE_HFLAG_POST_SET_MODE |
+			  IDE_HFLAG_BOOTABLE,
 	.pio_mask	= ATA_PIO4,
 	.mwdma_mask	= ATA_MWDMA2,
 	.udma_mask	= ATA_UDMA2,
Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -362,9 +362,6 @@ static int sc1200_resume (struct pci_dev
  */
 static void __devinit init_hwif_sc1200 (ide_hwif_t *hwif)
 {
-	if (hwif->mate)
-		hwif->serialized = hwif->mate->serialized = 1;
-
 	hwif->set_pio_mode = &sc1200_set_pio_mode;
 	hwif->set_dma_mode = &sc1200_set_dma_mode;
 
@@ -381,7 +378,9 @@ static void __devinit init_hwif_sc1200 (
 static ide_pci_device_t sc1200_chipset __devinitdata = {
 	.name		= "SC1200",
 	.init_hwif	= init_hwif_sc1200,
-	.host_flags	= IDE_HFLAG_ABUSE_DMA_MODES | IDE_HFLAG_POST_SET_MODE |
+	.host_flags	= IDE_HFLAG_SERIALIZE |
+			  IDE_HFLAG_POST_SET_MODE |
+			  IDE_HFLAG_ABUSE_DMA_MODES |
 			  IDE_HFLAG_BOOTABLE,
 	.pio_mask	= ATA_PIO4,
 	.mwdma_mask	= ATA_MWDMA2,
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -565,6 +565,9 @@ void ide_pci_setup_ports(struct pci_dev 
 		hwif->host_flags = d->host_flags;
 		hwif->pio_mask = d->pio_mask;
 
+		if ((d->host_flags & IDE_HFLAG_SERIALIZE) && hwif->mate)
+			hwif->mate->serialized = hwif->serialized = 1;
+
 		if (hwif->dma_base) {
 			hwif->swdma_mask = d->swdma_mask;
 			hwif->mwdma_mask = d->mwdma_mask;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1262,6 +1262,8 @@ enum {
 	IDE_HFLAG_NO_LBA48_DMA		= (1 << 18),
 	/* data FIFO is cleared by an error */
 	IDE_HFLAG_ERROR_STOPS_FIFO	= (1 << 19),
+	/* serialize ports */
+	IDE_HFLAG_SERIALIZE		= (1 << 20),
 };
 
 #ifdef CONFIG_BLK_DEV_OFFBOARD
