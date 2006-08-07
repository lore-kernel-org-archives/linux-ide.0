From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/17] libata: use LLD name where possible
Date: Mon, 7 Aug 2006 12:04:01 +0900
Message-ID: <11549198411863-git-send-email-htejun@gmail.com>
References: <1154919839169-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:35910 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750943AbWHGDEQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Aug 2006 23:04:16 -0400
Received: by py-out-1112.google.com with SMTP id c31so315370pyd
        for <linux-ide@vger.kernel.org>; Sun, 06 Aug 2006 20:04:12 -0700 (PDT)
In-Reply-To: <1154919839169-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

When acquiring resources, use LLD name where possible.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-bmdma.c |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

89c097fc1f9e41b7c2d7a03d0aa0857bed6b6b5d
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index 4cc316d..75eec7a 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -894,11 +894,12 @@ unsigned int ata_pci_legacy_mask(struct 
 	return mask;
 }
 
-static int ata_pci_acquire_legacy(int port, unsigned long *host_set_flags)
+static int ata_pci_acquire_legacy(int port, const char *name,
+				  unsigned long *host_set_flags)
 {
 	unsigned long cmd_addr = ata_legacy_addr_tbl[port][0];
 
-	if (request_region(cmd_addr, 8, "libata") != NULL)
+	if (request_region(cmd_addr, 8, name) != NULL)
 		*host_set_flags |= ATA_HOST_RES_LEGACY_PRI << port;
 	else {
 		struct resource *conflict, res;
@@ -980,6 +981,16 @@ int ata_pci_set_dma_mask(struct pci_dev 
 	return rc;
 }
 
+static const char *ata_drv_name(struct device *dev)
+{
+	const char *name = dev_driver_string(dev);
+
+	if (name[0] != '\0')
+		return name;
+
+	return DRV_NAME;
+}
+
 /**
  *	ata_pci_acquire_resources - acquire default PCI resources
  *	@host_set: target ATA host_set to acquire PCI resources for
@@ -998,6 +1009,7 @@ int ata_pci_acquire_resources(struct ata
 			      const char **reason)
 {
 	struct pci_dev *pdev = to_pci_dev(host_set->dev);
+	const char *name = ata_drv_name(&pdev->dev);
 	int nr_dummy, i, rc;
 
 	/* acquire generic resources */
@@ -1016,7 +1028,7 @@ int ata_pci_acquire_resources(struct ata
 		goto err;
 	}
 
-	rc = pci_request_regions(pdev, DRV_NAME);
+	rc = pci_request_regions(pdev, name);
 	if (rc) {
 		host_set->flags |= ATA_HOST_PCI_DEV_BUSY;
 		*reason = "failed to request PCI regions";
@@ -1040,7 +1052,7 @@ int ata_pci_acquire_resources(struct ata
 			continue;
 		BUG_ON(i >= host_set->n_ports);
 
-		if (ata_pci_acquire_legacy(i, &host_set->flags)) {
+		if (ata_pci_acquire_legacy(i, name, &host_set->flags)) {
 			host_set->ports[i]->ops = &ata_dummy_port_ops;
 			nr_dummy++;
 		}
@@ -1219,6 +1231,7 @@ int ata_pci_host_set_prepare(struct pci_
 	const int irq[3] = { 14, 15, pdev->irq };
 	irqreturn_t (*irq_handler[3])(int, void *,
 				      struct pt_regs *) = { NULL, NULL, NULL };
+	const char *name = ata_drv_name(&pdev->dev);
 	struct ata_host_set *host_set = NULL;
 	struct ata_port_info dummy_pinfo;
 	const struct ata_port_info *pi[2];
@@ -1309,8 +1322,8 @@ int ata_pci_host_set_prepare(struct pci_
 			break;
 		}
 
-		rc = request_irq(irq[i], irq_handler[i], irq_flags[i],
-				 DRV_NAME, host_set);
+		rc = request_irq(irq[i], irq_handler[i], irq_flags[i], name,
+				 host_set);
 		if (rc) {
 			reason = "failed to request IRQ";
 			goto err;
-- 
1.3.2


