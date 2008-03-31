From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 1/5] sata_mv cosmetic fixes
Date: Mon, 31 Mar 2008 19:33:56 -0400
Message-ID: <47F174E4.9090507@rtr.ca>
References: <47F1736F.8020104@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3037 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274AbYCaXd5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Mar 2008 19:33:57 -0400
In-Reply-To: <47F1736F.8020104@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

Various cosmetic fixes in preparation for real code changes later on.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

--- old/drivers/ata/sata_mv.c	2008-03-31 16:09:08.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-03-31 17:18:15.000000000 -0400
@@ -1,6 +1,7 @@
 /*
  * sata_mv.c - Marvell SATA support
  *
+ * Copyright 2008: Marvell Corporation, all rights reserved.
  * Copyright 2005: EMC Corporation, all rights reserved.
  * Copyright 2005 Red Hat, Inc.  All rights reserved.
  *
@@ -61,7 +62,6 @@
 
 */
 
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -131,7 +131,7 @@
 	MV_FLAG_DUAL_HC		= (1 << 30),  /* two SATA Host Controllers */
 	MV_FLAG_IRQ_COALESCE	= (1 << 29),  /* IRQ coalescing capability */
 	/* SoC integrated controllers, no PCI interface */
-	MV_FLAG_SOC = (1 << 28),
+	MV_FLAG_SOC		= (1 << 28),
 
 	MV_COMMON_FLAGS		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_NO_ATAPI |
@@ -141,6 +141,7 @@
 	CRQB_FLAG_READ		= (1 << 0),
 	CRQB_TAG_SHIFT		= 1,
 	CRQB_IOID_SHIFT		= 6,	/* CRQB Gen-II/IIE IO Id shift */
+	CRQB_PMP_SHIFT		= 12,	/* CRQB Gen-II/IIE PMP shift */
 	CRQB_HOSTQ_SHIFT	= 17,	/* CRQB Gen-II/IIE HostQueTag shift */
 	CRQB_CMD_ADDR_SHIFT	= 8,
 	CRQB_CMD_CS		= (0x2 << 11),
@@ -199,7 +200,7 @@
 	TWSI_INT		= (1 << 24),
 	HC_MAIN_RSVD		= (0x7f << 25),	/* bits 31-25 */
 	HC_MAIN_RSVD_5		= (0x1fff << 19), /* bits 31-19 */
-	HC_MAIN_RSVD_SOC 	= (0x3fffffb << 6),     /* bits 31-9, 7-6 */
+	HC_MAIN_RSVD_SOC	= (0x3fffffb << 6),     /* bits 31-9, 7-6 */
 	HC_MAIN_MASKED_IRQS	= (TRAN_LO_DONE | TRAN_HI_DONE |
 				   PORTS_0_7_COAL_DONE | GPIO_INT | TWSI_INT |
 				   HC_MAIN_RSVD),
@@ -223,13 +224,18 @@
 	SATA_STATUS_OFS		= 0x300,  /* ctrl, err regs follow status */
 	SATA_ACTIVE_OFS		= 0x350,
 	SATA_FIS_IRQ_CAUSE_OFS	= 0x364,
+	LTMODE_OFS		= 0x30c,
 	PHY_MODE3		= 0x310,
 	PHY_MODE4		= 0x314,
 	PHY_MODE2		= 0x330,
+	SATA_IFCTL_OFS		= 0x344,
+	SATA_IFSTAT_OFS		= 0x34c,
+	VENDOR_UNIQUE_FIS_OFS	= 0x35c,
+	FIS_CFG_OFS		= 0x360,
 	MV5_PHY_MODE		= 0x74,
 	MV5_LT_MODE		= 0x30,
 	MV5_PHY_CTL		= 0x0C,
-	SATA_INTERFACE_CTL	= 0x050,
+	SATA_INTERFACE_CFG	= 0x050,
 
 	MV_M2_PREAMP_MASK	= 0x7e0,
 
@@ -240,6 +246,8 @@
 	EDMA_CFG_NCQ_GO_ON_ERR	= (1 << 14),	/* continue on error */
 	EDMA_CFG_RD_BRST_EXT	= (1 << 11),	/* read burst 512B */
 	EDMA_CFG_WR_BUFF_LEN	= (1 << 13),	/* write buffer 512B */
+	EDMA_CFG_EDMA_FBS	= (1 << 16),	/* EDMA FIS-Based Switching */
+	EDMA_CFG_FBS		= (1 << 26),	/* FIS-Based Switching */
 
 	EDMA_ERR_IRQ_CAUSE_OFS	= 0x8,
 	EDMA_ERR_IRQ_MASK_OFS	= 0xc,
