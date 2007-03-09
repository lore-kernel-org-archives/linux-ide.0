From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/12] libata: convert legacy PCI host handling to new init model
Date: Fri, 9 Mar 2007 20:15:35 +0900
Message-ID: <11734389353821-git-send-email-htejun@gmail.com>
References: <1173438935540-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:5338 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767182AbXCILPp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 06:15:45 -0500
Received: by wr-out-0506.google.com with SMTP id 71so1261511wri
        for <linux-ide@vger.kernel.org>; Fri, 09 Mar 2007 03:15:45 -0800 (PST)
In-Reply-To: <1173438935540-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Convert legacy PCI host handling to alloc-init-attach model.
ata_init_legacy_host(), ata_request_legacy_irqs() and
ata_pci_init_bmdma() are separated out and follow the new init model.

The two legacy handling functions use separate ata_legacy_devres
instead of generic devm_* resources.  This reduces devres overhead for
legacy hosts which was a bit high because it didn't use PCI/iomap
merged resoruces.

ata_pci_init_one() is rewritten in terms of the aboved functions but
native mode handling is still using the old method.  Conversion will
be completed when native mode handling is updated.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-sff.c |  436 +++++++++++++++++++++++++++++++++-------------
 1 files changed, 312 insertions(+), 124 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index dfd906c..8287df5 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -627,75 +627,278 @@ ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port, int
 	return probe_ent;
 }
 
-static struct ata_probe_ent *ata_pci_init_legacy_port(struct pci_dev *pdev,
-				struct ata_port_info **port, int port_mask)
+/**
+ *	ata_pci_init_bmdma - acquire PCI BMDMA resources and init ATA host
+ *	@host: target ATA host
+ *
+ *	Acquire PCI BMDMA resources and initialize @host accordingly.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+static int ata_pci_init_bmdma(struct ata_host *host)
 {
-	struct ata_probe_ent *probe_ent;
-	void __iomem *iomap[5] = { }, *bmdma;
+	struct device *gdev = host->dev;
+	struct pci_dev *pdev = to_pci_dev(gdev);
+	int i, rc;
 
-	if (port_mask & ATA_PORT_PRIMARY) {
-		iomap[0] = devm_ioport_map(&pdev->dev, ATA_PRIMARY_CMD, 8);
-		iomap[1] = devm_ioport_map(&pdev->dev, ATA_PRIMARY_CTL, 1);
-		if (!iomap[0] || !iomap[1])
-			return NULL;
+	/* TODO: If we get no DMA mask we should fall back to PIO */
+	rc = pci_configure_dma_masks(pdev, ATA_DMA_MASK, NULL);
+	if (rc)
+		return rc;
+
+	/* request and iomap DMA region */
+	rc = pcim_iomap_regions(pdev, 1 << 4, DRV_NAME);
+	if (rc) {
+		dev_printk(KERN_ERR, gdev, "failed to request/iomap BAR4\n");
+		return -ENOMEM;
 	}
+	host->iomap = pcim_iomap_table(pdev);
 
-	if (port_mask & ATA_PORT_SECONDARY) {
-		iomap[2] = devm_ioport_map(&pdev->dev, ATA_SECONDARY_CMD, 8);
-		iomap[3] = devm_ioport_map(&pdev->dev, ATA_SECONDARY_CTL, 1);
-		if (!iomap[2] || !iomap[3])
-			return NULL;
+	for (i = 0; i < 2; i++) {
+		struct ata_port *ap = host->ports[i];
+		struct ata_ioports *ioaddr = &ap->ioaddr;
+		void __iomem *bmdma = host->iomap[4] + 8 * i;
+
+		if (ata_port_is_dummy(ap))
+			continue;
+
+		ioaddr->bmdma_addr = bmdma;
+		if ((!(ap->flags & ATA_FLAG_IGN_SIMPLEX)) &&
+		    (ioread8(bmdma + 2) & 0x80))
+			host->flags |= ATA_HOST_SIMPLEX;
 	}
 
-	bmdma = pcim_iomap(pdev, 4, 16); /* may fail */
+	return 0;
+}
+
+struct ata_legacy_devres {
+	unsigned int	mask;
+	unsigned long	cmd_port[2];
+	void __iomem *	cmd_addr[2];
+	void __iomem *	ctl_addr[2];
+	unsigned int	irq[2];
+	void *		irq_dev_id[2];
+};
 
