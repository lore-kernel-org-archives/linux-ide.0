From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 02/04] sata_mv: don't read hc_irq_cause
Date: Mon, 19 Jan 2009 18:05:42 -0500
Message-ID: <49750746.3010709@rtr.ca>
References: <49750705.7010709@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:43421 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752125AbZASXFn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Jan 2009 18:05:43 -0500
In-Reply-To: <49750705.7010709@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Remove silly read-modify-write sequences when clearing interrupts in hc_irq_cause.
This gets rid of unneeded MMIO reads, resulting in a slight performance boost
when switching between EDMA and non-EDMA modes (eg. for cache flushes).

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2009-01-16 11:52:17.000000000 -0500
+++ linux/drivers/ata/sata_mv.c	2009-01-19 16:47:24.000000000 -0500
@@ -35,8 +35,6 @@
  *
  * --> Investigate problems with PCI Message Signalled Interrupts (MSI).
  *
- * --> Cache frequently-accessed registers in mv_port_priv to reduce overhead.
- *
  * --> Develop a low-power-consumption strategy, and implement it.
  *
  * --> [Experiment, low priority] Investigate interrupt coalescing.
@@ -884,18 +882,14 @@
 		int hardport = mv_hardport_from_port(ap->port_no);
 		void __iomem *hc_mmio = mv_hc_base_from_port(
 					mv_host_base(ap->host), ap->port_no);
-		u32 hc_irq_cause, ipending;
+		u32 hc_irq_cause;
 
 		/* clear EDMA event indicators, if any */
 		writelfl(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
 
-		/* clear EDMA interrupt indicator, if any */
-		hc_irq_cause = readl(hc_mmio + HC_IRQ_CAUSE_OFS);
-		ipending = (DEV_IRQ | DMA_IRQ) << hardport;
-		if (hc_irq_cause & ipending) {
-			writelfl(hc_irq_cause & ~ipending,
-				 hc_mmio + HC_IRQ_CAUSE_OFS);
-		}
+		/* clear pending irq events */
+		hc_irq_cause = ~((DEV_IRQ | DMA_IRQ) << hardport);
+		writelfl(hc_irq_cause, hc_mmio + HC_IRQ_CAUSE_OFS);
 
 		mv_edma_cfg(ap, want_ncq);
 
@@ -2821,8 +2815,7 @@
 	writel(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
 
 	/* clear pending irq events */
-	hc_irq_cause = readl(hc_mmio + HC_IRQ_CAUSE_OFS);
-	hc_irq_cause &= ~((DEV_IRQ | DMA_IRQ) << hardport);
+	hc_irq_cause = ~((DEV_IRQ | DMA_IRQ) << hardport);
 	writelfl(hc_irq_cause, hc_mmio + HC_IRQ_CAUSE_OFS);
 
 	mv_enable_port_irqs(ap, ERR_IRQ);
