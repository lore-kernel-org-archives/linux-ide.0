From: Shane Huang <shane.huang@amd.com>
Subject: [PATCH #upstream, v3] ahci: Implement SATA AHCI FIS-based
 switching support
Date: Tue, 8 Sep 2009 17:28:25 +0800
Message-ID: <1252402105.3514.7.camel@zm-desktop>
Reply-To: shane.huang@amd.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:46914
	"EHLO VA3EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754127AbZIHJ2k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Sep 2009 05:28:40 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, tj@kernel.org
Cc: linux-ide@vger.kernel.org, "Huang, Shane" <Shane.Huang@amd.com>

Implement SATA AHCI FIS-based switching support.

Tested on AMD internal reference board.

Signed-off-by: Shane Huang <shane.huang@amd.com>
Cc: Tejun Heo <tj@kernel.org>
---
Changes from the last version(v2):
* Move fbs_need_dec from struct ahci_port_priv to ahci_error_intr() as
  a local variable.
* Add BUG_ON(!pp->fbs_enabled) for ahci_fbs_dec_intr().
* Refine the retry loop in ahci_fbs_dec_intr().
* Refine the code to determine failed active link with ap->pmp_link in
  ahci_error_intr().
* WARN_ON() in ahci_port_intr() can storm the machine with consecutive
  stack dumps, replace it with WARN_ON_ONCE().
* Refine ahci_enable_fbs()/ahci_disable_fbs(), and discard the message
  for controllers which do not support FBS.
* Add a warning message in ahci_port_start() for those weird controllers
  which support CAP.FBSS but do not support PxCMD.FBSCP.
* Several small corrections for better coding style.

 drivers/ata/ahci.c |  225 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 206 insertions(+), 19 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 273f50b..2f9a4fa 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -93,6 +93,9 @@ enum {
 	AHCI_CMD_TBL_AR_SZ	= AHCI_CMD_TBL_SZ * AHCI_MAX_CMDS,
 	AHCI_PORT_PRIV_DMA_SZ	= AHCI_CMD_SLOT_SZ + AHCI_CMD_TBL_AR_SZ +
 				  AHCI_RX_FIS_SZ,
+	AHCI_PORT_PRIV_FBS_DMA_SZ	= AHCI_CMD_SLOT_SZ +
+					  AHCI_CMD_TBL_AR_SZ +
+					  (AHCI_RX_FIS_SZ * 16),
 	AHCI_IRQ_ON_SG		= (1 << 31),
 	AHCI_CMD_ATAPI		= (1 << 5),
 	AHCI_CMD_WRITE		= (1 << 6),
@@ -132,6 +135,7 @@ enum {
 	HOST_CAP_EMS		= (1 << 6),  /* Enclosure Management support */
 	HOST_CAP_SSC		= (1 << 14), /* Slumber capable */
 	HOST_CAP_PMP		= (1 << 17), /* Port Multiplier support */
+	HOST_CAP_FBS		= (1 << 16), /* FIS-based Switching support */
 	HOST_CAP_CLO		= (1 << 24), /* Command List Override support */
 	HOST_CAP_ALPM		= (1 << 26), /* Aggressive Link PM support */
 	HOST_CAP_SSS		= (1 << 27), /* Staggered Spin-up */
@@ -155,6 +159,7 @@ enum {
 	PORT_SCR_ERR		= 0x30, /* SATA phy register: SError */
 	PORT_SCR_ACT		= 0x34, /* SATA phy register: SActive */
 	PORT_SCR_NTF		= 0x3c, /* SATA phy register: SNotification */
+	PORT_FBS		= 0x40, /* FIS-based Switching */
 
 	/* PORT_IRQ_{STAT,MASK} bits */
 	PORT_IRQ_COLD_PRES	= (1 << 31), /* cold presence detect */
@@ -193,6 +198,7 @@ enum {
 	PORT_CMD_ASP		= (1 << 27), /* Aggressive Slumber/Partial */
 	PORT_CMD_ALPE		= (1 << 26), /* Aggressive Link PM enable */
 	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
+	PORT_CMD_FBSCP		= (1 << 22), /* FBS Capable Port */
 	PORT_CMD_PMP		= (1 << 17), /* PMP attached */
 	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
 	PORT_CMD_FIS_ON		= (1 << 14), /* FIS DMA engine running */
@@ -207,6 +213,14 @@ enum {
 	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
 	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
 
+	PORT_FBS_DWE_OFFSET	= 16, /* FBS device with error offset */
+	PORT_FBS_ADO_OFFSET	= 12, /* FBS active dev optimization offset */
+	PORT_FBS_DEV_OFFSET	= 8,  /* FBS device to issue offset */
+	PORT_FBS_DEV_MASK	= (0xf << PORT_FBS_DEV_OFFSET),  /* FBS.DEV */
+	PORT_FBS_SDE		= (1 << 2), /* FBS single device error */
+	PORT_FBS_DEC		= (1 << 1), /* FBS device error clear */
+	PORT_FBS_EN		= (1 << 0), /* Enable FBS */
+
 	/* hpriv->flags bits */
 	AHCI_HFLAG_NO_NCQ		= (1 << 0),
 	AHCI_HFLAG_IGN_IRQ_IF_ERR	= (1 << 1), /* ignore IRQ_IF_ERR */
@@ -286,6 +300,9 @@ struct ahci_port_priv {
 	unsigned int		ncq_saw_dmas:1;
 	unsigned int		ncq_saw_sdb:1;
 	u32 			intr_mask;	/* interrupts to enable */
+	bool			fbs_supported;	/* set iff FBS is supported */
+	bool			fbs_enabled;	/* set iff FBS is enabled */
+	int			fbs_last_dev;	/* save FBS.DEV of last FIS */
 	/* enclosure management info per PM slot */
 	struct ahci_em_priv	em_priv[EM_MAX_SLOTS];
 };
@@ -297,9 +314,12 @@ static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc);
 static bool ahci_qc_fill_rtf(struct ata_queued_cmd *qc);
 static int ahci_port_start(struct ata_port *ap);
 static void ahci_port_stop(struct ata_port *ap);
+static int ahci_pmp_qc_defer(struct ata_queued_cmd *qc);
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static void ahci_freeze(struct ata_port *ap);
 static void ahci_thaw(struct ata_port *ap);
+static void ahci_enable_fbs(struct ata_port *ap);
+static void ahci_disable_fbs(struct ata_port *ap);
 static void ahci_pmp_attach(struct ata_port *ap);
 static void ahci_pmp_detach(struct ata_port *ap);
 static int ahci_softreset(struct ata_link *link, unsigned int *class,
@@ -354,7 +374,7 @@ static struct scsi_host_template ahci_sht = {
 static struct ata_port_operations ahci_ops = {
 	.inherits		= &sata_pmp_port_ops,
 
-	.qc_defer		= sata_pmp_qc_defer_cmd_switch,
+	.qc_defer		= ahci_pmp_qc_defer,
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
 	.qc_fill_rtf		= ahci_qc_fill_rtf,
@@ -1936,6 +1956,17 @@ static unsigned int ahci_fill_sg(struct ata_queued_cmd *qc, void *cmd_tbl)
 	return si;
 }
 
+static int ahci_pmp_qc_defer(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct ahci_port_priv *pp = ap->private_data;
+
+	if (!sata_pmp_attached(ap) || pp->fbs_enabled)
+		return ata_std_qc_defer(qc);
+	else
+		return sata_pmp_qc_defer_cmd_switch(qc);
+}
+
 static void ahci_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
@@ -1974,6 +2005,31 @@ static void ahci_qc_prep(struct ata_queued_cmd *qc)
 	ahci_fill_cmd_slot(pp, qc->tag, opts);
 }
 
+static void ahci_fbs_dec_intr(struct ata_port *ap)
+{
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *port_mmio = ahci_port_base(ap);
+	u32 fbs = readl(port_mmio + PORT_FBS);
+	int retries = 3;
+
+	DPRINTK("ENTER\n");
+	BUG_ON(!pp->fbs_enabled);
+
+	/* time to wait for DEC is not specified by AHCI spec,
+	 * add a retry loop for safety.
+	 */
+	writel(fbs | PORT_FBS_DEC, port_mmio + PORT_FBS);
+	fbs = readl(port_mmio + PORT_FBS);
+	while ((fbs & PORT_FBS_DEC) && retries--) {
+		udelay(1);
+		fbs = readl(port_mmio + PORT_FBS);
+	}
+
+	if (fbs & PORT_FBS_DEC)
+		dev_printk(KERN_ERR, ap->host->dev,
+			   "failed to clear device error\n");
+}
+
 static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 {
 	struct ahci_host_priv *hpriv = ap->host->private_data;
@@ -1982,12 +2038,26 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 	struct ata_link *link = NULL;
 	struct ata_queued_cmd *active_qc;
 	struct ata_eh_info *active_ehi;
+	bool fbs_need_dec = false;
 	u32 serror;
 
-	/* determine active link */
-	ata_for_each_link(link, ap, EDGE)
-		if (ata_link_active(link))
-			break;
+	/* determine active link with error */
+	if (pp->fbs_enabled) {
+		void __iomem *port_mmio = ahci_port_base(ap);
+		u32 fbs = readl(port_mmio + PORT_FBS);
+		int pmp = fbs >> PORT_FBS_DWE_OFFSET;
+
+		if ((fbs & PORT_FBS_SDE) && (pmp < ap->nr_pmp_links) &&
+		    ata_link_online(&ap->pmp_link[pmp])) {
+			link = &ap->pmp_link[pmp];
+			fbs_need_dec = true;
+		}
+
+	} else
+		ata_for_each_link(link, ap, EDGE)
+			if (ata_link_active(link))
+				break;
+
 	if (!link)
 		link = &ap->link;
 
@@ -2044,8 +2114,13 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 	}
 
 	if (irq_stat & PORT_IRQ_IF_ERR) {
-		host_ehi->err_mask |= AC_ERR_ATA_BUS;
-		host_ehi->action |= ATA_EH_RESET;
+		if (fbs_need_dec)
+			active_ehi->err_mask |= AC_ERR_DEV;
+		else {
+			host_ehi->err_mask |= AC_ERR_ATA_BUS;
+			host_ehi->action |= ATA_EH_RESET;
+		}
+
 		ata_ehi_push_desc(host_ehi, "interface fatal error");
 	}
 
@@ -2060,7 +2135,10 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 
 	if (irq_stat & PORT_IRQ_FREEZE)
 		ata_port_freeze(ap);
-	else
+	else if (fbs_need_dec) {
+		ata_link_abort(link);
+		ahci_fbs_dec_intr(ap);
+	} else
 		ata_port_abort(ap);
 }
 
@@ -2113,12 +2191,19 @@ static void ahci_port_intr(struct ata_port *ap)
 			/* If the 'N' bit in word 0 of the FIS is set,
 			 * we just received asynchronous notification.
 			 * Tell libata about it.
+			 *
+			 * Lack of SNotification should not appear in
+			 * ahci 1.2, so the workaround is unnecessary
+			 * when FBS is enabled.
 			 */
-			const __le32 *f = pp->rx_fis + RX_FIS_SDB;
-			u32 f0 = le32_to_cpu(f[0]);
-
-			if (f0 & (1 << 15))
-				sata_async_notification(ap);
+			if (pp->fbs_enabled)
+				WARN_ON_ONCE(1);
+			else {
+				const __le32 *f = pp->rx_fis + RX_FIS_SDB;
+				u32 f0 = le32_to_cpu(f[0]);
+				if (f0 & (1 << 15))
+					sata_async_notification(ap);
+			}
 		}
 	}
 
@@ -2212,6 +2297,15 @@ static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc)
 
 	if (qc->tf.protocol == ATA_PROT_NCQ)
 		writel(1 << qc->tag, port_mmio + PORT_SCR_ACT);
+
+	if (pp->fbs_enabled && pp->fbs_last_dev != qc->dev->link->pmp) {
+		u32 fbs = readl(port_mmio + PORT_FBS);
+		fbs &= ~(PORT_FBS_DEV_MASK | PORT_FBS_DEC);
+		fbs |= qc->dev->link->pmp << PORT_FBS_DEV_OFFSET;
+		writel(fbs, port_mmio + PORT_FBS);
+		pp->fbs_last_dev = qc->dev->link->pmp;
+	}
+
 	writel(1 << qc->tag, port_mmio + PORT_CMD_ISSUE);
 
 	ahci_sw_activity(qc->dev->link);
@@ -2224,6 +2318,9 @@ static bool ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
 	struct ahci_port_priv *pp = qc->ap->private_data;
 	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
 
+	if (pp->fbs_enabled)
+		d2h_fis += qc->dev->link->pmp * AHCI_RX_FIS_SZ;
+
 	ata_tf_from_fis(d2h_fis, &qc->result_tf);
 	return true;
 }
@@ -2272,6 +2369,71 @@ static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
 		ahci_kick_engine(ap);
 }
 
