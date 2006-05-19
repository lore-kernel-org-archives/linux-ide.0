From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/14] libata-hp-prep: make ops->tf_read() optional
Date: Fri, 19 May 2006 06:16:38 -0700 (PDT)
Message-ID: <11480445844029-git-send-email-htejun@gmail.com>
References: <11480445833568-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.193]:49900 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932249AbWESNQj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 May 2006 09:16:39 -0400
Received: by nz-out-0102.google.com with SMTP id 8so626374nzo
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 06:16:38 -0700 (PDT)
In-Reply-To: <11480445833568-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Not all controllers have single TF image and ops->tf_read() is
inappropriate for them.  Newly implemented hotplug probing will allow
drivers for such controllers to get rid of ops->tf_read() completely.
Make ops->tf_read() optional in core layer.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    8 +++++---
 drivers/scsi/libata-eh.c   |    3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

b27b1cc97dad12a344d60a184e94dff40c4ed15b
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 8f18ced..9a4124e 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4428,14 +4428,15 @@ void ata_qc_complete(struct ata_queued_c
 		if (unlikely(qc->flags & ATA_QCFLAG_FAILED)) {
 			if (!ata_tag_internal(qc->tag)) {
 				/* always fill result TF for failed qc */
-				ap->ops->tf_read(ap, &qc->result_tf);
+				if (ap->ops->tf_read)
+					ap->ops->tf_read(ap, &qc->result_tf);
 				ata_qc_schedule_eh(qc);
 				return;
 			}
 		}
 
 		/* read result TF if requested */
-		if (qc->flags & ATA_QCFLAG_RESULT_TF)
+		if (ap->ops->tf_read && qc->flags & ATA_QCFLAG_RESULT_TF)
 			ap->ops->tf_read(ap, &qc->result_tf);
 
 		__ata_qc_complete(qc);
@@ -4444,7 +4445,8 @@ void ata_qc_complete(struct ata_queued_c
 			return;
 
 		/* read result TF if failed or requested */
-		if (qc->err_mask || qc->flags & ATA_QCFLAG_RESULT_TF)
+		if (ap->ops->tf_read &&
+		    (qc->err_mask || qc->flags & ATA_QCFLAG_RESULT_TF))
 			ap->ops->tf_read(ap, &qc->result_tf);
 
 		__ata_qc_complete(qc);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 71b45ad..7cbb311 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -806,7 +806,8 @@ static unsigned int atapi_eh_request_sen
 	memset(sense_buf, 0, SCSI_SENSE_BUFFERSIZE);
 
 	/* XXX: why tf_read here? */
-	ap->ops->tf_read(ap, &tf);
+	if (ap->ops->tf_read)
+		ap->ops->tf_read(ap, &tf);
 
 	/* fill these in, for the case where they are -not- overwritten */
 	sense_buf[0] = 0x70;
-- 
1.3.2

