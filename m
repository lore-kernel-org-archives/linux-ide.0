From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/14] libata: implement ap->sactive
Date: Mon, 3 Apr 2006 17:32:39 +0900
Message-ID: <11440531591231-git-send-email-htejun@gmail.com>
References: <1144053158183-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.233]:59876 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751611AbWDCIct (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Apr 2006 04:32:49 -0400
Received: by wproxy.gmail.com with SMTP id i22so1247733wra
        for <linux-ide@vger.kernel.org>; Mon, 03 Apr 2006 01:32:49 -0700 (PDT)
In-Reply-To: <1144053158183-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, axboe@suse.de, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement ap->sactive.  This is libata's view of SActive register.
This will be used to track NCQ commands and complete them.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   22 +++++++++++++++++++++-
 include/linux/libata.h     |    1 +
 2 files changed, 22 insertions(+), 1 deletions(-)

60995c11803d5d1844b6998ae373ba2d8d01be6d
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 5491afb..b4eeb4b 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -982,6 +982,7 @@ unsigned ata_exec_internal(struct ata_po
 	u8 command = tf->command;
 	struct ata_queued_cmd *qc;
 	unsigned int tag, preempted_tag;
+	u32 preempted_sactive;
 	DECLARE_COMPLETION(wait);
 	unsigned long flags;
 	unsigned int err_mask;
@@ -1017,7 +1018,9 @@ unsigned ata_exec_internal(struct ata_po
 	ata_qc_reinit(qc);
 
 	preempted_tag = ap->active_tag;
+	preempted_sactive = ap->sactive;
 	ap->active_tag = ATA_TAG_POISON;
+	ap->sactive = 0;
 
 	/* prepare & issue qc */
 	qc->tf = *tf;
@@ -1069,6 +1072,7 @@ unsigned ata_exec_internal(struct ata_po
 
 	ata_qc_free(qc);
 	ap->active_tag = preempted_tag;
+	ap->sactive = preempted_sactive;
 
 	/* XXX - Some LLDDs (sata_mv) disable port on command failure.
 	 * Until those drivers are fixed, we detect the condition
@@ -4197,6 +4201,12 @@ void __ata_qc_complete(struct ata_queued
 	if (likely(qc->flags & ATA_QCFLAG_DMAMAP))
 		ata_sg_clean(qc);
 
+	/* sactive bit must be turned atomically w.r.t. command
+	 * completion, so it cannot be turned off in ata_qc_free().
+	 */
+	if (qc->tf.protocol == ATA_PROT_NCQ)
+		qc->ap->sactive &= ~(1 << qc->tag);
+
 	/* atapi: mark qc as inactive to prevent the interrupt handler
 	 * from completing the command twice later, before the error handler
 	 * is called. (when rc != 0 and atapi request sense is needed)
@@ -4296,7 +4306,17 @@ void ata_qc_issue(struct ata_queued_cmd 
 {
 	struct ata_port *ap = qc->ap;
 
-	qc->ap->active_tag = qc->tag;
+	/* old EH reuses active qc to request ATAPI sense */
+	WARN_ON(ap->ops->error_handler && ata_tag_valid(ap->active_tag));
+
+	if (qc->tf.protocol == ATA_PROT_NCQ) {
+		WARN_ON(ap->sactive & (1 << qc->tag));
+		ap->sactive |= 1 << qc->tag;
+	} else {
+		WARN_ON(ap->sactive);
+		ap->active_tag = qc->tag;
+	}
+
 	qc->flags |= ATA_QCFLAG_ACTIVE;
 
 	if (ata_should_dma_map(qc)) {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c3a3cc0..7175191 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -450,6 +450,7 @@ struct ata_port {
 	struct ata_queued_cmd	qcmd[ATA_MAX_QUEUE];
 	unsigned long		qactive;
 	unsigned int		active_tag;
+	u32			sactive;
 
 	struct ata_host_stats	stats;
 	struct ata_host_set	*host_set;
-- 
1.2.4


