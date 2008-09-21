From: "Gwendal Grignou" <gwendal@google.com>
Subject: [sata_mv]: enable FIS Based Switching when a Port Multiplier is connected
Date: Sun, 21 Sep 2008 13:36:37 -0700
Message-ID: <e7510f760809211336s9b31924x7c243562fd805272@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:56660 "EHLO
	smtp-out3.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753670AbYIUUgp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Sep 2008 16:36:45 -0400
Received: from zps19.corp.google.com (zps19.corp.google.com [172.25.146.19])
	by smtp-out.google.com with ESMTP id m8LKaeqO021798
	for <linux-ide@vger.kernel.org>; Sun, 21 Sep 2008 21:36:40 +0100
Received: from fg-out-1718.google.com (fgae21.prod.google.com [10.86.56.21])
	by zps19.corp.google.com with ESMTP id m8LKabqU029802
	for <linux-ide@vger.kernel.org>; Sun, 21 Sep 2008 13:36:38 -0700
Received: by fg-out-1718.google.com with SMTP id e21so1201793fga.7
        for <linux-ide@vger.kernel.org>; Sun, 21 Sep 2008 13:36:37 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

>From 1201673e2d2462275e45a926cc2935a518d72258 Mon Sep 17 00:00:00 2001
From: Gwendal Grignou <gwendal@google.com>
Date: Tue, 9 Sep 2008 21:33:39 -0700
Subject: sata_mv: enable FIS Based Switching when a Port Multiplier is
connected,
 	even when NCQ is disabled.

This improve performance by allowing up to one command on each link
behind the port
multiplier at once.

Signed-off-by: Gwendal Grignou <gwendal@google.com>
---
 drivers/ata/libata-core.c |    7 ++-
 drivers/ata/libata-eh.c   |    1 +
 drivers/ata/sata_mv.c     |  139 ++++++++++++++++++++++++---------------------
 include/linux/libata.h    |    1 +
 4 files changed, 81 insertions(+), 67 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 79e3a8e..fcc7ce2 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4607,8 +4607,11 @@ static void fill_result_tf(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;

-	qc->result_tf.flags = qc->tf.flags;
-	ap->ops->qc_fill_rtf(qc);
+	if ((qc->flags & ATA_QCFLAG_RTF_VALID) == 0) {
+		qc->result_tf.flags = qc->tf.flags;
+		qc->flags |= ATA_QCFLAG_RTF_VALID;
+		ap->ops->qc_fill_rtf(qc);
+	}
 }

 static void ata_verify_xfer(struct ata_queued_cmd *qc)
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index c1db2f2..b5d753e 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1518,6 +1518,7 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
 	memcpy(&qc->result_tf, &tf, sizeof(tf));
 	qc->result_tf.flags = ATA_TFLAG_ISADDR | ATA_TFLAG_LBA | ATA_TFLAG_LBA48;
 	qc->err_mask |= AC_ERR_DEV | AC_ERR_NCQ;
+	qc->flags |= ATA_QCFLAG_RTF_VALID;
 	ehc->i.err_mask &= ~AC_ERR_DEV;
 }

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index c815f8e..46c0a9a 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -219,6 +219,9 @@ enum {
 	SATA_FIS_IRQ_CAUSE_OFS	= 0x364,
 	SATA_FIS_IRQ_AN		= (1 << 9),	/* async notification */

+	/* FIS registers */
+	SATA_FIS_DW0		= 0x370,
+
 	LTMODE_OFS		= 0x30c,
 	LTMODE_BIT8		= (1 << 8),	/* unknown, but necessary */

@@ -1145,6 +1148,14 @@ static int mv_qc_defer(struct ata_queued_cmd *qc)
 	    (pp->pp_flags & MV_PP_FLAG_NCQ_EN) && ata_is_ncq(qc->tf.protocol))
 		return 0;

+	/*
+	 * Allow DMA commands when EDMA is enabled only on different links
+	 */
+	if ((pp->pp_flags & MV_PP_FLAG_EDMA_EN) &&
+	    (pp->pp_flags & MV_PP_FLAG_FBS_EN) && ata_is_dma(qc->tf.protocol) &&
+	    !ata_tag_valid(link->active_tag) && !link->sactive)
+		return 0;
+
 	return ATA_DEFER_PORT;
 }

@@ -1165,9 +1176,8 @@ static void mv_config_fbs(void __iomem
*port_mmio, int want_ncq, int want_fbs)
 	if (want_fbs) {
 		new_fiscfg = old_fiscfg | FISCFG_SINGLE_SYNC;
 		new_ltmode = old_ltmode | LTMODE_BIT8;
-		if (want_ncq)
-			new_haltcond &= ~EDMA_ERR_DEV;
-		else
+		new_haltcond &= ~EDMA_ERR_DEV;
+		if (!want_ncq)
 			new_fiscfg |=  FISCFG_WAIT_DEV_ERR;
 	}

