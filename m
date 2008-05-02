From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 09/12] sata_mv new mv_port_intr function
Date: Fri, 02 May 2008 02:14:02 -0400
Message-ID: <481AB12A.3030102@rtr.ca>
References: <481AAF84.40501@rtr.ca> <481AAFB7.4090708@rtr.ca> <481AAFE0.9090101@rtr.ca> <481AB00A.3000206@rtr.ca> <481AB03A.60808@rtr.ca> <481AB070.9050707@rtr.ca> <481AB0A1.3040009@rtr.ca> <481AB0D2.3070103@rtr.ca> <481AB107.701@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3612 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757235AbYEBGOD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 May 2008 02:14:03 -0400
In-Reply-To: <481AB107.701@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Separate out the inner loop body of mv_host_intr()
into it's own function called mv_port_intr().

This should help maintainabilty.

Signed-off-by: Mark Lord <mlord@pobox.com>
---
Ignore the checkpatch.pl "braces {} are not necessary" warning for now.
A subsequent patch installs more code within them.

--- old/drivers/ata/sata_mv.c	2008-05-01 20:15:59.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-05-01 20:01:40.000000000 -0400
@@ -1591,25 +1591,22 @@
 	return qc;
 }
 
-static void mv_unexpected_intr(struct ata_port *ap)
+static void mv_unexpected_intr(struct ata_port *ap, int edma_was_enabled)
 {
-	struct mv_port_priv *pp = ap->private_data;
 	struct ata_eh_info *ehi = &ap->link.eh_info;
-	char *when = "";
+	char *when = "idle";
 
-	/*
-	 * We got a device interrupt from something that
-	 * was supposed to be using EDMA or polling.
-	 */
 	ata_ehi_clear_desc(ehi);
-	if (pp->pp_flags & MV_PP_FLAG_EDMA_EN) {
-		when = " while EDMA enabled";
+	if (!ap || (ap->flags & ATA_FLAG_DISABLED)) {
+		when = "disabled";
+	} else if (edma_was_enabled) {
+		when = "EDMA enabled";
 	} else {
 		struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->link.active_tag);
 		if (qc && (qc->tf.flags & ATA_TFLAG_POLLING))
-			when = " while polling";
+			when = "polling";
 	}
-	ata_ehi_push_desc(ehi, "unexpected device interrupt%s", when);
+	ata_ehi_push_desc(ehi, "unexpected device interrupt while %s", when);
 	ehi->err_mask |= AC_ERR_OTHER;
 	ehi->action   |= ATA_EH_RESET;
 	ata_port_freeze(ap);
@@ -1807,6 +1804,42 @@
 			 port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
 }
 
+static void mv_port_intr(struct ata_port *ap, u32 port_cause)
+{
+	struct mv_port_priv *pp;
+	int edma_was_enabled;
+
+	if (!ap || (ap->flags & ATA_FLAG_DISABLED)) {
+		mv_unexpected_intr(ap, 0);
+		return;
+	}
+	/*
+	 * Grab a snapshot of the EDMA_EN flag setting,
+	 * so that we have a consistent view for this port,
+	 * even if something we call of our routines changes it.
+	 */
+	pp = ap->private_data;
+	edma_was_enabled = (pp->pp_flags & MV_PP_FLAG_EDMA_EN);
+	/*
+	 * Process completed CRPB response(s) before other events.
+	 */
+	if (edma_was_enabled && (port_cause & DONE_IRQ)) {
+		mv_process_crpb_entries(ap, pp);
+	}
+	/*
+	 * Handle chip-reported errors, or continue on to handle PIO.
+	 */
+	if (unlikely(port_cause & ERR_IRQ)) {
+		mv_err_intr(ap);
+	} else if (!edma_was_enabled) {
+		struct ata_queued_cmd *qc = mv_get_active_qc(ap);
+		if (qc)
+			ata_sff_host_intr(ap, qc);
+		else
+			mv_unexpected_intr(ap, edma_was_enabled);
+	}
+}
+
 /**
  *      mv_host_intr - Handle all interrupts on the given host controller
  *      @host: host specific structure
@@ -1823,7 +1856,6 @@
 
 	for (port = 0; port < hpriv->n_ports; port++) {
 		struct ata_port *ap = host->ports[port];
-		struct mv_port_priv *pp;
 		unsigned int p, shift, hardport, port_cause;
 
 		MV_PORT_TO_SHIFT_AND_HARDPORT(port, shift, hardport);
@@ -1865,32 +1897,12 @@
 			writelfl(~ack_irqs, hc_mmio + HC_IRQ_CAUSE_OFS);
 			handled = 1;
 		}
-		port_cause = (main_irq_cause >> shift) & (DONE_IRQ | ERR_IRQ);
-		if (!port_cause)
-			continue;
 		/*
-		 * Process completed CRPB response(s) before other events.
+		 * Handle interrupts signalled for this port:
 		 */
-		pp = ap->private_data;
-		if (port_cause & DONE_IRQ) {
-			if (pp->pp_flags & MV_PP_FLAG_EDMA_EN)
-				mv_process_crpb_entries(ap, pp);
-		}
-		/*
-		 * Handle chip-reported errors, or continue on to handle PIO.
-		 */
-		if (unlikely(port_cause & ERR_IRQ)) {
-			mv_err_intr(ap);
-		} else {
-			if (!(pp->pp_flags & MV_PP_FLAG_EDMA_EN)) {
-				struct ata_queued_cmd *qc = mv_get_active_qc(ap);
-				if (qc) {
-					ata_sff_host_intr(ap, qc);
-					continue;
-				}
-				mv_unexpected_intr(ap);
-			}
-		}
+		port_cause = (main_irq_cause >> shift) & (DONE_IRQ | ERR_IRQ);
+		if (port_cause)
+			mv_port_intr(ap, port_cause);
 	}
 	return handled;
 }