@@ -298,6 +306,7 @@
 				  EDMA_ERR_LNK_DATA_RX |
 				  EDMA_ERR_LNK_DATA_TX |
 				  EDMA_ERR_TRANS_PROTO,
+
 	EDMA_EH_FREEZE_5	= EDMA_ERR_D_PAR |
 				  EDMA_ERR_PRD_PAR |
 				  EDMA_ERR_DEV_DCON |
@@ -344,7 +353,6 @@
 	/* Port private flags (pp_flags) */
 	MV_PP_FLAG_EDMA_EN	= (1 << 0),	/* is EDMA engine enabled? */
 	MV_PP_FLAG_NCQ_EN	= (1 << 1),	/* is EDMA set up for NCQ? */
-	MV_PP_FLAG_HAD_A_RESET	= (1 << 2),	/* 1st hard reset complete? */
 };
 
 #define IS_GEN_I(hpriv) ((hpriv)->hp_flags & MV_HP_GEN_I)
@@ -506,11 +514,11 @@
 				      void __iomem *mmio);
 static void mv_soc_reset_bus(struct ata_host *host, void __iomem *mmio);
 static void mv_reset_pci_bus(struct ata_host *host, void __iomem *mmio);
-static void mv_channel_reset(struct mv_host_priv *hpriv, void __iomem *mmio,
+static void mv_reset_channel(struct mv_host_priv *hpriv, void __iomem *mmio,
 			     unsigned int port_no);
-static void mv_edma_cfg(struct mv_port_priv *pp, struct mv_host_priv *hpriv,
-			void __iomem *port_mmio, int want_ncq);
-static int __mv_stop_dma(struct ata_port *ap);
+static int mv_stop_edma(struct ata_port *ap);
+static int mv_stop_edma_engine(struct ata_port *ap);
+static void mv_edma_cfg(struct ata_port *ap, int want_ncq);
 
 /* .sg_tablesize is (MV_MAX_SG_CT / 2) in the structures below
  * because we have to allow room for worst case splitting of
@@ -714,6 +722,14 @@
 		(mv_hardport_from_port(port) * MV_PORT_REG_SZ);
 }
 
+static void __iomem *mv5_phy_base(void __iomem *mmio, unsigned int port)
+{
+	void __iomem *hc_mmio = mv_hc_base_from_port(mmio, port);
+	unsigned long ofs = (mv_hardport_from_port(port) + 1) * 0x100UL;
+
+	return hc_mmio + ofs;
+}
+
 static inline void __iomem *mv_host_base(struct ata_host *host)
 {
 	struct mv_host_priv *hpriv = host->private_data;
@@ -789,7 +805,7 @@
 	if (pp->pp_flags & MV_PP_FLAG_EDMA_EN) {
 		int using_ncq = ((pp->pp_flags & MV_PP_FLAG_NCQ_EN) != 0);
 		if (want_ncq != using_ncq)
-			__mv_stop_dma(ap);
+			mv_stop_edma_engine(ap);
 	}
 	if (!(pp->pp_flags & MV_PP_FLAG_EDMA_EN)) {
 		struct mv_host_priv *hpriv = ap->host->private_data;
@@ -810,7 +826,7 @@
 				 hc_mmio + HC_IRQ_CAUSE_OFS);
 		}
 
-		mv_edma_cfg(pp, hpriv, port_mmio, want_ncq);
+		mv_edma_cfg(ap, want_ncq);
 
 		/* clear FIS IRQ Cause */
 		writelfl(0, port_mmio + SATA_FIS_IRQ_CAUSE_OFS);
@@ -824,7 +840,7 @@
 }
 
 /**
- *      __mv_stop_dma - Disable eDMA engine
+ *      mv_stop_edma_engine - Disable eDMA engine
  *      @ap: ATA channel to manipulate
  *
  *      Verify the local cache of the eDMA state is accurate with a
@@ -833,7 +849,7 @@
  *      LOCKING:
  *      Inherited from caller.
  */
-static int __mv_stop_dma(struct ata_port *ap)
+static int mv_stop_edma_engine(struct ata_port *ap)
 {
 	void __iomem *port_mmio = mv_ap_base(ap);
 	struct mv_port_priv *pp	= ap->private_data;
@@ -866,13 +882,13 @@
 	return err;
 }
 
