From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/17] libata: implement PCI init helpers for new LLD init model
Date: Mon, 7 Aug 2006 12:04:00 +0900
Message-ID: <1154919840689-git-send-email-htejun@gmail.com>
References: <1154919839169-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:59460 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750950AbWHGDEQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Aug 2006 23:04:16 -0400
Received: by py-out-1112.google.com with SMTP id z74so1855417pyg
        for <linux-ide@vger.kernel.org>; Sun, 06 Aug 2006 20:04:13 -0700 (PDT)
In-Reply-To: <1154919839169-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement the following PCI init helpers for new LLD init model.

* ata_pci_host_set_init_native(): init ports for native PCI host_set
* ata_pci_legacy_mask(): obtain legacy mask of ATA PCI device
* ata_pci_set_dma_mask(): set DMA mask helper
* ata_pci_acquire_resources(): acquire generic ATA PCI resources for host_set
* ata_pci_request_irq(): prep host_set for IRQ and request IRQ.
* ata_pci_release_resources(): release generic ATA PCI resources including IRQs
* ata_pci_host_set_destroy(): release associated resources and destroy host_set

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-bmdma.c |  390 +++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata-core.c  |    7 +
 include/linux/libata.h      |   36 ++++
 3 files changed, 431 insertions(+), 2 deletions(-)

139908fea67d9fa2c835b1c92e76112ab45e295c
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index c4cd578..341d9b5 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -797,6 +797,396 @@ void ata_bmdma_post_internal_cmd(struct 
 }
 
 #ifdef CONFIG_PCI
