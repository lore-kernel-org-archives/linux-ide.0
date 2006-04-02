From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/13] libata: update SCSI command completion path for new EH
Date: Mon, 3 Apr 2006 03:31:10 +0900
Message-ID: <1144002670775-git-send-email-htejun@gmail.com>
References: <1144002668278-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.203]:25247 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750963AbWDBSbU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 14:31:20 -0400
Received: by zproxy.gmail.com with SMTP id o37so1550555nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 11:31:20 -0700 (PDT)
In-Reply-To: <1144002668278-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

New EH is responsible for filling qc->tf with status and filling sense
data for ATAPI check sense.  Update SCSI command completion path to
reflect this.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-scsi.c |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

5752d59755f1a27ffb45829cfd41f725eb322121
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 745fc26..bfb9a5b 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1204,7 +1204,9 @@ static void ata_scsi_qc_complete(struct 
 		if (!need_sense) {
 			cmd->result = SAM_STAT_GOOD;
 		} else {
-			qc->ap->ops->tf_read(qc->ap, &qc->tf);
+			/* new EH already loaded qc->tf */
+			if (!qc->ap->ops->error_handler)
+				qc->ap->ops->tf_read(qc->ap, &qc->tf);
 
 			/* TODO: decide which descriptor format to use
 			 * for 48b LBA devices and call that here
@@ -2069,6 +2071,27 @@ static void atapi_qc_complete(struct ata
 
 	VPRINTK("ENTER, err_mask 0x%X\n", err_mask);
 
+	/* handle completion from new EH */
+	if (unlikely(qc->ap->ops->error_handler &&
+		     (err_mask || qc->flags & ATA_QCFLAG_SENSE_VALID))) {
+
+		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID)) {
+			/* FIXME: not quite right; we don't want the
+			 * translation of taskfile registers into a
+			 * sense descriptors, since that's only
+			 * correct for ATA, not ATAPI
+			 */
+			/* new EH already loaded qc->tf */
+			ata_gen_ata_desc_sense(qc);
+		}
+
+		qc->scsicmd->result = SAM_STAT_CHECK_CONDITION;
+		qc->scsidone(cmd);
+		ata_qc_free(qc);
+		return;
+	}
+
+	/* successful completion or old EH failure path */
 	if (unlikely(err_mask & AC_ERR_DEV)) {
 		cmd->result = SAM_STAT_CHECK_CONDITION;
 		atapi_request_sense(qc);
-- 
1.2.4


