From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 08/12] sata_mv fix mv_host_intr bug for hc_irq_cause
Date: Fri, 02 May 2008 02:13:27 -0400
Message-ID: <481AB107.701@rtr.ca>
References: <481AAF84.40501@rtr.ca> <481AAFB7.4090708@rtr.ca> <481AAFE0.9090101@rtr.ca> <481AB00A.3000206@rtr.ca> <481AB03A.60808@rtr.ca> <481AB070.9050707@rtr.ca> <481AB0A1.3040009@rtr.ca> <481AB0D2.3070103@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3609 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758815AbYEBGN3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 May 2008 02:13:29 -0400
In-Reply-To: <481AB0D2.3070103@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Remove the unwanted reads of hc_irq_cause from mv_host_intr(),
thereby removing a bug whereby we were not always reading it when needed..

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-05-01 20:01:29.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-05-01 20:15:59.000000000 -0400
@@ -1818,48 +1818,61 @@
 static int mv_host_intr(struct ata_host *host, u32 main_irq_cause)
 {
 	struct mv_host_priv *hpriv = host->private_data;
-	void __iomem *mmio = hpriv->base, *hc_mmio = NULL;
-	u32 hc_irq_cause = 0;
+	void __iomem *mmio = hpriv->base, *hc_mmio;
 	unsigned int handled = 0, port;
 
 	for (port = 0; port < hpriv->n_ports; port++) {
 		struct ata_port *ap = host->ports[port];
 		struct mv_port_priv *pp;
-		unsigned int shift, hardport, port_cause;
-		/*
-		 * When we move to the second hc, flag our cached
-		 * copies of hc_mmio (and hc_irq_cause) as invalid again.
-		 */
-		if (port == MV_PORTS_PER_HC)
-			hc_mmio = NULL;
-		/*
-		 * Do nothing if port is not interrupting or is disabled:
-		 */
+		unsigned int p, shift, hardport, port_cause;
+
 		MV_PORT_TO_SHIFT_AND_HARDPORT(port, shift, hardport);
-		port_cause = (main_irq_cause >> shift) & (DONE_IRQ | ERR_IRQ);
-		if (!port_cause || !ap || (ap->flags & ATA_FLAG_DISABLED))
-			continue;
 		/*
-		 * Each hc within the host has its own hc_irq_cause register.
-		 * We defer reading it until we know we need it, right now:
-		 *
-		 * FIXME later: we don't really need to read this register
-		 * (some logic changes required below if we go that way),
-		 * because it doesn't tell us anything new.  But we do need
-		 * to write to it, outside the top of this loop,
-		 * to reset the interrupt triggers for next time.
+		 * Each hc within the host has its own hc_irq_cause register,
+		 * where the interrupting ports bits get ack'd.
 		 */
-		if (!hc_mmio) {
+		if (hardport == 0) {	/* first port on this hc ? */
+			u32 hc_cause = (main_irq_cause >> shift) & HC0_IRQ_PEND;
+			u32 port_mask, ack_irqs;
+			/*
+			 * Skip this entire hc if nothing pending for any ports
+			 */
+			if (!hc_cause) {
+				port += MV_PORTS_PER_HC - 1;
+				continue;
+			}
+			/*
+			 * We don't need/want to read the hc_irq_cause register,
+			 * because doing so hurts performance, and
+			 * main_irq_cause already gives us everything we need.
+			 *
+			 * But we do have to *write* to the hc_irq_cause to ack
+			 * the ports that we are handling this time through.
+			 *
+			 * This requires that we create a bitmap for those
+			 * ports which interrupted us, and use that bitmap
+			 * to ack (only) those ports via hc_irq_cause.
+			 */
+			ack_irqs = 0;
+			for (p = 0; p < MV_PORTS_PER_HC; ++p) {
+				if ((port + p) >= hpriv->n_ports)
+					break;
+				port_mask = (DONE_IRQ | ERR_IRQ) << (p * 2);
+				if (hc_cause & port_mask)
+					ack_irqs |= (DMA_IRQ | DEV_IRQ) << p;
+			}
 			hc_mmio = mv_hc_base_from_port(mmio, port);
-			hc_irq_cause = readl(hc_mmio + HC_IRQ_CAUSE_OFS);
-			writelfl(~hc_irq_cause, hc_mmio + HC_IRQ_CAUSE_OFS);
+			writelfl(~ack_irqs, hc_mmio + HC_IRQ_CAUSE_OFS);
 			handled = 1;
 		}
+		port_cause = (main_irq_cause >> shift) & (DONE_IRQ | ERR_IRQ);
+		if (!port_cause)
+			continue;
 		/*
 		 * Process completed CRPB response(s) before other events.
 		 */
 		pp = ap->private_data;
-		if (hc_irq_cause & (DMA_IRQ << hardport)) {
+		if (port_cause & DONE_IRQ) {
 			if (pp->pp_flags & MV_PP_FLAG_EDMA_EN)
 				mv_process_crpb_entries(ap, pp);
 		}
@@ -1868,15 +1881,15 @@
 		 */
 		if (unlikely(port_cause & ERR_IRQ)) {
 			mv_err_intr(ap);
-		} else if (hc_irq_cause & (DEV_IRQ << hardport)) {
+		} else {
 			if (!(pp->pp_flags & MV_PP_FLAG_EDMA_EN)) {
 				struct ata_queued_cmd *qc = mv_get_active_qc(ap);
 				if (qc) {
 					ata_sff_host_intr(ap, qc);
 					continue;
 				}
+				mv_unexpected_intr(ap);
 			}
-			mv_unexpected_intr(ap);
 		}
 	}
 	return handled;
