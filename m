From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH 6/6] Implement the AHCI suspend/resume
Date: Mon, 10 Jul 2006 15:34:59 +0800
Message-ID: <1152516899.7132.276.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42572 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751277AbWGJHsX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Jul 2006 03:48:23 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, htejun@gmail.com, hare@suse.de, axboe@suse.de
Cc: linux-ide@vger.kernel.org

This patch implements the AHCI suspend/resume.


Signed-off-by: Forrest Zhao <forrest.zhaot@intel.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Jens Axboe <axboe@suse.de>


---

 drivers/scsi/ahci.c |  127 ++++++++++++++++++++++++++++++++++++++++++++
+++++++
 1 files changed, 127 insertions(+), 0 deletions(-)

6fd581dceefd2f40212c468a3e0c7c49c60c0500
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index dc76798..28e1419 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -221,9 +221,12 @@ static void ahci_freeze(struct ata_port 
 static void ahci_thaw(struct ata_port *ap);
 static void ahci_error_handler(struct ata_port *ap);
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc);
+static int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t
state);
+static int ahci_pci_device_resume(struct pci_dev *pdev);
 static int ahci_port_standby(void __iomem *port_mmio, u32 cap);
 static int ahci_port_spinup(void __iomem *port_mmio, u32 cap);
 static int ahci_port_suspend(struct ata_port *ap, pm_message_t state);
+static int ahci_port_resume(struct ata_port *ap);
 static void ahci_remove_one (struct pci_dev *pdev);
 
 static struct scsi_host_template ahci_sht = {
@@ -243,6 +246,8 @@ static struct scsi_host_template ahci_sh
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static const struct ata_port_operations ahci_ops = {
@@ -371,6 +376,8 @@ static struct pci_driver ahci_pci_driver
 	.id_table		= ahci_pci_tbl,
 	.probe			= ahci_init_one,
 	.remove			= ahci_remove_one,
+	.suspend		= ahci_pci_device_suspend,
+	.resume			= ahci_pci_device_resume,
 };
 
 
@@ -507,6 +514,57 @@ static int ahci_port_suspend(struct ata_
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
@@ -1022,6 +1080,75 @@ static unsigned int ahci_fill_sg(struct 
 	return n_sg;
 }
 
+int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct ata_host_set *host_set = dev_get_drvdata(&pdev->dev);
+	void __iomem *mmio = host_set->mmio_base;
+	u32 tmp;
+	int i;
+
+	/* First suspend all ports */
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap;
+
+		ap = host_set->ports[i];
+		ahci_port_suspend(ap, state);
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
+	ata_pci_device_do_suspend(pdev, state);
+
+	return 0;
+}
+
+int ahci_pci_device_resume(struct pci_dev *pdev)
+{
+	struct device *dev = pci_dev_to_dev(pdev);
+	struct ata_host_set *host_set = dev_get_drvdata(dev);
+	void __iomem *mmio = host_set->mmio_base;
+	struct ata_port *ap;
+	u32 i, tmp, irq_stat;
+
+	tmp = readl(mmio + HOST_CTL);
+	if (!(tmp & HOST_AHCI_EN)) {
+		tmp |= HOST_AHCI_EN;
+		writel(tmp, mmio + HOST_CTL);
+		tmp = readl(mmio + HOST_CTL);
+	}
+
+	ata_pci_device_do_resume(pdev);
+
+	/* Resume all ports */
+	for (i = 0; i < host_set->n_ports; i++) {
+		ap = host_set->ports[i];
+		ahci_port_resume(ap);
+	}
+
+	/*
+	 * Clear interrupt status and enable interrupt
+	 */
+	if (!(tmp & HOST_IRQ_EN)) {
+		irq_stat = readl(mmio + HOST_IRQ_STAT);
+		if (irq_stat)
+			writel(irq_stat, mmio + HOST_IRQ_STAT);
+		tmp |= HOST_IRQ_EN;
+		writel(tmp, mmio + HOST_CTL);
+		tmp = readl(mmio + HOST_CTL);
+	}
+
+	return 0;
+}
+
 static void ahci_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-- 
1.2.6