+static void ahci_enable_fbs(struct ata_port *ap)
+{
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *port_mmio = ahci_port_base(ap);
+	u32 fbs;
+	int rc;
+
+	if (!pp->fbs_supported)
+		return;
+
+	fbs = readl(port_mmio + PORT_FBS);
+	if (fbs & PORT_FBS_EN) {
+		pp->fbs_enabled = true;
+		pp->fbs_last_dev = -1; /* initialization */
+		return;
+	}
+
+	rc = ahci_stop_engine(ap);
+	if (rc)
+		return;
+
+	writel(fbs | PORT_FBS_EN, port_mmio + PORT_FBS);
+	fbs = readl(port_mmio + PORT_FBS);
+	if (fbs & PORT_FBS_EN) {
+		dev_printk(KERN_INFO, ap->host->dev, "FBS is enabled.\n");
+		pp->fbs_enabled = true;
+		pp->fbs_last_dev = -1; /* initialization */
+	} else
+		dev_printk(KERN_ERR, ap->host->dev, "Failed to enable FBS\n");
+
+	ahci_start_engine(ap);
+}
+
+static void ahci_disable_fbs(struct ata_port *ap)
+{
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *port_mmio = ahci_port_base(ap);
+	u32 fbs;
+	int rc;
+
+	if (!pp->fbs_supported)
+		return;
+
+	fbs = readl(port_mmio + PORT_FBS);
+	if ((fbs & PORT_FBS_EN) == 0) {
+		pp->fbs_enabled = false;
+		return;
+	}
+
+	rc = ahci_stop_engine(ap);
+	if (rc)
+		return;
+
+	writel(fbs & ~PORT_FBS_EN, port_mmio + PORT_FBS);
+	fbs = readl(port_mmio + PORT_FBS);
+	if (fbs & PORT_FBS_EN)
+		dev_printk(KERN_ERR, ap->host->dev, "Failed to disable FBS\n");
+	else {
+		dev_printk(KERN_INFO, ap->host->dev, "FBS is disabled.\n");
+		pp->fbs_enabled = false;
+	}
+
+	ahci_start_engine(ap);
+}
+
 static void ahci_pmp_attach(struct ata_port *ap)
 {
 	void __iomem *port_mmio = ahci_port_base(ap);
@@ -2282,6 +2444,8 @@ static void ahci_pmp_attach(struct ata_port *ap)
 	cmd |= PORT_CMD_PMP;
 	writel(cmd, port_mmio + PORT_CMD);
 
+	ahci_enable_fbs(ap);
+
 	pp->intr_mask |= PORT_IRQ_BAD_PMP;
 	writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
 }
