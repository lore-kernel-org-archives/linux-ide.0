From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH 3/5] ahci: definition of ahci_port_suspend()
Date: Thu, 20 Jul 2006 13:21:24 +0800
Message-ID: <1153372884.7132.358.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:18948 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932570AbWGTFff (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Jul 2006 01:35:35 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, htejun@gmail.com, hare@suse.de, axboe@suse.de
Cc: linux-ide@vger.kernel.org

1 Add the definition of ahci_port_suspend(), which will be used to
suspend a port.
2 Use ahci_port_suspend() in ahci_port_stop().


Signed-off-by: Forrest Zhao <forrest.zhao@intel.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Jens Axboe <axboe@suse.de>


---

 drivers/scsi/ahci.c |   48 ++++++++++++++++++++++++++++++++++
+-------------
 1 files changed, 35 insertions(+), 13 deletions(-)

1c970ab5651cfd20ee1ce69d54bcda1a39af9e42
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index f4386c5..50d0183 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -223,6 +223,7 @@ static void ahci_error_handler(struct at
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc);
 static int ahci_port_standby(void __iomem *port_mmio, u32 cap);
 static int ahci_port_spinup(void __iomem *port_mmio, u32 cap);
+static int ahci_port_suspend(struct ata_port *ap, pm_message_t state);
 static void ahci_remove_one (struct pci_dev *pdev);
 
 static struct scsi_host_template ahci_sht = {
@@ -459,24 +460,12 @@ static int ahci_port_start(struct ata_po
        return 0;
 }
 
-
 static void ahci_port_stop(struct ata_port *ap)
 {
        struct device *dev = ap->host_set->dev;
        struct ahci_port_priv *pp = ap->private_data;
-       void __iomem *mmio = ap->host_set->mmio_base;
-       void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
-       u32 tmp;
 
-       tmp = readl(port_mmio + PORT_CMD);
-       tmp &= ~(PORT_CMD_START | PORT_CMD_FIS_RX);
-       writel(tmp, port_mmio + PORT_CMD);
-       readl(port_mmio + PORT_CMD); /* flush */
-
-       /* spec says 500 msecs for each PORT_CMD_{START,FIS_RX} bit, so
-        * this is slightly incorrect.
-        */
-       msleep(500);
+       ahci_port_suspend(ap, PMSG_SUSPEND);
 
        ap->private_data = NULL;
        dma_free_coherent(dev, AHCI_PORT_PRIV_DMA_SZ,
@@ -485,6 +474,39 @@ static void ahci_port_stop(struct ata_po
        kfree(pp);
 }
 
+static int ahci_port_suspend(struct ata_port *ap, pm_message_t state)
+{
+       void __iomem *mmio = ap->host_set->mmio_base;
+       void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+       struct ahci_host_priv *hpriv = ap->host_set->private_data;
+       int rc;
+
+       /*
+        * Disable DMA
+        */
+       rc = ahci_stop_engine(port_mmio);
+       if (rc) {
+               ata_port_printk(ap, KERN_WARNING, "DMA engine busy\n");
+               return rc;
+       }
+
+       /*
+        * Disable FIS reception
+        */
+       rc = ahci_stop_fis_rx(port_mmio);
+       if (rc)
+               ata_port_printk(ap, KERN_WARNING, "FIS RX still running"
+                               " (%d)\n", rc);
+
+       /*
+        * Put device into slumber mode
+        */
+       if (!rc && state.event != PM_EVENT_FREEZE)
+               ahci_port_standby(port_mmio, hpriv->cap);
+
+       return rc;
+}
+
 static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg_in)
 {
        unsigned int sc_reg;
-- 
1.2.6
