From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/14] libata-hp-prep: make ops->tf_read() optional
Date: Fri, 12 May 2006 00:12:00 +0900
Message-ID: <11473603203529-git-send-email-htejun@gmail.com>
References: <1147360318920-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:54573 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751859AbWEKPMO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 11:12:14 -0400
Received: by wr-out-0506.google.com with SMTP id i12so387722wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 08:12:14 -0700 (PDT)
In-Reply-To: <1147360318920-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Not all controllers have single TF image and ops->tf_read() is
inappropriate for them.  Newly implemented hotplug probing will allow
drivers for such controllers to get rid of ops->tf_read() completely.
Make ops->tf_read() optional in core layer.

---

 drivers/scsi/libata-core.c |    8 +++++---
 drivers/scsi/libata-eh.c   |    3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

164a958101ccf3f82b1af1be7dd77d991cd88d65
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 636f044..6d86479 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4429,14 +4429,15 @@ void ata_qc_complete(struct ata_queued_c
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
@@ -4445,7 +4446,8 @@ void ata_qc_complete(struct ata_queued_c
 			return;
 
 		/* read result TF if failed or requested */
-		if (qc->err_mask || qc->flags & ATA_QCFLAG_RESULT_TF)
+		if (ap->ops->tf_read &&
+		    (qc->err_mask || qc->flags & ATA_QCFLAG_RESULT_TF))
 			ap->ops->tf_read(ap, &qc->result_tf);
 
 		__ata_qc_complete(qc);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index b6268b5..740934b 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -811,7 +811,8 @@ static unsigned int atapi_eh_request_sen
 	memset(sense_buf, 0, SCSI_SENSE_BUFFERSIZE);
 
 	/* XXX: why tf_read here? */
-	ap->ops->tf_read(ap, &tf);
+	if (ap->ops->tf_read)
+		ap->ops->tf_read(ap, &tf);
 
 	/* fill these in, for the case where they are -not- overwritten */
 	sense_buf[0] = 0x70;
-- 
1.2.4


