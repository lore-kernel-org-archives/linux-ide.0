From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH 5/6] Update new users of new added functions
Date: Thu, 13 Jul 2006 13:39:23 +0800
Message-ID: <1152769163.7132.331.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:26373 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751489AbWGMFwz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Jul 2006 01:52:55 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, htejun@gmail.com, hare@suse.de, axboe@suse.de
Cc: linux-ide@vger.kernel.org

1 Use ahci_start_fis_rx(), ahci_port_spinup(), ahci_start_engine() in
ahci_port_start()
2 Use ahci_stop_engine(), ahci_stop_fis_rx() in ahci_host_init()


Signed-off-by: Forrest Zhao <forrest.zhao@intel.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Jens Axboe <axboe@suse.de>


---

 drivers/scsi/ahci.c |   50 ++++++++++++++++++++++
+---------------------------
 1 files changed, 23 insertions(+), 27 deletions(-)

9c57dea5678c608c5257ad2e6a363c52fd563ca8
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 50d0183..5e04ef4 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -442,20 +442,20 @@ static int ahci_port_start(struct ata_po
 
 	ap->private_data = pp;
 
-	if (hpriv->cap & HOST_CAP_64)
-		writel((pp->cmd_slot_dma >> 16) >> 16, port_mmio + PORT_LST_ADDR_HI);
-	writel(pp->cmd_slot_dma & 0xffffffff, port_mmio + PORT_LST_ADDR);
-	readl(port_mmio + PORT_LST_ADDR); /* flush */
-
-	if (hpriv->cap & HOST_CAP_64)
-		writel((pp->rx_fis_dma >> 16) >> 16, port_mmio + PORT_FIS_ADDR_HI);
-	writel(pp->rx_fis_dma & 0xffffffff, port_mmio + PORT_FIS_ADDR);
-	readl(port_mmio + PORT_FIS_ADDR); /* flush */
+	/*
+	 * Driver is setup; initialize the HBA
+	 */
+	ahci_start_fis_rx(port_mmio, pp, hpriv);
 
-	writel(PORT_CMD_ICC_ACTIVE | PORT_CMD_FIS_RX |
-	       PORT_CMD_POWER_ON | PORT_CMD_SPIN_UP |
-	       PORT_CMD_START, port_mmio + PORT_CMD);
-	readl(port_mmio + PORT_CMD); /* flush */
+	rc = ahci_port_spinup(port_mmio, hpriv->cap);
+	if (rc) 
+		ata_port_printk(ap, KERN_WARNING,
+				"Could not spinup port (%d)\n", rc);
+
+	rc = ahci_start_engine(port_mmio); 
+	if (rc) 
+		ata_port_printk(ap, KERN_WARNING, "Could not start DMA engine"
+			        "of port (%d)\n", rc);
 
 	return 0;
 }
@@ -1411,20 +1411,16 @@ static int ahci_host_init(struct ata_pro
 				(unsigned long) mmio, i);
 
 		/* make sure port is not active */
-		tmp = readl(port_mmio + PORT_CMD);
-		VPRINTK("PORT_CMD 0x%x\n", tmp);
-		if (tmp & (PORT_CMD_LIST_ON | PORT_CMD_FIS_ON |
-			   PORT_CMD_FIS_RX | PORT_CMD_START)) {
-			tmp &= ~(PORT_CMD_LIST_ON | PORT_CMD_FIS_ON |
-				 PORT_CMD_FIS_RX | PORT_CMD_START);
-			writel(tmp, port_mmio + PORT_CMD);
-			readl(port_mmio + PORT_CMD); /* flush */
-
-			/* spec says 500 msecs for each bit, so
-			 * this is slightly incorrect.
-			 */
-			msleep(500);
-		}
+
+		rc = ahci_stop_engine(port_mmio);
+		if (rc)
+			printk(KERN_WARNING "ata%u: DMA engine busy (%d)\n",
+			       i, rc);
+
+		rc = ahci_stop_fis_rx(port_mmio);
+		if (rc)
+			printk(KERN_WARNING "ata%u: FIS RX not stopped (%d)\n",
+			       i, rc);
 
 		writel(PORT_CMD_SPIN_UP, port_mmio + PORT_CMD);
 
-- 
1.2.6

