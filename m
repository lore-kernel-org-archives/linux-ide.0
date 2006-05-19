From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 13/13] libata-hp: move ata_do_reset() to libata-eh.c
Date: Sat, 20 May 2006 00:48:28 +0900
Message-ID: <11480537082648-git-send-email-htejun@gmail.com>
References: <11480537063293-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.226]:42918 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932394AbWESPsk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 May 2006 11:48:40 -0400
Received: by wr-out-0506.google.com with SMTP id 50so180509wri
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 08:48:40 -0700 (PDT)
In-Reply-To: <11480537063293-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

With ops->probe_init() gone, no user is left in libata-core.c.  Move
ata_do_reset() to libata-eh.c and make it static.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   28 ----------------------------
 drivers/scsi/libata-eh.c   |   28 ++++++++++++++++++++++++++++
 drivers/scsi/libata.h      |    2 --
 3 files changed, 28 insertions(+), 30 deletions(-)

8e2c3e2ccff15e2d111a3b3f21acd9f864672b4e
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 6b9586c..350df1d 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2783,34 +2783,6 @@ void ata_std_postreset(struct ata_port *
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
index 4357465..b1ac851 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1317,6 +1317,34 @@ static void ata_eh_report(struct ata_por
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
index 0176c40..a954500 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -57,8 +57,6 @@ extern int sata_down_spd_limit(struct at
 extern int sata_set_spd_needed(struct ata_port *ap);
 extern int ata_down_xfermask_limit(struct ata_device *dev, int force_pio0);
 extern int ata_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev);
-extern int ata_do_reset(struct ata_port *ap, ata_reset_fn_t reset,
-			unsigned int *classes);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern void ata_qc_issue(struct ata_queued_cmd *qc);
 extern void __ata_qc_complete(struct ata_queued_cmd *qc);
-- 
1.3.2


