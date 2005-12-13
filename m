From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/4] libata: remove unused functions
Date: Tue, 13 Dec 2005 14:50:38 +0900
Message-ID: <20051213055038.GC20810@htj.dyndns.org>
References: <20051129131717.GA8505@htj.dyndns.org> <43924B5A.1070904@pobox.com> <4392F78A.2040209@gmail.com> <439341C2.5090205@pobox.com> <43994F85.7040300@gmail.com> <20051211042303.GA29403@htj.dyndns.org> <439E54F8.8020304@pobox.com> <439E56E1.1070109@gmail.com> <439E59C1.6090002@pobox.com> <20051213054831.GA20810@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.195]:20433 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751334AbVLMFun (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Dec 2005 00:50:43 -0500
Received: by zproxy.gmail.com with SMTP id k1so1637791nzf
        for <linux-ide@vger.kernel.org>; Mon, 12 Dec 2005 21:50:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20051213054831.GA20810@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, linux-ide@vger.kernel.org

There is no user of ata_qc_wait_err() and ata_qc_complete_noop() after
ata_exec_internal() changes.  Remove unused functions.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work2/drivers/scsi/libata-core.c
===================================================================
--- work2.orig/drivers/scsi/libata-core.c	2005-12-13 14:37:49.000000000 +0900
+++ work2/drivers/scsi/libata-core.c	2005-12-13 14:37:51.000000000 +0900
@@ -1145,30 +1145,6 @@ ata_exec_internal(struct ata_port *ap, s
 	return AC_ERR_OTHER;
 }
 
-static int ata_qc_wait_err(struct ata_queued_cmd *qc,
-			   struct completion *wait)
-{
-	int rc = 0;
-
-	if (wait_for_completion_timeout(wait, 30 * HZ) < 1) {
-		/* timeout handling */
-		qc->err_mask |= ac_err_mask(ata_chk_status(qc->ap));
-
-		if (!qc->err_mask) {
-			printk(KERN_WARNING "ata%u: slow completion (cmd %x)\n",
-			       qc->ap->id, qc->tf.command);
-		} else {
-			printk(KERN_WARNING "ata%u: qc timeout (cmd %x)\n",
-			       qc->ap->id, qc->tf.command);
-			rc = -EIO;
-		}
-
-		ata_qc_complete(qc);
-	}
-
-	return rc;
-}
-
 /**
  *	ata_dev_identify - obtain IDENTIFY x DEVICE page
  *	@ap: port on which device we wish to probe resides
@@ -3524,11 +3500,6 @@ struct ata_queued_cmd *ata_qc_new_init(s
 	return qc;
 }
 
-int ata_qc_complete_noop(struct ata_queued_cmd *qc)
-{
-	return 0;
-}
-
 static void __ata_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
Index: work2/drivers/scsi/libata.h
===================================================================
--- work2.orig/drivers/scsi/libata.h	2005-12-13 14:37:10.000000000 +0900
+++ work2/drivers/scsi/libata.h	2005-12-13 14:37:51.000000000 +0900
@@ -39,7 +39,6 @@ struct ata_scsi_args {
 
 /* libata-core.c */
 extern int atapi_enabled;
-extern int ata_qc_complete_noop(struct ata_queued_cmd *qc);
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 				      struct ata_device *dev);
 extern void ata_rwcmd_protocol(struct ata_queued_cmd *qc);