-static int mv_stop_dma(struct ata_port *ap)
+static int mv_stop_edma(struct ata_port *ap)
 {
 	unsigned long flags;
 	int rc;
 
 	spin_lock_irqsave(&ap->host->lock, flags);
-	rc = __mv_stop_dma(ap);
+	rc = mv_stop_edma_engine(ap);
 	spin_unlock_irqrestore(&ap->host->lock, flags);
 
 	return rc;
@@ -1007,10 +1023,12 @@
 			adev->max_sectors = ATA_MAX_SECTORS;
 }
 
-static void mv_edma_cfg(struct mv_port_priv *pp, struct mv_host_priv *hpriv,
-			void __iomem *port_mmio, int want_ncq)
+static void mv_edma_cfg(struct ata_port *ap, int want_ncq)
 {
 	u32 cfg;
+	struct mv_port_priv *pp    = ap->private_data;
+	struct mv_host_priv *hpriv = ap->host->private_data;
+	void __iomem *port_mmio    = mv_ap_base(ap);
 
 	/* set up non-NCQ EDMA configuration */
 	cfg = EDMA_CFG_Q_DEPTH;		/* always 0x1f for *all* chips */
@@ -1118,7 +1136,7 @@
 
 	spin_lock_irqsave(&ap->host->lock, flags);
 
-	mv_edma_cfg(pp, hpriv, port_mmio, 0);
+	mv_edma_cfg(ap, 0);
 	mv_set_edma_ptrs(port_mmio, hpriv, pp);
 
 	spin_unlock_irqrestore(&ap->host->lock, flags);
@@ -1145,7 +1163,7 @@
  */
 static void mv_port_stop(struct ata_port *ap)
 {
-	mv_stop_dma(ap);
+	mv_stop_edma(ap);
 	mv_port_free_dma_mem(ap);
 }
 
@@ -1315,8 +1333,7 @@
 	    (qc->tf.protocol != ATA_PROT_NCQ))
 		return;
 
-	/* Fill in Gen IIE command request block
-	 */
+	/* Fill in Gen IIE command request block */
 	if (!(qc->tf.flags & ATA_TFLAG_WRITE))
 		flags |= CRQB_FLAG_READ;
 
@@ -1384,7 +1401,7 @@
 		 * port.  Turn off EDMA so there won't be problems accessing
 		 * shadow block, etc registers.
 		 */
-		__mv_stop_dma(ap);
+		mv_stop_edma_engine(ap);
 		return ata_qc_issue_prot(qc);
 	}
 
@@ -1407,10 +1424,10 @@
  *      @reset_allowed: bool: 0 == don't trigger from reset here
  *
  *      In most cases, just clear the interrupt and move on.  However,
- *      some cases require an eDMA reset, which is done right before
- *      the COMRESET in mv_phy_reset().  The SERR case requires a
- *      clear of pending errors in the SATA SERROR register.  Finally,
- *      if the port disabled DMA, update our cached copy to match.
+ *      some cases require an eDMA reset, which also performs a COMRESET.
+ *      The SERR case requires a clear of pending errors in the SATA
+ *      SERROR register.  Finally, if the port disabled DMA,
+ *      update our cached copy to match.
  *
  *      LOCKING:
  *      Inherited from caller.
@@ -1648,9 +1665,9 @@
 		pp = ap->private_data;
 
 		shift = port << 1;		/* (port * 2) */
-		if (port >= MV_PORTS_PER_HC) {
+		if (port >= MV_PORTS_PER_HC)
 			shift++;	/* skip bit 8 in the HC Main IRQ reg */
-		}
+
 		have_err_bits = ((PORT0_ERR << shift) & relevant);
 
 		if (unlikely(have_err_bits)) {
@@ -1739,6 +1756,7 @@
 	void __iomem *mmio = hpriv->base;
 	u32 irq_stat, irq_mask;
 
+	/* Note to self: &host->lock == &ap->host->lock == ap->lock */
 	spin_lock(&host->lock);
 
 	irq_stat = readl(hpriv->main_cause_reg_addr);
@@ -1772,14 +1790,6 @@
 	return IRQ_RETVAL(handled);
 }
 
