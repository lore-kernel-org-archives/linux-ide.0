From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 13/13] libata-hp: move ata_do_reset() to libata-eh.c
Date: Mon, 29 May 2006 15:38:56 +0900
Message-ID: <11488847363944-git-send-email-htejun@gmail.com>
References: <11488847352050-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.196]:272 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751315AbWE2GjU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 02:39:20 -0400
Received: by wx-out-0102.google.com with SMTP id h27so299180wxd
        for <linux-ide@vger.kernel.org>; Sun, 28 May 2006 23:39:20 -0700 (PDT)
In-Reply-To: <11488847352050-git-send-email-htejun@gmail.com>
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

854a6e658abac125cb2dbe8d081448d9a76c166a
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index c1a10ac..2274468 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2778,34 +2778,6 @@ void ata_std_postreset(struct ata_port *
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
index 9eb73bb..26bd83d 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1316,6 +1316,34 @@ static void ata_eh_report(struct ata_por
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
index 2d8cc05..2320b4d 100644
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


