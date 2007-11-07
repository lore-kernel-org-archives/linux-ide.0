From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 3/4] libata sata_qstor workaround for spurious interrupts
Date: Wed, 07 Nov 2007 10:53:41 -0500
Message-ID: <4731DF85.3000108@rtr.ca>
References: <4731DF06.3050202@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4408 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753690AbXKGPxm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Nov 2007 10:53:42 -0500
In-Reply-To: <4731DF06.3050202@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

sata_qstor workaround for spurious interrupts.

The qstor hardware generates spurious interrupts from time to time when switching
in and out of packet mode.  These eventually result in the IRQ being disabled,
which kills other devices sharing this IRQ with us.

This workaround isn't perfect, but it's about the best we can do for this hardware.
Spurious interrupts will still happen, but won't be logged as such,
and therefore won't cause the IRQ to be inadvertently disabled.

This belongs in 2.6.24.

Signed-off-by:  Mark Lord <mlord@pobox.com>
---

--- old/drivers/ata/sata_qstor.c	2007-11-07 09:12:32.000000000 -0500
+++ linux/drivers/ata/sata_qstor.c	2007-11-07 09:17:41.000000000 -0500
@@ -425,24 +425,27 @@
 		if (ap &&
 		    !(ap->flags & ATA_FLAG_DISABLED)) {
 			struct ata_queued_cmd *qc;
-			struct qs_port_priv *pp = ap->private_data;
-			if (!pp || pp->state != qs_state_mmio)
-				continue;
+			struct qs_port_priv *pp;
 			qc = ata_qc_from_tag(ap, ap->link.active_tag);
-			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING))) {
-
-				/* check main status, clearing INTRQ */
-				u8 status = ata_check_status(ap);
-				if ((status & ATA_BUSY))
-					continue;
-				DPRINTK("ata%u: protocol %d (dev_stat 0x%X)\n",
-					ap->print_id, qc->tf.protocol, status);
-
-				/* complete taskfile transaction */
-				qc->err_mask |= ac_err_mask(status);
-				ata_qc_complete(qc);
+			if (!qc || !(qc->flags & ATA_QCFLAG_ACTIVE)) {
+				/*
+				 * The qstor hardware generates spurious
+				 * interrupts from time to time when switching
+				 * in and out of packet mode.
+				 * There's no obvious way to know if we're
+				 * here now due to that, so just ack the irq
+				 * and pretend we knew it was ours.. (ugh).
+				 * This does not affect packet mode.
+				 */
+				ata_check_status(ap);
 				handled = 1;
+				continue;
 			}
+			pp = ap->private_data;
+			if (!pp || pp->state != qs_state_mmio)
+				continue;
+			if (!(qc->tf.flags & ATA_TFLAG_POLLING))
+				handled |= ata_host_intr(ap, qc);
 		}
 	}
 	return handled;
@@ -452,12 +455,13 @@
 {
 	struct ata_host *host = dev_instance;
 	unsigned int handled = 0;
+	unsigned long flags;
 
 	VPRINTK("ENTER\n");
 
-	spin_lock(&host->lock);
+	spin_lock_irqsave(&host->lock, flags);
 	handled  = qs_intr_pkt(host) | qs_intr_mmio(host);
-	spin_unlock(&host->lock);
+	spin_unlock_irqrestore(&host->lock, flags);
 
 	VPRINTK("EXIT\n");
 
