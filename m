From: Robert Richter <rric@kernel.org>
Subject: [PATCH v3 2/3] ahci: Store irq number in struct ahci_host_priv
Date: Wed, 27 May 2015 10:01:32 +0200
Message-ID: <1432713693-4282-3-git-send-email-rric@kernel.org>
References: <1432713693-4282-1-git-send-email-rric@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:33857 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621AbbE0ICA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 May 2015 04:02:00 -0400
In-Reply-To: <1432713693-4282-1-git-send-email-rric@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Sunil Goutham <sgoutham@cavium.com>, Jiang Liu <jiang.liu@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Robert Richter <rrichter@cavium.com>

From: Robert Richter <rrichter@cavium.com>

The irq number for msix devices is taken from msi_list instead of
pci_dev. Thus, the irq number of a device needs to be stored in struct
ahci_host_priv now.  Host controller can be activated then in a
generic way.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/ata/acard-ahci.c       |  4 +++-
 drivers/ata/ahci.c             | 15 ++++++++++-----
 drivers/ata/ahci.h             |  4 ++--
 drivers/ata/libahci.c          | 25 ++++++++++---------------
 drivers/ata/libahci_platform.c |  4 +++-
 drivers/ata/sata_highbank.c    |  3 ++-
 6 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
index c962886d7e71..c67fce2a4cbf 100644
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
index c8aedd836dc9..8cdc9ebbbc43 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1237,20 +1237,25 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
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
 
 static int ahci_init_intx(struct pci_dev *pdev, unsigned int n_ports,
 			struct ahci_host_priv *hpriv)
 {
 	pci_intx(pdev, 1);
+	hpriv->irq = pdev->irq;
 
 	return 0;
 }
@@ -1428,13 +1433,13 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -1480,7 +1485,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_master(pdev);
 
-	return ahci_host_activate(host, pdev->irq, &ahci_sht);
+	return ahci_host_activate(host, &ahci_sht);
 }
 
 module_pci_driver(ahci_pci_driver);
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 71262e08648e..f219507b1fbc 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -341,6 +341,7 @@ struct ahci_host_priv {
 	struct phy		**phys;
 	unsigned		nports;		/* Number of ports */
 	void			*plat_data;	/* Other platform data */
+	unsigned int		irq;		/* interrupt line */
 	/*
 	 * Optional ahci_start_engine override, if not set this gets set to the
 	 * default ahci_start_engine during ahci_save_initial_config, this can
@@ -393,8 +394,7 @@ void ahci_set_em_messages(struct ahci_host_priv *hpriv,
 			  struct ata_port_info *pi);
 int ahci_reset_em(struct ata_host *host);
 void ahci_print_info(struct ata_host *host, const char *scc_s);
-int ahci_host_activate(struct ata_host *host, int irq,
-		       struct scsi_host_template *sht);
+int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht);
 void ahci_error_handler(struct ata_port *ap);
 
 static inline void __iomem *__ahci_port_base(struct ata_host *host,
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 61a9c07e0dff..022da7ce77fb 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2298,7 +2298,7 @@ static int ahci_port_start(struct ata_port *ap)
 	/*
 	 * Switch to per-port locking in case each port has its own MSI vector.
 	 */
-	if ((hpriv->flags & AHCI_HFLAG_MULTI_MSI)) {
+	if (hpriv->flags & AHCI_HFLAG_MULTI_MSI) {
 		spin_lock_init(&pp->lock);
 		ap->lock = &pp->lock;
 	}
@@ -2426,7 +2426,10 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host, int irq,
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
 
@@ -2465,31 +2468,23 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host, int irq,
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
-	int rc;
 
 	if (hpriv->flags & AHCI_HFLAG_MULTI_MSI)
-		rc = ahci_host_activate_multi_irqs(host, irq, sht);
-	else
-		rc = ata_host_activate(host, irq, ahci_single_irq_intr,
-				       IRQF_SHARED, sht);
-	return rc;
+		return ahci_host_activate_multi_irqs(host, hpriv->irq, sht);
+
+	return ata_host_activate(host, hpriv->irq, ahci_single_irq_intr,
+				IRQF_SHARED, sht);
 }
 EXPORT_SYMBOL_GPL(ahci_host_activate);
 
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

