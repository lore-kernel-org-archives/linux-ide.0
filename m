From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 5/7] sata_mv: remove local copy of queue indexes
Date: Fri, 19 May 2006 16:36:36 -0400
Message-ID: <200605191636.36648.liml@rtr.ca>
References: <11480537082648-git-send-email-htejun@gmail.com> <446DEE92.50102@pobox.com> <200605191614.00023.liml@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:35818 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964808AbWESUgi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 16:36:38 -0400
In-Reply-To: <200605191614.00023.liml@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

The driver currently keeps local copies of the hardware request/response queue indexes.
But it expends significant effort ensuring consistency between the two views,
and still gets it wrong after an error or reset occurs.

This patch removes the local copies, in favour of just accessing the hardware
whenever we need them.  Eventually this may need to be tweaked again for NCQ,
but for now this works and solves problems some users were seeing.

Signed-off-by: Mark Lord <liml@rtr.ca>

---
--- linux/drivers/scsi/sata_mv.c	2006-05-19 15:40:46.000000000 -0400
+++ linux/drivers/scsi/sata_mv.c	2006-05-19 15:44:11.000000000 -0400
@@ -308,9 +308,6 @@
 	dma_addr_t		crpb_dma;
 	struct mv_sg		*sg_tbl;
 	dma_addr_t		sg_tbl_dma;
-
-	unsigned		req_producer;		/* cp of req_in_ptr */
-	unsigned		rsp_consumer;		/* cp of rsp_out_ptr */
 	u32			pp_flags;
 };
 
