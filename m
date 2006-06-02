From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH 1/6] The definition of ahci_start_engine() and
	ahci_stop_engine()
Date: Fri, 02 Jun 2006 15:49:59 +0800
Message-ID: <1149234599.13451.63.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:54333 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751297AbWFBID0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jun 2006 04:03:26 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, hare@suse.de, axboe@suse.de, htejun@gmail.com, jeremy@goop.org, lkml@rtr.ca
Cc: linux-ide@vger.kernel.org

1 Make ahci_start_engine() and ahci_stop_engine more consistent with AHCI
 spec 1.1
2 Change their input parameter from ap to port_mmio


Signed-off-by: Forrest Zhao <forrest.zhao@intel.com>


---

 drivers/scsi/ahci.c |   51 +++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 45 insertions(+), 6 deletions(-)

9ba56ff63c5f01f0a7280f15189c952f2fd7f2a1
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 45fd71d..d2b35c4 100644
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
@@ -482,14 +484,18 @@ static void ahci_scr_write (struct ata_p
 	writel(val, (void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
-static int ahci_stop_engine(struct ata_port *ap)
+static int ahci_stop_engine(void __iomem *port_mmio)
 {
-	void __iomem *mmio = ap->host_set->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 	int work;
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
 
@@ -507,16 +513,49 @@ static int ahci_stop_engine(struct ata_p
 	return -EIO;
 }
 
-static void ahci_start_engine(struct ata_port *ap)
+static int ahci_start_engine(void __iomem *port_mmio)
 {
-	void __iomem *mmio = ap->host_set->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 	u32 tmp;
+	int work = 1000;
 
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
+	while (work-- > 0) {
+		tmp = readl(port_mmio + PORT_CMD);
+		if ((tmp & PORT_CMD_LIST_ON) == 0)
+			break;
+		udelay(10);
+	}
+
+	if (!work) {
+		/*
+		 * We need to do a port reset / HBA reset here
+		 */
+		return -EBUSY;
+	}
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
