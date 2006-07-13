From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH 1/6] The redefinition of ahci_start_engine()
	andahci_stop_engine()
Date: Thu, 13 Jul 2006 13:38:32 +0800
Message-ID: <1152769112.7132.327.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:8494 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751486AbWGMFwE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Jul 2006 01:52:04 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, htejun@gmail.com, hare@suse.de, axboe@suse.de
Cc: linux-ide@vger.kernel.org

1 Make ahci_start_engine() and ahci_stop_engine() more consistent with
AHCI spec 1.1
2 Change their input parameter from ap to port_mmio
3 Update the existing users of ahci_start_engine() and ahci_stop_engine
()

Signed-off-by: Forrest Zhao <forrest.zhao@intel.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Jens Axboe <axboe@suse.de>


---

 drivers/scsi/ahci.c |   82 ++++++++++++++++++++++++++++++++++
+----------------
 1 files changed, 57 insertions(+), 25 deletions(-)

2000c3e3e0183ec2b2a62a91dc33bcb928b3edb6
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 77e7202..f1516ca 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -205,6 +205,8 @@ static irqreturn_t ahci_interrupt (int i
 static void ahci_irq_clear(struct ata_port *ap);
 static int ahci_port_start(struct ata_port *ap);
 static void ahci_port_stop(struct ata_port *ap);
+static int ahci_start_engine(void __iomem *port_mmio);
+static int ahci_stop_engine(void __iomem *port_mmio);
 static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static u8 ahci_check_status(struct ata_port *ap);
@@ -508,41 +510,64 @@ static void ahci_scr_write (struct ata_p
 	writel(val, (void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
-static int ahci_stop_engine(struct ata_port *ap)
+static int ahci_stop_engine(void __iomem *port_mmio)
 {
-	void __iomem *mmio = ap->host_set->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
-	int work;
 	u32 tmp;
 
 	tmp = readl(port_mmio + PORT_CMD);
+
+	/* Check if the HBA is idle */
+	if ((tmp & (PORT_CMD_START | PORT_CMD_LIST_ON)) == 0)
+		return 0;
+
+	/* Setting HBA to idle */
 	tmp &= ~PORT_CMD_START;
 	writel(tmp, port_mmio + PORT_CMD);
 
-	/* wait for engine to stop.  TODO: this could be
+	/* wait for engine to stop. This could be
 	 * as long as 500 msec
 	 */
-	work = 1000;
-	while (work-- > 0) {
-		tmp = readl(port_mmio + PORT_CMD);
-		if ((tmp & PORT_CMD_LIST_ON) == 0)
-			return 0;
-		udelay(10);
-	}
+	tmp = ata_wait_register(port_mmio + PORT_CMD,
+			        PORT_CMD_LIST_ON, PORT_CMD_LIST_ON, 1, 500);
+	if(tmp & PORT_CMD_LIST_ON)
+		return -EIO;
 
-	return -EIO;
+	return 0;
 }
 
-static void ahci_start_engine(struct ata_port *ap)
+static int ahci_start_engine(void __iomem *port_mmio)
 {
-	void __iomem *mmio = ap->host_set->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 	u32 tmp;
 
+	/*
+	 * Get current status
+	 */
 	tmp = readl(port_mmio + PORT_CMD);
+
+	/*
+	 * AHCI rev 1.1 section 10.3.1:
+	 * Software shall not set PxCMD.ST to '1' until it verifies
+	 * that PxCMD.CR is '0' and has set PxCMD.FRE to '1'
+	 */
+	if ((tmp & PORT_CMD_FIS_RX) == 0)
+		return -EPERM;
+
+	/*
+	 * wait for engine to become idle.
+	 */
+	tmp = ata_wait_register(port_mmio + PORT_CMD,
+				PORT_CMD_LIST_ON, PORT_CMD_LIST_ON, 1,500);
+	if(tmp & PORT_CMD_LIST_ON)
+		return -EBUSY;
+
+	/*
+	 * Start DMA
+	 */
 	tmp |= PORT_CMD_START;
 	writel(tmp, port_mmio + PORT_CMD);
 	readl(port_mmio + PORT_CMD); /* flush */
+
+	return 0;
 }
 
 static unsigned int ahci_dev_classify(struct ata_port *ap)
@@ -626,7 +651,7 @@ static int ahci_softreset(struct ata_por
 	}
 
 	/* prepare for SRST (AHCI-1.1 10.4.1) */
-	rc = ahci_stop_engine(ap);
+	rc = ahci_stop_engine(port_mmio);
 	if (rc) {
 		reason = "failed to stop engine";
 		goto fail_restart;
@@ -647,7 +672,7 @@ static int ahci_softreset(struct ata_por
 	}
 
 	/* restart engine */
-	ahci_start_engine(ap);
+	ahci_start_engine(port_mmio);
 
 	ata_tf_init(ap->device, &tf);
 	fis = pp->cmd_tbl;
@@ -706,7 +731,7 @@ static int ahci_softreset(struct ata_por
 	return 0;
 
  fail_restart:
-	ahci_start_engine(ap);
+	ahci_start_engine(port_mmio);
  fail:
 	ata_port_printk(ap, KERN_ERR, "softreset failed (%s)\n", reason);
 	return rc;
@@ -717,11 +742,13 @@ static int ahci_hardreset(struct ata_por
 	struct ahci_port_priv *pp = ap->private_data;
 	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
 	struct ata_taskfile tf;
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 	int rc;
 
 	DPRINTK("ENTER\n");
 
-	ahci_stop_engine(ap);
+	ahci_stop_engine(port_mmio);
 
 	/* clear D2H reception area to properly wait for D2H FIS */
 	ata_tf_init(ap->device, &tf);
@@ -730,7 +757,7 @@ static int ahci_hardreset(struct ata_por
 
 	rc = sata_std_hardreset(ap, class);
 
-	ahci_start_engine(ap);
+	ahci_start_engine(port_mmio);
 
 	if (rc == 0 && ata_port_online(ap))
 		*class = ahci_dev_classify(ap);
@@ -1052,10 +1079,13 @@ static void ahci_thaw(struct ata_port *a
 
 static void ahci_error_handler(struct ata_port *ap)
 {
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+
 	if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
 		/* restart engine */
-		ahci_stop_engine(ap);
-		ahci_start_engine(ap);
+		ahci_stop_engine(port_mmio);
+		ahci_start_engine(port_mmio);
 	}
 
 	/* perform recovery */
@@ -1066,14 +1096,16 @@ static void ahci_error_handler(struct at
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 
 	if (qc->flags & ATA_QCFLAG_FAILED)
 		qc->err_mask |= AC_ERR_OTHER;
 
 	if (qc->err_mask) {
 		/* make DMA engine forget about the failed command */
-		ahci_stop_engine(ap);
-		ahci_start_engine(ap);
+		ahci_stop_engine(port_mmio);
+		ahci_start_engine(port_mmio);
 	}
 }
 
-- 
1.2.6

