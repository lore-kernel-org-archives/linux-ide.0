From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/12] libata: convert native PCI host handling to new init model
Date: Fri, 9 Mar 2007 20:15:36 +0900
Message-ID: <1173438936670-git-send-email-htejun@gmail.com>
References: <1173438935540-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:36192 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767185AbXCILPj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 06:15:39 -0500
Received: by py-out-1112.google.com with SMTP id a29so282622pyi
        for <linux-ide@vger.kernel.org>; Fri, 09 Mar 2007 03:15:39 -0800 (PST)
In-Reply-To: <1173438935540-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Convert native PCI host handling to alloc-init-attach model.  New
function ata_pci_init_native_host() follows the new init model and
replaces ata_pci_init_native_mode().  As there are remaining LLD
users, the old function isn't removed yet.

ata_pci_init_one() is reimplemented using the new function and now
fully converted to new init model.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    1 +
 drivers/ata/libata-sff.c  |  148 ++++++++++++++++++++++++++++++--------------
 include/linux/libata.h    |    2 +
 3 files changed, 104 insertions(+), 47 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 97e7d9c..cf63651 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6649,6 +6649,7 @@ EXPORT_SYMBOL_GPL(ata_timing_merge);
 EXPORT_SYMBOL_GPL(pci_test_config_bits);
 EXPORT_SYMBOL_GPL(pci_configure_dma_masks);
 EXPORT_SYMBOL_GPL(ata_pci_init_native_mode);
+EXPORT_SYMBOL_GPL(ata_pci_init_native_host);
 EXPORT_SYMBOL_GPL(ata_pci_init_one);
 EXPORT_SYMBOL_GPL(ata_pci_remove_one);
 #ifdef CONFIG_PM
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 8287df5..f033e79 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -675,6 +675,70 @@ static int ata_pci_init_bmdma(struct ata_host *host)
 	return 0;
 }
 
+/**
+ *	ata_pci_init_native_host - acquire native ATA resources and init host
+ *	@host: target ATA host
+ *	@port_mask: ports to consider
+ *
+ *	Acquire native PCI ATA resources for @host and initialize
+ *	@host accordoingly.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_pci_init_native_host(struct ata_host *host, unsigned int port_mask)
+{
+	struct device *gdev = host->dev;
+	struct pci_dev *pdev = to_pci_dev(gdev);
+	int i, rc;
+
+	/* Discard disabled ports.  Some controllers show their unused
+	 * channels this way.  Disabled ports are made dummy.
+	 */
+	for (i = 0; i < 2; i++) {
+		if ((port_mask & (1 << i)) && !ata_resources_present(pdev, i)) {
+			host->ports[i]->ops = &ata_dummy_port_ops;
+			port_mask &= ~(1 << i);
+		}
+	}
+
+	if (!port_mask) {
+		dev_printk(KERN_ERR, gdev, "no available port\n");
+		return -ENODEV;
+	}
+
+	/* request, iomap BARs and init port addresses accordingly */
+	for (i = 0; i < 2; i++) {
+		struct ata_port *ap = host->ports[i];
+		int base = i * 2;
+		void __iomem * const *iomap;
+
+		if (!(port_mask & (1 << i)))
+			continue;
+
+		rc = pcim_iomap_regions(pdev, 0x3 << base, DRV_NAME);
+		if (rc) {
+			dev_printk(KERN_ERR, gdev, "failed to request/iomap "
+				   "BARs for port %d (errno=%d)\n", i, rc);
+			if (rc == -EBUSY)
+				pcim_pin_device(pdev);
+			return rc;
+		}
+		host->iomap = iomap = pcim_iomap_table(pdev);
+
+		ap->ioaddr.cmd_addr = iomap[base];
+		ap->ioaddr.altstatus_addr =
+		ap->ioaddr.ctl_addr = (void __iomem *)
+			((unsigned long)iomap[base + 1] | ATA_PCI_CTL_OFS);
+		ata_std_ports(&ap->ioaddr);
+	}
+
+	return 0;
+}
+
 struct ata_legacy_devres {
 	unsigned int	mask;
 	unsigned long	cmd_port[2];
@@ -929,7 +993,6 @@ int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 		      unsigned int n_ports)
 {
 	struct device *dev = &pdev->dev;
-	struct ata_probe_ent *probe_ent = NULL;
 	struct ata_host *host = NULL;
 	const struct ata_port_info *port[2];
 	u8 mask;
@@ -955,7 +1018,7 @@ int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 
 	   Checking dev->is_enabled is insufficient as this is not set at
 	   boot for the primary video which is BIOS enabled
-         */
+	  */
 
 	rc = pcim_enable_device(pdev);
 	if (rc)
@@ -981,27 +1044,28 @@ int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 #endif
 	}
 
