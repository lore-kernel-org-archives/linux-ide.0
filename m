From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH 3/6] The definition of ahci_port_standby() and
	ahci_port_spinup()
Date: Fri, 02 Jun 2006 15:45:28 +0800
Message-ID: <1149234328.13451.56.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:17983 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751284AbWFBH5J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jun 2006 03:57:09 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, hare@suse.de, axboe@suse.de, htejun@gmail.com, jeremy@goop.org, lkml@rtr.ca
Cc: linux-ide@vger.kernel.org

Put port power management[1], staggered-spinup[2], cold presence
detection[3] related operations during the power state transition into
ahci_port_standby() and ahci_port_spinup().

In particular ahci_port_standby() does the [1] and [2] when power transits
to a lower level; ahci_port_spinup() does [1], [2] and [3] when power
transits to a higher level.


Signed-off-by: Forrest Zhao <forrest.zhao@intel.com>

---

 drivers/scsi/ahci.c |  105 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 105 insertions(+), 0 deletions(-)

3d52b79eccec86284b92a074ae364d6576ed7c0a
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 34e6c73..12eed7e 100644
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
 
@@ -146,6 +148,7 @@ enum {
 
 	/* PORT_CMD bits */
 	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
+	PORT_CMD_CPD		= (1 << 20), /* Cold presence detection */
 	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
 	PORT_CMD_FIS_ON		= (1 << 14), /* FIS DMA engine running */
 	PORT_CMD_FIS_RX		= (1 << 4), /* Enable FIS receive DMA engine */
@@ -154,6 +157,7 @@ enum {
 	PORT_CMD_SPIN_UP	= (1 << 1), /* Spin up device */
 	PORT_CMD_START		= (1 << 0), /* Enable port DMA engine */
 
+	PORT_CMD_ICC_MASK	= (0xf << 28), /* i/f ICC state mask */
 	PORT_CMD_ICC_ACTIVE	= (0x1 << 28), /* Put i/f in active state */
 	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
 	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
@@ -210,6 +214,8 @@ static int ahci_probe_reset(struct ata_p
 static void ahci_irq_clear(struct ata_port *ap);
 static int ahci_port_start(struct ata_port *ap);
 static void ahci_port_stop(struct ata_port *ap);
+static int ahci_port_standby(void __iomem *port_mmio, u32 cap);
+static int ahci_port_spinup(void __iomem *port_mmio, u32 cap);
 static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static u8 ahci_check_status(struct ata_port *ap);
@@ -638,6 +644,105 @@ static void ahci_start_fis_rx(void __iom
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
+	scontrol = readl(port_mmio + PORT_SCR_CTL);
+	scontrol &= ~0xf;
+	writel(scontrol, port_mmio + PORT_SCR_CTL);
+
+	tmp = readl(port_mmio + PORT_CMD);
+	if (cap & HOST_CAP_SSS) {
+		/*
+		 * Spin down the device for staggered spin-up support
+		 */
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
+	 * Power on device if supported
+	 */
+	if (tmp & PORT_CMD_CPD) {
+		tmp |= PORT_CMD_POWER_ON;
+		writel(tmp, port_mmio + PORT_CMD);
+		tmp = readl(port_mmio + PORT_CMD);
+	}
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
