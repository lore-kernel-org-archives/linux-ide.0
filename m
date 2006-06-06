From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH 6/6] Implement the AHCI suspend/resume
Date: Tue, 06 Jun 2006 18:17:35 +0800
Message-ID: <1149589055.29552.62.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:62844 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750775AbWFFK30 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Jun 2006 06:29:26 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, hare@suse.de, axboe@suse.de, htejun@gmail.com, jeremy@goop.org, lkml@rtr.ca
Cc: linux-ide@vger.kernel.org

This patch implements the AHCI suspend/resume.
It puts the port suspend/resume operations in
ahci_pci_device_suspend/resume(), which is in conformance with
Jeff's idea of host<->bus<->device suspend/resume sequence.

Signed-off-by: Forrest Zhao <forrest.zhaot@intel.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Jens Axboe <axboe@suse.de>

---

 drivers/scsi/ahci.c |  137 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 137 insertions(+), 0 deletions(-)

471c6e864d2b016917d54bddf4d023fa2df33423
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 4175ff6..ac41678 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -216,6 +216,7 @@ static void ahci_port_stop(struct ata_po
 static int ahci_port_standby(void __iomem *port_mmio, u32 cap);
 static int ahci_port_spinup(void __iomem *port_mmio, u32 cap);
 static int ahci_port_suspend(struct ata_port *ap, pm_message_t state);
+static int ahci_port_resume(struct ata_port *ap);
 static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static u8 ahci_check_status(struct ata_port *ap);
@@ -223,6 +224,8 @@ static void ahci_freeze(struct ata_port 
 static void ahci_thaw(struct ata_port *ap);
 static void ahci_error_handler(struct ata_port *ap);
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc);
+static int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t state);
+static int ahci_pci_device_resume(struct pci_dev *pdev);
 static void ahci_remove_one (struct pci_dev *pdev);
 
 static struct scsi_host_template ahci_sht = {
@@ -241,6 +244,8 @@ static struct scsi_host_template ahci_sh
 	.dma_boundary		= AHCI_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static const struct ata_port_operations ahci_ops = {
@@ -345,6 +350,8 @@ static struct pci_driver ahci_pci_driver
 	.id_table		= ahci_pci_tbl,
 	.probe			= ahci_init_one,
 	.remove			= ahci_remove_one,
+	.suspend		= ahci_pci_device_suspend,
+	.resume			= ahci_pci_device_resume,
 };
 

@@ -481,6 +488,57 @@ static int ahci_port_suspend(struct ata_
 	return rc;
 }
 
+static int ahci_port_resume(struct ata_port *ap)
+{
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	struct ahci_host_priv *hpriv = ap->host_set->private_data;
+	struct ahci_port_priv *pp = ap->private_data;
+	int rc;
+	u32 tmp;
+
+	/*
+	 * Enable FIS reception
+	 */
+	ahci_start_fis_rx(port_mmio, pp, hpriv);
+
+	rc = ahci_port_spinup(port_mmio, hpriv->cap);
+	if (rc)
+		ata_port_printk(ap, KERN_WARNING, "Could not spinup device"
+				" (%d)\n", rc);
+
+	/*
+	 * Clear error status
+	 */
+	tmp = readl(port_mmio + PORT_SCR_ERR);
+	writel(tmp, port_mmio + PORT_SCR_ERR);
+	/*
+	 * Clear interrupt status
+	 */
+	tmp = readl(mmio + HOST_CTL);
+	if (!(tmp & HOST_IRQ_EN)) {
+		u32 irq_stat;
+
+		/* ack any pending irq events for this port */
+		irq_stat = readl(port_mmio + PORT_IRQ_STAT);
+		if (irq_stat)
+			writel(irq_stat, port_mmio + PORT_IRQ_STAT);
+
+		/* set irq mask (enables interrupts) */
+		writel(DEF_PORT_IRQ, port_mmio + PORT_IRQ_MASK);
+	}
+
+	/*
+	 * Enable DMA
+	 */
+	rc = ahci_start_engine(port_mmio);
+	if (rc)
+		ata_port_printk(ap, KERN_WARNING, "Can't start DMA engine"
+				" (%d)\n", rc);
+
+	return rc;
+}
+
 static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg_in)
 {
 	unsigned int sc_reg;
@@ -935,6 +993,85 @@ static void ahci_postreset(struct ata_po
 	}
 }
 
+int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct device *dev = pci_dev_to_dev(pdev);
+	struct ata_host_set *host_set = dev_get_drvdata(dev);
+	void __iomem *mmio = host_set->mmio_base;
+	int rc, i;
+	u32 tmp;
+	struct ata_port *ap;
+
+	/* First suspend all ports */
+	for (i = 0; i < host_set->n_ports; i++) {
+		ap = host_set->ports[i];
+
+		rc = ahci_port_suspend(ap, state);
+		if (rc)
+			return rc;
+	}
+
+	/*
+	 * AHCI spec rev1.1 section 8.3.3:
+	 * Software must disable interrupts prior to
+	 * requesting a transition of the HBA to
+	 * D3 state.
+	 */
+	tmp = readl(mmio + HOST_CTL);
+	tmp &= ~HOST_IRQ_EN;
+	writel(tmp, mmio + HOST_CTL);
+	tmp = readl(mmio + HOST_CTL); /* flush */
+
+	return ata_pci_device_suspend(pdev, state);
+}
+
+int ahci_pci_device_resume(struct pci_dev *pdev)
+{
+	struct device *dev = pci_dev_to_dev(pdev);
+	struct ata_host_set *host_set = dev_get_drvdata(dev);
+	void __iomem *mmio = host_set->mmio_base;
+	u32 tmp, irq_stat;
+	struct ata_port *ap;
+	int rc = 0, i;
+
+	/*
+	 * Enabling AHCI mode
+	 */
+	tmp = readl(mmio + HOST_CTL);
+	if (!(tmp & HOST_AHCI_EN)) {
+		tmp |= HOST_AHCI_EN;
+		writel(tmp, mmio + HOST_CTL);
+		tmp = readl(mmio + HOST_CTL);
+	}
+
+	rc = ata_pci_device_resume(pdev);
+	if (rc)
+		return rc;
+
+	/* Resume all ports */
+	for (i = 0; i < host_set->n_ports; i++) {
+		ap = host_set->ports[i];
+		rc = ahci_port_resume(ap);
+		if (rc)
+			break;
+	}
+
+	/*
+	 * Clear interrupt status and enable interrupt
+	 */
+	if (!(tmp & HOST_IRQ_EN)) {
+		irq_stat = readl(mmio + HOST_IRQ_STAT);
+		if (irq_stat)
+			writel(irq_stat, mmio + HOST_IRQ_STAT);
+
+		tmp |= HOST_IRQ_EN;
+		writel(tmp, mmio + HOST_CTL);
+		tmp = readl(mmio + HOST_CTL);
+	}
+
+	return 0;
+}
+
 static int ahci_probe_reset(struct ata_port *ap, unsigned int *classes)
 {
 	if ((ap->flags & AHCI_FLAG_RESET_NEEDS_CLO) &&
-- 
1.2.6
