From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH 5/6] Update the users of new added functions
Date: Tue, 11 Jul 2006 14:39:28 +0800
Message-ID: <1152599968.7132.301.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:862 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S965231AbWGKGxj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Jul 2006 02:53:39 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, htejun@gmail.com, hare@suse.de, axboe@suse.de
Cc: linux-ide@vger.kernel.org

Update the users of ahci_start_engine(), ahci_stop_engine(),
ahci_port_standby(), ahci_port_spinup() and ahci_port_suspend()

Signed-off-by: Forrest Zhao <forrest.zhaot@intel.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Jens Axboe <axboe@suse.de>


---

 drivers/scsi/ahci.c |   78 ++++++++++++++++++++
+------------------------------
 1 files changed, 32 insertions(+), 46 deletions(-)

f367ea144940c1a895b0fceeadd82ed9f28b2bc2
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index fc2c879..7bf9b6d 100644
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
@@ -464,19 +464,8 @@ static void ahci_port_stop(struct ata_po
 {
 	struct device *dev = ap->host_set->dev;
 	struct ahci_port_priv *pp = ap->private_data;
-	void __iomem *mmio = ap->host_set->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
-	u32 tmp;
 
-	tmp = readl(port_mmio + PORT_CMD);
-	tmp &= ~(PORT_CMD_START | PORT_CMD_FIS_RX);
-	writel(tmp, port_mmio + PORT_CMD);
-	readl(port_mmio + PORT_CMD); /* flush */
-
-	/* spec says 500 msecs for each PORT_CMD_{START,FIS_RX} bit, so
-	 * this is slightly incorrect.
-	 */
-	msleep(500);
+	ahci_port_suspend(ap, PMSG_SUSPEND);
 
 	ap->private_data = NULL;
 	dma_free_coherent(dev, AHCI_PORT_PRIV_DMA_SZ,
@@ -857,7 +846,7 @@ static int ahci_softreset(struct ata_por
 	}
 
 	/* prepare for SRST (AHCI-1.1 10.4.1) */
-	rc = ahci_stop_engine(ap);
+	rc = ahci_stop_engine(port_mmio);
 	if (rc) {
 		reason = "failed to stop engine";
 		goto fail_restart;
@@ -878,7 +867,7 @@ static int ahci_softreset(struct ata_por
 	}
 
 	/* restart engine */
-	ahci_start_engine(ap);
+	ahci_start_engine(port_mmio);
 
 	ata_tf_init(ap->device, &tf);
 	fis = pp->cmd_tbl;
@@ -937,7 +926,7 @@ static int ahci_softreset(struct ata_por
 	return 0;
 
  fail_restart:
-	ahci_start_engine(ap);
+	ahci_start_engine(port_mmio);
  fail:
 	ata_port_printk(ap, KERN_ERR, "softreset failed (%s)\n", reason);
 	return rc;
@@ -948,20 +937,20 @@ static int ahci_hardreset(struct ata_por
 	struct ahci_port_priv *pp = ap->private_data;
 	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
 	struct ata_taskfile tf;
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 	int rc;
 
 	DPRINTK("ENTER\n");
 
-	ahci_stop_engine(ap);
-
 	/* clear D2H reception area to properly wait for D2H FIS */
 	ata_tf_init(ap->device, &tf);
 	tf.command = 0xff;
 	ata_tf_to_fis(&tf, d2h_fis, 0);
 
+	ahci_stop_engine(port_mmio);
 	rc = sata_std_hardreset(ap, class);
-
-	ahci_start_engine(ap);
+	ahci_start_engine(port_mmio);
 
 	if (rc == 0 && ata_port_online(ap))
 		*class = ahci_dev_classify(ap);
@@ -1415,20 +1404,17 @@ static int ahci_host_init(struct ata_pro
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
+
 
 		writel(PORT_CMD_SPIN_UP, port_mmio + PORT_CMD);
 
-- 
1.2.6

