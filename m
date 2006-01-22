From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/12] libata: fold __ata_qc_complete() into ata_qc_free()
Date: Sun, 22 Jan 2006 16:58:30 +0900
Message-ID: <11379167104074-git-send-email-htejun@gmail.com>
References: <11379167103055-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.195]:41654 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751207AbWAVH6f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 02:58:35 -0500
Received: by xproxy.gmail.com with SMTP id s14so513087wxc
        for <linux-ide@vger.kernel.org>; Sat, 21 Jan 2006 23:58:35 -0800 (PST)
In-Reply-To: <11379167103055-git-send-email-htejun@gmail.com>
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

7474f1f37d6bcfa451b24e9a6905b56a1bd45a29
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


