From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/2] libata: make ata_qc_issue complete failed qcs
Date: Fri, 31 Mar 2006 20:41:11 +0900
Message-ID: <20060331114111.GE13172@htj.dyndns.org>
References: <20060331113647.GD13172@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.235]:16646 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751326AbWCaLlQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 06:41:16 -0500
Received: by wproxy.gmail.com with SMTP id i22so901627wra
        for <linux-ide@vger.kernel.org>; Fri, 31 Mar 2006 03:41:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20060331113647.GD13172@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

There is no reason for the issuer to diddle with a failed qc as the
issuer has complete control over when a qc gets freed (usually in
->complete_fn).  Make ata_qc_issue() responsible for completing qcs
which failed to issue.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 libata-core.c |   20 +++++++++-----------
 libata-scsi.c |    8 ++------
 libata.h      |    2 +-
 3 files changed, 12 insertions(+), 18 deletions(-)

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2006-03-31 20:34:02.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2006-03-31 20:34:06.000000000 +0900
@@ -989,9 +989,7 @@ ata_exec_internal(struct ata_port *ap, s
 	qc->private_data = &wait;
 	qc->complete_fn = ata_qc_complete_internal;
 
-	qc->err_mask = ata_qc_issue(qc);
-	if (qc->err_mask)
-		ata_qc_complete(qc);
+	ata_qc_issue(qc);
 
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
@@ -3997,12 +3995,8 @@ static inline int ata_should_dma_map(str
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
- *
- *	RETURNS:
- *	Zero on success, AC_ERR_* mask on failure
  */
-
-unsigned int ata_qc_issue(struct ata_queued_cmd *qc)
+void ata_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 
@@ -4023,14 +4017,18 @@ unsigned int ata_qc_issue(struct ata_que
 
 	ap->ops->qc_prep(qc);
 
-	return ap->ops->qc_issue(qc);
+	qc->err_mask |= ap->ops->qc_issue(qc);
+	if (unlikely(qc->err_mask))
+		goto err;
+	return;
 
 sg_err:
 	qc->flags &= ~ATA_QCFLAG_DMAMAP;
-	return AC_ERR_SYSTEM;
+	qc->err_mask |= AC_ERR_SYSTEM;
+err:
+	ata_qc_complete(qc);
 }
 
-
 /**
  *	ata_qc_issue_prot - issue taskfile to device in proto-dependent manner
  *	@qc: command to issue to device
Index: work/drivers/scsi/libata-scsi.c
===================================================================
--- work.orig/drivers/scsi/libata-scsi.c	2006-03-31 20:34:02.000000000 +0900
+++ work/drivers/scsi/libata-scsi.c	2006-03-31 20:34:06.000000000 +0900
@@ -1431,9 +1431,7 @@ static void ata_scsi_translate(struct at
 		goto early_finish;
 
 	/* select device, send command to hardware */
-	qc->err_mask = ata_qc_issue(qc);
-	if (qc->err_mask)
-		ata_qc_complete(qc);
+	ata_qc_issue(qc);
 
 	VPRINTK("EXIT\n");
 	return;
@@ -2199,9 +2197,7 @@ static void atapi_request_sense(struct a
 
 	qc->complete_fn = atapi_sense_complete;
 
-	qc->err_mask = ata_qc_issue(qc);
-	if (qc->err_mask)
-		ata_qc_complete(qc);
+	ata_qc_issue(qc);
 
 	DPRINTK("EXIT\n");
 }
Index: work/drivers/scsi/libata.h
===================================================================
--- work.orig/drivers/scsi/libata.h	2006-03-31 20:34:02.000000000 +0900
+++ work/drivers/scsi/libata.h	2006-03-31 20:34:06.000000000 +0900
@@ -47,7 +47,7 @@ extern struct ata_queued_cmd *ata_qc_new
 extern int ata_rwcmd_protocol(struct ata_queued_cmd *qc);
 extern void ata_port_flush_task(struct ata_port *ap);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
-extern unsigned int ata_qc_issue(struct ata_queued_cmd *qc);
+extern void ata_qc_issue(struct ata_queued_cmd *qc);
 extern int ata_check_atapi_dma(struct ata_queued_cmd *qc);
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,
                            unsigned int wait, unsigned int can_sleep);
