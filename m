From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/22] libata: remove postreset handling from ata_do_reset()
Date: Thu, 11 May 2006 20:59:51 +0900
Message-ID: <1147348791848-git-send-email-htejun@gmail.com>
References: <11473487893774-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:49594 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751587AbWEKMAB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 08:00:01 -0400
Received: by py-out-1112.google.com with SMTP id f28so211124pyf
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 05:00:01 -0700 (PDT)
In-Reply-To: <11473487893774-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make ata_do_reset() deal only with reset.  postreset is now the
responsibility of the caller.  This is simpler and eases later
prereset addition.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   19 ++++++++++---------
 drivers/scsi/libata.h      |    2 +-
 2 files changed, 11 insertions(+), 10 deletions(-)

1875f703363435b19f33166a74ef3081a1969967
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index ec40c79..464fd46 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2585,7 +2585,7 @@ int ata_std_probe_reset(struct ata_port 
 }
 
 int ata_do_reset(struct ata_port *ap, ata_reset_fn_t reset,
-		 ata_postreset_fn_t postreset, unsigned int *classes)
+		 unsigned int *classes)
 {
 	int i, rc;
 
@@ -2609,9 +2609,6 @@ int ata_do_reset(struct ata_port *ap, at
 			if (classes[i] == ATA_DEV_UNKNOWN)
 				classes[i] = ATA_DEV_NONE;
 
-	if (postreset)
-		postreset(ap, classes);
-
 	return 0;
 }
 
@@ -2655,7 +2652,7 @@ int ata_drive_probe_reset(struct ata_por
 		probeinit(ap);
 
 	if (softreset && !ata_set_sata_spd_needed(ap)) {
-		rc = ata_do_reset(ap, softreset, postreset, classes);
+		rc = ata_do_reset(ap, softreset, classes);
 		if (rc == 0 && classes[0] != ATA_DEV_UNKNOWN)
 			goto done;
 		printk(KERN_INFO "ata%u: softreset failed, will try "
@@ -2667,7 +2664,7 @@ int ata_drive_probe_reset(struct ata_por
 		goto done;
 
 	while (1) {
-		rc = ata_do_reset(ap, hardreset, postreset, classes);
+		rc = ata_do_reset(ap, hardreset, classes);
 		if (rc == 0) {
 			if (classes[0] != ATA_DEV_UNKNOWN)
 				goto done;
@@ -2688,12 +2685,16 @@ int ata_drive_probe_reset(struct ata_por
 		       ap->id);
 		ssleep(5);
 
-		rc = ata_do_reset(ap, softreset, postreset, classes);
+		rc = ata_do_reset(ap, softreset, classes);
 	}
 
  done:
-	if (rc == 0 && classes[0] == ATA_DEV_UNKNOWN)
-		rc = -ENODEV;
+	if (rc == 0) {
+		if (postreset)
+			postreset(ap, classes);
+		if (classes[0] == ATA_DEV_UNKNOWN)
+			rc = -ENODEV;
+	}
 	return rc;
 }
 
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index 3f8b0a8..43a56e5 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -57,7 +57,7 @@ extern int ata_down_xfermask_limit(struc
 				   int force_pio0);
 extern int ata_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev);
 extern int ata_do_reset(struct ata_port *ap, ata_reset_fn_t reset,
-			ata_postreset_fn_t postreset, unsigned int *classes);
+			unsigned int *classes);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern void ata_qc_issue(struct ata_queued_cmd *qc);
 extern int ata_check_atapi_dma(struct ata_queued_cmd *qc);
-- 
1.2.4


