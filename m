From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 1/8] sata_mv more cosmetics
Date: Sat, 19 Apr 2008 14:43:42 -0400
Message-ID: <480A3D5E.8090206@rtr.ca>
References: <480A3D2E.4040503@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3968 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755995AbYDSSnk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Apr 2008 14:43:40 -0400
In-Reply-To: <480A3D2E.4040503@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

More cosmetic cleanups prior to the interrupt/error handling logic changes.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-04-18 09:31:15.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-04-19 13:01:22.000000000 -0400
@@ -123,11 +123,11 @@
 	MV_MAX_SG_CT		= 256,
 	MV_SG_TBL_SZ		= (16 * MV_MAX_SG_CT),
 
-	MV_PORTS_PER_HC		= 4,
-	/* == (port / MV_PORTS_PER_HC) to determine HC from 0-7 port */
+	/* Determine hc from 0-7 port: hc = port >> MV_PORT_HC_SHIFT */
 	MV_PORT_HC_SHIFT	= 2,
-	/* == (port % MV_PORTS_PER_HC) to determine hard port from 0-7 port */
-	MV_PORT_MASK		= 3,
+	MV_PORTS_PER_HC		= (1 << MV_PORT_HC_SHIFT), /* 4 */
+	/* Determine hc port from 0-7 port: hardport = port & MV_PORT_MASK */
+	MV_PORT_MASK		= (MV_PORTS_PER_HC - 1),   /* 3 */
 
 	/* Host Flags */
 	MV_FLAG_DUAL_HC		= (1 << 30),  /* two SATA Host Controllers */
@@ -187,8 +187,8 @@
 	HC_MAIN_IRQ_MASK_OFS	= 0x1d64,
 	HC_SOC_MAIN_IRQ_CAUSE_OFS = 0x20020,
 	HC_SOC_MAIN_IRQ_MASK_OFS = 0x20024,
-	PORT0_ERR		= (1 << 0),	/* shift by port # */
-	PORT0_DONE		= (1 << 1),	/* shift by port # */
+	ERR_IRQ			= (1 << 0),	/* shift by port # */
+	DONE_IRQ		= (1 << 1),	/* shift by port # */
 	HC0_IRQ_PEND		= 0x1ff,	/* bits 0-8 = HC0's ports */
 	HC_SHIFT		= 9,		/* bits 9-17 = HC1's ports */
 	PCI_ERR			= (1 << 18),
@@ -214,8 +214,8 @@
 	HC_CFG_OFS		= 0,
 
 	HC_IRQ_CAUSE_OFS	= 0x14,
-	CRPB_DMA_DONE		= (1 << 0),	/* shift by port # */
-	HC_IRQ_COAL		= (1 << 4),	/* IRQ coalescing */
+	DMA_IRQ			= (1 << 0),	/* shift by port # */
+	HC_COAL_IRQ		= (1 << 4),	/* IRQ coalescing */
 	DEV_IRQ			= (1 << 8),	/* shift by port # */
 
 	/* Shadow block registers */
@@ -348,6 +348,8 @@
 	EDMA_IORDY_TMOUT	= 0x34,
 	EDMA_ARB_CFG		= 0x38,
 
+	GEN_II_NCQ_MAX_SECTORS	= 256,		/* max sects/io on Gen2 w/NCQ */
+
 	/* Host private flags (hp_flags) */
 	MV_HP_FLAG_MSI		= (1 << 0),
 	MV_HP_ERRATA_50XXB0	= (1 << 1),
@@ -718,11 +720,6 @@
 	(void) readl(addr);	/* flush to avoid PCI posted write */
 }
 
-static inline void __iomem *mv_hc_base(void __iomem *base, unsigned int hc)
-{
-	return (base + MV_SATAHC0_REG_BASE + (hc * MV_SATAHC_REG_SZ));
-}
-
 static inline unsigned int mv_hc_from_port(unsigned int port)
 {
 	return port >> MV_PORT_HC_SHIFT;
@@ -733,6 +730,11 @@
 	return port & MV_PORT_MASK;
 }
 
