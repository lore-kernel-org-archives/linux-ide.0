From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/17] libata: reimplement ata_pci_init_one() using new init helpers
Date: Mon, 7 Aug 2006 12:04:00 +0900
Message-ID: <11549198401907-git-send-email-htejun@gmail.com>
References: <1154919839169-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:61252 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750952AbWHGDEQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Aug 2006 23:04:16 -0400
Received: by py-out-1112.google.com with SMTP id z74so1855411pyg
        for <linux-ide@vger.kernel.org>; Sun, 06 Aug 2006 20:04:13 -0700 (PDT)
In-Reply-To: <1154919839169-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Reimplement ata_pci_init_one() using new init helpers.  New
implementation is split into to functions - ata_pci_host_set_prepare()
and ata_pci_init_one().  ata_pci_host_set_prepare() prepares host_set
for the specified pdev.  The split is to give LLDs more flexibility.

ata_pci_host_set_prepare() can handle all combinations of native and
legacy ports, but ata_pci_init_one() still applies the same
restriction as before for compatibility.

New implementation properly releases legacy resources on remove.
Other than that there is no behavior changes.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-bmdma.c |  317 +++++++++++++++++++++----------------------
 drivers/scsi/libata-core.c  |    1 
 include/linux/libata.h      |    4 +
 3 files changed, 163 insertions(+), 159 deletions(-)

455f87635e37afc13700ebab64128a02e51f2a49
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index 341d9b5..d97af71 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -1281,69 +1281,159 @@ ata_pci_init_native_mode(struct pci_dev 
 	return probe_ent;
 }
 
-
-static struct ata_probe_ent *ata_pci_init_legacy_port(struct pci_dev *pdev,
-				struct ata_port_info **port, int port_mask)
+/**
+ *	ata_pci_host_set_prepare - prepare PCI ATA device for libata attach
+ *	@pdev: target PCI device
+ *	@pinfo_ar: array of pointers to ATA port_info
+ *	@mask: available port mask
+ *	@legacy_mask: legacy port mask
+ *	@r_host_set: out arg for prepared ATA host_set
+ *
+ *	Allocate and initialize ATA host_set for PCI ATA device @pdev.
+ *	Ports of @pdev can be in either native or legacy mode.  All
+ *	related PCI resources including IRQs are acquired by this
+ *	function.  Returned ATA host_set is ready to be attached using
+ *	ata_host_set_attach().
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_pci_host_set_prepare(struct pci_dev *pdev,
+			     struct ata_port_info **pinfo_ar,
+			     unsigned int mask, unsigned int legacy_mask,
+			     struct ata_host_set **r_host_set)
 {
-	struct ata_probe_ent *probe_ent;
-	unsigned long bmdma = pci_resource_start(pdev, 4);
+	static const unsigned long irq_flags[3] = { 0, 0, IRQF_SHARED };
+	static const unsigned long irq_res_mask[3] = { ATA_HOST_PCI_RES_IRQ14,
+						       ATA_HOST_PCI_RES_IRQ15,
+						       ATA_HOST_PCI_RES_IRQ };
+	const int irq[3] = { 14, 15, pdev->irq };
+	irqreturn_t (*irq_handler[3])(int, void *,
+				      struct pt_regs *) = { NULL, NULL, NULL };
+	struct ata_host_set *host_set = NULL;
+	struct ata_port_info dummy_pinfo;
+	const struct ata_port_info *pi[2];
+	int n_ports, i, rc;
+	const char *reason;
 
-	probe_ent = ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[0]);
-	if (!probe_ent)
-		return NULL;
+	/* prep pi[] and count n_ports */
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
 
-	probe_ent->n_ports = 2;
-	probe_ent->private_data = port[0]->private_data;
+	/* allocate host_set */
+	host_set = ata_host_set_alloc_pinfo_ar(&pdev->dev, pi, n_ports);
+	if (!host_set) {
+		reason = "failed to allocate host_set";
+		rc = -ENOMEM;
+		goto err;
+	}
 
