From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:ncq 02/11] libata: implement new EH framework and convert non-ncq EH
Date: Thu,  7 Jul 2005 22:09:23 +0900 (KST)
Message-ID: <20050707130840.83C24844@htj.dyndns.org>
References: <20050707130840.5046338C@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.194]:50529 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261466AbVGGNJ2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jul 2005 09:09:28 -0400
Received: by wproxy.gmail.com with SMTP id i20so194432wra
        for <linux-ide@vger.kernel.org>; Thu, 07 Jul 2005 06:09:28 -0700 (PDT)
In-Reply-To: <20050707130840.5046338C@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, axboe@suse.de, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

02_libata_new-error-handling.patch

	This patch implements new EH framework and converts non-ncq EH
	to use it.  Now errors and timeouts are all handled by EH
	handler inside EH thread.

	* All failed commands are posted to EH by using ata_qc_error()
	  without qc-completion.  All timed out commands are posted to
	  EH, too.  On entry to EH handler, all active qc's are either
	  failed or timed out qc's, and they are all.  Also it's
	  guaranteed that once EH is started, only EH can finish or
	  retry it.  Normal or spurious interrupts during recovery
	  don't affect failed qc's.

	* EH handles error and determines whether to retry or fail
	  qc's.  It is responsible for setting error information to
	  notify upper layer if it's gonna fail a command.  (Jeff,
	  this should make implementing error classes you've talked
	  about easier.  All error handling is done inside EH and we
	  can just set sense data appropriately and eh-complete the
	  commands.)

	* After EH is complete, operation resumes.

	The following changes are worth noting.

	* ->eng_timeout renamed to ->error_handler

	* ata_eh_qc_complete(), ata_eh_qc_retry() added

	* __ata_qc_complete() used to deal with resource freeing and
	  completing wait for special cmds.  As this patch removes the
	  only use of __ata_qc_complete(), it's moved into
	  ata_qc_free() and ata_qc_free() deals only with resource
	  freeing.  New __ata_qc_complete() is defined to be used by
	  ata_eh_qc_*() functions (internal use only).

	* After allocated, all commands are either freed with
          ata_qc_free() if it can't be issued or completed with
          ata[_eh]_qc_complete().  No half-completion anymore.

	* As filling upper layer error info is the reponsibility of
	  the recovery handler now, qc->complete_fn() doesn't need
	  drv_stat argument.  Also, as all commands are completed
	  fully at once, there's no need for int return value.  This
	  leaves very little functionality to qc->complete_fn,
	  currently only ATAPI inquiry result tempering.  I think just
	  inlining that part and removing this callback will make the
	  code easier.

	* Although it looks like a lot of changes, from a device's
	  point of view, nothing changes.  Only software structure is
	  changed.

	This patch is separated out only to make changes incremental.
	I haven't really tested this patch alone.  Please test with
	the following NCQ EH patches applied.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/scsi/libata-core.c |  360 +++++++++++++++++++++++++++------------------
 drivers/scsi/libata-scsi.c |   92 +++++++----
 include/linux/libata.h     |   18 +-
 3 files changed, 290 insertions(+), 180 deletions(-)

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-07-07 22:08:35.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-07-07 22:08:35.000000000 +0900
@@ -69,9 +69,9 @@ MODULE_DESCRIPTION("Library module for A
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
-static int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat)
+static void ata_qc_complete_noop(struct ata_queued_cmd *qc)
 {
-	return 0;
+	/* noop */
 }
 
 static void ata_qc_exec_special_timeout(unsigned long data)
