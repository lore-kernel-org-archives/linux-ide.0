From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/7] pdc202xx_old: remove init_dma_pdc202xx()
Date: Sat, 8 Mar 2008 22:30:31 +0100
Message-ID: <200803082230.31377.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:49578 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656AbYCHVVd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Mar 2008 16:21:33 -0500
Received: by fk-out-0910.google.com with SMTP id z23so929294fkz.5
        for <linux-ide@vger.kernel.org>; Sat, 08 Mar 2008 13:21:32 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Do PDC202xx specific DMA initialization in init_chipset_pdc202xx()
and remove no longer needed init_dma_pdc202xx().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/pdc202xx_old.c |   23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -263,12 +263,6 @@ static void pdc202xx_dma_timeout(ide_dri
 	ide_dma_timeout(drive);
 }
 
-static unsigned int __devinit init_chipset_pdc202xx(struct pci_dev *dev,
-							const char *name)
-{
-	return dev->irq;
-}
-
 static void __devinit init_hwif_pdc202xx(ide_hwif_t *hwif)
 {
 	struct pci_dev *dev = to_pci_dev(hwif->dev);
@@ -286,15 +280,14 @@ static void __devinit init_hwif_pdc202xx
 	hwif->ide_dma_test_irq = &pdc202xx_old_ide_dma_test_irq;
 }
 
-static void __devinit init_dma_pdc202xx(ide_hwif_t *hwif, unsigned long dmabase)
+static unsigned int __devinit init_chipset_pdc202xx(struct pci_dev *dev,
+						    const char *name)
 {
-	struct pci_dev *dev = to_pci_dev(hwif->dev);
+	unsigned long dmabase = pci_resource_start(dev, 4);
 	u8 udma_speed_flag = 0, primary_mode = 0, secondary_mode = 0;
 
-	if (hwif->channel) {
-		ide_setup_dma(hwif, dmabase);
-		return;
-	}
+	if (dmabase == 0)
+		goto out;
 
 	udma_speed_flag	= inb(dmabase | 0x1f);
 	primary_mode	= inb(dmabase | 0x1a);
@@ -313,8 +306,8 @@ static void __devinit init_dma_pdc202xx(
 		outb(udma_speed_flag | 1, dmabase | 0x1f);
 		printk("%sACTIVE\n", (inb(dmabase | 0x1f) & 1) ? "" : "IN");
 	}
-
-	ide_setup_dma(hwif, dmabase);
+out:
+	return dev->irq;
 }
 
 static void __devinit pdc202ata4_fixup_irq(struct pci_dev *dev,
@@ -358,7 +351,6 @@ static const struct ide_port_ops pdc2026
 		.name		= name_str, \
 		.init_chipset	= init_chipset_pdc202xx, \
 		.init_hwif	= init_hwif_pdc202xx, \
-		.init_dma	= init_dma_pdc202xx, \
 		.port_ops	= &pdc2026x_port_ops, \
 		.host_flags	= IDE_HFLAGS_PDC202XX | extra_flags, \
 		.pio_mask	= ATA_PIO4, \
@@ -371,7 +363,6 @@ static const struct ide_port_info pdc202
 		.name		= "PDC20246",
 		.init_chipset	= init_chipset_pdc202xx,
 		.init_hwif	= init_hwif_pdc202xx,
-		.init_dma	= init_dma_pdc202xx,
 		.port_ops	= &pdc20246_port_ops,
 		.host_flags	= IDE_HFLAGS_PDC202XX,
 		.pio_mask	= ATA_PIO4,
