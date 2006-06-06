From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH 1/6] The definition of ahci_start_engine() and
	ahci_stop_engine()
Date: Tue, 06 Jun 2006 18:15:49 +0800
Message-ID: <1149588950.29552.55.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:9360 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750770AbWFFK1m (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Jun 2006 06:27:42 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, hare@suse.de, axboe@suse.de, htejun@gmail.com, jeremy@goop.org, lkml@rtr.ca
Cc: linux-ide@vger.kernel.org

1 Make ahci_start_engine() and ahci_stop_engine more consistent with AHCI
 spec 1.1
2 Change their input parameter from ap to port_mmio
3 Use ata_wait_register() to wait register bit.

Signed-off-by: Forrest Zhao <forrest.zhaot@intel.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Jens Axboe <axboe@suse.de>


---

 drivers/scsi/ahci.c |   57 +++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 41 insertions(+), 16 deletions(-)

4183c56a95717740b6ca9c06b22bb6377a2f23e7
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 45fd71d..be2cba8 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -200,6 +200,8 @@ static void ahci_scr_write (struct ata_p
 static int ahci_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc);
 static irqreturn_t ahci_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
+static int ahci_start_engine(void __iomem *port_mmio);
+static int ahci_stop_engine(void __iomem *port_mmio);
 static int ahci_probe_reset(struct ata_port *ap, unsigned int *classes);
 static void ahci_irq_clear(struct ata_port *ap);
 static int ahci_port_start(struct ata_port *ap);
@@ -482,41 +484,64 @@ static void ahci_scr_write (struct ata_p
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
