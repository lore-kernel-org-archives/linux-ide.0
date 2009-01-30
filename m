From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 02/07] sata_mv: rearrange mv_start_dma() and friends
Date: Fri, 30 Jan 2009 18:47:51 -0500
Message-ID: <498391A7.1090209@rtr.ca>
References: <49839107.2040603@rtr.ca> <4983915F.7090705@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:48391 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757947AbZA3Xrw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jan 2009 18:47:52 -0500
In-Reply-To: <4983915F.7090705@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Rearrange mv_start_dma() and friends, in preparation for adding
non-EDMA DMA modes, and non-EDMA interrupts, to the driver.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2009-01-30 16:45:20.000000000 -0500
+++ linux/drivers/ata/sata_mv.c	2009-01-30 16:44:12.000000000 -0500
@@ -536,7 +536,7 @@
 			     unsigned int port_no);
 static int mv_stop_edma(struct ata_port *ap);
 static int mv_stop_edma_engine(void __iomem *port_mmio);
-static void mv_edma_cfg(struct ata_port *ap, int want_ncq);
+static void mv_edma_cfg(struct ata_port *ap, int want_ncq, int want_edma);
 
 static void mv_pmp_select(struct ata_port *ap, int pmp);
 static int mv_pmp_hardreset(struct ata_link *link, unsigned int *class,
@@ -849,8 +849,32 @@
 	mv_set_main_irq_mask(ap->host, disable_bits, enable_bits);
 }
 
+static void mv_clear_and_enable_port_irqs(struct ata_port *ap,
+					  void __iomem *port_mmio,
+					  unsigned int port_irqs)
+{
+	struct mv_host_priv *hpriv = ap->host->private_data;
+	int hardport = mv_hardport_from_port(ap->port_no);
+	void __iomem *hc_mmio = mv_hc_base_from_port(
+				mv_host_base(ap->host), ap->port_no);
+	u32 hc_irq_cause;
+
+	/* clear EDMA event indicators, if any */
+	writelfl(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
+
+	/* clear pending irq events */
+	hc_irq_cause = ~((DEV_IRQ | DMA_IRQ) << hardport);
+	writelfl(hc_irq_cause, hc_mmio + HC_IRQ_CAUSE_OFS);
+
+	/* clear FIS IRQ Cause */
+	if (IS_GEN_IIE(hpriv))
+		writelfl(0, port_mmio + SATA_FIS_IRQ_CAUSE_OFS);
+
+	mv_enable_port_irqs(ap, port_irqs);
+}
+
 /**
- *      mv_start_dma - Enable eDMA engine
+ *      mv_start_edma - Enable eDMA engine
  *      @base: port base address
  *      @pp: port private data
  *
@@ -860,7 +884,7 @@
  *      LOCKING:
  *      Inherited from caller.
  */
-static void mv_start_dma(struct ata_port *ap, void __iomem *port_mmio,
+static void mv_start_edma(struct ata_port *ap, void __iomem *port_mmio,
 			 struct mv_port_priv *pp, u8 protocol)
 {
 	int want_ncq = (protocol == ATA_PROT_NCQ);
@@ -872,26 +896,11 @@
 	}
 	if (!(pp->pp_flags & MV_PP_FLAG_EDMA_EN)) {
 		struct mv_host_priv *hpriv = ap->host->private_data;
-		int hardport = mv_hardport_from_port(ap->port_no);
-		void __iomem *hc_mmio = mv_hc_base_from_port(
-					mv_host_base(ap->host), ap->port_no);
-		u32 hc_irq_cause;
-
-		/* clear EDMA event indicators, if any */
-		writelfl(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
-
-		/* clear pending irq events */
-		hc_irq_cause = ~((DEV_IRQ | DMA_IRQ) << hardport);
-		writelfl(hc_irq_cause, hc_mmio + HC_IRQ_CAUSE_OFS);
 
-		mv_edma_cfg(ap, want_ncq);
-
-		/* clear FIS IRQ Cause */
-		if (IS_GEN_IIE(hpriv))
-			writelfl(0, port_mmio + SATA_FIS_IRQ_CAUSE_OFS);
+		mv_edma_cfg(ap, want_ncq, 1);
 
 		mv_set_edma_ptrs(port_mmio, hpriv, pp);
-		mv_enable_port_irqs(ap, DONE_IRQ|ERR_IRQ);
+		mv_clear_and_enable_port_irqs(ap, port_mmio, DONE_IRQ|ERR_IRQ);
 
 		writelfl(EDMA_EN, port_mmio + EDMA_CMD_OFS);
 		pp->pp_flags |= MV_PP_FLAG_EDMA_EN;
@@ -1173,7 +1182,7 @@
 		writel(new, hpriv->base + MV_GPIO_PORT_CTL_OFS);
 }
 
-static void mv_edma_cfg(struct ata_port *ap, int want_ncq)
+static void mv_edma_cfg(struct ata_port *ap, int want_ncq, int want_edma)
 {
 	u32 cfg;
 	struct mv_port_priv *pp    = ap->private_data;
@@ -1182,7 +1191,7 @@
 
 	/* set up non-NCQ EDMA configuration */
 	cfg = EDMA_CFG_Q_DEPTH;		/* always 0x1f for *all* chips */
-	pp->pp_flags &= ~MV_PP_FLAG_FBS_EN;
+	pp->pp_flags &= ~(MV_PP_FLAG_FBS_EN | MV_PP_FLAG_NCQ_EN);
 
 	if (IS_GEN_I(hpriv))
 		cfg |= (1 << 8);	/* enab config burst size mask */
@@ -1211,9 +1220,11 @@
 		}
 
 		cfg |= (1 << 23);	/* do not mask PM field in rx'd FIS */
-		cfg |= (1 << 22);	/* enab 4-entry host queue cache */
-		if (!IS_SOC(hpriv))
-			cfg |= (1 << 18);	/* enab early completion */
+		if (want_edma) {
+			cfg |= (1 << 22); /* enab 4-entry host queue cache */
+			if (!IS_SOC(hpriv))
+				cfg |= (1 << 18); /* enab early completion */
+		}
 		if (hpriv->hp_flags & MV_HP_CUT_THROUGH)
 			cfg |= (1 << 17); /* enab cut-thru (dis stor&forwrd) */
 	}
@@ -1221,8 +1232,7 @@
 	if (want_ncq) {
 		cfg |= EDMA_CFG_NCQ;
 		pp->pp_flags |=  MV_PP_FLAG_NCQ_EN;
-	} else
-		pp->pp_flags &= ~MV_PP_FLAG_NCQ_EN;
+	}
 
 	writelfl(cfg, port_mmio + EDMA_CFG_OFS);
 }
@@ -1591,7 +1601,7 @@
 		return ata_sff_qc_issue(qc);
 	}
 
-	mv_start_dma(ap, port_mmio, pp, qc->tf.protocol);
+	mv_start_edma(ap, port_mmio, pp, qc->tf.protocol);
 
 	pp->req_idx = (pp->req_idx + 1) & MV_MAX_Q_DEPTH_MASK;
 	in_index = pp->req_idx << EDMA_REQ_Q_PTR_SHIFT;
