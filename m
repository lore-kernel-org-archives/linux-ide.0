From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 02/02] sata_mv: warn on PIO with multiple DRQs
Date: Wed, 18 Jun 2008 12:13:02 -0400
Message-ID: <4859340E.60203@rtr.ca>
References: <485933A4.3010409@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1528 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753522AbYFRQNC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Jun 2008 12:13:02 -0400
In-Reply-To: <485933A4.3010409@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Chip errata sometimes prevents reliable use of PIO commands which involve
more than a single DRQ (data request).  In normal operation, libata should
not generate such PIO commands (uses DMA instead), but they could be sent
in via SG_IO from userspace.

A full workaround might be to break up such commands into sequences
of single DRQ ones, but that's just way too complex for something
that doesn't normally happen in real life.

So, allow the attempt (it often works, despite the errata),
but log the event for reference when somebody screams.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

Tejun/Alan/Jeff:

We may also want a patch to prevent libata-eh from downshifting
all the way to PIO on these chipsets, but I am not sure how to
accomplish that from inside sata_mv.  Any suggestions?


--- old/drivers/ata/sata_mv.c	2008-06-17 19:22:46.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-06-17 19:22:15.000000000 -0400
@@ -1595,6 +1595,24 @@
 
 	if ((qc->tf.protocol != ATA_PROT_DMA) &&
 	    (qc->tf.protocol != ATA_PROT_NCQ)) {
+		static int limit_warnings = 10;
+		/*
+		 * Errata SATA#16, SATA#24: warn if multiple DRQs expected.
+		 *
+		 * Someday, we might implement special polling workarounds
+		 * for these, but it all seems rather unnecessary since we
+		 * normally use only DMA for commands which transfer more
+		 * than a single block of data.
+		 *
+		 * Much of the time, this could just work regardless.
+		 * So for now, just log the incident, and allow the attempt.
+		 */
+		if (limit_warnings && (qc->nbytes / qc->sect_size) > 1) {
+			--limit_warnings;
+			ata_link_printk(qc->dev->link, KERN_WARNING, DRV_NAME
+					": attempting PIO w/multiple DRQ: "
+					"this may fail due to h/w errata\n");
+		}
 		/*
 		 * We're about to send a non-EDMA capable command to the
 		 * port.  Turn off EDMA so there won't be problems accessing
