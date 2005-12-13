From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/4] libata: remove unused qc->waiting
Date: Tue, 13 Dec 2005 14:51:25 +0900
Message-ID: <20051213055125.GD20810@htj.dyndns.org>
References: <20051129131717.GA8505@htj.dyndns.org> <43924B5A.1070904@pobox.com> <4392F78A.2040209@gmail.com> <439341C2.5090205@pobox.com> <43994F85.7040300@gmail.com> <20051211042303.GA29403@htj.dyndns.org> <439E54F8.8020304@pobox.com> <439E56E1.1070109@gmail.com> <439E59C1.6090002@pobox.com> <20051213054831.GA20810@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:40508 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751337AbVLMFv3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Dec 2005 00:51:29 -0500
Received: by zproxy.gmail.com with SMTP id n1so1659541nzf
        for <linux-ide@vger.kernel.org>; Mon, 12 Dec 2005 21:51:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20051213054831.GA20810@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, linux-ide@vger.kernel.org

There is no user of qc->waiting left after ata_exec_internal()
changes.  Kill the field.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work2/drivers/scsi/libata-core.c
===================================================================
--- work2.orig/drivers/scsi/libata-core.c	2005-12-13 14:37:51.000000000 +0900
+++ work2/drivers/scsi/libata-core.c	2005-12-13 14:37:54.000000000 +0900
@@ -3503,7 +3503,7 @@ struct ata_queued_cmd *ata_qc_new_init(s
 static void __ata_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	unsigned int tag, do_clear = 0;
+	unsigned int tag;
 
 	qc->flags = 0;
 	tag = qc->tag;
@@ -3511,17 +3511,8 @@ static void __ata_qc_complete(struct ata
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
@@ -3537,7 +3528,6 @@ static void __ata_qc_complete(struct ata
 void ata_qc_free(struct ata_queued_cmd *qc)
 {
 	assert(qc != NULL);	/* ata_qc_from_tag _might_ return NULL */
-	assert(qc->waiting == NULL);	/* nothing should be waiting */
 
 	__ata_qc_complete(qc);
 }
Index: work2/include/linux/libata.h
===================================================================
--- work2.orig/include/linux/libata.h	2005-12-13 14:37:11.000000000 +0900
+++ work2/include/linux/libata.h	2005-12-13 14:37:54.000000000 +0900
@@ -285,8 +285,6 @@ struct ata_queued_cmd {
 
 	ata_qc_cb_t		complete_fn;
 
-	struct completion	*waiting;
-
 	void			*private_data;
 };
 