+static inline void __iomem *mv_hc_base(void __iomem *base, unsigned int hc)
+{
+	return (base + MV_SATAHC0_REG_BASE + (hc * MV_SATAHC_REG_SZ));
+}
+
 static inline void __iomem *mv_hc_base_from_port(void __iomem *base,
 						 unsigned int port)
 {
@@ -833,9 +835,9 @@
 	}
 	if (!(pp->pp_flags & MV_PP_FLAG_EDMA_EN)) {
 		struct mv_host_priv *hpriv = ap->host->private_data;
-		int hard_port = mv_hardport_from_port(ap->port_no);
+		int hardport = mv_hardport_from_port(ap->port_no);
 		void __iomem *hc_mmio = mv_hc_base_from_port(
-					mv_host_base(ap->host), hard_port);
+					mv_host_base(ap->host), hardport);
 		u32 hc_irq_cause, ipending;
 
 		/* clear EDMA event indicators, if any */
@@ -843,8 +845,7 @@
 
 		/* clear EDMA interrupt indicator, if any */
 		hc_irq_cause = readl(hc_mmio + HC_IRQ_CAUSE_OFS);
-		ipending = (DEV_IRQ << hard_port) |
-				(CRPB_DMA_DONE << hard_port);
+		ipending = (DEV_IRQ | DMA_IRQ) << hardport;
 		if (hc_irq_cause & ipending) {
 			writelfl(hc_irq_cause & ~ipending,
 				 hc_mmio + HC_IRQ_CAUSE_OFS);
@@ -860,7 +861,6 @@
 		writelfl(EDMA_EN, port_mmio + EDMA_CMD_OFS);
 		pp->pp_flags |= MV_PP_FLAG_EDMA_EN;
 	}
-	WARN_ON(!(EDMA_EN & readl(port_mmio + EDMA_CMD_OFS)));
 }
 
 /**
@@ -1032,10 +1032,16 @@
 	 * See mv_qc_prep() for more info.
 	 */
 	if (adev->flags & ATA_DFLAG_NCQ) {
-		if (sata_pmp_attached(adev->link->ap))
+		if (sata_pmp_attached(adev->link->ap)) {
 			adev->flags &= ~ATA_DFLAG_NCQ;
-		else if (adev->max_sectors > ATA_MAX_SECTORS)
-			adev->max_sectors = ATA_MAX_SECTORS;
+			ata_dev_printk(adev, KERN_INFO,
+				"NCQ disabled for command-based switching\n");
+		} else if (adev->max_sectors > GEN_II_NCQ_MAX_SECTORS) {
+			adev->max_sectors = GEN_II_NCQ_MAX_SECTORS;
+			ata_dev_printk(adev, KERN_INFO,
+				"max_sectors limited to %u for NCQ\n",
+				adev->max_sectors);
+		}
 	}
 }
 
