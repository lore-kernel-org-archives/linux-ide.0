From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/6] ide: remove ->mmio flag from ide_hwif_t
Date: Wed, 7 May 2008 19:45:11 +0200
Message-ID: <200805071945.11304.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:24063 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755848AbYEGR3J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 May 2008 13:29:09 -0400
Received: by nf-out-0910.google.com with SMTP id d3so225828nfc.21
        for <linux-ide@vger.kernel.org>; Wed, 07 May 2008 10:29:07 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Since scc_pata host driver no longer uses IDE PCI layer / ide_dma_setup()
and all other ->mmio users set also IDE_HFLAG_MMIO host flag we can safely
remove ->mmio flag.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/palm_bk3710.c |    1 -
 drivers/ide/ide-dma.c         |    2 +-
 drivers/ide/pci/scc_pata.c    |    1 -
 drivers/ide/pci/siimage.c     |   25 +++++++++++++------------
 drivers/ide/setup-pci.c       |    4 ++--
 include/linux/ide.h           |    1 -
 6 files changed, 16 insertions(+), 18 deletions(-)

Index: b/drivers/ide/arm/palm_bk3710.c
===================================================================
--- a/drivers/ide/arm/palm_bk3710.c
+++ b/drivers/ide/arm/palm_bk3710.c
@@ -402,7 +402,6 @@ static int __devinit palm_bk3710_probe(s
 	ide_init_port_data(hwif, i);
 	ide_init_port_hw(hwif, &hw);
 
-	hwif->mmio = 1;
 	default_hwif_mmiops(hwif);
 
 	idx[0] = i;
Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -463,7 +463,7 @@ int ide_dma_setup(ide_drive_t *drive)
 	}
 
 	/* PRD table */
-	if (hwif->mmio)
+	if (hwif->host_flags & IDE_HFLAG_MMIO)
 		writel(hwif->dmatable_dma,
 		       (void __iomem *)(hwif->dma_base + ATA_DMA_TABLE_OFS));
 	else
Index: b/drivers/ide/pci/scc_pata.c
===================================================================
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -793,7 +793,6 @@ static void __devinit init_mmio_iops_scc
 
 	hwif->dma_base = dma_base;
 	hwif->config_data = ports->ctl;
-	hwif->mmio = 1;
 }
 
 /**
Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -94,7 +94,7 @@ static unsigned long siimage_selreg(ide_
 	unsigned long base = (unsigned long)hwif->hwif_data;
 
 	base += 0xA0 + r;
-	if (hwif->mmio)
+	if (hwif->host_flags & IDE_HFLAG_MMIO)
 		base += hwif->channel << 6;
 	else
 		base += hwif->channel << 4;
@@ -117,7 +117,7 @@ static inline unsigned long siimage_seld
 	unsigned long base	= (unsigned long)hwif->hwif_data;
 
 	base += 0xA0 + r;
-	if (hwif->mmio)
+	if (hwif->host_flags & IDE_HFLAG_MMIO)
 		base += hwif->channel << 6;
 	else
 		base += hwif->channel << 4;
@@ -190,7 +190,9 @@ static u8 sil_pata_udma_filter(ide_drive
 	unsigned long base	= (unsigned long)hwif->hwif_data;
 	u8 scsc, mask		= 0;
 
-	scsc = sil_ioread8(dev, base + (hwif->mmio ? 0x4A : 0x8A));
+	base += (hwif->host_flags & IDE_HFLAG_MMIO) ? 0x4A : 0x8A;
+
+	scsc = sil_ioread8(dev, base);
 
 	switch (scsc & 0x30) {
 	case 0x10:	/* 133 */
