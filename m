From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH 2/6] The definition of ahci_start_fis_rx() and
	ahci_stop_fis_rx()
Date: Fri, 02 Jun 2006 15:44:55 +0800
Message-ID: <1149234295.13451.54.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15153 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751282AbWFBH4g (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jun 2006 03:56:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, hare@suse.de, axboe@suse.de, htejun@gmail.com, jeremy@goop.org, lkml@rtr.ca
Cc: linux-ide@vger.kernel.org

Put the "start/stop FIS RX" operation into ahci_start_fis_rx() and
 ahci_stop_fis_rx().


Signed-off-by: Forrest Zhao <forrest.zhao@intel.com>

---

 drivers/scsi/ahci.c |   80 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 80 insertions(+), 0 deletions(-)

81f3915bccdf294fd627f2b3b0e98b1a6a457cf5
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index d2b35c4..34e6c73 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -202,6 +202,10 @@ static unsigned int ahci_qc_issue(struct
 static irqreturn_t ahci_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 static int ahci_start_engine(void __iomem *port_mmio);
 static int ahci_stop_engine(void __iomem *port_mmio);
+static void ahci_start_fis_rx(void __iomem *port_mmio,
+			     struct ahci_port_priv *pp,
+			     struct ahci_host_priv *hpriv);
+static int ahci_stop_fis_rx(void __iomem *port_mmio);
 static int ahci_probe_reset(struct ata_port *ap, unsigned int *classes);
 static void ahci_irq_clear(struct ata_port *ap);
 static int ahci_port_start(struct ata_port *ap);
@@ -558,6 +562,82 @@ static int ahci_start_engine(void __iome
 	return 0;
 }
 
+static int ahci_stop_fis_rx(void __iomem *port_mmio)
+{
+	u32 tmp;
+	int work = 1000;
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
+	mdelay(500);
+	work = 1000;
+	while (work-- > 0) {
+		tmp = readl(port_mmio + PORT_CMD);
+		if ((tmp & PORT_CMD_FIS_ON) == 0)
+			return 0;
+		udelay(10);
+	}
+
+	return -EBUSY;
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
