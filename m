From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/3] ide: remove ->cds field from ide_hwif_t
Date: Thu, 6 Mar 2008 00:02:45 +0100
Message-ID: <200803060002.45507.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:55897 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758810AbYCEWwK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Mar 2008 17:52:10 -0500
Received: by ug-out-1314.google.com with SMTP id z38so3517410ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 05 Mar 2008 14:52:09 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

* Use hwif->name instead of cds->name in ide_allocate_dma_engine().

* Use pci_name(dev) instead of cds->name in init_dma_pdc202xx().

* Remove no longer needed ->cds field from ide_hwif_t.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma.c          |    2 +-
 drivers/ide/pci/pdc202xx_old.c |    5 +++--
 drivers/ide/setup-pci.c        |    1 -
 include/linux/ide.h            |    2 --
 4 files changed, 4 insertions(+), 6 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -833,7 +833,7 @@ static int ide_allocate_dma_engine(ide_h
 		return 0;
 
 	printk(KERN_ERR "%s: -- Error, unable to allocate DMA table.\n",
-	       hwif->cds->name);
+			hwif->name);
 
 	return 1;
 }
Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -288,6 +288,7 @@ static void __devinit init_hwif_pdc202xx
 
 static void __devinit init_dma_pdc202xx(ide_hwif_t *hwif, unsigned long dmabase)
 {
+	struct pci_dev *dev = to_pci_dev(hwif->dev);
 	u8 udma_speed_flag = 0, primary_mode = 0, secondary_mode = 0;
 
 	if (hwif->channel) {
@@ -300,14 +301,14 @@ static void __devinit init_dma_pdc202xx(
 	secondary_mode	= inb(dmabase | 0x1b);
 	printk(KERN_INFO "%s: (U)DMA Burst Bit %sABLED " \
 		"Primary %s Mode " \
-		"Secondary %s Mode.\n", hwif->cds->name,
+		"Secondary %s Mode.\n", pci_name(dev),
 		(udma_speed_flag & 1) ? "EN" : "DIS",
 		(primary_mode & 1) ? "MASTER" : "PCI",
 		(secondary_mode & 1) ? "MASTER" : "PCI" );
 
 	if (!(udma_speed_flag & 1)) {
 		printk(KERN_INFO "%s: FORCING BURST BIT 0x%02x->0x%02x ",
-			hwif->cds->name, udma_speed_flag,
+			pci_name(dev), udma_speed_flag,
 			(udma_speed_flag|1));
 		outb(udma_speed_flag | 1, dmabase | 0x1f);
 		printk("%sACTIVE\n", (inb(dmabase | 0x1f) & 1) ? "" : "IN");
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -321,7 +321,6 @@ static ide_hwif_t *ide_hwif_configure(st
 	ide_init_port_hw(hwif, &hw);
 
 	hwif->dev = &dev->dev;
-	hwif->cds = d;
 
 	return hwif;
 }
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -447,8 +447,6 @@ typedef struct hwif_s {
 
 	struct device *dev;
 
-	const struct ide_port_info *cds;	/* chipset device struct */
-
 	ide_ack_intr_t *ack_intr;
 
 	void (*rw_disk)(ide_drive_t *, struct request *);
