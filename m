From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH 2/6] The definition of ahci_start_fis_rx() and
	ahci_stop_fis_rx()
Date: Mon, 10 Jul 2006 11:35:09 +0800
Message-ID: <1152502510.7132.267.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33204 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1161328AbWGJDsa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 9 Jul 2006 23:48:30 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, htejun@gmail.com, hare@suse.de, axboe@suse.de
Cc: linux-ide@vger.kernel.org

Put the "start/stop FIS RX" operation into ahci_start_fis_rx() and
 ahci_stop_fis_rx().

Signed-off-by: Forrest Zhao <forrest.zhaot@intel.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Jens Axboe <axboe@suse.de>

---

 drivers/scsi/ahci.c |   75 ++++++++++++++++++++++++++++++++++++++++++++
+++++++
 1 files changed, 75 insertions(+), 0 deletions(-)

8098bbd92f7eacf5c40c01feb71fe88b88cb5745
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index be2cba8..2ad26cd 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -202,6 +202,10 @@ static unsigned int ahci_qc_issue(struct
 static irqreturn_t ahci_interrupt (int irq, void *dev_instance, struct
pt_regs *regs);
 static int ahci_start_engine(void __iomem *port_mmio);
 static int ahci_stop_engine(void __iomem *port_mmio);
+static void ahci_start_fis_rx(void __iomem *port_mmio,
+			     struct ahci_port_priv *pp,
+			     struct ahci_host_priv *hpriv);
+static int ahci_stop_fis_rx(void __iomem *port_mmio);
 static int ahci_probe_reset(struct ata_port *ap, unsigned int
*classes);
 static void ahci_irq_clear(struct ata_port *ap);
 static int ahci_port_start(struct ata_port *ap);
@@ -544,6 +548,77 @@ static int ahci_start_engine(void __iome
 	return 0;
 }
 
+static int ahci_stop_fis_rx(void __iomem *port_mmio)
+{
+	u32 tmp;
+
+	/*
+	 * Get current status
+	 */
+	tmp = readl(port_mmio + PORT_CMD);
+
+	/* Check if FIS RX is already disabled */
+	if ((tmp & PORT_CMD_FIS_RX) == 0)
+		return 0;
+
+	/*
+	 * AHCI Rev 1.1 section 10.3.2
+	 * Software shall not clear PxCMD.FRE while
+	 * PxCMD.ST or PxCMD.CR is set to '1'
+	 */
+	if (tmp & (PORT_CMD_LIST_ON | PORT_CMD_START)) {
+		return -EPERM;
+	}
+
+	/*
+	 * Disable FIS reception
+	 *
+	 * AHCI Rev 1.1 Section 10.1.2:
+	 * If PxCMD.FRE is set to '1', software should clear it
+	 * to '0' and wait at least 500 milliseconds for PxCMD.FR
+	 * to return '0' when read. If PxCMD.FR does not clear
+	 * '0' correctly, then software may attempt a port reset
+	 * of a full HBA reset to recover.
+	 */
+	tmp &= ~(PORT_CMD_FIS_RX);
+	writel(tmp, port_mmio + PORT_CMD);
+
+	tmp = ata_wait_register(port_mmio + PORT_CMD, PORT_CMD_FIS_ON,
+				PORT_CMD_FIS_ON, 1, 1000);
+	if(tmp & PORT_CMD_FIS_ON)
+		return -EBUSY;
+
+	return 0;
+}
+
+static void ahci_start_fis_rx(void __iomem *port_mmio,
+                             struct ahci_port_priv *pp,
+                             struct ahci_host_priv *hpriv)
+{
+	u32 tmp;
+
+	/*
+	 * Set FIS registers
+	 */
+	if (hpriv->cap & HOST_CAP_64)
+		writel((pp->cmd_slot_dma >> 16) >> 16, port_mmio + PORT_LST_ADDR_HI);
+	writel(pp->cmd_slot_dma & 0xffffffff, port_mmio + PORT_LST_ADDR);
+	readl(port_mmio + PORT_LST_ADDR); /* flush */
+
+	if (hpriv->cap & HOST_CAP_64)
+		writel((pp->rx_fis_dma >> 16) >> 16, port_mmio + PORT_FIS_ADDR_HI);
+	writel(pp->rx_fis_dma & 0xffffffff, port_mmio + PORT_FIS_ADDR);
+	readl(port_mmio + PORT_FIS_ADDR); /* flush */
+
+	/*
+	 * Enable FIS reception
+	 */
+	tmp = readl(port_mmio + PORT_CMD);
+	tmp |= PORT_CMD_FIS_RX;
+	writel(tmp, port_mmio + PORT_CMD);
+	readl(port_mmio + PORT_CMD); /* flush */
+}
+
 static unsigned int ahci_dev_classify(struct ata_port *ap)
 {
 	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
-- 
1.2.6
