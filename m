From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/15] libata-ncq: update EH to handle NCQ
Date: Tue, 11 Apr 2006 22:53:37 +0900
Message-ID: <11447636171050-git-send-email-htejun@gmail.com>
References: <1144763616819-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.200]:33886 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750993AbWDKNxu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:53:50 -0400
Received: by zproxy.gmail.com with SMTP id o37so1097581nzf
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:53:49 -0700 (PDT)
In-Reply-To: <1144763616819-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

* ata_eh_determine_qc() is updated to take log page 10h into account
  to determine which qc has failed and obtain its TF.

* ata_eh_report() is updated to report ap->sactive.

* ata_eh_finish_qcs() is updated to finish all aborted NCQ commands.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c         |    2 +
 drivers/scsi/libata-bmdma.c |    2 +
 drivers/scsi/libata-eh.c    |   79 +++++++++++++++++++++++++++++++++++++++++--
 drivers/scsi/sata_sil24.c   |    2 +
 include/linux/libata.h      |    1 +
 5 files changed, 80 insertions(+), 6 deletions(-)

80d986bf527942c9a6188b258b15e2f5667678ff
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 67950ee..f3d117e 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -845,7 +845,7 @@ static void ahci_error_handler(struct at
 	/* perform recovery */
 	action |= ahci_eh_autopsy(ap, irq_stat, &err_mask, desc, sizeof(desc));
 
-	qc = ata_eh_determine_qc(ap, &tf);
+	qc = ata_eh_determine_qc(ap, 0, &tf);
 	if (qc)
 		qc->err_mask |= err_mask;
 
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index 6e48ce5..3c3bc71 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -700,7 +700,7 @@ void ata_bmdma_drive_eh(struct ata_port 
 	struct ata_taskfile tf;
 	u32 serror;
 
-	qc = ata_eh_determine_qc(ap, &tf);
+	qc = ata_eh_determine_qc(ap, 0, &tf);
 
 	/* reset PIO HSM and stop DMA engine */
 	spin_lock_irqsave(&host_set->lock, flags);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 795f580..1a87bce 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -669,6 +669,7 @@ static int ata_eh_read_log_10h(struct at
 /**
  *	ata_eh_determine_qc - Determine which qc caused error
  *	@ap: port which failed
+ *	@use_log_10h: use log page 10h result
  *	@tf: resulting taskfile registers of the failed command
  *
  *	Determine which qc caused failure and read associated tf
@@ -681,12 +682,65 @@ static int ata_eh_read_log_10h(struct at
  *	Pointer to the failed qc.
  */
 struct ata_queued_cmd * ata_eh_determine_qc(struct ata_port *ap,
+					    int use_log_10h,
 					    struct ata_taskfile *tf)
 {
+	struct ata_queued_cmd *first_qc, *qc;
+	struct ata_device *dev;
+	struct ata_taskfile tmp_tf;
+	unsigned int tag;
+	int rc;
+
 	memset(tf, 0, sizeof(*tf));
 	ap->ops->tf_read(ap, tf);
 
-	return __ata_qc_from_tag(ap, ap->active_tag);
+	qc = __ata_qc_from_tag(ap, ap->active_tag);
+	if (qc)
+		return qc;
+
+	if (!ap->sactive)
+		return NULL;
+
+	/* NCQ.  Assume the first device. */
+	dev = &ap->device[0];
+
+	/* Find the first active qc with error.  If no qc is
+	 * explicitly marked with error, use the first active qc.
+	 */
+	first_qc = NULL;
+	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
+		qc = __ata_qc_from_tag(ap, tag);
+		if (qc->flags & ATA_QCFLAG_ACTIVE) {
+			if (!first_qc)
+				first_qc = qc;
+			if (qc->err_mask)
+				break;
+		}
+	}
+	if (tag == ATA_MAX_QUEUE)
+		qc = first_qc;
+
+	/* Always read log page 10h to unjam the device but use the
+	 * result only if use_log_10h is non-zero.
+	 */
+	rc = ata_eh_read_log_10h(ap, dev, &tag, &tmp_tf);
+	if (rc || !(ap->sactive & (1 << tag))) {
+		if (rc == 0)
+			rc = -ENOENT;
+		printk(KERN_ERR "ata%u: failed to read log page 10h (errno=%d)\n",
+		       ap->id, rc);
+		qc->err_mask &= ~AC_ERR_DEV;
+		qc->err_mask |= AC_ERR_OTHER;
+	}
+	DPRINTK("ata%u: rc=%d emask=0x%x tag=%d stat=0x%x err=0x%x\n",
+		ap->id, rc, qc->err_mask, tag, tmp_tf.command, tmp_tf.feature);
+
+	if (use_log_10h) {
+		qc = __ata_qc_from_tag(ap, tag);
+		memcpy(tf, &tmp_tf, sizeof(*tf));
+	}
+
+	return qc;
 }
 
 /**
@@ -1018,11 +1072,11 @@ void ata_eh_report(struct ata_port *ap, 
 
 	printk(KERN_ERR
 	       "ata%u: dev %u command 0x%x tag %u failed with %s\n"
-	       "      Emask 0x%x stat 0x%x err 0x%x SErr 0x%x action 0x%x\n"
+	       "      Emask 0x%x stat 0x%x err 0x%x SAct 0x%x SErr 0x%x action 0x%x\n"
 	       "%s%s%s",
 	       ap->id, qc->dev->devno, qc->tf.command, qc->tag,
 	       ata_err_string(qc->err_mask), qc->err_mask,
-	       tf->command, tf->feature, serror, action,
+	       tf->command, tf->feature, ap->sactive, serror, action,
 	       desc_head, desc, desc_tail);
 }
 
@@ -1247,7 +1301,9 @@ void ata_eh_finish_qcs(struct ata_port *
 		       struct ata_taskfile *tf)
 {
 	struct ata_taskfile tmp_tf;
+	int i;
 
+	/* first, the failed qc */
 	if (qc) {
 		/* prevent infinite retry loop */
 		if (!qc->err_mask && !(qc->flags & ATA_QCFLAG_SENSE_VALID)) {
@@ -1275,4 +1331,21 @@ void ata_eh_finish_qcs(struct ata_port *
 		else
 			ata_eh_qc_retry(qc);
 	}
+
+	/* and, victimized NCQ commands */
+
+	/* feed zero TF to sense generation */
+	memset(&tmp_tf, 0, sizeof(tmp_tf));
+
+	for (i = 0; i < ATA_MAX_QUEUE; i++) {
+		qc = __ata_qc_from_tag(ap, i);
+		if (qc->flags & ATA_QCFLAG_ACTIVE) {
+			tmp_tf.flags = qc->tf.flags;
+			tmp_tf.protocol = qc->tf.protocol;
+			tmp_tf.ctl = qc->tf.ctl;
+			qc->tf = tmp_tf;
+
+			ata_eh_qc_retry(qc);
+		}
+	}
 }
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index bbbc18a..c2c5ed9 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -821,7 +821,7 @@ static void sil24_error_handler(struct a
 	/* perform recovery */
 	action |= sil24_eh_autopsy(ap, irq_stat, &err_mask, desc, sizeof(desc));
 
-	qc = ata_eh_determine_qc(ap, &tf);
+	qc = ata_eh_determine_qc(ap, 0, &tf);
 	if (qc)
 		qc->err_mask |= err_mask;
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b194f3f..d463156 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -700,6 +700,7 @@ extern void ata_eh_schedule_port(struct 
 extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
 extern struct ata_queued_cmd * ata_eh_determine_qc(struct ata_port *ap,
+						   int use_log_10h,
 						   struct ata_taskfile *tf);
 extern unsigned int ata_eh_autopsy(struct ata_port *ap,
 				   struct ata_queued_cmd *qc,
-- 
1.2.4


