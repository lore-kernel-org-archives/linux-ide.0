From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/2] libata: remove qc->waiting
Date: Tue, 29 Nov 2005 22:19:06 +0900
Message-ID: <20051129131906.GB8505@htj.dyndns.org>
References: <20051128164201.GA7530@htj.dyndns.org> <438C0645.3020301@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.207]:10023 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751353AbVK2NTO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Nov 2005 08:19:14 -0500
Received: by zproxy.gmail.com with SMTP id 14so1619697nzn
        for <linux-ide@vger.kernel.org>; Tue, 29 Nov 2005 05:19:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <438C0645.3020301@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

With internal commands converted to use ata_exec_internal(), there is
no user of qc->waiting left.  Kill it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-11-29 22:06:20.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-11-29 22:06:38.000000000 +0900
@@ -3679,7 +3679,7 @@ struct ata_queued_cmd *ata_qc_new_init(s
 static void __ata_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	unsigned int tag, do_clear = 0;
+	unsigned int tag;
 
 	qc->flags = 0;
 	tag = qc->tag;
@@ -3687,17 +3687,8 @@ static void __ata_qc_complete(struct ata
 		if (tag == ap->active_tag)
 			ap->active_tag = ATA_TAG_POISON;
 		qc->tag = ATA_TAG_POISON;
-		do_clear = 1;
-	}
-
-	if (qc->waiting) {
-		struct completion *waiting = qc->waiting;
-		qc->waiting = NULL;
-		complete(waiting);
-	}
-
-	if (likely(do_clear))
 		clear_bit(tag, &ap->qactive);
+	}
 }
 
 /**
@@ -3713,7 +3704,6 @@ static void __ata_qc_complete(struct ata
 void ata_qc_free(struct ata_queued_cmd *qc)
 {
 	assert(qc != NULL);	/* ata_qc_from_tag _might_ return NULL */
-	assert(qc->waiting == NULL);	/* nothing should be waiting */
 
 	__ata_qc_complete(qc);
 }
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h	2005-11-29 22:06:20.000000000 +0900
+++ work/include/linux/libata.h	2005-11-29 22:06:38.000000000 +0900
@@ -288,8 +288,6 @@ struct ata_queued_cmd {
 	ata_qc_cb_t		complete_fn;
 	void			*complete_data;
 
-	struct completion	*waiting;
-
 	void			*private_data;
 };
 
