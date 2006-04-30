From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH] AHCI suspend/resume support
Date: Sun, 30 Apr 2006 13:35:44 +0800
Message-ID: <1146375344.5197.34.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58180 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750966AbWD3Fq3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 30 Apr 2006 01:46:29 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi,

I ported the AHCI suspend/resume patch at
http://www.spinnaker.de/linux/c1320/sata-resume-2.6.16.5.patch to
libata-dev #upstream.
This patch provides the support for AHCI suspend/resume. The patch
works very well on Napa SDV in our lab.

Your comments and bug report are welcome.

Thanks,
Forrest


Signed-off-by: Zhao, Forrest <forrest.zhao@intel.com>


---

 drivers/scsi/ahci.c |  528 +++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 471 insertions(+), 57 deletions(-)

d85e2e6b58eb449a10baab5ab309906f34cab22d
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index d23f002..176a875 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -44,6 +44,7 @@
 #include <linux/device.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_device.h>
 #include <linux/libata.h>
 #include <asm/io.h>
 
@@ -89,7 +90,9 @@ enum {
 
 	/* HOST_CAP bits */
 	HOST_CAP_64		= (1 << 31), /* PCI DAC (64-bit DMA) support */
+	HOST_CAP_SSS		= (1 << 27), /* Staggered Spin-up */
 	HOST_CAP_CLO		= (1 << 24), /* Command List Override support */
+	HOST_CAP_SSC		= (1 << 14), /* Slumber capable */
 
 	/* registers for each SATA port */
 	PORT_LST_ADDR		= 0x00, /* command list DMA addr */
@@ -140,6 +143,7 @@ enum {
 
 	/* PORT_CMD bits */
 	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
+	PORT_CMD_CPD		= (1 << 20), /* Cold presence detection */
 	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
 	PORT_CMD_FIS_ON		= (1 << 14), /* FIS DMA engine running */
 	PORT_CMD_FIS_RX		= (1 << 4), /* Enable FIS receive DMA engine */
@@ -148,6 +152,7 @@ enum {
 	PORT_CMD_SPIN_UP	= (1 << 1), /* Spin up device */
 	PORT_CMD_START		= (1 << 0), /* Enable port DMA engine */
 
+	PORT_CMD_ICC_MASK	= (0xf << 28), /* i/f ICC state mask */
 	PORT_CMD_ICC_ACTIVE	= (0x1 << 28), /* Put i/f in active state */
 	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
 	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
@@ -178,6 +183,7 @@ struct ahci_host_priv {
 	unsigned long		flags;
 	u32			cap;	/* cache of HOST_CAP register */
 	u32			port_map; /* cache of HOST_PORTS_IMPL reg */
+	u32			dev_map; /* connected devices */
 };
 
 struct ahci_port_priv {
@@ -195,15 +201,30 @@ static void ahci_scr_write (struct ata_p
 static int ahci_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc);
 static irqreturn_t ahci_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
+static int ahci_start_engine(void __iomem *port_mmio);
+static int ahci_stop_engine(void __iomem *port_mmio);
+static int ahci_stop_fis_rx(void __iomem *port_mmio);
+static void ahci_start_fis_rx(void __iomem *port_mmio,
+			     struct ahci_port_priv *pp,
+			     struct ahci_host_priv *hpriv);
 static int ahci_probe_reset(struct ata_port *ap, unsigned int *classes);
 static void ahci_irq_clear(struct ata_port *ap);
 static void ahci_eng_timeout(struct ata_port *ap);
 static int ahci_port_start(struct ata_port *ap);
 static void ahci_port_stop(struct ata_port *ap);
+static int ahci_port_suspend(struct ata_port *ap, pm_message_t state);
+static int ahci_port_resume(struct ata_port *ap);
+static int ahci_port_standby(void __iomem *port_mmio, u32 cap);
+static int ahci_port_spinup(void __iomem *port_mmio, u32 cap);
+static void ahci_port_disable(struct ata_port *ap);
 static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static u8 ahci_check_status(struct ata_port *ap);
 static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
+static int ahci_scsi_device_suspend(struct scsi_device *sdev, pm_message_t state);
+static int ahci_scsi_device_resume(struct scsi_device *sdev);
+static int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t state);
+static int ahci_pci_device_resume(struct pci_dev *pdev);
 static void ahci_remove_one (struct pci_dev *pdev);
 
 static struct scsi_host_template ahci_sht = {
@@ -221,10 +242,12 @@ static struct scsi_host_template ahci_sh
 	.dma_boundary		= AHCI_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ahci_scsi_device_resume,
+	.suspend		= ahci_scsi_device_suspend,
 };
 
 static const struct ata_port_operations ahci_ops = {
-	.port_disable		= ata_port_disable,
+	.port_disable		= ahci_port_disable,
 
 	.check_status		= ahci_check_status,
 	.check_altstatus	= ahci_check_status,
@@ -321,6 +344,8 @@ static struct pci_driver ahci_pci_driver
 	.id_table		= ahci_pci_tbl,
 	.probe			= ahci_init_one,
 	.remove			= ahci_remove_one,
+	.suspend		= ahci_pci_device_suspend,
+	.resume			= ahci_pci_device_resume,
 };
 

@@ -394,21 +419,23 @@ static int ahci_port_start(struct ata_po
 
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
-
-	writel(PORT_CMD_ICC_ACTIVE | PORT_CMD_FIS_RX |
-	       PORT_CMD_POWER_ON | PORT_CMD_SPIN_UP |
-	       PORT_CMD_START, port_mmio + PORT_CMD);
-	readl(port_mmio + PORT_CMD); /* flush */
-
+	/*
+	 * Driver is setup; initialize the HBA
+	 */
+	ahci_start_fis_rx(port_mmio, pp, hpriv);
+	rc = ahci_port_spinup(port_mmio, hpriv->cap);
+	if (rc)
+		printk(KERN_WARNING "ata%d: could not spinup device (%d)\n",
+		       ap->id, rc);
+ 
+	/*
+	 * Do not enable DMA here; according to the spec
+	 * (section 10.1.1) we should first enable FIS reception,
+	 * then check if the port is enabled before we try to 
+	 * switch on DMA.
+	 * And as the port check is done during probe
+	 * we really shouldn't be doing it here.
+	 */
 	return 0;
 }
 
@@ -417,19 +444,8 @@ static void ahci_port_stop(struct ata_po
 {
 	struct device *dev = ap->host_set->dev;
 	struct ahci_port_priv *pp = ap->private_data;
-	void __iomem *mmio = ap->host_set->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
-	u32 tmp;
-
-	tmp = readl(port_mmio + PORT_CMD);
-	tmp &= ~(PORT_CMD_START | PORT_CMD_FIS_RX);
-	writel(tmp, port_mmio + PORT_CMD);
-	readl(port_mmio + PORT_CMD); /* flush */
 
-	/* spec says 500 msecs for each PORT_CMD_{START,FIS_RX} bit, so
-	 * this is slightly incorrect.
-	 */
-	msleep(500);
+	ahci_port_suspend(ap, PMSG_SUSPEND);
 
 	ap->private_data = NULL;
 	dma_free_coherent(dev, AHCI_PORT_PRIV_DMA_SZ,
@@ -438,6 +454,106 @@ static void ahci_port_stop(struct ata_po
 	kfree(pp);
 }
 
+static int ahci_port_suspend(struct ata_port *ap, pm_message_t state)
+{
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	struct ahci_host_priv *hpriv = ap->host_set->private_data;
+	int rc;
+
+	/*
+	 * Disable DMA
+	 */
+	rc = ahci_stop_engine(port_mmio);
+	if (rc) {
+		printk(KERN_WARNING "ata%u: DMA engine busy\n", ap->id);
+		return rc;
+	}
+
+	/*
+	 * Disable FIS reception
+	 */
+	rc = ahci_stop_fis_rx(port_mmio);
+	if (rc)
+		printk(KERN_WARNING "ata%d: FIS RX still running (rc %d)\n",
+		       ap->id, rc);
+
+	/*
+	 * Put device into slumber mode
+	 */
+	if (!rc && state.event != PM_EVENT_FREEZE)
+		ahci_port_standby(port_mmio, hpriv->cap);
+
+	return rc;
+}
+
+static int ahci_port_resume(struct ata_port *ap)
+{
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	struct ahci_host_priv *hpriv = ap->host_set->private_data;
+	struct ahci_port_priv *pp = ap->private_data;
+	int rc;
+	u32 tmp;
+
+	/*
+	 * Enable FIS reception
+	 */
+	ahci_start_fis_rx(port_mmio, pp, hpriv);
+
+	rc = ahci_port_spinup(port_mmio, hpriv->cap);
+	if (rc)
+		printk(KERN_WARNING "ata%d: could not spinup device (%d)\n",
+		       ap->id, rc);
+
+	/*
+	 * Clear error status
+	 */
+	tmp = readl(port_mmio + PORT_SCR_ERR);
+	writel(tmp, port_mmio + PORT_SCR_ERR);
+	/*
+	 * Clear interrupt status
+	 */
+	tmp = readl(mmio + HOST_CTL);
+	if (!(tmp & HOST_IRQ_EN)) {
+		u32 irq_stat;
+
+		/* ack any pending irq events for this port */
+		irq_stat = readl(port_mmio + PORT_IRQ_STAT);
+		if (irq_stat)
+			writel(irq_stat, port_mmio + PORT_IRQ_STAT);
+
+		/* set irq mask (enables interrupts) */
+		writel(DEF_PORT_IRQ, port_mmio + PORT_IRQ_MASK);
+
+		if ((hpriv->dev_map >> (ap->port_no + 1)) == 0) {
+			/*
+			 * Enable interrupts if this was the last port
+			 */
+			printk(KERN_WARNING "ata%d: enabling interrupts\n",
+			       ap->id);
+
+			irq_stat = readl(mmio + HOST_IRQ_STAT);
+			if (irq_stat)
+				writel(irq_stat, mmio + HOST_IRQ_STAT);
+
+			tmp |= HOST_IRQ_EN;
+			writel(tmp, mmio + HOST_CTL);
+			(void) readl(mmio + HOST_CTL);
+		}
+	}
+
+	/*
+	 * Enable DMA
+	 */
+	rc = ahci_start_engine(port_mmio);
+	if (rc)
+		printk(KERN_WARNING "ata%d: cannot start DMA engine (rc %d)\n",
+		       ap->id, rc);
+
+	return rc;
+}
+
 static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg_in)
 {
 	unsigned int sc_reg;
@@ -472,19 +588,22 @@ static void ahci_scr_write (struct ata_p
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
+	/* Check if the HBA is idle */
+	if ((tmp & (PORT_CMD_START | PORT_CMD_LIST_ON)) == 0)
+		return 0;
+
+	/* Setting HBA to idle */
 	tmp &= ~PORT_CMD_START;
 	writel(tmp, port_mmio + PORT_CMD);
 
-	/* wait for engine to stop.  TODO: this could be
-	 * as long as 500 msec
+	/*
+	 * wait for engine to become idle
 	 */
 	work = 1000;
 	while (work-- > 0) {
@@ -497,16 +616,233 @@ static int ahci_stop_engine(struct ata_p
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
+}
+
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
+static void ahci_port_disable(struct ata_port *ap)
+{
+	struct ahci_host_priv *hpriv = ap->host_set->private_data;
+
+	ata_port_disable(ap);
+
+	hpriv->dev_map &= ~(1 << ap->port_no);
 }
 
 static unsigned int ahci_dev_classify(struct ata_port *ap)
@@ -574,7 +910,7 @@ static int ahci_softreset(struct ata_por
 	}
 
 	/* prepare for SRST (AHCI-1.1 10.4.1) */
-	rc = ahci_stop_engine(ap);
+	rc = ahci_stop_engine(port_mmio);
 	if (rc) {
 		reason = "failed to stop engine";
 		goto fail_restart;
@@ -595,7 +931,7 @@ static int ahci_softreset(struct ata_por
 	}
 
 	/* restart engine */
-	ahci_start_engine(ap);
+	ahci_start_engine(port_mmio);
 
 	ata_tf_init(ap, &tf, 0);
 	fis = pp->cmd_tbl;
@@ -653,7 +989,7 @@ static int ahci_softreset(struct ata_por
 	return 0;
 
  fail_restart:
-	ahci_start_engine(ap);
+	ahci_start_engine(port_mmio);
  fail:
 	printk(KERN_ERR "ata%u: softreset failed (%s)\n",
 	       ap->id, reason);
@@ -662,13 +998,15 @@ static int ahci_softreset(struct ata_por
 
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
 
 	if (rc == 0)
 		*class = ahci_dev_classify(ap);
@@ -682,6 +1020,7 @@ static int ahci_hardreset(struct ata_por
 static void ahci_postreset(struct ata_port *ap, unsigned int *class)
 {
 	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	struct ahci_host_priv *hpriv = ap->host_set->private_data;
 	u32 new_tmp, tmp;
 
 	ata_std_postreset(ap, class);
@@ -696,6 +1035,9 @@ static void ahci_postreset(struct ata_po
 		writel(new_tmp, port_mmio + PORT_CMD);
 		readl(port_mmio + PORT_CMD); /* flush */
 	}
+
+	if (*class != ATA_DEV_NONE)
+		hpriv->dev_map |= (1 << ap->port_no);
 }
 
 static int ahci_probe_reset(struct ata_port *ap, unsigned int *classes)
@@ -810,7 +1152,7 @@ static void ahci_restart_port(struct ata
 			readl(port_mmio + PORT_SCR_ERR));
 
 	/* stop DMA */
-	ahci_stop_engine(ap);
+	ahci_stop_engine(port_mmio);
 
 	/* clear SATA phy error, if any */
 	tmp = readl(port_mmio + PORT_SCR_ERR);
@@ -829,7 +1171,7 @@ static void ahci_restart_port(struct ata
 	}
 
 	/* re-start DMA */
-	ahci_start_engine(ap);
+	ahci_start_engine(port_mmio);
 }
 
 static void ahci_eng_timeout(struct ata_port *ap)
@@ -853,6 +1195,71 @@ static void ahci_eng_timeout(struct ata_
 	ata_eh_qc_complete(qc);
 }
 
+int ahci_scsi_device_suspend(struct scsi_device *sdev, pm_message_t state)
+{
+	struct ata_port *ap = (struct ata_port *) &sdev->host->hostdata[0];
+	struct ata_device *dev = &ap->device[sdev->id];
+	int rc;
+
+	rc = ata_device_suspend(ap, dev, state);
+
+	if (!rc)
+		rc = ahci_port_suspend(ap, state);
+
+	return rc;
+}
+
+int ahci_scsi_device_resume(struct scsi_device *sdev)
+{
+	struct ata_port *ap = (struct ata_port *) &sdev->host->hostdata[0];
+	struct ata_device *dev = &ap->device[sdev->id];
+
+	ahci_port_resume(ap);
+
+	return ata_device_resume(ap, dev);
+}
+
+int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct device *dev = pci_dev_to_dev(pdev);
+	struct ata_host_set *host_set = dev_get_drvdata(dev);
+	void __iomem *mmio = host_set->mmio_base;
+	u32 tmp;
+
+	/*
+	 * AHCI spec rev1.1 section 8.3.3:
+	 * Software must disable interrupts prior to
+	 * requesting a transition of the HBA to
+	 * D3 state.
+	 */
+	tmp = readl(mmio + HOST_CTL);
+	tmp &= ~HOST_IRQ_EN;
+	writel(tmp, mmio + HOST_CTL);
+	tmp = readl(mmio + HOST_CTL); /* flush */
+
+	return ata_pci_device_suspend(pdev, state);
+}
+
+int ahci_pci_device_resume(struct pci_dev *pdev)
+{
+	struct device *dev = pci_dev_to_dev(pdev);
+	struct ata_host_set *host_set = dev_get_drvdata(dev);
+	void __iomem *mmio = host_set->mmio_base;
+	u32 tmp;
+
+	/*
+	 * Enabling AHCI mode
+	 */
+	tmp = readl(mmio + HOST_CTL);
+	if (!(tmp & HOST_AHCI_EN)) {
+		tmp |= HOST_AHCI_EN;
+		writel(tmp, mmio + HOST_CTL);
+		tmp = readl(mmio + HOST_CTL);
+	}
+
+	return ata_pci_device_resume(pdev);
+}
+
 static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
 {
 	void __iomem *mmio = ap->host_set->mmio_base;
@@ -1033,6 +1440,7 @@ static int ahci_host_init(struct ata_pro
 
 	hpriv->cap = readl(mmio + HOST_CAP);
 	hpriv->port_map = readl(mmio + HOST_PORTS_IMPL);
+	hpriv->dev_map = 0;
 	probe_ent->n_ports = (hpriv->cap & 0x1f) + 1;
 
 	VPRINTK("cap 0x%x  port_map 0x%x  n_ports %d\n",
@@ -1078,23 +1486,29 @@ static int ahci_host_init(struct ata_pro
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
+		rc = ahci_stop_engine(port_mmio);
+		if (rc)
+			printk(KERN_WARNING "ata%u: DMA engine busy (rc %d)\n",
+			       i, rc);
+
+		rc = ahci_stop_fis_rx(port_mmio);
+		if (rc)
+			printk(KERN_WARNING "ata%u: FIS RX not stopped (rc %d)\n",
+			       i, rc);
+
+		/*
+		 * Actually, this is wrong again.
+		 * AHCI spec says that we first should
+		 * enable FIS reception before sending
+		 * SPIN_UP to the device ...
+		 */
 
 		writel(PORT_CMD_SPIN_UP, port_mmio + PORT_CMD);
 
+		/*
+		 * Wait for the communications link to establish
+		 */
+
 		j = 0;
 		while (j < 100) {
 			msleep(10);
-- 
1.2.6
