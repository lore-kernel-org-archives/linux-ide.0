From: Mark Lord <liml@rtr.ca>
Subject: REPOST: [PATCH 3/8] sata_mv simplify freeze/thaw bit-shift calculations
Date: Sat, 19 Apr 2008 15:05:50 -0400
Message-ID: <480A428E.9060004@rtr.ca>
References: <480A3D2E.4040503@rtr.ca> <480A3DD9.5070606@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3142 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755764AbYDSTFr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Apr 2008 15:05:47 -0400
In-Reply-To: <480A3DD9.5070606@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Here it is again, minus the checkpatch.pl complaint:

Introduce the MV_PORT_TO_SHIFT_AND_HARDPORT() macro,
to centralize/simplify various scattered bits of logic
for calculating bit shifts and the like.

Some of the places that do this get it wrong, too,
so consolidating the algorithm at one place will help
keep the code correct.

For now, we use the new macro in mv_eh_{freeze,thaw}.
A subsequent patch will re-use this in the interrupt handlers

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-04-19 13:02:17.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-04-19 13:06:31.000000000 -0400
@@ -731,6 +731,24 @@
 	return port & MV_PORT_MASK;
 }
 
+/*
+ * Consolidate some rather tricky bit shift calculations.
+ * This is hot-path stuff, so not a function.
+ * Simple code, with two return values, so macro rather than inline.
+ *
+ * port is the sole input, in range 0..7.
+ * shift is one output, for use with the main_cause and main_mask registers.
+ * hardport is the other output, in range 0..3
+ *
+ * Note that port and hardport may be the same variable in some cases.
+ */
+#define MV_PORT_TO_SHIFT_AND_HARDPORT(port, shift, hardport)	\
+{								\
+	shift    = mv_hc_from_port(port) * HC_SHIFT;		\
+	hardport = mv_hardport_from_port(port);			\
+	shift   += hardport * 2;				\
+}
+
 static inline void __iomem *mv_hc_base(void __iomem *base, unsigned int hc)
 {
 	return (base + MV_SATAHC0_REG_BASE + (hc * MV_SATAHC_REG_SZ));
@@ -2408,15 +2426,13 @@
 static void mv_eh_freeze(struct ata_port *ap)
 {
 	struct mv_host_priv *hpriv = ap->host->private_data;
-	unsigned int hc = (ap->port_no > 3) ? 1 : 0;
-	unsigned int shift;
+	unsigned int shift, hardport, port = ap->port_no;
 	u32 main_mask;
 
 	/* FIXME: handle coalescing completion events properly */
 
-	shift = ap->port_no * 2;
-	if (hc > 0)
-		shift++;
+	mv_stop_edma(ap);
+	MV_PORT_TO_SHIFT_AND_HARDPORT(port, shift, hardport);
 
 	/* disable assertion of portN err, done events */
 	main_mask = readl(hpriv->main_mask_reg_addr);
@@ -2427,28 +2443,22 @@
 static void mv_eh_thaw(struct ata_port *ap)
 {
 	struct mv_host_priv *hpriv = ap->host->private_data;
-	void __iomem *mmio = hpriv->base;
-	unsigned int hc = (ap->port_no > 3) ? 1 : 0;
-	void __iomem *hc_mmio = mv_hc_base(mmio, hc);
+	unsigned int shift, hardport, port = ap->port_no;
+	void __iomem *hc_mmio = mv_hc_base_from_port(hpriv->base, port);
 	void __iomem *port_mmio = mv_ap_base(ap);
-	unsigned int shift, hc_port_no = ap->port_no;
 	u32 main_mask, hc_irq_cause;
 
 	/* FIXME: handle coalescing completion events properly */
 
-	shift = ap->port_no * 2;
-	if (hc > 0) {
-		shift++;
-		hc_port_no -= 4;
-	}
+	MV_PORT_TO_SHIFT_AND_HARDPORT(port, shift, hardport);
 
 	/* clear EDMA errors on this port */
 	writel(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
 
 	/* clear pending irq events */
 	hc_irq_cause = readl(hc_mmio + HC_IRQ_CAUSE_OFS);
-	hc_irq_cause &= ~((DEV_IRQ | DMA_IRQ) << hc_port_no);
-	writel(hc_irq_cause, hc_mmio + HC_IRQ_CAUSE_OFS);
+	hc_irq_cause &= ~((DEV_IRQ | DMA_IRQ) << hardport);
+	writelfl(hc_irq_cause, hc_mmio + HC_IRQ_CAUSE_OFS);
 
 	/* enable assertion of portN err, done events */
 	main_mask = readl(hpriv->main_mask_reg_addr);
