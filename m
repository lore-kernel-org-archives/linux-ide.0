From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/4] libata: remove unused qc->waiting
Date: Mon, 5 Dec 2005 17:31:34 +0900
Message-ID: <20051205083134.GD3451@htj.dyndns.org>
References: <20051128164201.GA7530@htj.dyndns.org> <438C0645.3020301@tw.ibm.com> <20051129131717.GA8505@htj.dyndns.org> <43924B5A.1070904@pobox.com> <4392F78A.2040209@gmail.com> <439341C2.5090205@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.205]:45417 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751118AbVLEIbi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Dec 2005 03:31:38 -0500
Received: by zproxy.gmail.com with SMTP id 13so742239nzn
        for <linux-ide@vger.kernel.org>; Mon, 05 Dec 2005 00:31:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <439341C2.5090205@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, linux-ide@vger.kernel.org

There is no user of qc->waiting left after ata_exec_internal() change.
Kill the field.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-12-05 17:10:44.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-12-05 17:10:48.000000000 +0900
@@ -3664,7 +3664,7 @@ struct ata_queued_cmd *ata_qc_new_init(s
 static void __ata_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	unsigned int tag, do_clear = 0;
+	unsigned int tag;
 
 	qc->flags = 0;
 	tag = qc->tag;
@@ -3672,17 +3672,8 @@ static void __ata_qc_complete(struct ata
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
@@ -3698,7 +3689,6 @@ static void __ata_qc_complete(struct ata
 void ata_qc_free(struct ata_queued_cmd *qc)
 {
 	assert(qc != NULL);	/* ata_qc_from_tag _might_ return NULL */
-	assert(qc->waiting == NULL);	/* nothing should be waiting */
 
 	__ata_qc_complete(qc);
 }
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h	2005-12-05 17:10:36.000000000 +0900
+++ work/include/linux/libata.h	2005-12-05 17:10:48.000000000 +0900
@@ -287,8 +287,6 @@ struct ata_queued_cmd {
 
 	ata_qc_cb_t		complete_fn;
 
-	struct completion	*waiting;
-
 	void			*private_data;
 };
 

