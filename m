From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/11] libata-eh-fw: implement new EH scheduling via error completion
Date: Thu, 11 May 2006 21:27:24 +0900
Message-ID: <11473504441373-git-send-email-htejun@gmail.com>
References: <11473504433328-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:33556 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751649AbWEKM1f (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 08:27:35 -0400
Received: by py-out-1112.google.com with SMTP id f28so218011pyf
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 05:27:35 -0700 (PDT)
In-Reply-To: <11473504433328-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

There are several ways a qc can get schedule for EH in new EH.  This
patch implements one of them - completing a qc with ATA_QCFLAG_FAILED
set or with non-zero qc->err_mask.  ALL such qc's are examined by EH.

New EH schedules a qc for EH from completion iff ->error_handler is
implemented, qc is marked as failed or qc->err_mask is non-zero and
the command is not an internal command (internal cmd is handled via
->post_internal_cmd).  The EH scheduling itself is performed by asking
SCSI midlayer to schedule EH for the specified scmd.

For drivers implementing old-EH, nothing changes.  As this change
makes ata_qc_complete() rather large, it's not inlined anymore and
__ata_qc_complete() is exported to other parts of libata for later
use.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   62 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/scsi/libata-eh.c   |   27 +++++++++++++++++++
 drivers/scsi/libata.h      |    2 +
 include/linux/libata.h     |   27 +------------------
 4 files changed, 91 insertions(+), 27 deletions(-)

8291f2fe1c4d682e630a4902424a6195b797ceca
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 76df36d..2b18033 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4122,6 +4122,66 @@ void __ata_qc_complete(struct ata_queued
 	qc->complete_fn(qc);
 }
 
+/**
+ *	ata_qc_complete - Complete an active ATA command
+ *	@qc: Command to complete
+ *	@err_mask: ATA Status register contents
+ *
+ *	Indicate to the mid and upper layers that an ATA
+ *	command has completed, with either an ok or not-ok status.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+void ata_qc_complete(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+
+	/* XXX: New EH and old EH use different mechanisms to
+	 * synchronize EH with regular execution path.
+	 *
+	 * In new EH, a failed qc is marked with ATA_QCFLAG_FAILED.
+	 * Normal execution path is responsible for not accessing a
+	 * failed qc.  libata core enforces the rule by returning NULL
+	 * from ata_qc_from_tag() for failed qcs.
+	 *
+	 * Old EH depends on ata_qc_complete() nullifying completion
+	 * requests if ATA_QCFLAG_EH_SCHEDULED is set.  Old EH does
+	 * not synchronize with interrupt handler.  Only PIO task is
+	 * taken care of.
+	 */
+	if (ap->ops->error_handler) {
+		WARN_ON(ap->flags & ATA_FLAG_FROZEN);
+
+		if (unlikely(qc->err_mask))
+			qc->flags |= ATA_QCFLAG_FAILED;
+
+		if (unlikely(qc->flags & ATA_QCFLAG_FAILED)) {
+			if (!ata_tag_internal(qc->tag)) {
+				/* always fill result TF for failed qc */
+				ap->ops->tf_read(ap, &qc->result_tf);
+				ata_qc_schedule_eh(qc);
+				return;
+			}
+		}
+
+		/* read result TF if requested */
+		if (qc->flags & ATA_QCFLAG_RESULT_TF)
+			ap->ops->tf_read(ap, &qc->result_tf);
+
+		__ata_qc_complete(qc);
+	} else {
+		if (qc->flags & ATA_QCFLAG_EH_SCHEDULED)
+			return;
+
+		/* read result TF if failed or requested */
+		if (qc->err_mask || qc->flags & ATA_QCFLAG_RESULT_TF)
+			ap->ops->tf_read(ap, &qc->result_tf);
+
+		__ata_qc_complete(qc);
+	}
+}
+
 static inline int ata_should_dma_map(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
@@ -5244,7 +5304,7 @@ EXPORT_SYMBOL_GPL(ata_device_add);
 EXPORT_SYMBOL_GPL(ata_host_set_remove);
 EXPORT_SYMBOL_GPL(ata_sg_init);
 EXPORT_SYMBOL_GPL(ata_sg_init_one);
-EXPORT_SYMBOL_GPL(__ata_qc_complete);
+EXPORT_SYMBOL_GPL(ata_qc_complete);
 EXPORT_SYMBOL_GPL(ata_qc_issue_prot);
 EXPORT_SYMBOL_GPL(ata_tf_load);
 EXPORT_SYMBOL_GPL(ata_tf_read);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 959a1cd..471846f 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -210,6 +210,33 @@ void ata_eng_timeout(struct ata_port *ap
 	DPRINTK("EXIT\n");
 }
 
+/**
+ *	ata_qc_schedule_eh - schedule qc for error handling
+ *	@qc: command to schedule error handling for
+ *
+ *	Schedule error handling for @qc.  EH will kick in as soon as
+ *	other commands are drained.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+void ata_qc_schedule_eh(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+
+	WARN_ON(!ap->ops->error_handler);
+
+	qc->flags |= ATA_QCFLAG_FAILED;
+	qc->ap->flags |= ATA_FLAG_EH_PENDING;
+
+	/* The following will fail if timeout has already expired.
+	 * ata_scsi_error() takes care of such scmds on EH entry.
+	 * Note that ATA_QCFLAG_FAILED is unconditionally set after
+	 * this function completes.
+	 */
+	scsi_req_abort_cmd(qc->scsicmd);
+}
+
 static void ata_eh_scsidone(struct scsi_cmnd *scmd)
 {
 	/* nada */
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index a810c91..1e81c37 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -57,6 +57,7 @@ extern int ata_do_reset(struct ata_port 
 			unsigned int *classes);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern void ata_qc_issue(struct ata_queued_cmd *qc);
+extern void __ata_qc_complete(struct ata_queued_cmd *qc);
 extern int ata_check_atapi_dma(struct ata_queued_cmd *qc);
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,
                            unsigned int wait, unsigned int can_sleep);
