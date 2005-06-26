From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata-dev-2.6-ncq: rewrite __ata_qc_complete
Date: Sun, 26 Jun 2005 23:41:10 +0900
Message-ID: <20050626144110.GD24968@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.199]:18725 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261282AbVFZOlP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jun 2005 10:41:15 -0400
Received: by zproxy.gmail.com with SMTP id f1so96814nzc
        for <linux-ide@vger.kernel.org>; Sun, 26 Jun 2005 07:41:15 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, axboe@suse.de, linux-ide@vger.kernel.org

 Hello, Jeff.
 Hello, Jens.

 This is the fource, no, fourth (dang, that starwars) of six misc
updates to ncq.

 This patch rewrites __ata_qc_complete() to make it look more sane.
Also, remove spurious clearing of ATA_QCFLAG_ACTIVE from
ata_qc_complete().

 Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-06-26 21:20:43.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-06-26 21:20:47.000000000 +0900
@@ -3069,7 +3069,8 @@ static int ata_qc_complete_noop(struct a
 static void __ata_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	unsigned int tag, do_clear = 0;
+	struct completion *waiting = qc->waiting;
+	unsigned int tag = ata_qc_to_tag(qc);
 
 	if (likely(qc->flags & ATA_QCFLAG_ACTIVE)) {
 		assert(ap->queue_depth);
@@ -3077,26 +3078,19 @@ static void __ata_qc_complete(struct ata
 
 		if (!ap->queue_depth)
 			ap->flags &= ~ATA_FLAG_NCQ_QUEUED;
-	}
-
-	qc->flags = 0;
-	tag = ata_qc_to_tag(qc);
-	if (likely(ata_tag_valid(tag))) {
 		if (tag == ap->active_tag)
 			ap->active_tag = ATA_TAG_POISON;
-		do_clear = 1;
 	}
 
-	if (qc->waiting) {
-		struct completion *waiting = qc->waiting;
-		qc->waiting = NULL;
-		complete(waiting);
-	}
+	qc->flags = 0;
+	qc->waiting = NULL;
+	ap->qactive &= ~(1 << tag);
 
-	if (likely(do_clear))
-		ap->qactive &= ~(1 << tag);
 	if (ap->cmd_waiters)
 		wake_up(&ap->cmd_wait_queue);
+
+	if (waiting)
+		complete(waiting);
 }
 
 /**
@@ -3151,7 +3145,6 @@ void ata_qc_complete(struct ata_queued_c
 		return;
 
 	__ata_qc_complete(qc);
-	qc->flags &= ~ATA_QCFLAG_ACTIVE;
 
 	VPRINTK("EXIT\n");
 }
