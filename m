From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/12] libata-ncq: implement ap->qc_active, ap->sactive and complete helper
Date: Thu, 11 May 2006 23:44:43 +0900
Message-ID: <11473586831622-git-send-email-htejun@gmail.com>
References: <1147358682210-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.199]:58251 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751802AbWEKOou (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 10:44:50 -0400
Received: by wx-out-0102.google.com with SMTP id t16so8162wxc
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 07:44:50 -0700 (PDT)
In-Reply-To: <1147358682210-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add ap->qc_active and ap->sactive, mask of all active qcs and libata's
view of the SActive register, respectively.  Also, implement
ata_qc_complete_multiple() which takes new qc_active mask and complete
multiple qcs according to the mask.

These will be used to track NCQ commands and complete them.  The
distinction between ap->qc_active and ap->sactive is also useful for
later PM implementation.

---

 drivers/scsi/libata-core.c |   81 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/libata.h     |    5 +++
 2 files changed, 84 insertions(+), 2 deletions(-)

4e46d5244102b748d414e888fdc6cd3a42087b78
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index bafc460..0c2550e 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -981,6 +981,7 @@ unsigned ata_exec_internal(struct ata_de
 	u8 command = tf->command;
 	struct ata_queued_cmd *qc;
 	unsigned int tag, preempted_tag;
+	u32 preempted_sactive, preempted_qc_active;
 	DECLARE_COMPLETION(wait);
 	unsigned long flags;
 	unsigned int err_mask;
@@ -1017,7 +1018,11 @@ unsigned ata_exec_internal(struct ata_de
 	ata_qc_reinit(qc);
 
 	preempted_tag = ap->active_tag;
+	preempted_sactive = ap->sactive;
+	preempted_qc_active = ap->qc_active;
 	ap->active_tag = ATA_TAG_POISON;
+	ap->sactive = 0;
+	ap->qc_active = 0;
 
 	/* prepare & issue qc */
 	qc->tf = *tf;
@@ -1082,6 +1087,8 @@ unsigned ata_exec_internal(struct ata_de
 
 	ata_qc_free(qc);
 	ap->active_tag = preempted_tag;
+	ap->sactive = preempted_sactive;
+	ap->qc_active = preempted_qc_active;
 
 	/* XXX - Some LLDDs (sata_mv) disable port on command failure.
 	 * Until those drivers are fixed, we detect the condition
@@ -4269,6 +4276,8 @@ void ata_qc_free(struct ata_queued_cmd *
 
 void __ata_qc_complete(struct ata_queued_cmd *qc)
 {
+	struct ata_port *ap = qc->ap;
+
 	WARN_ON(qc == NULL);	/* ata_qc_from_tag _might_ return NULL */
 	WARN_ON(!(qc->flags & ATA_QCFLAG_ACTIVE));
 
@@ -4276,13 +4285,17 @@ void __ata_qc_complete(struct ata_queued
 		ata_sg_clean(qc);
 
 	/* command should be marked inactive atomically with qc completion */
-	qc->ap->active_tag = ATA_TAG_POISON;
+	if (qc->tf.protocol == ATA_PROT_NCQ)
+		ap->sactive &= ~(1 << qc->tag);
+	else
+		ap->active_tag = ATA_TAG_POISON;
 
 	/* atapi: mark qc as inactive to prevent the interrupt handler
 	 * from completing the command twice later, before the error handler
 	 * is called. (when rc != 0 and atapi request sense is needed)
 	 */
 	qc->flags &= ~ATA_QCFLAG_ACTIVE;
+	ap->qc_active &= ~(1 << qc->tag);
 
 	/* call completion callback */
 	qc->complete_fn(qc);
@@ -4348,6 +4361,55 @@ void ata_qc_complete(struct ata_queued_c
 	}
 }
 
+/**
+ *	ata_qc_complete_multiple - Complete multiple qcs successfully
+ *	@ap: port in question
+ *	@qc_active: new qc_active mask
+ *	@finish_qc: LLDD callback invoked before completing a qc
+ *
+ *	Complete in-flight commands.  This functions is meant to be
+ *	called from low-level driver's interrupt routine to complete
+ *	requests normally.  ap->qc_active and @qc_active is compared
+ *	and commands are completed accordingly.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ *
+ *	RETURNS:
+ *	Number of completed commands on success, -errno otherwise.
+ */
+int ata_qc_complete_multiple(struct ata_port *ap, u32 qc_active,
+			     void (*finish_qc)(struct ata_queued_cmd *))
+{
+	int nr_done = 0;
+	u32 done_mask;
+	int i;
+
+	done_mask = ap->qc_active ^ qc_active;
+
+	if (unlikely(done_mask & qc_active)) {
+		ata_port_printk(ap, KERN_ERR, "illegal qc_active transition "
+				"(%08x->%08x)\n", ap->qc_active, qc_active);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < ATA_MAX_QUEUE; i++) {
+		struct ata_queued_cmd *qc;
+
+		if (!(done_mask & (1 << i)))
+			continue;
+
+		if ((qc = ata_qc_from_tag(ap, i))) {
+			if (finish_qc)
+				finish_qc(qc);
+			ata_qc_complete(qc);
+			nr_done++;
+		}
+	}
+
+	return nr_done;
+}
+
 static inline int ata_should_dma_map(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
@@ -4387,8 +4449,22 @@ void ata_qc_issue(struct ata_queued_cmd 
 {
 	struct ata_port *ap = qc->ap;
 
-	qc->ap->active_tag = qc->tag;
+	/* Make sure only one non-NCQ command is outstanding.  The
+	 * check is skipped for old EH because it reuses active qc to
+	 * request ATAPI sense.
+	 */
+	WARN_ON(ap->ops->error_handler && ata_tag_valid(ap->active_tag));
+
+	if (qc->tf.protocol == ATA_PROT_NCQ) {
+		WARN_ON(ap->sactive & (1 << qc->tag));
+		ap->sactive |= 1 << qc->tag;
+	} else {
+		WARN_ON(ap->sactive);
+		ap->active_tag = qc->tag;
+	}
+
 	qc->flags |= ATA_QCFLAG_ACTIVE;
+	ap->qc_active |= 1 << qc->tag;
 
 	if (ata_should_dma_map(qc)) {
 		if (qc->flags & ATA_QCFLAG_SG) {
@@ -5549,6 +5625,7 @@ EXPORT_SYMBOL_GPL(ata_host_set_remove);
 EXPORT_SYMBOL_GPL(ata_sg_init);
 EXPORT_SYMBOL_GPL(ata_sg_init_one);
 EXPORT_SYMBOL_GPL(ata_qc_complete);
+EXPORT_SYMBOL_GPL(ata_qc_complete_multiple);
 EXPORT_SYMBOL_GPL(ata_qc_issue_prot);
 EXPORT_SYMBOL_GPL(ata_tf_load);
 EXPORT_SYMBOL_GPL(ata_tf_read);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index ffb57fc..d059c75 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -478,7 +478,10 @@ struct ata_port {
 
 	struct ata_queued_cmd	qcmd[ATA_MAX_QUEUE];
 	unsigned long		qc_allocated;
+	unsigned int		qc_active;
+
 	unsigned int		active_tag;
+	u32			sactive;
 
 	struct ata_host_stats	stats;
 	struct ata_host_set	*host_set;
@@ -671,6 +674,8 @@ extern void ata_bmdma_drive_eh(struct at
 extern void ata_bmdma_error_handler(struct ata_port *ap);
 extern void ata_bmdma_post_internal_cmd(struct ata_queued_cmd *qc);
 extern void ata_qc_complete(struct ata_queued_cmd *qc);
+extern int ata_qc_complete_multiple(struct ata_port *ap, u32 qc_active,
+				    void (*finish_qc)(struct ata_queued_cmd *));
 extern void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd,
 			      void (*done)(struct scsi_cmnd *));
 extern int ata_std_bios_param(struct scsi_device *sdev,
-- 
1.2.4


