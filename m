From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 04/12] sata_mv new mv_qc_defer method
Date: Fri, 02 May 2008 02:10:02 -0400
Message-ID: <481AB03A.60808@rtr.ca>
References: <481AAF84.40501@rtr.ca> <481AAFB7.4090708@rtr.ca> <481AAFE0.9090101@rtr.ca> <481AB00A.3000206@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1124 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751538AbYEBGKE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 May 2008 02:10:04 -0400
In-Reply-To: <481AB00A.3000206@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

The EDMA engine cannot tolerate a mix of NCQ/non-NCQ commands,
and cannot be used for PIO at all.  So we need to prevent libata
from trying to feed us such mixtures.

Introduce mv_qc_defer() for this purpose, and use it for all chip versions.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-05-01 17:56:54.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-05-01 18:01:04.000000000 -0400
@@ -492,6 +492,7 @@
 static int mv5_scr_write(struct ata_port *ap, unsigned int sc_reg_in, u32 val);
 static int mv_port_start(struct ata_port *ap);
 static void mv_port_stop(struct ata_port *ap);
+static int mv_qc_defer(struct ata_queued_cmd *qc);
 static void mv_qc_prep(struct ata_queued_cmd *qc);
 static void mv_qc_prep_iie(struct ata_queued_cmd *qc);
 static unsigned int mv_qc_issue(struct ata_queued_cmd *qc);
@@ -561,6 +562,7 @@
 static struct ata_port_operations mv5_ops = {
 	.inherits		= &ata_sff_port_ops,
 
+	.qc_defer		= mv_qc_defer,
 	.qc_prep		= mv_qc_prep,
 	.qc_issue		= mv_qc_issue,
 
@@ -579,7 +581,6 @@
 
 static struct ata_port_operations mv6_ops = {
 	.inherits		= &mv5_ops,
-	.qc_defer		= sata_pmp_qc_defer_cmd_switch,
 	.dev_config             = mv6_dev_config,
 	.scr_read		= mv_scr_read,
 	.scr_write		= mv_scr_write,
@@ -592,7 +593,6 @@
 
 static struct ata_port_operations mv_iie_ops = {
 	.inherits		= &mv6_ops,
-	.qc_defer		= ata_std_qc_defer, /* FIS-based switching */
 	.dev_config		= ATA_OP_NULL,
 	.qc_prep		= mv_qc_prep_iie,
 };
@@ -1090,6 +1090,45 @@
 	}
 }
 
+static int mv_qc_defer(struct ata_queued_cmd *qc)
+{
+	struct ata_link *link = qc->dev->link;
+	struct ata_port *ap = link->ap;
+	struct mv_port_priv *pp = ap->private_data;
+
+	/*
+	 * If the port is completely idle, then allow the new qc.
+	 */
+	if (ap->nr_active_links == 0)
+		return 0;
+
+	if (pp->pp_flags & MV_PP_FLAG_EDMA_EN) {
+		/*
+		 * The port is operating in host queuing mode (EDMA).
+		 * It can accomodate a new qc if the qc protocol
+		 * is compatible with the current host queue mode.
+		 */
+		if (pp->pp_flags & MV_PP_FLAG_NCQ_EN) {
+			/*
+			 * The host queue (EDMA) is in NCQ mode.
+			 * If the new qc is also an NCQ command,
+			 * then allow the new qc.
+			 */
+			if (qc->tf.protocol == ATA_PROT_NCQ)
+				return 0;
+		} else {
+			/*
+			 * The host queue (EDMA) is in non-NCQ, DMA mode.
+			 * If the new qc is also a non-NCQ, DMA command,
+			 * then allow the new qc.
+			 */
+			if (qc->tf.protocol == ATA_PROT_DMA)
+				return 0;
+		}
+	}
+	return ATA_DEFER_PORT;
+}
+
 static void mv_config_fbs(void __iomem *port_mmio, int enable_fbs)
 {
 	u32 old_fiscfg, new_fiscfg, old_ltmode, new_ltmode;
