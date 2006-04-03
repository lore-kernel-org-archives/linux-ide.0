From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/14] libata: update EH to handle NCQ
Date: Mon, 3 Apr 2006 17:32:39 +0900
Message-ID: <1144053159475-git-send-email-htejun@gmail.com>
References: <1144053158183-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.203]:7526 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751633AbWDCIcu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Apr 2006 04:32:50 -0400
Received: by xproxy.gmail.com with SMTP id t10so764247wxc
        for <linux-ide@vger.kernel.org>; Mon, 03 Apr 2006 01:32:49 -0700 (PDT)
In-Reply-To: <1144053158183-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, axboe@suse.de, linux-ide@vger.kernel.org
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
 include/linux/libata.h      |    1 +
 4 files changed, 79 insertions(+), 5 deletions(-)

7afc779e20e434b5ce39626a2c5ef4b2f9cae017
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 21aea0b..3dad10f 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -862,7 +862,7 @@ static void ahci_error_handler(struct at
 	}
 
 	/* perform recovery */
-	qc = ata_eh_determine_qc(ap, &tf);
+	qc = ata_eh_determine_qc(ap, 0, &tf);
 
 	action |= ahci_eh_autopsy(ap, qc, irq_stat, desc, sizeof(desc));
 	action |= ata_eh_autopsy(ap, qc, &tf, serror);
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
index 94ecb0c..10c0574 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -637,6 +637,7 @@ static int ata_eh_read_log_10h(struct at
 /**
  *	ata_eh_determine_qc - Determine which qc caused error
  *	@ap: port which failed
+ *	@use_log_10h: use log page 10h result
  *	@tf: resulting taskfile registers of the failed command
  *
  *	Determine which qc caused failure and read associated tf
@@ -649,12 +650,65 @@ static int ata_eh_read_log_10h(struct at
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
@@ -980,11 +1034,11 @@ void ata_eh_report(struct ata_port *ap, 
 
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
 
@@ -1166,7 +1220,9 @@ void ata_eh_finish_qcs(struct ata_port *
 		       struct ata_taskfile *tf)
 {
 	struct ata_taskfile tmp_tf;
+	int i;
 
+	/* first, the failed qc */
 	if (qc) {
 		/* prevent infinite retry loop */
 		if (!qc->err_mask && !(qc->flags & ATA_QCFLAG_SENSE_VALID)) {
@@ -1194,4 +1250,21 @@ void ata_eh_finish_qcs(struct ata_port *
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
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 7175191..f3f6f50 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -696,6 +696,7 @@ extern void ata_eh_schedule_port(struct 
 extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
 extern struct ata_queued_cmd * ata_eh_determine_qc(struct ata_port *ap,
+						   int use_log_10h,
 						   struct ata_taskfile *tf);
 extern unsigned int ata_eh_autopsy(struct ata_port *ap,
 				   struct ata_queued_cmd *qc,
-- 
1.2.4


