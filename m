From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/20] libata: kill old init helpers
Date: Sat, 19 Aug 2006 17:59:32 +0900
Message-ID: <1155977972397-git-send-email-htejun@gmail.com>
References: <11559778241753-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:43525 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751645AbWHSI76 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Aug 2006 04:59:58 -0400
Received: by py-out-1112.google.com with SMTP id n25so1465942pyg
        for <linux-ide@vger.kernel.org>; Sat, 19 Aug 2006 01:59:57 -0700 (PDT)
In-Reply-To: <11559778241753-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Kill old init helpers ata_pci_init_native_mode() and ata_device_add().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-bmdma.c |   68 ------------------------
 drivers/ata/libata-core.c  |  123 --------------------------------------------
 include/linux/libata.h     |    3 -
 3 files changed, 0 insertions(+), 194 deletions(-)

diff --git a/drivers/ata/libata-bmdma.c b/drivers/ata/libata-bmdma.c
index 672df5a..0f62a6e 100644
--- a/drivers/ata/libata-bmdma.c
+++ b/drivers/ata/libata-bmdma.c
@@ -798,74 +798,6 @@ void ata_bmdma_post_internal_cmd(struct 
 
 #ifdef CONFIG_PCI
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
-				probe_ent->_host_flags |= ATA_HOST_SIMPLEX;
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
-				probe_ent->_host_flags |= ATA_HOST_SIMPLEX;
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
-/**
  *	ata_pci_clear_simplex	-	attempt to kick device out of simplex
  *	@pdev: PCI device
  *
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ad32d35..1778256 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5911,127 +5911,6 @@ int ata_host_attach(struct ata_host *hos
 	return 0;
 }
 
-
-/**
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
-	if (!ent->port_ops->error_handler &&
-	    !(ent->port_flags & (ATA_FLAG_SATA_RESET | ATA_FLAG_SRST))) {
-		dev_printk(KERN_ERR, dev, "no reset mechanism available\n");
-		return 0;
-	}
-
-	/* allocate host */
-	host = ata_host_alloc(dev, ent->sht, ent->n_ports);
-	if (!host)
-		return 0;
-
-	host->irq = ent->irq;
-	host->irq2 = ent->irq2;
-	host->mmio_base = ent->mmio_base;
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
-		ap->pio_mask = ent->pio_mask;
-		ap->mwdma_mask = ent->mwdma_mask;
-		ap->udma_mask = ent->udma_mask;
-		ap->flags |= ent->port_flags;
-		ap->ops = ent->port_ops;
-
-		memcpy(&ap->ioaddr, &ent->port[ap->port_no],
-		       sizeof(struct ata_ioports));
-	}
-
-	/* start ports */
-	rc = ata_host_start(host);
-	if (rc)
-		goto err_free_host;
-
-	/* freeze */
-	for (i = 0; i < host->n_ports; i++) {
-		struct ata_port *ap = host->ports[i];
-
-		ata_chk_status(ap);
-		host->ops->irq_clear(ap);
-		ata_eh_freeze_port(ap);	/* freeze port before requesting IRQ */
-	}
-
-	/* obtain irq, that may be shared between channels */
-	rc = request_irq(ent->irq, ent->port_ops->irq_handler, ent->irq_flags,
-			 DRV_NAME, host);
-	if (rc) {
-		dev_printk(KERN_ERR, dev, "irq %lu request failed: %d\n",
-			   ent->irq, rc);
-		goto err_free_host;
-	}
-
-	/* do we have a second IRQ for the other channel, eg legacy mode */
-	if (ent->irq2) {
-		/* We will get weird core code crashes later if this is true
-		   so trap it now */
-		BUG_ON(ent->irq == ent->irq2);
-
-		rc = request_irq(ent->irq2, ent->port_ops->irq_handler, ent->irq_flags,
-			 DRV_NAME, host);
-		if (rc) {
-			dev_printk(KERN_ERR, dev, "irq %lu request failed: %d\n",
-				   ent->irq2, rc);
-			goto err_free_irq;
-		}
-	}
-
-	rc = ata_host_attach(host);
-	if (rc)
-		goto err_free_irq2;
-
-	return host->n_ports; /* success */
-
- err_free_irq2:
-	if (ent->irq2)
-		free_irq(ent->irq2, host);
- err_free_irq:
-	free_irq(ent->irq, host);
- err_free_host:
-	ata_host_stop(host);
-	ata_host_free(host);
-	VPRINTK("EXIT, returning 0\n");
-	return 0;
-}
-
 /**
  *	ata_port_detach - Detach ATA port in prepration of device removal
  *	@ap: ATA port to be detached
@@ -6501,7 +6380,6 @@ EXPORT_SYMBOL_GPL(ata_host_add_ports_pin
 EXPORT_SYMBOL_GPL(ata_host_start);
 EXPORT_SYMBOL_GPL(ata_host_request_irq);
 EXPORT_SYMBOL_GPL(ata_host_attach);
-EXPORT_SYMBOL_GPL(ata_device_add);
 EXPORT_SYMBOL_GPL(ata_host_detach);
 EXPORT_SYMBOL_GPL(ata_host_stop);
 EXPORT_SYMBOL_GPL(ata_host_free_irqs);
@@ -6583,7 +6461,6 @@ EXPORT_SYMBOL_GPL(ata_timing_merge);
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL_GPL(pci_test_config_bits);
 EXPORT_SYMBOL_GPL(ata_pci_host_stop);
-EXPORT_SYMBOL_GPL(ata_pci_init_native_mode);
 EXPORT_SYMBOL_GPL(ata_pci_device_do_suspend);
 EXPORT_SYMBOL_GPL(ata_pci_device_do_resume);
 EXPORT_SYMBOL_GPL(ata_pci_device_suspend);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e96c257..e274121 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -760,7 +760,6 @@ extern int ata_host_request_irq(struct a
 			const char **p_reason);
 extern int ata_host_start(struct ata_host *host);
 extern int ata_host_attach(struct ata_host *host);
-extern int ata_device_add(const struct ata_probe_ent *ent);
 extern void ata_host_detach(struct ata_host *host);
 extern void ata_host_stop(struct ata_host *host);
 extern void ata_host_free_irqs(struct ata_host *host);
@@ -900,8 +899,6 @@ struct pci_bits {
 };
 
 extern void ata_pci_host_stop (struct ata_host *host);
-extern struct ata_probe_ent *
-ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port, int portmask);
 extern int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits);
 extern unsigned long ata_pci_default_filter(const struct ata_port *, struct ata_device *, unsigned long);
 #endif /* CONFIG_PCI */
-- 
1.4.1.1


