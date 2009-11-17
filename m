From: Vivek Mahajan <vivek.mahajan@freescale.com>
Subject: [PATCH 1/1] sata_sil24: MSI support cleanup
Date: Tue, 17 Nov 2009 13:01:23 +0530
Message-ID: <1258443083-6203-1-git-send-email-vivek.mahajan@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from az33egw02.freescale.net ([192.88.158.103]:61277 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755107AbZKQHbY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Nov 2009 02:31:24 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, Vivek Mahajan <vivek.mahajan@freescale.com>

Grant Grundler suggested the following cleanup:

* Rename module param 'msi' to 'sata_sil24_msi'
* Remove pci_intx() as pci_enable_msi() internally
  takes care of it.

Reviewed-by: Grant Grundler <grundler@google.com>
Signed-off-by: Vivek Mahajan <vivek.mahajan@freescale.com>
---
 drivers/ata/sata_sil24.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 1370df6..783d8c7 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -417,9 +417,9 @@ static struct ata_port_operations sil24_ops = {
 #endif
 };
 
-static int sata_sil24_msi;    /* Disable MSI */
-module_param_named(msi, sata_sil24_msi, bool, S_IRUGO);
-MODULE_PARM_DESC(msi, "Enable MSI (Default: false)");
+static int modparam_sata_sil24_msi;    /* Disable MSI */
+module_param_named(sata_sil24_msi, modparam_sata_sil24_msi, bool, S_IRUGO);
+MODULE_PARM_DESC(sata_sil24_msi, "Enable MSI (default: false)");
 
 /*
  * Use bits 30-31 of port_flags to encode available port numbers.
@@ -1344,10 +1344,8 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	sil24_init_controller(host);
 
-	if (sata_sil24_msi && !pci_enable_msi(pdev)) {
+	if (modparam_sata_sil24_msi && !pci_enable_msi(pdev))
 		dev_printk(KERN_INFO, &pdev->dev, "Using MSI\n");
-		pci_intx(pdev, 0);
-	}
 
 	pci_set_master(pdev);
 	return ata_host_activate(host, pdev->irq, sil24_interrupt, IRQF_SHARED,
-- 
1.5.6.5

