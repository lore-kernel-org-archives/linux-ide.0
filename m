From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/17] libata: kill old init helpers
Date: Mon, 7 Aug 2006 12:04:01 +0900
Message-ID: <11549198411039-git-send-email-htejun@gmail.com>
References: <1154919839169-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:54597 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750957AbWHGDEQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Aug 2006 23:04:16 -0400
Received: by py-out-1112.google.com with SMTP id z74so1855412pyg
        for <linux-ide@vger.kernel.org>; Sun, 06 Aug 2006 20:04:13 -0700 (PDT)
In-Reply-To: <1154919839169-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Kill old init helpers ata_pci_init_native_mode() and ata_device_add().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-bmdma.c |   94 ---------------------------------
 drivers/scsi/libata-core.c  |  122 -------------------------------------------
 include/linux/libata.h      |   23 --------
 3 files changed, 0 insertions(+), 239 deletions(-)

3890f4d1ef9e5ed37227f71914c3690f654bfd66
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index d97af71..4cc316d 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -1187,100 +1187,6 @@ void ata_pci_host_set_destroy(struct ata
 	}
 }
 
-static struct ata_probe_ent *
-ata_probe_ent_alloc(struct device *dev, const struct ata_port_info *port)
-{
-	struct ata_probe_ent *probe_ent;
-
-	probe_ent = kzalloc(sizeof(*probe_ent), GFP_KERNEL);
-	if (!probe_ent) {
-		printk(KERN_ERR DRV_NAME "(%s): out of memory\n",
-		       kobject_name(&(dev->kobj)));
-		return NULL;
-	}
-
-	INIT_LIST_HEAD(&probe_ent->node);
-	probe_ent->dev = dev;
-
-	probe_ent->sht = port->sht;
-	probe_ent->host_flags = port->host_flags;
-	probe_ent->pio_mask = port->pio_mask;
-	probe_ent->mwdma_mask = port->mwdma_mask;
-	probe_ent->udma_mask = port->udma_mask;
-	probe_ent->port_ops = port->port_ops;
-
-	return probe_ent;
-}
-
-
-/**
- *	ata_pci_init_native_mode - Initialize native-mode driver
- *	@pdev:  pci device to be initialized
- *	@port:  array[2] of pointers to port info structures.
- *	@ports: bitmap of ports present
- *
- *	Utility function which allocates and initializes an
- *	ata_probe_ent structure for a standard dual-port
- *	PIO-based IDE controller.  The returned ata_probe_ent
- *	structure can be passed to ata_device_add().  The returned
- *	ata_probe_ent structure should then be freed with kfree().
- *
- *	The caller need only pass the address of the primary port, the
- *	secondary will be deduced automatically. If the device has non
- *	standard secondary port mappings this function can be called twice,
- *	once for each interface.
- */
-
-struct ata_probe_ent *
-ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port, int ports)
-{
-	struct ata_probe_ent *probe_ent =
-		ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[0]);
-	int p = 0;
-	unsigned long bmdma;
-
-	if (!probe_ent)
-		return NULL;
-
-	probe_ent->irq = pdev->irq;
-	probe_ent->irq_flags = IRQF_SHARED;
-	probe_ent->private_data = port[0]->private_data;
-
-	if (ports & ATA_PORT_PRIMARY) {
-		probe_ent->port[p].cmd_addr = pci_resource_start(pdev, 0);
-		probe_ent->port[p].altstatus_addr =
-		probe_ent->port[p].ctl_addr =
-			pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
-		bmdma = pci_resource_start(pdev, 4);
-		if (bmdma) {
-			if (inb(bmdma + 2) & 0x80)
-				probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
-			probe_ent->port[p].bmdma_addr = bmdma;
-		}
-		ata_std_ports(&probe_ent->port[p]);
-		p++;
-	}
-
-	if (ports & ATA_PORT_SECONDARY) {
-		probe_ent->port[p].cmd_addr = pci_resource_start(pdev, 2);
-		probe_ent->port[p].altstatus_addr =
-		probe_ent->port[p].ctl_addr =
-			pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS;
-		bmdma = pci_resource_start(pdev, 4);
-		if (bmdma) {
-			bmdma += 8;
-			if(inb(bmdma + 2) & 0x80)
-				probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
-			probe_ent->port[p].bmdma_addr = bmdma;
-		}
-		ata_std_ports(&probe_ent->port[p]);
-		p++;
-	}
-
-	probe_ent->n_ports = p;
-	return probe_ent;
-}
-
 /**
  *	ata_pci_host_set_prepare - prepare PCI ATA device for libata attach
  *	@pdev: target PCI device
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index bc326b8..2350c34 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5733,126 +5733,6 @@ int ata_host_set_attach(struct ata_host_
 }
 
 /**
- *	ata_device_add - Register hardware device with ATA and SCSI layers
- *	@ent: Probe information describing hardware device to be registered
- *
- *	This function processes the information provided in the probe
- *	information struct @ent, allocates the necessary ATA and SCSI
- *	host information structures, initializes them, and registers
- *	everything with requisite kernel subsystems.
- *
- *	This function requests irqs, probes the ATA bus, and probes
- *	the SCSI bus.
- *
- *	LOCKING:
- *	PCI/etc. bus probe sem.
- *
- *	RETURNS:
- *	Number of ports registered.  Zero on error (no ports registered).
- */
-int ata_device_add(const struct ata_probe_ent *ent)
-{
-	unsigned int i;
-	struct device *dev = ent->dev;
-	struct ata_host_set *host_set;
-	int rc;
-
-	DPRINTK("ENTER\n");
-
-	if (!ent->port_ops->error_handler &&
-	    !(ent->host_flags & (ATA_FLAG_SATA_RESET | ATA_FLAG_SRST))) {
-		dev_printk(KERN_ERR, dev, "no reset mechanism available\n");
-		return 0;
-	}
-
-	/* allocate host_set */
-	host_set = ata_host_set_alloc(dev, ent->sht, ent->n_ports);
-	if (!host_set)
-		return 0;
-
-	/* initialize host_set according to @ent */
-	host_set->irq = ent->irq;
-	host_set->irq2 = ent->irq2;
-	host_set->mmio_base = ent->mmio_base;
-	host_set->private_data = ent->private_data;
-	host_set->ops = ent->port_ops;
-	host_set->flags = ent->host_set_flags;
-
-	for (i = 0; i < host_set->n_ports; i++) {
-		struct ata_port *ap = host_set->ports[i];
-
-		/* dummy? */
-		if (ent->dummy_port_mask & (1 << i)) {
-			ap->ops = &ata_dummy_port_ops;
-			continue;
-		}
-
-		ap->pio_mask = ent->pio_mask;
-		ap->mwdma_mask = ent->mwdma_mask;
-		ap->udma_mask = ent->udma_mask;
-		ap->flags |= ent->host_flags;
-		ap->ops = ent->port_ops;
-
-		memcpy(&ap->ioaddr, &ent->port[ap->port_no],
-		       sizeof(struct ata_ioports));
-	}
-
-	/* start ports */
-	rc = ata_host_set_start(host_set);
-	if (rc)
-		goto err_free_host_set;
-
-	/* freeze */
-	for (i = 0; i < host_set->n_ports; i++) {
-		struct ata_port *ap = host_set->ports[i];
-
-		ata_chk_status(ap);
-		host_set->ops->irq_clear(ap);
-		ata_eh_freeze_port(ap);	/* freeze port before requesting IRQ */
-	}
-
-	/* obtain irq, that may be shared between channels */
-	rc = request_irq(ent->irq, ent->port_ops->irq_handler, ent->irq_flags,
-			 DRV_NAME, host_set);
-	if (rc) {
-		dev_printk(KERN_ERR, dev, "irq %lu request failed: %d\n",
-			   ent->irq, rc);
-		goto err_free_host_set;
-	}
-
-	/* do we have a second IRQ for the other channel, eg legacy mode */
-	if (ent->irq2) {
-		/* We will get weird core code crashes later if this is true
-		   so trap it now */
-		BUG_ON(ent->irq == ent->irq2);
-
-		rc = request_irq(ent->irq2, ent->port_ops->irq_handler, ent->irq_flags,
-			 DRV_NAME, host_set);
-		if (rc) {
-			dev_printk(KERN_ERR, dev, "irq %lu request failed: %d\n",
-				   ent->irq2, rc);
-			goto err_free_irq;
-		}
-	}
-
-	rc = ata_host_set_attach(host_set);
-	if (rc)
-		goto err_free_irq2;
-
-	return host_set->n_ports; /* success */
-
- err_free_irq2:
-	if (ent->irq2)
-		free_irq(ent->irq2, host_set);
- err_free_irq:
-	free_irq(ent->irq, host_set);
- err_free_host_set:
-	ata_host_set_free(host_set);
-	VPRINTK("EXIT, returning 0\n");
-	return 0;
-}
-
-/**
  *	ata_port_detach - Detach ATA port in prepration of device removal
  *	@ap: ATA port to be detached
  *
@@ -6283,7 +6163,6 @@ EXPORT_SYMBOL_GPL(ata_host_set_add_ports
 EXPORT_SYMBOL_GPL(ata_host_set_start);
 EXPORT_SYMBOL_GPL(ata_host_set_request_irq);
 EXPORT_SYMBOL_GPL(ata_host_set_attach);
-EXPORT_SYMBOL_GPL(ata_device_add);
 EXPORT_SYMBOL_GPL(ata_host_set_detach);
 EXPORT_SYMBOL_GPL(ata_host_set_stop);
 EXPORT_SYMBOL_GPL(ata_host_set_free);
@@ -6372,7 +6251,6 @@ EXPORT_SYMBOL_GPL(ata_pci_acquire_resour
 EXPORT_SYMBOL_GPL(ata_pci_request_irq);
 EXPORT_SYMBOL_GPL(ata_pci_release_resources);
 EXPORT_SYMBOL_GPL(ata_pci_host_set_destroy);
-EXPORT_SYMBOL_GPL(ata_pci_init_native_mode);
 EXPORT_SYMBOL_GPL(ata_pci_host_set_prepare);
 EXPORT_SYMBOL_GPL(ata_pci_init_one);
 EXPORT_SYMBOL_GPL(ata_pci_remove_one);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 1fe1b96..523a5e2 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -367,26 +367,6 @@ struct ata_ioports {
 	unsigned long		scr_addr;
 };
 
-struct ata_probe_ent {
-	struct list_head	node;
-	struct device 		*dev;
-	const struct ata_port_operations *port_ops;
-	struct scsi_host_template *sht;
-	struct ata_ioports	port[ATA_MAX_PORTS];
-	unsigned int		n_ports;
-	unsigned int		dummy_port_mask;
-	unsigned int		pio_mask;
-	unsigned int		mwdma_mask;
-	unsigned int		udma_mask;
-	unsigned long		irq;
-	unsigned long		irq2;
-	unsigned int		irq_flags;
-	unsigned long		host_flags;
-	unsigned long		host_set_flags;
-	void __iomem		*mmio_base;
-	void			*private_data;
-};
-
 struct ata_host_set {
 	spinlock_t		lock;
 	struct device 		*dev;
@@ -730,7 +710,6 @@ extern int ata_host_set_request_irq(stru
 			unsigned long irq_flags, const char **reason);
 extern int ata_host_set_start(struct ata_host_set *host_set);
 extern int ata_host_set_attach(struct ata_host_set *host_set);
-extern int ata_device_add(const struct ata_probe_ent *ent);
 extern void ata_host_set_detach(struct ata_host_set *host_set);
 extern void ata_host_set_stop(struct ata_host_set *host_set);
 extern void ata_host_set_free(struct ata_host_set *host_set);
@@ -871,8 +850,6 @@ extern int ata_pci_request_irq(struct at
 		unsigned int flags, const char **reason);
 extern void ata_pci_release_resources(struct ata_host_set *host_set);
 extern void ata_pci_host_set_destroy(struct ata_host_set *host_set);
-extern struct ata_probe_ent *
-ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port, int portmask);
 extern int ata_pci_host_set_prepare(struct pci_dev *pdev,
 				    struct ata_port_info **pinfo_ar,
 				    unsigned int mask, unsigned int legacy_mask,
-- 
1.3.2


