From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 6/8] sata_mv more interrupt handling rework
Date: Sat, 19 Apr 2008 14:53:07 -0400
Message-ID: <480A3F93.9080602@rtr.ca>
References: <480A3D2E.4040503@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3911 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754902AbYDSSxE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Apr 2008 14:53:04 -0400
In-Reply-To: <480A3D2E.4040503@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Continue fixing the interrupt handling logic.

Get rid of mv_intr_pio(), by using ata_sff_host_intr() for PIO..

Add a mv_unexpected_intr() catch-all for "impossible" scenarios,
where we get an interrupt that shouldn't have happened
(never seen in testing, but just in case..).

Rearrange the logic so that we always process completed
response queue entries before looking for other events,
This avoids having to re-issue commands that had already succeeded.

As part of this, we split out some duplicated functionality
into a new function, mv_get_active_qc().

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-04-19 13:36:17.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-04-19 13:47:23.000000000 -0400
@@ -1479,6 +1479,43 @@
 	return 0;
 }
 
+static struct ata_queued_cmd *mv_get_active_qc(struct ata_port *ap)
+{
+	struct mv_port_priv *pp = ap->private_data;
+	struct ata_queued_cmd *qc;
+
+	if (pp->pp_flags & MV_PP_FLAG_NCQ_EN)
+		return NULL;
+	qc = ata_qc_from_tag(ap, ap->link.active_tag);
+	if (qc && (qc->tf.flags & ATA_TFLAG_POLLING))
+		qc = NULL;
+	return qc;
+}
+
+static void mv_unexpected_intr(struct ata_port *ap)
+{
+	struct mv_port_priv *pp = ap->private_data;
+	struct ata_eh_info *ehi = &ap->link.eh_info;
+	char *when = "";
+
+	/*
+	 * We got a device interrupt from something that
+	 * was supposed to be using EDMA or polling.
+	 */
+	ata_ehi_clear_desc(ehi);
+	if (pp->pp_flags & MV_PP_FLAG_EDMA_EN) {
+		when = " while EDMA enabled";
+	} else {
+		struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->link.active_tag);
+		if (qc && (qc->tf.flags & ATA_TFLAG_POLLING))
+			when = " while polling";
+	}
+	ata_ehi_push_desc(ehi, "unexpected device interrupt%s", when);
+	ehi->err_mask |= AC_ERR_OTHER;
+	ehi->action   |= ATA_EH_RESET;
+	ata_port_freeze(ap);
+}
+
 /**
  *      mv_err_intr - Handle error interrupts on the port
  *      @ap: ATA channel to manipulate
@@ -1582,28 +1619,6 @@
 		ata_port_abort(ap);
 }
 
-static void mv_intr_pio(struct ata_port *ap)
-{
-	struct ata_queued_cmd *qc;
-	u8 ata_status;
-
-	/* ignore spurious intr if drive still BUSY */
-	ata_status = readb(ap->ioaddr.status_addr);
-	if (unlikely(ata_status & ATA_BUSY))
-		return;
-
-	/* get active ATA command */
-	qc = ata_qc_from_tag(ap, ap->link.active_tag);
-	if (unlikely(!qc))			/* no active tag */
-		return;
-	if (qc->tf.flags & ATA_TFLAG_POLLING)	/* polling; we don't own qc */
-		return;
-
-	/* and finally, complete the ATA command */
-	qc->err_mask |= ac_err_mask(ata_status);
-	ata_qc_complete(qc);
-}
-
 static void mv_process_crpb_response(struct ata_port *ap,
 		struct mv_crpb *response, unsigned int tag, int ncq_enabled)
 {
@@ -1676,15 +1691,7 @@
 /**
  *      mv_host_intr - Handle all interrupts on the given host controller
  *      @host: host specific structure
- *      @relevant: port error bits relevant to this host controller
- *      @hc: which host controller we're to look at
- *
- *      Read then write clear the HC interrupt status then walk each
- *      port connected to the HC and see if it needs servicing.  Port
- *      success ints are reported in the HC interrupt status reg, the
- *      port error ints are reported in the higher level main
- *      interrupt status register and thus are passed in via the
- *      'relevant' argument.
+ *      @main_cause: Main interrupt cause register for the chip.
  *
  *      LOCKING:
  *      Inherited from caller.
@@ -1729,25 +1736,28 @@
 			writelfl(~hc_irq_cause, hc_mmio + HC_IRQ_CAUSE_OFS);
 			handled = 1;
 		}
-
-		if (unlikely(port_cause & ERR_IRQ)) {
-			struct ata_queued_cmd *qc;
-
-			qc = ata_qc_from_tag(ap, ap->link.active_tag);
-			if (qc && (qc->tf.flags & ATA_TFLAG_POLLING))
-				continue;
-
-			mv_err_intr(ap, qc);
-			continue;
-		}
-
+		/*
+		 * Process completed CRPB response(s) before other events.
+		 */
 		pp = ap->private_data;
-		if (pp->pp_flags & MV_PP_FLAG_EDMA_EN) {
-			if ((DMA_IRQ << hardport) & hc_irq_cause)
+		if (hc_irq_cause & (DMA_IRQ << hardport)) {
+			if (pp->pp_flags & MV_PP_FLAG_EDMA_EN)
 				mv_process_crpb_entries(ap, pp);
-		} else {
-			if ((DEV_IRQ << hardport) & hc_irq_cause)
-				mv_intr_pio(ap);
+		}
+		/*
+		 * Handle chip-reported errors, or continue on to handle PIO.
+		 */
+		if (unlikely(port_cause & ERR_IRQ)) {
+			mv_err_intr(ap, mv_get_active_qc(ap));
+		} else if (hc_irq_cause & (DEV_IRQ << hardport)) {
+			if (!(pp->pp_flags & MV_PP_FLAG_EDMA_EN)) {
+				struct ata_queued_cmd *qc = mv_get_active_qc(ap);
+				if (qc) {
+					ata_sff_host_intr(ap, qc);
+					continue;
+				}
+			}
+			mv_unexpected_intr(ap);
 		}
 	}
 	return handled;
