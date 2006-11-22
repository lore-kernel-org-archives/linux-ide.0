From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: don't schedule EH on wcache on/off if old EH
Date: Wed, 22 Nov 2006 12:39:43 +0900
Message-ID: <20061122033943.GV2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:29973 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S967037AbWKVDjv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Nov 2006 22:39:51 -0500
Received: by nf-out-0910.google.com with SMTP id o25so388405nfa
        for <linux-ide@vger.kernel.org>; Tue, 21 Nov 2006 19:39:50 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Do not schedule EH for revalidation on wcache on/off if old EH.  Old
EH cannot handle it and will result in WARN_ON()'s and oops.

This closes bug #7412.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Jeff, this one should go into #upstream-fixes too.

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 3976b25..fc03628 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1434,6 +1434,7 @@ nothing_to_do:
 
 static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 {
+	struct ata_port *ap = qc->ap;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	u8 *cdb = cmd->cmnd;
  	int need_sense = (qc->err_mask != 0);
@@ -1442,11 +1443,12 @@ static void ata_scsi_qc_complete(struct
 	 * schedule EH_REVALIDATE operation to update the IDENTIFY DEVICE
 	 * cache
 	 */
-	if (!need_sense && (qc->tf.command == ATA_CMD_SET_FEATURES) &&
+	if (ap->ops->error_handler &&
+	    !need_sense && (qc->tf.command == ATA_CMD_SET_FEATURES) &&
 	    ((qc->tf.feature == SETFEATURES_WC_ON) ||
 	     (qc->tf.feature == SETFEATURES_WC_OFF))) {
-		qc->ap->eh_info.action |= ATA_EH_REVALIDATE;
-		ata_port_schedule_eh(qc->ap);
+		ap->eh_info.action |= ATA_EH_REVALIDATE;
+		ata_port_schedule_eh(ap);
 	}
 
 	/* For ATA pass thru (SAT) commands, generate a sense block if
@@ -1473,8 +1475,8 @@ static void ata_scsi_qc_complete(struct
 		}
 	}
 
-	if (need_sense && !qc->ap->ops->error_handler)
-		ata_dump_status(qc->ap->id, &qc->result_tf);
+	if (need_sense && !ap->ops->error_handler)
+		ata_dump_status(ap->id, &qc->result_tf);
 
 	qc->scsidone(cmd);
 
