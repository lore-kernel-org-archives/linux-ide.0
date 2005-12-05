From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/4] libata: remove unused functions
Date: Mon, 5 Dec 2005 17:30:12 +0900
Message-ID: <20051205083012.GC3451@htj.dyndns.org>
References: <20051128164201.GA7530@htj.dyndns.org> <438C0645.3020301@tw.ibm.com> <20051129131717.GA8505@htj.dyndns.org> <43924B5A.1070904@pobox.com> <4392F78A.2040209@gmail.com> <439341C2.5090205@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.204]:20810 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751355AbVLEIaR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Dec 2005 03:30:17 -0500
Received: by zproxy.gmail.com with SMTP id 13so742016nzn
        for <linux-ide@vger.kernel.org>; Mon, 05 Dec 2005 00:30:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <439341C2.5090205@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, linux-ide@vger.kernel.org

There is no user of ata_qc_wait_err() and ata_qc_complete_noop() after
ata_qc_exec_internal() change.  Remove unused functions.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-12-05 17:10:36.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-12-05 17:10:44.000000000 +0900
@@ -1147,30 +1147,6 @@ ata_exec_internal(struct ata_port *ap, s
 	return AC_ERR_OTHER;
 }
 
-static int ata_qc_wait_err(struct ata_queued_cmd *qc,
-			   struct completion *wait)
-{
-	int rc = 0;
-
-	if (wait_for_completion_timeout(wait, 30 * HZ) < 1) {
-		/* timeout handling */
-		unsigned int err_mask = ac_err_mask(ata_chk_status(qc->ap));
-
-		if (!err_mask) {
-			printk(KERN_WARNING "ata%u: slow completion (cmd %x)\n",
-			       qc->ap->id, qc->tf.command);
-		} else {
-			printk(KERN_WARNING "ata%u: qc timeout (cmd %x)\n",
-			       qc->ap->id, qc->tf.command);
-			rc = -EIO;
-		}
-
-		ata_qc_complete(qc, err_mask);
-	}
-
-	return rc;
-}
-
 /**
  *	ata_dev_identify - obtain IDENTIFY x DEVICE page
  *	@ap: port on which device we wish to probe resides
@@ -3685,11 +3661,6 @@ struct ata_queued_cmd *ata_qc_new_init(s
 	return qc;
 }
 
-int ata_qc_complete_noop(struct ata_queued_cmd *qc, unsigned int err_mask)
-{
-	return 0;
-}
-
 static void __ata_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
Index: work/drivers/scsi/libata.h
===================================================================
--- work.orig/drivers/scsi/libata.h	2005-12-05 17:10:16.000000000 +0900
+++ work/drivers/scsi/libata.h	2005-12-05 17:10:36.000000000 +0900
@@ -39,7 +39,6 @@ struct ata_scsi_args {
 
 /* libata-core.c */
 extern int atapi_enabled;
-extern int ata_qc_complete_noop(struct ata_queued_cmd *qc, unsigned int err_mask);
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 				      struct ata_device *dev);
 extern void ata_rwcmd_protocol(struct ata_queued_cmd *qc);
