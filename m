From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 06/12] sata_mv rearrange mv_config_fbs
Date: Fri, 02 May 2008 02:11:45 -0400
Message-ID: <481AB0A1.3040009@rtr.ca>
References: <481AAF84.40501@rtr.ca> <481AAFB7.4090708@rtr.ca> <481AAFE0.9090101@rtr.ca> <481AB00A.3000206@rtr.ca> <481AB03A.60808@rtr.ca> <481AB070.9050707@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1130 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751959AbYEBGLr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 May 2008 02:11:47 -0400
In-Reply-To: <481AB070.9050707@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Rearrange mv_config_fbs() to more closely follow the (corrected) datasheet
recommendations for NCQ and FIS-based switching (FBS).

Also, maintain a port flag to let us know when FBS is enabled.
We will make more use of that flag later in this patch series.

Signed-off-by: Mark Lord <mlord@pobox.com>
---
The final patch in this series builds further on top of this prep work.

--- old/drivers/ata/sata_mv.c	2008-05-01 18:04:24.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-05-01 18:16:38.000000000 -0400
@@ -366,6 +366,7 @@
 	/* Port private flags (pp_flags) */
 	MV_PP_FLAG_EDMA_EN	= (1 << 0),	/* is EDMA engine enabled? */
 	MV_PP_FLAG_NCQ_EN	= (1 << 1),	/* is EDMA set up for NCQ? */
+	MV_PP_FLAG_FBS_EN	= (1 << 2),	/* is EDMA set up for FBS? */
 };
 
 #define IS_GEN_I(hpriv) ((hpriv)->hp_flags & MV_HP_GEN_I)
@@ -1129,26 +1130,31 @@
 	return ATA_DEFER_PORT;
 }
 
-static void mv_config_fbs(void __iomem *port_mmio, int enable_fbs)
+static void mv_config_fbs(void __iomem *port_mmio, int want_ncq, int want_fbs)
 {
-	u32 old_fiscfg, new_fiscfg, old_ltmode, new_ltmode;
-	/*
-	 * Various bit settings required for operation
-	 * in FIS-based switching (fbs) mode on GenIIe:
-	 */
-	old_fiscfg = readl(port_mmio + FISCFG_OFS);
-	old_ltmode = readl(port_mmio + LTMODE_OFS);
-	if (enable_fbs) {
-		new_fiscfg = old_fiscfg |  FISCFG_SINGLE_SYNC;
-		new_ltmode = old_ltmode |  LTMODE_BIT8;
-	} else { /* disable fbs */
-		new_fiscfg = old_fiscfg & ~FISCFG_SINGLE_SYNC;
-		new_ltmode = old_ltmode & ~LTMODE_BIT8;
+	u32 new_fiscfg, old_fiscfg;
+	u32 new_ltmode, old_ltmode;
+	u32 new_haltcond, old_haltcond;
+
+	old_fiscfg   = readl(port_mmio + FISCFG_OFS);
+	old_ltmode   = readl(port_mmio + LTMODE_OFS);
+	old_haltcond = readl(port_mmio + EDMA_HALTCOND_OFS);
+
+	new_fiscfg   = old_fiscfg & ~(FISCFG_SINGLE_SYNC | FISCFG_WAIT_DEV_ERR);
+	new_ltmode   = old_ltmode & ~LTMODE_BIT8;
+	new_haltcond = old_haltcond | EDMA_ERR_DEV;
+
+	if (want_fbs) {
+		new_fiscfg = old_fiscfg | FISCFG_SINGLE_SYNC;
+		new_ltmode = old_ltmode | LTMODE_BIT8;
 	}
+
 	if (new_fiscfg != old_fiscfg)
 		writelfl(new_fiscfg, port_mmio + FISCFG_OFS);
 	if (new_ltmode != old_ltmode)
 		writelfl(new_ltmode, port_mmio + LTMODE_OFS);
+	if (new_haltcond != old_haltcond)
+		writelfl(new_haltcond, port_mmio + EDMA_HALTCOND_OFS);
 }
 
 static void mv_60x1_errata_sata25(struct ata_port *ap, int want_ncq)
@@ -1175,6 +1181,7 @@
 
 	/* set up non-NCQ EDMA configuration */
 	cfg = EDMA_CFG_Q_DEPTH;		/* always 0x1f for *all* chips */
+	pp->pp_flags &= ~MV_PP_FLAG_FBS_EN;
 
 	if (IS_GEN_I(hpriv))
 		cfg |= (1 << 8);	/* enab config burst size mask */
@@ -1184,19 +1191,30 @@
 		mv_60x1_errata_sata25(ap, want_ncq);
 
 	} else if (IS_GEN_IIE(hpriv)) {
+		int want_fbs = sata_pmp_attached(ap);
+		/*
+		 * Possible future enhancement:
+		 *
+		 * The chip can use FBS with non-NCQ, if we allow it,
+		 * But first we need to have the error handling in place
+		 * for this mode (datasheet section 7.3.15.4.2.3).
+		 * So disallow non-NCQ FBS for now.
+		 */
+		want_fbs &= want_ncq;
+
+		mv_config_fbs(port_mmio, want_ncq, want_fbs);
+
+		if (want_fbs) {
+			pp->pp_flags |= MV_PP_FLAG_FBS_EN;
+			cfg |= EDMA_CFG_EDMA_FBS; /* FIS-based switching */
+		}
+
 		cfg |= (1 << 23);	/* do not mask PM field in rx'd FIS */
 		cfg |= (1 << 22);	/* enab 4-entry host queue cache */
 		if (HAS_PCI(ap->host))
 			cfg |= (1 << 18);	/* enab early completion */
 		if (hpriv->hp_flags & MV_HP_CUT_THROUGH)
 			cfg |= (1 << 17); /* enab cut-thru (dis stor&forwrd) */
-
-		if (want_ncq && sata_pmp_attached(ap)) {
-			cfg |= EDMA_CFG_EDMA_FBS; /* FIS-based switching */
-			mv_config_fbs(port_mmio, 1);
-		} else {
-			mv_config_fbs(port_mmio, 0);
-		}
 	}
 
 	if (want_ncq) {
