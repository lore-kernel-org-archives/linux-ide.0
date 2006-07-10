From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH 4/6] The definition of ahci_port_suspend()
Date: Mon, 10 Jul 2006 11:35:20 +0800
Message-ID: <1152502520.7132.269.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:55648 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1161327AbWGJDsl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 9 Jul 2006 23:48:41 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, htejun@gmail.com, hare@suse.de, axboe@suse.de
Cc: linux-ide@vger.kernel.org

Add the definition of ahci_port_suspend(), which will be used to suspend
a port.

Signed-off-by: Forrest Zhao <forrest.zhaot@intel.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Jens Axboe <axboe@suse.de>


---

 drivers/scsi/ahci.c |   35 ++++++++++++++++++++++++++++++++++-
 1 files changed, 34 insertions(+), 1 deletions(-)

cc19430967817d0354c92a7b1d1a1cef87cc449f
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 6edc7c8..fc2c879 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -223,6 +223,7 @@ static void ahci_error_handler(struct at
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc);
 static int ahci_port_standby(void __iomem *port_mmio, u32 cap);
 static int ahci_port_spinup(void __iomem *port_mmio, u32 cap);
+static int ahci_port_suspend(struct ata_port *ap, pm_message_t state);
 static void ahci_remove_one (struct pci_dev *pdev);
 
 static struct scsi_host_template ahci_sht = {
@@ -459,7 +460,6 @@ static int ahci_port_start(struct ata_po
 	return 0;
 }
 
-
 static void ahci_port_stop(struct ata_port *ap)
 {
 	struct device *dev = ap->host_set->dev;
@@ -485,6 +485,39 @@ static void ahci_port_stop(struct ata_po
 	kfree(pp);
 }
 
+static int ahci_port_suspend(struct ata_port *ap, pm_message_t state)
+{
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	struct ahci_host_priv *hpriv = ap->host_set->private_data;
+	int rc;
+
+	/*
+	 * Disable DMA
+	 */
+	rc = ahci_stop_engine(port_mmio);
+	if (rc) {
+		ata_port_printk(ap, KERN_WARNING, "DMA engine busy\n");
+		return rc;
+	}
+
+	/*
+	 * Disable FIS reception
+	 */
+	rc = ahci_stop_fis_rx(port_mmio);
+	if (rc)
+		ata_port_printk(ap, KERN_WARNING, "FIS RX still running"
+				" (%d)\n", rc);
+
+	/*
+	 * Put device into slumber mode
+	 */
+	if (!rc && state.event != PM_EVENT_FREEZE)
+		ahci_port_standby(port_mmio, hpriv->cap);
+
+	return rc;
+}
+
 static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg_in)
 {
 	unsigned int sc_reg;
-- 
1.2.6
-
