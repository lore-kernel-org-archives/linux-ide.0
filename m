From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev#upstream] libata: simplify PCI legacy SFF host
 handling
Date: Wed, 04 Jul 2007 18:02:07 +0900
Message-ID: <468B620F.3010603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:35982 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755183AbXGDJCN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 05:02:13 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3172873wah
        for <linux-ide@vger.kernel.org>; Wed, 04 Jul 2007 02:02:12 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>


With PCI resource fix up for legacy hosts.  We can use the same code
path to allocate IO resources and initialize host for both legacy and
native SFF hosts.  Only IRQ requesting needs to be different.

Rename ata_pci_*_native_host() to ata_pci_*_sff_host(), kill all
legacy specific functions and use the renamed functions instead.  This
simplifies code a lot.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
Gee, I like it.  The BAR fixup thing was a really good idea.  :-)

 drivers/ata/libata-core.c |    4 
 drivers/ata/libata-sff.c  |  288 +++++-----------------------------------------
 drivers/ata/sata_nv.c     |    2 
 drivers/ata/sata_sis.c    |    2 
 drivers/ata/sata_uli.c    |    2 
 drivers/ata/sata_via.c    |    2 
 include/linux/libata.h    |    8 -
 7 files changed, 42 insertions(+), 266 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -6961,9 +6961,9 @@ EXPORT_SYMBOL_GPL(ata_timing_merge);
 
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL_GPL(pci_test_config_bits);
-EXPORT_SYMBOL_GPL(ata_pci_init_native_host);
+EXPORT_SYMBOL_GPL(ata_pci_init_sff_host);
 EXPORT_SYMBOL_GPL(ata_pci_init_bmdma);
-EXPORT_SYMBOL_GPL(ata_pci_prepare_native_host);
+EXPORT_SYMBOL_GPL(ata_pci_prepare_sff_host);
 EXPORT_SYMBOL_GPL(ata_pci_init_one);
 EXPORT_SYMBOL_GPL(ata_pci_remove_one);
 #ifdef CONFIG_PM
Index: work/drivers/ata/libata-sff.c
===================================================================
--- work.orig/drivers/ata/libata-sff.c
+++ work/drivers/ata/libata-sff.c
@@ -604,13 +604,17 @@ int ata_pci_init_bmdma(struct ata_host *
 }
 
 /**
- *	ata_pci_init_native_host - acquire native ATA resources and init host
+ *	ata_pci_init_sff_host - acquire native PCI ATA resources and init host
  *	@host: target ATA host
  *
  *	Acquire native PCI ATA resources for @host and initialize the
  *	first two ports of @host accordingly.  Ports marked dummy are
  *	skipped and allocation failure makes the port dummy.
  *
+ *	Note that native PCI resources are valid even for legacy hosts
+ *	as we fix up pdev resources array early in boot, so this
+ *	function can be used for both native and legacy SFF hosts.
+ *
  *	LOCKING:
  *	Inherited from calling layer (may sleep).
  *
@@ -618,7 +622,7 @@ int ata_pci_init_bmdma(struct ata_host *
  *	0 if at least one port is initialized, -ENODEV if no port is
  *	available.
  */
