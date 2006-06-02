From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH 5/6] Update the users of new added functions
Date: Fri, 02 Jun 2006 15:45:57 +0800
Message-ID: <1149234357.13451.58.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33039 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751213AbWFBH5q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jun 2006 03:57:46 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, hare@suse.de, axboe@suse.de, htejun@gmail.com, jeremy@goop.org, lkml@rtr.ca
Cc: linux-ide@vger.kernel.org

Update the users of ahci_start_engine(), ahci_stop_engine(),
ahci_port_standby(), ahci_port_spinup() and ahci_port_suspend().


Signed-off-by: Forrest Zhao <forrest.zhao@intel.com>

---

 drivers/scsi/ahci.c |   76 +++++++++++++++++++++------------------------------
 1 files changed, 32 insertions(+), 44 deletions(-)

7124ce975902b06891a6057ccc166305217082c0
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 1d9c158..8928170 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -417,20 +417,20 @@ static int ahci_port_start(struct ata_po
 
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
@@ -439,19 +439,8 @@ static void ahci_port_stop(struct ata_po
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
@@ -846,7 +835,7 @@ static int ahci_softreset(struct ata_por
 	}
 
 	/* prepare for SRST (AHCI-1.1 10.4.1) */
-	rc = ahci_stop_engine(ap);
+	rc = ahci_stop_engine(port_mmio);
 	if (rc) {
 		reason = "failed to stop engine";
 		goto fail_restart;
@@ -867,7 +856,7 @@ static int ahci_softreset(struct ata_por
 	}
 
 	/* restart engine */
-	ahci_start_engine(ap);
+	ahci_start_engine(port_mmio);
 
 	ata_tf_init(ap->device, &tf);
 	fis = pp->cmd_tbl;
@@ -926,7 +915,7 @@ static int ahci_softreset(struct ata_por
 	return 0;
 
  fail_restart:
-	ahci_start_engine(ap);
+	ahci_start_engine(port_mmio);
  fail:
 	ata_port_printk(ap, KERN_ERR, "softreset failed (%s)\n", reason);
 	return rc;
@@ -934,13 +923,15 @@ static int ahci_softreset(struct ata_por
 
 static int ahci_hardreset(struct ata_port *ap, unsigned int *class)
 {
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 	int rc;
 
 	DPRINTK("ENTER\n");
 
-	ahci_stop_engine(ap);
+	ahci_stop_engine(port_mmio);
 	rc = sata_std_hardreset(ap, class);
-	ahci_start_engine(ap);
+	ahci_start_engine(port_mmio);
 
 	if (rc == 0 && ata_port_online(ap))
 		*class = ahci_dev_classify(ap);
@@ -1407,20 +1398,17 @@ static int ahci_host_init(struct ata_pro
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