@@ -138,7 +138,7 @@ static int ata_qc_exec_special(struct at
 	if (tmout && !del_timer(&timer)) {
 		spin_lock_irq(&ap->host_set->lock);
 		if (qc->waiting == &wait) {
-			ata_qc_complete(qc, 0);
+			ata_qc_complete(qc);
 			rc = -ETIMEDOUT;
 		}
 		spin_unlock_irq(&ap->host_set->lock);
@@ -1428,6 +1428,52 @@ int ata_read_log_page(struct ata_port *a
 }
 
 /**
+ *	ata_eh_qc_complete - Complete an ATA command from EH
+ *	@qc: Command to complete
+ *	@drv_stat: ATA Status register contents
+ *	@drv_err: ATA Error register contents
+ *
+ *	This function is used in EH to complete commands.
+ *
+ *	HACK ALERT!  We cannot use the supplied completion function
+ *	from inside the ->eh_strategy_handler() thread.  libata is the
+ *	only user of ->eh_strategy_handler() in any kernel, so the
+ *	default scsi_done() assumes it is not being called from the
+ *	SCSI EH.
+ *
+ *	LOCKING:
+ *	None.  Called from EH.
+ */
+
+void ata_eh_qc_complete(struct ata_queued_cmd *qc)
+{
+	BUG_ON(!(qc->ap->flags & ATA_FLAG_RECOVERY));
+
+	qc->scsidone = scsi_finish_command;
+	__ata_qc_complete(qc);
+}
+
+/**
+ *	ata_eh_qc_retry - Retry an ATA command from EH.
+ *	@qc: Command to complete
+ *
+ *	This function is used in EH to complete commands.
+ *
+ *	HACK ALERT!  See ata_eh_qc_complete.
+ *
+ *	LOCKING:
+ *	None.  Called from EH.
+ */
+
+void ata_eh_qc_retry(struct ata_queued_cmd *qc)
+{
+	BUG_ON(!(qc->ap->flags & ATA_FLAG_RECOVERY));
+
+	qc->scsidone = (void *)scsi_retry_command;
+	__ata_qc_complete(qc);
+}
+
+/**
  *	ata_bus_probe - Reset and probe ATA bus
  *	@ap: Bus to probe
  *
@@ -2590,7 +2636,7 @@ static void ata_pio_complete (struct ata
 
 	ata_irq_on(ap);
 
-	ata_qc_complete(qc, drv_stat);
+	ata_qc_complete(qc);
 }
 
 
@@ -2815,7 +2861,10 @@ static void ata_pio_block(struct ata_por
 
 			ata_irq_on(ap);
 
-			ata_qc_complete(qc, status);
+			if (!(status & (ATA_ERR | ATA_DRQ)))
+				ata_qc_complete(qc);
+			else
+				ata_qc_error(qc);
 			return;
 		}
 
@@ -2847,7 +2896,7 @@ static void ata_pio_error(struct ata_por
 
 	ata_irq_on(ap);
 
-	ata_qc_complete(qc, drv_stat | ATA_ERR);
+	ata_qc_error(qc);
 }
 
 static void ata_pio_task(void *_data)
@@ -2913,6 +2962,7 @@ static void atapi_request_sense(struct a
 	qc->tf.lbam = (8 * 1024) & 0xff;
 	qc->tf.lbah = (8 * 1024) >> 8;
 	qc->nbytes = SCSI_SENSE_BUFFERSIZE;
+	qc->flags |= ATA_QCFLAG_PREEMPT;
 
 	rc = ata_qc_exec_special(qc, ATA_TMOUT_REQUEST_SENSE);
 	if (rc) {
@@ -2925,18 +2975,21 @@ static void atapi_request_sense(struct a
 		 */
 	}
 
+	cmd->result = SAM_STAT_CHECK_CONDITION;
+
 	DPRINTK("EXIT\n");
 }
 
 /**
- *	ata_qc_timeout - Handle timeout of queued command
- *	@qc: Command that timed out
+ *	ata_error_handler - Handle error or timeout of queued command
+ *	@ap: Port on which the command is active
  *
- *	Some part of the kernel (currently, only the SCSI layer)
- *	has noticed that the active command on port @ap has not
- *	completed after a specified length of time.  Handle this
- *	condition by disabling DMA (if necessary) and completing
- *	transactions, with error if necessary.
+ *	The driver reported error or some part of the kernel
+ *	(currently, only the SCSI layer) has noticed that the active
+ *	command on port @ap has not completed after a specified length
+ *	of time.  Handle this condition by disabling DMA (if
+ *	necessary) and completing transactions, with error if
+ *	necessary.
  *
  *	This also handles the case of the "lost interrupt", where
  *	for some reason (possibly hardware bug, possibly driver bug)
@@ -2947,102 +3000,63 @@ static void atapi_request_sense(struct a
  *	Inherited from SCSI layer (none, can sleep)
  */
 
