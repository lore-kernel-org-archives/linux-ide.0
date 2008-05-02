From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 11/12] sata_mv delayed eh handling
Date: Fri, 02 May 2008 02:15:37 -0400
Message-ID: <481AB189.3070705@rtr.ca>
References: <481AAF84.40501@rtr.ca> <481AAFB7.4090708@rtr.ca> <481AAFE0.9090101@rtr.ca> <481AB00A.3000206@rtr.ca> <481AB03A.60808@rtr.ca> <481AB070.9050707@rtr.ca> <481AB0A1.3040009@rtr.ca> <481AB0D2.3070103@rtr.ca> <481AB107.701@rtr.ca> <481AB12A.3030102@rtr.ca> <481AB15D.5020201@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3620 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755225AbYEBGPi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 May 2008 02:15:38 -0400
In-Reply-To: <481AB15D.5020201@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Introduce a new "delayed error handling" mechanism in sata_mv,
to enable us to eventually deal with multiple simultaneous NCQ
failures on a single host link when a PM is present.

This involves a port flag (MV_PP_FLAG_DELAYED_EH) to prevent new
commands being queued, and a pmp bitmap to indicate which pmp links
had NCQ errors.

The new mv_pmp_error_handler() uses those values to invoke
ata_eh_analyze_ncq_error() on each failed link, prior to freezing
the port and passing control to sata_pmp_error_handler().

This is based upon a strategy suggested by Tejun.

For now, we just implement the delayed mechanism.
The next patch in this series will add the multiple-NCQ EH code
to take advantage of it.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-05-01 18:43:49.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-05-01 18:55:23.000000000 -0400
@@ -367,6 +367,7 @@
 	MV_PP_FLAG_EDMA_EN	= (1 << 0),	/* is EDMA engine enabled? */
 	MV_PP_FLAG_NCQ_EN	= (1 << 1),	/* is EDMA set up for NCQ? */
 	MV_PP_FLAG_FBS_EN	= (1 << 2),	/* is EDMA set up for FBS? */
+	MV_PP_FLAG_DELAYED_EH	= (1 << 3),	/* delayed dev err handling */
 };
 
 #define IS_GEN_I(hpriv) ((hpriv)->hp_flags & MV_HP_GEN_I)
@@ -447,6 +448,7 @@
 	unsigned int		resp_idx;
 
 	u32			pp_flags;
+	unsigned int		delayed_eh_pmp_map;
 };
 
 struct mv_port_signal {
@@ -542,6 +544,7 @@
 				unsigned long deadline);
 static int  mv_softreset(struct ata_link *link, unsigned int *class,
 				unsigned long deadline);
+static void mv_pmp_error_handler(struct ata_port *ap);
 
 /* .sg_tablesize is (MV_MAX_SG_CT / 2) in the structures below
  * because we have to allow room for worst case splitting of
@@ -589,7 +592,7 @@
 	.pmp_hardreset		= mv_pmp_hardreset,
 	.pmp_softreset		= mv_softreset,
 	.softreset		= mv_softreset,
-	.error_handler		= sata_pmp_error_handler,
+	.error_handler		= mv_pmp_error_handler,
 };
 
 static struct ata_port_operations mv_iie_ops = {
@@ -1098,6 +1101,12 @@
 	struct mv_port_priv *pp = ap->private_data;
 
 	/*
+	 * Don't allow new commands if we're in a delayed EH state
+	 * for NCQ and/or FIS-based switching.
+	 */
+	if (pp->pp_flags & MV_PP_FLAG_DELAYED_EH)
+		return ATA_DEFER_PORT;
+	/*
 	 * If the port is completely idle, then allow the new qc.
 	 */
 	if (ap->nr_active_links == 0)
@@ -1591,6 +1600,33 @@
 	return qc;
 }
 
+static void mv_pmp_error_handler(struct ata_port *ap)
+{
+	unsigned int pmp, pmp_map;
+	struct mv_port_priv *pp = ap->private_data;
+
+	if (pp->pp_flags & MV_PP_FLAG_DELAYED_EH) {
+		/*
+		 * Perform NCQ error analysis on failed PMPs
+		 * before we freeze the port entirely.
+		 *
+		 * The failed PMPs are marked earlier by mv_pmp_eh_prep().
+		 */
+		pmp_map = pp->delayed_eh_pmp_map;
+		pp->pp_flags &= ~MV_PP_FLAG_DELAYED_EH;
+		for (pmp = 0; pmp_map != 0; pmp++) {
+			unsigned int this_pmp = (1 << pmp);
+			if (pmp_map & this_pmp) {
+				struct ata_link *link = &ap->pmp_link[pmp];
+				pmp_map &= ~this_pmp;
+				ata_eh_analyze_ncq_error(link);
+			}
+		}
+		ata_port_freeze(ap);
+	}
+	sata_pmp_error_handler(ap);
+}
+
 static void mv_unexpected_intr(struct ata_port *ap, int edma_was_enabled)
 {
 	struct ata_eh_info *ehi = &ap->link.eh_info;