@@ -2292,6 +2456,8 @@ static void ahci_pmp_detach(struct ata_port *ap)
 	struct ahci_port_priv *pp = ap->private_data;
 	u32 cmd;
 
+	ahci_disable_fbs(ap);
+
 	cmd = readl(port_mmio + PORT_CMD);
 	cmd &= ~PORT_CMD_PMP;
 	writel(cmd, port_mmio + PORT_CMD);
@@ -2383,20 +2549,40 @@ static int ahci_pci_device_resume(struct pci_dev *pdev)
 
 static int ahci_port_start(struct ata_port *ap)
 {
+	struct ahci_host_priv *hpriv = ap->host->private_data;
 	struct device *dev = ap->host->dev;
 	struct ahci_port_priv *pp;
 	void *mem;
 	dma_addr_t mem_dma;
+	size_t dma_sz, rx_fis_sz;
 
 	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
 	if (!pp)
 		return -ENOMEM;
 
-	mem = dmam_alloc_coherent(dev, AHCI_PORT_PRIV_DMA_SZ, &mem_dma,
-				  GFP_KERNEL);
+	/* check FBS capability */
+	if ((hpriv->cap & HOST_CAP_FBS) && sata_pmp_supported(ap)) {
+		void __iomem *port_mmio = ahci_port_base(ap);
+		u32 cmd = readl(port_mmio + PORT_CMD);
+		if (cmd & PORT_CMD_FBSCP)
+			pp->fbs_supported = true;
+		else
+			dev_printk(KERN_WARNING, dev,
+				   "The port is not capable of FBS\n");
+	}
+
+	if (pp->fbs_supported) {
+		dma_sz = AHCI_PORT_PRIV_FBS_DMA_SZ;
+		rx_fis_sz = AHCI_RX_FIS_SZ * 16;
+	} else {
+		dma_sz = AHCI_PORT_PRIV_DMA_SZ;
+		rx_fis_sz = AHCI_RX_FIS_SZ;
+	}
+
+	mem = dmam_alloc_coherent(dev, dma_sz, &mem_dma, GFP_KERNEL);
 	if (!mem)
 		return -ENOMEM;
-	memset(mem, 0, AHCI_PORT_PRIV_DMA_SZ);
+	memset(mem, 0, dma_sz);
 
 	/*
 	 * First item in chunk of DMA memory: 32-slot command table,
@@ -2414,8 +2600,8 @@ static int ahci_port_start(struct ata_port *ap)
 	pp->rx_fis = mem;
 	pp->rx_fis_dma = mem_dma;
 
-	mem += AHCI_RX_FIS_SZ;
-	mem_dma += AHCI_RX_FIS_SZ;
+	mem += rx_fis_sz;
+	mem_dma += rx_fis_sz;
 
 	/*
 	 * Third item: data area for storing a single command
@@ -2533,7 +2719,7 @@ static void ahci_print_info(struct ata_host *host)
 		"flags: "
 		"%s%s%s%s%s%s%s"
 		"%s%s%s%s%s%s%s"
-		"%s\n"
+		"%s%s\n"
 		,
 
 		cap & (1 << 31) ? "64bit " : "",
@@ -2548,6 +2734,7 @@ static void ahci_print_info(struct ata_host *host)
 		cap & (1 << 19) ? "nz " : "",
 		cap & (1 << 18) ? "only " : "",
 		cap & (1 << 17) ? "pmp " : "",
+		cap & (1 << 16) ? "fbs " : "",
 		cap & (1 << 15) ? "pio " : "",
 		cap & (1 << 14) ? "slum " : "",
 		cap & (1 << 13) ? "part " : "",


