From: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] Several recent libata commits
Date: Thu, 23 Mar 2006 00:36:36 -0500
Message-ID: <20060323053636.GA25772@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:46477 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932161AbWCWFgj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Mar 2006 00:36:39 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, achew@nvidia.com


Linus pulled the latest stuff (incl. Alan and Tejun's stuff) already.

The 'upstream' branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

contains the following updates:

 drivers/scsi/libata-bmdma.c |  234 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata-core.c  |  234 --------------------------------------------
 drivers/scsi/sata_nv.c      |  181 +++++++++++-----------------------
 drivers/scsi/sata_sil24.c   |   23 +---
 drivers/scsi/sata_uli.c     |   37 +++++-
 5 files changed, 333 insertions(+), 376 deletions(-)

Jeff Garzik:
      [libata sata_sil24] cleanups: use pci_iomap(), kzalloc()
      [libata sata_nv] cleanups: convert #defines to enums; remove in-file history
      [libata sata_nv] eliminate duplicate codepaths with iomap
      [libata sata_uli] kill scr_addr abuse
      [libata] Move some bmdma-specific code to libata-bmdma.c

diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index 96b4d21..a00a78b 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -418,6 +418,240 @@ u8 ata_altstatus(struct ata_port *ap)
 	return inb(ap->ioaddr.altstatus_addr);
 }
 
