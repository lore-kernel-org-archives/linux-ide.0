From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 4/8] sata_mv simplify request/response queue handling
Date: Sat, 19 Apr 2008 14:46:59 -0400
Message-ID: <480A3E23.1060901@rtr.ca>
References: <480A3D2E.4040503@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3496 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752129AbYDSSq4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Apr 2008 14:46:56 -0400
In-Reply-To: <480A3D2E.4040503@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Try and simplify handling of the request/response queues.

Maintain the cached copies of queue indexes in a fully-masked state,
rather than having each use of them have to do the masking.

Split off handling of a single crpb response into a separate function,
to reduce complexity in the main mv_process_crpb_entries() routine.

Ignore the rarely-valid error bits from the crpb status field,
as we already handle that information in mv_err_intr().

For now, preserve the rest of the original logic.
A later patch will deal with fixing that separately.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-04-19 13:06:31.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-04-19 13:21:28.000000000 -0400
@@ -800,7 +800,8 @@
 	/*
 	 * initialize request queue
 	 */
-	index = (pp->req_idx & MV_MAX_Q_DEPTH_MASK) << EDMA_REQ_Q_PTR_SHIFT;
+	pp->req_idx &= MV_MAX_Q_DEPTH_MASK;	/* paranoia */
+	index = pp->req_idx << EDMA_REQ_Q_PTR_SHIFT;
 
 	WARN_ON(pp->crqb_dma & 0x3ff);
 	writel((pp->crqb_dma >> 16) >> 16, port_mmio + EDMA_REQ_Q_BASE_HI_OFS);
@@ -816,7 +817,8 @@
 	/*
 	 * initialize response queue
 	 */
-	index = (pp->resp_idx & MV_MAX_Q_DEPTH_MASK) << EDMA_RSP_Q_PTR_SHIFT;
+	pp->resp_idx &= MV_MAX_Q_DEPTH_MASK;	/* paranoia */
+	index = pp->resp_idx << EDMA_RSP_Q_PTR_SHIFT;
 
 	WARN_ON(pp->crpb_dma & 0xff);
 	writel((pp->crpb_dma >> 16) >> 16, port_mmio + EDMA_RSP_Q_BASE_HI_OFS);
@@ -1308,7 +1310,7 @@
 	flags |= (qc->dev->link->pmp & 0xf) << CRQB_PMP_SHIFT;
 
 	/* get current queue index from software */
-	in_index = pp->req_idx & MV_MAX_Q_DEPTH_MASK;
+	in_index = pp->req_idx;
 
 	pp->crqb[in_index].sg_addr =
 		cpu_to_le32(pp->sg_tbl_dma[qc->tag] & 0xffffffff);
@@ -1400,7 +1402,7 @@
 	flags |= (qc->dev->link->pmp & 0xf) << CRQB_PMP_SHIFT;
 
 	/* get current queue index from software */
-	in_index = pp->req_idx & MV_MAX_Q_DEPTH_MASK;
+	in_index = pp->req_idx;
 
 	crqb = (struct mv_crqb_iie *) &pp->crqb[in_index];
 	crqb->addr = cpu_to_le32(pp->sg_tbl_dma[qc->tag] & 0xffffffff);
@@ -1467,9 +1469,8 @@
 
 	mv_start_dma(ap, port_mmio, pp, qc->tf.protocol);
 
-	pp->req_idx++;
-
-	in_index = (pp->req_idx & MV_MAX_Q_DEPTH_MASK) << EDMA_REQ_Q_PTR_SHIFT;
+	pp->req_idx = (pp->req_idx + 1) & MV_MAX_Q_DEPTH_MASK;
+	in_index = pp->req_idx << EDMA_REQ_Q_PTR_SHIFT;
 
 	/* and write the request in pointer to kick the EDMA to life */
 	writelfl((pp->crqb_dma & EDMA_REQ_Q_BASE_LO_MASK) | in_index,
@@ -1603,70 +1604,72 @@
 	ata_qc_complete(qc);
 }
 
