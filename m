From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 13/13] libata-hp: move ata_do_reset() to libata-eh.c
Date: Fri, 12 May 2006 00:32:08 +0900
Message-ID: <11473615282117-git-send-email-htejun@gmail.com>
References: <11473615261297-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.234]:10565 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030265AbWEKPcU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 11:32:20 -0400
Received: by wr-out-0506.google.com with SMTP id i12so392288wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 08:32:19 -0700 (PDT)
In-Reply-To: <11473615261297-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

With ops->probe_init() gone, no user is left in libata-core.c.  Move
ata_do_reset() to libata-eh.c and make it static.

---

 drivers/scsi/libata-core.c |   28 ----------------------------
 drivers/scsi/libata-eh.c   |   28 ++++++++++++++++++++++++++++
 drivers/scsi/libata.h      |    2 --
 3 files changed, 28 insertions(+), 30 deletions(-)

9b268696e656ec9b14ff744801889c6b7f2a06e1
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index e1f17c3..defc6c9 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2747,34 +2747,6 @@ void ata_std_postreset(struct ata_port *
 	DPRINTK("EXIT\n");
 }
 
-int ata_do_reset(struct ata_port *ap, ata_reset_fn_t reset,
-		 unsigned int *classes)
-{
-	int i, rc;
-
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		classes[i] = ATA_DEV_UNKNOWN;
-
-	rc = reset(ap, classes);
-	if (rc)
-		return rc;
-
-	/* If any class isn't ATA_DEV_UNKNOWN, consider classification
-	 * is complete and convert all ATA_DEV_UNKNOWN to
-	 * ATA_DEV_NONE.
-	 */
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		if (classes[i] != ATA_DEV_UNKNOWN)
-			break;
-
-	if (i < ATA_MAX_DEVICES)
-		for (i = 0; i < ATA_MAX_DEVICES; i++)
-			if (classes[i] == ATA_DEV_UNKNOWN)
-				classes[i] = ATA_DEV_NONE;
-
-	return 0;
-}
-
 /**
  *	ata_dev_same_device - Determine whether new ID matches configured device
  *	@dev: device to compare against
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 629b855..88f8bc7 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1323,6 +1323,34 @@ static void ata_eh_report(struct ata_por
 	}
 }
 
+static int ata_do_reset(struct ata_port *ap, ata_reset_fn_t reset,
+			unsigned int *classes)
+{
+	int i, rc;
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		classes[i] = ATA_DEV_UNKNOWN;
+
+	rc = reset(ap, classes);
+	if (rc)
+		return rc;
+
+	/* If any class isn't ATA_DEV_UNKNOWN, consider classification
+	 * is complete and convert all ATA_DEV_UNKNOWN to
+	 * ATA_DEV_NONE.
+	 */
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		if (classes[i] != ATA_DEV_UNKNOWN)
+			break;
+
+	if (i < ATA_MAX_DEVICES)
+		for (i = 0; i < ATA_MAX_DEVICES; i++)
+			if (classes[i] == ATA_DEV_UNKNOWN)
+				classes[i] = ATA_DEV_NONE;
+
+	return 0;
+}
+
 static int ata_eh_followup_srst_needed(int rc, int classify,
 				       const unsigned int *classes)
 {
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index 5088ad2..aee6552 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -57,8 +57,6 @@ extern int ata_down_sata_spd_limit(struc
 extern int ata_set_sata_spd_needed(struct ata_port *ap);
 extern int ata_down_xfermask_limit(struct ata_device *dev, int force_pio0);
 extern int ata_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev);
-extern int ata_do_reset(struct ata_port *ap, ata_reset_fn_t reset,
-			unsigned int *classes);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern void ata_qc_issue(struct ata_queued_cmd *qc);
 extern void __ata_qc_complete(struct ata_queued_cmd *qc);
-- 
1.2.4