+/**
+ *	ata_bmdma_setup_mmio - Set up PCI IDE BMDMA transaction
+ *	@qc: Info associated with this ATA transaction.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
+static void ata_bmdma_setup_mmio (struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
+	u8 dmactl;
+	void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
+
+	/* load PRD table addr. */
+	mb();	/* make sure PRD table writes are visible to controller */
+	writel(ap->prd_dma, mmio + ATA_DMA_TABLE_OFS);
+
+	/* specify data direction, triple-check start bit is clear */
+	dmactl = readb(mmio + ATA_DMA_CMD);
+	dmactl &= ~(ATA_DMA_WR | ATA_DMA_START);
+	if (!rw)
+		dmactl |= ATA_DMA_WR;
+	writeb(dmactl, mmio + ATA_DMA_CMD);
+
+	/* issue r/w command */
+	ap->ops->exec_command(ap, &qc->tf);
+}
+
+/**
+ *	ata_bmdma_start_mmio - Start a PCI IDE BMDMA transaction
+ *	@qc: Info associated with this ATA transaction.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
+static void ata_bmdma_start_mmio (struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
+	u8 dmactl;
+
+	/* start host DMA transaction */
+	dmactl = readb(mmio + ATA_DMA_CMD);
+	writeb(dmactl | ATA_DMA_START, mmio + ATA_DMA_CMD);
+
+	/* Strictly, one may wish to issue a readb() here, to
+	 * flush the mmio write.  However, control also passes
+	 * to the hardware at this point, and it will interrupt
+	 * us when we are to resume control.  So, in effect,
+	 * we don't care when the mmio write flushes.
+	 * Further, a read of the DMA status register _immediately_
+	 * following the write may not be what certain flaky hardware
+	 * is expected, so I think it is best to not add a readb()
+	 * without first all the MMIO ATA cards/mobos.
+	 * Or maybe I'm just being paranoid.
+	 */
+}
+
+/**
+ *	ata_bmdma_setup_pio - Set up PCI IDE BMDMA transaction (PIO)
+ *	@qc: Info associated with this ATA transaction.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
+static void ata_bmdma_setup_pio (struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
+	u8 dmactl;
+
+	/* load PRD table addr. */
+	outl(ap->prd_dma, ap->ioaddr.bmdma_addr + ATA_DMA_TABLE_OFS);
+
+	/* specify data direction, triple-check start bit is clear */
+	dmactl = inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+	dmactl &= ~(ATA_DMA_WR | ATA_DMA_START);
+	if (!rw)
+		dmactl |= ATA_DMA_WR;
+	outb(dmactl, ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+
+	/* issue r/w command */
+	ap->ops->exec_command(ap, &qc->tf);
+}
+
+/**
+ *	ata_bmdma_start_pio - Start a PCI IDE BMDMA transaction (PIO)
+ *	@qc: Info associated with this ATA transaction.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
+static void ata_bmdma_start_pio (struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	u8 dmactl;
+
+	/* start host DMA transaction */
+	dmactl = inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+	outb(dmactl | ATA_DMA_START,
+	     ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+}
+
+
+/**
+ *	ata_bmdma_start - Start a PCI IDE BMDMA transaction
+ *	@qc: Info associated with this ATA transaction.
+ *
+ *	Writes the ATA_DMA_START flag to the DMA command register.
+ *
+ *	May be used as the bmdma_start() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+void ata_bmdma_start(struct ata_queued_cmd *qc)
+{
+	if (qc->ap->flags & ATA_FLAG_MMIO)
+		ata_bmdma_start_mmio(qc);
+	else
+		ata_bmdma_start_pio(qc);
+}
+
+
+/**
+ *	ata_bmdma_setup - Set up PCI IDE BMDMA transaction
+ *	@qc: Info associated with this ATA transaction.
+ *
+ *	Writes address of PRD table to device's PRD Table Address
+ *	register, sets the DMA control register, and calls
+ *	ops->exec_command() to start the transfer.
+ *
+ *	May be used as the bmdma_setup() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+void ata_bmdma_setup(struct ata_queued_cmd *qc)
+{
+	if (qc->ap->flags & ATA_FLAG_MMIO)
+		ata_bmdma_setup_mmio(qc);
+	else
+		ata_bmdma_setup_pio(qc);
+}
+
+
+/**
+ *	ata_bmdma_irq_clear - Clear PCI IDE BMDMA interrupt.
+ *	@ap: Port associated with this ATA transaction.
+ *
+ *	Clear interrupt and error flags in DMA status register.
+ *
+ *	May be used as the irq_clear() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
+void ata_bmdma_irq_clear(struct ata_port *ap)
+{
+	if (!ap->ioaddr.bmdma_addr)
+		return;
+
+	if (ap->flags & ATA_FLAG_MMIO) {
+		void __iomem *mmio =
+		      ((void __iomem *) ap->ioaddr.bmdma_addr) + ATA_DMA_STATUS;
+		writeb(readb(mmio), mmio);
+	} else {
+		unsigned long addr = ap->ioaddr.bmdma_addr + ATA_DMA_STATUS;
+		outb(inb(addr), addr);
+	}
+}
+
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
+ *	spin_lock_irqsave(host_set lock)
+ */
+
+u8 ata_bmdma_status(struct ata_port *ap)
+{
+	u8 host_stat;
+	if (ap->flags & ATA_FLAG_MMIO) {
+		void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
+		host_stat = readb(mmio + ATA_DMA_STATUS);
+	} else
+		host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+	return host_stat;
+}
+
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
+ *	spin_lock_irqsave(host_set lock)
+ */
+
+void ata_bmdma_stop(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	if (ap->flags & ATA_FLAG_MMIO) {
+		void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
+
+		/* clear start/stop bit */
+		writeb(readb(mmio + ATA_DMA_CMD) & ~ATA_DMA_START,
+			mmio + ATA_DMA_CMD);
+	} else {
+		/* clear start/stop bit */
+		outb(inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD) & ~ATA_DMA_START,
+			ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+	}
+
+	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
+	ata_altstatus(ap);        /* dummy read */
+}
+
 #ifdef CONFIG_PCI
 static struct ata_probe_ent *
 ata_probe_ent_alloc(struct device *dev, const struct ata_port_info *port)
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 0314abd..f3c115b 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4065,240 +4065,6 @@ unsigned int ata_qc_issue_prot(struct at
 }
 
 /**
- *	ata_bmdma_setup_mmio - Set up PCI IDE BMDMA transaction
- *	@qc: Info associated with this ATA transaction.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host_set lock)
- */
-
-static void ata_bmdma_setup_mmio (struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
-	u8 dmactl;
-	void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
-
-	/* load PRD table addr. */
-	mb();	/* make sure PRD table writes are visible to controller */
-	writel(ap->prd_dma, mmio + ATA_DMA_TABLE_OFS);
-
-	/* specify data direction, triple-check start bit is clear */
-	dmactl = readb(mmio + ATA_DMA_CMD);
-	dmactl &= ~(ATA_DMA_WR | ATA_DMA_START);
-	if (!rw)
-		dmactl |= ATA_DMA_WR;
-	writeb(dmactl, mmio + ATA_DMA_CMD);
-
-	/* issue r/w command */
-	ap->ops->exec_command(ap, &qc->tf);
-}
-
-/**
- *	ata_bmdma_start_mmio - Start a PCI IDE BMDMA transaction
- *	@qc: Info associated with this ATA transaction.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host_set lock)
- */
-
-static void ata_bmdma_start_mmio (struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
-	u8 dmactl;
-
-	/* start host DMA transaction */
-	dmactl = readb(mmio + ATA_DMA_CMD);
-	writeb(dmactl | ATA_DMA_START, mmio + ATA_DMA_CMD);
-
-	/* Strictly, one may wish to issue a readb() here, to
-	 * flush the mmio write.  However, control also passes
-	 * to the hardware at this point, and it will interrupt
-	 * us when we are to resume control.  So, in effect,
-	 * we don't care when the mmio write flushes.
-	 * Further, a read of the DMA status register _immediately_
-	 * following the write may not be what certain flaky hardware
-	 * is expected, so I think it is best to not add a readb()
-	 * without first all the MMIO ATA cards/mobos.
-	 * Or maybe I'm just being paranoid.
-	 */
-}
-
-/**
- *	ata_bmdma_setup_pio - Set up PCI IDE BMDMA transaction (PIO)
- *	@qc: Info associated with this ATA transaction.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host_set lock)
- */
-
-static void ata_bmdma_setup_pio (struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
-	u8 dmactl;
-
-	/* load PRD table addr. */
-	outl(ap->prd_dma, ap->ioaddr.bmdma_addr + ATA_DMA_TABLE_OFS);
-
-	/* specify data direction, triple-check start bit is clear */
-	dmactl = inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
-	dmactl &= ~(ATA_DMA_WR | ATA_DMA_START);
-	if (!rw)
-		dmactl |= ATA_DMA_WR;
-	outb(dmactl, ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
-
-	/* issue r/w command */
-	ap->ops->exec_command(ap, &qc->tf);
-}
-
-/**
- *	ata_bmdma_start_pio - Start a PCI IDE BMDMA transaction (PIO)
- *	@qc: Info associated with this ATA transaction.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host_set lock)
- */
-
-static void ata_bmdma_start_pio (struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	u8 dmactl;
-
-	/* start host DMA transaction */
-	dmactl = inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
-	outb(dmactl | ATA_DMA_START,
-	     ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
-}
-
-
-/**
- *	ata_bmdma_start - Start a PCI IDE BMDMA transaction
- *	@qc: Info associated with this ATA transaction.
- *
- *	Writes the ATA_DMA_START flag to the DMA command register.
- *
- *	May be used as the bmdma_start() entry in ata_port_operations.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host_set lock)
- */
-void ata_bmdma_start(struct ata_queued_cmd *qc)
-{
-	if (qc->ap->flags & ATA_FLAG_MMIO)
-		ata_bmdma_start_mmio(qc);
-	else
-		ata_bmdma_start_pio(qc);
-}
-
-
-/**
- *	ata_bmdma_setup - Set up PCI IDE BMDMA transaction
- *	@qc: Info associated with this ATA transaction.
- *
- *	Writes address of PRD table to device's PRD Table Address
- *	register, sets the DMA control register, and calls
- *	ops->exec_command() to start the transfer.
- *
- *	May be used as the bmdma_setup() entry in ata_port_operations.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host_set lock)
- */
-void ata_bmdma_setup(struct ata_queued_cmd *qc)
-{
-	if (qc->ap->flags & ATA_FLAG_MMIO)
-		ata_bmdma_setup_mmio(qc);
-	else
-		ata_bmdma_setup_pio(qc);
-}
-
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
- *	spin_lock_irqsave(host_set lock)
- */
-
-void ata_bmdma_irq_clear(struct ata_port *ap)
-{
-	if (!ap->ioaddr.bmdma_addr)
-		return;
-
-	if (ap->flags & ATA_FLAG_MMIO) {
-		void __iomem *mmio =
-		      ((void __iomem *) ap->ioaddr.bmdma_addr) + ATA_DMA_STATUS;
-		writeb(readb(mmio), mmio);
-	} else {
-		unsigned long addr = ap->ioaddr.bmdma_addr + ATA_DMA_STATUS;
-		outb(inb(addr), addr);
-	}
-}
-
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
- *	spin_lock_irqsave(host_set lock)
- */
-
-u8 ata_bmdma_status(struct ata_port *ap)
-{
-	u8 host_stat;
-	if (ap->flags & ATA_FLAG_MMIO) {
-		void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
-		host_stat = readb(mmio + ATA_DMA_STATUS);
-	} else
-		host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
-	return host_stat;
-}
-
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
- *	spin_lock_irqsave(host_set lock)
- */
-
-void ata_bmdma_stop(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	if (ap->flags & ATA_FLAG_MMIO) {
-		void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
-
-		/* clear start/stop bit */
-		writeb(readb(mmio + ATA_DMA_CMD) & ~ATA_DMA_START,
-			mmio + ATA_DMA_CMD);
-	} else {
-		/* clear start/stop bit */
-		outb(inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD) & ~ATA_DMA_START,
-			ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
-	}
-
-	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
-	ata_altstatus(ap);        /* dummy read */
-}
-
-/**
  *	ata_host_intr - Handle host interrupt for given (port, task)
  *	@ap: Port on which interrupt arrived (possibly...)
  *	@qc: Taskfile currently active in engine
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index e5b20c6..f77bf18 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -29,34 +29,6 @@
  *  NV-specific details such as register offsets, SATA phy location,
  *  hotplug info, etc.
  *
- *  0.10
- *     - Fixed spurious interrupts issue seen with the Maxtor 6H500F0 500GB
- *       drive.  Also made the check_hotplug() callbacks return whether there
- *       was a hotplug interrupt or not.  This was not the source of the
- *       spurious interrupts, but is the right thing to do anyway.
- *
- *  0.09
- *     - Fixed bug introduced by 0.08's MCP51 and MCP55 support.
- *
- *  0.08
- *     - Added support for MCP51 and MCP55.
- *
- *  0.07
- *     - Added support for RAID class code.
- *
- *  0.06
- *     - Added generic SATA support by using a pci_device_id that filters on
- *       the IDE storage class code.
- *
- *  0.03
- *     - Fixed a bug where the hotplug handlers for non-CK804/MCP04 were using
- *       mmio_base, which is only set for the CK804/MCP04 case.
- *
- *  0.02
- *     - Added support for CK804 SATA controller.
- *
- *  0.01
- *     - Initial revision.
  */
 
 #include <linux/config.h>
@@ -74,53 +46,55 @@
 #define DRV_NAME			"sata_nv"
 #define DRV_VERSION			"0.8"
 
-#define NV_PORTS			2
-#define NV_PIO_MASK			0x1f
-#define NV_MWDMA_MASK			0x07
-#define NV_UDMA_MASK			0x7f
-#define NV_PORT0_SCR_REG_OFFSET		0x00
-#define NV_PORT1_SCR_REG_OFFSET		0x40
-
-#define NV_INT_STATUS			0x10
-#define NV_INT_STATUS_CK804		0x440
-#define NV_INT_STATUS_PDEV_INT		0x01
-#define NV_INT_STATUS_PDEV_PM		0x02
-#define NV_INT_STATUS_PDEV_ADDED	0x04
-#define NV_INT_STATUS_PDEV_REMOVED	0x08
-#define NV_INT_STATUS_SDEV_INT		0x10
-#define NV_INT_STATUS_SDEV_PM		0x20
-#define NV_INT_STATUS_SDEV_ADDED	0x40
-#define NV_INT_STATUS_SDEV_REMOVED	0x80
-#define NV_INT_STATUS_PDEV_HOTPLUG	(NV_INT_STATUS_PDEV_ADDED | \
-					NV_INT_STATUS_PDEV_REMOVED)
-#define NV_INT_STATUS_SDEV_HOTPLUG	(NV_INT_STATUS_SDEV_ADDED | \
-					NV_INT_STATUS_SDEV_REMOVED)
-#define NV_INT_STATUS_HOTPLUG		(NV_INT_STATUS_PDEV_HOTPLUG | \
-					NV_INT_STATUS_SDEV_HOTPLUG)
-
-#define NV_INT_ENABLE			0x11
-#define NV_INT_ENABLE_CK804		0x441
-#define NV_INT_ENABLE_PDEV_MASK		0x01
-#define NV_INT_ENABLE_PDEV_PM		0x02
-#define NV_INT_ENABLE_PDEV_ADDED	0x04
-#define NV_INT_ENABLE_PDEV_REMOVED	0x08
-#define NV_INT_ENABLE_SDEV_MASK		0x10
-#define NV_INT_ENABLE_SDEV_PM		0x20
-#define NV_INT_ENABLE_SDEV_ADDED	0x40
-#define NV_INT_ENABLE_SDEV_REMOVED	0x80
-#define NV_INT_ENABLE_PDEV_HOTPLUG	(NV_INT_ENABLE_PDEV_ADDED | \
-					NV_INT_ENABLE_PDEV_REMOVED)
-#define NV_INT_ENABLE_SDEV_HOTPLUG	(NV_INT_ENABLE_SDEV_ADDED | \
-					NV_INT_ENABLE_SDEV_REMOVED)
-#define NV_INT_ENABLE_HOTPLUG		(NV_INT_ENABLE_PDEV_HOTPLUG | \
-					NV_INT_ENABLE_SDEV_HOTPLUG)
-
-#define NV_INT_CONFIG			0x12
-#define NV_INT_CONFIG_METHD		0x01 // 0 = INT, 1 = SMI
-
-// For PCI config register 20
-#define NV_MCP_SATA_CFG_20		0x50
-#define NV_MCP_SATA_CFG_20_SATA_SPACE_EN	0x04
+enum {
+	NV_PORTS			= 2,
+	NV_PIO_MASK			= 0x1f,
+	NV_MWDMA_MASK			= 0x07,
+	NV_UDMA_MASK			= 0x7f,
+	NV_PORT0_SCR_REG_OFFSET		= 0x00,
+	NV_PORT1_SCR_REG_OFFSET		= 0x40,
+
+	NV_INT_STATUS			= 0x10,
+	NV_INT_STATUS_CK804		= 0x440,
+	NV_INT_STATUS_PDEV_INT		= 0x01,
+	NV_INT_STATUS_PDEV_PM		= 0x02,
+	NV_INT_STATUS_PDEV_ADDED	= 0x04,
+	NV_INT_STATUS_PDEV_REMOVED	= 0x08,
+	NV_INT_STATUS_SDEV_INT		= 0x10,
+	NV_INT_STATUS_SDEV_PM		= 0x20,
+	NV_INT_STATUS_SDEV_ADDED	= 0x40,
+	NV_INT_STATUS_SDEV_REMOVED	= 0x80,
+	NV_INT_STATUS_PDEV_HOTPLUG	= (NV_INT_STATUS_PDEV_ADDED |
+					   NV_INT_STATUS_PDEV_REMOVED),
+	NV_INT_STATUS_SDEV_HOTPLUG	= (NV_INT_STATUS_SDEV_ADDED |
+					   NV_INT_STATUS_SDEV_REMOVED),
+	NV_INT_STATUS_HOTPLUG		= (NV_INT_STATUS_PDEV_HOTPLUG |
+					   NV_INT_STATUS_SDEV_HOTPLUG),
+
+	NV_INT_ENABLE			= 0x11,
+	NV_INT_ENABLE_CK804		= 0x441,
+	NV_INT_ENABLE_PDEV_MASK		= 0x01,
+	NV_INT_ENABLE_PDEV_PM		= 0x02,
+	NV_INT_ENABLE_PDEV_ADDED	= 0x04,
+	NV_INT_ENABLE_PDEV_REMOVED	= 0x08,
+	NV_INT_ENABLE_SDEV_MASK		= 0x10,
+	NV_INT_ENABLE_SDEV_PM		= 0x20,
+	NV_INT_ENABLE_SDEV_ADDED	= 0x40,
+	NV_INT_ENABLE_SDEV_REMOVED	= 0x80,
+	NV_INT_ENABLE_PDEV_HOTPLUG	= (NV_INT_ENABLE_PDEV_ADDED |
+					   NV_INT_ENABLE_PDEV_REMOVED),
+	NV_INT_ENABLE_SDEV_HOTPLUG	= (NV_INT_ENABLE_SDEV_ADDED |
+					   NV_INT_ENABLE_SDEV_REMOVED),
+	NV_INT_ENABLE_HOTPLUG		= (NV_INT_ENABLE_PDEV_HOTPLUG |
+					   NV_INT_ENABLE_SDEV_HOTPLUG),
+
+	NV_INT_CONFIG			= 0x12,
+	NV_INT_CONFIG_METHD		= 0x01, // 0 = INT, 1 = SMI
+
+	// For PCI config register 20
+	NV_MCP_SATA_CFG_20		= 0x50,
+	NV_MCP_SATA_CFG_20_SATA_SPACE_EN = 0x04,
+};
 
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static irqreturn_t nv_interrupt (int irq, void *dev_instance,
@@ -175,8 +149,6 @@ static const struct pci_device_id nv_pci
 	{ 0, } /* terminate list */
 };
 