@@ -238,8 +240,9 @@ static void sil_set_pio_mode(ide_drive_t
 	unsigned long tfaddr	= siimage_selreg(hwif,	0x02);
 	unsigned long base	= (unsigned long)hwif->hwif_data;
 	u8 tf_pio		= pio;
-	u8 addr_mask		= hwif->channel ? (hwif->mmio ? 0xF4 : 0x84)
-						: (hwif->mmio ? 0xB4 : 0x80);
+	u8 mmio			= (hwif->host_flags & IDE_HFLAG_MMIO) ? 1 : 0;
+	u8 addr_mask		= hwif->channel ? (mmio ? 0xF4 : 0x84)
+						: (mmio ? 0xB4 : 0x80);
 	u8 mode			= 0;
 	u8 unit			= drive->select.b.unit;
 
@@ -290,13 +293,13 @@ static void sil_set_dma_mode(ide_drive_t
 	u16 ultra = 0, multi	= 0;
 	u8 mode = 0, unit	= drive->select.b.unit;
 	unsigned long base	= (unsigned long)hwif->hwif_data;
-	u8 scsc = 0, addr_mask	= hwif->channel ?
-					(hwif->mmio ? 0xF4 : 0x84) :
-					(hwif->mmio ? 0xB4 : 0x80);
+	u8 mmio			= (hwif->host_flags & IDE_HFLAG_MMIO) ? 1 : 0;
+	u8 scsc = 0, addr_mask	= hwif->channel ? (mmio ? 0xF4 : 0x84)
+						: (mmio ? 0xB4 : 0x80);
 	unsigned long ma	= siimage_seldev(drive, 0x08);
 	unsigned long ua	= siimage_seldev(drive, 0x0C);
 
-	scsc  = sil_ioread8 (dev, base + (hwif->mmio ? 0x4A : 0x8A));
+	scsc  = sil_ioread8 (dev, base + (mmio ? 0x4A : 0x8A));
 	mode  = sil_ioread8 (dev, base + addr_mask);
 	multi = sil_ioread16(dev, ma);
 	ultra = sil_ioread16(dev, ua);
@@ -391,7 +394,7 @@ static int siimage_mmio_dma_test_irq(ide
 
 static int siimage_dma_test_irq(ide_drive_t *drive)
 {
-	if (drive->hwif->mmio)
+	if (drive->hwif->host_flags & IDE_HFLAG_MMIO)
 		return siimage_mmio_dma_test_irq(drive);
 	else
 		return siimage_io_dma_test_irq(drive);
@@ -640,8 +643,6 @@ static void __devinit init_mmio_iops_sii
 	hwif->irq = dev->irq;
 
 	hwif->dma_base = (unsigned long)addr + (ch ? 0x08 : 0x00);
-
-	hwif->mmio = 1;
 }
 
 static int is_dev_seagate_sata(ide_drive_t *drive)
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -87,7 +87,7 @@ unsigned long ide_pci_dma_base(ide_hwif_
 	unsigned long dma_base = 0;
 	u8 dma_stat = 0;
 
-	if (hwif->mmio)
+	if (hwif->host_flags & IDE_HFLAG_MMIO)
 		return hwif->dma_base;
 
 	if (hwif->mate && hwif->mate->dma_base) {
@@ -374,7 +374,7 @@ int ide_hwif_setup_dma(ide_hwif_t *hwif,
 		if (base == 0 || ide_pci_set_master(dev, d->name) < 0)
 			return -1;
 
-		if (hwif->mmio)
+		if (hwif->host_flags & IDE_HFLAG_MMIO)
 			printk(KERN_INFO "    %s: MMIO-DMA\n", hwif->name);
 		else
 			printk(KERN_INFO "    %s: BM-DMA at 0x%04lx-0x%04lx\n",
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -517,7 +517,6 @@ typedef struct hwif_s {
 	unsigned	serialized : 1;	/* serialized all channel operation */
 	unsigned	sharing_irq: 1;	/* 1 = sharing irq with another hwif */
 	unsigned	sg_mapped  : 1;	/* sg_table and sg_nents are ready */
-	unsigned	mmio       : 1; /* host uses MMIO */
 
 	struct device		gendev;
 	struct device		*portdev;