-static void __iomem *mv5_phy_base(void __iomem *mmio, unsigned int port)
-{
-	void __iomem *hc_mmio = mv_hc_base_from_port(mmio, port);
-	unsigned long ofs = (mv_hardport_from_port(port) + 1) * 0x100UL;
-
-	return hc_mmio + ofs;
-}
-
 static unsigned int mv5_scr_offset(unsigned int sc_reg_in)
 {
 	unsigned int ofs;
@@ -1907,7 +1917,7 @@
 
 	writelfl(EDMA_DS, port_mmio + EDMA_CMD_OFS);
 
-	mv_channel_reset(hpriv, mmio, port);
+	mv_reset_channel(hpriv, mmio, port);
 
 	ZERO(0x028);	/* command */
 	writel(0x11f, port_mmio + EDMA_CFG_OFS);
@@ -2125,14 +2135,15 @@
 		m4 = readl(port_mmio + PHY_MODE4);
 
 		if (hp_flags & MV_HP_ERRATA_60X1B2)
-			tmp = readl(port_mmio + 0x310);
+			tmp = readl(port_mmio + PHY_MODE3);
 
+		/* workaround for errata FEr SATA#10 (part 1) */
 		m4 = (m4 & ~(1 << 1)) | (1 << 0);
 
 		writel(m4, port_mmio + PHY_MODE4);
 
 		if (hp_flags & MV_HP_ERRATA_60X1B2)
-			writel(tmp, port_mmio + 0x310);
+			writel(tmp, port_mmio + PHY_MODE3);
 	}
 
 	/* Revert values of pre-emphasis and signal amps to the saved ones */
@@ -2182,7 +2193,7 @@
 
 	writelfl(EDMA_DS, port_mmio + EDMA_CMD_OFS);
 
-	mv_channel_reset(hpriv, mmio, port);
+	mv_reset_channel(hpriv, mmio, port);
 
 	ZERO(0x028);		/* command */
 	writel(0x101f, port_mmio + EDMA_CFG_OFS);
@@ -2239,7 +2250,7 @@
 	return;
 }
 
-static void mv_channel_reset(struct mv_host_priv *hpriv, void __iomem *mmio,
+static void mv_reset_channel(struct mv_host_priv *hpriv, void __iomem *mmio,
 			     unsigned int port_no)
 {
 	void __iomem *port_mmio = mv_port_base(mmio, port_no);
@@ -2247,10 +2258,10 @@
 	writelfl(ATA_RST, port_mmio + EDMA_CMD_OFS);
 
 	if (IS_GEN_II(hpriv)) {
-		u32 ifctl = readl(port_mmio + SATA_INTERFACE_CTL);
+		u32 ifctl = readl(port_mmio + SATA_INTERFACE_CFG);
 		ifctl |= (1 << 7);		/* enable gen2i speed */
 		ifctl = (ifctl & 0xfff) | 0x9b1000; /* from chip spec */
-		writelfl(ifctl, port_mmio + SATA_INTERFACE_CTL);
+		writelfl(ifctl, port_mmio + SATA_INTERFACE_CFG);
 	}
 
 	udelay(25);		/* allow reset propagation */
@@ -2372,14 +2383,7 @@
 
 static int mv_prereset(struct ata_link *link, unsigned long deadline)
 {
-	struct ata_port *ap = link->ap;
-	struct mv_port_priv *pp	= ap->private_data;
-
-	mv_stop_dma(ap);
-
-	if (!(pp->pp_flags & MV_PP_FLAG_HAD_A_RESET))
-		pp->pp_flags |= MV_PP_FLAG_HAD_A_RESET;
-
+	mv_stop_edma(link->ap);
 	return 0;
 }
 
@@ -2390,10 +2394,8 @@
 	struct mv_host_priv *hpriv = ap->host->private_data;
 	void __iomem *mmio = hpriv->base;
 
-	mv_stop_dma(ap);
-
-	mv_channel_reset(hpriv, mmio, ap->port_no);
-
+	mv_stop_edma(ap);
+	mv_reset_channel(hpriv, mmio, ap->port_no);
 	mv_phy_reset(ap, class, deadline);
 
 	return 0;
@@ -2715,10 +2717,10 @@
 		if (IS_GEN_II(hpriv)) {
 			void __iomem *port_mmio = mv_port_base(mmio, port);
 
-			u32 ifctl = readl(port_mmio + SATA_INTERFACE_CTL);
+			u32 ifctl = readl(port_mmio + SATA_INTERFACE_CFG);
 			ifctl |= (1 << 7);		/* enable gen2i speed */
 			ifctl = (ifctl & 0xfff) | 0x9b1000; /* from chip spec */
-			writelfl(ifctl, port_mmio + SATA_INTERFACE_CTL);
+			writelfl(ifctl, port_mmio + SATA_INTERFACE_CFG);
 		}
 
 		hpriv->ops->phy_errata(hpriv, mmio, port);
