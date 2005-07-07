From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:ncq 04/11] libata: implement ap->sactive
Date: Thu,  7 Jul 2005 22:09:33 +0900 (KST)
Message-ID: <20050707130840.32B35551@htj.dyndns.org>
References: <20050707130840.5046338C@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.201]:32612 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261470AbVGGNJk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jul 2005 09:09:40 -0400
Received: by wproxy.gmail.com with SMTP id i28so191209wra
        for <linux-ide@vger.kernel.org>; Thu, 07 Jul 2005 06:09:37 -0700 (PDT)
In-Reply-To: <20050707130840.5046338C@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, axboe@suse.de, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

04_libata_implement-sactive.patch

	This patch implements generic ap->sactive handling for NCQ
	commands.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/scsi/libata-core.c |   37 ++++++++++++++++++++++++-------------
 drivers/scsi/libata-scsi.c |    6 +++---
 include/linux/libata.h     |    5 ++---
 3 files changed, 29 insertions(+), 19 deletions(-)

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-07-07 22:08:35.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-07-07 22:08:36.000000000 +0900
@@ -3140,14 +3140,20 @@ void ata_qc_free(struct ata_queued_cmd *
 	assert(ata_tag_valid(qc->tag));
 
 	if (likely(qc->flags & ATA_QCFLAG_ACTIVE)) {
-		assert(ap->queue_depth);
-		ap->queue_depth--;
+		assert(ap->flags & ATA_FLAG_INFLIGHT);
 
-		if (!ap->queue_depth)
-			ap->flags &= ~ATA_FLAG_NCQ_QUEUED;
-		if (tag == ap->active_tag) {
+		if (ap->active_tag == ATA_TAG_POISON) {
+			assert(ap->sactive & (1 << tag));
+			ap->sactive &= ~(1 << tag);
+			if (!ap->sactive)
+				ap->flags &= ~ATA_FLAG_INFLIGHT;
+		} else {
+			assert(ap->active_tag == tag &&
+			       (qc->flags & ATA_QCFLAG_PREEMPT || !ap->sactive));
 			ap->active_tag = ap->preempted_tag;
 			ap->preempted_tag = ATA_TAG_POISON;
+			if (ap->active_tag == ATA_TAG_POISON && !ap->sactive)
+				ap->flags &= ~ATA_FLAG_INFLIGHT;
 		}
 	}
 
@@ -3304,7 +3310,7 @@ static inline int ata_qc_issue_ok(struct
 	/*
 	 * If nothing is queued, it's always ok to continue.
 	 */
-	if (!ap->queue_depth)
+	if (!(ap->flags & ATA_FLAG_INFLIGHT))
 		return 1;
 
 	/*
@@ -3318,7 +3324,7 @@ static inline int ata_qc_issue_ok(struct
 	 * Command is NCQ, allow it to be queued if the commands that are
 	 * currently running are also NCQ
 	 */
-	if (ap->flags & ATA_FLAG_NCQ_QUEUED)
+	if (ap->sactive)
 		return 1;
 
 	return 0;
@@ -3396,20 +3402,25 @@ int ata_qc_issue(struct ata_queued_cmd *
 
 	ap->ops->qc_prep(qc);
 
-	qc->ap->active_tag = qc->tag;
 	qc->flags |= ATA_QCFLAG_ACTIVE;
 
 	assert(ap->preempted_tag == ATA_TAG_POISON);
 
-	if (qc->flags & ATA_QCFLAG_PREEMPT) {
+	if (!(qc->flags & ATA_QCFLAG_PREEMPT)) {
+		assert(ap->active_tag == ATA_TAG_POISON);
+
+		if (qc->flags & ATA_QCFLAG_NCQ)
+			ap->sactive |= 1 << qc->tag;
+		else {
+			assert(!ap->sactive);
+			ap->active_tag = qc->tag;
+		}
+	} else {
 		ap->preempted_tag = ap->active_tag;
 		ap->active_tag = qc->tag;
 	}
 
-	if (qc->flags & ATA_QCFLAG_NCQ)
-		ap->flags |= ATA_FLAG_NCQ_QUEUED;
-
-	ap->queue_depth++;
+	ap->flags |= ATA_FLAG_INFLIGHT;
 
 	rc = ap->ops->qc_issue(qc);
 	if (rc != ATA_QC_ISSUE_OK)
Index: work/drivers/scsi/libata-scsi.c
===================================================================
--- work.orig/drivers/scsi/libata-scsi.c	2005-07-07 22:08:35.000000000 +0900
+++ work/drivers/scsi/libata-scsi.c	2005-07-07 22:08:36.000000000 +0900
@@ -164,10 +164,10 @@ struct ata_queued_cmd *ata_scsi_qc_new(s
 		return NULL;
 	if (ap->cmd_waiters)
 		return NULL;
-	if (ap->queue_depth) {
+	if (ap->flags & ATA_FLAG_INFLIGHT) {
 		if (!scsi_rw_ncq_request(dev, cmd))
 			return NULL;
-		if (!(ap->flags & ATA_FLAG_NCQ_QUEUED))
+		if (!ap->sactive)
 			return NULL;
 	}
 
@@ -517,7 +517,7 @@ int ata_scsi_error(struct Scsi_Host *hos
 		ap->ops->error_handler(ap);
 
 	spin_lock_irq(&ap->host_set->lock);
-	assert(!ap->queue_depth && !ap->host->host_busy);
+	assert(!(ap->flags & ATA_FLAG_INFLIGHT) && !ap->host->host_busy);
 	host->host_failed = 0;
 	ap->flags &= ~(ATA_FLAG_ERROR | ATA_FLAG_RECOVERY);
 	if (ap->cmd_waiters)
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h	2005-07-07 22:08:35.000000000 +0900
+++ work/include/linux/libata.h	2005-07-07 22:08:36.000000000 +0900
@@ -116,7 +116,7 @@ enum {
 	ATA_FLAG_SATA_RESET	= (1 << 7), /* use COMRESET */
 	ATA_FLAG_PIO_DMA	= (1 << 8), /* PIO cmds via DMA */
 	ATA_FLAG_NCQ		= (1 << 9), /* Can do NCQ */
-	ATA_FLAG_NCQ_QUEUED	= (1 << 10), /* NCQ commands are queued */
+	ATA_FLAG_INFLIGHT	= (1 << 10), /* Command(s) in flight */
 	ATA_FLAG_ERROR		= (1 << 11), /* Error met and EH scheduled */
 	ATA_FLAG_RECOVERY	= (1 << 12), /* Recovery in progress */
 
@@ -323,9 +323,8 @@ struct ata_port {
 	struct ata_device	device[ATA_MAX_DEVICES];
 
 	struct ata_queued_cmd	qcmd[ATA_MAX_CMDS];
-	unsigned long		qactive;
+	unsigned long		qactive, sactive;
 	unsigned int		active_tag, preempted_tag;
-	unsigned int		queue_depth;
 
 	wait_queue_head_t	cmd_wait_queue;
 	unsigned int		cmd_waiters;

