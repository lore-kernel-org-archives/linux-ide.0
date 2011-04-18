From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 1/2] libata-sff: remove hardcoded requirement for two ports
Date: Mon, 18 Apr 2011 13:44:18 -0500
Message-ID: <1303152258.7167.14.camel@mulgrave.site>
References: <1303152147.7167.12.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1303152147.7167.12.camel@mulgrave.site>
Sender: linux-parisc-owner@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>
Cc: Parisc List <linux-parisc@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

The two port requirement in libata-sff is causing crashes on non-x86
systems which are wired up with the second port disabled.

Fix libata-sff to key of a new host flag ATA_HOST_SFF_SINGLE_PORT
which tells it only to probe the primary port of the host.  This
prevents the crash by preventing the disabled secondary registers from
being touched.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/ata/libata-sff.c |   75 +++++++++++++++++++++++++++++++++-------------
 include/linux/libata.h   |    1 +
 2 files changed, 55 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index f8380ce..f0aa7db 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2296,7 +2296,7 @@ int ata_pci_sff_init_host(struct ata_host *host)
 	int i, rc;
 
 	/* request, iomap BARs and init port addresses accordingly */
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 		int base = i * 2;
 		void __iomem * const *iomap;
@@ -2349,10 +2349,11 @@ int ata_pci_sff_init_host(struct ata_host *host)
 EXPORT_SYMBOL_GPL(ata_pci_sff_init_host);
 
 /**
- *	ata_pci_sff_prepare_host - helper to prepare PCI PIO-only SFF ATA host
+ *	ata_pci_sff_prepare_host_ports - helper to prepare PCI PIO-only SFF ATA host
  *	@pdev: target PCI device
  *	@ppi: array of port_info, must be enough for two ports
  *	@r_host: out argument for the initialized ATA host
+ *	@ports: number of ports in the host
  *
  *	Helper to allocate PIO-only SFF ATA host for @pdev, acquire
  *	all PCI resources and initialize it accordingly in one go.
@@ -2363,9 +2364,9 @@ EXPORT_SYMBOL_GPL(ata_pci_sff_init_host);
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int ata_pci_sff_prepare_host(struct pci_dev *pdev,
-			     const struct ata_port_info * const *ppi,
-			     struct ata_host **r_host)
+static int ata_pci_sff_prepare_host_ports(struct pci_dev *pdev,
+					  const struct ata_port_info * const *ppi,
+					  struct ata_host **r_host, int nports)
 {
 	struct ata_host *host;
 	int rc;
@@ -2373,7 +2374,7 @@ int ata_pci_sff_prepare_host(struct pci_dev *pdev,
 	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL))
 		return -ENOMEM;
 
-	host = ata_host_alloc_pinfo(&pdev->dev, ppi, 2);
+	host = ata_host_alloc_pinfo(&pdev->dev, ppi, nports);
 	if (!host) {
 		dev_printk(KERN_ERR, &pdev->dev,
 			   "failed to allocate ATA host\n");
@@ -2393,6 +2394,27 @@ err_out:
 	devres_release_group(&pdev->dev, NULL);
 	return rc;
 }
+
+/**
+ *	ata_pci_sff_prepare_host - helper to prepare PCI PIO-only SFF ATA host
+ *	@pdev: target PCI device
+ *	@ppi: array of port_info, must be enough for two ports
+ *	@r_host: out argument for the initialized ATA host
+ *
+ *	Helper to allocate PIO-only SFF ATA host for @pdev, acquire
+ *	all PCI resources and initialize it accordingly in one go.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_pci_sff_prepare_host(struct pci_dev *pdev,
+			     const struct ata_port_info * const *ppi,
+			     struct ata_host **r_host) {
+	return ata_pci_sff_prepare_host_ports(pdev, ppi, r_host, 2);
+}
 EXPORT_SYMBOL_GPL(ata_pci_sff_prepare_host);
 
 /**
@@ -2447,13 +2469,15 @@ int ata_pci_sff_activate_host(struct ata_host *host,
 		return -ENOMEM;
 
 	if (!legacy_mode && pdev->irq) {
+		int i;
+
 		rc = devm_request_irq(dev, pdev->irq, irq_handler,
 				      IRQF_SHARED, drv_name, host);
 		if (rc)
 			goto out;
 
-		ata_port_desc(host->ports[0], "irq %d", pdev->irq);
-		ata_port_desc(host->ports[1], "irq %d", pdev->irq);
+		for (i = 0; i < host->n_ports; i++)
+			ata_port_desc(host->ports[i], "irq %d", pdev->irq);
 	} else if (legacy_mode) {
 		if (!ata_port_is_dummy(host->ports[0])) {
 			rc = devm_request_irq(dev, ATA_PRIMARY_IRQ(pdev),
@@ -2466,7 +2490,7 @@ int ata_pci_sff_activate_host(struct ata_host *host,
 				      ATA_PRIMARY_IRQ(pdev));
 		}
 
-		if (!ata_port_is_dummy(host->ports[1])) {
+		if (host->n_ports > 1 && !ata_port_is_dummy(host->ports[1])) {
 			rc = devm_request_irq(dev, ATA_SECONDARY_IRQ(pdev),
 					      irq_handler, IRQF_SHARED,
 					      drv_name, host);
@@ -2532,6 +2556,7 @@ int ata_pci_sff_init_one(struct pci_dev *pdev,
 	const struct ata_port_info *pi;
 	struct ata_host *host = NULL;
 	int rc;
+	int nports = (hflag & ATA_HOST_SFF_SINGLE_PORT) ? 1 : 2;
 
 	DPRINTK("ENTER\n");
 
@@ -2550,7 +2575,7 @@ int ata_pci_sff_init_one(struct pci_dev *pdev,
 		goto out;
 
 	/* prepare and activate SFF host */
