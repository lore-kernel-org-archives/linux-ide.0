From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/13] libata: fold __ata_qc_complete() into ata_qc_free()
Date: Mon, 23 Jan 2006 13:09:36 +0900
Message-ID: <11379893763218-git-send-email-htejun@gmail.com>
References: <11379893762140-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.193]:12055 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751387AbWAWEJl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 23:09:41 -0500
Received: by wproxy.gmail.com with SMTP id i3so763645wra
        for <linux-ide@vger.kernel.org>; Sun, 22 Jan 2006 20:09:41 -0800 (PST)
In-Reply-To: <11379893762140-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: Tejun Heo <htejun@gmail.com>

All ata_qc_free() does is calling __ata_qc_complete() which isn't used
anywhere else.  Fold __ata_qc_complete() into ata_qc_free().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   30 ++++++++++++------------------
 1 files changed, 12 insertions(+), 18 deletions(-)

62789ae9af2f157a4eb4dfcdb3ab2425adb9cc86
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index a07bd35..0e49323 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -73,7 +73,6 @@ static int fgb(u32 bitmap);
 static int ata_choose_xfer_mode(const struct ata_port *ap,
 				u8 *xfer_mode_out,
 				unsigned int *xfer_shift_out);
-static void __ata_qc_complete(struct ata_queued_cmd *qc);
 
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
@@ -3593,21 +3592,6 @@ struct ata_queued_cmd *ata_qc_new_init(s
 	return qc;
 }
 
-static void __ata_qc_complete(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	unsigned int tag;
-
-	qc->flags = 0;
-	tag = qc->tag;
-	if (likely(ata_tag_valid(tag))) {
-		if (tag == ap->active_tag)
-			ap->active_tag = ATA_TAG_POISON;
-		qc->tag = ATA_TAG_POISON;
-		clear_bit(tag, &ap->qactive);
-	}
-}
-
 /**
  *	ata_qc_free - free unused ata_queued_cmd
  *	@qc: Command to complete
@@ -3620,9 +3604,19 @@ static void __ata_qc_complete(struct ata
  */
 void ata_qc_free(struct ata_queued_cmd *qc)
 {
+	struct ata_port *ap = qc->ap;
+	unsigned int tag;
+
 	assert(qc != NULL);	/* ata_qc_from_tag _might_ return NULL */
 
-	__ata_qc_complete(qc);
+	qc->flags = 0;
+	tag = qc->tag;
+	if (likely(ata_tag_valid(tag))) {
+		if (tag == ap->active_tag)
+			ap->active_tag = ATA_TAG_POISON;
+		qc->tag = ATA_TAG_POISON;
+		clear_bit(tag, &ap->qactive);
+	}
 }
 
 /**
@@ -3662,7 +3656,7 @@ void ata_qc_complete(struct ata_queued_c
 	if (rc != 0)
 		return;
 
-	__ata_qc_complete(qc);
+	ata_qc_free(qc);
 
 	VPRINTK("EXIT\n");
 }
-- 
1.0.8


