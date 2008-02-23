From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/4] sis5513: fail early for unsupported chipsets
Date: Sat, 23 Feb 2008 21:14:23 +0100
Message-ID: <200802232114.23726.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:18507 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754433AbYBWUD6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Feb 2008 15:03:58 -0500
Received: by ug-out-1314.google.com with SMTP id z38so232752ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 23 Feb 2008 12:03:55 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

* Factor out chipset family detection from init_chipset_sis5513()
  to sis_find_family().

* Use sis_find_family() in sis5513_init_one() to fail early if the
  chipset is unsupported.

* Keep a local copy sis5513_chipset in sis5513_init_one()
  and set .udma_mask according to chipset family.

* Remove no longer need ->ultra_mask setting from init_hwif_sis5513().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sis5513.c |   27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -358,8 +358,7 @@ static u8 sis5513_ata133_udma_filter(ide
 	return (regdw & 0x08) ? ATA_UDMA6 : ATA_UDMA5;
 }
 
-/* Chip detection and general config */
-static unsigned int __devinit init_chipset_sis5513 (struct pci_dev *dev, const char *name)
+static int __devinit sis_find_family(struct pci_dev *dev)
 {
 	struct pci_dev *host;
 	int i = 0;
@@ -440,9 +439,12 @@ static unsigned int __devinit init_chips
 			}
 	}
 
-	if (!chipset_family)
-		return -1;
+	return chipset_family;
+}
 
+static unsigned int __devinit init_chipset_sis5513(struct pci_dev *dev,
+						   const char *name)
+{
 	/* Make general config ops here
 	   1/ tell IDE channels to operate in Compatibility mode only
 	   2/ tell old chips to allow per drive IDE timings */
@@ -548,8 +550,6 @@ static u8 __devinit ata66_sis5513(ide_hw
 
 static void __devinit init_hwif_sis5513 (ide_hwif_t *hwif)
 {
-	u8 udma_rates[] = { 0x00, 0x00, 0x07, 0x1f, 0x3f, 0x3f, 0x7f, 0x7f };
-
 	hwif->set_pio_mode = &sis_set_pio_mode;
 	hwif->set_dma_mode = &sis_set_dma_mode;
 
@@ -557,11 +557,6 @@ static void __devinit init_hwif_sis5513 
 		hwif->udma_filter = sis5513_ata133_udma_filter;
 
 	hwif->cable_detect = ata66_sis5513;
-
-	if (hwif->dma_base == 0)
-		return;
-
-	hwif->ultra_mask = udma_rates[chipset_family];
 }
 
 static const struct ide_port_info sis5513_chipset __devinitdata = {
@@ -576,7 +571,15 @@ static const struct ide_port_info sis551
 
 static int __devinit sis5513_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	return ide_setup_pci_device(dev, &sis5513_chipset);
+	struct ide_port_info d = sis5513_chipset;
+	u8 udma_rates[] = { 0x00, 0x00, 0x07, 0x1f, 0x3f, 0x3f, 0x7f, 0x7f };
+
+	if (sis_find_family(dev) == 0)
+		return -ENOTSUPP;
+
+	d.udma_mask = udma_rates[chipset_family];
+
+	return ide_setup_pci_device(dev, &d);
 }
 
 static const struct pci_device_id sis5513_pci_tbl[] = {