-static void ata_qc_timeout(struct ata_queued_cmd *qc)
+void ata_error_handler(struct ata_port *ap)
 {
-	struct ata_port *ap = qc->ap;
-	struct ata_device *dev = qc->dev;
+	struct ata_queued_cmd *qc;
 	u8 host_stat = 0, drv_stat;
 
 	DPRINTK("ENTER\n");
 
-	/* FIXME: doesn't this conflict with timeout handling? */
-	if (qc->dev->class == ATA_DEV_ATAPI && qc->scsicmd) {
-		struct scsi_cmnd *cmd = qc->scsicmd;
-
-		if (!scsi_eh_eflags_chk(cmd, SCSI_EH_CANCEL_CMD)) {
-
-			/* finish completing original command */
-			__ata_qc_complete(qc);
-
-			atapi_request_sense(ap, dev, cmd);
-
-			cmd->result = (CHECK_CONDITION << 1) | (DID_OK << 16);
-			scsi_finish_command(cmd);
-
-			goto out;
-		}
+	qc = ata_qc_from_tag(ap, ap->active_tag);
+	if (!qc) {
+		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
+		       ap->id);
+		goto out;
 	}
 
-	/* hack alert!  We cannot use the supplied completion
-	 * function from inside the ->eh_strategy_handler() thread.
-	 * libata is the only user of ->eh_strategy_handler() in
-	 * any kernel, so the default scsi_done() assumes it is
-	 * not being called from the SCSI EH.
-	 */
-	qc->scsidone = scsi_finish_command;
-
-	switch (qc->tf.protocol) {
-
-	case ATA_PROT_DMA:
-	case ATA_PROT_ATAPI_DMA:
-		host_stat = ap->ops->bmdma_status(ap);
-
-		/* before we do anything else, clear DMA-Start bit */
-		ap->ops->bmdma_stop(ap);
-
-		/* fall through */
-
-	default:
-		ata_altstatus(ap);
+	if (qc->flags & ATA_QCFLAG_ERROR)
 		drv_stat = ata_chk_status(ap);
+	else {
+		/*
+		 * Okay, command has timed out.  Currently all we do
+		 * is stopping the dma engine.  Maybe performing
+		 * ->phy_reset is useful to make the device online
+		 * again.  However, this was all that the original
+		 * code did, so, for now, leave it as it is.
+		 */
+		switch (qc->tf.protocol) {
 
-		/* ack bmdma irq events */
-		ap->ops->irq_clear(ap);
+		case ATA_PROT_DMA:
+		case ATA_PROT_ATAPI_DMA:
+			host_stat = ap->ops->bmdma_status(ap);
 
-		printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x host_stat 0x%x\n",
-		       ap->id, qc->tf.command, drv_stat, host_stat);
+			/* before we do anything else, clear DMA-Start bit */
+			ap->ops->bmdma_stop(ap);
 
-		/* complete taskfile transaction */
-		ata_qc_complete(qc, drv_stat);
-		break;
-	}
-out:
-	DPRINTK("EXIT\n");
-}
+			/* fall through */
 
-/**
- *	ata_eng_timeout - Handle timeout of queued command
- *	@ap: Port on which timed-out command is active
- *
- *	Some part of the kernel (currently, only the SCSI layer)
- *	has noticed that the active command on port @ap has not
- *	completed after a specified length of time.  Handle this
- *	condition by disabling DMA (if necessary) and completing
- *	transactions, with error if necessary.
- *
- *	This also handles the case of the "lost interrupt", where
- *	for some reason (possibly hardware bug, possibly driver bug)
- *	an interrupt was not delivered to the driver, even though the
- *	transaction completed successfully.
- *
- *	LOCKING:
- *	Inherited from SCSI layer (none, can sleep)
- */
+		default:
+			ata_altstatus(ap);
+			drv_stat = ata_chk_status(ap);
 
-void ata_eng_timeout(struct ata_port *ap)
-{
-	struct ata_queued_cmd *qc;
+			/* ack bmdma irq events */
+			ap->ops->irq_clear(ap);
 
-	DPRINTK("ENTER\n");
+			printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x host_stat 0x%x\n",
+			       ap->id, qc->tf.command, drv_stat, host_stat);
+			break;
+		}
+	}
 
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-	if (!qc) {
-		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
-		       ap->id);
-		goto out;
+	if (qc->scsicmd) {
+		if (qc->dev->class == ATA_DEV_ATA ||
+		    !(qc->flags & ATA_QCFLAG_ERROR))
+			ata_to_sense_error(qc, drv_stat);
+		else
+			atapi_request_sense(ap, qc->dev, qc->scsicmd);
 	}
 
