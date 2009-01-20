From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 05/04] sata_mv: msi fix and cleanup
Date: Tue, 20 Jan 2009 13:19:02 -0500
Message-ID: <49761596.3010000@rtr.ca>
References: <49750705.7010709@rtr.ca> <49750746.3010709@rtr.ca> <49750774.1070005@rtr.ca> <497507BF.3090608@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:46520 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753049AbZATSTE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jan 2009 13:19:04 -0500
In-Reply-To: <497507BF.3090608@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Bug fix and cleanup for MSI support in sata_mv:

1. Set MV_HP_FLAG_MSI when MSI is enabled.
2. Remove redundant call of pci_intx().
3. Ensure that pci_disable_msi() is called on device removal.

Tested and working with Marvell 7042 PCIe hosts, though off by default.
Use of MSI still requires "msi=1" modparm for sata_mv.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2009-01-19 17:12:51.000000000 -0500
+++ linux/drivers/ata/sata_mv.c	2009-01-20 13:06:06.000000000 -0500
@@ -3276,13 +3276,14 @@
 #ifdef CONFIG_PCI
 static int mv_pci_init_one(struct pci_dev *pdev,
 			   const struct pci_device_id *ent);
+static void mv_pci_remove_one(struct pci_dev *pdev);
 
 
 static struct pci_driver mv_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= mv_pci_tbl,
 	.probe			= mv_pci_init_one,
-	.remove			= ata_pci_remove_one,
+	.remove			= mv_pci_remove_one,
 };
 
 /*
@@ -3367,6 +3368,26 @@
 }
 
 /**
+ *      mv_pci_remove_one - ensure MSI gets disabled on device removal
+ *      @pdev: PCI device
+ *
+ *      LOCKING:
+ *      Inherited from caller.
+ */
+static void mv_pci_remove_one(struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct mv_host_priv *hpriv = host->private_data;
+
+	if (hpriv->hp_flags & MV_HP_FLAG_MSI) {
+		devm_free_irq(host->dev, pdev->irq, host);
+		pci_disable_msi(pdev);
+	}
+	ata_pci_remove_one(pdev);
+}
+
+/**
  *      mv_pci_init_one - handle a positive probe of a PCI Marvell host
  *      @pdev: PCI device found
  *      @ent: PCI device ID entry for the matched host
@@ -3424,8 +3445,8 @@
 		return rc;
 
 	/* Enable interrupts */
-	if (msi && pci_enable_msi(pdev))
-		pci_intx(pdev, 1);
+	if (msi && 0 == pci_enable_msi(pdev))
+		hpriv->hp_flags |= MV_HP_FLAG_MSI;
 
 	mv_dump_pci_cfg(pdev, 0x68);
 	mv_print_info(host);
