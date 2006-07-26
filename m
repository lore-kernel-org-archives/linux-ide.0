From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 6/6] ahci: implement Power Management support
Date: Wed, 26 Jul 2006 15:59:26 +0900
Message-ID: <11538971661674-git-send-email-htejun@gmail.com>
References: <11538971651205-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:46947 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030445AbWGZG7f (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 Jul 2006 02:59:35 -0400
Received: by py-out-1112.google.com with SMTP id t32so3362778pyc
        for <linux-ide@vger.kernel.org>; Tue, 25 Jul 2006 23:59:35 -0700 (PDT)
In-Reply-To: <11538971651205-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>, Zhao@htj.dyndns.org, Forrest <forrest.zhao@intel.com>

Implement power management support.

Original implementation is from Zhao, Forrest <forrest.zhao@intel.com>

Signed-off-by: Tejun Heo <htejun@gmail.com>
Signed-off-by: Zhao, Forrest <forrest.zhao@intel.com>

---

 drivers/scsi/ahci.c |   84 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 84 insertions(+), 0 deletions(-)

4513d4761b48bca3025af0832d517f6b913061f9
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index a9e0c5f..909a4dc 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -215,6 +215,10 @@ static void ahci_freeze(struct ata_port 
 static void ahci_thaw(struct ata_port *ap);
 static void ahci_error_handler(struct ata_port *ap);
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc);
+static int ahci_port_suspend(struct ata_port *ap, pm_message_t mesg);
+static int ahci_port_resume(struct ata_port *ap);
+static int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
+static int ahci_pci_device_resume(struct pci_dev *pdev);
 static void ahci_remove_one (struct pci_dev *pdev);
 
 static struct scsi_host_template ahci_sht = {
@@ -234,6 +238,8 @@ static struct scsi_host_template ahci_sh
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+	.suspend		= ata_scsi_device_suspend,
+	.resume			= ata_scsi_device_resume,
 };
 
 static const struct ata_port_operations ahci_ops = {
@@ -260,6 +266,9 @@ static const struct ata_port_operations 
 	.error_handler		= ahci_error_handler,
 	.post_internal_cmd	= ahci_post_internal_cmd,
 
+	.port_suspend		= ahci_port_suspend,
+	.port_resume		= ahci_port_resume,
+
 	.port_start		= ahci_port_start,
 	.port_stop		= ahci_port_stop,
 };
@@ -361,6 +370,8 @@ static struct pci_driver ahci_pci_driver
 	.name			= DRV_NAME,
 	.id_table		= ahci_pci_tbl,
 	.probe			= ahci_init_one,
+	.suspend		= ahci_pci_device_suspend,
+	.resume			= ahci_pci_device_resume,
 	.remove			= ahci_remove_one,
 };
 
@@ -1199,6 +1210,79 @@ static void ahci_post_internal_cmd(struc
 	}
 }
 
+static int ahci_port_suspend(struct ata_port *ap, pm_message_t mesg)
+{
+	struct ahci_host_priv *hpriv = ap->host_set->private_data;
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	const char *emsg = NULL;
+	int rc;
+
+	rc = ahci_deinit_port(port_mmio, hpriv->cap, &emsg);
+	if (rc) {
+		ata_port_printk(ap, KERN_ERR, "%s (%d)\n", emsg, rc);
+		ahci_init_port(port_mmio, hpriv->cap,
+			       pp->cmd_slot_dma, pp->rx_fis_dma);
+	}
+
+	return rc;
+}
+
+static int ahci_port_resume(struct ata_port *ap)
+{
+	struct ahci_port_priv *pp = ap->private_data;
+	struct ahci_host_priv *hpriv = ap->host_set->private_data;
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+
+	ahci_init_port(port_mmio, hpriv->cap, pp->cmd_slot_dma, pp->rx_fis_dma);
+
+	return 0;
+}
+
+static int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
+{
+	struct ata_host_set *host_set = dev_get_drvdata(&pdev->dev);
+	void __iomem *mmio = host_set->mmio_base;
+	u32 ctl;
+
+	if (mesg.event == PM_EVENT_SUSPEND) {
+		/* AHCI spec rev1.1 section 8.3.3:
+		 * Software must disable interrupts prior to requesting a
+		 * transition of the HBA to D3 state.
+		 */
+		ctl = readl(mmio + HOST_CTL);
+		ctl &= ~HOST_IRQ_EN;
+		writel(ctl, mmio + HOST_CTL);
+		readl(mmio + HOST_CTL); /* flush */
+	}
+
+	return ata_pci_device_suspend(pdev, mesg);
+}
+
+static int ahci_pci_device_resume(struct pci_dev *pdev)
+{
+	struct ata_host_set *host_set = dev_get_drvdata(&pdev->dev);
+	struct ahci_host_priv *hpriv = host_set->private_data;
+	void __iomem *mmio = host_set->mmio_base;
+	int rc;
+
+	ata_pci_device_do_resume(pdev);
+
+	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
+		rc = ahci_reset_controller(mmio, pdev);
+		if (rc)
+			return rc;
+
+		ahci_init_controller(mmio, pdev, host_set->n_ports, hpriv->cap);
+	}
+
+	ata_host_set_resume(host_set);
+
+	return 0;
+}
+
 static int ahci_port_start(struct ata_port *ap)
 {
 	struct device *dev = ap->host_set->dev;
-- 
1.3.2


