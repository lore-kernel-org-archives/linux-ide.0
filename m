From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH 6/6] Implement the AHCI suspend/resume
Date: Fri, 02 Jun 2006 15:46:19 +0800
Message-ID: <1149234379.13451.59.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:65419 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751286AbWFBH6C (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jun 2006 03:58:02 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, hare@suse.de, axboe@suse.de, htejun@gmail.com, jeremy@goop.org, lkml@rtr.ca
Cc: linux-ide@vger.kernel.org

This patch implements the AHCI suspend/resume.
It puts the port suspend/resume operations in 
ahci_pci_device_suspend/resume(), which is in conformance with
Jeff's idea of host<->bus<->device suspend/resume sequence.


Signed-off-by: Forrest Zhao <forrest.zhao@intel.com>

---

 drivers/scsi/ahci.c |  157 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 156 insertions(+), 1 deletions(-)

a68fb19b6f0d03d4052d02f1288ccb3e5902c50e
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 8928170..b2c94ed 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -188,6 +188,7 @@ struct ahci_host_priv {
 	unsigned long		flags;
 	u32			cap;	/* cache of HOST_CAP register */
 	u32			port_map; /* cache of HOST_PORTS_IMPL reg */
+	u32			dev_map; /* connected devices */
 };
 
 struct ahci_port_priv {
@@ -217,6 +218,8 @@ static void ahci_port_stop(struct ata_po
 static int ahci_port_standby(void __iomem *port_mmio, u32 cap);
 static int ahci_port_spinup(void __iomem *port_mmio, u32 cap);
 static int ahci_port_suspend(struct ata_port *ap, pm_message_t state);
+static int ahci_port_resume(struct ata_port *ap);
+static void ahci_port_disable(struct ata_port *ap);
 static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static u8 ahci_check_status(struct ata_port *ap);
@@ -224,6 +227,8 @@ static void ahci_freeze(struct ata_port 
 static void ahci_thaw(struct ata_port *ap);
 static void ahci_error_handler(struct ata_port *ap);
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc);
+static int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t state);
+static int ahci_pci_device_resume(struct pci_dev *pdev);
 static void ahci_remove_one (struct pci_dev *pdev);
 
 static struct scsi_host_template ahci_sht = {
@@ -242,10 +247,12 @@ static struct scsi_host_template ahci_sh
 	.dma_boundary		= AHCI_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static const struct ata_port_operations ahci_ops = {
-	.port_disable		= ata_port_disable,
+	.port_disable		= ahci_port_disable,
 
 	.check_status		= ahci_check_status,
 	.check_altstatus	= ahci_check_status,
@@ -346,6 +353,8 @@ static struct pci_driver ahci_pci_driver
 	.id_table		= ahci_pci_tbl,
 	.probe			= ahci_init_one,
 	.remove			= ahci_remove_one,
+	.suspend		= ahci_pci_device_suspend,
+	.resume			= ahci_pci_device_resume,
 };
 

@@ -482,6 +491,81 @@ static int ahci_port_suspend(struct ata_
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
+
+		if ((hpriv->dev_map >> (ap->port_no + 1)) == 0) {
+			/*
+			 * Enable interrupts if this was the last port
+			 */
+			ata_port_printk(ap, KERN_INFO, "Enable interrupts\n");
+
+			irq_stat = readl(mmio + HOST_IRQ_STAT);
+			if (irq_stat)
+				writel(irq_stat, mmio + HOST_IRQ_STAT);
+
+			tmp |= HOST_IRQ_EN;
+			writel(tmp, mmio + HOST_CTL);
+			(void) readl(mmio + HOST_CTL);
+		}
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
+static void ahci_port_disable(struct ata_port *ap)
+{
+	struct ahci_host_priv *hpriv = ap->host_set->private_data;
+
+	ata_port_disable(ap);
+
+	hpriv->dev_map &= ~(1 << ap->port_no);
+}
+
 static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg_in)
 {
 	unsigned int sc_reg;
@@ -945,6 +1029,7 @@ static int ahci_hardreset(struct ata_por
 static void ahci_postreset(struct ata_port *ap, unsigned int *class)
 {
 	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	struct ahci_host_priv *hpriv = ap->host_set->private_data;
 	u32 new_tmp, tmp;
 
 	ata_std_postreset(ap, class);
@@ -959,6 +1044,75 @@ static void ahci_postreset(struct ata_po
 		writel(new_tmp, port_mmio + PORT_CMD);
 		readl(port_mmio + PORT_CMD); /* flush */
 	}
+
+	if (*class != ATA_DEV_NONE)
+		hpriv->dev_map |= (1 << ap->port_no);
+}
+
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
+	u32 tmp;
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
+	return rc;
 }
 
 static int ahci_probe_reset(struct ata_port *ap, unsigned int *classes)
@@ -1353,6 +1507,7 @@ static int ahci_host_init(struct ata_pro
 
 	hpriv->cap = readl(mmio + HOST_CAP);
 	hpriv->port_map = readl(mmio + HOST_PORTS_IMPL);
+	hpriv->dev_map = 0;
 	probe_ent->n_ports = (hpriv->cap & 0x1f) + 1;
 
 	VPRINTK("cap 0x%x  port_map 0x%x  n_ports %d\n",
-- 
1.2.6