-	if (port_mask & ATA_PORT_PRIMARY) {
-		probe_ent->irq = 14;
-		probe_ent->port[0].cmd_addr = ATA_PRIMARY_CMD;
-		probe_ent->port[0].altstatus_addr =
-		probe_ent->port[0].ctl_addr = ATA_PRIMARY_CTL;
-		if (bmdma) {
-			probe_ent->port[0].bmdma_addr = bmdma;
-			if (inb(bmdma + 2) & 0x80)
-				probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
+	host_set->flags |= legacy_mask & ATA_HOST_LEGACY_MASK;
+
+	/* acquire ATA PCI resources */
+	rc = ata_pci_acquire_resources(host_set, ATA_DMA_MASK, &reason);
+	if (rc)
+		goto err;
+
+	/* initialize & start ports */
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap = host_set->ports[i];
+
+		if (ata_port_is_dummy(ap))
+			continue;
+
+		if (host_set->flags & (ATA_HOST_LEGACY_PRI << i)) {
+			ata_pci_port_init_legacy(ap, i);
+			irq_handler[i] = ap->ops->irq_handler;
+		} else {
+			ata_pci_port_init_native(ap, i);
+			irq_handler[2] = ap->ops->irq_handler;
 		}
-		ata_std_ports(&probe_ent->port[0]);
-	} else
-		probe_ent->dummy_port_mask |= ATA_PORT_PRIMARY;
+	}
 
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
-				probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
+	rc = ata_host_set_start(host_set);
+	if (rc) {
+		reason = "failed to start host_set";
+		goto err;
+	}
+
+	/* freeze & request IRQs */
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap = host_set->ports[i];
+
+		ata_chk_status(ap);
+		host_set->ops->irq_clear(ap);
+		ata_eh_freeze_port(ap);	/* freeze port before requesting IRQ */
+	}
+
+	for (i = 0; i < 3; i++) {
+		if (!irq_handler[i])
+			continue;
+
+		switch (i) {
+		case 0:
+			host_set->irq = irq[i];
+			break;
+		case 1:
+			host_set->irq2 = irq[i];
+			break;
+		case 2:
+			if (host_set->irq == 0)
+				host_set->irq = irq[i];
+			else
+				host_set->irq2 = irq[i];
+			break;
 		}
-		ata_std_ports(&probe_ent->port[1]);
-	} else
-		probe_ent->dummy_port_mask |= ATA_PORT_SECONDARY;
 
-	return probe_ent;
-}
+		rc = request_irq(irq[i], irq_handler[i], irq_flags[i],
+				 DRV_NAME, host_set);
+		if (rc) {
+			reason = "failed to request IRQ";
+			goto err;
+		}
 
+		host_set->flags |= irq_res_mask[i];
+	}
+
+	pci_set_master(pdev);
+
+	*r_host_set = host_set;
+	return 0;
+
+ err:
+	ata_pci_host_set_destroy(host_set);
+	dev_printk(KERN_ERR, &pdev->dev, "%s (error=%d)\n", reason, rc);
+	return rc;
+}
 
 /**
  *	ata_pci_init_one - Initialize/register PCI IDE host controller
  *	@pdev: Controller to be initialized
- *	@port_info: Information from low-level host driver
+ *	@pinfo_ar: Information from low-level host driver
  *	@n_ports: Number of ports attached to host controller
  *
  *	This is a helper function which can be called from a driver's
  *	xxx_init_one() probe function if the hardware uses traditional
  *	IDE taskfile registers.
  *
- *	This function calls pci_enable_device(), reserves its register
- *	regions, sets the dma mask, enables bus master mode, and calls
- *	ata_device_add()
- *
  *	ASSUMPTION:
  *	Nobody makes a single channel controller that appears solely as
  *	the secondary legacy port on PCI.
@@ -1354,134 +1444,43 @@ static struct ata_probe_ent *ata_pci_ini
  *	RETURNS:
  *	Zero on success, negative on errno-based value on error.
  */