-	/* alloc and init probe_ent */
-	probe_ent = ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[0]);
-	if (!probe_ent)
-		return NULL;
+static void ata_legacy_free_irqs(struct ata_legacy_devres *legacy_dr)
+{
+	int i;
 
-	probe_ent->n_ports = 2;
-	probe_ent->irq_flags = IRQF_SHARED;
+	for (i = 0; i < 2; i++) {
+		if (!legacy_dr->irq[i])
+			continue;
 
-	if (port_mask & ATA_PORT_PRIMARY) {
-		probe_ent->irq = ATA_PRIMARY_IRQ(pdev);
-		probe_ent->port[0].cmd_addr = iomap[0];
-		probe_ent->port[0].altstatus_addr =
-		probe_ent->port[0].ctl_addr = iomap[1];
-		if (bmdma) {
-			probe_ent->port[0].bmdma_addr = bmdma;
-			if ((!(port[0]->flags & ATA_FLAG_IGN_SIMPLEX)) &&
-			    (ioread8(bmdma + 2) & 0x80))
-				probe_ent->_host_flags |= ATA_HOST_SIMPLEX;
+		free_irq(legacy_dr->irq[i], legacy_dr->irq_dev_id[i]);
+		legacy_dr->irq[i] = 0;
+		legacy_dr->irq_dev_id[i] = NULL;
+	}
+}
+
+static void ata_legacy_release(struct device *gdev, void *res)
+{
+	struct ata_legacy_devres *this = res;
+	int i;
+
+	ata_legacy_free_irqs(this);
+
+	for (i = 0; i < 2; i++) {
+		if (this->cmd_addr[i])
+			ioport_unmap(this->cmd_addr[i]);
+		if (this->ctl_addr[i])
+			ioport_unmap(this->ctl_addr[i]);
+		if (this->cmd_port[i])
+			release_region(this->cmd_port[i], 8);
+	}
+}
+
+static int ata_init_legacy_port(struct ata_port *ap,
+				struct ata_legacy_devres *legacy_dr)
+{
+	struct ata_host *host = ap->host;
+	int port_no = ap->port_no;
+	unsigned long cmd_port, ctl_port;
+
+	if (port_no == 0) {
+		cmd_port = ATA_PRIMARY_CMD;
+		ctl_port = ATA_PRIMARY_CTL;
+	} else {
+		cmd_port = ATA_SECONDARY_CMD;
+		ctl_port = ATA_SECONDARY_CTL;
+	}
+
+	/* request cmd_port */
+	if (request_region(cmd_port, 8, "libata"))
+		legacy_dr->cmd_port[port_no] = cmd_port;
+	else {
+		struct resource *conflict, res;
+
+		/* Deal with combined mode hack. This side of the
+		 * logic all goes away once the combined mode hack is
+		 * killed in 2.6.21.
+		 */
+		res.start = cmd_port;
+		res.end = cmd_port + 8 - 1;
+		conflict = ____request_resource(&ioport_resource, &res);
+		while (conflict->child)
+			conflict = ____request_resource(conflict, &res);
+		if (strcmp(conflict->name, "libata")) {
+			dev_printk(KERN_WARNING, host->dev,
+				   "0x%0lX IDE port busy\n", cmd_port);
+			return -EBUSY;
 		}
-		ata_std_ports(&probe_ent->port[0]);
-	} else
-		probe_ent->dummy_port_mask |= ATA_PORT_PRIMARY;
+		dev_printk(KERN_INFO, host->dev,
+			   "0x%0lX IDE port preallocated\n", cmd_port);
+	}
+
+	/* iomap cmd and ctl ports */
+	legacy_dr->cmd_addr[port_no] = ioport_map(cmd_port, 8);
+	legacy_dr->ctl_addr[port_no] = ioport_map(ctl_port, 1);
+	if (!legacy_dr->cmd_addr[port_no] || !legacy_dr->ctl_addr[port_no])
+		return -ENOMEM;
+
+	/* init IO addresses */
+	ap->ioaddr.cmd_addr = legacy_dr->cmd_addr[port_no];
+	ap->ioaddr.altstatus_addr = legacy_dr->ctl_addr[port_no];
+	ap->ioaddr.ctl_addr = legacy_dr->ctl_addr[port_no];
+	ata_std_ports(&ap->ioaddr);
+
+	return 0;
+}
+
+/**
+ *	ata_init_legacy_host - acquire legacy ATA resources and init ATA host
+ *	@host: target ATA host
+ *	@legacy_mask: out parameter, mask indicating ports is in legacy mode
+ *	@was_busy: out parameter, indicates whether any port was busy
+ *
+ *	Acquire legacy ATA resources for ports.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+static int ata_init_legacy_host(struct ata_host *host,
+				unsigned int *legacy_mask, int *was_busy)
+{
+	struct device *gdev = host->dev;
+	struct ata_legacy_devres *legacy_dr;
+	int i, rc;
+
+	if (!devres_open_group(gdev, NULL, GFP_KERNEL))
+		return -ENOMEM;
+
+	rc = -ENOMEM;
+	legacy_dr = devres_alloc(ata_legacy_release, sizeof(*legacy_dr),
+				 GFP_KERNEL);
+	if (!legacy_dr)
+		goto err_out;
+	devres_add(gdev, legacy_dr);
+
+	for (i = 0; i < 2; i++) {
+		*legacy_mask &= ~(1 << i);
+		rc = ata_init_legacy_port(host->ports[i], legacy_dr);
+		if (rc == 0)
+			legacy_dr->mask |= 1 << i;
+		else if (rc == -EBUSY)
+			(*was_busy)++;
+	}
+
+	if (!legacy_dr->mask)
+		return -EBUSY;
 
-	if (port_mask & ATA_PORT_SECONDARY) {
-		if (probe_ent->irq)
-			probe_ent->irq2 = ATA_SECONDARY_IRQ(pdev);
+	for (i = 0; i < 2; i++)
+		if (!(legacy_dr->mask & (1 << i)))
+			host->ports[i]->ops = &ata_dummy_port_ops;
+
+	*legacy_mask |= legacy_dr->mask;
+
+	devres_remove_group(gdev, NULL);
+	return 0;
+
+ err_out:
+	devres_release_group(gdev, NULL);
+	return rc;
+}
+
+/**
+ *	ata_request_legacy_irqs - request legacy ATA IRQs
+ *	@host: target ATA host
+ *	@handler: array of IRQ handlers
+ *	@irq_flags: array of IRQ flags
+ *	@dev_id: array of IRQ dev_ids
+ *
+ *	Request legacy IRQs for non-dummy legacy ports in @host.  All
+ *	IRQ parameters are passed as array to allow ports to have
+ *	separate IRQ handlers.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+static int ata_request_legacy_irqs(struct ata_host *host,
+				   irq_handler_t const *handler,
+				   const unsigned int *irq_flags,
+				   void * const *dev_id)
+{
+	struct device *gdev = host->dev;
+	struct ata_legacy_devres *legacy_dr;
+	int i, rc;
+
+	legacy_dr = devres_find(host->dev, ata_legacy_release, NULL, NULL);
+	BUG_ON(!legacy_dr);
+
+	for (i = 0; i < 2; i++) {
+		unsigned int irq;
+
+		/* FIXME: ATA_*_IRQ() should take generic device not pci_dev */
+		if (i == 0)
+			irq = ATA_PRIMARY_IRQ(to_pci_dev(gdev));
 		else
-			probe_ent->irq = ATA_SECONDARY_IRQ(pdev);
-		probe_ent->port[1].cmd_addr = iomap[2];
-		probe_ent->port[1].altstatus_addr =
-		probe_ent->port[1].ctl_addr = iomap[3];
-		if (bmdma) {
-			probe_ent->port[1].bmdma_addr = bmdma + 8;
-			if ((!(port[1]->flags & ATA_FLAG_IGN_SIMPLEX)) &&
-			    (ioread8(bmdma + 10) & 0x80))
-				probe_ent->_host_flags |= ATA_HOST_SIMPLEX;
+			irq = ATA_SECONDARY_IRQ(to_pci_dev(gdev));
+
+		if (!(legacy_dr->mask & (1 << i)))
+			continue;
+
+		if (!handler[i]) {
+			dev_printk(KERN_ERR, gdev,
+				   "NULL handler specified for port %d\n", i);
+			rc = -EINVAL;
+			goto err_out;
 		}
-		ata_std_ports(&probe_ent->port[1]);
 
-		/* FIXME: could be pointing to stack area; must copy */
-		probe_ent->pinfo2 = port[1];
-	} else
-		probe_ent->dummy_port_mask |= ATA_PORT_SECONDARY;
+		rc = request_irq(irq, handler[i], irq_flags[i], DRV_NAME,
+				 dev_id[i]);
+		if (rc) {
+			dev_printk(KERN_ERR, gdev,
+				"irq %u request failed (errno=%d)\n", irq, rc);
+			goto err_out;
+		}
 
-	return probe_ent;
-}
+		/* record irq allocation in legacy_dr */
+		legacy_dr->irq[i] = irq;
+		legacy_dr->irq_dev_id[i] = dev_id[i];
+
+		/* only used to print info */
+		if (i == 0)
+			host->irq = irq;
+		else
+			host->irq2 = irq;
+	}
 
