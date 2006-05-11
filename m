From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/11] libata-eh-fw: update SCSI command completion path for new EH
Date: Thu, 11 May 2006 21:27:24 +0900
Message-ID: <11473504441307-git-send-email-htejun@gmail.com>
References: <11473504433328-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.199]:29322 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751654AbWEKM1e (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 08:27:34 -0400
Received: by nz-out-0102.google.com with SMTP id 13so175443nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 05:27:34 -0700 (PDT)
In-Reply-To: <11473504433328-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

SCSI command completion path used to do some part of EH including
printing messages and obtaining sense data.  With new EH, all these
are responsibilities of the EH, update SCSI command completion path to
reflect this.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-scsi.c |   48 ++++++++++++++++++++++++++++++++++----------
 1 files changed, 37 insertions(+), 11 deletions(-)

90c8f6da58a1c4c67e65c73ed303a97d06c077c9
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index fd7064b..e61cc35 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -415,6 +415,7 @@ int ata_scsi_device_suspend(struct scsi_
  *	@sk: the sense key we'll fill out
  *	@asc: the additional sense code we'll fill out
  *	@ascq: the additional sense code qualifier we'll fill out
+ *	@verbose: be verbose
  *
  *	Converts an ATA error into a SCSI error.  Fill out pointers to
  *	SK, ASC, and ASCQ bytes for later use in fixed or descriptor
@@ -424,7 +425,7 @@ int ata_scsi_device_suspend(struct scsi_
  *	spin_lock_irqsave(host_set lock)
  */
 void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk, u8 *asc,
-			u8 *ascq)
+			u8 *ascq, int verbose)
 {
 	int i;
 
@@ -489,8 +490,9 @@ void ata_to_sense_error(unsigned id, u8 
 			}
 		}
 		/* No immediate match */
-		printk(KERN_WARNING "ata%u: no sense translation for "
-		       "error 0x%02x\n", id, drv_err);
+		if (verbose)
+			printk(KERN_WARNING "ata%u: no sense translation for "
+			       "error 0x%02x\n", id, drv_err);
 	}
 
 	/* Fall back to interpreting status bits */
@@ -503,8 +505,9 @@ void ata_to_sense_error(unsigned id, u8 
 		}
 	}
 	/* No error?  Undecoded? */
-	printk(KERN_WARNING "ata%u: no sense translation for status: 0x%02x\n",
-	       id, drv_stat);
+	if (verbose)
+		printk(KERN_WARNING "ata%u: no sense translation for "
+		       "status: 0x%02x\n", id, drv_stat);
 
 	/* We need a sensible error return here, which is tricky, and one
 	   that won't cause people to do things like return a disk wrongly */
@@ -513,9 +516,10 @@ void ata_to_sense_error(unsigned id, u8 
 	*ascq = 0x00;
 
  translate_done:
-	printk(KERN_ERR "ata%u: translated ATA stat/err 0x%02x/%02x to "
-	       "SCSI SK/ASC/ASCQ 0x%x/%02x/%02x\n", id, drv_stat, drv_err,
-	       *sk, *asc, *ascq);
+	if (verbose)
+		printk(KERN_ERR "ata%u: translated ATA stat/err 0x%02x/%02x "
+		       "to SCSI SK/ASC/ASCQ 0x%x/%02x/%02x\n",
+		       id, drv_stat, drv_err, *sk, *asc, *ascq);
 	return;
 }
 
@@ -538,6 +542,7 @@ void ata_gen_ata_desc_sense(struct ata_q
 	struct ata_taskfile *tf = &qc->result_tf;
 	unsigned char *sb = cmd->sense_buffer;
 	unsigned char *desc = sb + 8;
+	int verbose = qc->ap->ops->error_handler == NULL;
 
 	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
 
@@ -550,7 +555,7 @@ void ata_gen_ata_desc_sense(struct ata_q
 	if (qc->err_mask ||
 	    tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
 		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
-				   &sb[1], &sb[2], &sb[3]);
+				   &sb[1], &sb[2], &sb[3], verbose);
 		sb[1] &= 0x0f;
 	}
 
@@ -608,6 +613,7 @@ void ata_gen_fixed_sense(struct ata_queu
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->result_tf;
 	unsigned char *sb = cmd->sense_buffer;
+	int verbose = qc->ap->ops->error_handler == NULL;
 
 	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
 
@@ -620,7 +626,7 @@ void ata_gen_fixed_sense(struct ata_queu
 	if (qc->err_mask ||
 	    tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
 		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
-				   &sb[2], &sb[12], &sb[13]);
+				   &sb[2], &sb[12], &sb[13], verbose);
 		sb[2] &= 0x0f;
 	}
 
@@ -1212,7 +1218,7 @@ static void ata_scsi_qc_complete(struct 
 		}
 	}
 
-	if (need_sense)
+	if (need_sense && !qc->ap->ops->error_handler)
 		ata_dump_status(qc->ap->id, &qc->result_tf);
 
 	qc->scsidone(cmd);
@@ -2060,6 +2066,26 @@ static void atapi_qc_complete(struct ata
 
 	VPRINTK("ENTER, err_mask 0x%X\n", err_mask);
 
+	/* handle completion from new EH */
+	if (unlikely(qc->ap->ops->error_handler &&
+		     (err_mask || qc->flags & ATA_QCFLAG_SENSE_VALID))) {
+
+		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID)) {
+			/* FIXME: not quite right; we don't want the
+			 * translation of taskfile registers into a
+			 * sense descriptors, since that's only
+			 * correct for ATA, not ATAPI
+			 */
+			ata_gen_ata_desc_sense(qc);
+		}
+
+		qc->scsicmd->result = SAM_STAT_CHECK_CONDITION;
+		qc->scsidone(cmd);
+		ata_qc_free(qc);
+		return;
+	}
+
+	/* successful completion or old EH failure path */
 	if (unlikely(err_mask & AC_ERR_DEV)) {
 		cmd->result = SAM_STAT_CHECK_CONDITION;
 		atapi_request_sense(qc);
-- 
1.2.4