-int ata_pci_init_native_host(struct ata_host *host)
+int ata_pci_init_sff_host(struct ata_host *host)
 {
 	struct device *gdev = host->dev;
 	struct pci_dev *pdev = to_pci_dev(gdev);
@@ -673,7 +677,7 @@ int ata_pci_init_native_host(struct ata_
 }
 
 /**
- *	ata_pci_prepare_native_host - helper to prepare native PCI ATA host
+ *	ata_pci_prepare_sff_host - helper to prepare native PCI ATA host
  *	@pdev: target PCI device
  *	@ppi: array of port_info, must be enough for two ports
  *	@r_host: out argument for the initialized ATA host
@@ -687,9 +691,9 @@ int ata_pci_init_native_host(struct ata_
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int ata_pci_prepare_native_host(struct pci_dev *pdev,
-				const struct ata_port_info * const * ppi,
-				struct ata_host **r_host)
+int ata_pci_prepare_sff_host(struct pci_dev *pdev,
+			     const struct ata_port_info * const * ppi,
+			     struct ata_host **r_host)
 {
 	struct ata_host *host;
 	int rc;
@@ -705,7 +709,7 @@ int ata_pci_prepare_native_host(struct p
 		goto err_out;
 	}
 
-	rc = ata_pci_init_native_host(host);
+	rc = ata_pci_init_sff_host(host);
 	if (rc)
 		goto err_out;
 
@@ -730,221 +734,6 @@ int ata_pci_prepare_native_host(struct p
 	return rc;
 }
 
-struct ata_legacy_devres {
-	unsigned int	mask;
-	unsigned long	cmd_port[2];
-	void __iomem *	cmd_addr[2];
-	void __iomem *	ctl_addr[2];
-	unsigned int	irq[2];
-	void *		irq_dev_id[2];
-};
-
-static void ata_legacy_free_irqs(struct ata_legacy_devres *legacy_dr)
-{
-	int i;
-
-	for (i = 0; i < 2; i++) {
-		if (!legacy_dr->irq[i])
-			continue;
-
-		free_irq(legacy_dr->irq[i], legacy_dr->irq_dev_id[i]);
-		legacy_dr->irq[i] = 0;
-		legacy_dr->irq_dev_id[i] = NULL;
-	}
-}
-
-static void ata_legacy_release(struct device *gdev, void *res)
-{
-	struct ata_legacy_devres *this = res;
-	int i;
-
-	ata_legacy_free_irqs(this);
-
-	for (i = 0; i < 2; i++) {
-		if (this->cmd_addr[i])
-			ioport_unmap(this->cmd_addr[i]);
-		if (this->ctl_addr[i])
-			ioport_unmap(this->ctl_addr[i]);
-		if (this->cmd_port[i])
-			release_region(this->cmd_port[i], 8);
-	}
-}
-
-static int ata_init_legacy_port(struct ata_port *ap,
-				struct ata_legacy_devres *legacy_dr)
-{
-	struct ata_host *host = ap->host;
-	int port_no = ap->port_no;
-	unsigned long cmd_port, ctl_port;
-
-	if (port_no == 0) {
-		cmd_port = ATA_PRIMARY_CMD;
-		ctl_port = ATA_PRIMARY_CTL;
-	} else {
-		cmd_port = ATA_SECONDARY_CMD;
-		ctl_port = ATA_SECONDARY_CTL;
-	}
-
-	/* request cmd_port */
-	if (request_region(cmd_port, 8, "libata"))
-		legacy_dr->cmd_port[port_no] = cmd_port;
-	else {
-		dev_printk(KERN_WARNING, host->dev,
-			   "0x%0lX IDE port busy\n", cmd_port);
-		return -EBUSY;
-	}
-
-	/* iomap cmd and ctl ports */
-	legacy_dr->cmd_addr[port_no] = ioport_map(cmd_port, 8);
-	legacy_dr->ctl_addr[port_no] = ioport_map(ctl_port, 1);
-	if (!legacy_dr->cmd_addr[port_no] || !legacy_dr->ctl_addr[port_no]) {
-		dev_printk(KERN_WARNING, host->dev,
-			   "failed to map cmd/ctl ports\n");
-		return -ENOMEM;
-	}
-
-	/* init IO addresses */
-	ap->ioaddr.cmd_addr = legacy_dr->cmd_addr[port_no];
-	ap->ioaddr.altstatus_addr = legacy_dr->ctl_addr[port_no];
-	ap->ioaddr.ctl_addr = legacy_dr->ctl_addr[port_no];
-	ata_std_ports(&ap->ioaddr);
-
-	return 0;
-}
-
-/**
- *	ata_init_legacy_host - acquire legacy ATA resources and init ATA host
- *	@host: target ATA host
- *	@was_busy: out parameter, indicates whether any port was busy
- *
- *	Acquire legacy ATA resources for the first two ports of @host
- *	and initialize it accordingly.  Ports marked dummy are skipped
- *	and resource acquistion failure makes the port dummy.
- *
- *	LOCKING:
- *	Inherited from calling layer (may sleep).
- *
- *	RETURNS:
- *	0 if at least one port is initialized, -ENODEV if no port is
- *	available.
- */
-static int ata_init_legacy_host(struct ata_host *host, int *was_busy)
-{
-	struct device *gdev = host->dev;
-	struct ata_legacy_devres *legacy_dr;
-	int i, rc;
-
-	if (!devres_open_group(gdev, NULL, GFP_KERNEL))
-		return -ENOMEM;
-
-	rc = -ENOMEM;
-	legacy_dr = devres_alloc(ata_legacy_release, sizeof(*legacy_dr),
-				 GFP_KERNEL);
-	if (!legacy_dr)
-		goto err_out;
-	devres_add(gdev, legacy_dr);
-
-	for (i = 0; i < 2; i++) {
-		if (ata_port_is_dummy(host->ports[i]))
-			continue;
-
-		rc = ata_init_legacy_port(host->ports[i], legacy_dr);
-		if (rc == 0)
-			legacy_dr->mask |= 1 << i;
-		else {
-			if (rc == -EBUSY)
-				(*was_busy)++;
-			host->ports[i]->ops = &ata_dummy_port_ops;
-		}
-	}
-
-	if (!legacy_dr->mask) {
-		dev_printk(KERN_ERR, gdev, "no available legacy port\n");
-		return -ENODEV;
-	}
-
-	devres_remove_group(gdev, NULL);
-	return 0;
-
- err_out:
-	devres_release_group(gdev, NULL);
-	return rc;
-}
-
-/**
- *	ata_request_legacy_irqs - request legacy ATA IRQs
- *	@host: target ATA host
- *	@handler: array of IRQ handlers
- *	@irq_flags: array of IRQ flags
- *	@dev_id: array of IRQ dev_ids
- *
- *	Request legacy IRQs for non-dummy legacy ports in @host.  All
- *	IRQ parameters are passed as array to allow ports to have
- *	separate IRQ handlers.
- *
- *	LOCKING:
- *	Inherited from calling layer (may sleep).
- *
- *	RETURNS:
- *	0 on success, -errno otherwise.
- */
-static int ata_request_legacy_irqs(struct ata_host *host,
-				   irq_handler_t const *handler,
-				   const unsigned int *irq_flags,
-				   void * const *dev_id)
-{
-	struct device *gdev = host->dev;
-	struct ata_legacy_devres *legacy_dr;
-	int i, rc;
-
-	legacy_dr = devres_find(host->dev, ata_legacy_release, NULL, NULL);
-	BUG_ON(!legacy_dr);
-
-	for (i = 0; i < 2; i++) {
-		unsigned int irq;
-
-		/* FIXME: ATA_*_IRQ() should take generic device not pci_dev */
-		if (i == 0)
-			irq = ATA_PRIMARY_IRQ(to_pci_dev(gdev));
-		else
-			irq = ATA_SECONDARY_IRQ(to_pci_dev(gdev));
-
-		if (!(legacy_dr->mask & (1 << i)))
-			continue;
-
-		if (!handler[i]) {
-			dev_printk(KERN_ERR, gdev,
-				   "NULL handler specified for port %d\n", i);
-			rc = -EINVAL;
-			goto err_out;
-		}
-
-		rc = request_irq(irq, handler[i], irq_flags[i], DRV_NAME,
-				 dev_id[i]);
-		if (rc) {
-			dev_printk(KERN_ERR, gdev,
-				"irq %u request failed (errno=%d)\n", irq, rc);
-			goto err_out;
-		}
-
-		/* record irq allocation in legacy_dr */
-		legacy_dr->irq[i] = irq;
-		legacy_dr->irq_dev_id[i] = dev_id[i];
-
-		/* only used to print info */
-		if (i == 0)
-			host->irq = irq;
-		else
-			host->irq2 = irq;
-	}
-
-	return 0;
-
- err_out:
-	ata_legacy_free_irqs(legacy_dr);
-	return rc;
-}
-
 /**
  *	ata_pci_init_one - Initialize/register PCI IDE host controller
  *	@pdev: Controller to be initialized
@@ -1029,35 +818,11 @@ int ata_pci_init_one(struct pci_dev *pde
 #endif
 	}
 
-	/* alloc and init host */
-	host = ata_host_alloc_pinfo(dev, ppi, 2);
-	if (!host) {
-		dev_printk(KERN_ERR, &pdev->dev,
-			   "failed to allocate ATA host\n");
-		rc = -ENOMEM;
+	/* prepare host */
+	rc = ata_pci_prepare_sff_host(pdev, ppi, &host);
+	if (rc)
 		goto err_out;
-	}
-
-	if (!legacy_mode) {
-		rc = ata_pci_init_native_host(host);
-		if (rc)
-			goto err_out;
-	} else {
-		int was_busy = 0;
 
-		rc = ata_init_legacy_host(host, &was_busy);
-		if (was_busy)
-			pcim_pin_device(pdev);
-		if (rc)
-			goto err_out;
-
-		/* request respective PCI regions, may fail */
-		rc = pci_request_region(pdev, 1, DRV_NAME);
-		rc = pci_request_region(pdev, 3, DRV_NAME);
-	}
-
-	/* init BMDMA, may fail */
-	ata_pci_init_bmdma(host);
 	pci_set_master(pdev);
 
 	/* start host and request IRQ */