@@ -1489,12 +1495,11 @@
 
 	edma_err_cause = readl(port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
 
-	ata_ehi_push_desc(ehi, "edma_err 0x%08x", edma_err_cause);
+	ata_ehi_push_desc(ehi, "edma_err_cause=%08x", edma_err_cause);
 
 	/*
-	 * all generations share these EDMA error cause bits
+	 * All generations share these EDMA error cause bits:
 	 */
-
 	if (edma_err_cause & EDMA_ERR_DEV)
 		err_mask |= AC_ERR_DEV;
 	if (edma_err_cause & (EDMA_ERR_D_PAR | EDMA_ERR_PRD_PAR |
@@ -1511,23 +1516,22 @@
 		action |= ATA_EH_RESET;
 	}
 
+	/*
+	 * Gen-I has a different SELF_DIS bit,
+	 * different FREEZE bits, and no SERR bit:
+	 */
 	if (IS_GEN_I(hpriv)) {
 		eh_freeze_mask = EDMA_EH_FREEZE_5;
-
 		if (edma_err_cause & EDMA_ERR_SELF_DIS_5) {
-			pp = ap->private_data;
 			pp->pp_flags &= ~MV_PP_FLAG_EDMA_EN;
 			ata_ehi_push_desc(ehi, "EDMA self-disable");
 		}
 	} else {
 		eh_freeze_mask = EDMA_EH_FREEZE;
-
 		if (edma_err_cause & EDMA_ERR_SELF_DIS) {
-			pp = ap->private_data;
 			pp->pp_flags &= ~MV_PP_FLAG_EDMA_EN;
 			ata_ehi_push_desc(ehi, "EDMA self-disable");
 		}
-
 		if (edma_err_cause & EDMA_ERR_SERR) {
 			sata_scr_read(&ap->link, SCR_ERROR, &serr);
 			sata_scr_write_flush(&ap->link, SCR_ERROR, serr);
@@ -1640,6 +1644,7 @@
 		pp->resp_idx++;
 	}
 
+	/* Update the software queue position index in hardware */
 	if (work_done)
 		writelfl((pp->crpb_dma & EDMA_RSP_Q_BASE_LO_MASK) |
 			 (out_index << EDMA_RSP_Q_PTR_SHIFT),
@@ -1692,7 +1697,7 @@
 	for (port = port0; port < last_port; port++) {
 		struct ata_port *ap = host->ports[port];
 		struct mv_port_priv *pp;
-		int have_err_bits, hard_port, shift;
+		int have_err_bits, hardport, shift;
 
 		if ((!ap) || (ap->flags & ATA_FLAG_DISABLED))
 			continue;
@@ -1703,7 +1708,7 @@
 		if (port >= MV_PORTS_PER_HC)
 			shift++;	/* skip bit 8 in the HC Main IRQ reg */
 
-		have_err_bits = ((PORT0_ERR << shift) & relevant);
+		have_err_bits = ((ERR_IRQ << shift) & relevant);
 
 		if (unlikely(have_err_bits)) {
 			struct ata_queued_cmd *qc;
@@ -1716,13 +1721,13 @@
 			continue;
 		}
 
-		hard_port = mv_hardport_from_port(port); /* range 0..3 */
+		hardport = mv_hardport_from_port(port); /* range 0..3 */
 
 		if (pp->pp_flags & MV_PP_FLAG_EDMA_EN) {
-			if ((CRPB_DMA_DONE << hard_port) & hc_irq_cause)
+			if ((DMA_IRQ << hardport) & hc_irq_cause)
 				mv_intr_edma(ap);
 		} else {
-			if ((DEV_IRQ << hard_port) & hc_irq_cause)
+			if ((DEV_IRQ << hardport) & hc_irq_cause)
 				mv_intr_pio(ap);
 		}
 	}
@@ -1789,30 +1794,28 @@
 	struct mv_host_priv *hpriv = host->private_data;
 	unsigned int hc, handled = 0, n_hcs;
 	void __iomem *mmio = hpriv->base;
-	u32 irq_stat, irq_mask;
+	u32 main_cause, main_mask;
 
-	/* Note to self: &host->lock == &ap->host->lock == ap->lock */
 	spin_lock(&host->lock);
-
-	irq_stat = readl(hpriv->main_cause_reg_addr);
-	irq_mask = readl(hpriv->main_mask_reg_addr);
-
-	/* check the cases where we either have nothing pending or have read
-	 * a bogus register value which can indicate HW removal or PCI fault
+	main_cause = readl(hpriv->main_cause_reg_addr);
+	main_mask  = readl(hpriv->main_mask_reg_addr);
+	/*
+	 * Deal with cases where we either have nothing pending, or have read
+	 * a bogus register value which can indicate HW removal or PCI fault.
 	 */
-	if (!(irq_stat & irq_mask) || (0xffffffffU == irq_stat))
+	if (!(main_cause & main_mask) || (main_cause == 0xffffffffU))
 		goto out_unlock;
 
 	n_hcs = mv_get_hc_count(host->ports[0]->flags);
 
-	if (unlikely((irq_stat & PCI_ERR) && HAS_PCI(host))) {
+	if (unlikely((main_cause & PCI_ERR) && HAS_PCI(host))) {
 		mv_pci_error(host, mmio);
 		handled = 1;
 		goto out_unlock;	/* skip all other HC irq handling */
 	}
 
 	for (hc = 0; hc < n_hcs; hc++) {
-		u32 relevant = irq_stat & (HC0_IRQ_PEND << (hc * HC_SHIFT));
+		u32 relevant = main_cause & (HC0_IRQ_PEND << (hc * HC_SHIFT));
 		if (relevant) {
 			mv_host_intr(host, relevant, hc);
 			handled = 1;
@@ -1821,7 +1824,6 @@
 
 out_unlock:
 	spin_unlock(&host->lock);
-
 	return IRQ_RETVAL(handled);
 }
 
@@ -2406,8 +2408,8 @@
 {
 	struct mv_host_priv *hpriv = ap->host->private_data;
 	unsigned int hc = (ap->port_no > 3) ? 1 : 0;
-	u32 tmp, mask;
 	unsigned int shift;
+	u32 main_mask;
 
 	/* FIXME: handle coalescing completion events properly */
 
@@ -2415,11 +2417,10 @@
 	if (hc > 0)
 		shift++;
 
-	mask = 0x3 << shift;
-
 	/* disable assertion of portN err, done events */
-	tmp = readl(hpriv->main_mask_reg_addr);
-	writelfl(tmp & ~mask, hpriv->main_mask_reg_addr);
+	main_mask = readl(hpriv->main_mask_reg_addr);
+	main_mask &= ~((DONE_IRQ | ERR_IRQ) << shift);
+	writelfl(main_mask, hpriv->main_mask_reg_addr);
 }
 
 static void mv_eh_thaw(struct ata_port *ap)
@@ -2429,8 +2430,8 @@
 	unsigned int hc = (ap->port_no > 3) ? 1 : 0;
 	void __iomem *hc_mmio = mv_hc_base(mmio, hc);
 	void __iomem *port_mmio = mv_ap_base(ap);
-	u32 tmp, mask, hc_irq_cause;
 	unsigned int shift, hc_port_no = ap->port_no;
+	u32 main_mask, hc_irq_cause;
 
 	/* FIXME: handle coalescing completion events properly */
 
@@ -2440,20 +2441,18 @@
 		hc_port_no -= 4;
 	}
 
-	mask = 0x3 << shift;
-
 	/* clear EDMA errors on this port */
 	writel(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
 
 	/* clear pending irq events */
 	hc_irq_cause = readl(hc_mmio + HC_IRQ_CAUSE_OFS);
-	hc_irq_cause &= ~(1 << hc_port_no);	/* clear CRPB-done */
-	hc_irq_cause &= ~(1 << (hc_port_no + 8)); /* clear Device int */
+	hc_irq_cause &= ~((DEV_IRQ | DMA_IRQ) << hc_port_no);
 	writel(hc_irq_cause, hc_mmio + HC_IRQ_CAUSE_OFS);
 
 	/* enable assertion of portN err, done events */
-	tmp = readl(hpriv->main_mask_reg_addr);
-	writelfl(tmp | mask, hpriv->main_mask_reg_addr);
+	main_mask = readl(hpriv->main_mask_reg_addr);
+	main_mask |= ((DONE_IRQ | ERR_IRQ) << shift);
+	writelfl(main_mask, hpriv->main_mask_reg_addr);
 }
 
 /**
@@ -2664,19 +2663,17 @@
 
 	rc = mv_chip_id(host, board_idx);
 	if (rc)
-	goto done;
+		goto done;
 
 	if (HAS_PCI(host)) {
-		hpriv->main_cause_reg_addr = hpriv->base +
-		  HC_MAIN_IRQ_CAUSE_OFS;
-		hpriv->main_mask_reg_addr = hpriv->base + HC_MAIN_IRQ_MASK_OFS;
+		hpriv->main_cause_reg_addr = mmio + HC_MAIN_IRQ_CAUSE_OFS;
+		hpriv->main_mask_reg_addr  = mmio + HC_MAIN_IRQ_MASK_OFS;
 	} else {
-		hpriv->main_cause_reg_addr = hpriv->base +
-		  HC_SOC_MAIN_IRQ_CAUSE_OFS;
-		hpriv->main_mask_reg_addr = hpriv->base +
-		  HC_SOC_MAIN_IRQ_MASK_OFS;
+		hpriv->main_cause_reg_addr = mmio + HC_SOC_MAIN_IRQ_CAUSE_OFS;
+		hpriv->main_mask_reg_addr  = mmio + HC_SOC_MAIN_IRQ_MASK_OFS;
 	}
-	/* global interrupt mask */
+
+	/* global interrupt mask: 0 == mask everything */
 	writel(0, hpriv->main_mask_reg_addr);
 
 	n_hc = mv_get_hc_count(host->ports[0]->flags);
