From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/16] libata-eh-fw: update ata_qc_from_tag() to enforce normal/EH qc ownership
Date: Tue, 11 Apr 2006 22:42:54 +0900
Message-ID: <1144762974987-git-send-email-htejun@gmail.com>
References: <11447629733305-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.227]:18071 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750900AbWDKNnA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:43:00 -0400
Received: by wproxy.gmail.com with SMTP id i11so925428wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:43:00 -0700 (PDT)
In-Reply-To: <11447629733305-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
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

efaa885fb5b63f1235ef0db268ed283074d7fd9b
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index e8566bb..f019d5d 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1011,7 +1011,7 @@ unsigned ata_exec_internal(struct ata_po
 
 	if (test_and_set_bit(tag, &ap->qactive))
 		BUG();
-	qc = ata_qc_from_tag(ap, tag);
+	qc = __ata_qc_from_tag(ap, tag);
 
 	qc->tag = tag;
 	qc->scsicmd = NULL;
@@ -4111,7 +4111,7 @@ static struct ata_queued_cmd *ata_qc_new
 	/* the last tag is reserved for internal command. */
 	for (i = 0; i < ATA_MAX_QUEUE - 1; i++)
 		if (!test_and_set_bit(i, &ap->qactive)) {
-			qc = ata_qc_from_tag(ap, i);
+			qc = __ata_qc_from_tag(ap, i);
 			break;
 		}
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e814f38..e059cd3 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -812,14 +812,29 @@ static inline void ata_qc_set_polling(st
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