@@ -1068,17 +833,28 @@ int ata_pci_init_one(struct pci_dev *pde
 	if (!legacy_mode) {
 		rc = devm_request_irq(dev, pdev->irq, pi->port_ops->irq_handler,
 				      IRQF_SHARED, DRV_NAME, host);
+		if (rc)
+			goto err_out;
 		host->irq = pdev->irq;
 	} else {
-		irq_handler_t handler[2] = { host->ops->irq_handler,
-					     host->ops->irq_handler };
-		unsigned int irq_flags[2] = { IRQF_SHARED, IRQF_SHARED };
-		void *dev_id[2] = { host, host };
+		if (!ata_port_is_dummy(host->ports[0])) {
+			host->irq = ATA_PRIMARY_IRQ(pdev);
+			rc = devm_request_irq(dev, host->irq,
+					      pi->port_ops->irq_handler,
+					      IRQF_SHARED, DRV_NAME, host);
+			if (rc)
+				goto err_out;
+		}
 
-		rc = ata_request_legacy_irqs(host, handler, irq_flags, dev_id);
+		if (!ata_port_is_dummy(host->ports[1])) {
+			host->irq2 = ATA_SECONDARY_IRQ(pdev);
+			rc = devm_request_irq(dev, host->irq2,
+					      pi->port_ops->irq_handler,
+					      IRQF_SHARED, DRV_NAME, host);
+			if (rc)
+				goto err_out;
+		}
 	}
-	if (rc)
-		goto err_out;
 
 	/* register */
 	rc = ata_host_register(host, pi->sht);
Index: work/drivers/ata/sata_nv.c
===================================================================
--- work.orig/drivers/ata/sata_nv.c
+++ work/drivers/ata/sata_nv.c
@@ -1560,7 +1560,7 @@ static int nv_init_one (struct pci_dev *
 	}
 
 	ppi[0] = &nv_port_info[type];
-	rc = ata_pci_prepare_native_host(pdev, ppi, &host);
+	rc = ata_pci_prepare_sff_host(pdev, ppi, &host);
 	if (rc)
 		return rc;
 
Index: work/drivers/ata/sata_sis.c
===================================================================
--- work.orig/drivers/ata/sata_sis.c
+++ work/drivers/ata/sata_sis.c
@@ -334,7 +334,7 @@ static int sis_init_one (struct pci_dev 
 		break;
 	}
 
-	rc = ata_pci_prepare_native_host(pdev, ppi, &host);
+	rc = ata_pci_prepare_sff_host(pdev, ppi, &host);
 	if (rc)
 		return rc;
 
Index: work/drivers/ata/sata_uli.c
===================================================================
--- work.orig/drivers/ata/sata_uli.c
+++ work/drivers/ata/sata_uli.c
@@ -213,7 +213,7 @@ static int uli_init_one (struct pci_dev 
 	host->private_data = hpriv;
 
 	/* the first two ports are standard SFF */
-	rc = ata_pci_init_native_host(host);
+	rc = ata_pci_init_sff_host(host);
 	if (rc)
 		return rc;
 
Index: work/drivers/ata/sata_via.c
===================================================================
--- work.orig/drivers/ata/sata_via.c
+++ work/drivers/ata/sata_via.c
@@ -412,7 +412,7 @@ static int vt6420_prepare_host(struct pc
 	struct ata_host *host;
 	int rc;
 
-	rc = ata_pci_prepare_native_host(pdev, ppi, &host);
+	rc = ata_pci_prepare_sff_host(pdev, ppi, &host);
 	if (rc)
 		return rc;
 	*r_host = host;
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -871,11 +871,11 @@ struct pci_bits {
 	unsigned long		val;
 };
 
-extern int ata_pci_init_native_host(struct ata_host *host);
+extern int ata_pci_init_sff_host(struct ata_host *host);
 extern int ata_pci_init_bmdma(struct ata_host *host);
-extern int ata_pci_prepare_native_host(struct pci_dev *pdev,
-				const struct ata_port_info * const * ppi,
-				struct ata_host **r_host);
+extern int ata_pci_prepare_sff_host(struct pci_dev *pdev,
+				    const struct ata_port_info * const * ppi,
+				    struct ata_host **r_host);
 extern int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits);
 extern unsigned long ata_pci_default_filter(struct ata_device *, unsigned long);
 #endif /* CONFIG_PCI */
