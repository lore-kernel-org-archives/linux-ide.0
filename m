From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/27] libata: reorder functions in libata-sff.c
Date: Tue, 25 Mar 2008 22:16:40 +0900
Message-ID: <1206451025826-git-send-email-htejun@gmail.com>
References: <1206451025926-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.232]:15483 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093AbYCYNR3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:17:29 -0400
Received: by wx-out-0506.google.com with SMTP id h31so3539072wxd.4
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:17:29 -0700 (PDT)
In-Reply-To: <1206451025926-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com
Cc: Tejun Heo <htejun@gmail.com>

Reorder functions in drivers/ata/libata-sff.c such that functions
generally follow ops table order and init functions come last.  This
is in preparation of SFF cleanup.

This patch strictly moves stuff around and as such doesn't cause any
functional difference.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-sff.c |  443 +++++++++++++++++++++++-----------------------
 1 files changed, 220 insertions(+), 223 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 0e30c11..4cbb149 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -39,6 +39,43 @@
 #include "libata.h"
 
 /**
+ *	ata_check_status - Read device status reg & clear interrupt
+ *	@ap: port where the device is
+ *
+ *	Reads ATA taskfile status register for currently-selected device
+ *	and return its value. This also clears pending interrupts
+ *      from this device
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+u8 ata_check_status(struct ata_port *ap)
+{
+	return ioread8(ap->ioaddr.status_addr);
+}
+
+/**
+ *	ata_altstatus - Read device alternate status reg
+ *	@ap: port where the device is
+ *
+ *	Reads ATA taskfile alternate status register for
+ *	currently-selected device and return its value.
+ *
+ *	Note: may NOT be used as the check_altstatus() entry in
+ *	ata_port_operations.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+u8 ata_altstatus(struct ata_port *ap)
+{
+	if (ap->ops->check_altstatus)
+		return ap->ops->check_altstatus(ap);
+
+	return ioread8(ap->ioaddr.altstatus_addr);
+}
+
+/**
  *	ata_irq_on - Enable interrupts on a port.
  *	@ap: Port on which interrupts are enabled.
  *
@@ -66,6 +103,27 @@ u8 ata_irq_on(struct ata_port *ap)
 }
 
 /**
+ *	ata_bmdma_irq_clear - Clear PCI IDE BMDMA interrupt.
+ *	@ap: Port associated with this ATA transaction.
+ *
+ *	Clear interrupt and error flags in DMA status register.
+ *
+ *	May be used as the irq_clear() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ */
+void ata_bmdma_irq_clear(struct ata_port *ap)
+{
+	void __iomem *mmio = ap->ioaddr.bmdma_addr;
+
+	if (!mmio)
+		return;
+
+	iowrite8(ioread8(mmio + ATA_DMA_STATUS), mmio + ATA_DMA_STATUS);
+}
+
+/**
  *	ata_tf_load - send taskfile registers to host controller
  *	@ap: Port to which output is sent
  *	@tf: ATA taskfile register set
@@ -75,7 +133,6 @@ u8 ata_irq_on(struct ata_port *ap)
  *	LOCKING:
  *	Inherited from caller.
  */
-
 void ata_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
@@ -126,25 +183,6 @@ void ata_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
 }
 
 /**
- *	ata_exec_command - issue ATA command to host controller
- *	@ap: port to which command is being issued
- *	@tf: ATA taskfile register set
- *
- *	Issues ATA command, with proper synchronization with interrupt
- *	handler / other threads.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- */
-void ata_exec_command(struct ata_port *ap, const struct ata_taskfile *tf)
-{
-	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
-
-	iowrite8(tf->command, ap->ioaddr.command_addr);
-	ata_pause(ap);
-}
-
-/**
  *	ata_tf_read - input device's ATA taskfile shadow registers
  *	@ap: Port from which input is read
  *	@tf: ATA taskfile register set for storing input
@@ -185,169 +223,22 @@ void ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
 }
 
 /**
- *	ata_check_status - Read device status reg & clear interrupt
- *	@ap: port where the device is
- *
- *	Reads ATA taskfile status register for currently-selected device
- *	and return its value. This also clears pending interrupts
- *      from this device
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-u8 ata_check_status(struct ata_port *ap)
-{
-	return ioread8(ap->ioaddr.status_addr);
-}
-
-/**
- *	ata_altstatus - Read device alternate status reg
- *	@ap: port where the device is
- *
- *	Reads ATA taskfile alternate status register for
- *	currently-selected device and return its value.
- *
- *	Note: may NOT be used as the check_altstatus() entry in
- *	ata_port_operations.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-u8 ata_altstatus(struct ata_port *ap)
-{
-	if (ap->ops->check_altstatus)
-		return ap->ops->check_altstatus(ap);
-
-	return ioread8(ap->ioaddr.altstatus_addr);
-}
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
-	ap->ops->exec_command(ap, &qc->tf);
-}
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
-
-/**
- *	ata_bmdma_irq_clear - Clear PCI IDE BMDMA interrupt.
- *	@ap: Port associated with this ATA transaction.
- *
- *	Clear interrupt and error flags in DMA status register.
- *
- *	May be used as the irq_clear() entry in ata_port_operations.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- */
-void ata_bmdma_irq_clear(struct ata_port *ap)
-{
-	void __iomem *mmio = ap->ioaddr.bmdma_addr;
-
-	if (!mmio)
-		return;
-
-	iowrite8(ioread8(mmio + ATA_DMA_STATUS), mmio + ATA_DMA_STATUS);
-}
-
-/**
- *	ata_noop_irq_clear - Noop placeholder for irq_clear
- *	@ap: Port associated with this ATA transaction.
- */
-void ata_noop_irq_clear(struct ata_port *ap)
-{
-}
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
-
-/**
- *	ata_bmdma_stop - Stop PCI IDE BMDMA transfer
- *	@qc: Command we are ending DMA for
- *
- *	Clears the ATA_DMA_START flag in the dma control register
+ *	ata_exec_command - issue ATA command to host controller
+ *	@ap: port to which command is being issued
+ *	@tf: ATA taskfile register set
  *
- *	May be used as the bmdma_stop() entry in ata_port_operations.
+ *	Issues ATA command, with proper synchronization with interrupt
+ *	handler / other threads.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-void ata_bmdma_stop(struct ata_queued_cmd *qc)
+void ata_exec_command(struct ata_port *ap, const struct ata_taskfile *tf)
 {
-	struct ata_port *ap = qc->ap;
-	void __iomem *mmio = ap->ioaddr.bmdma_addr;
-
-	/* clear start/stop bit */
-	iowrite8(ioread8(mmio + ATA_DMA_CMD) & ~ATA_DMA_START,
-		 mmio + ATA_DMA_CMD);
+	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
 
