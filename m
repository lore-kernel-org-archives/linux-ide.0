From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/13] libata: use special reserved tag and qc for internal commands
Date: Mon, 3 Apr 2006 03:31:09 +0900
Message-ID: <1144002669360-git-send-email-htejun@gmail.com>
References: <1144002668278-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.203]:25247 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750892AbWDBSbO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 14:31:14 -0400
Received: by zproxy.gmail.com with SMTP id o37so1550555nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 11:31:14 -0700 (PDT)
In-Reply-To: <1144002668278-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

New EH may issue internal commands to recover from error while failed
qc's are still hanging around.  To allow such usage, reserve tag
ATA_MAX_QUEUE-1 for internal command.  This also makes it easy to tell
whether a qc is for internal command or not.  ata_tag_internal() test
implements this test.

To avoid breaking existing drivers, ata_exec_internal() uses
ATA_TAG_INTERNAL only for drivers which implement ->error_handler.
For drivers on old EH, tag 0 is used as before.  Note that this makes
ata_tag_internal() test valid only when ->error_handler is
implemented.  This is okay as drivers on old EH should not and does
not have any reason to use ata_tag_internal().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   32 +++++++++++++++++++++++++++++---
 include/linux/libata.h     |    9 ++++++++-
 2 files changed, 37 insertions(+), 4 deletions(-)

80ff3bcf9ab141553bfc5adbf2783c8e4cdf6375
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 966be30..446ab53 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -981,15 +981,39 @@ unsigned ata_exec_internal(struct ata_po
 {
 	u8 command = tf->command;
 	struct ata_queued_cmd *qc;
+	unsigned int tag, preempted_tag;
 	DECLARE_COMPLETION(wait);
 	unsigned long flags;
 	unsigned int err_mask;
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 
-	qc = ata_qc_new_init(ap, dev);
-	BUG_ON(qc == NULL);
+	/* initialize internal qc */
 
+	/* XXX: Tag 0 is used for drivers with legacy EH as some
+	 * drivers choke if any other tag is given.  This breaks
+	 * ata_tag_internal() test for those drivers.  Don't use new
+	 * EH stuff without converting to it.
+	 */
+	if (ap->ops->error_handler)
+		tag = ATA_TAG_INTERNAL;
+	else
+		tag = 0;
+
+	if (test_and_set_bit(tag, &ap->qactive))
+		BUG();
+	qc = ata_qc_from_tag(ap, tag);
+
+	qc->tag = tag;
+	qc->scsicmd = NULL;
+	qc->ap = ap;
+	qc->dev = dev;
+	ata_qc_reinit(qc);
+
+	preempted_tag = ap->active_tag;
+	ap->active_tag = ATA_TAG_POISON;
+
+	/* prepare & issue qc */
 	qc->tf = *tf;
 	if (cdb)
 		memcpy(qc->cdb, cdb, ATAPI_CDB_LEN);
@@ -1031,6 +1055,7 @@ unsigned ata_exec_internal(struct ata_po
 	err_mask = qc->err_mask;
 
 	ata_qc_free(qc);
+	ap->active_tag = preempted_tag;
 
 	/* XXX - Some LLDDs (sata_mv) disable port on command failure.
 	 * Until those drivers are fixed, we detect the condition
@@ -4027,7 +4052,8 @@ static struct ata_queued_cmd *ata_qc_new
 	struct ata_queued_cmd *qc = NULL;
 	unsigned int i;
 
-	for (i = 0; i < ATA_MAX_QUEUE; i++)
+	/* the last tag is reserved for internal command. */
+	for (i = 0; i < ATA_MAX_QUEUE - 1; i++)
 		if (!test_and_set_bit(i, &ap->qactive)) {
 			qc = ata_qc_from_tag(ap, i);
 			break;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0858788..ccd8846 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -108,7 +108,9 @@ enum {
 	LIBATA_MAX_PRD		= ATA_MAX_PRD / 2,
 	ATA_MAX_PORTS		= 8,
 	ATA_DEF_QUEUE		= 1,
-	ATA_MAX_QUEUE		= 1,
+	/* tag ATA_MAX_QUEUE - 1 is reserved for internal commands */
+	ATA_MAX_QUEUE		= 2,
+	ATA_TAG_INTERNAL	= ATA_MAX_QUEUE - 1,
 	ATA_MAX_SECTORS		= 200,	/* FIXME */
 	ATA_MAX_BUS		= 2,
 	ATA_DEF_BUSY_WAIT	= 10000,
@@ -696,6 +698,11 @@ static inline unsigned int ata_tag_valid
 	return (tag < ATA_MAX_QUEUE) ? 1 : 0;
 }
 
+static inline unsigned int ata_tag_internal(unsigned int tag)
+{
+	return tag == ATA_MAX_QUEUE - 1;
+}
+
 static inline unsigned int ata_class_enabled(unsigned int class)
 {
 	return class == ATA_DEV_ATA || class == ATA_DEV_ATAPI;
-- 
1.2.4


