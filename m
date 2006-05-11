From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/22] libata: clear ap->active_tag atomically w.r.t. command completion
Date: Thu, 11 May 2006 20:59:50 +0900
Message-ID: <11473487901473-git-send-email-htejun@gmail.com>
References: <11473487893774-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.197]:3016 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751575AbWEKMAB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 08:00:01 -0400
Received: by nz-out-0102.google.com with SMTP id 13so170503nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 05:00:01 -0700 (PDT)
In-Reply-To: <11473487893774-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ap->active_tag was cleared in ata_qc_free().  This left ap->active_tag
dangling after ata_qc_complete().  Spurious interrupts inbetween could
incorrectly access the qc.  Clear active_tag in ata_qc_complete().
This change is necessary for later EH changes.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

7054ad3067bb27d6070a75f90afd14fafd3f5527
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 142a3a8..763dd66 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4083,8 +4083,6 @@ void ata_qc_free(struct ata_queued_cmd *
 	qc->flags = 0;
 	tag = qc->tag;
 	if (likely(ata_tag_valid(tag))) {
-		if (tag == ap->active_tag)
-			ap->active_tag = ATA_TAG_POISON;
 		qc->tag = ATA_TAG_POISON;
 		clear_bit(tag, &ap->qactive);
 	}
@@ -4098,6 +4096,9 @@ void __ata_qc_complete(struct ata_queued
 	if (likely(qc->flags & ATA_QCFLAG_DMAMAP))
 		ata_sg_clean(qc);
 
+	/* command should be marked inactive atomically with qc completion */
+	qc->ap->active_tag = ATA_TAG_POISON;
+
 	/* atapi: mark qc as inactive to prevent the interrupt handler
 	 * from completing the command twice later, before the error handler
 	 * is called. (when rc != 0 and atapi request sense is needed)
-- 
1.2.4


