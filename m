From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/3] libata: factor out ata_pci_activate_sff_host() from ata_pci_one()
Date: Fri, 18 Jan 2008 18:36:28 +0900
Message-ID: <12006489903674-git-send-email-htejun@gmail.com>
References: <12006489901911-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:36433 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595AbYARJgj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jan 2008 04:36:39 -0500
Received: by rv-out-0910.google.com with SMTP id k20so835842rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 18 Jan 2008 01:36:37 -0800 (PST)
In-Reply-To: <12006489901911-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Factor out ata_pci_activate_sff_host() from ata_pci_one().  This does
about the same thing as ata_host_activate() but needs to be separate
because SFF controllers use different and multiple IRQs in legacy
mode.

This will be used to make SFF LLD initialization more flexible.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    1 +
 drivers/ata/libata-sff.c  |  187 +++++++++++++++++++++++++--------------------
 include/linux/libata.h    |    3 +
 3 files changed, 107 insertions(+), 84 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 06ff781..8fc664d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -7644,6 +7644,7 @@ EXPORT_SYMBOL_GPL(pci_test_config_bits);
 EXPORT_SYMBOL_GPL(ata_pci_init_sff_host);
 EXPORT_SYMBOL_GPL(ata_pci_init_bmdma);
 EXPORT_SYMBOL_GPL(ata_pci_prepare_sff_host);
+EXPORT_SYMBOL_GPL(ata_pci_activate_sff_host);
 EXPORT_SYMBOL_GPL(ata_pci_init_one);
 EXPORT_SYMBOL_GPL(ata_pci_remove_one);
 #ifdef CONFIG_PM
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 97dd8f2..60cd4b1 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -714,6 +714,99 @@ int ata_pci_prepare_sff_host(struct pci_dev *pdev,
 }
 
 /**
+ *	ata_pci_activate_sff_host - start SFF host, request IRQ and register it
+ *	@host: target SFF ATA host
+ *	@irq_handler: irq_handler used when requesting IRQ(s)
+ *	@sht: scsi_host_template to use when registering the host
+ *
+ *	This is the counterpart of ata_host_activate() for SFF ATA
+ *	hosts.  This separate helper is necessary because SFF hosts
+ *	use two separate interrupts in legacy mode.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_pci_activate_sff_host(struct ata_host *host,
+			      irq_handler_t irq_handler,
+			      struct scsi_host_template *sht)
+{
+	struct device *dev = host->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	const char *drv_name = dev_driver_string(host->dev);
+	int legacy_mode = 0, rc;
+
+	rc = ata_host_start(host);
+	if (rc)
+		return rc;
+
+	if ((pdev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
+		u8 tmp8, mask;
+
+		/* TODO: What if one channel is in native mode ... */
+		pci_read_config_byte(pdev, PCI_CLASS_PROG, &tmp8);
+		mask = (1 << 2) | (1 << 0);
+		if ((tmp8 & mask) != mask)
+			legacy_mode = 1;
+#if defined(CONFIG_NO_ATA_LEGACY)
+		/* Some platforms with PCI limits cannot address compat
+		   port space. In that case we punt if their firmware has
+		   left a device in compatibility mode */
+		if (legacy_mode) {
+			printk(KERN_ERR "ata: Compatibility mode ATA is not supported on this platform, skipping.\n");
+			return -EOPNOTSUPP;
+		}
+#endif
+	}
+
+	if (!devres_open_group(dev, NULL, GFP_KERNEL))
+		return -ENOMEM;
+
+	if (!legacy_mode && pdev->irq) {
+		rc = devm_request_irq(dev, pdev->irq, irq_handler,
+				      IRQF_SHARED, drv_name, host);
+		if (rc)
+			goto out;
+
+		ata_port_desc(host->ports[0], "irq %d", pdev->irq);
+		ata_port_desc(host->ports[1], "irq %d", pdev->irq);
+	} else if (legacy_mode) {
+		if (!ata_port_is_dummy(host->ports[0])) {
+			rc = devm_request_irq(dev, ATA_PRIMARY_IRQ(pdev),
+					      irq_handler, IRQF_SHARED,
+					      drv_name, host);
+			if (rc)
+				goto out;
+
+			ata_port_desc(host->ports[0], "irq %d",
+				      ATA_PRIMARY_IRQ(pdev));
+		}
+
+		if (!ata_port_is_dummy(host->ports[1])) {
+			rc = devm_request_irq(dev, ATA_SECONDARY_IRQ(pdev),
+					      irq_handler, IRQF_SHARED,
+					      drv_name, host);
+			if (rc)
+				goto out;
+
+			ata_port_desc(host->ports[1], "irq %d",
+				      ATA_SECONDARY_IRQ(pdev));
+		}
+	}
+
+	rc = ata_host_register(host, sht);
+ out:
+	if (rc == 0)
+		devres_remove_group(dev, NULL);
+	else
+		devres_release_group(dev, NULL);
+
+	return rc;
+}
+
+/**
  *	ata_pci_init_one - Initialize/register PCI IDE host controller
  *	@pdev: Controller to be initialized
  *	@ppi: array of port_info, must be enough for two ports
@@ -742,9 +835,6 @@ int ata_pci_init_one(struct pci_dev *pdev,
 	struct device *dev = &pdev->dev;
 	const struct ata_port_info *pi = NULL;
 	struct ata_host *host = NULL;
-	const char *drv_name = dev_driver_string(&pdev->dev);
-	u8 mask;
-	int legacy_mode = 0;
 	int i, rc;
 
 	DPRINTK("ENTER\n");
@@ -766,95 +856,24 @@ int ata_pci_init_one(struct pci_dev *pdev,
 	if (!devres_open_group(dev, NULL, GFP_KERNEL))
 		return -ENOMEM;
 
-	/* FIXME: Really for ATA it isn't safe because the device may be
-	   multi-purpose and we want to leave it alone if it was already
-	   enabled. Secondly for shared use as Arjan says we want refcounting
-
-	   Checking dev->is_enabled is insufficient as this is not set at
-	   boot for the primary video which is BIOS enabled
-	  */
-
 	rc = pcim_enable_device(pdev);
 	if (rc)
