From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/12] libata: kill probe_ent and related helpers
Date: Fri, 9 Mar 2007 20:15:36 +0900
Message-ID: <1173438936270-git-send-email-htejun@gmail.com>
References: <1173438935540-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.228]:50781 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767190AbXCILPr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 06:15:47 -0500
Received: by nz-out-0506.google.com with SMTP id s1so740598nze
        for <linux-ide@vger.kernel.org>; Fri, 09 Mar 2007 03:15:47 -0800 (PST)
In-Reply-To: <1173438935540-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

All drivers are converted to new init model.  Kill probe_ent,
ata_device_add() and ata_pci_init_native_mode().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |  153 ---------------------------------------------
 drivers/ata/libata-sff.c  |   95 ----------------------------
 drivers/ata/libata.h      |    2 -
 include/linux/libata.h    |   31 ---------
 4 files changed, 0 insertions(+), 281 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4d371fb..5722026 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5987,131 +5987,6 @@ int ata_host_activate(struct ata_host *host, int irq,
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
-	struct ata_host *host;
-	int rc;
-
-	DPRINTK("ENTER\n");
-
-	if (ent->irq == 0) {
-		dev_printk(KERN_ERR, dev, "is not available: No interrupt assigned.\n");
-		return 0;
-	}
-
-	if (!ent->port_ops->error_handler &&
-	    !(ent->port_flags & (ATA_FLAG_SATA_RESET | ATA_FLAG_SRST))) {
-		dev_printk(KERN_ERR, dev, "no reset mechanism available\n");
-		return 0;
-	}
-
-	if (!devres_open_group(dev, ata_device_add, GFP_KERNEL))
-		return 0;
-
-	/* allocate host */
-	host = ata_host_alloc(dev, ent->n_ports);
-
-	host->irq = ent->irq;
-	host->irq2 = ent->irq2;
-	host->iomap = ent->iomap;
-	host->private_data = ent->private_data;
-	host->ops = ent->port_ops;
-	host->flags = ent->_host_flags;
-
-	for (i = 0; i < host->n_ports; i++) {
-		struct ata_port *ap = host->ports[i];
-
-		/* dummy? */
-		if (ent->dummy_port_mask & (1 << i)) {
-			ap->ops = &ata_dummy_port_ops;
-			continue;
-		}
-
-		if (ap->port_no == 1 && ent->pinfo2) {
-			ap->pio_mask = ent->pinfo2->pio_mask;
-			ap->mwdma_mask = ent->pinfo2->mwdma_mask;
-			ap->udma_mask = ent->pinfo2->udma_mask;
-			ap->flags |= ent->pinfo2->flags;
-			ap->ops = ent->pinfo2->port_ops;
-		} else {
-			ap->pio_mask = ent->pio_mask;
-			ap->mwdma_mask = ent->mwdma_mask;
-			ap->udma_mask = ent->udma_mask;
-			ap->flags |= ent->port_flags;
-			ap->ops = ent->port_ops;
-		}
-
-		memcpy(&ap->ioaddr, &ent->port[ap->port_no],
-		       sizeof(struct ata_ioports));
-	}
-
-	/* start and freeze ports before requesting IRQ */
-	rc = ata_host_start(host);
-	if (rc)
-		goto err_out;
-
-	/* obtain irq, that may be shared between channels */
-	rc = devm_request_irq(dev, ent->irq, ent->port_ops->irq_handler,
-			      ent->irq_flags, DRV_NAME, host);
-	if (rc) {
-		dev_printk(KERN_ERR, dev, "irq %lu request failed: %d\n",
-			   ent->irq, rc);
-		goto err_out;
-	}
-
-	/* do we have a second IRQ for the other channel, eg legacy mode */
-	if (ent->irq2) {
-		/* We will get weird core code crashes later if this is true
-		   so trap it now */
-		BUG_ON(ent->irq == ent->irq2);
-
-		rc = devm_request_irq(dev, ent->irq2,
-				ent->port_ops->irq_handler, ent->irq_flags,
-				DRV_NAME, host);
-		if (rc) {
-			dev_printk(KERN_ERR, dev, "irq %lu request failed: %d\n",
-				   ent->irq2, rc);
-			goto err_out;
-		}
-	}
-
-	/* resource acquisition complete */
-	devres_remove_group(dev, ata_device_add);
-
-	/* attach */
-	rc = ata_host_attach(host, ent->sht);
-	if (rc)
-		goto err_out;
-
-	VPRINTK("EXIT, returning %u\n", host->n_ports);
-	return host->n_ports; /* success */
-
- err_out:
-	devres_release_group(dev, ata_device_add);
-	VPRINTK("EXIT, returning 0\n");
-	return 0;
-}
-
-/**
  *	ata_port_detach - Detach ATA port in prepration of device removal
  *	@ap: ATA port to be detached
  *
@@ -6186,32 +6061,6 @@ void ata_host_detach(struct ata_host *host)
 		ata_port_detach(host->ports[i]);
 }
 
-struct ata_probe_ent *
-ata_probe_ent_alloc(struct device *dev, const struct ata_port_info *port)
-{
-	struct ata_probe_ent *probe_ent;
-
-	probe_ent = devm_kzalloc(dev, sizeof(*probe_ent), GFP_KERNEL);
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
-	probe_ent->port_flags = port->flags;
-	probe_ent->pio_mask = port->pio_mask;
-	probe_ent->mwdma_mask = port->mwdma_mask;
-	probe_ent->udma_mask = port->udma_mask;
-	probe_ent->port_ops = port->port_ops;
-	probe_ent->private_data = port->private_data;
-
-	return probe_ent;
-}
-
 /**
  *	ata_std_ports - initialize ioaddr with standard port offsets.
  *	@ioaddr: IO address structure to be initialized
@@ -6570,7 +6419,6 @@ EXPORT_SYMBOL_GPL(ata_host_alloc_pinfo);
 EXPORT_SYMBOL_GPL(ata_host_start);
 EXPORT_SYMBOL_GPL(ata_host_attach);
 EXPORT_SYMBOL_GPL(ata_host_activate);
-EXPORT_SYMBOL_GPL(ata_device_add);
 EXPORT_SYMBOL_GPL(ata_host_detach);
 EXPORT_SYMBOL_GPL(ata_sg_init);
 EXPORT_SYMBOL_GPL(ata_sg_init_one);
@@ -6653,7 +6501,6 @@ EXPORT_SYMBOL_GPL(ata_timing_merge);
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL_GPL(pci_test_config_bits);
 EXPORT_SYMBOL_GPL(pci_configure_dma_masks);
-EXPORT_SYMBOL_GPL(ata_pci_init_native_mode);
 EXPORT_SYMBOL_GPL(ata_pci_init_native_host);
 EXPORT_SYMBOL_GPL(ata_pci_prepare_native_host);
 EXPORT_SYMBOL_GPL(ata_pci_init_one);
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index d53b181..c29bdd5 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -533,101 +533,6 @@ static int ata_resources_present(struct pci_dev *pdev, int port)
 }
 
 /**
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
-	struct ata_probe_ent *probe_ent;
-	int i;
-	void __iomem * const *iomap;
-
-	/* Discard disabled ports.  Some controllers show their unused
-	 * channels this way.  Disabled ports will be made dummy.
-	 */
-	if (ata_resources_present(pdev, 0) == 0)
-		ports &= ~ATA_PORT_PRIMARY;
-	if (ata_resources_present(pdev, 1) == 0)
-		ports &= ~ATA_PORT_SECONDARY;
-
-	if (!ports) {
-		dev_printk(KERN_ERR, &pdev->dev, "no available port\n");
-		return NULL;
-	}
-
-	/* iomap BARs */
-	for (i = 0; i < 4; i++) {
-		if (!(ports & (1 << (i / 2))))
-			continue;
-		if (pcim_iomap(pdev, i, 0) == NULL) {
-			dev_printk(KERN_ERR, &pdev->dev,
-				   "failed to iomap PCI BAR %d\n", i);
-			return NULL;
-		}
-	}
-
-	pcim_iomap(pdev, 4, 0); /* may fail */
-	iomap = pcim_iomap_table(pdev);
-
-	/* alloc and init probe_ent */
-	probe_ent = ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[0]);
-	if (!probe_ent)
-		return NULL;
-
-	probe_ent->n_ports = 2;
-	probe_ent->irq = pdev->irq;
-	probe_ent->irq_flags = IRQF_SHARED;
-
-	if (ports & ATA_PORT_PRIMARY) {
-		probe_ent->port[0].cmd_addr = iomap[0];
-		probe_ent->port[0].altstatus_addr =
-		probe_ent->port[0].ctl_addr = (void __iomem *)
-			((unsigned long)iomap[1] | ATA_PCI_CTL_OFS);
-		if (iomap[4]) {
-			if ((!(port[0]->flags & ATA_FLAG_IGN_SIMPLEX)) &&
-			    (ioread8(iomap[4] + 2) & 0x80))
-				probe_ent->_host_flags |= ATA_HOST_SIMPLEX;
-			probe_ent->port[0].bmdma_addr = iomap[4];
-		}
-		ata_std_ports(&probe_ent->port[0]);
-	} else
-		probe_ent->dummy_port_mask |= ATA_PORT_PRIMARY;
-
-	if (ports & ATA_PORT_SECONDARY) {
-		probe_ent->port[1].cmd_addr = iomap[2];
-		probe_ent->port[1].altstatus_addr =
-		probe_ent->port[1].ctl_addr = (void __iomem *)
-			((unsigned long)iomap[3] | ATA_PCI_CTL_OFS);
-		if (iomap[4]) {
-			if ((!(port[1]->flags & ATA_FLAG_IGN_SIMPLEX)) &&
-			    (ioread8(iomap[4] + 10) & 0x80))
-				probe_ent->_host_flags |= ATA_HOST_SIMPLEX;
-			probe_ent->port[1].bmdma_addr = iomap[4] + 8;
-		}
-		ata_std_ports(&probe_ent->port[1]);
-		probe_ent->pinfo2 = port[1];
-	} else
-		probe_ent->dummy_port_mask |= ATA_PORT_SECONDARY;
-
-	return probe_ent;
-}
-
-/**
  *	ata_pci_init_bmdma - acquire PCI BMDMA resources and init ATA host
  *	@host: target ATA host
  *
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 38949a2..242cc7f 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -93,8 +93,6 @@ extern int ata_flush_cache(struct ata_device *dev);
 extern void ata_dev_init(struct ata_device *dev);
 extern int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg);
 extern int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg);
-extern struct ata_probe_ent *ata_probe_ent_alloc(struct device *dev,
-						 const struct ata_port_info *port);
 extern struct ata_port *ata_port_alloc(struct ata_host *host);
 
 /* libata-acpi.c */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 43d9356..1126184 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -366,34 +366,6 @@ struct ata_ioports {
 	void __iomem		*scr_addr;
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
-	unsigned long		port_flags;
-	unsigned long		_host_flags;
-	void __iomem * const	*iomap;
-	void			*private_data;
-
-	/* port_info for the secondary port.  Together with irq2, it's
-	 * used to implement non-uniform secondary port.  Currently,
-	 * the only user is ata_piix combined mode.  This workaround
-	 * will be removed together with ata_probe_ent when init model
-	 * is updated.
-	 */
-	const struct ata_port_info *pinfo2;
-};
-
 struct ata_host {
 	spinlock_t		lock;
 	struct device 		*dev;
@@ -739,7 +711,6 @@ extern int ata_host_attach(struct ata_host *host,
 extern int ata_host_activate(struct ata_host *host, int irq,
 			     irq_handler_t irq_handler, unsigned long irq_flags,
 			     struct scsi_host_template *sht);
-extern int ata_device_add(const struct ata_probe_ent *ent);
 extern void ata_host_detach(struct ata_host *host);
 extern void ata_host_init(struct ata_host *, struct device *,
 			  unsigned long, const struct ata_port_operations *);
@@ -881,8 +852,6 @@ struct pci_bits {
 	unsigned long		val;
 };
 
-extern struct ata_probe_ent *
-ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port, int portmask);
 extern int ata_pci_init_native_host(struct ata_host *host,
 				    unsigned int port_mask);
 extern int ata_pci_prepare_native_host(struct pci_dev *pdev,
-- 
1.5.0.1


