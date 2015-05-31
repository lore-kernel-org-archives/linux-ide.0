From: Robert Richter <rric@kernel.org>
Subject: [PATCH v4 2/3] ahci: Store irq number in struct ahci_host_priv
Date: Sun, 31 May 2015 13:55:18 +0200
Message-ID: <1433073319-13796-3-git-send-email-rric@kernel.org>
References: <1433073319-13796-1-git-send-email-rric@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35039 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758147AbbEaLzd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 31 May 2015 07:55:33 -0400
In-Reply-To: <1433073319-13796-1-git-send-email-rric@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Sunil Goutham <sgoutham@cavium.com>, Jiang Liu <jiang.liu@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Robert Richter <rrichter@cavium.com>

From: Robert Richter <rrichter@cavium.com>

Currently, ahci supports only msi and intx. To also support msix the
handling of the irq number need to be changed. The irq number for msix
devices is taken from msi_list instead of pci_dev. Thus, the irq
number of a device needs to be stored in struct ahci_host_priv now.
This allows the host controller to be activated in a generic way.

This change is only intended for ahci drivers. For that reason the irq
number is stored in struct ahci_host_priv used only by ahci drivers.
Thus, the ABI changes only for ahci_host_activate(), but existing ata
drivers (about 50) are unaffected and keep unchanged. All users of
ahci_host_activate() have been updated.

While touching drivers/ata/libahci.c, doing a small code cleanup in
ahci_port_start().

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/ata/acard-ahci.c       |  4 +++-
 drivers/ata/ahci.c             | 15 ++++++++++-----
 drivers/ata/ahci.h             |  4 ++--
 drivers/ata/libahci.c          | 16 +++++++---------
 drivers/ata/libahci_platform.c |  4 +++-
 drivers/ata/sata_highbank.c    |  3 ++-
 6 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
index 12489ce863c4..ed6a30cd681a 100644
--- a/drivers/ata/acard-ahci.c
+++ b/drivers/ata/acard-ahci.c
@@ -433,6 +433,8 @@ static int acard_ahci_init_one(struct pci_dev *pdev, const struct pci_device_id
 	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
 	if (!hpriv)
 		return -ENOMEM;
+
+	hpriv->irq = pdev->irq;
 	hpriv->flags |= (unsigned long)pi.private_data;
 
 	if (!(hpriv->flags & AHCI_HFLAG_NO_MSI))
@@ -498,7 +500,7 @@ static int acard_ahci_init_one(struct pci_dev *pdev, const struct pci_device_id
 	acard_ahci_pci_print_info(host);
 
 	pci_set_master(pdev);
-	return ahci_host_activate(host, pdev->irq, &acard_ahci_sht);
+	return ahci_host_activate(host, &acard_ahci_sht);
 }
 
 module_pci_driver(acard_ahci_pci_driver);
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 7ba5332476c6..a3c66c3bb76e 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1237,14 +1237,18 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 	if (nvec > 1)
 		hpriv->flags |= AHCI_HFLAG_MULTI_MSI;
 
-	return nvec;
+	goto out;
 
 single_msi:
+	nvec = 1;
+
 	rc = pci_enable_msi(pdev);
 	if (rc < 0)
 		return rc;
+out:
+	hpriv->irq = pdev->irq;
 
-	return 1;
+	return nvec;
 }
 
 static int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
@@ -1258,6 +1262,7 @@ static int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
 
 	/* lagacy intx interrupts */
 	pci_intx(pdev, 1);
+	hpriv->irq = pdev->irq;
 
 	return 0;
 }
@@ -1423,13 +1428,13 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 */
 	n_ports = max(ahci_nr_ports(hpriv->cap), fls(hpriv->port_map));
 
-	ahci_init_interrupts(pdev, n_ports, hpriv);
-
 	host = ata_host_alloc_pinfo(&pdev->dev, ppi, n_ports);
 	if (!host)
 		return -ENOMEM;
 	host->private_data = hpriv;
 
+	ahci_init_interrupts(pdev, n_ports, hpriv);
+
 	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
 		host->flags |= ATA_HOST_PARALLEL_SCAN;
 	else
@@ -1475,7 +1480,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_master(pdev);
 