+static const unsigned long ata_legacy_addr_tbl[][2] = {
+	{ ATA_PRIMARY_CMD, ATA_PRIMARY_CTL },
+	{ ATA_SECONDARY_CMD, ATA_SECONDARY_CTL}
+};
+
+static void ata_pci_port_init(struct ata_port *ap, unsigned long cmd_addr,
+			      unsigned long ctl_addr, unsigned long bmdma_addr)
+{
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+
+	ioaddr->cmd_addr = cmd_addr;
+	ioaddr->altstatus_addr = ctl_addr;
+	ioaddr->ctl_addr = ctl_addr;
+
+	if (bmdma_addr) {
+		if (inb(bmdma_addr + 2) & 0x80)
+			ap->host_set->flags |= ATA_HOST_SIMPLEX;
+		ioaddr->bmdma_addr = bmdma_addr;
+	}
+	ata_std_ports(ioaddr);
+}
+
+static void ata_pci_port_init_native(struct ata_port *ap, int port)
+{
+	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	unsigned long cmd_addr, ctl_addr, bmdma_addr;
+
+	cmd_addr = pci_resource_start(pdev, port * 2);
+	ctl_addr = pci_resource_start(pdev, port * 2 + 1) | ATA_PCI_CTL_OFS;
+	bmdma_addr = pci_resource_start(pdev, 4);
+	if (bmdma_addr)
+		bmdma_addr += port * 8;
+
+	ata_pci_port_init(ap, cmd_addr, ctl_addr, bmdma_addr);
+}
+
+static void ata_pci_port_init_legacy(struct ata_port *ap, int port)
+{
+	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	unsigned long cmd_addr, ctl_addr, bmdma_addr;
+
+	cmd_addr = ata_legacy_addr_tbl[port][0];
+	ctl_addr = ata_legacy_addr_tbl[port][1];
+	bmdma_addr = pci_resource_start(pdev, 4);
+	if (bmdma_addr)
+		bmdma_addr += port * 8;
+
+	ata_pci_port_init(ap, cmd_addr, ctl_addr, bmdma_addr);
+}
+
+/**
+ *	ata_pci_host_set_init_native - init host_set for native PCI ATA
+ *	@host_set: target ATA host_set
+ *
+ *	Initialize @host_set for native mode PCI ATA.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+void ata_pci_host_set_init_native(struct ata_host_set *host_set)
+{
+	ata_pci_port_init_native(host_set->ports[0], 0);
+	if (host_set->n_ports > 1)
+		ata_pci_port_init_native(host_set->ports[1], 1);
+}
+
+/**
+ *	ata_pci_legacy_mask - obatin legacy mask from PCI IDE device
+ *	@pdev: target PCI device
+ *
+ *	Obtain legacy mask from @pdev.
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	Obtained legacy mask.
+ */
+unsigned int ata_pci_legacy_mask(struct pci_dev *pdev)
+{
+	unsigned int mask = 0;
+	u8 tmp8;
+
+	if (pdev->class >> 8 != PCI_CLASS_STORAGE_IDE)
+		return 0;
+
+	pci_read_config_byte(pdev, PCI_CLASS_PROG, &tmp8);
+
+	if (!(tmp8 & (1 << 0)))
+		mask |= ATA_PORT_PRIMARY;
+
+	if (!(tmp8 & (1 << 2)))
+		mask |= ATA_PORT_SECONDARY;
+
+	return mask;
+}
+
+static int ata_pci_acquire_legacy(int port, unsigned long *host_set_flags)
+{
+	unsigned long cmd_addr = ata_legacy_addr_tbl[port][0];
+
+	if (request_region(cmd_addr, 8, "libata") != NULL)
+		*host_set_flags |= ATA_HOST_RES_LEGACY_PRI << port;
+	else {
+		struct resource *conflict, res;
+
+		res.start = cmd_addr;
+		res.end = cmd_addr + 8 - 1;
+		conflict = ____request_resource(&ioport_resource, &res);
+
+		if (strcmp(conflict->name, "libata")) {
+			printk(KERN_WARNING "ata: 0x%0lX IDE port busy\n",
+			       cmd_addr);
+			*host_set_flags |= ATA_HOST_PCI_DEV_BUSY;
+			return -EBUSY;
+		}
+		printk("ata: 0x%0lX IDE port preallocated\n", cmd_addr);
+	}
+
+	return 0;
+}
+
+/**
+ *	ata_pci_set_dma_mask - PCI DMA mask set helper
+ *	@pdev: target PCI device
+ *	@dma_mask: DMA mask
+ *	@p_reason: output arg for error message
+ *
+ *	Helper to set PCI DMA mask.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_pci_set_dma_mask(struct pci_dev *pdev, u64 dma_mask,
+			 const char **p_reason)
+{
+	const char *reason;
+	int rc = 0;
+
+	if (dma_mask == DMA_64BIT_MASK) {
+		if (pci_set_dma_mask(pdev, DMA_64BIT_MASK) == 0) {
+			rc = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
+			if (rc) {
+				rc = pci_set_consistent_dma_mask(pdev,
+							DMA_32BIT_MASK);
+				if (rc) {
+					reason = "64-bit DMA enable failed";
+					goto err;
+				}
+			}
+		} else {
+			rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
+			if (rc) {
+				reason = "32-bit DMA enable failed";
+				goto err;
+			}
+			rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
+			if (rc) {
+				reason = "32-bit consistent DMA enable failed";
+				goto err;
+			}
+		}
+	} else if (dma_mask) {
+		reason = "failed to set DMA mask";
+		rc = pci_set_dma_mask(pdev, dma_mask);
+		if (rc)
+			goto err;
+		rc = pci_set_consistent_dma_mask(pdev, dma_mask);
+		if (rc)
+			goto err;
+	}
+
+	return 0;
+
+ err:
+	if (p_reason)
+		*p_reason = reason;
+	return rc;
+}
+
+/**
+ *	ata_pci_acquire_resources - acquire default PCI resources
+ *	@host_set: target ATA host_set to acquire PCI resources for
+ *	@dma_mask: DMA mask
+ *	@reason: output arg for error message
+ *
+ *	Acquire default ATA PCI resources.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_pci_acquire_resources(struct ata_host_set *host_set, u64 dma_mask,
+			      const char **reason)
+{
+	struct pci_dev *pdev = to_pci_dev(host_set->dev);
+	int nr_dummy, i, rc;
+
+	/* acquire generic resources */
+
+	/* FIXME: Really for ATA it isn't safe because the device may
+	 * be multi-purpose and we want to leave it alone if it was
+	 * already enabled. Secondly for shared use as Arjan says we
+	 * want refcounting
+	 *
+	 * Checking dev->is_enabled is insufficient as this is not set
+	 * at boot for the primary video which is BIOS enabled
+         */
+	rc = pci_enable_device(pdev);
+	if (rc) {
+		*reason = "failed to enable PCI device";
+		goto err;
+	}
+
+	rc = pci_request_regions(pdev, DRV_NAME);
+	if (rc) {
+		host_set->flags |= ATA_HOST_PCI_DEV_BUSY;
+		*reason = "failed to request PCI regions";
+		goto err;
+	}
+
+	host_set->flags |= ATA_HOST_PCI_RES_GEN;
+
+	/* set DMA mask */
+	/* FIXME: If we get no DMA mask we should fall back to PIO */
+	rc = ata_pci_set_dma_mask(pdev, dma_mask, reason);
+	if (rc)
+		goto err;
+
+	/* Acquire legacy resources.  For legacy ports, host_set must
+	 * be popultaed with ports before calling this function.
+	 */
+	nr_dummy = 0;
+	for (i = 0; i < 2; i++) {
+		if (!(host_set->flags & (ATA_HOST_LEGACY_PRI << i)))
+			continue;
+		BUG_ON(i >= host_set->n_ports);
+
+		if (ata_pci_acquire_legacy(i, &host_set->flags)) {
+			host_set->ports[i]->ops = &ata_dummy_port_ops;
+			nr_dummy++;
+		}
+	}
+
+	if (nr_dummy && nr_dummy == host_set->n_ports) {
+		*reason = "no available port";
+		rc = -ENODEV;
+		goto err;
+	}
+
+	return 0;
+
+ err:
+	ata_pci_release_resources(host_set);
+	return rc;
+}
+
+/**
+ *	ata_pci_request_irq - request PCI irq for ATA host_set
+ *	@host_set: ATA host_set to request PCI irq for
+ *	@irq_handler: irq_handler
+ *	@flags: ATA_PCI_IRQ_* flags
+ *	@reason: output arg for error message
+ *
+ *	Request PCI irq for @host_set.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer.
+ *
+ *	RETURNS:
+ *	Return value of request_irq().
+ */
+int ata_pci_request_irq(struct ata_host_set *host_set,
+		irqreturn_t (*irq_handler)(int, void *, struct pt_regs *),
+		unsigned int flags, const char **reason)
+{
+	struct pci_dev *pdev = to_pci_dev(host_set->dev);
+	unsigned int irq_flags = 0;
+	int rc;
+
+	if (flags & ATA_PCI_IRQ_MSI) {
+		flags &= ~ATA_PCI_IRQ_INTX;
+
+		if (pci_enable_msi(pdev) == 0)
+			host_set->flags |= ATA_HOST_PCI_RES_MSI;
+		else
+			flags |= ATA_PCI_IRQ_INTX;
+	}
+
+	if (flags & ATA_PCI_IRQ_INTX) {
+		pci_intx(pdev, 1);
+		host_set->flags |= ATA_HOST_PCI_RES_INTX;
+	}
+
+	if (!(flags & ATA_PCI_IRQ_EXCL))
+		irq_flags |= IRQF_SHARED;
+
+	rc = ata_host_set_request_irq(host_set, pdev->irq, irq_handler,
+				      irq_flags, reason);
+	if (rc == 0)
+		host_set->flags |= ATA_HOST_PCI_RES_IRQ;
+
+	return rc;
+}
+
+/**
+ *	ata_pci_release_resources - release all ATA PCI resources
+ *	@pdev: target ATA host_set
+ *
+ *	Release all ATA PCI resources.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+void ata_pci_release_resources(struct ata_host_set *host_set)
+{
+	struct pci_dev *pdev = to_pci_dev(host_set->dev);
+	int i;
+
+	/* stop all ports */
+	ata_host_set_stop(host_set);
+
+	/* release IRQs */
+	if (host_set->flags & ATA_HOST_PCI_RES_IRQ15) {
+		free_irq(15, host_set);
+		host_set->flags &= ~ATA_HOST_PCI_RES_IRQ15;
+	}
+
+	if (host_set->flags & ATA_HOST_PCI_RES_IRQ14) {
+		free_irq(14, host_set);
+		host_set->flags &= ~ATA_HOST_PCI_RES_IRQ14;
+	}
+
+	if (host_set->flags & ATA_HOST_PCI_RES_IRQ) {
+		free_irq(pdev->irq, host_set);
+		host_set->flags &= ~ATA_HOST_PCI_RES_IRQ;
+	}
+
+	if (host_set->flags & ATA_HOST_PCI_RES_INTX) {
+		pci_intx(pdev, 0);
+		host_set->flags &= ~ATA_HOST_PCI_RES_INTX;
+	}
+
+	if (host_set->flags & ATA_HOST_PCI_RES_MSI) {
+		pci_disable_msi(pdev);
+		host_set->flags &= ~ATA_HOST_PCI_RES_MSI;
+	}
+
+	/* release legacy resources */
+	for (i = 0; i < 2; i++) {
+		if (host_set->flags & (ATA_HOST_RES_LEGACY_PRI << i)) {
+			release_region(ata_legacy_addr_tbl[i][0], 8);
+			host_set->flags &= ~(ATA_HOST_RES_LEGACY_PRI << i);
+		}
+	}
+
+	/* release generic resources */
+	if (host_set->flags & ATA_HOST_PCI_RES_GEN) {
+		pci_release_regions(pdev);
+
+		if (!(host_set->flags & ATA_HOST_PCI_DEV_BUSY))
+			pci_disable_device(pdev);
+
+		host_set->flags &= ~ATA_HOST_PCI_RES_GEN;
+	}
+}
+
+/**
+ *	ata_pci_host_set_destroy - release all PCI resources and free host_set
+ *	@host_set: target ATA host_set
+ *
+ *	Release all ATA PCI resources associated with @host_set and
+ *	free it.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+void ata_pci_host_set_destroy(struct ata_host_set *host_set)
+{
+	if (host_set) {
+		ata_pci_release_resources(host_set);
+		ata_host_set_free(host_set);
+	}
+}
+
 static struct ata_probe_ent *
 ata_probe_ent_alloc(struct device *dev, const struct ata_port_info *port)
 {
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 78ee73a..d44c1df 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -6403,6 +6403,13 @@ EXPORT_SYMBOL_GPL(ata_timing_merge);
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL_GPL(pci_test_config_bits);
 EXPORT_SYMBOL_GPL(ata_pci_host_stop);
+EXPORT_SYMBOL_GPL(ata_pci_host_set_init_native);
+EXPORT_SYMBOL_GPL(ata_pci_legacy_mask);
+EXPORT_SYMBOL_GPL(ata_pci_set_dma_mask);
+EXPORT_SYMBOL_GPL(ata_pci_acquire_resources);
+EXPORT_SYMBOL_GPL(ata_pci_request_irq);
+EXPORT_SYMBOL_GPL(ata_pci_release_resources);
+EXPORT_SYMBOL_GPL(ata_pci_host_set_destroy);
 EXPORT_SYMBOL_GPL(ata_pci_init_native_mode);
 EXPORT_SYMBOL_GPL(ata_pci_init_one);
 EXPORT_SYMBOL_GPL(ata_pci_remove_one);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 91b1fc5..0ae0fbb 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -200,8 +200,24 @@ enum {
 	ATA_QCFLAG_EH_SCHEDULED = (1 << 18), /* EH scheduled (obsolete) */
 
 	/* host set flags */
