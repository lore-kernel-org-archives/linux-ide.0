From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 12/12] sata_mv NCQ-EH for FIS-based switching
Date: Fri, 02 May 2008 02:16:20 -0400
Message-ID: <481AB1B4.7050508@rtr.ca>
References: <481AAF84.40501@rtr.ca> <481AAFB7.4090708@rtr.ca> <481AAFE0.9090101@rtr.ca> <481AB00A.3000206@rtr.ca> <481AB03A.60808@rtr.ca> <481AB070.9050707@rtr.ca> <481AB0A1.3040009@rtr.ca> <481AB0D2.3070103@rtr.ca> <481AB107.701@rtr.ca> <481AB12A.3030102@rtr.ca> <481AB15D.5020201@rtr.ca> <481AB189.3070705@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3622 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756474AbYEBGQW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 May 2008 02:16:22 -0400
In-Reply-To: <481AB189.3070705@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Convert sata_mv's EH for FIS-based switching (FBS) over to the
sequence recommended by Marvell.  This enables us to catch/analyze
multiple failed links on a port-multiplier when using NCQ.

To do this, we clear the ERR_DEV bit in the EDMA Halt-Conditions register,
so that the EDMA engine doesn't self-disable on the first NCQ error.

Our EH code sets the MV_PP_FLAG_DELAYED_EH flag to prevent new commands
being queued while we await completion of all outstanding NCQ commands
on all links of the failed PM.

The SATA Test Control register tells us which links have failed,
so we must only wait for any other active links to finish up
before we stop the EDMA and run the .error_handler afterward.

The patch also includes skeleton code for handling of non-NCQ FBS operation.
This is more for documentation purposes right now, as that mode is not yet
enabled in sata_mv.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-05-01 18:55:23.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-05-01 18:52:59.000000000 -0400
@@ -545,6 +545,8 @@
 static int  mv_softreset(struct ata_link *link, unsigned int *class,
 				unsigned long deadline);
 static void mv_pmp_error_handler(struct ata_port *ap);
