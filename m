From: Shane Huang <shane.huang@amd.com>
Subject: [PATCH] Implement SATA AHCI FIS-based switching support
Date: Thu, 30 Jul 2009 17:59:48 +0800
Message-ID: <1248947988.3341.5.camel@zm-desktop>
Reply-To: shane.huang@amd.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sg2ehsobe005.messaging.microsoft.com ([207.46.51.79]:27306 "EHLO
	SG2EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752544AbZG3KAM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jul 2009 06:00:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, tj@kernel.org
Cc: linux-ide@vger.kernel.org, shane.huang@amd.com

Implement SATA AHCI FIS-based switching support.

Signed-off-by: Shane Huang <shane.huang@amd.com>

diff -ruNp a/drivers/ata/ahci.c b/drivers/ata/ahci.c
--- a/drivers/ata/ahci.c	2009-07-29 14:38:39.000000000 +0800
+++ b/drivers/ata/ahci.c	2009-07-30 17:10:40.000000000 +0800
@@ -93,6 +93,8 @@ enum {
 	AHCI_CMD_TBL_AR_SZ	= AHCI_CMD_TBL_SZ * AHCI_MAX_CMDS,
 	AHCI_PORT_PRIV_DMA_SZ	= AHCI_CMD_SLOT_SZ + AHCI_CMD_TBL_AR_SZ +
 				  AHCI_RX_FIS_SZ,
+	AHCI_PORT_PRIV_FBS_DMA	= AHCI_CMD_SLOT_SZ + AHCI_CMD_TBL_AR_SZ +
+				  (AHCI_RX_FIS_SZ * 16),
 	AHCI_IRQ_ON_SG		= (1 << 31),
 	AHCI_CMD_ATAPI		= (1 << 5),
 	AHCI_CMD_WRITE		= (1 << 6),
@@ -132,6 +134,7 @@ enum {
 	HOST_CAP_EMS		= (1 << 6),  /* Enclosure Management support */
 	HOST_CAP_SSC		= (1 << 14), /* Slumber capable */
 	HOST_CAP_PMP		= (1 << 17), /* Port Multiplier support */
+	HOST_CAP_FBS		= (1 << 16), /* FIS-based Switching support */
 	HOST_CAP_CLO		= (1 << 24), /* Command List Override support */
 	HOST_CAP_ALPM		= (1 << 26), /* Aggressive Link PM support */
 	HOST_CAP_SSS		= (1 << 27), /* Staggered Spin-up */
@@ -155,6 +158,7 @@ enum {
 	PORT_SCR_ERR		= 0x30, /* SATA phy register: SError */
 	PORT_SCR_ACT		= 0x34, /* SATA phy register: SActive */
 	PORT_SCR_NTF		= 0x3c, /* SATA phy register: SNotification */
+	PORT_FBS		= 0x40, /* FIS-based Switching */
 
 	/* PORT_IRQ_{STAT,MASK} bits */
 	PORT_IRQ_COLD_PRES	= (1 << 31), /* cold presence detect */
@@ -193,6 +197,7 @@ enum {
 	PORT_CMD_ASP		= (1 << 27), /* Aggressive Slumber/Partial */
 	PORT_CMD_ALPE		= (1 << 26), /* Aggressive Link PM enable */
 	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
+	PORT_CMD_FBSCP		= (1 << 22), /* FBS Capable Port */
 	PORT_CMD_PMP		= (1 << 17), /* PMP attached */
 	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
 	PORT_CMD_FIS_ON		= (1 << 14), /* FIS DMA engine running */
@@ -207,6 +212,14 @@ enum {
 	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
 	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
 
+	PORT_FBS_DWE_OFFSET	= 16, /* FBS device with error offset */
+	PORT_FBS_ADO_OFFSET	= 12, /* FBS active dev optimization offset */
+	PORT_FBS_DEV_OFFSET	= 8,  /* FBS device to issue offset */
+	PORT_FBS_DEV		= (0xf << PORT_FBS_DEV_OFFSET),  /* FBS.DEV */
+	PORT_FBS_SDE		= (1 << 2), /* FBS single device error */
+	PORT_FBS_DEC		= (1 << 1), /* FBS device error clear */
+	PORT_FBS_EN		= (1 << 0), /* Enable FBS */
+
 	/* hpriv->flags bits */
 	AHCI_HFLAG_NO_NCQ		= (1 << 0),
 	AHCI_HFLAG_IGN_IRQ_IF_ERR	= (1 << 1), /* ignore IRQ_IF_ERR */
@@ -284,6 +297,9 @@ struct ahci_port_priv {
 	unsigned int		ncq_saw_dmas:1;
 	unsigned int		ncq_saw_sdb:1;
 	u32 			intr_mask;	/* interrupts to enable */
+	int			fbs_enabled;	/* set iff FBS is enabled */
+	int			fbs_last_dev;	/* save FBS.DEV of last FIS */
+	int			fbs_need_dec;	/* need clear device error */
 	/* enclosure management info per PM slot */
 	struct ahci_em_priv	em_priv[EM_MAX_SLOTS];
 };
@@ -295,9 +311,13 @@ static unsigned int ahci_qc_issue(struct
 static bool ahci_qc_fill_rtf(struct ata_queued_cmd *qc);
 static int ahci_port_start(struct ata_port *ap);
 static void ahci_port_stop(struct ata_port *ap);
+static int ahci_pmp_qc_defer(struct ata_queued_cmd *qc);
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static void ahci_freeze(struct ata_port *ap);
 static void ahci_thaw(struct ata_port *ap);
+static int ahci_fbs_supported(struct ata_port *ap);
+static int ahci_enable_fbs(struct ata_port *ap);
+static int ahci_disable_fbs(struct ata_port *ap);
 static void ahci_pmp_attach(struct ata_port *ap);
 static void ahci_pmp_detach(struct ata_port *ap);
 static int ahci_softreset(struct ata_link *link, unsigned int *class,
@@ -311,6 +331,7 @@ static int ahci_vt8251_hardreset(struct 
 static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
 				unsigned long deadline);
 static void ahci_postreset(struct ata_link *link, unsigned int *class);
+static int ahci_eh_fbs_dec(struct ata_port *ap);
 static void ahci_error_handler(struct ata_port *ap);
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc);
 static int ahci_port_resume(struct ata_port *ap);
@@ -352,7 +373,7 @@ static struct scsi_host_template ahci_sh
 static struct ata_port_operations ahci_ops = {
 	.inherits		= &sata_pmp_port_ops,
 
-	.qc_defer		= sata_pmp_qc_defer_cmd_switch,
+	.qc_defer		= ahci_pmp_qc_defer,
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
 	.qc_fill_rtf		= ahci_qc_fill_rtf,
@@ -1582,12 +1603,21 @@ static int ahci_kick_engine(struct ata_p
 {
 	void __iomem *port_mmio = ahci_port_base(ap);
 	struct ahci_host_priv *hpriv = ap->host->private_data;
-	u8 status = readl(port_mmio + PORT_TFDATA) & 0xFF;
+	struct ahci_port_priv *pp = ap->private_data;
+	u8 status;
 	u32 tmp;
 	int busy, rc;
 
-	/* do we need to kick the port? */
-	busy = status & (ATA_BUSY | ATA_DRQ);
+	/* do we need to kick the port?
+	 * It is unsafe to refer to PxTFD register to determine
+	 * command completion when doing FBS. (AHCI-1.2 9.3.7)
+	 */
+	if (pp->fbs_enabled && (ap->nr_active_links >= 2))
+		busy = readl(port_mmio + PORT_CMD_ISSUE);
+	else {
+		status = readl(port_mmio + PORT_TFDATA) & 0xFF;
+		busy = status & (ATA_BUSY | ATA_DRQ);
+	}
 	if (!busy && !force_restart)
 		return 0;
 
@@ -1714,8 +1744,20 @@ static int ahci_do_softreset(struct ata_
 
 static int ahci_check_ready(struct ata_link *link)
 {
-	void __iomem *port_mmio = ahci_port_base(link->ap);
-	u8 status = readl(port_mmio + PORT_TFDATA) & 0xFF;
+	struct ata_port *ap = link->ap;
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *port_mmio = ahci_port_base(ap);
+	u8 status = 0;
+
+	/* It is unsafe to refer to PxTFD register to determine
+	 * command completion when doing FBS. (AHCI-1.2 9.3.7)
+	 */
+	if (pp->fbs_enabled && (ap->nr_active_links >= 2)) {
+		u32 tmp = readl(port_mmio + PORT_CMD_ISSUE);
+		if (tmp)
+			status |= ATA_BUSY;
+	} else
+		status = readl(port_mmio + PORT_TFDATA) & 0xFF;
 
 	return ata_check_ready(status);
 }
@@ -1732,8 +1774,10 @@ static int ahci_softreset(struct ata_lin
 
 static int ahci_sb600_check_ready(struct ata_link *link)
 {
-	void __iomem *port_mmio = ahci_port_base(link->ap);
-	u8 status = readl(port_mmio + PORT_TFDATA) & 0xFF;
+	struct ata_port *ap = link->ap;
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *port_mmio = ahci_port_base(ap);
+	u8 status = 0;
 	u32 irq_status = readl(port_mmio + PORT_IRQ_STAT);
 
 	/*
@@ -1743,6 +1787,16 @@ static int ahci_sb600_check_ready(struct
 	if (irq_status & PORT_IRQ_BAD_PMP)
 		return -EIO;
 
+	/* It is unsafe to refer to PxTFD register to determine
+	 * command completion when doing FBS. (AHCI-1.2 9.3.7)
+	 */
+	if (pp->fbs_enabled && (ap->nr_active_links >= 2)) {
+		u32 tmp = readl(port_mmio + PORT_CMD_ISSUE);
+		if (tmp)
+			status |= ATA_BUSY;
+	} else
+		status = readl(port_mmio + PORT_TFDATA) & 0xFF;
+
 	return ata_check_ready(status);
 }
 
@@ -1921,6 +1975,17 @@ static unsigned int ahci_fill_sg(struct 
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
@@ -1967,12 +2032,25 @@ static void ahci_error_intr(struct ata_p
 	struct ata_link *link = NULL;
 	struct ata_queued_cmd *active_qc;
 	struct ata_eh_info *active_ehi;
-	u32 serror;
+	void __iomem *port_mmio = ahci_port_base(ap);
+	u32 serror, fbs = 0;
+	int rc = 0;
 
-	/* determine active link */
+	if (pp->fbs_enabled)
+		fbs = readl(port_mmio + PORT_FBS);
+
+	/* determine active link with error */
 	ata_for_each_link(link, ap, EDGE)
-		if (ata_link_active(link))
-			break;
+		if (ata_link_active(link)) {
+			if (!pp->fbs_enabled)
+				break;
+			if ((fbs & PORT_FBS_SDE) &&
+			    (link->pmp == (fbs >> PORT_FBS_DWE_OFFSET)))
+				break;
+			rc = sata_scr_read(link, SCR_ERROR, &serror);
+			if ((rc == 0) && serror)
+				break;
+		}
 	if (!link)
 		link = &ap->link;
 
@@ -2004,6 +2082,9 @@ static void ahci_error_intr(struct ata_p
 
 		if (hpriv->flags & AHCI_HFLAG_IGN_SERR_INTERNAL)
 			host_ehi->serror &= ~SERR_INTERNAL;
+
+		if (pp->fbs_enabled && (fbs & PORT_FBS_SDE))
+			pp->fbs_need_dec = 1;
 	}
 
 	if (irq_stat & PORT_IRQ_UNK_FIS) {
@@ -2029,8 +2110,14 @@ static void ahci_error_intr(struct ata_p
 	}
 
 	if (irq_stat & PORT_IRQ_IF_ERR) {
-		host_ehi->err_mask |= AC_ERR_ATA_BUS;
-		host_ehi->action |= ATA_EH_RESET;
+		if (pp->fbs_enabled && (fbs & PORT_FBS_SDE)) {
+			active_ehi->err_mask |= AC_ERR_DEV;
+			pp->fbs_need_dec = 1;
+		} else {
+			host_ehi->err_mask |= AC_ERR_ATA_BUS;
+			host_ehi->action |= ATA_EH_RESET;
+		}
+
 		ata_ehi_push_desc(host_ehi, "interface fatal error");
 	}
 
@@ -2046,7 +2133,11 @@ static void ahci_error_intr(struct ata_p
 	if (irq_stat & PORT_IRQ_FREEZE)
 		ata_port_freeze(ap);
 	else
-		ata_port_abort(ap);
+		if (pp->fbs_enabled && pp->fbs_need_dec &&
+		    !ata_is_host_link(link))
+			ata_link_abort(link);
+		else
+			ata_port_abort(ap);
 }
 
 static void ahci_port_intr(struct ata_port *ap)
@@ -2098,12 +2189,17 @@ static void ahci_port_intr(struct ata_po
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
+			if (!pp->fbs_enabled) {
+				const __le32 *f = pp->rx_fis + RX_FIS_SDB;
+				u32 f0 = le32_to_cpu(f[0]);
+				if (f0 & (1 << 15))
+					sata_async_notification(ap);
+			}
 		}
 	}
 
@@ -2197,6 +2293,17 @@ static unsigned int ahci_qc_issue(struct
 
 	if (qc->tf.protocol == ATA_PROT_NCQ)
 		writel(1 << qc->tag, port_mmio + PORT_SCR_ACT);
+
+	if (pp->fbs_enabled) {
+		if (pp->fbs_last_dev != qc->dev->link->pmp) {
+			u32 fbs = readl(port_mmio + PORT_FBS);
+			fbs &= ~(PORT_FBS_DEV | PORT_FBS_DEC);
+			fbs |= qc->dev->link->pmp << PORT_FBS_DEV_OFFSET;
+			writel(fbs, port_mmio + PORT_FBS);
+			pp->fbs_last_dev = qc->dev->link->pmp;
+		}
+	}
+
 	writel(1 << qc->tag, port_mmio + PORT_CMD_ISSUE);
 
 	ahci_sw_activity(qc->dev->link);
@@ -2209,6 +2316,9 @@ static bool ahci_qc_fill_rtf(struct ata_
 	struct ahci_port_priv *pp = qc->ap->private_data;
 	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
 
+	if (pp->fbs_enabled)
+		d2h_fis += (qc->dev->link->pmp) * AHCI_RX_FIS_SZ;
+
 	ata_tf_from_fis(d2h_fis, &qc->result_tf);
 	return true;
 }
@@ -2237,15 +2347,45 @@ static void ahci_thaw(struct ata_port *a
 	writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
 }
 
+static int ahci_eh_fbs_dec(struct ata_port *ap)
+{
+	struct ahci_port_priv *pp = ap->private_data;
+	DPRINTK("ENTER\n");
+
+	if (pp->fbs_enabled) {
+		void __iomem *port_mmio = ahci_port_base(ap);
+		u32 fbs = readl(port_mmio + PORT_FBS);
+
+		writel(fbs | PORT_FBS_DEC, port_mmio + PORT_FBS);
+		fbs = readl(port_mmio + PORT_FBS);
+		if (fbs & PORT_FBS_DEC)
+			return -EIO;
+	} else {
+		dev_printk(KERN_ERR, ap->host->dev,
+			   "PMP is not used or FBS is disabled.\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static void ahci_error_handler(struct ata_port *ap)
 {
+	struct ahci_port_priv *pp = ap->private_data;
+
 	if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
 		/* restart engine */
 		ahci_stop_engine(ap);
 		ahci_start_engine(ap);
 	}
 
-	sata_pmp_error_handler(ap);
+	if (pp->fbs_enabled && pp->fbs_need_dec) {
+		int rc = ahci_eh_fbs_dec(ap);
+		pp->fbs_need_dec = 0;
+		if (rc)
+			sata_pmp_error_handler(ap);
+	} else
+		sata_pmp_error_handler(ap);
 }
 
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
@@ -2257,6 +2397,85 @@ static void ahci_post_internal_cmd(struc
 		ahci_kick_engine(ap, 1);
 }
 
+static int ahci_fbs_supported(struct ata_port *ap)
+{
+	if (sata_fbs_supported(ap) && (ap->pflags & ATA_PFLAG_FBSCP))
+		return 1;
+
+	return 0;
+}
+
+static int ahci_enable_fbs(struct ata_port *ap)
+{
+	struct ahci_port_priv *pp = ap->private_data;
+
+	if (ahci_fbs_supported(ap) && !pp->fbs_enabled) {
+		void __iomem *port_mmio = ahci_port_base(ap);
+		u32 fbs;
+		int rc = ahci_stop_engine(ap);
+		if (rc)
+			return rc;
+
+		fbs = readl(port_mmio + PORT_FBS);
+		writel(fbs | PORT_FBS_EN, port_mmio + PORT_FBS);
+		fbs = readl(port_mmio + PORT_FBS);
+		if (fbs & PORT_FBS_EN) {
+			dev_printk(KERN_INFO, ap->host->dev,
+				   "FBS is enabled.\n");
+			pp->fbs_enabled = 1;
+			pp->fbs_last_dev = -1; /* initialization*/
+		} else {
+			dev_printk(KERN_ERR, ap->host->dev,
+				   "Failed to enable FBS.\n");
+			ahci_start_engine(ap);
+			return -EIO;
+		}
+
+		ahci_start_engine(ap);
+	} else {
+		dev_printk(KERN_ERR, ap->host->dev,
+			   "FBS is not supported or already enabled.\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ahci_disable_fbs(struct ata_port *ap)
+{
+	struct ahci_port_priv *pp = ap->private_data;
+
+	if (pp->fbs_enabled) {
+		void __iomem *port_mmio = ahci_port_base(ap);
+		u32 fbs;
+		int rc = ahci_stop_engine(ap);
+		if (rc)
+			return rc;
+
+		fbs = readl(port_mmio + PORT_FBS);
+		writel(fbs & ~PORT_FBS_EN, port_mmio + PORT_FBS);
+		fbs = readl(port_mmio + PORT_FBS);
+		if (fbs & PORT_FBS_EN) {
+			dev_printk(KERN_ERR, ap->host->dev,
+				   "Failed to disable FBS!\n");
+			ahci_start_engine(ap);
+			return -EIO;
+		} else {
+			dev_printk(KERN_INFO, ap->host->dev,
+				   "FBS is disabled.\n");
+			pp->fbs_enabled = 0;
+		}
+
+		ahci_start_engine(ap);
+	} else if (sata_pmp_attached(ap)) {
+		dev_printk(KERN_ERR, ap->host->dev,
+			   "FBS is not supported or already disabled.\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void ahci_pmp_attach(struct ata_port *ap)
 {
 	void __iomem *port_mmio = ahci_port_base(ap);
@@ -2267,6 +2486,8 @@ static void ahci_pmp_attach(struct ata_p
 	cmd |= PORT_CMD_PMP;
 	writel(cmd, port_mmio + PORT_CMD);
 
+	ahci_enable_fbs(ap);
+
 	pp->intr_mask |= PORT_IRQ_BAD_PMP;
 	writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
 }
@@ -2277,6 +2498,8 @@ static void ahci_pmp_detach(struct ata_p
 	struct ahci_port_priv *pp = ap->private_data;
 	u32 cmd;
 
+	ahci_disable_fbs(ap);
+
 	cmd = readl(port_mmio + PORT_CMD);
 	cmd &= ~PORT_CMD_PMP;
 	writel(cmd, port_mmio + PORT_CMD);
@@ -2377,11 +2600,19 @@ static int ahci_port_start(struct ata_po
 	if (!pp)
 		return -ENOMEM;
 
-	mem = dmam_alloc_coherent(dev, AHCI_PORT_PRIV_DMA_SZ, &mem_dma,
-				  GFP_KERNEL);
+	if (ahci_fbs_supported(ap))
+		mem = dmam_alloc_coherent(dev, AHCI_PORT_PRIV_FBS_DMA,
+					  &mem_dma, GFP_KERNEL);
+	else
+		mem = dmam_alloc_coherent(dev, AHCI_PORT_PRIV_DMA_SZ,
+					  &mem_dma, GFP_KERNEL);
 	if (!mem)
 		return -ENOMEM;
-	memset(mem, 0, AHCI_PORT_PRIV_DMA_SZ);
+
+	if (ahci_fbs_supported(ap))
+		memset(mem, 0, AHCI_PORT_PRIV_FBS_DMA);
+	else
+		memset(mem, 0, AHCI_PORT_PRIV_DMA_SZ);
 
 	/*
 	 * First item in chunk of DMA memory: 32-slot command table,
@@ -2399,8 +2630,13 @@ static int ahci_port_start(struct ata_po
 	pp->rx_fis = mem;
 	pp->rx_fis_dma = mem_dma;
 
-	mem += AHCI_RX_FIS_SZ;
-	mem_dma += AHCI_RX_FIS_SZ;
+	if (ahci_fbs_supported(ap)) {
+		mem += AHCI_RX_FIS_SZ * 16;
+		mem_dma += AHCI_RX_FIS_SZ * 16;
+	} else {
+		mem += AHCI_RX_FIS_SZ;
+		mem_dma += AHCI_RX_FIS_SZ;
+	}
 
 	/*
 	 * Third item: data area for storing a single command
@@ -2518,7 +2754,7 @@ static void ahci_print_info(struct ata_h
 		"flags: "
 		"%s%s%s%s%s%s%s"
 		"%s%s%s%s%s%s%s"
-		"%s\n"
+		"%s%s\n"
 		,
 
 		cap & (1 << 31) ? "64bit " : "",
@@ -2533,6 +2769,7 @@ static void ahci_print_info(struct ata_h
 		cap & (1 << 19) ? "nz " : "",
 		cap & (1 << 18) ? "only " : "",
 		cap & (1 << 17) ? "pmp " : "",
+		cap & (1 << 16) ? "fbs " : "",
 		cap & (1 << 15) ? "pio " : "",
 		cap & (1 << 14) ? "slum " : "",
 		cap & (1 << 13) ? "part " : "",
@@ -2807,6 +3044,9 @@ static int ahci_init_one(struct pci_dev 
 	if (hpriv->cap & HOST_CAP_PMP)
 		pi.flags |= ATA_FLAG_PMP;
 
+	if (hpriv->cap & HOST_CAP_FBS)
+		pi.flags |= ATA_FLAG_FBS;
+
 	if (ahci_em_messages && (hpriv->cap & HOST_CAP_EMS)) {
 		u8 messages;
 		void __iomem *mmio = pcim_iomap_table(pdev)[AHCI_PCI_BAR];
@@ -2860,6 +3100,8 @@ static int ahci_init_one(struct pci_dev 
 
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
+		void __iomem *port_mmio = ahci_port_base(ap);
+		u32 cmd;
 
 		ata_port_pbar_desc(ap, AHCI_PCI_BAR, -1, "abar");
 		ata_port_pbar_desc(ap, AHCI_PCI_BAR,
@@ -2872,10 +3114,14 @@ static int ahci_init_one(struct pci_dev 
 		if (ap->flags & ATA_FLAG_EM)
 			ap->em_message_type = ahci_em_messages;
 
-
 		/* disabled/not-implemented port */
 		if (!(hpriv->port_map & (1 << i)))
 			ap->ops = &ata_dummy_port_ops;
+
+		/* check PxCMD.FBSCP */
+		cmd = readl(port_mmio + PORT_CMD);
+		if (cmd & PORT_CMD_FBSCP)
+			ap->pflags |= ATA_PFLAG_FBSCP;
 	}
 
 	/* apply workaround for ASUS P5W DH Deluxe mainboard */
diff -ruNp a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
--- a/drivers/ata/libata-pmp.c	2009-07-29 14:39:11.000000000 +0800
+++ b/drivers/ata/libata-pmp.c	2009-07-29 14:39:15.000000000 +0800
@@ -221,6 +221,8 @@ static const char *sata_pmp_spec_rev_str
 {
 	u32 rev = gscr[SATA_PMP_GSCR_REV];
 
+	if ((rev & (1 << 2)) && (rev & (1 << 1)))
+		return "1.2";
 	if (rev & (1 << 2))
 		return "1.1";
 	if (rev & (1 << 1))
diff -ruNp a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2009-07-29 14:39:30.000000000 +0800
+++ b/include/linux/libata.h	2009-07-29 14:39:34.000000000 +0800
@@ -208,6 +208,7 @@ enum {
 	ATA_FLAG_DISABLED	= (1 << 23), /* port is disabled, ignore it */
 
 	/* bits 24:31 of ap->flags are reserved for LLD specific flags */
+	ATA_FLAG_FBS		= (1 << 24), /* controller supports FBS */
 
 
 	/* struct ata_port pflags */
@@ -228,6 +229,7 @@ enum {
 
 	ATA_PFLAG_PIO32		= (1 << 20),  /* 32bit PIO */
 	ATA_PFLAG_PIO32CHANGE	= (1 << 21),  /* 32bit PIO can be turned on/off */
+	ATA_PFLAG_FBSCP		= (1 << 22),  /* FBS Capable Port */
 
 	/* struct ata_queued_cmd flags */
 	ATA_QCFLAG_ACTIVE	= (1 << 0), /* cmd not yet ack'd to scsi lyer */
@@ -1175,6 +1177,11 @@ static inline bool sata_pmp_supported(st
 	return ap->flags & ATA_FLAG_PMP;
 }
 
+static inline bool sata_fbs_supported(struct ata_port *ap)
+{
+	return (ap->flags & ATA_FLAG_PMP) && (ap->flags & ATA_FLAG_FBS);
+}
+
 static inline bool sata_pmp_attached(struct ata_port *ap)
 {
 	return ap->nr_pmp_links != 0;
@@ -1184,12 +1191,18 @@ static inline int ata_is_host_link(const
 {
 	return link == &link->ap->link || link == link->ap->slave_link;
 }
+
 #else /* CONFIG_SATA_PMP */
 static inline bool sata_pmp_supported(struct ata_port *ap)
 {
 	return false;
 }
 
+static inline bool sata_fbs_supported(struct ata_port *ap)
+{
+	return false;
+}
+
 static inline bool sata_pmp_attached(struct ata_port *ap)
 {
 	return false;