-	ATA_HOST_SIMPLEX	= (1 << 0),	/* Host is simplex, one DMA channel per host_set only */
-	
+	/* keep ATA_HOST_*_LEGACY in sync with ATA_PORT_PRIMARY/SECONDARY */
+	ATA_HOST_LEGACY_PRI	= (1 << 0), /* primary port is legacy */
+	ATA_HOST_LEGACY_SEC	= (1 << 1), /* secondary port is legacy */
+	ATA_HOST_LEGACY_MASK	= ATA_HOST_LEGACY_PRI | ATA_HOST_LEGACY_SEC,
+
+	ATA_HOST_SIMPLEX	= (1 << 2), /* Host is simplex, one DMA channel per host_set only */
+
+	/* host_set resource flags */
+	ATA_HOST_RES_LEGACY_PRI	= (1 << 8), /* holding primary legacy */
+	ATA_HOST_RES_LEGACY_SEC	= (1 << 9), /* holding secondary legacy */
+	ATA_HOST_PCI_DEV_BUSY	= (1 << 10), /* if set, don't disable pdev */
+	ATA_HOST_PCI_RES_GEN	= (1 << 11), /* holding generic PCI resources */
+	ATA_HOST_PCI_RES_IRQ	= (1 << 12), /* holding PCI IRQ */
+	ATA_HOST_PCI_RES_IRQ14	= (1 << 13), /* holding legacy IRQ 14 */
+	ATA_HOST_PCI_RES_IRQ15	= (1 << 14), /* holding legacy IRQ 15 */
+	ATA_HOST_PCI_RES_INTX	= (1 << 15), /* enabled INTX */
+	ATA_HOST_PCI_RES_MSI	= (1 << 16), /* enabled MSI */
+
 	/* various lengths of time */
 	ATA_TMOUT_BOOT		= 30 * HZ,	/* heuristic */
 	ATA_TMOUT_BOOT_QUICK	= 7 * HZ,	/* heuristic */