-static void mv_intr_edma(struct ata_port *ap)
+static void mv_process_crpb_response(struct ata_port *ap,
+		struct mv_crpb *response, unsigned int tag, int ncq_enabled)
+{
+	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, tag);
+
+	if (qc) {
+		u8 ata_status;
+		u16 edma_status = le16_to_cpu(response->flags);
+		/*
+		 * edma_status from a response queue entry:
+		 *   LSB is from EDMA_ERR_IRQ_CAUSE_OFS (non-NCQ only).
+		 *   MSB is saved ATA status from command completion.
+		 */
+		if (!ncq_enabled) {
+			u8 err_cause = edma_status & 0xff & ~EDMA_ERR_DEV;
+			if (err_cause) {
+				/*
+				 * Error will be seen/handled by mv_err_intr().
+				 * So do nothing at all here.
+				 */
+				return;
+			}
+		}
+		ata_status = edma_status >> CRPB_FLAG_STATUS_SHIFT;
+		qc->err_mask |= ac_err_mask(ata_status);
+		ata_qc_complete(qc);
+	} else {
+		ata_port_printk(ap, KERN_ERR, "%s: no qc for tag=%d\n",
+				__FUNCTION__, tag);
+	}
+}
+
+static void mv_process_crpb_entries(struct ata_port *ap, struct mv_port_priv *pp)
 {
 	void __iomem *port_mmio = mv_ap_base(ap);
 	struct mv_host_priv *hpriv = ap->host->private_data;
-	struct mv_port_priv *pp = ap->private_data;
-	struct ata_queued_cmd *qc;
-	u32 out_index, in_index;
+	u32 in_index;
 	bool work_done = false;
+	int ncq_enabled = (pp->pp_flags & MV_PP_FLAG_NCQ_EN);
 
-	/* get h/w response queue pointer */
+	/* Get the hardware queue position index */
 	in_index = (readl(port_mmio + EDMA_RSP_Q_IN_PTR_OFS)
 			>> EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK;
 
-	while (1) {
-		u16 status;
+	/* Process new responses from since the last time we looked */
+	while (in_index != pp->resp_idx) {
 		unsigned int tag;
+		struct mv_crpb *response = &pp->crpb[pp->resp_idx];
 
-		/* get s/w response queue last-read pointer, and compare */
-		out_index = pp->resp_idx & MV_MAX_Q_DEPTH_MASK;
-		if (in_index == out_index)
-			break;
+		pp->resp_idx = (pp->resp_idx + 1) & MV_MAX_Q_DEPTH_MASK;
 
-		/* 50xx: get active ATA command */
-		if (IS_GEN_I(hpriv))
+		if (IS_GEN_I(hpriv)) {
+			/* 50xx: no NCQ, only one command active at a time */
 			tag = ap->link.active_tag;
-
-		/* Gen II/IIE: get active ATA command via tag, to enable
-		 * support for queueing.  this works transparently for
-		 * queued and non-queued modes.
-		 */
-		else
-			tag = le16_to_cpu(pp->crpb[out_index].id) & 0x1f;
-
-		qc = ata_qc_from_tag(ap, tag);
-
-		/* For non-NCQ mode, the lower 8 bits of status
-		 * are from EDMA_ERR_IRQ_CAUSE_OFS,
-		 * which should be zero if all went well.
-		 */
-		status = le16_to_cpu(pp->crpb[out_index].flags);
-		if ((status & 0xff) && !(pp->pp_flags & MV_PP_FLAG_NCQ_EN)) {
-			mv_err_intr(ap, qc);
-			return;
-		}
-
-		/* and finally, complete the ATA command */
-		if (qc) {
-			qc->err_mask |=
-				ac_err_mask(status >> CRPB_FLAG_STATUS_SHIFT);
-			ata_qc_complete(qc);
+		} else {
+			/* Gen II/IIE: get command tag from CRPB entry */
+			tag = le16_to_cpu(response->id) & 0x1f;
 		}
-
-		/* advance software response queue pointer, to
-		 * indicate (after the loop completes) to hardware
-		 * that we have consumed a response queue entry.
-		 */
+		mv_process_crpb_response(ap, response, tag, ncq_enabled);
 		work_done = true;
-		pp->resp_idx++;
 	}
 
 	/* Update the software queue position index in hardware */
 	if (work_done)
 		writelfl((pp->crpb_dma & EDMA_RSP_Q_BASE_LO_MASK) |
-			 (out_index << EDMA_RSP_Q_PTR_SHIFT),
+			 (pp->resp_idx << EDMA_RSP_Q_PTR_SHIFT),
 			 port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
 }
 
@@ -1744,7 +1747,7 @@
 
 		if (pp->pp_flags & MV_PP_FLAG_EDMA_EN) {
 			if ((DMA_IRQ << hardport) & hc_irq_cause)
-				mv_intr_edma(ap);
+				mv_process_crpb_entries(ap, pp);
 		} else {
 			if ((DEV_IRQ << hardport) & hc_irq_cause)
 				mv_intr_pio(ap);
