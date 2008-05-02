From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 07/12] sata_mv NCQ and SError fixes for mv_err_intr
Date: Fri, 02 May 2008 02:12:34 -0400
Message-ID: <481AB0D2.3070103@rtr.ca>
References: <481AAF84.40501@rtr.ca> <481AAFB7.4090708@rtr.ca> <481AAFE0.9090101@rtr.ca> <481AB00A.3000206@rtr.ca> <481AB03A.60808@rtr.ca> <481AB070.9050707@rtr.ca> <481AB0A1.3040009@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3607 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757229AbYEBGMg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 May 2008 02:12:36 -0400
In-Reply-To: <481AB0A1.3040009@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Sigh.  Undo some earlier changes to mv_port_intr(),
so that we now read/clear SError again in all cases.

Arrange the top of the function to be as close as possible
to what we need for a later update (in this series) for ERR_DEV handling.

Fix things so that libata-eh can attempt a READ_LOG_EXT_10H
in response to a failed NCQ command, by just doing a local
mv_eh_freeze() rather than ata_port_freeze().

This will now fully handle NCQ errors much of the time,
but more fixes are needed for FBS/PMP, and for certain chip errata.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-05-01 18:18:27.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-05-01 18:39:27.000000000 -0400
@@ -1627,7 +1627,7 @@
  *      LOCKING:
  *      Inherited from caller.
  */
-static void mv_err_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
+static void mv_err_intr(struct ata_port *ap)
 {
 	void __iomem *port_mmio = mv_ap_base(ap);
 	u32 edma_err_cause, eh_freeze_mask, serr = 0;
@@ -1635,24 +1635,33 @@
 	struct mv_host_priv *hpriv = ap->host->private_data;
 	unsigned int action = 0, err_mask = 0;
 	struct ata_eh_info *ehi = &ap->link.eh_info;
-
-	ata_ehi_clear_desc(ehi);
+	struct ata_queued_cmd *qc;
+	int abort = 0;
 
 	/*
-	 * Read and clear the err_cause bits.  This won't actually
-	 * clear for some errors (eg. SError), but we will be doing
-	 * a hard reset in those cases regardless, which *will* clear it.
+	 * Read and clear the SError and err_cause bits.
 	 */
+	sata_scr_read(&ap->link, SCR_ERROR, &serr);
+	sata_scr_write_flush(&ap->link, SCR_ERROR, serr);
+
 	edma_err_cause = readl(port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
 	writelfl(~edma_err_cause, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
 
-	ata_ehi_push_desc(ehi, "edma_err_cause=%08x", edma_err_cause);
+	ata_port_printk(ap, KERN_INFO, "%s: err_cause=%08x pp_flags=0x%x\n",
+			__func__, edma_err_cause, pp->pp_flags);
 
+	qc = mv_get_active_qc(ap);
+	ata_ehi_clear_desc(ehi);
+	ata_ehi_push_desc(ehi, "edma_err_cause=%08x pp_flags=%08x",
+			  edma_err_cause, pp->pp_flags);
 	/*
 	 * All generations share these EDMA error cause bits:
 	 */
-	if (edma_err_cause & EDMA_ERR_DEV)
+	if (edma_err_cause & EDMA_ERR_DEV) {
 		err_mask |= AC_ERR_DEV;
+		action |= ATA_EH_RESET;
+		ata_ehi_push_desc(ehi, "dev error");
+	}
 	if (edma_err_cause & (EDMA_ERR_D_PAR | EDMA_ERR_PRD_PAR |
 			EDMA_ERR_CRQB_PAR | EDMA_ERR_CRPB_PAR |
 			EDMA_ERR_INTRL_PAR)) {
@@ -1684,13 +1693,6 @@
 			ata_ehi_push_desc(ehi, "EDMA self-disable");
 		}
 		if (edma_err_cause & EDMA_ERR_SERR) {
-			/*
-			 * Ensure that we read our own SCR, not a pmp link SCR:
-			 */
-			ap->ops->scr_read(ap, SCR_ERROR, &serr);
-			/*
-			 * Don't clear SError here; leave it for libata-eh:
-			 */
 			ata_ehi_push_desc(ehi, "SError=%08x", serr);
 			err_mask |= AC_ERR_ATA_BUS;
 			action |= ATA_EH_RESET;
@@ -1710,10 +1712,29 @@
 	else
 		ehi->err_mask |= err_mask;
 
-	if (edma_err_cause & eh_freeze_mask)
+	if (err_mask == AC_ERR_DEV) {
+		/*
+		 * Cannot do ata_port_freeze() here,
+		 * because it would kill PIO access,
+		 * which is needed for further diagnosis.
+		 */
+		mv_eh_freeze(ap);
+		abort = 1;
+	} else if (edma_err_cause & eh_freeze_mask) {
+		/*
+		 * Note to self: ata_port_freeze() calls ata_port_abort()
+		 */
 		ata_port_freeze(ap);
-	else
-		ata_port_abort(ap);
+	} else {
+		abort = 1;
+	}
+
+	if (abort) {
+		if (qc)
+			ata_link_abort(qc->dev->link);
+		else
+			ata_port_abort(ap);
+	}
 }
 
 static void mv_process_crpb_response(struct ata_port *ap,
@@ -1740,8 +1761,9 @@
 			}
 		}
 		ata_status = edma_status >> CRPB_FLAG_STATUS_SHIFT;
-		qc->err_mask |= ac_err_mask(ata_status);
-		ata_qc_complete(qc);
+		if (!ac_err_mask(ata_status))
+			ata_qc_complete(qc);
+		/* else: leave it for mv_err_intr() */
 	} else {
 		ata_port_printk(ap, KERN_ERR, "%s: no qc for tag=%d\n",
 				__func__, tag);
@@ -1845,7 +1867,7 @@
 		 * Handle chip-reported errors, or continue on to handle PIO.
 		 */
 		if (unlikely(port_cause & ERR_IRQ)) {
-			mv_err_intr(ap, mv_get_active_qc(ap));
+			mv_err_intr(ap);
 		} else if (hc_irq_cause & (DEV_IRQ << hardport)) {
 			if (!(pp->pp_flags & MV_PP_FLAG_EDMA_EN)) {
 				struct ata_queued_cmd *qc = mv_get_active_qc(ap);