@@ -943,8 +940,6 @@
 	writelfl(pp->crpb_dma & EDMA_RSP_Q_BASE_LO_MASK,
 		 port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
 
-	pp->req_producer = pp->rsp_consumer = 0;
-
 	/* Don't turn on EDMA here...do it before DMA commands only.  Else
 	 * we'll be unable to send non-data, PIO, etc due to restricted access
 	 * to shadow regs.
@@ -1028,10 +1023,9 @@
 	}
 }
 
-static inline unsigned mv_inc_q_index(unsigned *index)
+static inline unsigned mv_inc_q_index(unsigned index)
 {
-	*index = (*index + 1) & MV_MAX_Q_DEPTH_MASK;
-	return *index;
+	return (index + 1) & MV_MAX_Q_DEPTH_MASK;
 }
 
 static inline void mv_crqb_pack_cmd(u16 *cmdw, u8 data, u8 addr, unsigned last)
@@ -1059,15 +1053,11 @@
 	u16 *cw;
 	struct ata_taskfile *tf;
 	u16 flags = 0;
+	unsigned in_index;
 
  	if (ATA_PROT_DMA != qc->tf.protocol)
 		return;
 
-	/* the req producer index should be the same as we remember it */
-	WARN_ON(((readl(mv_ap_base(qc->ap) + EDMA_REQ_Q_IN_PTR_OFS) >>
-		  EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) !=
-		pp->req_producer);
-
 	/* Fill in command request block
 	 */
 	if (!(qc->tf.flags & ATA_TFLAG_WRITE))
@@ -1075,13 +1065,17 @@
 	WARN_ON(MV_MAX_Q_DEPTH <= qc->tag);
 	flags |= qc->tag << CRQB_TAG_SHIFT;
 
-	pp->crqb[pp->req_producer].sg_addr =
+	/* get current queue index from hardware */
+	in_index = (readl(mv_ap_base(ap) + EDMA_REQ_Q_IN_PTR_OFS)
+			>> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK;
+
+	pp->crqb[in_index].sg_addr =
 		cpu_to_le32(pp->sg_tbl_dma & 0xffffffff);
-	pp->crqb[pp->req_producer].sg_addr_hi =
+	pp->crqb[in_index].sg_addr_hi =
 		cpu_to_le32((pp->sg_tbl_dma >> 16) >> 16);
-	pp->crqb[pp->req_producer].ctrl_flags = cpu_to_le16(flags);
+	pp->crqb[in_index].ctrl_flags = cpu_to_le16(flags);
 
-	cw = &pp->crqb[pp->req_producer].ata_cmd[0];
+	cw = &pp->crqb[in_index].ata_cmd[0];
 	tf = &qc->tf;
 
 	/* Sadly, the CRQB cannot accomodate all registers--there are
@@ -1150,16 +1144,12 @@
 	struct mv_port_priv *pp = ap->private_data;
 	struct mv_crqb_iie *crqb;
 	struct ata_taskfile *tf;
+	unsigned in_index;
 	u32 flags = 0;
 
  	if (ATA_PROT_DMA != qc->tf.protocol)
 		return;
 
-	/* the req producer index should be the same as we remember it */
-	WARN_ON(((readl(mv_ap_base(qc->ap) + EDMA_REQ_Q_IN_PTR_OFS) >>
-		  EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) !=
-		pp->req_producer);
-
 	/* Fill in Gen IIE command request block
 	 */
 	if (!(qc->tf.flags & ATA_TFLAG_WRITE))
@@ -1168,7 +1158,11 @@
 	WARN_ON(MV_MAX_Q_DEPTH <= qc->tag);
 	flags |= qc->tag << CRQB_TAG_SHIFT;
 
-	crqb = (struct mv_crqb_iie *) &pp->crqb[pp->req_producer];
+	/* get current queue index from hardware */
+	in_index = (readl(mv_ap_base(ap) + EDMA_REQ_Q_IN_PTR_OFS)
+			>> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK;
+
+	crqb = (struct mv_crqb_iie *) &pp->crqb[in_index];
 	crqb->addr = cpu_to_le32(pp->sg_tbl_dma & 0xffffffff);
 	crqb->addr_hi = cpu_to_le32((pp->sg_tbl_dma >> 16) >> 16);
 	crqb->flags = cpu_to_le32(flags);
@@ -1216,6 +1210,7 @@
 {
 	void __iomem *port_mmio = mv_ap_base(qc->ap);
 	struct mv_port_priv *pp = qc->ap->private_data;
+	unsigned in_index;
 	u32 in_ptr;
 
 	if (ATA_PROT_DMA != qc->tf.protocol) {
@@ -1227,23 +1222,20 @@
 		return ata_qc_issue_prot(qc);
 	}
 
-	in_ptr = readl(port_mmio + EDMA_REQ_Q_IN_PTR_OFS);
+	in_ptr   = readl(port_mmio + EDMA_REQ_Q_IN_PTR_OFS);
+	in_index = (in_ptr >> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK;
 
-	/* the req producer index should be the same as we remember it */
-	WARN_ON(((in_ptr >> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) !=
-		pp->req_producer);
 	/* until we do queuing, the queue should be empty at this point */
-	WARN_ON(((in_ptr >> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) !=
-		((readl(port_mmio + EDMA_REQ_Q_OUT_PTR_OFS) >>
-		  EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK));
+	WARN_ON(in_index != ((readl(port_mmio + EDMA_REQ_Q_OUT_PTR_OFS)
+		>> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK));
 
-	mv_inc_q_index(&pp->req_producer);	/* now incr producer index */
+	in_index = mv_inc_q_index(in_index);	/* now incr producer index */
 
 	mv_start_dma(port_mmio, pp);
 
 	/* and write the request in pointer to kick the EDMA to life */
 	in_ptr &= EDMA_REQ_Q_BASE_LO_MASK;
-	in_ptr |= pp->req_producer << EDMA_REQ_Q_PTR_SHIFT;
+	in_ptr |= in_index << EDMA_REQ_Q_PTR_SHIFT;
 	writelfl(in_ptr, port_mmio + EDMA_REQ_Q_IN_PTR_OFS);
 
 	return 0;
@@ -1266,28 +1258,26 @@
 {
 	void __iomem *port_mmio = mv_ap_base(ap);
 	struct mv_port_priv *pp = ap->private_data;
+	unsigned out_index;
 	u32 out_ptr;
 	u8 ata_status;
 
-	out_ptr = readl(port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
-
-	/* the response consumer index should be the same as we remember it */
-	WARN_ON(((out_ptr >> EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) !=
-		pp->rsp_consumer);
+	out_ptr   = readl(port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
+	out_index = (out_ptr >> EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK;
 
-	ata_status = pp->crpb[pp->rsp_consumer].flags >> CRPB_FLAG_STATUS_SHIFT;
+	ata_status = le16_to_cpu(pp->crpb[out_index].flags)
+					>> CRPB_FLAG_STATUS_SHIFT;
 
 	/* increment our consumer index... */
-	pp->rsp_consumer = mv_inc_q_index(&pp->rsp_consumer);
+	out_index = mv_inc_q_index(out_index);
 
 	/* and, until we do NCQ, there should only be 1 CRPB waiting */
-	WARN_ON(((readl(port_mmio + EDMA_RSP_Q_IN_PTR_OFS) >>
-		  EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) !=
-		pp->rsp_consumer);
+	WARN_ON(out_index != ((readl(port_mmio + EDMA_RSP_Q_IN_PTR_OFS)
+		>> EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK));
 
 	/* write out our inc'd consumer index so EDMA knows we're caught up */
 	out_ptr &= EDMA_RSP_Q_BASE_LO_MASK;
-	out_ptr |= pp->rsp_consumer << EDMA_RSP_Q_PTR_SHIFT;
+	out_ptr |= out_index << EDMA_RSP_Q_PTR_SHIFT;
 	writelfl(out_ptr, port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
 
 	/* Return ATA status register for completed CRPB */
