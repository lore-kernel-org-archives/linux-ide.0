From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/23] libata-sff: update bmdma host bus error handling
Date: Mon, 10 May 2010 21:41:28 +0200
Message-ID: <1273520507-32459-5-git-send-email-tj@kernel.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44925 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755891Ab0EJTmK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 May 2010 15:42:10 -0400
In-Reply-To: <1273520507-32459-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, sshtylyov@mvista.com
Cc: Tejun Heo <tj@kernel.org>

* Clearing IRQ from ata_sff_error_handler() is necessary only when the
  port is gonna be thawed before performing EH actions and some
  controllers don't like being accessed after certain failure modes
  until they're reset.  Clear IRQ iff the port is being thawed.

* When the controller succesfully indicated bus error, the point of
  thawing doesn't matter.  Move thawing inside bmdma part of EH.  This
  is a bit ugly but will ease code reorganization later.

* Remove the unneeded ata_sff_sync().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-sff.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index b313896..10af348 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2359,7 +2359,7 @@ void ata_sff_error_handler(struct ata_port *ap)
 	ata_reset_fn_t hardreset = ap->ops->hardreset;
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
-	int thaw = 0;
+	bool thaw = false;
 
 	qc = __ata_qc_from_tag(ap, ap->link.active_tag);
 	if (qc && !(qc->flags & ATA_QCFLAG_FAILED))
@@ -2385,15 +2385,22 @@ void ata_sff_error_handler(struct ata_port *ap)
 		if (qc->err_mask == AC_ERR_TIMEOUT
 						&& (host_stat & ATA_DMA_ERR)) {
 			qc->err_mask = AC_ERR_HOST_BUS;
-			thaw = 1;
+			thaw = true;
 		}
 
 		ap->ops->bmdma_stop(qc);
+
+		/* if we're gonna thaw, make sure IRQ is clear */
+		if (thaw) {
+			ap->ops->sff_check_status(ap);
+			ap->ops->sff_irq_clear(ap);
+
+			spin_unlock_irqrestore(ap->lock, flags);
+			ata_eh_thaw_port(ap);
+			spin_lock_irqsave(ap->lock, flags);
+		}
 	}
 
-	ata_sff_sync(ap);		/* FIXME: We don't need this */
-	ap->ops->sff_check_status(ap);
-	ap->ops->sff_irq_clear(ap);
 	/* We *MUST* do FIFO draining before we issue a reset as several
 	 * devices helpfully clear their internal state and will lock solid
 	 * if we touch the data port post reset. Pass qc in case anyone wants
@@ -2404,9 +2411,6 @@ void ata_sff_error_handler(struct ata_port *ap)
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	if (thaw)
-		ata_eh_thaw_port(ap);
-
 	/* PIO and DMA engines have been stopped, perform recovery */
 
 	/* Ignore ata_sff_softreset if ctl isn't accessible and
-- 
1.6.4.2

