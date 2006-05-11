From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/12] libata-ncq: rename ap->qactive to ap->qc_allocated
Date: Thu, 11 May 2006 23:44:43 +0900
Message-ID: <1147358683707-git-send-email-htejun@gmail.com>
References: <1147358682210-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.194]:61795 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751800AbWEKOos (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 10:44:48 -0400
Received: by nz-out-0102.google.com with SMTP id 13so216442nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 07:44:48 -0700 (PDT)
In-Reply-To: <1147358682210-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Rename ap->qactive to ap->qc_allocated.  This is to accomodate
addition of ap->qc_active, mask of active qcs.

---

 drivers/scsi/libata-core.c |    6 +++---
 include/linux/libata.h     |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

657b87491833e0c1be9a48536cf09a878b671451
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 6d28722..bafc460 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1006,7 +1006,7 @@ unsigned ata_exec_internal(struct ata_de
 	else
 		tag = 0;
 
-	if (test_and_set_bit(tag, &ap->qactive))
+	if (test_and_set_bit(tag, &ap->qc_allocated))
 		BUG();
 	qc = __ata_qc_from_tag(ap, tag);
 
@@ -4206,7 +4206,7 @@ static struct ata_queued_cmd *ata_qc_new
 
 	/* the last tag is reserved for internal command. */
 	for (i = 0; i < ATA_MAX_QUEUE - 1; i++)
-		if (!test_and_set_bit(i, &ap->qactive)) {
+		if (!test_and_set_bit(i, &ap->qc_allocated)) {
 			qc = __ata_qc_from_tag(ap, i);
 			break;
 		}
@@ -4263,7 +4263,7 @@ void ata_qc_free(struct ata_queued_cmd *
 	tag = qc->tag;
 	if (likely(ata_tag_valid(tag))) {
 		qc->tag = ATA_TAG_POISON;
-		clear_bit(tag, &ap->qactive);
+		clear_bit(tag, &ap->qc_allocated);
 	}
 }
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c9d20d4..ffb57fc 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -477,7 +477,7 @@ struct ata_port {
 	struct ata_device	device[ATA_MAX_DEVICES];
 
 	struct ata_queued_cmd	qcmd[ATA_MAX_QUEUE];
-	unsigned long		qactive;
+	unsigned long		qc_allocated;
 	unsigned int		active_tag;
 
 	struct ata_host_stats	stats;
-- 
1.2.4


