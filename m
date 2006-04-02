From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/13] libata: update ata_qc_from_tag() to enforce normal/EH qc ownership
Date: Mon, 3 Apr 2006 03:31:09 +0900
Message-ID: <11440026691550-git-send-email-htejun@gmail.com>
References: <1144002668278-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.203]:25247 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751435AbWDBSbV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 14:31:21 -0400
Received: by zproxy.gmail.com with SMTP id o37so1550555nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 11:31:21 -0700 (PDT)
In-Reply-To: <1144002668278-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

New EH framework has clear distinction about who owns a qc.  Every qc
starts owned by normal execution path - PIO, interrupt or whatever.
When an exception condition occurs which affects the qc, the qc gets
scheduled for EH.  Note that some events (say, link lost and regained,
command timeout) may schedule qc's which are not directly related but
could have been affected for EH too.  Scheduling for EH is atomic
w.r.t. ap->host_set->lock and once schedule for EH, normal execution
path is not allowed to access the qc in whatever way.  (PIO
synchronization acts a bit different and will be dealt with later)

This patch make ata_qc_from_tag() check whether a qc is active and
owned by normal path before returning it.  If conditions don't match,
NULL is returned and thus access to the qc is denied.
__ata_qc_from_tag() is the original ata_qc_from_tag() and is used by
libata core/EH layers to access inactive/failed qc's.

This change is applied only if the associated LLDD implements new EH
as indicated by non-NULL ->error_handler

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    4 ++--
 include/linux/libata.h     |   19 +++++++++++++++++--
 2 files changed, 19 insertions(+), 4 deletions(-)

828c4140b9a119c9defbe332ca887e0e1df17e57
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 69a069f..884f771 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1008,7 +1008,7 @@ unsigned ata_exec_internal(struct ata_po
 
 	if (test_and_set_bit(tag, &ap->qactive))
 		BUG();
-	qc = ata_qc_from_tag(ap, tag);
+	qc = __ata_qc_from_tag(ap, tag);
 
 	qc->tag = tag;
 	qc->scsicmd = NULL;
@@ -4104,7 +4104,7 @@ static struct ata_queued_cmd *ata_qc_new
 	/* the last tag is reserved for internal command. */
 	for (i = 0; i < ATA_MAX_QUEUE - 1; i++)
 		if (!test_and_set_bit(i, &ap->qactive)) {
-			qc = ata_qc_from_tag(ap, i);
+			qc = __ata_qc_from_tag(ap, i);
 			break;
 		}
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index ccd8846..289ec2e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -811,14 +811,29 @@ static inline void ata_qc_set_polling(st
 	qc->tf.ctl |= ATA_NIEN;
 }
 
-static inline struct ata_queued_cmd *ata_qc_from_tag (struct ata_port *ap,
-						      unsigned int tag)
+static inline struct ata_queued_cmd *__ata_qc_from_tag(struct ata_port *ap,
+						       unsigned int tag)
 {
 	if (likely(ata_tag_valid(tag)))
 		return &ap->qcmd[tag];
 	return NULL;
 }
 
+static inline struct ata_queued_cmd *ata_qc_from_tag(struct ata_port *ap,
+						     unsigned int tag)
+{
+	struct ata_queued_cmd *qc = __ata_qc_from_tag(ap, tag);
+
+	if (unlikely(!qc) || !ap->ops->error_handler)
+		return qc;
+
+	if ((qc->flags & (ATA_QCFLAG_ACTIVE |
+			  ATA_QCFLAG_EH_SCHEDULED)) == ATA_QCFLAG_ACTIVE)
+		return qc;
+
+	return NULL;
+}
+
 static inline void ata_tf_init(struct ata_port *ap, struct ata_taskfile *tf, unsigned int device)
 {
 	memset(tf, 0, sizeof(*tf));
-- 
1.2.4


