From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 8/20] libata: reimplement ata_pci_init_one() using new init helpers
Date: Sat, 19 Aug 2006 17:59:32 +0900
Message-ID: <11559779723326-git-send-email-htejun@gmail.com>
References: <11559778241753-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:35163 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751682AbWHSJ1m (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Aug 2006 05:27:42 -0400
Received: by py-out-1112.google.com with SMTP id n25so1477492pyg
        for <linux-ide@vger.kernel.org>; Sat, 19 Aug 2006 02:27:41 -0700 (PDT)
In-Reply-To: <11559778241753-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Reimplement ata_pci_init_one() using new init helpers.  New
implementation is split into to functions - ata_pci_host_prepare() and
ata_pci_init_one().  ata_pci_host_prepare() prepares host for the
specified pdev.  The split is to give LLDs more flexibility.

ata_pci_host_prepare() can handle all combinations of native and
legacy ports, but ata_pci_init_one() still applies the same
restriction as before for compatibility.

New implementation properly releases legacy resources on remove.
Other than that, there's no behavior change.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-bmdma.c |  204 --------------------------------------------
 drivers/ata/libata-core.c  |    1 
 drivers/ata/libata-pci.c   |  191 +++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h     |    4 +
 4 files changed, 195 insertions(+), 205 deletions(-)

diff --git a/drivers/ata/libata-bmdma.c b/drivers/ata/libata-bmdma.c
index 7605028..672df5a 100644
--- a/drivers/ata/libata-bmdma.c
+++ b/drivers/ata/libata-bmdma.c
@@ -865,210 +865,6 @@ ata_pci_init_native_mode(struct pci_dev 
 	return probe_ent;
 }
 
-
-static struct ata_probe_ent *ata_pci_init_legacy_port(struct pci_dev *pdev,
-				struct ata_port_info **port, int port_mask)
-{
-	struct ata_probe_ent *probe_ent;
-	unsigned long bmdma = pci_resource_start(pdev, 4);
-
-	probe_ent = ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[0]);
-	if (!probe_ent)
-		return NULL;
-
-	probe_ent->n_ports = 2;
-	probe_ent->private_data = port[0]->private_data;
-
-	if (port_mask & ATA_PORT_PRIMARY) {
-		probe_ent->irq = 14;
-		probe_ent->port[0].cmd_addr = ATA_PRIMARY_CMD;
-		probe_ent->port[0].altstatus_addr =
-		probe_ent->port[0].ctl_addr = ATA_PRIMARY_CTL;
-		if (bmdma) {
-			probe_ent->port[0].bmdma_addr = bmdma;
-			if (inb(bmdma + 2) & 0x80)
-				probe_ent->_host_flags |= ATA_HOST_SIMPLEX;
-		}
-		ata_std_ports(&probe_ent->port[0]);
-	} else
-		probe_ent->dummy_port_mask |= ATA_PORT_PRIMARY;
-
-	if (port_mask & ATA_PORT_SECONDARY) {
-		if (probe_ent->irq)
-			probe_ent->irq2 = 15;
-		else
-			probe_ent->irq = 15;
-		probe_ent->port[1].cmd_addr = ATA_SECONDARY_CMD;
-		probe_ent->port[1].altstatus_addr =
-		probe_ent->port[1].ctl_addr = ATA_SECONDARY_CTL;
-		if (bmdma) {
-			probe_ent->port[1].bmdma_addr = bmdma + 8;
-			if (inb(bmdma + 10) & 0x80)
-				probe_ent->_host_flags |= ATA_HOST_SIMPLEX;
-		}
-		ata_std_ports(&probe_ent->port[1]);
-	} else
-		probe_ent->dummy_port_mask |= ATA_PORT_SECONDARY;
-
-	return probe_ent;
-}
-
-
-/**
- *	ata_pci_init_one - Initialize/register PCI IDE host controller
- *	@pdev: Controller to be initialized
- *	@port_info: Information from low-level host driver
- *	@n_ports: Number of ports attached to host controller
- *
- *	This is a helper function which can be called from a driver's
- *	xxx_init_one() probe function if the hardware uses traditional
- *	IDE taskfile registers.
- *
- *	This function calls pci_enable_device(), reserves its register
- *	regions, sets the dma mask, enables bus master mode, and calls
- *	ata_device_add()
- *
- *	ASSUMPTION:
- *	Nobody makes a single channel controller that appears solely as
- *	the secondary legacy port on PCI.
- *
- *	LOCKING:
- *	Inherited from PCI layer (may sleep).
- *
- *	RETURNS:
- *	Zero on success, negative on errno-based value on error.
- */
-
-int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
-		      unsigned int n_ports)
-{
-	struct ata_probe_ent *probe_ent = NULL;
-	struct ata_port_info *port[2];
-	u8 tmp8, mask;
-	unsigned int legacy_mode = 0;
-	int disable_dev_on_err = 1;
-	int rc;
-
-	DPRINTK("ENTER\n");
-
-	port[0] = port_info[0];
-	if (n_ports > 1)
-		port[1] = port_info[1];
-	else
-		port[1] = port[0];
-
-	if ((port[0]->flags & ATA_FLAG_NO_LEGACY) == 0
-	    && (pdev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
-		/* TODO: What if one channel is in native mode ... */
-		pci_read_config_byte(pdev, PCI_CLASS_PROG, &tmp8);
-		mask = (1 << 2) | (1 << 0);
-		if ((tmp8 & mask) != mask)
-			legacy_mode = (1 << 3);
-	}
-
-	/* FIXME... */
-	if ((!legacy_mode) && (n_ports > 2)) {
-		printk(KERN_ERR "ata: BUG: native mode, n_ports > 2\n");
-		n_ports = 2;
-		/* For now */
-	}
-
-	/* FIXME: Really for ATA it isn't safe because the device may be
-	   multi-purpose and we want to leave it alone if it was already
-	   enabled. Secondly for shared use as Arjan says we want refcounting
-
-	   Checking dev->is_enabled is insufficient as this is not set at
-	   boot for the primary video which is BIOS enabled
-         */
-
-	rc = pci_enable_device(pdev);
-	if (rc)
-		return rc;
-
-	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc) {
-		disable_dev_on_err = 0;
-		goto err_out;
-	}
-
-	if (legacy_mode) {
-		if (!request_region(ATA_PRIMARY_CMD, 8, "libata")) {
-			struct resource *conflict, res;
-			res.start = ATA_PRIMARY_CMD;
-			res.end = ATA_PRIMARY_CMD + 8 - 1;
-			conflict = ____request_resource(&ioport_resource, &res);
-			if (!strcmp(conflict->name, "libata"))
-				legacy_mode |= ATA_PORT_PRIMARY;
-			else {
-				disable_dev_on_err = 0;
-				printk(KERN_WARNING "ata: 0x%0X IDE port busy\n", ATA_PRIMARY_CMD);
-			}
-		} else
-			legacy_mode |= ATA_PORT_PRIMARY;
-
-		if (!request_region(ATA_SECONDARY_CMD, 8, "libata")) {
-			struct resource *conflict, res;
-			res.start = ATA_SECONDARY_CMD;
-			res.end = ATA_SECONDARY_CMD + 8 - 1;
-			conflict = ____request_resource(&ioport_resource, &res);
-			if (!strcmp(conflict->name, "libata"))
-				legacy_mode |= ATA_PORT_SECONDARY;
-			else {
-				disable_dev_on_err = 0;
-				printk(KERN_WARNING "ata: 0x%X IDE port busy\n", ATA_SECONDARY_CMD);
-			}
-		} else
-			legacy_mode |= ATA_PORT_SECONDARY;
-	}
-
-	/* we have legacy mode, but all ports are unavailable */
-	if (legacy_mode == (1 << 3)) {
-		rc = -EBUSY;
-		goto err_out_regions;
-	}
-
-	/* FIXME: If we get no DMA mask we should fall back to PIO */
-	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
-	if (rc)
-		goto err_out_regions;
-	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
-	if (rc)
-		goto err_out_regions;
-
-	if (legacy_mode) {
-		probe_ent = ata_pci_init_legacy_port(pdev, port, legacy_mode);
-	} else {
-		if (n_ports == 2)
-			probe_ent = ata_pci_init_native_mode(pdev, port, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
-		else
-			probe_ent = ata_pci_init_native_mode(pdev, port, ATA_PORT_PRIMARY);
-	}
-	if (!probe_ent) {
-		rc = -ENOMEM;
-		goto err_out_regions;
-	}
-
-	pci_set_master(pdev);
-
-	/* FIXME: check ata_device_add return */
-	ata_device_add(probe_ent);
-
-	kfree(probe_ent);
-
-	return 0;
-
-err_out_regions:
-	if (legacy_mode & ATA_PORT_PRIMARY)
-		release_region(ATA_PRIMARY_CMD, 8);
-	if (legacy_mode & ATA_PORT_SECONDARY)
-		release_region(ATA_SECONDARY_CMD, 8);
-	pci_release_regions(pdev);
-err_out:
-	if (disable_dev_on_err)
-		pci_disable_device(pdev);
-	return rc;
-}
-
 /**
  *	ata_pci_clear_simplex	-	attempt to kick device out of simplex
  *	@pdev: PCI device
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b293d47..0509935 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6651,7 +6651,6 @@ #ifdef CONFIG_PCI
 EXPORT_SYMBOL_GPL(pci_test_config_bits);
 EXPORT_SYMBOL_GPL(ata_pci_host_stop);
 EXPORT_SYMBOL_GPL(ata_pci_init_native_mode);
-EXPORT_SYMBOL_GPL(ata_pci_init_one);
 EXPORT_SYMBOL_GPL(ata_pci_remove_one);
 EXPORT_SYMBOL_GPL(ata_pci_device_do_suspend);
 EXPORT_SYMBOL_GPL(ata_pci_device_do_resume);
diff --git a/drivers/ata/libata-pci.c b/drivers/ata/libata-pci.c
index d1e4194..9649a8c 100644
--- a/drivers/ata/libata-pci.c
+++ b/drivers/ata/libata-pci.c
@@ -407,6 +407,133 @@ void ata_pci_free_msix_irqs(struct ata_h
 }
 
 /**
+ *	ata_pci_host_prepare - prepare PCI native/legacy ATA device for attach
+ *	@pdev: target PCI device
+ *	@pinfo_ar: array of pointers to ATA port_info
+ *	@mask: available port mask
+ *	@legacy_mask: legacy port mask
+ *	@r_host: out arg for prepared ATA host
+ *
+ *	Allocate and initialize ATA host for PCI ATA device @pdev.
+ *	Ports of @pdev can be in either native or legacy mode.  All
+ *	related PCI resources including IRQs are acquired by this
+ *	function.  Returned ATA host is ready to be attached using
+ *	ata_host_attach().
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_pci_host_prepare(struct pci_dev *pdev, struct ata_port_info **pinfo_ar,
+			 unsigned int mask, unsigned int legacy_mask,
+			 struct ata_host **r_host)
+{
+	struct ata_host *host = NULL;
+	struct ata_port_info dummy_pinfo;
+	const struct ata_port_info *pi[2];
+	irqreturn_t (*handler[2])(int, void *, struct pt_regs *);
+	void *dev_id[2];
+	unsigned int legacy_irq_flags[2];
+	int n_ports, i, rc;
+	const char *reason;
+
+	/* prep and count n_ports */
+	if (pinfo_ar[0])
+		dummy_pinfo = *pinfo_ar[0];
+	else
+		dummy_pinfo = *pinfo_ar[1];
+	dummy_pinfo.port_ops = &ata_dummy_port_ops;
+	pi[0] = &dummy_pinfo;
+	pi[1] = &dummy_pinfo;
+
+	n_ports = 0;
+	if (mask & ATA_PORT_PRIMARY) {
+		pi[0] = pinfo_ar[0];
+		n_ports = 1;
+	}
+	if (mask & ATA_PORT_SECONDARY) {
+		pi[1] = pinfo_ar[1];
+		n_ports = 2;
+	}
+
+	/* allocate host */
+	host = ata_host_alloc_pinfo_ar(&pdev->dev, pi, n_ports);
+	if (!host) {
+		reason = "failed to allocate host";
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	/* acquire PCI and legacy resources and init host accordingly */
+	host->legacy_flags |= legacy_mask & ATA_LEGACY_MASK;
+
+	rc = ata_pci_acquire_resources(host, ATA_DMA_MASK, &reason);
+	if (rc)
+		goto err;
+
+	ata_pci_init_ports(host);
+
+	rc = ata_legacy_acquire_resources(host, &reason);
+	if (rc)
+		goto err;
+
+	ata_legacy_init_ports(host);
+
+	/* do we have any port? */
+	for (i = 0; i < host->n_ports; i++)
+		if (!ata_port_is_dummy(host->ports[i]))
+			break;
+
+	if (i == host->n_ports) {
+		reason = "no available port";
+		rc = -ENODEV;
+		goto err;
+	}
+
+	/* request legacy IRQs */
+	for (i = 0; i < 2; i++) {
+		handler[i] = pi[i]->port_ops->irq_handler;
+		dev_id[i] = host;
+		legacy_irq_flags[i] = 0;
+	}
+
+	rc = ata_legacy_request_irqs(host, handler, legacy_irq_flags, dev_id,
+				     &reason);
+	if (rc)
+		goto err;
+
+	/* request native IRQ if there is any native port */
+	for (i = 0; i < host->n_ports; i++)
+		if (!(host->legacy_flags & (1 << i)))
+			break;
+
+	if (i < host->n_ports) {
+		rc = ata_pci_request_irq(host, handler[i], IRQF_SHARED,
+					 dev_id[i], &reason);
+		if (rc)
+			goto err;
+
+		/* only for info printing */
+		if (!host->irq)
+			host->irq = pdev->irq;
+		else
+			host->irq2 = pdev->irq;
+	}
+
+	pci_set_master(pdev);
+
+	*r_host = host;
+	return 0;
+
+ err:
+	ata_pci_host_destroy(host);
+	dev_printk(KERN_ERR, &pdev->dev, "%s (error=%d)\n", reason, rc);
+	return rc;
+}
+
+/**
  *	ata_pci_host_destroy - destroy PCI ATA host
  *	@host: target ATA host
  *
@@ -419,6 +546,7 @@ void ata_pci_free_msix_irqs(struct ata_h
 void ata_pci_host_destroy(struct ata_host *host)
 {
 	/* free IRQs */
+	ata_legacy_free_irqs(host);
 	ata_pci_free_msix_irqs(host);
 	ata_pci_free_irq(host);
 
@@ -426,10 +554,71 @@ void ata_pci_host_destroy(struct ata_hos
 	ata_host_stop(host);
 
 	/* release resources */
+	ata_legacy_release_resources(host);
 	ata_pci_release_resources(host);
 	ata_host_free(host);
 }
 
+/**
+ *	ata_pci_init_one - Initialize/register PCI IDE host controller
+ *	@pdev: Controller to be initialized
+ *	@pinfo_ar: Information from low-level host driver
+ *	@n_ports: Number of ports attached to host controller
+ *
+ *	This is a helper function which can be called from a driver's
+ *	xxx_init_one() probe function if the hardware uses traditional
+ *	IDE taskfile registers.
+ *
+ *	ASSUMPTION:
+ *	Nobody makes a single channel controller that appears solely as
+ *	the secondary legacy port on PCI.
+ *
+ *	LOCKING:
+ *	Inherited from PCI layer (may sleep).
+ *
+ *	RETURNS:
+ *	Zero on success, negative on errno-based value on error.
+ */
+int ata_pci_init_one(struct pci_dev *pdev, struct ata_port_info **pinfo_ar,
+		     unsigned int n_ports)
+
+{
+	unsigned int mask = ATA_PORT_PRIMARY | ATA_PORT_SECONDARY;
+	unsigned int legacy_mask = 0;
+	struct ata_host *host;
+	int rc;
+
+	DPRINTK("ENTER\n");
+
+	/* legacy mode? */
+	if (!(pinfo_ar[0]->flags & ATA_FLAG_NO_LEGACY))
+		legacy_mask = ata_pci_legacy_mask(pdev);
+
+	if (legacy_mask) {
+		/* XXX: all legacy or all native for the time being */
+		BUG_ON(n_ports < 2);
+		legacy_mask |= ATA_PORT_PRIMARY | ATA_PORT_SECONDARY;
+	} else {
+		/* FIXME... */
+		if (n_ports > 2)
+			printk(KERN_ERR "ata: BUG: native mode, n_ports > 2\n");
+		if (n_ports < 2)
+			mask &= ~ATA_PORT_SECONDARY;
+	}
+
+	/* prep */
+	rc = ata_pci_host_prepare(pdev, pinfo_ar, mask, legacy_mask, &host);
+	if (rc)
+		return rc;
+
+	/* attach */
+	rc = ata_host_attach(host);
+	if (rc)
+		ata_pci_host_destroy(host);
+
+	return rc;
+}
+
 EXPORT_SYMBOL_GPL(ata_pci_legacy_mask);
 EXPORT_SYMBOL_GPL(ata_pci_set_dma_mask);
 EXPORT_SYMBOL_GPL(ata_pci_acquire_resources);
@@ -439,4 +628,6 @@ EXPORT_SYMBOL_GPL(ata_pci_request_irq);
 EXPORT_SYMBOL_GPL(ata_pci_free_irq);
 EXPORT_SYMBOL_GPL(ata_pci_request_msix_irqs);
 EXPORT_SYMBOL_GPL(ata_pci_free_msix_irqs);
+EXPORT_SYMBOL_GPL(ata_pci_host_prepare);
 EXPORT_SYMBOL_GPL(ata_pci_host_destroy);
+EXPORT_SYMBOL_GPL(ata_pci_init_one);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index f25fc53..3705d09 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -728,6 +728,10 @@ extern int ata_pci_request_msix_irqs(str
 			      struct ata_msix_entry *ata_msix_tbl, int nr_irqs,
 			      const char **p_reason);
 extern void ata_pci_free_msix_irqs(struct ata_host *host);
+extern int ata_pci_host_prepare(struct pci_dev *pdev,
+				struct ata_port_info **pinfo_ar,
+				unsigned int mask, unsigned int legacy_mask,
+				struct ata_host **r_host);
 extern void ata_pci_host_destroy(struct ata_host *host);
 extern int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 			     unsigned int n_ports);
-- 
1.4.1.1