-	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
-	ata_altstatus(ap);        /* dummy read */
+	iowrite8(tf->command, ap->ioaddr.command_addr);
+	ata_pause(ap);
 }
 
 /**
@@ -496,7 +387,6 @@ void ata_bmdma_post_internal_cmd(struct ata_queued_cmd *qc)
  *	LOCKING:
  *	Inherited from caller.
  */
-
 int ata_sff_port_start(struct ata_port *ap)
 {
 	if (ap->ioaddr.bmdma_addr)
@@ -504,20 +394,149 @@ int ata_sff_port_start(struct ata_port *ap)
 	return 0;
 }
 
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
+	ap->ops->exec_command(ap, &qc->tf);
+}
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
+	ata_altstatus(ap);        /* dummy read */
+}
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
+
+/**
+ *	ata_noop_irq_clear - Noop placeholder for irq_clear
+ *	@ap: Port associated with this ATA transaction.
+ */
+void ata_noop_irq_clear(struct ata_port *ap)
+{
+}
+
 #ifdef CONFIG_PCI
 
-static int ata_resources_present(struct pci_dev *pdev, int port)
+/**
+ *	ata_pci_clear_simplex	-	attempt to kick device out of simplex
+ *	@pdev: PCI device
+ *
+ *	Some PCI ATA devices report simplex mode but in fact can be told to
+ *	enter non simplex mode. This implements the necessary logic to
+ *	perform the task on such devices. Calling it on other devices will
+ *	have -undefined- behaviour.
+ */
+int ata_pci_clear_simplex(struct pci_dev *pdev)
 {
-	int i;
+	unsigned long bmdma = pci_resource_start(pdev, 4);
+	u8 simplex;
 
-	/* Check the PCI resources for this channel are enabled */
-	port = port * 2;
-	for (i = 0; i < 2; i ++) {
-		if (pci_resource_start(pdev, port + i) == 0 ||
-		    pci_resource_len(pdev, port + i) == 0)
-			return 0;
-	}
-	return 1;
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
+
+unsigned long ata_pci_default_filter(struct ata_device *adev, unsigned long xfer_mask)
+{
+	/* Filter out DMA modes if the device has been configured by
+	   the BIOS as PIO only */
+
+	if (adev->link->ap->ioaddr.bmdma_addr == NULL)
+		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
+	return xfer_mask;
 }
 
 /**
@@ -577,6 +596,20 @@ int ata_pci_init_bmdma(struct ata_host *host)
 	return 0;
 }
 
+static int ata_resources_present(struct pci_dev *pdev, int port)
+{
+	int i;
+
+	/* Check the PCI resources for this channel are enabled */
+	port = port * 2;
+	for (i = 0; i < 2; i ++) {
+		if (pci_resource_start(pdev, port + i) == 0 ||
+		    pci_resource_len(pdev, port + i) == 0)
+			return 0;
+	}
+	return 1;
+}
+
 /**
  *	ata_pci_init_sff_host - acquire native PCI ATA resources and init host
  *	@host: target ATA host
@@ -880,41 +913,5 @@ int ata_pci_init_one(struct pci_dev *pdev,
 	return rc;
 }
 
-/**
- *	ata_pci_clear_simplex	-	attempt to kick device out of simplex
- *	@pdev: PCI device
- *
- *	Some PCI ATA devices report simplex mode but in fact can be told to
- *	enter non simplex mode. This implements the necessary logic to
- *	perform the task on such devices. Calling it on other devices will
- *	have -undefined- behaviour.
- */
-
-int ata_pci_clear_simplex(struct pci_dev *pdev)
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
-
-unsigned long ata_pci_default_filter(struct ata_device *adev, unsigned long xfer_mask)
-{
-	/* Filter out DMA modes if the device has been configured by
-	   the BIOS as PIO only */
-
-	if (adev->link->ap->ioaddr.bmdma_addr == NULL)
-		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
-	return xfer_mask;
-}
-
 #endif /* CONFIG_PCI */
 
-- 
1.5.2.4

