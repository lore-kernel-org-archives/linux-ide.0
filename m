From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH 4/6] The definition of ahci_port_suspend()
Date: Tue, 06 Jun 2006 18:17:15 +0800
Message-ID: <1149589035.29552.60.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52628 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751160AbWFFLGS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Jun 2006 07:06:18 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, hare@suse.de, axboe@suse.de, htejun@gmail.com, jeremy@goop.org, lkml@rtr.ca
Cc: linux-ide@vger.kernel.org

Add the definition of ahci_port_suspend(), which will be used to suspend a
port.

Signed-off-by: Forrest Zhao <forrest.zhaot@intel.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Jens Axboe <axboe@suse.de>

---

 drivers/scsi/ahci.c |   35 ++++++++++++++++++++++++++++++++++-
 1 files changed, 34 insertions(+), 1 deletions(-)

a702c05813a2b7ec16ae1314b54ca772e26fb2fb
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index f6086d6..acf3538 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -215,6 +215,7 @@ static int ahci_port_start(struct ata_po
 static void ahci_port_stop(struct ata_port *ap);
 static int ahci_port_standby(void __iomem *port_mmio, u32 cap);
 static int ahci_port_spinup(void __iomem *port_mmio, u32 cap);
+static int ahci_port_suspend(struct ata_port *ap, pm_message_t state);
 static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static u8 ahci_check_status(struct ata_port *ap);
@@ -433,7 +434,6 @@ static int ahci_port_start(struct ata_po
 	return 0;
 }
 
-
 static void ahci_port_stop(struct ata_port *ap)
 {
 	struct device *dev = ap->host_set->dev;
@@ -459,6 +459,39 @@ static void ahci_port_stop(struct ata_po
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
