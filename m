From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/2] ide-pmac: dynamically allocate struct pmac_ide_hwif instances
Date: Sat, 16 Feb 2008 18:53:40 +0100
Message-ID: <200802161853.40296.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:52605 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755339AbYBPRky (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Feb 2008 12:40:54 -0500
Received: by nf-out-0910.google.com with SMTP id g13so461029nfb.21
        for <linux-ide@vger.kernel.org>; Sat, 16 Feb 2008 09:40:50 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Dynamically allocate struct pmac_ide_hwif instances in pmac_ide_macio_attach()
and pmac_ide_pci_attach(), then remove no longer needed pmac_ide[].

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ppc/pmac.c |   49 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 16 deletions(-)

Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -79,8 +79,6 @@ typedef struct pmac_ide_hwif {
 	
 } pmac_ide_hwif_t;
 
-static pmac_ide_hwif_t pmac_ide[MAX_HWIFS];
-
 enum {
 	controller_ohare,	/* OHare based */
 	controller_heathrow,	/* Heathrow/Paddington */
@@ -1094,29 +1092,34 @@ pmac_ide_macio_attach(struct macio_dev *
 	int i, rc;
 	hw_regs_t hw;
 
+	pmif = (struct pmac_ide_hwif)kzalloc(sizeof(*pmif), GFP_KERNEL);
+	if (pmif == NULL)
+		return -ENOMEM;
+
 	i = 0;
-	while (i < MAX_HWIFS && (ide_hwifs[i].io_ports[IDE_DATA_OFFSET] != 0
-	    || pmac_ide[i].node != NULL))
+	while (i < MAX_HWIFS && (ide_hwifs[i].io_ports[IDE_DATA_OFFSET] != 0))
 		++i;
 	if (i >= MAX_HWIFS) {
 		printk(KERN_ERR "ide-pmac: MacIO interface attach with no slot\n");
 		printk(KERN_ERR "          %s\n", mdev->ofdev.node->full_name);
-		return -ENODEV;
+		rc = -ENODEV;
+		goto out_free_pmif;
 	}
 
-	pmif = &pmac_ide[i];
 	hwif = &ide_hwifs[i];
 
 	if (macio_resource_count(mdev) == 0) {
 		printk(KERN_WARNING "ide%d: no address for %s\n",
 		       i, mdev->ofdev.node->full_name);
-		return -ENXIO;
+		rc = -ENXIO;
+		goto out_free_pmif;
 	}
 
 	/* Request memory resource for IO ports */
 	if (macio_request_resource(mdev, 0, "ide-pmac (ports)")) {
 		printk(KERN_ERR "ide%d: can't request mmio resource !\n", i);
-		return -EBUSY;
+		rc = -EBUSY;
+		goto out_free_pmif;
 	}
 			
 	/* XXX This is bogus. Should be fixed in the registry by checking
@@ -1166,11 +1169,15 @@ pmac_ide_macio_attach(struct macio_dev *
 			iounmap(pmif->dma_regs);
 			macio_release_resource(mdev, 1);
 		}
-		memset(pmif, 0, sizeof(*pmif));
 		macio_release_resource(mdev, 0);
+		kfree(pmif);
 	}
 
 	return rc;
+
+out_free_pmif:
+	kfree(pmif);
+	return rc;
 }
 
 static int
@@ -1223,30 +1230,36 @@ pmac_ide_pci_attach(struct pci_dev *pdev
 		printk(KERN_ERR "ide-pmac: cannot find MacIO node for Kauai ATA interface\n");
 		return -ENODEV;
 	}
+
+	pmif = (struct pmac_ide_hwif)kzalloc(sizeof(*pmif), GFP_KERNEL);
+	if (pmif == NULL)
+		return -ENOMEM;
+
 	i = 0;
-	while (i < MAX_HWIFS && (ide_hwifs[i].io_ports[IDE_DATA_OFFSET] != 0
-	    || pmac_ide[i].node != NULL))
+	while (i < MAX_HWIFS && (ide_hwifs[i].io_ports[IDE_DATA_OFFSET] != 0))
 		++i;
 	if (i >= MAX_HWIFS) {
 		printk(KERN_ERR "ide-pmac: PCI interface attach with no slot\n");
 		printk(KERN_ERR "          %s\n", np->full_name);
-		return -ENODEV;
+		rc = -ENODEV;
+		goto out_free_pmif;
 	}
 
-	pmif = &pmac_ide[i];
 	hwif = &ide_hwifs[i];
 
 	if (pci_enable_device(pdev)) {
 		printk(KERN_WARNING "ide%i: Can't enable PCI device for %s\n",
 			i, np->full_name);
-		return -ENXIO;
+		rc = -ENXIO;
+		goto out_free_pmif;
 	}
 	pci_set_master(pdev);
 			
 	if (pci_request_regions(pdev, "Kauai ATA")) {
 		printk(KERN_ERR "ide%d: Cannot obtain PCI resources for %s\n",
 			i, np->full_name);
-		return -ENXIO;
+		rc = -ENXIO;
+		goto out_free_pmif;
 	}
 
 	hwif->dev = &pdev->dev;
@@ -1276,11 +1289,15 @@ pmac_ide_pci_attach(struct pci_dev *pdev
 		/* The inteface is released to the common IDE layer */
 		pci_set_drvdata(pdev, NULL);
 		iounmap(base);
-		memset(pmif, 0, sizeof(*pmif));
 		pci_release_regions(pdev);
+		kfree(pmif);
 	}
 
 	return rc;
+
+out_free_pmif:
+	kfree(pmif);
+	return rc;
 }
 
 static int
