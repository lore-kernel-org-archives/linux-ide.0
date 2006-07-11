From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH 1/6]The definition of ahci_start_engine() and
	ahci_stop_engine()
Date: Tue, 11 Jul 2006 14:37:35 +0800
Message-ID: <1152599855.7132.292.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47922 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S965051AbWGKGuy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Jul 2006 02:50:54 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, htejun@gmail.com, hare@suse.de, axboe@suse.de
Cc: linux-ide@vger.kernel.org

1 Make ahci_start_engine() and ahci_stop_engine more consistent with
AHCI
 spec 1.1
2 Change their input parameter from ap to port_mmio

Signed-off-by: Forrest Zhao <forrest.zhaot@intel.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Jens Axboe <axboe@suse.de>


---

 drivers/scsi/ahci.c |   57 ++++++++++++++++++++++++++++++++++++
+--------------
 1 files changed, 41 insertions(+), 16 deletions(-)

ca41463c59af1b90149c42101696b47d96c41d11
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index f059467..0ff8be1 100644
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
-- 
1.2.6

