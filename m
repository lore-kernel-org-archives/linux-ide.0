From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH Linux 2.6.12 03/09] NCQ: add ap->sactive
Date: Mon, 27 Jun 2005 00:21:22 +0900 (KST)
Message-ID: <20050626152105.B19CB0C1@htj.dyndns.org>
References: <20050626152105.D86561FB@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:7024 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261312AbVFZPV1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jun 2005 11:21:27 -0400
Received: by zproxy.gmail.com with SMTP id f1so98812nzc
        for <linux-ide@vger.kernel.org>; Sun, 26 Jun 2005 08:21:27 -0700 (PDT)
In-Reply-To: <20050626152105.D86561FB@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, axboe@suse.de, linux-ide@vger.kernel.org

03_NCQ_implement-ap_sactive.patch

	This patch makes libata-core layer aware of ap->sactive
	status.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/scsi/ahci.c        |    2 +-
 drivers/scsi/libata-core.c |   32 ++++++++++++++++++++------------
 drivers/scsi/libata-scsi.c |    4 ++--
 include/linux/libata.h     |    5 ++---
 4 files changed, 25 insertions(+), 18 deletions(-)

Index: work/drivers/scsi/ahci.c
===================================================================
--- work.orig/drivers/scsi/ahci.c	2005-06-27 00:20:29.000000000 +0900
+++ work/drivers/scsi/ahci.c	2005-06-27 00:20:29.000000000 +0900
@@ -651,7 +651,7 @@ static void ahci_ncq_timeout(struct ata_
 	u32 sactive;
 	int reset;
 
-	printk(KERN_WARNING "ata%u: ncq interrupt error (Q=%d)\n", ap->id, ap->queue_depth);
+	printk(KERN_WARNING "ata%u: ncq interrupt error (Q=%08lx)\n", ap->id, ap->sactive);
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 
Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-06-27 00:20:29.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-06-27 00:20:29.000000000 +0900
@@ -3143,13 +3143,17 @@ static void __ata_qc_complete(struct ata
 	unsigned int tag = ata_qc_to_tag(qc);
 
 	if (likely(qc->flags & ATA_QCFLAG_ACTIVE)) {
-		assert(ap->queue_depth);
-		ap->queue_depth--;
-
-		if (!ap->queue_depth)
-			ap->flags &= ~ATA_FLAG_NCQ_QUEUED;
-		if (tag == ap->active_tag)
+		assert(ap->flags & ATA_FLAG_INFLIGHT);
+		if (ap->active_tag == ATA_TAG_POISON) {
+			assert(ap->sactive & (1 << tag));
+			ap->sactive &= ~(1 << tag);
+			if (!ap->sactive)
+				ap->flags &= ~ATA_FLAG_INFLIGHT;
+		} else {
+			assert(ap->active_tag == tag);
 			ap->active_tag = ATA_TAG_POISON;
+			ap->flags &= ~ATA_FLAG_INFLIGHT;
+		}
 	}
 
 	qc->flags = 0;
@@ -3285,7 +3289,7 @@ static inline int ata_qc_issue_ok(struct
 	/*
 	 * If nothing is queued, it's always ok to continue.
 	 */
-	if (!ap->queue_depth)
+	if (!(ap->flags & ATA_FLAG_INFLIGHT))
 		return 1;
 
 	/*
@@ -3299,7 +3303,7 @@ static inline int ata_qc_issue_ok(struct
 	 * Command is NCQ, allow it to be queued if the commands that are
 	 * currently running are also NCQ
 	 */
-	if (ap->flags & ATA_FLAG_NCQ_QUEUED)
+	if (ap->sactive)
 		return 1;
 
 	return 0;
@@ -3377,13 +3381,17 @@ int ata_qc_issue(struct ata_queued_cmd *
 
 	ap->ops->qc_prep(qc);
 
-	qc->ap->active_tag = ata_qc_to_tag(qc);
 	qc->flags |= ATA_QCFLAG_ACTIVE;
 
-	if (qc->flags & ATA_QCFLAG_NCQ)
-		ap->flags |= ATA_FLAG_NCQ_QUEUED;
+	if (qc->flags & ATA_QCFLAG_NCQ) {
+		assert(ap->active_tag == ATA_TAG_POISON);
+		ap->sactive |= 1 << ata_qc_to_tag(qc);
+	} else {
+		assert(!ap->sactive || qc->flags & ATA_QCFLAG_PREEMPT);
+		ap->active_tag = ata_qc_to_tag(qc);
+	}
 
-	ap->queue_depth++;
+	ap->flags |= ATA_FLAG_INFLIGHT;
 
 	rc = ap->ops->qc_issue(qc);
 	if (rc != ATA_QC_ISSUE_OK)
Index: work/drivers/scsi/libata-scsi.c
===================================================================
--- work.orig/drivers/scsi/libata-scsi.c	2005-06-27 00:20:29.000000000 +0900
+++ work/drivers/scsi/libata-scsi.c	2005-06-27 00:20:29.000000000 +0900
@@ -162,10 +162,10 @@ struct ata_queued_cmd *ata_scsi_qc_new(s
 	 */
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
 
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h	2005-06-27 00:20:29.000000000 +0900
+++ work/include/linux/libata.h	2005-06-27 00:20:29.000000000 +0900
@@ -117,7 +117,7 @@ enum {
 	ATA_FLAG_SATA_RESET	= (1 << 7), /* use COMRESET */
 	ATA_FLAG_PIO_DMA	= (1 << 8), /* PIO cmds via DMA */
 	ATA_FLAG_NCQ		= (1 << 9), /* Can do NCQ */
-	ATA_FLAG_NCQ_QUEUED	= (1 << 10), /* NCQ commands are queued */
+	ATA_FLAG_INFLIGHT	= (1 << 10), /* Command(s) in flight */
 
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
@@ -315,9 +315,8 @@ struct ata_port {
 	struct ata_device	device[ATA_MAX_DEVICES];
 
 	struct ata_queued_cmd	qcmd[ATA_MAX_CMDS];
-	unsigned long		qactive;
+	unsigned long		qactive, sactive;
 	unsigned int		active_tag;
-	unsigned int		queue_depth;
 
 	wait_queue_head_t	cmd_wait_queue;
 	unsigned int		cmd_waiters;

