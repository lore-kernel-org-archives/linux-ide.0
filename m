From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/15] libata-ncq: implement ap->sactive
Date: Tue, 11 Apr 2006 22:53:36 +0900
Message-ID: <11447636163810-git-send-email-htejun@gmail.com>
References: <1144763616819-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.177]:43136 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750971AbWDKNxj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:53:39 -0400
Received: by pproxy.gmail.com with SMTP id i49so1388582pye
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:53:39 -0700 (PDT)
In-Reply-To: <1144763616819-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement ap->sactive.  This is libata's view of SActive register.
This will be used to track NCQ commands and complete them.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   22 +++++++++++++++++++++-
 include/linux/libata.h     |    1 +
 2 files changed, 22 insertions(+), 1 deletions(-)

29972b1500568aeb7a6dbb681192af3e90d988be
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index ac79c5c..7dc668c 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -985,6 +985,7 @@ unsigned ata_exec_internal(struct ata_po
 	u8 command = tf->command;
 	struct ata_queued_cmd *qc;
 	unsigned int tag, preempted_tag;
+	u32 preempted_sactive;
 	DECLARE_COMPLETION(wait);
 	unsigned long flags;
 	unsigned int err_mask;
@@ -1020,7 +1021,9 @@ unsigned ata_exec_internal(struct ata_po
 	ata_qc_reinit(qc);
 
 	preempted_tag = ap->active_tag;
+	preempted_sactive = ap->sactive;
 	ap->active_tag = ATA_TAG_POISON;
+	ap->sactive = 0;
 
 	/* prepare & issue qc */
 	qc->tf = *tf;
@@ -1082,6 +1085,7 @@ unsigned ata_exec_internal(struct ata_po
 
 	ata_qc_free(qc);
 	ap->active_tag = preempted_tag;
+	ap->sactive = preempted_sactive;
 
 	/* XXX - Some LLDDs (sata_mv) disable port on command failure.
 	 * Until those drivers are fixed, we detect the condition
@@ -4212,6 +4216,12 @@ void __ata_qc_complete(struct ata_queued
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
@@ -4311,7 +4321,17 @@ void ata_qc_issue(struct ata_queued_cmd 
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
index c9dfc7d..b194f3f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -452,6 +452,7 @@ struct ata_port {
 	struct ata_queued_cmd	qcmd[ATA_MAX_QUEUE];
 	unsigned long		qactive;
 	unsigned int		active_tag;
+	u32			sactive;
 
 	struct ata_host_stats	stats;
 	struct ata_host_set	*host_set;
-- 
1.2.4