@@ -248,6 +264,11 @@ enum {
 	ATA_PORT_PRIMARY	= (1 << 0),
 	ATA_PORT_SECONDARY	= (1 << 1),
 
+	/* flags for ata_pci_request_irq() */
+	ATA_PCI_IRQ_EXCL	= (1 << 0), /* don't set IRQF_SHARED */
+	ATA_PCI_IRQ_INTX	= (1 << 1), /* enable IRQ with INTX */
+	ATA_PCI_IRQ_MSI		= (1 << 2), /* try MSI (implies INTX) */
+
 	/* ering size */
 	ATA_ERING_SIZE		= 32,
 
@@ -840,6 +861,17 @@ struct pci_bits {
 };
 
 extern void ata_pci_host_stop (struct ata_host_set *host_set);
+extern void ata_pci_host_set_init_native(struct ata_host_set *host_set);
+extern unsigned int ata_pci_legacy_mask(struct pci_dev *pdev);
+extern int ata_pci_set_dma_mask(struct pci_dev *pdev, u64 dma_mask,
+				const char **p_reason);
+extern int ata_pci_acquire_resources(struct ata_host_set *host_set,
+				     u64 dma_mask, const char **reason);
+extern int ata_pci_request_irq(struct ata_host_set *host_set,
+		irqreturn_t (*irq_handler)(int, void *, struct pt_regs *),
+		unsigned int flags, const char **reason);
+extern void ata_pci_release_resources(struct ata_host_set *host_set);
+extern void ata_pci_host_set_destroy(struct ata_host_set *host_set);
 extern struct ata_probe_ent *
 ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port, int portmask);
 extern int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits);
-- 
1.3.2


