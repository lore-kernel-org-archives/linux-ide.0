From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 03/07] sata_mv: restructure mv_qc_issue
Date: Fri, 30 Jan 2009 18:48:41 -0500
Message-ID: <498391D9.2000403@rtr.ca>
References: <49839107.2040603@rtr.ca> <4983915F.7090705@rtr.ca> <498391A7.1090209@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:57877 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753175AbZA3Xsm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jan 2009 18:48:42 -0500
In-Reply-To: <498391A7.1090209@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Rearrange logic in mv_qc_issue() to handle protocols
other than ATA_PROT_DMA, ATA_PROT_NCQ, and ATA_PROT_PIO.
This is in preparation for later enabling ATAPI support.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2009-01-30 18:21:49.000000000 -0500
+++ linux/drivers/ata/sata_mv.c	2009-01-30 18:23:22.000000000 -0500
@@ -1565,14 +1565,26 @@
  */
 static unsigned int mv_qc_issue(struct ata_queued_cmd *qc)
 {
+	static int limit_warnings = 10;
 	struct ata_port *ap = qc->ap;
 	void __iomem *port_mmio = mv_ap_base(ap);
 	struct mv_port_priv *pp = ap->private_data;
 	u32 in_index;
+	unsigned int port_irqs = DONE_IRQ | ERR_IRQ;
 
-	if ((qc->tf.protocol != ATA_PROT_DMA) &&
-	    (qc->tf.protocol != ATA_PROT_NCQ)) {
-		static int limit_warnings = 10;
+	switch (qc->tf.protocol) {
+	case ATA_PROT_DMA:
+	case ATA_PROT_NCQ:
+		mv_start_edma(ap, port_mmio, pp, qc->tf.protocol);
+		pp->req_idx = (pp->req_idx + 1) & MV_MAX_Q_DEPTH_MASK;
+		in_index = pp->req_idx << EDMA_REQ_Q_PTR_SHIFT;
+
+		/* Write the request in pointer to kick the EDMA to life */
+		writelfl((pp->crqb_dma & EDMA_REQ_Q_BASE_LO_MASK) | in_index,
+					port_mmio + EDMA_REQ_Q_IN_PTR_OFS);
+		return 0;
+
+	case ATA_PROT_PIO:
 		/*
 		 * Errata SATA#16, SATA#24: warn if multiple DRQs expected.
 		 *
@@ -1590,27 +1602,22 @@
 					": attempting PIO w/multiple DRQ: "
 					"this may fail due to h/w errata\n");
 		}
+		/* drop through */
+	case ATAPI_PROT_PIO:
+		port_irqs = ERR_IRQ;	/* leave DONE_IRQ masked for PIO */
+		/* drop through */
+	default:
 		/*
 		 * We're about to send a non-EDMA capable command to the
 		 * port.  Turn off EDMA so there won't be problems accessing
 		 * shadow block, etc registers.
 		 */
 		mv_stop_edma(ap);
-		mv_enable_port_irqs(ap, ERR_IRQ);
+		mv_edma_cfg(ap, 0, 0);
+		mv_clear_and_enable_port_irqs(ap, mv_ap_base(ap), port_irqs);
 		mv_pmp_select(ap, qc->dev->link->pmp);
 		return ata_sff_qc_issue(qc);
 	}
-
-	mv_start_edma(ap, port_mmio, pp, qc->tf.protocol);
-
-	pp->req_idx = (pp->req_idx + 1) & MV_MAX_Q_DEPTH_MASK;
-	in_index = pp->req_idx << EDMA_REQ_Q_PTR_SHIFT;
-
-	/* and write the request in pointer to kick the EDMA to life */
-	writelfl((pp->crqb_dma & EDMA_REQ_Q_BASE_LO_MASK) | in_index,
-		 port_mmio + EDMA_REQ_Q_IN_PTR_OFS);
-
-	return 0;
 }
 
 static struct ata_queued_cmd *mv_get_active_qc(struct ata_port *ap)