+static void mv_process_crpb_entries(struct ata_port *ap,
+					struct mv_port_priv *pp);
 
 /* .sg_tablesize is (MV_MAX_SG_CT / 2) in the structures below
  * because we have to allow room for worst case splitting of
@@ -1156,6 +1158,10 @@
 	if (want_fbs) {
 		new_fiscfg = old_fiscfg | FISCFG_SINGLE_SYNC;
 		new_ltmode = old_ltmode | LTMODE_BIT8;
+		if (want_ncq)
+			new_haltcond &= ~EDMA_ERR_DEV;
+		else
+			new_fiscfg |=  FISCFG_WAIT_DEV_ERR;
 	}
 
 	if (new_fiscfg != old_fiscfg)
@@ -1627,6 +1633,154 @@
 	sata_pmp_error_handler(ap);
 }
 
+static unsigned int mv_get_err_pmp_map(struct ata_port *ap)
+{
+	void __iomem *port_mmio = mv_ap_base(ap);
+
+	return readl(port_mmio + SATA_TESTCTL_OFS) >> 16;
+}
+
+static int mv_count_pmp_links(unsigned int pmp_map)
+{
+	unsigned int link_count = 0;
+
+	while (pmp_map) {
+		link_count += (pmp_map & 1);
+		pmp_map >>= 1;
+	}
+	return link_count;
+}
+
+static void mv_pmp_eh_prep(struct ata_port *ap, unsigned int pmp_map)
+{
+	struct ata_eh_info *ehi;
+	unsigned int pmp;
+
+	/*
+	 * Initialize EH info for PMPs which saw device errors
+	 */
+	ehi = &ap->link.eh_info;
+	for (pmp = 0; pmp_map != 0; pmp++) {
+		unsigned int this_pmp = (1 << pmp);
+		if (pmp_map & this_pmp) {
+			struct ata_link *link = &ap->pmp_link[pmp];
+
+			pmp_map &= ~this_pmp;
+			ehi = &link->eh_info;
+			ata_ehi_clear_desc(ehi);
+			ata_ehi_push_desc(ehi, "dev err");
+			ehi->err_mask |= AC_ERR_DEV;
+			ehi->action |= ATA_EH_RESET;
+			ata_link_abort(link);
+		}
+	}
+}
+
+static int mv_handle_fbs_ncq_dev_err(struct ata_port *ap)
+{
+	struct mv_port_priv *pp = ap->private_data;
+	int failed_links;
+	unsigned int old_map, new_map;
+
+	/*
+	 * Device error during FBS+NCQ operation:
+	 *
+	 * Set a port flag to prevent further I/O being enqueued.
+	 * Leave the EDMA running to drain outstanding commands from this port.
+	 * Perform the post-mortem/EH only when all responses are complete.
+	 * Follow recovery sequence from 6042/7042 datasheet (7.3.15.4.2.2).
+	 */
+	if (!(pp->pp_flags & MV_PP_FLAG_DELAYED_EH)) {
+		pp->pp_flags |= MV_PP_FLAG_DELAYED_EH;
+		pp->delayed_eh_pmp_map = 0;
+	}
+	old_map = pp->delayed_eh_pmp_map;
+	new_map = old_map | mv_get_err_pmp_map(ap);
+
+	if (old_map != new_map) {
+		pp->delayed_eh_pmp_map = new_map;
+		mv_pmp_eh_prep(ap, new_map & ~old_map);
+	}
+	failed_links = mv_count_pmp_links(new_map);
+
+	ata_port_printk(ap, KERN_INFO, "%s: pmp_map=%04x qc_map=%04x "
+			"failed_links=%d nr_active_links=%d\n",
+			__func__, pp->delayed_eh_pmp_map,
+			ap->qc_active, failed_links,
+			ap->nr_active_links);
+
+	if (ap->nr_active_links <= failed_links) {
+		mv_process_crpb_entries(ap, pp);
+		mv_stop_edma(ap);
+		mv_eh_freeze(ap);
+		ata_port_printk(ap, KERN_INFO, "%s: done\n", __func__);
+		return 1;	/* handled */
+	}
+	ata_port_printk(ap, KERN_INFO, "%s: waiting\n", __func__);
+	return 1;	/* handled */
+}
+
+static int mv_handle_fbs_non_ncq_dev_err(struct ata_port *ap)
+{
+	/*
+	 * Possible future enhancement:
+	 *
+	 * FBS+non-NCQ operation is not yet implemented.
+	 * See related notes in mv_edma_cfg().
+	 *
+	 * Device error during FBS+non-NCQ operation:
+	 *
+	 * We need to snapshot the shadow registers for each failed command.
+	 * Follow recovery sequence from 6042/7042 datasheet (7.3.15.4.2.3).
+	 */
+	return 0;	/* not handled */
+}
+
+static int mv_handle_dev_err(struct ata_port *ap, u32 edma_err_cause)
+{
+	struct mv_port_priv *pp = ap->private_data;
+
+	if (!(pp->pp_flags & MV_PP_FLAG_EDMA_EN))
+		return 0;	/* EDMA was not active: not handled */
+	if (!(pp->pp_flags & MV_PP_FLAG_FBS_EN))
+		return 0;	/* FBS was not active: not handled */
+
+	if (!(edma_err_cause & EDMA_ERR_DEV))
+		return 0;	/* non DEV error: not handled */
+	edma_err_cause &= ~EDMA_ERR_IRQ_TRANSIENT;
+	if (edma_err_cause & ~(EDMA_ERR_DEV | EDMA_ERR_SELF_DIS))
+		return 0;	/* other problems: not handled */
+
+	if (pp->pp_flags & MV_PP_FLAG_NCQ_EN) {
+		/*
+		 * EDMA should NOT have self-disabled for this case.
+		 * If it did, then something is wrong elsewhere,
+		 * and we cannot handle it here.
+		 */
+		if (edma_err_cause & EDMA_ERR_SELF_DIS) {
+			ata_port_printk(ap, KERN_WARNING,
+				"%s: err_cause=0x%x pp_flags=0x%x\n",
+				__func__, edma_err_cause, pp->pp_flags);
+			return 0; /* not handled */
+		}
+		return mv_handle_fbs_ncq_dev_err(ap);
+	} else {
+		/*
+		 * EDMA should have self-disabled for this case.
+		 * If it did not, then something is wrong elsewhere,
+		 * and we cannot handle it here.
+		 */
+		if (!(edma_err_cause & EDMA_ERR_SELF_DIS)) {
+			ata_port_printk(ap, KERN_WARNING,
+				"%s: err_cause=0x%x pp_flags=0x%x\n",
+				__func__, edma_err_cause, pp->pp_flags);
+			return 0; /* not handled */
+		}
+		return mv_handle_fbs_non_ncq_dev_err(ap);
+	}
+	return 0;	/* not handled */
+}
+
 static void mv_unexpected_intr(struct ata_port *ap, int edma_was_enabled)
 {
 	struct ata_eh_info *ehi = &ap->link.eh_info;
@@ -1683,6 +1837,15 @@
 	ata_port_printk(ap, KERN_INFO, "%s: err_cause=%08x pp_flags=0x%x\n",
 			__func__, edma_err_cause, pp->pp_flags);
 
+	if (edma_err_cause & EDMA_ERR_DEV) {
+		/*
+		 * Device errors during FIS-based switching operation
+		 * require special handling.
+		 */
+		if (mv_handle_dev_err(ap, edma_err_cause))
+			return;
+	}
+
 	qc = mv_get_active_qc(ap);
 	ata_ehi_clear_desc(ehi);
 	ata_ehi_push_desc(ehi, "edma_err_cause=%08x pp_flags=%08x",
@@ -1861,6 +2024,8 @@
 	 */
 	if (edma_was_enabled && (port_cause & DONE_IRQ)) {
 		mv_process_crpb_entries(ap, pp);
+		if (pp->pp_flags & MV_PP_FLAG_DELAYED_EH)
+			mv_handle_fbs_ncq_dev_err(ap);
 	}
 	/*
 	 * Handle chip-reported errors, or continue on to handle PIO.
