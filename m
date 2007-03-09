From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/12] libata: add init helpers including ata_pci_prepare_native_host()
Date: Fri, 9 Mar 2007 20:15:36 +0900
Message-ID: <11734389363973-git-send-email-htejun@gmail.com>
References: <1173438935540-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:36192 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767184AbXCILPl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 06:15:41 -0500
Received: by py-out-1112.google.com with SMTP id a29so282622pyi
        for <linux-ide@vger.kernel.org>; Fri, 09 Mar 2007 03:15:40 -0800 (PST)
In-Reply-To: <1173438935540-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

These will be used to convert LLDs to new init model.

* Add irq_handler field to port_info.  In new init model, requesting
  IRQ is LLD's responsibility and libata doesn't need to know about
  irq_handler.  Most LLDs can simply register their irq_handler but
  some need different irq_handler depending on specific chip.  The
  added port_info->irq_handler field can be used by LLDs to select
  the matching IRQ handler in such cases.

* Add ata_dummy_port_info.

* Implement ata_pci_prepare_native_host(), a helper to alloc ATA host,
  acquire all resources and init the host in one go.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    6 ++++
 drivers/ata/libata-sff.c  |   67 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/libata.h    |    5 +++
 3 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index cf63651..4d371fb 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6546,6 +6546,10 @@ const struct ata_port_operations ata_dummy_port_ops = {
 	.port_stop		= ata_dummy_noret,
 };
 
+const struct ata_port_info ata_dummy_port_info = {
+	.port_ops		= &ata_dummy_port_ops,
+};
+
 /*
  * libata is essentially a library of internal helper functions for
  * low-level ATA host controller drivers.  As such, the API/ABI is
@@ -6557,6 +6561,7 @@ EXPORT_SYMBOL_GPL(sata_deb_timing_normal);
 EXPORT_SYMBOL_GPL(sata_deb_timing_hotplug);
 EXPORT_SYMBOL_GPL(sata_deb_timing_long);
 EXPORT_SYMBOL_GPL(ata_dummy_port_ops);
+EXPORT_SYMBOL_GPL(ata_dummy_port_info);
 EXPORT_SYMBOL_GPL(ata_std_bios_param);
 EXPORT_SYMBOL_GPL(ata_std_ports);
 EXPORT_SYMBOL_GPL(ata_host_init);
@@ -6650,6 +6655,7 @@ EXPORT_SYMBOL_GPL(pci_test_config_bits);
 EXPORT_SYMBOL_GPL(pci_configure_dma_masks);
 EXPORT_SYMBOL_GPL(ata_pci_init_native_mode);
 EXPORT_SYMBOL_GPL(ata_pci_init_native_host);
+EXPORT_SYMBOL_GPL(ata_pci_prepare_native_host);
 EXPORT_SYMBOL_GPL(ata_pci_init_one);
 EXPORT_SYMBOL_GPL(ata_pci_remove_one);
 #ifdef CONFIG_PM
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index f033e79..d53b181 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -660,13 +660,12 @@ static int ata_pci_init_bmdma(struct ata_host *host)
 
 	for (i = 0; i < 2; i++) {
 		struct ata_port *ap = host->ports[i];
-		struct ata_ioports *ioaddr = &ap->ioaddr;
 		void __iomem *bmdma = host->iomap[4] + 8 * i;
 
 		if (ata_port_is_dummy(ap))
 			continue;
 
-		ioaddr->bmdma_addr = bmdma;
+		ap->ioaddr.bmdma_addr = bmdma;
 		if ((!(ap->flags & ATA_FLAG_IGN_SIMPLEX)) &&
 		    (ioread8(bmdma + 2) & 0x80))
 			host->flags |= ATA_HOST_SIMPLEX;
@@ -739,6 +738,70 @@ int ata_pci_init_native_host(struct ata_host *host, unsigned int port_mask)
 	return 0;
 }
 
+/**
+ *	ata_pci_prepare_native_host - helper to prepare native PCI ATA host
+ *	@pdev: target PCI device
+ *	@ppi: array of port_info
+ *	@n_ports: number of ports to allocate
+ *	@r_host: out argument for the initialized ATA host
+ *
+ *	Helper to allocate ATA host for @pdev, acquire all native PCI
+ *	resources and initialize it accordingly in one go.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_pci_prepare_native_host(struct pci_dev *pdev,
+				const struct ata_port_info * const * ppi,
+				int n_ports, struct ata_host **r_host)
+{
+	struct ata_host *host;
+	unsigned int port_mask;
+	int rc;
+
+	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL))
+		return -ENOMEM;
+
+	host = ata_host_alloc_pinfo(&pdev->dev, ppi, 2);
+	if (!host) {
+		dev_printk(KERN_ERR, &pdev->dev,
+			   "failed to allocate ATA host\n");
+		rc = -ENOMEM;
+		goto err_out;
+	}
+
+	port_mask = ATA_PORT_PRIMARY;
+	if (n_ports > 1)
+		port_mask |= ATA_PORT_SECONDARY;
+
+	rc = ata_pci_init_native_host(host, port_mask);
+	if (rc)
+		goto err_out;
+
+	/* init DMA related stuff */
+	rc = ata_pci_init_bmdma(host);
+	if (rc)
+		goto err_bmdma;
+
+	devres_remove_group(&pdev->dev, NULL);
+	*r_host = host;
+	return 0;
+
+ err_bmdma:
+	/* This is necessary because PCI and iomap resources are
+	 * merged and releasing the top group won't release the
+	 * acquired resources if some of those have been acquired
+	 * before entering this function.
+	 */
+	pcim_iounmap_regions(pdev, 0xf);
+ err_out:
+	devres_release_group(&pdev->dev, NULL);
+	return rc;
+}
+
 struct ata_legacy_devres {
 	unsigned int	mask;
 	unsigned long	cmd_port[2];
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 7aa6085..43d9356 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -663,6 +663,7 @@ struct ata_port_info {
 	unsigned long		mwdma_mask;
 	unsigned long		udma_mask;
 	const struct ata_port_operations *port_ops;
+	irq_handler_t		irq_handler;
 	void 			*private_data;
 };
 
@@ -685,6 +686,7 @@ extern const unsigned long sata_deb_timing_hotplug[];
 extern const unsigned long sata_deb_timing_long[];
 
 extern const struct ata_port_operations ata_dummy_port_ops;
+extern const struct ata_port_info ata_dummy_port_info;
 
 static inline const unsigned long *
 sata_ehc_deb_timing(struct ata_eh_context *ehc)
@@ -883,6 +885,9 @@ extern struct ata_probe_ent *
 ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port, int portmask);
 extern int ata_pci_init_native_host(struct ata_host *host,
 				    unsigned int port_mask);
+extern int ata_pci_prepare_native_host(struct pci_dev *pdev,
+				const struct ata_port_info * const * ppi,
+				int n_ports, struct ata_host **r_host);
 extern int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits);
 extern int pci_configure_dma_masks(struct pci_dev *pdev, u64 dma_mask,
 				   u64 *configured_mask);
-- 
1.5.0.1