@@ -101,5 +102,6 @@ extern void ata_scsi_rbuf_fill(struct at
 /* libata-eh.c */
 extern enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd);
 extern void ata_scsi_error(struct Scsi_Host *host);
+extern void ata_qc_schedule_eh(struct ata_queued_cmd *qc);
 
 #endif /* __LIBATA_H__ */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3d6942a..fbabfb6 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -605,7 +605,7 @@ extern void ata_bmdma_start (struct ata_
 extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
 extern u8   ata_bmdma_status(struct ata_port *ap);
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
-extern void __ata_qc_complete(struct ata_queued_cmd *qc);
+extern void ata_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd,
 			      void (*done)(struct scsi_cmnd *));
 extern int ata_std_bios_param(struct scsi_device *sdev,
@@ -883,31 +883,6 @@ static inline void ata_qc_reinit(struct 
 }
 
 /**
- *	ata_qc_complete - Complete an active ATA command
- *	@qc: Command to complete
- *	@err_mask: ATA Status register contents
- *
- *	Indicate to the mid and upper layers that an ATA
- *	command has completed, with either an ok or not-ok status.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host_set lock)
- */
-static inline void ata_qc_complete(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-
-	if (unlikely(qc->flags & ATA_QCFLAG_EH_SCHEDULED))
-		return;
-
-	/* read result TF if failed or requested */
-	if (qc->err_mask || qc->flags & ATA_QCFLAG_RESULT_TF)
-		ap->ops->tf_read(ap, &qc->result_tf);
-
-	__ata_qc_complete(qc);
-}
-
-/**
  *	ata_irq_on - Enable interrupts on a port.
  *	@ap: Port on which interrupts are enabled.
  *
-- 
1.2.4