+	return 0;
+
+ err_out:
+	ata_legacy_free_irqs(legacy_dr);
+	return rc;
+}
 
 /**
  *	ata_pci_init_one - Initialize/register PCI IDE host controller
@@ -727,7 +930,8 @@ int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 {
 	struct device *dev = &pdev->dev;
 	struct ata_probe_ent *probe_ent = NULL;
-	struct ata_port_info *port[2];
+	struct ata_host *host = NULL;
+	const struct ata_port_info *port[2];
 	u8 mask;
 	unsigned int legacy_mode = 0;
 	int rc;
@@ -783,87 +987,71 @@ int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 			pcim_pin_device(pdev);
 			goto err_out;
 		}
+
+		/* TODO: If we get no DMA mask we should fall back to PIO */
+		rc = pci_configure_dma_masks(pdev, ATA_DMA_MASK, NULL);
+		if (rc)
+			goto err_out;
+
+		pci_set_master(pdev);
 	} else {
-		/* Deal with combined mode hack. This side of the logic all
-		   goes away once the combined mode hack is killed in 2.6.21 */
-		if (!devm_request_region(dev, ATA_PRIMARY_CMD, 8, "libata")) {
-			struct resource *conflict, res;
-			res.start = ATA_PRIMARY_CMD;
-			res.end = ATA_PRIMARY_CMD + 8 - 1;
-			conflict = ____request_resource(&ioport_resource, &res);
-			while (conflict->child)
-				conflict = ____request_resource(conflict, &res);
-			if (!strcmp(conflict->name, "libata"))
-				legacy_mode |= ATA_PORT_PRIMARY;
-			else {
-				pcim_pin_device(pdev);
-				printk(KERN_WARNING "ata: 0x%0X IDE port busy\n" \
-						    "ata: conflict with %s\n",
-						    ATA_PRIMARY_CMD,
-						    conflict->name);
-			}
-		} else
-			legacy_mode |= ATA_PORT_PRIMARY;
-
-		if (!devm_request_region(dev, ATA_SECONDARY_CMD, 8, "libata")) {
-			struct resource *conflict, res;
-			res.start = ATA_SECONDARY_CMD;
-			res.end = ATA_SECONDARY_CMD + 8 - 1;
-			conflict = ____request_resource(&ioport_resource, &res);
-			while (conflict->child)
-				conflict = ____request_resource(conflict, &res);
-			if (!strcmp(conflict->name, "libata"))
-				legacy_mode |= ATA_PORT_SECONDARY;
-			else {
-				pcim_pin_device(pdev);
-				printk(KERN_WARNING "ata: 0x%X IDE port busy\n" \
-						    "ata: conflict with %s\n",
-						    ATA_SECONDARY_CMD,
-						    conflict->name);
-			}
-		} else
-			legacy_mode |= ATA_PORT_SECONDARY;
-
-		if (legacy_mode & ATA_PORT_PRIMARY)
-			pci_request_region(pdev, 1, DRV_NAME);
-		if (legacy_mode & ATA_PORT_SECONDARY)
-			pci_request_region(pdev, 3, DRV_NAME);
-		/* If there is a DMA resource, allocate it */
-		pci_request_region(pdev, 4, DRV_NAME);
-	}
+		int was_busy = 0;
 
