From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream 1/2] libata: cleanup ata_sff_interrupt()
Date: Tue, 19 Jan 2010 10:46:32 +0900
Message-ID: <4B550EF8.1000009@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35858 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930Ab0ASBk4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Jan 2010 20:40:56 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Hans Werner <hwerner4@gmx.de>, Sergei Shtylyov <sshtylyov>

host->ports[i] is never NULL if i < host->n_ports and non-NULL return
from ata_qc_from_tag() guarantees that the returned qc is active.
Drop unnecessary tests.

Superflous () dropped as suggested by Sergei.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
---
 drivers/ata/libata-sff.c |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

Index: ata/drivers/ata/libata-sff.c
===================================================================
--- ata.orig/drivers/ata/libata-sff.c
+++ ata/drivers/ata/libata-sff.c
@@ -1767,18 +1767,15 @@ irqreturn_t ata_sff_interrupt(int irq, v
 	spin_lock_irqsave(&host->lock, flags);
 
 	for (i = 0; i < host->n_ports; i++) {
-		struct ata_port *ap;
+		struct ata_port *ap = host->ports[i];
+		struct ata_queued_cmd *qc;
 
-		ap = host->ports[i];
-		if (ap &&
-		    !(ap->flags & ATA_FLAG_DISABLED)) {
-			struct ata_queued_cmd *qc;
+		if (unlikely(ap->flags & ATA_FLAG_DISABLED))
+			continue;
 
-			qc = ata_qc_from_tag(ap, ap->link.active_tag);
-			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)) &&
-			    (qc->flags & ATA_QCFLAG_ACTIVE))
-				handled |= ata_sff_host_intr(ap, qc);
-		}
+		qc = ata_qc_from_tag(ap, ap->link.active_tag);
+		if (qc && !(qc->tf.flags & ATA_TFLAG_POLLING))
+			handled |= ata_sff_host_intr(ap, qc);
 	}
 
 	spin_unlock_irqrestore(&host->lock, flags);