-	rc = ata_pci_sff_prepare_host(pdev, ppi, &host);
+	rc = ata_pci_sff_prepare_host_ports(pdev, ppi, &host, nports);
 	if (rc)
 		goto out;
 	host->private_data = host_priv;
@@ -3162,7 +3187,7 @@ static void ata_bmdma_nodma(struct ata_host *host, const char *reason)
 	dev_printk(KERN_ERR, host->dev, "BMDMA: %s, falling back to PIO\n",
 		   reason);
 
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < host->n_ports; i++) {
 		host->ports[i]->mwdma_mask = 0;
 		host->ports[i]->udma_mask = 0;
 	}
@@ -3213,7 +3238,7 @@ void ata_pci_bmdma_init(struct ata_host *host)
 	}
 	host->iomap = pcim_iomap_table(pdev);
 
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 		void __iomem *bmdma = host->iomap[4] + 8 * i;
 
@@ -3231,6 +3256,20 @@ void ata_pci_bmdma_init(struct ata_host *host)
 }
 EXPORT_SYMBOL_GPL(ata_pci_bmdma_init);
 
+static int ata_pci_bmdma_prepare_host_ports(struct pci_dev *pdev,
+					    const struct ata_port_info * const * ppi,
+					    struct ata_host **r_host, int nports)
+{
+	int rc;
+
+	rc = ata_pci_sff_prepare_host_ports(pdev, ppi, r_host, nports);
+	if (rc)
+		return rc;
+
+	ata_pci_bmdma_init(*r_host);
+	return 0;
+}
+
 /**
  *	ata_pci_bmdma_prepare_host - helper to prepare PCI BMDMA ATA host
  *	@pdev: target PCI device
@@ -3250,14 +3289,7 @@ int ata_pci_bmdma_prepare_host(struct pci_dev *pdev,
 			       const struct ata_port_info * const * ppi,
 			       struct ata_host **r_host)
 {
-	int rc;
-
-	rc = ata_pci_sff_prepare_host(pdev, ppi, r_host);
-	if (rc)
-		return rc;
-
-	ata_pci_bmdma_init(*r_host);
-	return 0;
+	return ata_pci_bmdma_prepare_host_ports(pdev, ppi, r_host, 2);
 }
 EXPORT_SYMBOL_GPL(ata_pci_bmdma_prepare_host);
 
@@ -3287,6 +3319,7 @@ int ata_pci_bmdma_init_one(struct pci_dev *pdev,
 	const struct ata_port_info *pi;
 	struct ata_host *host = NULL;
 	int rc;
+	int nports = (hflags & ATA_HOST_SFF_SINGLE_PORT) ? 1 : 2;
 
 	DPRINTK("ENTER\n");
 
@@ -3305,7 +3338,7 @@ int ata_pci_bmdma_init_one(struct pci_dev *pdev,
 		goto out;
 
 	/* prepare and activate BMDMA host */
-	rc = ata_pci_bmdma_prepare_host(pdev, ppi, &host);
+	rc = ata_pci_bmdma_prepare_host_ports(pdev, ppi, &host, nports);
 	if (rc)
 		goto out;
 	host->private_data = host_priv;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 7f675aa..554b0d2 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -238,6 +238,7 @@ enum {
 	ATA_HOST_SIMPLEX	= (1 << 0),	/* Host is simplex, one DMA channel per host only */
 	ATA_HOST_STARTED	= (1 << 1),	/* Host started */
 	ATA_HOST_PARALLEL_SCAN	= (1 << 2),	/* Ports on this host can be scanned in parallel */
+	ATA_HOST_SFF_SINGLE_PORT = (1 << 3),	/* SFF interface should only probe one port not two */
 
 	/* bits 24:31 of host->flags are reserved for LLD specific flags */
 
-- 
1.7.4.1



