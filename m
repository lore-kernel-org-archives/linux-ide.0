From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 07/09] sata_mv fix pmp drives not found
Date: Sat, 17 May 2008 13:36:30 -0400
Message-ID: <482F179E.8020602@rtr.ca>
References: <482AE694.5080604@rtr.ca> <482AE6E2.4080900@rtr.ca> <482AE767.8090103@rtr.ca> <482AE817.2020809@rtr.ca> <482F1732.6010109@rtr.ca> <482F1759.20905@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4036 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756959AbYEQRgb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 May 2008 13:36:31 -0400
In-Reply-To: <482F1759.20905@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Part three of simplifying/fixing handling of the main_irq_mask register
to resolve unexpected interrupt issues observed in 2.6.26-rc*.

Partially fix a reported bug whereby we sometimes miss seeing drives on
a port-multiplier, as reported by Gwendal Grignou <gwendal@google.com>.

The problem was that we were receiving unexpected interrupts
during EH from POLLed commands while accessing port-multiplier registers.
These unexpected interrupts can be prevented by masking the DONE_IRQ bit
for the port whenever not operating in EDMA mode.

Also fix port_stop() to mask all port interrupts.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-05-16 16:04:45.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-05-16 16:05:48.000000000 -0400
@@ -908,6 +908,7 @@
 			writelfl(0, port_mmio + SATA_FIS_IRQ_CAUSE_OFS);
 
 		mv_set_edma_ptrs(port_mmio, hpriv, pp);
+		mv_enable_port_irqs(ap, DONE_IRQ|ERR_IRQ);
 
 		writelfl(EDMA_EN, port_mmio + EDMA_CMD_OFS);
 		pp->pp_flags |= MV_PP_FLAG_EDMA_EN;
@@ -1360,6 +1361,7 @@
 static void mv_port_stop(struct ata_port *ap)
 {
 	mv_stop_edma(ap);
+	mv_enable_port_irqs(ap, 0);
 	mv_port_free_dma_mem(ap);
 }
 
@@ -1601,6 +1603,7 @@
 		 * shadow block, etc registers.
 		 */
 		mv_stop_edma(ap);
+		mv_enable_port_irqs(ap, ERR_IRQ);
 		mv_pmp_select(ap, qc->dev->link->pmp);
 		return ata_sff_qc_issue(qc);
 	}
@@ -2800,7 +2803,7 @@
 	hc_irq_cause &= ~((DEV_IRQ | DMA_IRQ) << hardport);
 	writelfl(hc_irq_cause, hc_mmio + HC_IRQ_CAUSE_OFS);
 
-	mv_enable_port_irqs(ap, DONE_IRQ | ERR_IRQ);
+	mv_enable_port_irqs(ap, ERR_IRQ);
 }
 
 /**
