From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream 1/2] libata: move command post processing to __ata_qc_complete()
Date: Fri, 12 Oct 2007 20:56:31 +0900
Message-ID: <20071012115631.GA11510@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:54740 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbXJLL4i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Oct 2007 07:56:38 -0400
Received: by wa-out-1112.google.com with SMTP id v27so966502wah
        for <linux-ide@vger.kernel.org>; Fri, 12 Oct 2007 04:56:37 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, ballen@gravity.phys.uwm.edu, andrew@ishiboo.com

Some commands need post-processing after successful completion.  This
was done in ata_scsi_qc_complete() till now but command post
processing doesn't belong to SAT layer.  Move them to
__ata_qc_complete() and, while at it, restructure a bit to ease adding
post-processing for other commands.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   25 +++++++++++++++++++++++++
 drivers/ata/libata-scsi.c |   23 -----------------------
 2 files changed, 25 insertions(+), 23 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -5536,6 +5536,31 @@ void __ata_qc_complete(struct ata_queued
 	qc->flags &= ~ATA_QCFLAG_ACTIVE;
 	ap->qc_active &= ~(1 << qc->tag);
 
+	/* some commands need post-processing after successful completion */
+	if (likely(qc->err_mask == 0)) {
+		unsigned int eh_action = 0;
+
+		switch (qc->tf.command) {
+		case ATA_CMD_SET_FEATURES:
+			/* cache configuration changed? */
+			if (ap->ops->error_handler &&
+			    ((qc->tf.feature == SETFEATURES_WC_ON) ||
+			     (qc->tf.feature == SETFEATURES_WC_OFF)))
+				eh_action |= ATA_EH_REVALIDATE;
+			break;
+
+		case ATA_CMD_INIT_DEV_PARAMS: /* CHS translation changed */
+		case ATA_CMD_SET_MULTI: /* multi_count changed */
+			eh_action |= ATA_EH_REVALIDATE;
+			break;
+		}
+
+		if (unlikely(eh_action) && ap->ops->error_handler) {
+			link->eh_info.action |= eh_action;
+			ata_port_schedule_eh(ap);
+		}
+	}
+
 	/* call completion callback */
 	qc->complete_fn(qc);
 }
Index: work/drivers/ata/libata-scsi.c
===================================================================
--- work.orig/drivers/ata/libata-scsi.c
+++ work/drivers/ata/libata-scsi.c
@@ -1363,33 +1363,10 @@ nothing_to_do:
 static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	struct ata_eh_info *ehi = &qc->dev->link->eh_info;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	u8 *cdb = cmd->cmnd;
  	int need_sense = (qc->err_mask != 0);
 
-	/* We snoop the SET_FEATURES - Write Cache ON/OFF command, and
-	 * schedule EH_REVALIDATE operation to update the IDENTIFY DEVICE
-	 * cache
-	 */
-	if (ap->ops->error_handler && !need_sense) {
-		switch (qc->tf.command) {
-		case ATA_CMD_SET_FEATURES:
-			if ((qc->tf.feature == SETFEATURES_WC_ON) ||
-			    (qc->tf.feature == SETFEATURES_WC_OFF)) {
-				ehi->action |= ATA_EH_REVALIDATE;
-				ata_port_schedule_eh(ap);
-			}
-			break;
-
-		case ATA_CMD_INIT_DEV_PARAMS: /* CHS translation changed */
-		case ATA_CMD_SET_MULTI: /* multi_count changed */
-			ehi->action |= ATA_EH_REVALIDATE;
-			ata_port_schedule_eh(ap);
-			break;
-		}
-	}
-
 	/* For ATA pass thru (SAT) commands, generate a sense block if
 	 * user mandated it or if there's an error.  Note that if we
 	 * generate because the user forced us to, a check condition
