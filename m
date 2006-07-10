From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH 3/6] The definition of ahci_port_standby() and
	ahci_port_spinup()
Date: Mon, 10 Jul 2006 11:35:13 +0800
Message-ID: <1152502513.7132.268.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:55648 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1161329AbWGJDsm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 9 Jul 2006 23:48:42 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, htejun@gmail.com, hare@suse.de, axboe@suse.de
Cc: linux-ide@vger.kernel.org

Put port power management and staggered-spinup related operations during
the power state transition into
ahci_port_standby() and ahci_port_spinup().

Signed-off-by: Forrest Zhao <forrest.zhaot@intel.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Jens Axboe <axboe@suse.de>


---

 drivers/scsi/ahci.c |   98 ++++++++++++++++++++++++++++++++++++++++++++
+++++++
 1 files changed, 98 insertions(+), 0 deletions(-)

7cd1ccaf6bee8363d7fb0d24f0d109f5d7003080
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index f4dd60c..6edc7c8 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -92,7 +92,9 @@ enum {
 	HOST_AHCI_EN		= (1 << 31), /* AHCI enabled */
 
 	/* HOST_CAP bits */
+	HOST_CAP_SSC		= (1 << 14), /* Slumber capable */
 	HOST_CAP_CLO		= (1 << 24), /* Command List Override support */
+	HOST_CAP_SSS		= (1 << 27), /* Staggered Spin-up */
 	HOST_CAP_NCQ		= (1 << 30), /* Native Command Queueing */
 	HOST_CAP_64		= (1 << 31), /* PCI DAC (64-bit DMA) support */
 
@@ -155,6 +157,7 @@ enum {
 	PORT_CMD_SPIN_UP	= (1 << 1), /* Spin up device */
 	PORT_CMD_START		= (1 << 0), /* Enable port DMA engine */
 
+	PORT_CMD_ICC_MASK	= (0xf << 28), /* i/f ICC state mask */
 	PORT_CMD_ICC_ACTIVE	= (0x1 << 28), /* Put i/f in active state */
 	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
 	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
@@ -218,6 +221,8 @@ static void ahci_freeze(struct ata_port 
 static void ahci_thaw(struct ata_port *ap);
 static void ahci_error_handler(struct ata_port *ap);
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc);
+static int ahci_port_standby(void __iomem *port_mmio, u32 cap);
+static int ahci_port_spinup(void __iomem *port_mmio, u32 cap);
 static void ahci_remove_one (struct pci_dev *pdev);
 
 static struct scsi_host_template ahci_sht = {
@@ -645,6 +650,99 @@ static void ahci_start_fis_rx(void __iom
 	readl(port_mmio + PORT_CMD); /* flush */
 }
 
+static int ahci_port_standby(void __iomem *port_mmio, u32 cap)
+{
+	u32 tmp, scontrol, sstatus;
+
+	tmp = readl(port_mmio + PORT_CMD);
+	/*
+	 * AHCI Rev1.1 Section 5.3.2.3:
+	 * Software is only allowed to program the PxCMD.FRE,
+	 * PxCMD.POD, PxSCTL.DET, and PxCMD.SUD register bits
+	 * when PxCMD.ST is set to '0'
+	 */
+	if (tmp & PORT_CMD_START)
+		return -EBUSY;
+
+	if (cap & HOST_CAP_SSC) {
+		/*
+		 * Enable transitions to slumber mode
+		 */
+		scontrol = readl(port_mmio + PORT_SCR_CTL);
+		if ((scontrol & 0x0f00) > 0x100) {
+			scontrol &= ~0xf00;
+			writel(scontrol, port_mmio + PORT_SCR_CTL);
+		}
+		/*
+		 * Put device into slumber mode
+		 */
+		tmp |= PORT_CMD_ICC_SLUMBER;
+		writel(tmp, port_mmio + PORT_CMD);
+		tmp = readl(port_mmio + PORT_CMD);
+
+		/*
+		 * Actually, we should wait for the device to
+		 * enter slumber mode by checking
+		 * sstatus & 0xf00 == 6
+		 */
+		sstatus = readl(port_mmio + PORT_SCR_STAT);
+	}
+
+	/*
+	 * Put device into listen mode
+	 */
+	if (cap & HOST_CAP_SSS) {
+		/* 
+		 * first set PxSCTL.DET to 0
+		 */
+		scontrol = readl(port_mmio + PORT_SCR_CTL);
+		scontrol &= ~0xf;
+		writel(scontrol, port_mmio + PORT_SCR_CTL);
+
+		/*
+		 * then set PxCMD.SUD to 0
+		 */
+		tmp = readl(port_mmio + PORT_CMD);
+		tmp &= ~PORT_CMD_SPIN_UP;
+		writel(tmp, port_mmio + PORT_CMD);
+		readl(port_mmio + PORT_CMD); /* flush */
+	}
+
+	return 0;
+}
+
+static int ahci_port_spinup(void __iomem *port_mmio, u32 cap)
+{
+	u32 tmp;
+
+	tmp = readl(port_mmio + PORT_CMD);
+	/*
+	 * AHCI Rev1.1 Section 5.3.2.3:
+	 * Software is only allowed to program the PxCMD.FRE,
+	 * PxCMD.POD, PxSCTL.DET, and PxCMD.SUD register bits
+	 * when PxCMD.ST is set to '0'
+	 */
+	if (tmp & PORT_CMD_START)
+		return -EBUSY;
+
+	/*
+	 * Spin up device
+	 */
+	if (cap & HOST_CAP_SSS) {
+		tmp |= PORT_CMD_SPIN_UP;
+		writel(tmp, port_mmio + PORT_CMD);
+		tmp = readl(port_mmio + PORT_CMD);
+	}
+
+	if ((tmp & PORT_CMD_ICC_MASK) != PORT_CMD_ICC_ACTIVE) {
+		tmp |= PORT_CMD_ICC_ACTIVE;
+		writel(tmp, port_mmio + PORT_CMD);
+		tmp = readl(port_mmio + PORT_CMD);
+	}
+
+	return 0;
+}
+
 static unsigned int ahci_dev_classify(struct ata_port *ap)
 {
 	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
-- 
1.2.6
-