-		goto err_out;
+		goto out;
 
-	if ((pdev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
-		u8 tmp8;
-
-		/* TODO: What if one channel is in native mode ... */
-		pci_read_config_byte(pdev, PCI_CLASS_PROG, &tmp8);
-		mask = (1 << 2) | (1 << 0);
-		if ((tmp8 & mask) != mask)
-			legacy_mode = 1;
-#if defined(CONFIG_NO_ATA_LEGACY)
-		/* Some platforms with PCI limits cannot address compat
-		   port space. In that case we punt if their firmware has
-		   left a device in compatibility mode */
-		if (legacy_mode) {
-			printk(KERN_ERR "ata: Compatibility mode ATA is not supported on this platform, skipping.\n");
-			rc = -EOPNOTSUPP;
-			goto err_out;
-		}
-#endif
-	}
-
-	/* prepare host */
+	/* prepare and activate SFF host */
 	rc = ata_pci_prepare_sff_host(pdev, ppi, &host);
 	if (rc)
-		goto err_out;
+		goto out;
 
 	pci_set_master(pdev);
+	rc = ata_pci_activate_sff_host(host, pi->port_ops->irq_handler,
+				       pi->sht);
+ out:
+	if (rc == 0)
+		devres_remove_group(&pdev->dev, NULL);
+	else
+		devres_release_group(&pdev->dev, NULL);
 
-	/* start host and request IRQ */
-	rc = ata_host_start(host);
-	if (rc)
-		goto err_out;
-
-	if (!legacy_mode && pdev->irq) {
-		/* We may have no IRQ assigned in which case we can poll. This
-		   shouldn't happen on a sane system but robustness is cheap
-		   in this case */
-		rc = devm_request_irq(dev, pdev->irq, pi->port_ops->irq_handler,
-				      IRQF_SHARED, drv_name, host);
-		if (rc)
-			goto err_out;
-
-		ata_port_desc(host->ports[0], "irq %d", pdev->irq);
-		ata_port_desc(host->ports[1], "irq %d", pdev->irq);
-	} else if (legacy_mode) {
-		if (!ata_port_is_dummy(host->ports[0])) {
-			rc = devm_request_irq(dev, ATA_PRIMARY_IRQ(pdev),
-					      pi->port_ops->irq_handler,
-					      IRQF_SHARED, drv_name, host);
-			if (rc)
-				goto err_out;
-
-			ata_port_desc(host->ports[0], "irq %d",
-				      ATA_PRIMARY_IRQ(pdev));
-		}
-
-		if (!ata_port_is_dummy(host->ports[1])) {
-			rc = devm_request_irq(dev, ATA_SECONDARY_IRQ(pdev),
-					      pi->port_ops->irq_handler,
-					      IRQF_SHARED, drv_name, host);
-			if (rc)
-				goto err_out;
-
-			ata_port_desc(host->ports[1], "irq %d",
-				      ATA_SECONDARY_IRQ(pdev));
-		}
-	}
-
-	/* register */
-	rc = ata_host_register(host, pi->sht);
-	if (rc)
-		goto err_out;
-
-	devres_remove_group(dev, NULL);
-	return 0;
-
-err_out:
-	devres_release_group(dev, NULL);
 	return rc;
 }
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index ccb0556..4374c42 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1033,6 +1033,9 @@ extern int ata_pci_init_bmdma(struct ata_host *host);
 extern int ata_pci_prepare_sff_host(struct pci_dev *pdev,
 				    const struct ata_port_info * const * ppi,
 				    struct ata_host **r_host);
+extern int ata_pci_activate_sff_host(struct ata_host *host,
+				     irq_handler_t irq_handler,
+				     struct scsi_host_template *sht);
 extern int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits);
 extern unsigned long ata_pci_default_filter(struct ata_device *dev,
 					    unsigned long xfer_mask);
-- 
1.5.2.4