-#define NV_HOST_FLAGS_SCR_MMIO	0x00000001
-
 struct nv_host_desc
 {
 	enum nv_host_type	host_type;
@@ -332,36 +304,23 @@ static irqreturn_t nv_interrupt (int irq
 
 static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
-	struct ata_host_set *host_set = ap->host_set;
-	struct nv_host *host = host_set->private_data;
-
 	if (sc_reg > SCR_CONTROL)
 		return 0xffffffffU;
 
-	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO)
-		return readl((void __iomem *)ap->ioaddr.scr_addr + (sc_reg * 4));
-	else
-		return inl(ap->ioaddr.scr_addr + (sc_reg * 4));
+	return ioread32((void __iomem *)ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
 static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
 {
-	struct ata_host_set *host_set = ap->host_set;
-	struct nv_host *host = host_set->private_data;
-
 	if (sc_reg > SCR_CONTROL)
 		return;
 
-	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO)
-		writel(val, (void __iomem *)ap->ioaddr.scr_addr + (sc_reg * 4));
-	else
-		outl(val, ap->ioaddr.scr_addr + (sc_reg * 4));
+	iowrite32(val, (void __iomem *)ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
 static void nv_host_stop (struct ata_host_set *host_set)
 {
 	struct nv_host *host = host_set->private_data;
-	struct pci_dev *pdev = to_pci_dev(host_set->dev);
 
 	// Disable hotplug event interrupts.
 	if (host->host_desc->disable_hotplug)
@@ -369,8 +328,7 @@ static void nv_host_stop (struct ata_hos
 
 	kfree(host);
 
-	if (host_set->mmio_base)
-		pci_iounmap(pdev, host_set->mmio_base);
+	ata_pci_host_stop(host_set);
 }
 
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
@@ -382,6 +340,7 @@ static int nv_init_one (struct pci_dev *
 	int pci_dev_busy = 0;
 	int rc;
 	u32 bar;
+	unsigned long base;
 
         // Make sure this is a SATA controller by counting the number of bars
         // (NVIDIA SATA controllers will always have six bars).  Otherwise,
@@ -426,31 +385,16 @@ static int nv_init_one (struct pci_dev *
 
 	probe_ent->private_data = host;
 
-	if (pci_resource_flags(pdev, 5) & IORESOURCE_MEM)
-		host->host_flags |= NV_HOST_FLAGS_SCR_MMIO;
-
-	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO) {
-		unsigned long base;
-
-		probe_ent->mmio_base = pci_iomap(pdev, 5, 0);
-		if (probe_ent->mmio_base == NULL) {
-			rc = -EIO;
-			goto err_out_free_host;
-		}
+	probe_ent->mmio_base = pci_iomap(pdev, 5, 0);
+	if (!probe_ent->mmio_base) {
+		rc = -EIO;
+		goto err_out_free_host;
+	}
 
-		base = (unsigned long)probe_ent->mmio_base;
+	base = (unsigned long)probe_ent->mmio_base;
 
-		probe_ent->port[0].scr_addr =
-			base + NV_PORT0_SCR_REG_OFFSET;
-		probe_ent->port[1].scr_addr =
-			base + NV_PORT1_SCR_REG_OFFSET;
-	} else {
-
-		probe_ent->port[0].scr_addr =
-			pci_resource_start(pdev, 5) | NV_PORT0_SCR_REG_OFFSET;
-		probe_ent->port[1].scr_addr =
-			pci_resource_start(pdev, 5) | NV_PORT1_SCR_REG_OFFSET;
-	}
+	probe_ent->port[0].scr_addr = base + NV_PORT0_SCR_REG_OFFSET;
+	probe_ent->port[1].scr_addr = base + NV_PORT1_SCR_REG_OFFSET;
 
 	pci_set_master(pdev);
 
@@ -467,8 +411,7 @@ static int nv_init_one (struct pci_dev *
 	return 0;
 
 err_out_iounmap:
-	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO)
-		pci_iounmap(pdev, probe_ent->mmio_base);
+	pci_iounmap(pdev, probe_ent->mmio_base);
 err_out_free_host:
 	kfree(host);
 err_out_free_ent:
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 5d01e5c..3efebea 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -842,9 +842,10 @@ static void sil24_port_stop(struct ata_p
 static void sil24_host_stop(struct ata_host_set *host_set)
 {
 	struct sil24_host_priv *hpriv = host_set->private_data;
+	struct pci_dev *pdev = to_pci_dev(host_set->dev);
 
-	iounmap(hpriv->host_base);
-	iounmap(hpriv->port_base);
+	pci_iounmap(pdev, hpriv->host_base);
+	pci_iounmap(pdev, hpriv->port_base);
 	kfree(hpriv);
 }
 
@@ -871,26 +872,23 @@ static int sil24_init_one(struct pci_dev
 		goto out_disable;
 
 	rc = -ENOMEM;
-	/* ioremap mmio registers */
-	host_base = ioremap(pci_resource_start(pdev, 0),
-			    pci_resource_len(pdev, 0));
+	/* map mmio registers */
+	host_base = pci_iomap(pdev, 0, 0);
 	if (!host_base)
 		goto out_free;
-	port_base = ioremap(pci_resource_start(pdev, 2),
-			    pci_resource_len(pdev, 2));
+	port_base = pci_iomap(pdev, 2, 0);
 	if (!port_base)
 		goto out_free;
 
 	/* allocate & init probe_ent and hpriv */
-	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	probe_ent = kzalloc(sizeof(*probe_ent), GFP_KERNEL);
 	if (!probe_ent)
 		goto out_free;
 
-	hpriv = kmalloc(sizeof(*hpriv), GFP_KERNEL);
+	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
 	if (!hpriv)
 		goto out_free;
 
-	memset(probe_ent, 0, sizeof(*probe_ent));
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
@@ -907,7 +905,6 @@ static int sil24_init_one(struct pci_dev
 	probe_ent->mmio_base = port_base;
 	probe_ent->private_data = hpriv;
 
-	memset(hpriv, 0, sizeof(*hpriv));
 	hpriv->host_base = host_base;
 	hpriv->port_base = port_base;
 
@@ -1011,9 +1008,9 @@ static int sil24_init_one(struct pci_dev
 
  out_free:
 	if (host_base)
-		iounmap(host_base);
+		pci_iounmap(pdev, host_base);
 	if (port_base)
-		iounmap(port_base);
+		pci_iounmap(pdev, port_base);
 	kfree(probe_ent);
 	kfree(hpriv);
 	pci_release_regions(pdev);
diff --git a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
index 8f50257..7ac5a5f 100644
--- a/drivers/scsi/sata_uli.c
+++ b/drivers/scsi/sata_uli.c
@@ -44,6 +44,8 @@ enum {
 	uli_5287		= 1,
 	uli_5281		= 2,
 
+	uli_max_ports		= 4,
+
 	/* PCI configuration registers */
 	ULI5287_BASE		= 0x90, /* sata0 phy SCR registers */
 	ULI5287_OFFS		= 0x10, /* offset from sata0->sata1 phy regs */
@@ -51,6 +53,10 @@ enum {
 	ULI5281_OFFS		= 0x60, /* offset from sata0->sata1 phy regs */
 };
 
+struct uli_priv {
+	unsigned int		scr_cfg_addr[uli_max_ports];
+};
+
 static int uli_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static u32 uli_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void uli_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
@@ -137,7 +143,8 @@ MODULE_VERSION(DRV_VERSION);
 
 static unsigned int get_scr_cfg_addr(struct ata_port *ap, unsigned int sc_reg)
 {
-	return ap->ioaddr.scr_addr + (4 * sc_reg);
+	struct uli_priv *hpriv = ap->host_set->private_data;
+	return hpriv->scr_cfg_addr[ap->port_no] + (4 * sc_reg);
 }
 
 static u32 uli_scr_cfg_read (struct ata_port *ap, unsigned int sc_reg)
@@ -182,6 +189,7 @@ static int uli_init_one (struct pci_dev 
 	int rc;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
 	int pci_dev_busy = 0;
+	struct uli_priv *hpriv;
 
 	if (!printed_version++)
 		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
@@ -210,10 +218,18 @@ static int uli_init_one (struct pci_dev 
 		goto err_out_regions;
 	}
 
+	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
+	if (!hpriv) {
+		rc = -ENOMEM;
+		goto err_out_probe_ent;
+	}
+
+	probe_ent->private_data = hpriv;
+
 	switch (board_idx) {
 	case uli_5287:
-		probe_ent->port[0].scr_addr = ULI5287_BASE;
-		probe_ent->port[1].scr_addr = ULI5287_BASE + ULI5287_OFFS;
+		hpriv->scr_cfg_addr[0] = ULI5287_BASE;
+		hpriv->scr_cfg_addr[1] = ULI5287_BASE + ULI5287_OFFS;
        		probe_ent->n_ports = 4;
 
        		probe_ent->port[2].cmd_addr = pci_resource_start(pdev, 0) + 8;
@@ -221,27 +237,27 @@ static int uli_init_one (struct pci_dev 
 		probe_ent->port[2].ctl_addr =
 			(pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS) + 4;
 		probe_ent->port[2].bmdma_addr = pci_resource_start(pdev, 4) + 16;
-		probe_ent->port[2].scr_addr = ULI5287_BASE + ULI5287_OFFS*4;
+		hpriv->scr_cfg_addr[2] = ULI5287_BASE + ULI5287_OFFS*4;
 
 		probe_ent->port[3].cmd_addr = pci_resource_start(pdev, 2) + 8;
 		probe_ent->port[3].altstatus_addr =
 		probe_ent->port[3].ctl_addr =
 			(pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS) + 4;
 		probe_ent->port[3].bmdma_addr = pci_resource_start(pdev, 4) + 24;
-		probe_ent->port[3].scr_addr = ULI5287_BASE + ULI5287_OFFS*5;
+		hpriv->scr_cfg_addr[3] = ULI5287_BASE + ULI5287_OFFS*5;
 
 		ata_std_ports(&probe_ent->port[2]);
 		ata_std_ports(&probe_ent->port[3]);
 		break;
 
 	case uli_5289:
-		probe_ent->port[0].scr_addr = ULI5287_BASE;
-		probe_ent->port[1].scr_addr = ULI5287_BASE + ULI5287_OFFS;
+		hpriv->scr_cfg_addr[0] = ULI5287_BASE;
+		hpriv->scr_cfg_addr[1] = ULI5287_BASE + ULI5287_OFFS;
 		break;
 
 	case uli_5281:
-		probe_ent->port[0].scr_addr = ULI5281_BASE;
-		probe_ent->port[1].scr_addr = ULI5281_BASE + ULI5281_OFFS;
+		hpriv->scr_cfg_addr[0] = ULI5281_BASE;
+		hpriv->scr_cfg_addr[1] = ULI5281_BASE + ULI5281_OFFS;
 		break;
 
 	default:
@@ -258,9 +274,10 @@ static int uli_init_one (struct pci_dev 
 
 	return 0;
 
+err_out_probe_ent:
+	kfree(probe_ent);
 err_out_regions:
 	pci_release_regions(pdev);
-
 err_out:
 	if (!pci_dev_busy)
 		pci_disable_device(pdev);
