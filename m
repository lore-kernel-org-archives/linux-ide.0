From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/2] ide-pmac: use ide_find_port()
Date: Sat, 16 Feb 2008 18:54:27 +0100
Message-ID: <200802161854.28117.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:7689 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758801AbYBPRkw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Feb 2008 12:40:52 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1078737mue.5
        for <linux-ide@vger.kernel.org>; Sat, 16 Feb 2008 09:40:51 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ppc/pmac.c |   44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1086,38 +1086,34 @@ pmac_ide_macio_attach(struct macio_dev *
 {
 	void __iomem *base;
 	unsigned long regbase;
-	int irq;
 	ide_hwif_t *hwif;
 	pmac_ide_hwif_t *pmif;
-	int i, rc;
+	int irq, rc;
 	hw_regs_t hw;
 
 	pmif = (struct pmac_ide_hwif)kzalloc(sizeof(*pmif), GFP_KERNEL);
 	if (pmif == NULL)
 		return -ENOMEM;
 
-	i = 0;
-	while (i < MAX_HWIFS && (ide_hwifs[i].io_ports[IDE_DATA_OFFSET] != 0))
-		++i;
-	if (i >= MAX_HWIFS) {
+	hwif = ide_find_port();
+	if (hwif == NULL) {
 		printk(KERN_ERR "ide-pmac: MacIO interface attach with no slot\n");
 		printk(KERN_ERR "          %s\n", mdev->ofdev.node->full_name);
 		rc = -ENODEV;
 		goto out_free_pmif;
 	}
 
-	hwif = &ide_hwifs[i];
-
 	if (macio_resource_count(mdev) == 0) {
-		printk(KERN_WARNING "ide%d: no address for %s\n",
-		       i, mdev->ofdev.node->full_name);
+		printk(KERN_WARNING "ide-pmac: no address for %s\n",
+				    mdev->ofdev.node->full_name);
 		rc = -ENXIO;
 		goto out_free_pmif;
 	}
 
 	/* Request memory resource for IO ports */
 	if (macio_request_resource(mdev, 0, "ide-pmac (ports)")) {
-		printk(KERN_ERR "ide%d: can't request mmio resource !\n", i);
+		printk(KERN_ERR "ide-pmac: can't request MMIO resource for "
+				"%s!\n", mdev->ofdev.node->full_name);
 		rc = -EBUSY;
 		goto out_free_pmif;
 	}
@@ -1128,8 +1124,8 @@ pmac_ide_macio_attach(struct macio_dev *
 	 * where that happens though...
 	 */
 	if (macio_irq_count(mdev) == 0) {
-		printk(KERN_WARNING "ide%d: no intrs for device %s, using 13\n",
-			i, mdev->ofdev.node->full_name);
+		printk(KERN_WARNING "ide-pmac: no intrs for device %s, using "
+				    "13\n", mdev->ofdev.node->full_name);
 		irq = irq_create_mapping(NULL, 13);
 	} else
 		irq = macio_irq(mdev, 0);
@@ -1147,7 +1143,9 @@ pmac_ide_macio_attach(struct macio_dev *
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
 	if (macio_resource_count(mdev) >= 2) {
 		if (macio_request_resource(mdev, 1, "ide-pmac (dma)"))
-			printk(KERN_WARNING "ide%d: can't request DMA resource !\n", i);
+			printk(KERN_WARNING "ide-pmac: can't request DMA "
+					    "resource for %s!\n",
+					    mdev->ofdev.node->full_name);
 		else
 			pmif->dma_regs = ioremap(macio_resource_start(mdev, 1), 0x1000);
 	} else
@@ -1222,7 +1220,7 @@ pmac_ide_pci_attach(struct pci_dev *pdev
 	pmac_ide_hwif_t *pmif;
 	void __iomem *base;
 	unsigned long rbase, rlen;
-	int i, rc;
+	int rc;
 	hw_regs_t hw;
 
 	np = pci_device_to_OF_node(pdev);
@@ -1235,29 +1233,25 @@ pmac_ide_pci_attach(struct pci_dev *pdev
 	if (pmif == NULL)
 		return -ENOMEM;
 
-	i = 0;
-	while (i < MAX_HWIFS && (ide_hwifs[i].io_ports[IDE_DATA_OFFSET] != 0))
-		++i;
-	if (i >= MAX_HWIFS) {
+	hwif = ide_find_port();
+	if (hwif == NULL) {
 		printk(KERN_ERR "ide-pmac: PCI interface attach with no slot\n");
 		printk(KERN_ERR "          %s\n", np->full_name);
 		rc = -ENODEV;
 		goto out_free_pmif;
 	}
 
-	hwif = &ide_hwifs[i];
-
 	if (pci_enable_device(pdev)) {
-		printk(KERN_WARNING "ide%i: Can't enable PCI device for %s\n",
-			i, np->full_name);
+		printk(KERN_WARNING "ide-pmac: Can't enable PCI device for "
+				    "%s\n", np->full_name);
 		rc = -ENXIO;
 		goto out_free_pmif;
 	}
 	pci_set_master(pdev);
 			
 	if (pci_request_regions(pdev, "Kauai ATA")) {
-		printk(KERN_ERR "ide%d: Cannot obtain PCI resources for %s\n",
-			i, np->full_name);
+		printk(KERN_ERR "ide-pmac: Cannot obtain PCI resources for "
+				"%s\n", np->full_name);
 		rc = -ENXIO;
 		goto out_free_pmif;
 	}
