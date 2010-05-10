From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 08/23] libata-sff: reorder SFF/BMDMA functions
Date: Mon, 10 May 2010 21:41:32 +0200
Message-ID: <1273520507-32459-9-git-send-email-tj@kernel.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44963 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756035Ab0EJTme (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 May 2010 15:42:34 -0400
In-Reply-To: <1273520507-32459-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, sshtylyov@mvista.com
Cc: Tejun Heo <tj@kernel.org>

Reorder functions such that SFF and BMDMA functions are grouped.
While at it, s/BMDMA/SFF in a few comments where it actually meant
SFF.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-sff.c |  448 +++++++++++++++++++++++-----------------------
 include/linux/libata.h   |   21 ++-
 2 files changed, 238 insertions(+), 231 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 02524b5..5ec17f9 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -72,26 +72,6 @@ const struct ata_port_operations ata_sff_port_ops = {
 };
 EXPORT_SYMBOL_GPL(ata_sff_port_ops);
 
-const struct ata_port_operations ata_bmdma_port_ops = {
-	.inherits		= &ata_sff_port_ops,
-
-	.mode_filter		= ata_bmdma_mode_filter,
-
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-};
-EXPORT_SYMBOL_GPL(ata_bmdma_port_ops);
-
-const struct ata_port_operations ata_bmdma32_port_ops = {
-	.inherits		= &ata_bmdma_port_ops,
-
-	.sff_data_xfer		= ata_sff_data_xfer32,
-	.port_start		= ata_sff_port_start32,
-};
-EXPORT_SYMBOL_GPL(ata_bmdma32_port_ops);
-
 /**
  *	ata_fill_sg - Fill PCI IDE PRD table
  *	@qc: Metadata associated with taskfile to be transferred
@@ -1728,7 +1708,7 @@ unsigned int ata_sff_host_intr(struct ata_port *ap,
 			goto idle_irq;
 	}
 
-	/* ack bmdma irq events */
+	/* clear irq events */
 	ap->ops->sff_irq_clear(ap);
 
 	ata_sff_hsm_move(ap, qc, status, 0);
@@ -1882,7 +1862,7 @@ EXPORT_SYMBOL_GPL(ata_sff_lost_interrupt);
  *	ata_sff_freeze - Freeze SFF controller port
  *	@ap: port to freeze
  *
- *	Freeze BMDMA controller port.
+ *	Freeze SFF controller port.
  *
  *	LOCKING:
  *	Inherited from caller.
@@ -2513,208 +2493,8 @@ void ata_sff_std_ports(struct ata_ioports *ioaddr)
 }
 EXPORT_SYMBOL_GPL(ata_sff_std_ports);
 