+	/* alloc and init host */
+	host = ata_host_alloc_pinfo(dev, port, 2);
+	if (!host) {
+		dev_printk(KERN_ERR, &pdev->dev,
+			   "failed to allocate ATA host\n");
+		rc = -ENOMEM;
+		goto err_out;
+	}
+
 	if (!legacy_mode) {
-		rc = pci_request_regions(pdev, DRV_NAME);
-		if (rc) {
-			pcim_pin_device(pdev);
-			goto err_out;
-		}
+		unsigned int port_mask;
+
+		port_mask = ATA_PORT_PRIMARY;
+		if (n_ports > 1)
+			port_mask |= ATA_PORT_SECONDARY;
 
-		/* TODO: If we get no DMA mask we should fall back to PIO */
-		rc = pci_configure_dma_masks(pdev, ATA_DMA_MASK, NULL);
+		rc = ata_pci_init_native_host(host, port_mask);
 		if (rc)
 			goto err_out;
-
-		pci_set_master(pdev);
 	} else {
 		int was_busy = 0;
 
-		rc = -ENOMEM;
-		host = ata_host_alloc_pinfo(dev, port, 2);
-		if (!host)
-			goto err_out;
-
 		rc = ata_init_legacy_host(host, &legacy_mode, &was_busy);
 		if (was_busy)
 			pcim_pin_device(pdev);
@@ -1011,47 +1075,37 @@ int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 		/* request respective PCI regions, may fail */
 		rc = pci_request_region(pdev, 1, DRV_NAME);
 		rc = pci_request_region(pdev, 3, DRV_NAME);
-
-		/* init bmdma */
-		ata_pci_init_bmdma(host);
-		pci_set_master(pdev);
 	}
 
-	if (legacy_mode) {
+	/* init BMDMA, may fail */
+	ata_pci_init_bmdma(host);
+	pci_set_master(pdev);
+
+	/* start host and request IRQ */
+	rc = ata_host_start(host);
+	if (rc)
+		goto err_out;
+
+	if (!legacy_mode)
+		rc = devm_request_irq(dev, pdev->irq,
+				      port_info[0]->port_ops->irq_handler,
+				      IRQF_SHARED, DRV_NAME, host);
+	else {
 		irq_handler_t handler[2] = { host->ops->irq_handler,
 					     host->ops->irq_handler };
 		unsigned int irq_flags[2] = { IRQF_SHARED, IRQF_SHARED };
 		void *dev_id[2] = { host, host };
 
-		rc = ata_host_start(host);
-		if (rc)
-			goto err_out;
-
 		rc = ata_request_legacy_irqs(host, handler, irq_flags, dev_id);
-		if (rc)
-			goto err_out;
-
-		rc = ata_host_attach(host, port_info[0]->sht);
-		if (rc)
-			goto err_out;
-	} else {
-		if (n_ports == 2)
-			probe_ent = ata_pci_init_native_mode(pdev, (struct ata_port_info **)port, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
-		else
-			probe_ent = ata_pci_init_native_mode(pdev, (struct ata_port_info **)port, ATA_PORT_PRIMARY);
-
-		if (!probe_ent) {
-			rc = -ENOMEM;
-			goto err_out;
-		}
+	}
+	if (rc)
+		goto err_out;
 
-		if (!ata_device_add(probe_ent)) {
-			rc = -ENODEV;
-			goto err_out;
-		}
+	/* attach */
+	rc = ata_host_attach(host, port_info[0]->sht);
+	if (rc)
+		goto err_out;
 
-		devm_kfree(dev, probe_ent);
-	}
 	devres_remove_group(dev, NULL);
 	return 0;
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 202ed7a..7aa6085 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -881,6 +881,8 @@ struct pci_bits {
 
 extern struct ata_probe_ent *
 ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port, int portmask);
+extern int ata_pci_init_native_host(struct ata_host *host,
+				    unsigned int port_mask);
 extern int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits);
 extern int pci_configure_dma_masks(struct pci_dev *pdev, u64 dma_mask,
 				   u64 *configured_mask);
-- 
1.5.0.1