-
-int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
-		      unsigned int n_ports)
+int ata_pci_init_one(struct pci_dev *pdev, struct ata_port_info **pinfo_ar,
+		     unsigned int n_ports)
 {
-	struct ata_probe_ent *probe_ent = NULL;
-	struct ata_port_info *port[2];
-	u8 tmp8, mask;
-	unsigned int legacy_mode = 0;
-	int disable_dev_on_err = 1;
+	unsigned int mask = ATA_PORT_PRIMARY | ATA_PORT_SECONDARY;
+	unsigned int legacy_mask = 0;
+	struct ata_host_set *host_set;
 	int rc;
 
 	DPRINTK("ENTER\n");
 
-	port[0] = port_info[0];
-	if (n_ports > 1)
-		port[1] = port_info[1];
-	else
-		port[1] = port[0];
-
-	if ((port[0]->host_flags & ATA_FLAG_NO_LEGACY) == 0
-	    && (pdev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
-		/* TODO: What if one channel is in native mode ... */
-		pci_read_config_byte(pdev, PCI_CLASS_PROG, &tmp8);
-		mask = (1 << 2) | (1 << 0);
-		if ((tmp8 & mask) != mask)
-			legacy_mode = (1 << 3);
-	}
+	/* legacy mode? */
+	if (!(pinfo_ar[0]->host_flags & ATA_FLAG_NO_LEGACY))
+		legacy_mask = ata_pci_legacy_mask(pdev);
 
-	/* FIXME... */
-	if ((!legacy_mode) && (n_ports > 2)) {
-		printk(KERN_ERR "ata: BUG: native mode, n_ports > 2\n");
-		n_ports = 2;
-		/* For now */
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
 	}
 
-	/* FIXME: Really for ATA it isn't safe because the device may be
-	   multi-purpose and we want to leave it alone if it was already
-	   enabled. Secondly for shared use as Arjan says we want refcounting
-
-	   Checking dev->is_enabled is insufficient as this is not set at
-	   boot for the primary video which is BIOS enabled
-         */
-
-	rc = pci_enable_device(pdev);
+	/* prep */
+	rc = ata_pci_host_set_prepare(pdev, pinfo_ar, mask, legacy_mask,
+				      &host_set);
 	if (rc)
 		return rc;
 
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
+	/* attach */
+	rc = ata_host_set_attach(host_set);
 	if (rc)
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
+		ata_pci_host_set_destroy(host_set);
 
-err_out_regions:
-	if (legacy_mode & ATA_PORT_PRIMARY)
-		release_region(ATA_PRIMARY_CMD, 8);
-	if (legacy_mode & ATA_PORT_SECONDARY)
-		release_region(ATA_SECONDARY_CMD, 8);
-	pci_release_regions(pdev);
-err_out:
-	if (disable_dev_on_err)
-		pci_disable_device(pdev);
 	return rc;
 }
 
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index d44c1df..cb22c04 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -6411,6 +6411,7 @@ EXPORT_SYMBOL_GPL(ata_pci_request_irq);
 EXPORT_SYMBOL_GPL(ata_pci_release_resources);
 EXPORT_SYMBOL_GPL(ata_pci_host_set_destroy);
 EXPORT_SYMBOL_GPL(ata_pci_init_native_mode);
+EXPORT_SYMBOL_GPL(ata_pci_host_set_prepare);
 EXPORT_SYMBOL_GPL(ata_pci_init_one);
 EXPORT_SYMBOL_GPL(ata_pci_remove_one);
 EXPORT_SYMBOL_GPL(ata_pci_device_do_suspend);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0ae0fbb..ed89959 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -874,6 +874,10 @@ extern void ata_pci_release_resources(st
 extern void ata_pci_host_set_destroy(struct ata_host_set *host_set);
 extern struct ata_probe_ent *
 ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port, int portmask);
+extern int ata_pci_host_set_prepare(struct pci_dev *pdev,
+				    struct ata_port_info **pinfo_ar,
+				    unsigned int mask, unsigned int legacy_mask,
+				    struct ata_host_set **r_host_set);
 extern int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits);
 extern unsigned long ata_pci_default_filter(const struct ata_port *, struct ata_device *, unsigned long);
 #endif /* CONFIG_PCI */
-- 
1.3.2


