From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/3] libata: convert assert(xxx)'s in low-level drivers to WARN_ON(!xxx)'s
Date: Sat, 11 Feb 2006 19:11:13 +0900
Message-ID: <11396526732153-git-send-email-htejun@gmail.com>
References: <11396526734098-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.176]:7226 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751372AbWBKKLR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Feb 2006 05:11:17 -0500
Received: by pproxy.gmail.com with SMTP id f25so319599pyf
        for <linux-ide@vger.kernel.org>; Sat, 11 Feb 2006 02:11:16 -0800 (PST)
In-Reply-To: <11396526734098-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

This patch converts all assert(xxx)'s in low-level drivers to
WARN_ON(!xxx)'s.  After this patch, there is no in-kernel user of the
libata assert() macro.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c       |    2 +-
 drivers/scsi/sata_mv.c    |   50 +++++++++++++++++++++++----------------------
 drivers/scsi/sata_qstor.c |    4 ++--
 drivers/scsi/sata_sx4.c   |    2 +-
 4 files changed, 29 insertions(+), 29 deletions(-)

5a00ebe55d888f3252e87798add5ae085bde4228
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index a65895f..12c76be 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -847,7 +847,7 @@ static inline int ahci_host_intr(struct 
 	ci = readl(port_mmio + PORT_CMD_ISSUE);
 	if (likely((ci & 0x1) == 0)) {
 		if (qc) {
-			assert(qc->err_mask == 0);
+			WARN_ON(qc->err_mask);
 			ata_qc_complete(qc);
 			qc = NULL;
 		}
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 6c80527..732cb64 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -632,8 +632,8 @@ static void mv_irq_clear(struct ata_port
  *      @base: port base address
  *      @pp: port private data
  *
- *      Verify the local cache of the eDMA state is accurate with an
- *      assert.
+ *      Verify the local cache of the eDMA state is accurate with a
+ *      WARN_ON.
  *
  *      LOCKING:
  *      Inherited from caller.
@@ -644,15 +644,15 @@ static void mv_start_dma(void __iomem *b
 		writelfl(EDMA_EN, base + EDMA_CMD_OFS);
 		pp->pp_flags |= MV_PP_FLAG_EDMA_EN;
 	}
-	assert(EDMA_EN & readl(base + EDMA_CMD_OFS));
+	WARN_ON(!(EDMA_EN & readl(base + EDMA_CMD_OFS)));
 }
 
 /**
  *      mv_stop_dma - Disable eDMA engine
  *      @ap: ATA channel to manipulate
  *
- *      Verify the local cache of the eDMA state is accurate with an
- *      assert.
+ *      Verify the local cache of the eDMA state is accurate with a
+ *      WARN_ON.
  *
  *      LOCKING:
  *      Inherited from caller.
@@ -670,7 +670,7 @@ static void mv_stop_dma(struct ata_port 
 		writelfl(EDMA_DS, port_mmio + EDMA_CMD_OFS);
 		pp->pp_flags &= ~MV_PP_FLAG_EDMA_EN;
 	} else {
-		assert(!(EDMA_EN & readl(port_mmio + EDMA_CMD_OFS)));
+		WARN_ON(EDMA_EN & readl(port_mmio + EDMA_CMD_OFS));
   	}
 
 	/* now properly wait for the eDMA to stop */
@@ -1061,15 +1061,15 @@ static void mv_qc_prep(struct ata_queued
 		return;
 
 	/* the req producer index should be the same as we remember it */
-	assert(((readl(mv_ap_base(qc->ap) + EDMA_REQ_Q_IN_PTR_OFS) >>
-		 EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) ==
-	       pp->req_producer);
+	WARN_ON(((readl(mv_ap_base(qc->ap) + EDMA_REQ_Q_IN_PTR_OFS) >>
+		  EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) !=
+		pp->req_producer);
 
 	/* Fill in command request block
 	 */
 	if (!(qc->tf.flags & ATA_TFLAG_WRITE))
 		flags |= CRQB_FLAG_READ;
-	assert(MV_MAX_Q_DEPTH > qc->tag);
+	WARN_ON(MV_MAX_Q_DEPTH <= qc->tag);
 	flags |= qc->tag << CRQB_TAG_SHIFT;
 
 	pp->crqb[pp->req_producer].sg_addr =
@@ -1152,16 +1152,16 @@ static void mv_qc_prep_iie(struct ata_qu
 		return;
 
 	/* the req producer index should be the same as we remember it */
-	assert(((readl(mv_ap_base(qc->ap) + EDMA_REQ_Q_IN_PTR_OFS) >>
-		 EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) ==
-	       pp->req_producer);
+	WARN_ON(((readl(mv_ap_base(qc->ap) + EDMA_REQ_Q_IN_PTR_OFS) >>
+		  EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) !=
+		pp->req_producer);
 
 	/* Fill in Gen IIE command request block
 	 */
 	if (!(qc->tf.flags & ATA_TFLAG_WRITE))
 		flags |= CRQB_FLAG_READ;
 
-	assert(MV_MAX_Q_DEPTH > qc->tag);
+	WARN_ON(MV_MAX_Q_DEPTH <= qc->tag);
 	flags |= qc->tag << CRQB_TAG_SHIFT;
 
 	crqb = (struct mv_crqb_iie *) &pp->crqb[pp->req_producer];
@@ -1226,12 +1226,12 @@ static unsigned int mv_qc_issue(struct a
 	in_ptr = readl(port_mmio + EDMA_REQ_Q_IN_PTR_OFS);
 
 	/* the req producer index should be the same as we remember it */
-	assert(((in_ptr >> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) ==
-	       pp->req_producer);
+	WARN_ON(((in_ptr >> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) !=
+		pp->req_producer);
 	/* until we do queuing, the queue should be empty at this point */
-	assert(((in_ptr >> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) ==
-	       ((readl(port_mmio + EDMA_REQ_Q_OUT_PTR_OFS) >>
-		 EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK));
+	WARN_ON(((in_ptr >> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) !=
+		((readl(port_mmio + EDMA_REQ_Q_OUT_PTR_OFS) >>
+		  EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK));
 
 	mv_inc_q_index(&pp->req_producer);	/* now incr producer index */
 
@@ -1251,7 +1251,7 @@ static unsigned int mv_qc_issue(struct a
  *
  *      This routine is for use when the port is in DMA mode, when it
  *      will be using the CRPB (command response block) method of
- *      returning command completion information.  We assert indices
+ *      returning command completion information.  We check indices
  *      are good, grab status, and bump the response consumer index to
  *      prove that we're up to date.
  *
@@ -1267,16 +1267,16 @@ static u8 mv_get_crpb_status(struct ata_
 	out_ptr = readl(port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
 
 	/* the response consumer index should be the same as we remember it */
-	assert(((out_ptr >> EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) ==
-	       pp->rsp_consumer);
+	WARN_ON(((out_ptr >> EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) !=
+		pp->rsp_consumer);
 
 	/* increment our consumer index... */
 	pp->rsp_consumer = mv_inc_q_index(&pp->rsp_consumer);
 
 	/* and, until we do NCQ, there should only be 1 CRPB waiting */
-	assert(((readl(port_mmio + EDMA_RSP_Q_IN_PTR_OFS) >>
-		 EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) ==
-	       pp->rsp_consumer);
+	WARN_ON(((readl(port_mmio + EDMA_RSP_Q_IN_PTR_OFS) >>
+		  EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) !=
+		pp->rsp_consumer);
 
 	/* write out our inc'd consumer index so EDMA knows we're caught up */
 	out_ptr &= EDMA_RSP_Q_BASE_LO_MASK;
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index 82c3df7..955131b 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -277,8 +277,8 @@ static unsigned int qs_fill_sg(struct at
 	unsigned int nelem;
 	u8 *prd = pp->pkt + QS_CPB_BYTES;
 
-	assert(qc->__sg != NULL);
-	assert(qc->n_elem > 0);
+	WARN_ON(qc->__sg == NULL);
+	WARN_ON(qc->n_elem == 0);
 
 	nelem = 0;
 	ata_for_each_sg(sg, qc) {
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index 212cff4..e158f7a 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -461,7 +461,7 @@ static void pdc20621_dma_prep(struct ata
 	unsigned int i, idx, total_len = 0, sgt_len;
 	u32 *buf = (u32 *) &pp->dimm_buf[PDC_DIMM_HEADER_SZ];
 
-	assert(qc->flags & ATA_QCFLAG_DMAMAP);
+	WARN_ON(!(qc->flags & ATA_QCFLAG_DMAMAP));
 
 	VPRINTK("ata%u: ENTER\n", ap->id);
 
-- 
1.1.5


