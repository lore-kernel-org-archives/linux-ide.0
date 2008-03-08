From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/7] ide: factor out setting PCI bus-mastering from ide_hwif_setup_dma()
Date: Sat, 8 Mar 2008 22:33:18 +0100
Message-ID: <200803082233.18333.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:55084 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601AbYCHVVj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Mar 2008 16:21:39 -0500
Received: by ug-out-1314.google.com with SMTP id z38so4632676ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 08 Mar 2008 13:21:38 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Factor out setting PCI bus-mastering from ide_hwif_setup_dma()
to ide_pci_set_master() helper.

While at it:

* don't read PCI Command register if not necessary

* use PCI device name instead of hwif->name

* cleanup ide_hwif_setup_dma() a bit

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/setup-pci.c |   61 +++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 24 deletions(-)

Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -132,6 +132,29 @@ static unsigned long ide_get_or_set_dma_
 out:
 	return dma_base;
 }
+
+/*
+ * Set up BM-DMA capability (PnP BIOS should have done this)
+ */
+static int ide_pci_set_master(struct pci_dev *dev, const char *name)
+{
+	u16 pcicmd;
+
+	pci_read_config_word(dev, PCI_COMMAND, &pcicmd);
+
+	if ((pcicmd & PCI_COMMAND_MASTER) == 0) {
+		pci_set_master(dev);
+
+		if (pci_read_config_word(dev, PCI_COMMAND, &pcicmd) ||
+		    (pcicmd & PCI_COMMAND_MASTER) == 0) {
+			printk(KERN_ERR "%s: error updating PCICMD on %s\n",
+					name, pci_name(dev));
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
 #endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
 
 void ide_setup_pci_noise(struct pci_dev *dev, const struct ide_port_info *d)
@@ -339,36 +362,26 @@ static ide_hwif_t *ide_hwif_configure(st
 void ide_hwif_setup_dma(ide_hwif_t *hwif, const struct ide_port_info *d)
 {
 	struct pci_dev *dev = to_pci_dev(hwif->dev);
-	u16 pcicmd;
-
-	pci_read_config_word(dev, PCI_COMMAND, &pcicmd);
 
 	if ((d->host_flags & IDE_HFLAG_NO_AUTODMA) == 0 ||
 	    ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE &&
 	     (dev->class & 0x80))) {
 		unsigned long dma_base = ide_get_or_set_dma_base(d, hwif);
-		if (dma_base && !(pcicmd & PCI_COMMAND_MASTER)) {
-			/*
-			 * Set up BM-DMA capability
-			 * (PnP BIOS should have done this)
-			 */
-			pci_set_master(dev);
-			if (pci_read_config_word(dev, PCI_COMMAND, &pcicmd) || !(pcicmd & PCI_COMMAND_MASTER)) {
-				printk(KERN_ERR "%s: %s error updating PCICMD\n",
-					hwif->name, d->name);
-				dma_base = 0;
-			}
-		}
-		if (dma_base) {
-			if (d->init_dma)
-				d->init_dma(hwif, dma_base);
-
-			ide_setup_dma(hwif, dma_base);
-		} else {
-			printk(KERN_INFO "%s: %s Bus-Master DMA disabled "
-				"(BIOS)\n", hwif->name, d->name);
-		}
+
+		if (dma_base == 0 || ide_pci_set_master(dev, d->name) < 0)
+			goto out_disabled;
+
+		if (d->init_dma)
+			d->init_dma(hwif, dma_base);
+
+		ide_setup_dma(hwif, dma_base);
 	}
+
+	return;
+
+out_disabled:
+	printk(KERN_INFO "%s: Bus-Master DMA disabled (BIOS) on %s\n",
+			 d->name, pci_name(dev));
 }
 #endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
 
