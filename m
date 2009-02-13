From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 03/06] sata_mv: stricter irq masking
Date: Fri, 13 Feb 2009 00:05:45 -0500
Message-ID: <4994FFA9.7030300@rtr.ca>
References: <4994FF3D.90904@rtr.ca> <4994FF7C.2050607@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:35127 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729AbZBMFFr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Feb 2009 00:05:47 -0500
In-Reply-To: <4994FF7C.2050607@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tighten up interrupt masking in mv_qc_issue() so that it doesn't
miss any protocols.  Handle future cases where a qc is specially
marked for polled issue or where a particular chip version prefers
interrupts over polling for PIO.

This mimics the polling decision logic from ata_sff_qc_issue().

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2009-02-12 20:02:42.000000000 -0500
+++ linux/drivers/ata/sata_mv.c	2009-02-12 20:12:50.000000000 -0500
@@ -1809,7 +1809,7 @@
  	void __iomem *port_mmio = mv_ap_base(ap);
  	struct mv_port_priv *pp = ap->private_data;
  	u32 in_index;
-	unsigned int port_irqs = DONE_IRQ | ERR_IRQ;
+	unsigned int port_irqs;

  	switch (qc->tf.protocol) {
  	case ATA_PROT_DMA:
@@ -1842,20 +1842,28 @@
  					"this may fail due to h/w errata\n");
  		}
  		/* drop through */
+	case ATA_PROT_NODATA:
  	case ATAPI_PROT_PIO:
-		port_irqs = ERR_IRQ;	/* leave DONE_IRQ masked for PIO */
-		/* drop through */
-	default:
-		/*
-		 * We're about to send a non-EDMA capable command to the
-		 * port.  Turn off EDMA so there won't be problems accessing
-		 * shadow block, etc registers.
-		 */
-		mv_stop_edma(ap);
-		mv_clear_and_enable_port_irqs(ap, mv_ap_base(ap), port_irqs);
-		mv_pmp_select(ap, qc->dev->link->pmp);
-		return ata_sff_qc_issue(qc);
+	case ATAPI_PROT_NODATA:
+		if (ap->flags & ATA_FLAG_PIO_POLLING)
+			qc->tf.flags |= ATA_TFLAG_POLLING;
+		break;
  	}
+
+	if (qc->tf.flags & ATA_TFLAG_POLLING)
+		port_irqs = ERR_IRQ;	/* mask device interrupt when polling */
+	else
+		port_irqs = ERR_IRQ | DONE_IRQ;	/* unmask all interrupts */
+
+	/*
+	 * We're about to send a non-EDMA capable command to the
+	 * port.  Turn off EDMA so there won't be problems accessing
+	 * shadow block, etc registers.
+	 */
+	mv_stop_edma(ap);
+	mv_clear_and_enable_port_irqs(ap, mv_ap_base(ap), port_irqs);
+	mv_pmp_select(ap, qc->dev->link->pmp);
+	return ata_sff_qc_issue(qc);
  }

  static struct ata_queued_cmd *mv_get_active_qc(struct ata_port *ap)
