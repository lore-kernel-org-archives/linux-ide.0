From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/5] libata: use dev_driver_string() instead of "libata" in libata-sff.c
Date: Fri,  4 Jan 2008 18:42:21 +0900
Message-ID: <119943974492-git-send-email-htejun@gmail.com>
References: <1199439744356-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:58845 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756348AbYADJmb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jan 2008 04:42:31 -0500
Received: by rv-out-0910.google.com with SMTP id k20so6064374rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 04 Jan 2008 01:42:30 -0800 (PST)
In-Reply-To: <1199439744356-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, torvalds@linux-foundation.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

libata-sff code used DRV_NAME which is hardcoded to "libata" when
requesting resources.  Use dev_driver_string() such that low level
driver names are used in resource listing.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-sff.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 3b62479..16eb9e9 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -551,7 +551,7 @@ int ata_pci_init_bmdma(struct ata_host *host)
 		return rc;
 
 	/* request and iomap DMA region */
-	rc = pcim_iomap_regions(pdev, 1 << 4, DRV_NAME);
+	rc = pcim_iomap_regions(pdev, 1 << 4, dev_driver_string(gdev));
 	if (rc) {
 		dev_printk(KERN_ERR, gdev, "failed to request/iomap BAR4\n");
 		return -ENOMEM;
@@ -621,7 +621,8 @@ int ata_pci_init_sff_host(struct ata_host *host)
 			continue;
 		}
 
-		rc = pcim_iomap_regions(pdev, 0x3 << base, DRV_NAME);
+		rc = pcim_iomap_regions(pdev, 0x3 << base,
+					dev_driver_string(gdev));
 		if (rc) {
 			dev_printk(KERN_WARNING, gdev,
 				   "failed to request/iomap BARs for port %d "
@@ -741,6 +742,7 @@ int ata_pci_init_one(struct pci_dev *pdev,
 	struct device *dev = &pdev->dev;
 	const struct ata_port_info *pi = NULL;
 	struct ata_host *host = NULL;
+	const char *drv_name = dev_driver_string(&pdev->dev);
 	u8 mask;
 	int legacy_mode = 0;
 	int i, rc;
@@ -810,7 +812,7 @@ int ata_pci_init_one(struct pci_dev *pdev,
 
 	if (!legacy_mode) {
 		rc = devm_request_irq(dev, pdev->irq, pi->port_ops->irq_handler,
-				      IRQF_SHARED, DRV_NAME, host);
+				      IRQF_SHARED, drv_name, host);
 		if (rc)
 			goto err_out;
 
@@ -820,7 +822,7 @@ int ata_pci_init_one(struct pci_dev *pdev,
 		if (!ata_port_is_dummy(host->ports[0])) {
 			rc = devm_request_irq(dev, ATA_PRIMARY_IRQ(pdev),
 					      pi->port_ops->irq_handler,
-					      IRQF_SHARED, DRV_NAME, host);
+					      IRQF_SHARED, drv_name, host);
 			if (rc)
 				goto err_out;
 
@@ -831,7 +833,7 @@ int ata_pci_init_one(struct pci_dev *pdev,
 		if (!ata_port_is_dummy(host->ports[1])) {
 			rc = devm_request_irq(dev, ATA_SECONDARY_IRQ(pdev),
 					      pi->port_ops->irq_handler,
-					      IRQF_SHARED, DRV_NAME, host);
+					      IRQF_SHARED, drv_name, host);
 			if (rc)
 				goto err_out;
 
-- 
1.5.2.4

