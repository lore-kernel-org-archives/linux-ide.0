From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream] libata: relocate and fix post-command processing
Date: Thu, 25 Oct 2007 18:22:44 +0900
Message-ID: <20071025092244.GJ11853@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:36928 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754485AbXJYJWw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 05:22:52 -0400
Received: by wa-out-1112.google.com with SMTP id v27so554430wah
        for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 02:22:52 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, andrew.m.paprocki@gmail.com, ballen@gravity.phys.uwm.edu

Some commands need post-processing after successful completion.  This
was done in ata_scsi_qc_complete() till now but this has the following
problems.

* Post-command processing gets executed when qc is completed from EH.
  Some qc's are retried from EH with zero err_mask and thus triggers
  unnecessary/incorrect post-command processing.

* Command post processing doesn't belong to SAT layer.

* Link-wide revalidation was scheduled where device revalidation
  suffices.

This patch moves post-command processing to success completion path of
ata_qc_complete() which is travelled iff the command is going to be
completed without passing through EH and updates post-command
processing such that device-specific action is used.  While at it,
restructure code a bit for readability.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   20 ++++++++++++++++++++
 drivers/ata/libata-scsi.c |   23 -----------------------
 2 files changed, 20 insertions(+), 23 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -5594,6 +5594,9 @@ void ata_qc_complete(struct ata_queued_c
 	 * taken care of.
 	 */
 	if (ap->ops->error_handler) {
+		struct ata_device *dev = qc->dev;
+		struct ata_eh_info *ehi = &dev->link->eh_info;
+
 		WARN_ON(ap->pflags & ATA_PFLAG_FROZEN);
 
 		if (unlikely(qc->err_mask))
@@ -5612,6 +5615,23 @@ void ata_qc_complete(struct ata_queued_c
 		if (qc->flags & ATA_QCFLAG_RESULT_TF)
 			fill_result_tf(qc);
 
+		/* Some commands need post-processing after successful
+		 * completion.
+		 */
+		switch (qc->tf.command) {
+		case ATA_CMD_SET_FEATURES:
+			if (qc->tf.feature != SETFEATURES_WC_ON &&
+			    qc->tf.feature != SETFEATURES_WC_OFF)
+				break;
+			/* fall through */
+		case ATA_CMD_INIT_DEV_PARAMS: /* CHS translation changed */
+		case ATA_CMD_SET_MULTI: /* multi_count changed */
+			/* revalidate device */
+			ehi->dev_action[dev->devno] |= ATA_EH_REVALIDATE;
+			ata_port_schedule_eh(ap);
+			break;
+		}
+
 		__ata_qc_complete(qc);
 	} else {
 		if (qc->flags & ATA_QCFLAG_EH_SCHEDULED)
Index: work/drivers/ata/libata-scsi.c
===================================================================
--- work.orig/drivers/ata/libata-scsi.c
+++ work/drivers/ata/libata-scsi.c
@@ -1361,33 +1361,10 @@ nothing_to_do:
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
