From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove ->cds field from ide_hwif_t (take 2)
Date: Thu, 17 Apr 2008 00:08:31 +0200
Message-ID: <200804170008.31774.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:15618 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242AbYDPW1s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2008 18:27:48 -0400
Received: by fk-out-0910.google.com with SMTP id 19so3013115fkr.5
        for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2008 15:27:47 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Kou Ishizaki <kou.ishizaki@toshiba.co.jp>, Akira Iguchi <akira2.iguchi@toshiba.co.jp>


* Use hwif->name instead of cds->name in ide_allocate_dma_engine().

* Use pci_name(dev) instead of cds->name in init_dma_pdc202xx().

* Remove no longer needed ->cds field from ide_hwif_t.

v2:

* scc_pata.c also needs to be updated now (noticed by Stephen Rothwell).

There should be no functional changes caused by this patch.

Cc: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Cc: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
replacement patch for the one in the IDE tree

 drivers/ide/ide-dma.c          |    2 +-
 drivers/ide/pci/pdc202xx_old.c |    5 +++--
 drivers/ide/pci/scc_pata.c     |    1 -
 drivers/ide/setup-pci.c        |    1 -
 include/linux/ide.h            |    2 --
 5 files changed, 4 insertions(+), 7 deletions(-)

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
Index: b/drivers/ide/pci/scc_pata.c
===================================================================
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -535,7 +535,6 @@ static int scc_ide_setup_pci_device(stru
 	hw.chipset = ide_pci;
 	ide_init_port_hw(hwif, &hw);
 	hwif->dev = &dev->dev;
-	hwif->cds = d;
 
 	idx[0] = hwif->index;
 
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -322,7 +322,6 @@ static ide_hwif_t *ide_hwif_configure(st
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
