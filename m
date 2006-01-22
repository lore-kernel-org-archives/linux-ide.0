From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/12] libata: make the owner of a qc responsible for freeing it
Date: Sun, 22 Jan 2006 16:58:30 +0900
Message-ID: <1137916710182-git-send-email-htejun@gmail.com>
References: <11379167103055-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.203]:43152 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751254AbWAVH6i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 02:58:38 -0500
Received: by wproxy.gmail.com with SMTP id i3so715411wra
        for <linux-ide@vger.kernel.org>; Sat, 21 Jan 2006 23:58:35 -0800 (PST)
In-Reply-To: <11379167103055-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: Tejun Heo <htejun@gmail.com>

qc used to be freed automatically on command completion.  However, as
a qc can carry information about its completion status, it can be
useful to its owner/issuer after command completion.  This patch makes
freeing qc responsibility of its owner.  This simplifies
ata_exec_internal() and makes command turn-around for atapi request
sensing less hackish.

This change was originally suggested by Jeff Garzik.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   47 ++++++++++++--------------------------------
 drivers/scsi/libata-scsi.c |   14 +++++++------
 include/linux/libata.h     |    2 +-
 3 files changed, 21 insertions(+), 42 deletions(-)

576c63b9e5ffef8fac2a379b639fbe198fd150ac
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 0e49323..15df633 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1072,24 +1072,12 @@ static unsigned int ata_pio_modes(const 
 	   timing API will get this right anyway */
 }
 
-struct ata_exec_internal_arg {
-	unsigned int err_mask;
-	struct ata_taskfile *tf;
-	struct completion *waiting;
-};
-
-int ata_qc_complete_internal(struct ata_queued_cmd *qc)
+void ata_qc_complete_internal(struct ata_queued_cmd *qc)
 {
-	struct ata_exec_internal_arg *arg = qc->private_data;
-	struct completion *waiting = arg->waiting;
+	struct completion *waiting = qc->private_data;
 
-	if (!(qc->err_mask & ~AC_ERR_DEV))
-		qc->ap->ops->tf_read(qc->ap, arg->tf);
-	arg->err_mask = qc->err_mask;
-	arg->waiting = NULL;
+	qc->ap->ops->tf_read(qc->ap, &qc->tf);
 	complete(waiting);
-
-	return 0;
 }
 
 /**
@@ -1120,7 +1108,7 @@ ata_exec_internal(struct ata_port *ap, s
 	struct ata_queued_cmd *qc;
 	DECLARE_COMPLETION(wait);
 	unsigned long flags;
-	struct ata_exec_internal_arg arg;
+	unsigned int err_mask;
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 
@@ -1134,9 +1122,7 @@ ata_exec_internal(struct ata_port *ap, s
 		qc->nsect = buflen / ATA_SECT_SIZE;
 	}
 
-	arg.waiting = &wait;
-	arg.tf = tf;
-	qc->private_data = &arg;
+	qc->private_data = &wait;
 	qc->complete_fn = ata_qc_complete_internal;
 
 	if (ata_qc_issue(qc))
@@ -1153,7 +1139,7 @@ ata_exec_internal(struct ata_port *ap, s
 		 * before the caller cleans up, it will result in a
 		 * spurious interrupt.  We can live with that.
 		 */
-		if (arg.waiting) {
+		if (qc->flags & ATA_QCFLAG_ACTIVE) {
 			qc->err_mask = AC_ERR_OTHER;
 			ata_qc_complete(qc);
 			printk(KERN_WARNING "ata%u: qc timeout (cmd 0x%x)\n",
@@ -1163,7 +1149,12 @@ ata_exec_internal(struct ata_port *ap, s
 		spin_unlock_irqrestore(&ap->host_set->lock, flags);
 	}
 
-	return arg.err_mask;
+	*tf = qc->tf;
+	err_mask = qc->err_mask;
+
+	ata_qc_free(qc);
+
+	return err_mask;
 
  issue_fail:
 	ata_qc_free(qc);
@@ -3633,8 +3624,6 @@ void ata_qc_free(struct ata_queued_cmd *
 
 void ata_qc_complete(struct ata_queued_cmd *qc)
 {
-	int rc;
-
 	assert(qc != NULL);	/* ata_qc_from_tag _might_ return NULL */
 	assert(qc->flags & ATA_QCFLAG_ACTIVE);
 
@@ -3648,17 +3637,7 @@ void ata_qc_complete(struct ata_queued_c
 	qc->flags &= ~ATA_QCFLAG_ACTIVE;
 
 	/* call completion callback */
-	rc = qc->complete_fn(qc);
-
-	/* if callback indicates not to complete command (non-zero),
-	 * return immediately
-	 */
-	if (rc != 0)
-		return;
-
-	ata_qc_free(qc);
-
-	VPRINTK("EXIT\n");
+	qc->complete_fn(qc);
 }
 
 static inline int ata_should_dma_map(struct ata_queued_cmd *qc)
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 0e65bfe..ce3fe92 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1219,7 +1219,7 @@ nothing_to_do:
 	return 1;
 }
 
-static int ata_scsi_qc_complete(struct ata_queued_cmd *qc)
+static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	u8 *cdb = cmd->cmnd;
@@ -1256,7 +1256,7 @@ static int ata_scsi_qc_complete(struct a
 
 	qc->scsidone(cmd);
 
-	return 0;
+	ata_qc_free(qc);
 }
 
 /**
@@ -1982,7 +1982,7 @@ void ata_scsi_badcmd(struct scsi_cmnd *c
 	done(cmd);
 }
 
-static int atapi_sense_complete(struct ata_queued_cmd *qc)
+static void atapi_sense_complete(struct ata_queued_cmd *qc)
 {
 	if (qc->err_mask && ((qc->err_mask & AC_ERR_DEV) == 0))
 		/* FIXME: not quite right; we don't want the
@@ -1993,7 +1993,7 @@ static int atapi_sense_complete(struct a
 		ata_gen_ata_desc_sense(qc);
 
 	qc->scsidone(qc->scsicmd);
-	return 0;
+	ata_qc_free(qc);
 }
 
 /* is it pointless to prefer PIO for "safety reasons"? */
@@ -2050,7 +2050,7 @@ static void atapi_request_sense(struct a
 	DPRINTK("EXIT\n");
 }
 
-static int atapi_qc_complete(struct ata_queued_cmd *qc)
+static void atapi_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	unsigned int err_mask = qc->err_mask;
@@ -2060,7 +2060,7 @@ static int atapi_qc_complete(struct ata_
 	if (unlikely(err_mask & AC_ERR_DEV)) {
 		cmd->result = SAM_STAT_CHECK_CONDITION;
 		atapi_request_sense(qc);
-		return 1;
+		return;
 	}
 
 	else if (unlikely(err_mask))
@@ -2100,7 +2100,7 @@ static int atapi_qc_complete(struct ata_
 	}
 
 	qc->scsidone(cmd);
-	return 0;
+	ata_qc_free(qc);
 }
 /**
  *	atapi_xlat - Initialize PACKET taskfile
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 46ccea2..d58b659 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -235,7 +235,7 @@ struct ata_port;
 struct ata_queued_cmd;
 
 /* typedefs */
-typedef int (*ata_qc_cb_t) (struct ata_queued_cmd *qc);
+typedef void (*ata_qc_cb_t) (struct ata_queued_cmd *qc);
 
 struct ata_ioports {
 	unsigned long		cmd_addr;
-- 
1.0.8


