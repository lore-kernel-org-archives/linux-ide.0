From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 15/16] libata-eh-fw: update SCSI command completion path for new EH
Date: Tue, 11 Apr 2006 22:42:55 +0900
Message-ID: <1144762975483-git-send-email-htejun@gmail.com>
References: <11447629733305-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.237]:25239 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750917AbWDKNnE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:43:04 -0400
Received: by wproxy.gmail.com with SMTP id i12so1030488wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:43:04 -0700 (PDT)
In-Reply-To: <11447629733305-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

New EH is responsible for filling qc->tf with status and filling sense
data for ATAPI check sense.  Update SCSI command completion path to
reflect this.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-scsi.c |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

394065e67293178b8ed4766800e655f9cc8ec33e
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index c9c0014..1c1b510 100644
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