-unsigned long ata_bmdma_mode_filter(struct ata_device *adev,
-				    unsigned long xfer_mask)
-{
-	/* Filter out DMA modes if the device has been configured by
-	   the BIOS as PIO only */
-
-	if (adev->link->ap->ioaddr.bmdma_addr == NULL)
-		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
-	return xfer_mask;
-}
-EXPORT_SYMBOL_GPL(ata_bmdma_mode_filter);
-
-/**
- *	ata_bmdma_setup - Set up PCI IDE BMDMA transaction
- *	@qc: Info associated with this ATA transaction.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- */
-void ata_bmdma_setup(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
-	u8 dmactl;
-
-	/* load PRD table addr. */
-	mb();	/* make sure PRD table writes are visible to controller */
-	iowrite32(ap->prd_dma, ap->ioaddr.bmdma_addr + ATA_DMA_TABLE_OFS);
-
-	/* specify data direction, triple-check start bit is clear */
-	dmactl = ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
-	dmactl &= ~(ATA_DMA_WR | ATA_DMA_START);
-	if (!rw)
-		dmactl |= ATA_DMA_WR;
-	iowrite8(dmactl, ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
-
-	/* issue r/w command */
-	ap->ops->sff_exec_command(ap, &qc->tf);
-}
-EXPORT_SYMBOL_GPL(ata_bmdma_setup);
-
-/**
- *	ata_bmdma_start - Start a PCI IDE BMDMA transaction
- *	@qc: Info associated with this ATA transaction.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- */
-void ata_bmdma_start(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	u8 dmactl;
-
-	/* start host DMA transaction */
-	dmactl = ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
-	iowrite8(dmactl | ATA_DMA_START, ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
-
-	/* Strictly, one may wish to issue an ioread8() here, to
-	 * flush the mmio write.  However, control also passes
-	 * to the hardware at this point, and it will interrupt
-	 * us when we are to resume control.  So, in effect,
-	 * we don't care when the mmio write flushes.
-	 * Further, a read of the DMA status register _immediately_
-	 * following the write may not be what certain flaky hardware
-	 * is expected, so I think it is best to not add a readb()
-	 * without first all the MMIO ATA cards/mobos.
-	 * Or maybe I'm just being paranoid.
-	 *
-	 * FIXME: The posting of this write means I/O starts are
-	 * unneccessarily delayed for MMIO
-	 */
-}
-EXPORT_SYMBOL_GPL(ata_bmdma_start);
-
-/**
- *	ata_bmdma_stop - Stop PCI IDE BMDMA transfer
- *	@qc: Command we are ending DMA for
- *
- *	Clears the ATA_DMA_START flag in the dma control register
- *
- *	May be used as the bmdma_stop() entry in ata_port_operations.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- */
-void ata_bmdma_stop(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	void __iomem *mmio = ap->ioaddr.bmdma_addr;
-
-	/* clear start/stop bit */
-	iowrite8(ioread8(mmio + ATA_DMA_CMD) & ~ATA_DMA_START,
-		 mmio + ATA_DMA_CMD);
-
-	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
-	ata_sff_dma_pause(ap);
-}
-EXPORT_SYMBOL_GPL(ata_bmdma_stop);
-
-/**
- *	ata_bmdma_status - Read PCI IDE BMDMA status
- *	@ap: Port associated with this ATA transaction.
- *
- *	Read and return BMDMA status register.
- *
- *	May be used as the bmdma_status() entry in ata_port_operations.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- */
-u8 ata_bmdma_status(struct ata_port *ap)
-{
-	return ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
-}
-EXPORT_SYMBOL_GPL(ata_bmdma_status);
-
 #ifdef CONFIG_PCI
 
-/**
- *	ata_pci_bmdma_clear_simplex -	attempt to kick device out of simplex
- *	@pdev: PCI device
- *
- *	Some PCI ATA devices report simplex mode but in fact can be told to
- *	enter non simplex mode. This implements the necessary logic to
- *	perform the task on such devices. Calling it on other devices will
- *	have -undefined- behaviour.
- */
-int ata_pci_bmdma_clear_simplex(struct pci_dev *pdev)
-{
-	unsigned long bmdma = pci_resource_start(pdev, 4);
-	u8 simplex;
-
-	if (bmdma == 0)
-		return -ENOENT;
-
-	simplex = inb(bmdma + 0x02);
-	outb(simplex & 0x60, bmdma + 0x02);
-	simplex = inb(bmdma + 0x02);
-	if (simplex & 0x80)
-		return -EOPNOTSUPP;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(ata_pci_bmdma_clear_simplex);
-
-/**
- *	ata_pci_bmdma_init - acquire PCI BMDMA resources and init ATA host
- *	@host: target ATA host
- *
- *	Acquire PCI BMDMA resources and initialize @host accordingly.
- *
- *	LOCKING:
- *	Inherited from calling layer (may sleep).
- *
- *	RETURNS:
- *	0 on success, -errno otherwise.
- */
-int ata_pci_bmdma_init(struct ata_host *host)
-{
-	struct device *gdev = host->dev;
-	struct pci_dev *pdev = to_pci_dev(gdev);
-	int i, rc;
-
-	/* No BAR4 allocation: No DMA */
-	if (pci_resource_start(pdev, 4) == 0)
-		return 0;
-
-	/* TODO: If we get no DMA mask we should fall back to PIO */
-	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
-	if (rc)
-		return rc;
-	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
-	if (rc)
-		return rc;
-
-	/* request and iomap DMA region */
-	rc = pcim_iomap_regions(pdev, 1 << 4, dev_driver_string(gdev));
-	if (rc) {
-		dev_printk(KERN_ERR, gdev, "failed to request/iomap BAR4\n");
-		return -ENOMEM;
-	}
-	host->iomap = pcim_iomap_table(pdev);
-
-	for (i = 0; i < 2; i++) {
-		struct ata_port *ap = host->ports[i];
-		void __iomem *bmdma = host->iomap[4] + 8 * i;
-
-		if (ata_port_is_dummy(ap))
-			continue;
-
-		ap->ioaddr.bmdma_addr = bmdma;
-		if ((!(ap->flags & ATA_FLAG_IGN_SIMPLEX)) &&
-		    (ioread8(bmdma + 2) & 0x80))
-			host->flags |= ATA_HOST_SIMPLEX;
-
-		ata_port_desc(ap, "bmdma 0x%llx",
-		    (unsigned long long)pci_resource_start(pdev, 4) + 8 * i);
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(ata_pci_bmdma_init);
-
 static int ata_resources_present(struct pci_dev *pdev, int port)
 {
 	int i;
@@ -3039,3 +2819,227 @@ out:
 EXPORT_SYMBOL_GPL(ata_pci_sff_init_one);
 
 #endif /* CONFIG_PCI */
+
+const struct ata_port_operations ata_bmdma_port_ops = {
+	.inherits		= &ata_sff_port_ops,
+
+	.mode_filter		= ata_bmdma_mode_filter,
+
+	.bmdma_setup		= ata_bmdma_setup,
+	.bmdma_start		= ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
+};
+EXPORT_SYMBOL_GPL(ata_bmdma_port_ops);
+
+const struct ata_port_operations ata_bmdma32_port_ops = {
+	.inherits		= &ata_bmdma_port_ops,
+
+	.sff_data_xfer		= ata_sff_data_xfer32,
+	.port_start		= ata_sff_port_start32,
+};
+EXPORT_SYMBOL_GPL(ata_bmdma32_port_ops);
+
+unsigned long ata_bmdma_mode_filter(struct ata_device *adev,
+				    unsigned long xfer_mask)
+{
+	/* Filter out DMA modes if the device has been configured by
+	   the BIOS as PIO only */
+
+	if (adev->link->ap->ioaddr.bmdma_addr == NULL)
+		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
+	return xfer_mask;
+}
+EXPORT_SYMBOL_GPL(ata_bmdma_mode_filter);
+
+/**
+ *	ata_bmdma_setup - Set up PCI IDE BMDMA transaction
+ *	@qc: Info associated with this ATA transaction.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ */
+void ata_bmdma_setup(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
+	u8 dmactl;
+
+	/* load PRD table addr. */
+	mb();	/* make sure PRD table writes are visible to controller */
+	iowrite32(ap->prd_dma, ap->ioaddr.bmdma_addr + ATA_DMA_TABLE_OFS);
+
+	/* specify data direction, triple-check start bit is clear */
+	dmactl = ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+	dmactl &= ~(ATA_DMA_WR | ATA_DMA_START);
+	if (!rw)
+		dmactl |= ATA_DMA_WR;
+	iowrite8(dmactl, ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+
+	/* issue r/w command */
+	ap->ops->sff_exec_command(ap, &qc->tf);
+}
+EXPORT_SYMBOL_GPL(ata_bmdma_setup);
+
+/**
+ *	ata_bmdma_start - Start a PCI IDE BMDMA transaction
+ *	@qc: Info associated with this ATA transaction.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ */
+void ata_bmdma_start(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	u8 dmactl;
+
+	/* start host DMA transaction */
+	dmactl = ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+	iowrite8(dmactl | ATA_DMA_START, ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+
+	/* Strictly, one may wish to issue an ioread8() here, to
+	 * flush the mmio write.  However, control also passes
+	 * to the hardware at this point, and it will interrupt
+	 * us when we are to resume control.  So, in effect,
+	 * we don't care when the mmio write flushes.
+	 * Further, a read of the DMA status register _immediately_
+	 * following the write may not be what certain flaky hardware
+	 * is expected, so I think it is best to not add a readb()
+	 * without first all the MMIO ATA cards/mobos.
+	 * Or maybe I'm just being paranoid.
+	 *
+	 * FIXME: The posting of this write means I/O starts are
+	 * unneccessarily delayed for MMIO
+	 */
+}
+EXPORT_SYMBOL_GPL(ata_bmdma_start);
+
+/**
+ *	ata_bmdma_stop - Stop PCI IDE BMDMA transfer
+ *	@qc: Command we are ending DMA for
+ *
+ *	Clears the ATA_DMA_START flag in the dma control register
+ *
+ *	May be used as the bmdma_stop() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ */
+void ata_bmdma_stop(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	void __iomem *mmio = ap->ioaddr.bmdma_addr;
+
+	/* clear start/stop bit */
+	iowrite8(ioread8(mmio + ATA_DMA_CMD) & ~ATA_DMA_START,
+		 mmio + ATA_DMA_CMD);
+
+	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
+	ata_sff_dma_pause(ap);
+}
+EXPORT_SYMBOL_GPL(ata_bmdma_stop);
+
+/**
+ *	ata_bmdma_status - Read PCI IDE BMDMA status
+ *	@ap: Port associated with this ATA transaction.
+ *
+ *	Read and return BMDMA status register.
+ *
+ *	May be used as the bmdma_status() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ */
+u8 ata_bmdma_status(struct ata_port *ap)
+{
+	return ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+}
+EXPORT_SYMBOL_GPL(ata_bmdma_status);
+
+#ifdef CONFIG_PCI
+
+/**
+ *	ata_pci_bmdma_clear_simplex -	attempt to kick device out of simplex
+ *	@pdev: PCI device
+ *
+ *	Some PCI ATA devices report simplex mode but in fact can be told to
+ *	enter non simplex mode. This implements the necessary logic to
+ *	perform the task on such devices. Calling it on other devices will
+ *	have -undefined- behaviour.
+ */
+int ata_pci_bmdma_clear_simplex(struct pci_dev *pdev)
+{
+	unsigned long bmdma = pci_resource_start(pdev, 4);
+	u8 simplex;
+
+	if (bmdma == 0)
+		return -ENOENT;
+
+	simplex = inb(bmdma + 0x02);
+	outb(simplex & 0x60, bmdma + 0x02);
+	simplex = inb(bmdma + 0x02);
+	if (simplex & 0x80)
+		return -EOPNOTSUPP;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ata_pci_bmdma_clear_simplex);
+
+/**
+ *	ata_pci_bmdma_init - acquire PCI BMDMA resources and init ATA host
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
+int ata_pci_bmdma_init(struct ata_host *host)
+{
+	struct device *gdev = host->dev;
+	struct pci_dev *pdev = to_pci_dev(gdev);
+	int i, rc;
+
+	/* No BAR4 allocation: No DMA */
+	if (pci_resource_start(pdev, 4) == 0)
+		return 0;
+
+	/* TODO: If we get no DMA mask we should fall back to PIO */
+	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
+	if (rc)
+		return rc;
+	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
+	if (rc)
+		return rc;
+
+	/* request and iomap DMA region */
+	rc = pcim_iomap_regions(pdev, 1 << 4, dev_driver_string(gdev));
+	if (rc) {
+		dev_printk(KERN_ERR, gdev, "failed to request/iomap BAR4\n");
+		return -ENOMEM;
+	}
+	host->iomap = pcim_iomap_table(pdev);
+
+	for (i = 0; i < 2; i++) {
+		struct ata_port *ap = host->ports[i];
+		void __iomem *bmdma = host->iomap[4] + 8 * i;
+
+		if (ata_port_is_dummy(ap))
+			continue;
+
+		ap->ioaddr.bmdma_addr = bmdma;
+		if ((!(ap->flags & ATA_FLAG_IGN_SIMPLEX)) &&
+		    (ioread8(bmdma + 2) & 0x80))
+			host->flags |= ATA_HOST_SIMPLEX;
+
+		ata_port_desc(ap, "bmdma 0x%llx",
+		    (unsigned long long)pci_resource_start(pdev, 4) + 8 * i);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ata_pci_bmdma_init);
+
+#endif /* CONFIG_PCI */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d165641..7d40e46 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1618,16 +1618,7 @@ extern void ata_sff_post_internal_cmd(struct ata_queued_cmd *qc);
 extern int ata_sff_port_start(struct ata_port *ap);
 extern int ata_sff_port_start32(struct ata_port *ap);
 extern void ata_sff_std_ports(struct ata_ioports *ioaddr);
-extern unsigned long ata_bmdma_mode_filter(struct ata_device *dev,
-					   unsigned long xfer_mask);
-extern void ata_bmdma_setup(struct ata_queued_cmd *qc);
-extern void ata_bmdma_start(struct ata_queued_cmd *qc);
-extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
-extern u8 ata_bmdma_status(struct ata_port *ap);
-
 #ifdef CONFIG_PCI
-extern int ata_pci_bmdma_clear_simplex(struct pci_dev *pdev);
-extern int ata_pci_bmdma_init(struct ata_host *host);
 extern int ata_pci_sff_init_host(struct ata_host *host);
 extern int ata_pci_sff_prepare_host(struct pci_dev *pdev,
 				    const struct ata_port_info * const * ppi,
@@ -1640,6 +1631,18 @@ extern int ata_pci_sff_init_one(struct pci_dev *pdev,
 		struct scsi_host_template *sht, void *host_priv, int hflags);
 #endif /* CONFIG_PCI */
 
+extern unsigned long ata_bmdma_mode_filter(struct ata_device *dev,
+					   unsigned long xfer_mask);
+extern void ata_bmdma_setup(struct ata_queued_cmd *qc);
+extern void ata_bmdma_start(struct ata_queued_cmd *qc);
+extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
+extern u8 ata_bmdma_status(struct ata_port *ap);
+
+#ifdef CONFIG_PCI
+extern int ata_pci_bmdma_clear_simplex(struct pci_dev *pdev);
+extern int ata_pci_bmdma_init(struct ata_host *host);
+#endif /* CONFIG_PCI */
+
 /**
  *	ata_sff_busy_wait - Wait for a port status register
  *	@ap: Port to wait for.
-- 
1.6.4.2

