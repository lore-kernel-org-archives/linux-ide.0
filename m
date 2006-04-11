From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/16] libata-eh-fw: implement new EH scheduling via error completion
Date: Tue, 11 Apr 2006 22:42:54 +0900
Message-ID: <1144762974424-git-send-email-htejun@gmail.com>
References: <11447629733305-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.183]:9317 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750895AbWDKNnA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:43:00 -0400
Received: by pproxy.gmail.com with SMTP id i49so1385350pye
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:43:00 -0700 (PDT)
In-Reply-To: <11447629733305-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

There are several ways a qc can get schedule for EH in new EH.  This
patch implements one of them - completing qc with non-zero
qc->err_mask.  ALL normal qc's with set err_mask are to be examined by
EH.  There's no sideway.

New EH schedules a qc for EH from completion iff ->error_handler is
implemented, qc->err_mask is non-zero and the command is not an
internal command (internal cmd is handled via ->post_internal_cmd).
The EH scheduling itself is performed by asking SCSI midlayer to
schedule EH for the specified scmd.

Note that in the new EH, there is no way a qc can hit
ata_qc_complete() twice or normal path completes a qc which has been
scheduled for EH by other entities.  The ownership is clear and must
be followed.  Violation will trigger WARN_ON().

For drivers implementing old-EH, nothing changes.  As this change
makes ata_qc_complete() rather large, it's not inlined anymore and
__ata_qc_complete() is exported to other parts of libata for later
use.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   52 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/scsi/libata-eh.c   |   29 +++++++++++++++++++++++++
 drivers/scsi/libata.h      |    2 ++
 include/linux/libata.h     |   21 +-----------------
 4 files changed, 83 insertions(+), 21 deletions(-)

62f9790537d3ea763d911e48f23e66bf21d7e445
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index f019d5d..2a5d3f6 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4192,6 +4192,56 @@ void __ata_qc_complete(struct ata_queued
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
+	 * When a qc fails, it's marked with EH_SCHEDULED.  In new EH,
+	 * regular execution path is responsible for not accessing a
+	 * failed qc.  libata core enforces the rule by returning NULL
+	 * from ata_qc_from_tag() for failed qcs.
+	 *
+	 * Old EH depends on ata_qc_complete() nullifying completion
+	 * requests if EH_SCHEDULED is set.  Old EH does not
+	 * synchronize with interrupt handler.  Only PIO task is taken
+	 * care of.
+	 */
+	if (ap->ops->error_handler) {
+		WARN_ON(qc->flags & ATA_QCFLAG_EH_SCHEDULED ||
+			ap->flags & ATA_FLAG_FROZEN);
+
+		if (unlikely(qc->err_mask)) {
+			/* ATA_QCFLAG_FAILED is set for all failed
+			 * qc's including internal qc.
+			 */
+			qc->flags |= ATA_QCFLAG_FAILED;
+			if (!ata_tag_internal(qc->tag)) {
+				ata_eh_schedule_qc(qc);
+				return;
+			}
+		}
+		__ata_qc_complete(qc);
+	} else {
+		if (qc->flags & ATA_QCFLAG_EH_SCHEDULED)
+			return;
+		__ata_qc_complete(qc);
+	}
+}
+
 static inline int ata_should_dma_map(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
@@ -5177,7 +5227,7 @@ EXPORT_SYMBOL_GPL(ata_device_add);
 EXPORT_SYMBOL_GPL(ata_host_set_remove);
 EXPORT_SYMBOL_GPL(ata_sg_init);
 EXPORT_SYMBOL_GPL(ata_sg_init_one);
-EXPORT_SYMBOL_GPL(__ata_qc_complete);
+EXPORT_SYMBOL_GPL(ata_qc_complete);
 EXPORT_SYMBOL_GPL(ata_qc_issue_prot);
 EXPORT_SYMBOL_GPL(ata_tf_load);
 EXPORT_SYMBOL_GPL(ata_tf_read);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index e73f561..a1fe14f 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -210,6 +210,35 @@ void ata_eng_timeout(struct ata_port *ap
 	DPRINTK("EXIT\n");
 }
 
+/**
+ *	ata_eh_schedule_qc - schedule qc for error handling
+ *	@qc: command to schedule error handling for
+ *
+ *	Schedule error handling for the specified qc.  EH will kick in
+ *	as soon as other commands are drained.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+void ata_eh_schedule_qc(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+
+	WARN_ON(!ap->ops->error_handler);
+	WARN_ON(qc->flags & ATA_QCFLAG_EH_SCHEDULED ||
+		ap->flags & ATA_FLAG_FROZEN);
+
+	qc->flags |= ATA_QCFLAG_FAILED | ATA_QCFLAG_EH_SCHEDULED;
+	qc->dev->flags |= ATA_DFLAG_FAILED;
+
+	/* The following will fail if timeout has already expired.
+	 * ata_scsi_timed_out() will put @qc onto EH.  Note that
+	 * EH_SCHEDULED flag is unconditionally set after this
+	 * function completes.
+	 */
+	scsi_eh_schedule_cmd(qc->scsicmd);
+}
+
 static void ata_eh_scsidone(struct scsi_cmnd *scmd)
 {
 	/* nada */
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index 3fd31f9..b522aaa 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -61,6 +61,7 @@ extern int ata_do_reset(struct ata_port 
 			ata_postreset_fn_t postreset, unsigned int *classes);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern void ata_qc_issue(struct ata_queued_cmd *qc);
+extern void __ata_qc_complete(struct ata_queued_cmd *qc);
 extern int ata_check_atapi_dma(struct ata_queued_cmd *qc);
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,
                            unsigned int wait, unsigned int can_sleep);
@@ -104,5 +105,6 @@ extern void ata_scsi_rbuf_fill(struct at
 
 /* libata-eh.c */
 extern enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd);
+extern void ata_eh_schedule_qc(struct ata_queued_cmd *qc);
 
 #endif /* __LIBATA_H__ */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e059cd3..8aeead3 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -593,7 +593,7 @@ extern void ata_bmdma_start (struct ata_
 extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
 extern u8   ata_bmdma_status(struct ata_port *ap);
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
-extern void __ata_qc_complete(struct ata_queued_cmd *qc);
+extern void ata_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_scsi_simulate(struct ata_port *ap, struct ata_device *dev,
 			      struct scsi_cmnd *cmd,
 			      void (*done)(struct scsi_cmnd *));
@@ -859,25 +859,6 @@ static inline void ata_qc_reinit(struct 
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
-	if (unlikely(qc->flags & ATA_QCFLAG_EH_SCHEDULED))
-		return;
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