-	/* we have legacy mode, but all ports are unavailable */
-	if (legacy_mode == (1 << 3)) {
-		rc = -EBUSY;
-		goto err_out;
-	}
+		rc = -ENOMEM;
+		host = ata_host_alloc_pinfo(dev, port, 2);
+		if (!host)
+			goto err_out;
 
-	/* TODO: If we get no DMA mask we should fall back to PIO */
-	rc = pci_configure_dma_masks(pdev, ATA_DMA_MASK, NULL);
-	if (rc)
-		goto err_out;
+		rc = ata_init_legacy_host(host, &legacy_mode, &was_busy);
+		if (was_busy)
+			pcim_pin_device(pdev);
+		if (rc)
+			goto err_out;
+
+		/* request respective PCI regions, may fail */
+		rc = pci_request_region(pdev, 1, DRV_NAME);
+		rc = pci_request_region(pdev, 3, DRV_NAME);
+
+		/* init bmdma */
+		ata_pci_init_bmdma(host);
+		pci_set_master(pdev);
+	}
 
 	if (legacy_mode) {
-		probe_ent = ata_pci_init_legacy_port(pdev, port, legacy_mode);
+		irq_handler_t handler[2] = { host->ops->irq_handler,
+					     host->ops->irq_handler };
+		unsigned int irq_flags[2] = { IRQF_SHARED, IRQF_SHARED };
+		void *dev_id[2] = { host, host };
+
+		rc = ata_host_start(host);
+		if (rc)
+			goto err_out;
+
+		rc = ata_request_legacy_irqs(host, handler, irq_flags, dev_id);
+		if (rc)
+			goto err_out;
+
+		rc = ata_host_attach(host, port_info[0]->sht);
+		if (rc)
+			goto err_out;
 	} else {
 		if (n_ports == 2)
-			probe_ent = ata_pci_init_native_mode(pdev, port, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
+			probe_ent = ata_pci_init_native_mode(pdev, (struct ata_port_info **)port, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
 		else
-			probe_ent = ata_pci_init_native_mode(pdev, port, ATA_PORT_PRIMARY);
-	}
-	if (!probe_ent) {
-		rc = -ENOMEM;
-		goto err_out;
-	}
+			probe_ent = ata_pci_init_native_mode(pdev, (struct ata_port_info **)port, ATA_PORT_PRIMARY);
 
-	pci_set_master(pdev);
+		if (!probe_ent) {
+			rc = -ENOMEM;
+			goto err_out;
+		}
 
-	if (!ata_device_add(probe_ent)) {
-		rc = -ENODEV;
-		goto err_out;
-	}
+		if (!ata_device_add(probe_ent)) {
+			rc = -ENODEV;
+			goto err_out;
+		}
 
-	devm_kfree(dev, probe_ent);
+		devm_kfree(dev, probe_ent);
+	}
 	devres_remove_group(dev, NULL);
 	return 0;
 
-- 
1.5.0.1


