From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/15] libata: don't read TF directly from sense generation functions
Date: Sun, 2 Apr 2006 18:51:53 +0900
Message-ID: <11439715131394-git-send-email-htejun@gmail.com>
References: <11439715124131-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.229]:16243 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932314AbWDBJwG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 05:52:06 -0400
Received: by wproxy.gmail.com with SMTP id i22so1139534wra
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 01:52:05 -0800 (PST)
In-Reply-To: <11439715124131-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

TF register might not be directly accessible depending on errors.
e.g. TF of failed NCQ command is in log page 10h.  Make reading TF
responsibility of error handlers.  For the current EH, simply push TF
reading into qc completion functions as they are practically part of
EH.  New EH will fill qc->tf with status registers before complting
qcs.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-scsi.c |   27 +++++++++------------------
 1 files changed, 9 insertions(+), 18 deletions(-)

97b03d7b095baa09504d1c96720d2b45633d9c58
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index ec628ce..2870652 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -546,12 +546,6 @@ void ata_gen_ata_desc_sense(struct ata_q
 	cmd->result = (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;
 
 	/*
-	 * Read the controller registers.
-	 */
-	WARN_ON(qc->ap->ops->tf_read == NULL);
-	qc->ap->ops->tf_read(qc->ap, tf);
-
-	/*
 	 * Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
 	 */
@@ -622,12 +616,6 @@ void ata_gen_fixed_sense(struct ata_queu
 	cmd->result = (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;
 
 	/*
-	 * Read the controller registers.
-	 */
-	WARN_ON(qc->ap->ops->tf_read == NULL);
-	qc->ap->ops->tf_read(qc->ap, tf);
-
-	/*
 	 * Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
 	 */
@@ -1337,11 +1325,14 @@ static void ata_scsi_qc_complete(struct 
 	 */
 	if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
  	    ((cdb[2] & 0x20) || need_sense)) {
+		qc->ap->ops->tf_read(qc->ap, &qc->tf);
  		ata_gen_ata_desc_sense(qc);
 	} else {
 		if (!need_sense) {
 			cmd->result = SAM_STAT_GOOD;
 		} else {
+			qc->ap->ops->tf_read(qc->ap, &qc->tf);
+
 			/* TODO: decide which descriptor format to use
 			 * for 48b LBA devices and call that here
 			 * instead of the fixed desc, which is only
@@ -2133,13 +2124,15 @@ void ata_scsi_badcmd(struct scsi_cmnd *c
 
 static void atapi_sense_complete(struct ata_queued_cmd *qc)
 {
-	if (qc->err_mask && ((qc->err_mask & AC_ERR_DEV) == 0))
+	if (qc->err_mask && ((qc->err_mask & AC_ERR_DEV) == 0)) {
 		/* FIXME: not quite right; we don't want the
 		 * translation of taskfile registers into
 		 * a sense descriptors, since that's only
 		 * correct for ATA, not ATAPI
 		 */
+		qc->ap->ops->tf_read(qc->ap, &qc->tf);
 		ata_gen_ata_desc_sense(qc);
+	}
 
 	qc->scsidone(qc->scsicmd);
 	ata_qc_free(qc);
@@ -2207,17 +2200,15 @@ static void atapi_qc_complete(struct ata
 		cmd->result = SAM_STAT_CHECK_CONDITION;
 		atapi_request_sense(qc);
 		return;
-	}
-
-	else if (unlikely(err_mask))
+	} else if (unlikely(err_mask)) {
 		/* FIXME: not quite right; we don't want the
 		 * translation of taskfile registers into
 		 * a sense descriptors, since that's only
 		 * correct for ATA, not ATAPI
 		 */
+		qc->ap->ops->tf_read(qc->ap, &qc->tf);
 		ata_gen_ata_desc_sense(qc);
-
-	else {
+	} else {
 		u8 *scsicmd = cmd->cmnd;
 
 		if ((scsicmd[0] == INQUIRY) && ((scsicmd[1] & 0x03) == 0)) {
-- 
1.2.4