@@ -1214,15 +1224,6 @@ static void mv_edma_cfg(struct ata_port *ap,
int want_ncq)

 	} else if (IS_GEN_IIE(hpriv)) {
 		int want_fbs = sata_pmp_attached(ap);
-		/*
-		 * Possible future enhancement:
-		 *
-		 * The chip can use FBS with non-NCQ, if we allow it,
-		 * But first we need to have the error handling in place
-		 * for this mode (datasheet section 7.3.15.4.2.3).
-		 * So disallow non-NCQ FBS for now.
-		 */
-		want_fbs &= want_ncq;

 		mv_config_fbs(port_mmio, want_ncq, want_fbs);

@@ -1642,23 +1643,24 @@ static void mv_pmp_error_handler(struct ata_port *ap)
 	struct mv_port_priv *pp = ap->private_data;

 	if (pp->pp_flags & MV_PP_FLAG_DELAYED_EH) {
-		/*
-		 * Perform NCQ error analysis on failed PMPs
-		 * before we freeze the port entirely.
-		 *
-		 * The failed PMPs are marked earlier by mv_pmp_eh_prep().
-		 */
-		pmp_map = pp->delayed_eh_pmp_map;
 		pp->pp_flags &= ~MV_PP_FLAG_DELAYED_EH;
-		for (pmp = 0; pmp_map != 0; pmp++) {
-			unsigned int this_pmp = (1 << pmp);
-			if (pmp_map & this_pmp) {
-				struct ata_link *link = &ap->pmp_link[pmp];
-				pmp_map &= ~this_pmp;
-				ata_eh_analyze_ncq_error(link);
+		if (pp->pp_flags & MV_PP_FLAG_NCQ_EN) {
+			/*
+			 * Perform NCQ error analysis on failed PMPs
+			 * before we freeze the port entirely.
+			 *
+			 * The failed PMPs are marked earlier by mv_pmp_eh_prep().
+			 */
+			pmp_map = pp->delayed_eh_pmp_map;
+			for (pmp = 0; pmp_map != 0; pmp++) {
+				unsigned int this_pmp = (1 << pmp);
+				if (pmp_map & this_pmp) {
+					struct ata_link *link = &ap->pmp_link[pmp];
+					pmp_map &= ~this_pmp;
+					ata_eh_analyze_ncq_error(link);
+				}
 			}
 		}
-		ata_port_freeze(ap);
 	}
 	sata_pmp_error_handler(ap);
 }
@@ -1742,7 +1744,6 @@ static int mv_handle_fbs_ncq_dev_err(struct ata_port *ap)

 	if (ap->nr_active_links <= failed_links && mv_req_q_empty(ap)) {
 		mv_process_crpb_entries(ap, pp);
-		mv_stop_edma(ap);
 		mv_eh_freeze(ap);
 		ata_port_printk(ap, KERN_INFO, "%s: done\n", __func__);
 		return 1;	/* handled */
@@ -1753,18 +1754,43 @@ static int mv_handle_fbs_ncq_dev_err(struct
ata_port *ap)

 static int mv_handle_fbs_non_ncq_dev_err(struct ata_port *ap)
 {
+	u8 fis[6 * 4];
+	u8 pmp;
+	void __iomem *port_mmio = mv_ap_base(ap);
+	struct ata_queued_cmd *qc;
+	unsigned int tag;
+
 	/*
-	 * Possible future enhancement:
-	 *
-	 * FBS+non-NCQ operation is not yet implemented.
-	 * See related notes in mv_edma_cfg().
-	 *
 	 * Device error during FBS+non-NCQ operation:
 	 *
 	 * We need to snapshot the shadow registers for each failed command.
 	 * Follow recovery sequence from 6042/7042 datasheet (7.3.15.4.2.3).
 	 */
-	return 0;	/* not handled */
+	memcpy_fromio(fis, port_mmio + SATA_FIS_DW0, sizeof(fis));
+	pmp = fis[1] & 0xf;
+
+	/* If we are in FBS mode, we have a pmp attached */
+	WARN_ON(!sata_pmp_attached(ap));
+	if (pmp >= ap->nr_pmp_links) {
+		ata_port_printk(ap, KERN_ERR,
+				"%s: invalid FIS from device DW0=0x%08x\n",
+				__func__, *(u32*)(fis));
+		return 0;
+	}
+	tag = ap->pmp_link[pmp].active_tag;
+	qc = ata_qc_from_tag(ap, tag);
+	if (qc) {
+		qc->flags |= ATA_QCFLAG_RTF_VALID;
+		qc->result_tf.flags = qc->tf.flags;
+		ata_tf_from_fis(fis, &qc->result_tf);
+
+		return mv_handle_fbs_ncq_dev_err(ap);
+	}
+	else {
+		ata_port_printk(ap, KERN_ERR, "%s: no qc for tag=%d\n",
+				__func__, tag);
+		return 0;
+	}
 }

 static int mv_handle_dev_err(struct ata_port *ap, u32 edma_err_cause)
@@ -1779,34 +1805,12 @@ static int mv_handle_dev_err(struct ata_port
*ap, u32 edma_err_cause)
 	if (!(edma_err_cause & EDMA_ERR_DEV))
 		return 0;	/* non DEV error: not handled */
 	edma_err_cause &= ~EDMA_ERR_IRQ_TRANSIENT;
-	if (edma_err_cause & ~(EDMA_ERR_DEV | EDMA_ERR_SELF_DIS))
+	if (edma_err_cause & ~EDMA_ERR_DEV)
 		return 0;	/* other problems: not handled */

 	if (pp->pp_flags & MV_PP_FLAG_NCQ_EN) {
-		/*
-		 * EDMA should NOT have self-disabled for this case.
-		 * If it did, then something is wrong elsewhere,
-		 * and we cannot handle it here.
-		 */
-		if (edma_err_cause & EDMA_ERR_SELF_DIS) {
-			ata_port_printk(ap, KERN_WARNING,
-				"%s: err_cause=0x%x pp_flags=0x%x\n",
-				__func__, edma_err_cause, pp->pp_flags);
-			return 0; /* not handled */
-		}
 		return mv_handle_fbs_ncq_dev_err(ap);
 	} else {
-		/*
-		 * EDMA should have self-disabled for this case.
-		 * If it did not, then something is wrong elsewhere,
-		 * and we cannot handle it here.
-		 */
-		if (!(edma_err_cause & EDMA_ERR_SELF_DIS)) {
-			ata_port_printk(ap, KERN_WARNING,
-				"%s: err_cause=0x%x pp_flags=0x%x\n",
-				__func__, edma_err_cause, pp->pp_flags);
-			return 0; /* not handled */
-		}
 		return mv_handle_fbs_non_ncq_dev_err(ap);
 	}
 	return 0;	/* not handled */
@@ -1855,7 +1859,7 @@ static void mv_err_intr(struct ata_port *ap)
 	unsigned int action = 0, err_mask = 0;
 	struct ata_eh_info *ehi = &ap->link.eh_info;
 	struct ata_queued_cmd *qc;
-	int abort = 0;
+	int abort = 0, handled = 0;

 	/*
 	 * Read and clear the SError and err_cause bits.
@@ -1866,20 +1870,25 @@ static void mv_err_intr(struct ata_port *ap)
 	sata_scr_write_flush(&ap->link, SCR_ERROR, serr);

 	edma_err_cause = readl(port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
-	if (IS_GEN_IIE(hpriv) && (edma_err_cause & EDMA_ERR_TRANS_IRQ_7)) {
-		fis_cause = readl(port_mmio + SATA_FIS_IRQ_CAUSE_OFS);
-		writelfl(~fis_cause, port_mmio + SATA_FIS_IRQ_CAUSE_OFS);
-	}
-	writelfl(~edma_err_cause, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
-
 	if (edma_err_cause & EDMA_ERR_DEV) {
 		/*
 		 * Device errors during FIS-based switching operation
 		 * require special handling.
 		 */
-		if (mv_handle_dev_err(ap, edma_err_cause))
-			return;
+		handled = mv_handle_dev_err(ap, edma_err_cause);
 	}
+	if (IS_GEN_IIE(hpriv) &&
+	    ((edma_err_cause & EDMA_ERR_TRANS_IRQ_7) ||
+	     ((edma_err_cause & EDMA_ERR_DEV) &&
+	      (pp->pp_flags & MV_PP_FLAG_FBS_EN) &&
+	      !(pp->pp_flags & MV_PP_FLAG_NCQ_EN)))) {
+		fis_cause = readl(port_mmio + SATA_FIS_IRQ_CAUSE_OFS);
+		writelfl(~fis_cause, port_mmio + SATA_FIS_IRQ_CAUSE_OFS);
+	}
+	writelfl(~edma_err_cause, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
+
+	if (handled)
+		return;

 	qc = mv_get_active_qc(ap);
 	ata_ehi_clear_desc(ehi);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 225bfc5..08fc5a9 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -233,6 +233,7 @@ enum {
 	ATA_QCFLAG_FAILED	= (1 << 16), /* cmd failed and is owned by EH */
 	ATA_QCFLAG_SENSE_VALID	= (1 << 17), /* sense data valid */
 	ATA_QCFLAG_EH_SCHEDULED = (1 << 18), /* EH scheduled (obsolete) */
+	ATA_QCFLAG_RTF_VALID	= (1 << 19), /* set when result_tf is valid */

 	/* host set flags */
 	ATA_HOST_SIMPLEX	= (1 << 0),	/* Host is simplex, one DMA channel per
host only */
-- 
1.5.4.5