-	ata_qc_timeout(qc);
+	ata_eh_qc_complete(qc);
 
 out:
 	DPRINTK("EXIT\n");
@@ -3106,10 +3120,24 @@ struct ata_queued_cmd *ata_qc_new_init(s
 	return qc;
 }
 
-static void __ata_qc_complete(struct ata_queued_cmd *qc)
+/**
+ *	ata_qc_free - free unused ata_queued_cmd
+ *	@qc: Command to complete
+ *
+ *	Designed to free unused ata_queued_cmd object
+ *	in case something prevents using it.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ *
+ */
+
+void ata_qc_free(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	unsigned int tag, do_clear = 0;
+	unsigned int tag = qc->tag;
+
+	assert(ata_tag_valid(qc->tag));
 
 	if (likely(qc->flags & ATA_QCFLAG_ACTIVE)) {
 		assert(ap->queue_depth);
@@ -3117,84 +3145,111 @@ static void __ata_qc_complete(struct ata
 
 		if (!ap->queue_depth)
 			ap->flags &= ~ATA_FLAG_NCQ_QUEUED;
+		if (tag == ap->active_tag) {
+			ap->active_tag = ap->preempted_tag;
+			ap->preempted_tag = ATA_TAG_POISON;
+		}
 	}
 
 	qc->flags = 0;
-	tag = qc->tag;
-	if (likely(ata_tag_valid(tag))) {
-		if (tag == ap->active_tag)
-			ap->active_tag = ATA_TAG_POISON;
-		qc->tag = ATA_TAG_POISON;
-		do_clear = 1;
-	}
+	qc->tag = ATA_TAG_POISON;
 
-	if (qc->waiting) {
-		struct completion *waiting = qc->waiting;
-		qc->waiting = NULL;
-		complete(waiting);
-	}
-
-	if (likely(do_clear))
-		clear_bit(tag, &ap->qactive);
+	clear_bit(tag, &ap->qactive);
 	if (ap->cmd_waiters)
 		wake_up(&ap->cmd_wait_queue);
 }
 
+static void __ata_qc_complete(struct ata_queued_cmd *qc)
+{
+	struct completion *waiting = qc->waiting;
+
+	assert(qc != NULL);	/* ata_qc_from_tag _might_ return NULL */
+	assert(qc->flags & ATA_QCFLAG_ACTIVE);
+
+	if (likely(qc->flags & ATA_QCFLAG_DMAMAP))
+		ata_sg_clean(qc);
+
+	/* call completion callback */
+	qc->complete_fn(qc);
+	/* for special cmd timeout synchronization */
+	qc->waiting = NULL;
+
+	ata_qc_free(qc);
+
+	if (waiting)
+		complete(waiting);
+
+	VPRINTK("EXIT\n");
+}
+
 /**
- *	ata_qc_free - free unused ata_queued_cmd
+ *	ata_qc_complete - Complete an active ATA command
  *	@qc: Command to complete
  *
- *	Designed to free unused ata_queued_cmd object
- *	in case something prevents using it.
+ *	Indicate to the mid and upper layers that an ATA
+ *	command has completed, with either an ok or not-ok status.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  *
  */
-void ata_qc_free(struct ata_queued_cmd *qc)
+void ata_qc_complete(struct ata_queued_cmd *qc)
 {
-	assert(qc != NULL);	/* ata_qc_from_tag _might_ return NULL */
-	assert(qc->waiting == NULL);	/* nothing should be waiting */
+	if (unlikely((qc->flags & ATA_QCFLAG_ERROR ||
+		      qc->ap->flags & ATA_FLAG_RECOVERY) &&
+		     !(qc->flags & ATA_QCFLAG_PREEMPT))) {
+		printk(KERN_WARNING "ata%u: ignoring command completion for "
+		       "tag %u during recovery\n", qc->ap->id, qc->tag);
+		return;
+	}
 
 	__ata_qc_complete(qc);
 }
 
 /**
- *	ata_qc_complete - Complete an active ATA command
- *	@qc: Command to complete
- *	@drv_stat: ATA Status register contents
+ *	ata_qc_error - Invoke error handler
+ *	@qc: Command which failed
  *
- *	Indicate to the mid and upper layers that an ATA
- *	command has completed, with either an ok or not-ok status.
+ *	Invoke EH for a failed qc.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  *
  */
 
-void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
+void ata_qc_error(struct ata_queued_cmd *qc)
 {
-	int rc;
-
-	assert(qc != NULL);	/* ata_qc_from_tag _might_ return NULL */
-	assert(qc->flags & ATA_QCFLAG_ACTIVE);
-
-	if (likely(qc->flags & ATA_QCFLAG_DMAMAP))
-		ata_sg_clean(qc);
-
-	/* call completion callback */
-	rc = qc->complete_fn(qc, drv_stat);
-
-	/* if callback indicates not to complete command (non-zero),
-	 * return immediately
-	 */
-	if (unlikely(rc != 0))
+	if (unlikely((qc->flags & ATA_QCFLAG_ERROR ||
+		      qc->ap->flags & ATA_FLAG_RECOVERY) &&
+		     !(qc->flags & ATA_QCFLAG_PREEMPT))) {
+		printk(KERN_WARNING "ata%u: ignoring command error for "
+		       "tag %u during recovery\n", qc->ap->id, qc->tag);
 		return;
+	}
 
-	__ata_qc_complete(qc);
-	qc->flags &= ~ATA_QCFLAG_ACTIVE;
+	if (qc->scsicmd) {
+		/*
+		 *  SCSI command.  Invoke SCSI EH
+		 */
+		printk(KERN_WARNING "ata%u: requesting check condition for "
+		       "failed scmd %p tag %u\n",
+		       qc->ap->id, qc->scsicmd, qc->tag);
 
-	VPRINTK("EXIT\n");
+		qc->flags |= ATA_QCFLAG_ERROR;
+		qc->ap->flags |= ATA_FLAG_ERROR;
+
+		qc->scsicmd->result = SAM_STAT_CHECK_CONDITION;
+		qc->scsidone(qc->scsicmd);
+	} else {
+		/*
+		 * libata internal command.  No tender and kind error
+		 * handling yet.  Just finish'em.
+		 */
+		printk(KERN_WARNING "ata%u: finishing internal command tag %u "
+		       "with error\n", qc->ap->id, qc->tag);
+		BUG_ON(qc->flags & ATA_QCFLAG_NCQ);
+		ata_qc_complete(qc);
+	}
 }
 
 static inline int ata_should_dma_map(struct ata_queued_cmd *qc)
@@ -3231,6 +3286,14 @@ static inline int ata_qc_issue_ok(struct
 {
 	if (qc->flags & ATA_QCFLAG_PREEMPT)
 		return 1;
+
+	/*
+	 * If error handling is in progress, only preempt commands are
+	 * allowed.
+	 */
+	if (qc->ap->flags & (ATA_FLAG_ERROR | ATA_FLAG_RECOVERY))
+		return 0;
+
 	/*
 	 * if people are already waiting for a queue drain, don't allow a
 	 * new 'lucky' queuer to get in there
@@ -3336,6 +3399,13 @@ int ata_qc_issue(struct ata_queued_cmd *
 	qc->ap->active_tag = qc->tag;
 	qc->flags |= ATA_QCFLAG_ACTIVE;
 
+	assert(ap->preempted_tag == ATA_TAG_POISON);
+
+	if (qc->flags & ATA_QCFLAG_PREEMPT) {
+		ap->preempted_tag = ap->active_tag;
+		ap->active_tag = qc->tag;
+	}
+
 	if (qc->flags & ATA_QCFLAG_NCQ)
 		ap->flags |= ATA_FLAG_NCQ_QUEUED;
 
@@ -3707,7 +3777,10 @@ inline unsigned int ata_host_intr (struc
 		ap->ops->irq_clear(ap);
 
 		/* complete taskfile transaction */
-		ata_qc_complete(qc, status);
+		if (!(status & (ATA_ERR | ATA_DRQ)))
+			ata_qc_complete(qc);
+		else
+			ata_qc_error(qc);
 		break;
 
 	default:
@@ -3832,7 +3905,7 @@ static void atapi_packet_task(void *_dat
 	return;
 
 err_out:
-	ata_qc_complete(qc, ATA_ERR);
+	ata_qc_error(qc);
 }
 
 
@@ -3952,6 +4025,7 @@ static void ata_host_init(struct ata_por
 	ap->ops = ent->port_ops;
 	ap->cbl = ATA_CBL_NONE;
 	ap->active_tag = ATA_TAG_POISON;
+	ap->preempted_tag = ATA_TAG_POISON;
 	init_waitqueue_head(&ap->cmd_wait_queue);
 	ap->cmd_waiters = 0;
 	ap->last_ctl = 0xFF;
@@ -4590,7 +4664,7 @@ EXPORT_SYMBOL_GPL(ata_sg_init);
 EXPORT_SYMBOL_GPL(ata_sg_init_one);
 EXPORT_SYMBOL_GPL(ata_qc_complete);
 EXPORT_SYMBOL_GPL(ata_qc_issue_prot);
-EXPORT_SYMBOL_GPL(ata_eng_timeout);
+EXPORT_SYMBOL_GPL(ata_error_handler);
 EXPORT_SYMBOL_GPL(ata_tf_load);
 EXPORT_SYMBOL_GPL(ata_tf_read);
 EXPORT_SYMBOL_GPL(ata_noop_dev_select);
@@ -4630,6 +4704,8 @@ EXPORT_SYMBOL_GPL(ata_scsi_block_request
 EXPORT_SYMBOL_GPL(ata_scsi_unblock_requests);
 EXPORT_SYMBOL_GPL(ata_scsi_requeue);
 EXPORT_SYMBOL_GPL(ata_read_log_page);
+EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
+EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
 
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL_GPL(pci_test_config_bits);
Index: work/drivers/scsi/libata-scsi.c
===================================================================
--- work.orig/drivers/scsi/libata-scsi.c	2005-07-07 22:08:35.000000000 +0900
+++ work/drivers/scsi/libata-scsi.c	2005-07-07 22:08:35.000000000 +0900
@@ -160,6 +160,8 @@ struct ata_queued_cmd *ata_scsi_qc_new(s
 	/*
 	 * check if we need to defer this command
 	 */
+	if (ap->flags & (ATA_FLAG_ERROR | ATA_FLAG_RECOVERY))
+		return NULL;
 	if (ap->cmd_waiters)
 		return NULL;
 	if (ap->queue_depth) {
@@ -434,7 +436,7 @@ void ata_scsi_requeue(struct ata_queued_
 
 		ata_qc_free(qc);
 	} else
-		ata_qc_complete(qc, ATA_ERR);
+		ata_qc_complete(qc);
 }
 
 void ata_scsi_block_requests(struct ata_port *ap)
@@ -469,18 +471,61 @@ void ata_scsi_unblock_requests(struct at
 int ata_scsi_error(struct Scsi_Host *host)
 {
 	struct ata_port *ap = (struct ata_port *) &host->hostdata[0];
+	LIST_HEAD(cmds);
+	struct ata_queued_cmd *qc;
+	struct scsi_cmnd *scmd, *tmp;
+	unsigned tag;
+	int todo = 0;
+
+	printk(KERN_WARNING "ata%u: recovering from %s\n",
+	       ap->id, ap->flags & ATA_FLAG_ERROR ? "error" : "timeout");
+
+	spin_lock_irq(&ap->host_set->lock);
+	assert(!(ap->flags & ATA_FLAG_RECOVERY));
+	list_splice_init(&ap->host->eh_cmd_q, &cmds);
 
-	DPRINTK("ENTER\n");
+	/*
+	 * First, sort out commands which need error handling from
+	 * those that can be finished right away.
+	 */
+	for (tag = 0; tag < ATA_MAX_CMDS; tag++) {
+		if (!(qc = ata_qc_from_tag(ap, tag)) ||
+		    !(qc->flags & ATA_QCFLAG_ACTIVE) || !(scmd = qc->scsicmd))
+			continue;
+		assert(!list_empty(&scmd->eh_entry));
+		list_del_init(&scmd->eh_entry);
+		todo++;
+	}
 
-	ap->ops->eng_timeout(ap);
+	ap->flags |= ATA_FLAG_RECOVERY;
+	spin_unlock_irq(&ap->host_set->lock);
 
-	/* TODO: this is per-command; when queueing is supported
-	 * this code will either change or move to a more
-	 * appropriate place
+	/*
+	 * These scmds don't have corresponding qc's, which means that
+	 * the scmds had timed out but the qc completed successfully
+	 * inbetween timer expiration and here.  Just finish them
+	 * normally.
 	 */
-	host->host_failed--;
+	list_for_each_entry_safe(scmd, tmp, &cmds, eh_entry) {
+		printk(KERN_WARNING "ata%u: interrupt and timer raced for "
+		       "scsicmd %p\n", ap->id, scmd);
+		scmd->result = SAM_STAT_GOOD;
+		scsi_finish_command(scmd);
+	}
+
+	if (todo)
+		ap->ops->error_handler(ap);
+
+	spin_lock_irq(&ap->host_set->lock);
+	assert(!ap->queue_depth && !ap->host->host_busy);
+	host->host_failed = 0;
+	ap->flags &= ~(ATA_FLAG_ERROR | ATA_FLAG_RECOVERY);
+	if (ap->cmd_waiters)
+		wake_up(&ap->cmd_wait_queue);
+	spin_unlock_irq(&ap->host_set->lock);
+
+	printk(KERN_WARNING "ata%u: recovery complete\n", ap->id);
 
-	DPRINTK("EXIT\n");
 	return 0;
 }
 
@@ -753,18 +798,9 @@ static unsigned int ata_scsi_rw_xlat(str
 	return 1;
 }
 
-static int ata_scsi_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
+static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 {
-	struct scsi_cmnd *cmd = qc->scsicmd;
-
-	if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ)))
-		ata_to_sense_error(qc, drv_stat);
-	else
-		cmd->result = SAM_STAT_GOOD;
-
-	qc->scsidone(cmd);
-
-	return 0;
+	qc->scsidone(qc->scsicmd);
 }
 
 /**
@@ -1391,19 +1427,11 @@ void ata_scsi_badcmd(struct scsi_cmnd *c
 	done(cmd);
 }
 
-static int atapi_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
+static void atapi_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 
-	if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ))) {
-		DPRINTK("request check condition\n");
-
-		cmd->result = SAM_STAT_CHECK_CONDITION;
-
-		qc->scsidone(cmd);
-
-		return 1;
-	} else {
+	if (cmd->result == SAM_STAT_GOOD) {
 		u8 *scsicmd = cmd->cmnd;
 
 		if (scsicmd[0] == INQUIRY) {
@@ -1415,13 +1443,11 @@ static int atapi_qc_complete(struct ata_
 			buf[3] = (buf[3] & 0xf0) | 2;
 			ata_scsi_rbuf_put(cmd, buf);
 		}
-		cmd->result = SAM_STAT_GOOD;
 	}
 
 	qc->scsidone(cmd);
-
-	return 0;
 }
+
 /**
  *	atapi_xlat - Initialize PACKET taskfile
  *	@qc: command structure to be initialized
@@ -1618,6 +1644,8 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
 
 	ata_scsi_dump_cdb(ap, cmd);
 
+	cmd->result = SAM_STAT_GOOD;
+
 	dev = ata_scsi_find_dev(ap, scsidev);
 	if (unlikely(!dev)) {
 		cmd->result = (DID_BAD_TARGET << 16);
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h	2005-07-07 22:08:35.000000000 +0900
+++ work/include/linux/libata.h	2005-07-07 22:08:35.000000000 +0900
@@ -117,13 +117,16 @@ enum {
 	ATA_FLAG_PIO_DMA	= (1 << 8), /* PIO cmds via DMA */
 	ATA_FLAG_NCQ		= (1 << 9), /* Can do NCQ */
 	ATA_FLAG_NCQ_QUEUED	= (1 << 10), /* NCQ commands are queued */
+	ATA_FLAG_ERROR		= (1 << 11), /* Error met and EH scheduled */
+	ATA_FLAG_RECOVERY	= (1 << 12), /* Recovery in progress */
 
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
 	ATA_QCFLAG_SINGLE	= (1 << 4), /* no s/g, just a single buffer */
 	ATA_QCFLAG_DMAMAP	= ATA_QCFLAG_SG | ATA_QCFLAG_SINGLE,
 	ATA_QCFLAG_NCQ		= (1 << 5), /* using NCQ */
-	ATA_QCFLAG_PREEMPT	= (1 << 6), /* for error handling */
+	ATA_QCFLAG_ERROR	= (1 << 6), /* this qc has failed w/ error */
+	ATA_QCFLAG_PREEMPT	= (1 << 7), /* for error handling */
 
 	ATA_QC_ISSUE_OK		= 0,
 	ATA_QC_ISSUE_FATAL	= -1,
@@ -184,7 +187,7 @@ struct ata_port;
 struct ata_queued_cmd;
 
 /* typedefs */
-typedef int (*ata_qc_cb_t) (struct ata_queued_cmd *qc, u8 drv_stat);
+typedef void (*ata_qc_cb_t) (struct ata_queued_cmd *qc);
 
 struct ata_ioports {
 	unsigned long		cmd_addr;
@@ -321,7 +324,7 @@ struct ata_port {
 
 	struct ata_queued_cmd	qcmd[ATA_MAX_CMDS];
 	unsigned long		qactive;
-	unsigned int		active_tag;
+	unsigned int		active_tag, preempted_tag;
 	unsigned int		queue_depth;
 
 	wait_queue_head_t	cmd_wait_queue;
@@ -367,7 +370,7 @@ struct ata_port_operations {
 	void (*qc_prep) (struct ata_queued_cmd *qc);
 	int (*qc_issue) (struct ata_queued_cmd *qc);
 
-	void (*eng_timeout) (struct ata_port *ap);
+	void (*error_handler) (struct ata_port *ap);
 
 	irqreturn_t (*irq_handler)(int, void *, struct pt_regs *);
 	void (*irq_clear) (struct ata_port *);
@@ -444,8 +447,9 @@ extern void ata_bmdma_start (struct ata_
 extern void ata_bmdma_stop(struct ata_port *ap);
 extern u8   ata_bmdma_status(struct ata_port *ap);
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
-extern void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat);
-extern void ata_eng_timeout(struct ata_port *ap);
+extern void ata_qc_complete(struct ata_queued_cmd *qc);
+extern void ata_qc_error(struct ata_queued_cmd *qc);
+extern void ata_error_handler(struct ata_port *ap);
 extern void ata_scsi_simulate(u16 *id, struct scsi_cmnd *cmd,
 			      void (*done)(struct scsi_cmnd *));
 extern int ata_std_bios_param(struct scsi_device *sdev,
@@ -458,6 +462,8 @@ extern void ata_scsi_unblock_requests(st
 extern void ata_scsi_requeue(struct ata_queued_cmd *);
 extern int ata_read_log_page(struct ata_port *, unsigned int, char, char *,
 			     unsigned int);
+extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
+extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
 
 
 #ifdef CONFIG_PCI