-	return ahci_host_activate(host, pdev->irq, &ahci_sht);
+	return ahci_host_activate(host, &ahci_sht);
 }
 
 module_pci_driver(ahci_pci_driver);
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index f4429600e2bf..5b8e8a0fab48 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -343,6 +343,7 @@ struct ahci_host_priv {
 	struct phy		**phys;
 	unsigned		nports;		/* Number of ports */
 	void			*plat_data;	/* Other platform data */
+	unsigned int		irq;		/* interrupt line */
 	/*
 	 * Optional ahci_start_engine override, if not set this gets set to the
 	 * default ahci_start_engine during ahci_save_initial_config, this can
@@ -395,8 +396,7 @@ void ahci_set_em_messages(struct ahci_host_priv *hpriv,
 			  struct ata_port_info *pi);
 int ahci_reset_em(struct ata_host *host);
 void ahci_print_info(struct ata_host *host, const char *scc_s);
-int ahci_host_activate(struct ata_host *host, int irq,
-		       struct scsi_host_template *sht);
+int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht);
 void ahci_error_handler(struct ata_port *ap);
 
 static inline void __iomem *__ahci_port_base(struct ata_host *host,
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 1add5baec584..1c99402a1017 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2344,7 +2344,7 @@ static int ahci_port_start(struct ata_port *ap)
 	/*
 	 * Switch to per-port locking in case each port has its own MSI vector.
 	 */
-	if ((hpriv->flags & AHCI_HFLAG_MULTI_MSI)) {
+	if (hpriv->flags & AHCI_HFLAG_MULTI_MSI) {
 		spin_lock_init(&pp->lock);
 		ap->lock = &pp->lock;
 	}
@@ -2472,7 +2472,10 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host, int irq,
 	rc = ata_host_start(host);
 	if (rc)
 		return rc;
-
+	/*
+	 * Requests IRQs according to AHCI-1.1 when multiple MSIs were
+	 * allocated. That is one MSI per port, starting from @irq.
+	 */
 	for (i = 0; i < host->n_ports; i++) {
 		struct ahci_port_priv *pp = host->ports[i]->private_data;
 
@@ -2511,23 +2514,18 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host, int irq,
 /**
  *	ahci_host_activate - start AHCI host, request IRQs and register it
  *	@host: target ATA host
- *	@irq: base IRQ number to request
  *	@sht: scsi_host_template to use when registering the host
  *
- *	Similar to ata_host_activate, but requests IRQs according to AHCI-1.1
- *	when multiple MSIs were allocated. That is one MSI per port, starting
- *	from @irq.
- *
  *	LOCKING:
  *	Inherited from calling layer (may sleep).
  *
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int ahci_host_activate(struct ata_host *host, int irq,
-		       struct scsi_host_template *sht)
+int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht)
 {
 	struct ahci_host_priv *hpriv = host->private_data;
+	int irq = hpriv->irq;
 	int rc;
 
 	if (hpriv->flags & AHCI_HFLAG_MULTI_MSI)
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index d89305d289f6..aaa761b9081c 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -518,6 +518,8 @@ int ahci_platform_init_host(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
+	hpriv->irq = irq;
+
 	/* prepare host */
 	pi.private_data = (void *)(unsigned long)hpriv->flags;
 
@@ -588,7 +590,7 @@ int ahci_platform_init_host(struct platform_device *pdev,
 	ahci_init_controller(host);
 	ahci_print_info(host, "platform");
 
-	return ahci_host_activate(host, irq, sht);
+	return ahci_host_activate(host, sht);
 }
 EXPORT_SYMBOL_GPL(ahci_platform_init_host);
 
diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index 24e311fe2c1c..8638d575b2b9 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -499,6 +499,7 @@ static int ahci_highbank_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	hpriv->irq = irq;
 	hpriv->flags |= (unsigned long)pi.private_data;
 
 	hpriv->mmio = devm_ioremap(dev, mem->start, resource_size(mem));
@@ -568,7 +569,7 @@ static int ahci_highbank_probe(struct platform_device *pdev)
 	ahci_init_controller(host);
 	ahci_print_info(host, "platform");
 
-	rc = ahci_host_activate(host, irq, &ahci_highbank_platform_sht);
+	rc = ahci_host_activate(host, &ahci_highbank_platform_sht);
 	if (rc)
 		goto err0;
 
-- 
2.1.1

