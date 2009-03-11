From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 04/03] sata_mv optimize IRQ coalescing for 8-port chips
Date: Wed, 11 Mar 2009 00:56:00 -0400
Message-ID: <49B74460.4080708@rtr.ca>
References: <49B6EE95.1010808@rtr.ca> <49B6EED8.8060205@rtr.ca> <49B6EF18.8050000@rtr.ca> <49B71B6D.40406@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:56523 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194AbZCKE4F (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Mar 2009 00:56:05 -0400
In-Reply-To: <49B71B6D.40406@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Enable use of the "all ports" IRQ coalescing optimization
for GEN_II / GEN_IIE chips that have dual host-controllers (8-ports).
Currently only the 6081 chip qualifies, but other chips may come along someday.

Rather than each half of the chip having to satisfy a local set of coalescing thresholds,
use of this feature groups all ports together under a single set of thresholds.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

This is a follow-up to the earlier 3-patch series for sata_mv IRQ coalescing.

--- old/drivers/ata/sata_mv.c	2009-03-11 00:47:57.000000000 -0400
+++ new/drivers/ata/sata_mv.c	2009-03-11 00:50:48.000000000 -0400
@@ -1016,7 +1016,7 @@
 	void __iomem *mmio = hpriv->base, *hc_mmio;
 	u32 coal_enable = 0;
 	unsigned long flags;
-	unsigned int clks;
+	unsigned int clks, is_dual_hc = hpriv->n_ports > MV_PORTS_PER_HC;
 	const u32 coal_disable = PORTS_0_3_COAL_DONE | PORTS_4_7_COAL_DONE |
 							ALL_PORTS_COAL_DONE;
 
@@ -1033,37 +1033,41 @@
 	}
 
 	spin_lock_irqsave(&host->lock, flags);
+	mv_set_main_irq_mask(host, coal_disable, 0);
 
-#if 0 /* disabled pending functional clarification from Marvell */
-	if (!IS_GEN_I(hpriv)) {
+	if (is_dual_hc && !IS_GEN_I(hpriv)) {
 		/*
-		 * GEN_II/GEN_IIE: global thresholds for the entire chip.
+		 * GEN_II/GEN_IIE with dual host controllers:
+		 * one set of global thresholds for the entire chip.
 		 */
 		writel(clks,  mmio + MV_IRQ_COAL_TIME_THRESHOLD);
 		writel(count, mmio + MV_IRQ_COAL_IO_THRESHOLD);
 		/* clear leftover coal IRQ bit */
-		writelfl(~ALL_PORTS_COAL_IRQ, mmio + MV_IRQ_COAL_CAUSE);
-		clks = count = 0; /* so as to clear the alternate regs below */
-		coal_enable = ALL_PORTS_COAL_DONE;
+		writel(~ALL_PORTS_COAL_IRQ, mmio + MV_IRQ_COAL_CAUSE);
+		if (count)
+			coal_enable = ALL_PORTS_COAL_DONE;
+		clks = count = 0; /* force clearing of regular regs below */
 	}
-#endif
+
 	/*
 	 * All chips: independent thresholds for each HC on the chip.
 	 */
 	hc_mmio = mv_hc_base_from_port(mmio, 0);
 	writel(clks,  hc_mmio + HC_IRQ_COAL_TIME_THRESHOLD_OFS);
 	writel(count, hc_mmio + HC_IRQ_COAL_IO_THRESHOLD_OFS);
-	coal_enable |= PORTS_0_3_COAL_DONE;
-	if (hpriv->n_ports > 4) {
+	writel(~HC_COAL_IRQ, hc_mmio + HC_IRQ_CAUSE_OFS);
+	if (count)
+		coal_enable |= PORTS_0_3_COAL_DONE;
+	if (is_dual_hc) {
 		hc_mmio = mv_hc_base_from_port(mmio, MV_PORTS_PER_HC);
 		writel(clks,  hc_mmio + HC_IRQ_COAL_TIME_THRESHOLD_OFS);
 		writel(count, hc_mmio + HC_IRQ_COAL_IO_THRESHOLD_OFS);
-		coal_enable |= PORTS_4_7_COAL_DONE;
+		writel(~HC_COAL_IRQ, hc_mmio + HC_IRQ_CAUSE_OFS);
+		if (count)
+			coal_enable |= PORTS_4_7_COAL_DONE;
 	}
-	if (!count)
-		coal_enable = 0;
-	mv_set_main_irq_mask(host, coal_disable, coal_enable);
 
+	mv_set_main_irq_mask(host, 0, coal_enable);
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
