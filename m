From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 06/09] sata_mv consolidate main_irq_mask updates
Date: Sat, 17 May 2008 13:35:21 -0400
Message-ID: <482F1759.20905@rtr.ca>
References: <482AE694.5080604@rtr.ca> <482AE6E2.4080900@rtr.ca> <482AE767.8090103@rtr.ca> <482AE817.2020809@rtr.ca> <482F1732.6010109@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4034 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752049AbYEQRfW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 May 2008 13:35:22 -0400
In-Reply-To: <482F1732.6010109@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Part two of simplifying/fixing handling of the main_irq_mask register
to resolve unexpected interrupt issues observed in 2.6.26-rc*.

Consolidate all updates of the host main_irq_mask register
into a single function.  This simplifies maintenance,
and also prepares the way for caching it (later).

No functionality changes in this update.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-05-16 16:03:53.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-05-16 16:04:45.000000000 -0400
@@ -837,6 +837,31 @@
 		 port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
 }
 
+static void mv_set_main_irq_mask(struct ata_host *host,
+				 u32 disable_bits, u32 enable_bits)
+{
+	struct mv_host_priv *hpriv = host->private_data;
+	u32 old_mask, new_mask;
+
+	old_mask = readl(hpriv->main_irq_mask_addr);
+	new_mask = (old_mask & ~disable_bits) | enable_bits;
+	if (new_mask != old_mask)
+		writelfl(new_mask, hpriv->main_irq_mask_addr);
+}
+
+static void mv_enable_port_irqs(struct ata_port *ap,
+				     unsigned int port_bits)
+{
+	unsigned int shift, hardport, port = ap->port_no;
+	u32 disable_bits, enable_bits;
+
+	MV_PORT_TO_SHIFT_AND_HARDPORT(port, shift, hardport);
+
+	disable_bits = (DONE_IRQ | ERR_IRQ) << shift;
+	enable_bits  = port_bits << shift;
+	mv_set_main_irq_mask(ap->host, disable_bits, enable_bits);
+}
+
 /**
  *      mv_start_dma - Enable eDMA engine
  *      @base: port base address
@@ -2383,7 +2408,6 @@
 	ZERO(MV_PCI_DISC_TIMER);
 	ZERO(MV_PCI_MSI_TRIGGER);
 	writel(0x000100ff, mmio + MV_PCI_XBAR_TMOUT_OFS);
-	ZERO(PCI_HC_MAIN_IRQ_MASK_OFS);
 	ZERO(MV_PCI_SERR_MASK);
 	ZERO(hpriv->irq_cause_ofs);
 	ZERO(hpriv->irq_mask_ofs);
@@ -2755,32 +2779,18 @@
 
 static void mv_eh_freeze(struct ata_port *ap)
 {
-	struct mv_host_priv *hpriv = ap->host->private_data;
-	unsigned int shift, hardport, port = ap->port_no;
-	u32 main_irq_mask;
-
-	/* FIXME: handle coalescing completion events properly */
-
 	mv_stop_edma(ap);
-	MV_PORT_TO_SHIFT_AND_HARDPORT(port, shift, hardport);
-
-	/* disable assertion of portN err, done events */
-	main_irq_mask = readl(hpriv->main_irq_mask_addr);
-	main_irq_mask &= ~((DONE_IRQ | ERR_IRQ) << shift);
-	writelfl(main_irq_mask, hpriv->main_irq_mask_addr);
+	mv_enable_port_irqs(ap, 0);
 }
 
 static void mv_eh_thaw(struct ata_port *ap)
 {
 	struct mv_host_priv *hpriv = ap->host->private_data;
-	unsigned int shift, hardport, port = ap->port_no;
+	unsigned int port = ap->port_no;
+	unsigned int hardport = mv_hardport_from_port(port);
 	void __iomem *hc_mmio = mv_hc_base_from_port(hpriv->base, port);
 	void __iomem *port_mmio = mv_ap_base(ap);
-	u32 main_irq_mask, hc_irq_cause;
-
-	/* FIXME: handle coalescing completion events properly */
-
-	MV_PORT_TO_SHIFT_AND_HARDPORT(port, shift, hardport);
+	u32 hc_irq_cause;
 
 	/* clear EDMA errors on this port */
 	writel(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
@@ -2790,10 +2800,7 @@
 	hc_irq_cause &= ~((DEV_IRQ | DMA_IRQ) << hardport);
 	writelfl(hc_irq_cause, hc_mmio + HC_IRQ_CAUSE_OFS);
 
-	/* enable assertion of portN err, done events */
-	main_irq_mask = readl(hpriv->main_irq_mask_addr);
-	main_irq_mask |= ((DONE_IRQ | ERR_IRQ) << shift);
-	writelfl(main_irq_mask, hpriv->main_irq_mask_addr);
+	mv_enable_port_irqs(ap, DONE_IRQ | ERR_IRQ);
 }
 
 /**
@@ -3046,7 +3053,7 @@
 	}
 
 	/* global interrupt mask: 0 == mask everything */
-	writel(0, hpriv->main_irq_mask_addr);
+	mv_set_main_irq_mask(host, ~0, 0);
 
 	n_hc = mv_get_hc_count(host->ports[0]->flags);
 
@@ -3099,7 +3106,7 @@
 		 * enable only global host interrupts for now.
 		 * The per-port interrupts get done later as ports are set up.
 		 */
-		writelfl(PCI_ERR, hpriv->main_irq_mask_addr);
+		mv_set_main_irq_mask(host, 0, PCI_ERR);
 	}
 done:
 	return rc;
