From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata total system lockup fix
Date: Fri, 5 Aug 2005 13:01:05 +0900
Message-ID: <20050805040105.GA18466@htj.dyndns.org>
References: <42E4ED70.1050501@pobox.com> <42E4FC75.70006@pobox.com> <42E50AE9.3000207@rtr.ca> <42F2E267.50402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.200]:22710 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262845AbVHEEBN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Aug 2005 00:01:13 -0400
Received: by zproxy.gmail.com with SMTP id i11so306676nzh
        for <linux-ide@vger.kernel.org>; Thu, 04 Aug 2005 21:01:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <42F2E267.50402@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <mlord@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, hare@suse.de

On Fri, Aug 05, 2005 at 12:52:07PM +0900, Tejun Heo wrote:
> Mark Lord wrote:
> > >The problem with this patch is that is causes leaks, and doesn't 
> >actually ready the devices because scsi_eh_ready_devs() is never called: 
> >scsi_eh_abort_cmds() is guaranteed to fail out every time its called.
> >
> >MMmm.. bummer if that's the case, but it does execute here
> >on my machine about once every two seconds, continuously,
> >for hours on end, and the DVD-RW drive still works when
> >I eventually do place a disc into it later on.
> >
> >I suppose the bug isn't seen more commonly because libata is
> >the only (?) SCSI LLD that supplies it's own eh strategy function.
> >Or are there other users of that interface now?
> >
> >I'm off on holiday for the next while, but I'll check in on this
> >again when I get back.  Perhaps the originator of this patch could
> >chip in with some of the fixes, if you point out where the "leaks" are.
> >
> > >Ahha.. here's the header from the original email for this patch
> > >Subject: [PATCH] Fix SATA ATAPI error handling
> > >From: Hannes Reinecke <hare@suse.de>
> > >Date: Wed, 23 Mar 2005 16:28:16 +0100
> > >To: SCSI Mailing List <linux-scsi@vger.kernel.org>
> > >CC: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
> > >Jens Axboe <axboe@suse.de>, Kurt Garloff <garloff@suse.de>:
> >
> 
>  Hello, Mark Lord.
> 
>  I think I've hit similar scsi-eh lockup problem during development of 
> new EH/NCQ helpers.  I currently don't remember where it exactly looped, 
> but I recall that scmds jumped back and forth between two lists, one of 
> which being eh_cmd_q which isn't cleared properly by SATA's strategy 
> routine.  Anyways, I'm attaching an one liner quick fix, which I'm not 
> sure if it will work or not.  Also, I'll post a combined patch of my new 
> EH/NCQ helpers in a separate mail, which, hopefully, should be free of 
> this issue.
> 

 And this is the combined patch against ncq head of libata-dev-2.6
tree.  Commit d032ec9048ff82a704b96b93cfd6f2e8e3a06b19.

 Only ata_piix, sata_sil and ahci are converted and all other SATA
drivers are broken.  So, enable only those three SATA drivers when
compiling with this patch.


Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-08-05 12:55:08.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-08-05 12:55:50.000000000 +0900
@@ -49,6 +49,10 @@
 
 #include "libata.h"
 
+#define ata_for_each_tag(tag, mask) \
+	for (tag = find_first_bit(&mask, ATA_MAX_CMDS); tag < ATA_MAX_CMDS; \
+	     tag = find_next_bit(&mask, ATA_MAX_CMDS, tag + 1))
+
 static unsigned int ata_busy_sleep (struct ata_port *ap,
 				    unsigned long tmout_pat,
 			    	    unsigned long tmout);
@@ -59,7 +63,6 @@ static int fgb(u32 bitmap);
 static int ata_choose_xfer_mode(struct ata_port *ap,
 				u8 *xfer_mode_out,
 				unsigned int *xfer_shift_out);
-static int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat);
 static void __ata_qc_complete(struct ata_queued_cmd *qc);
 
 static unsigned int ata_unique_id = 1;
@@ -70,6 +73,87 @@ MODULE_DESCRIPTION("Library module for A
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
+static void ata_qc_complete_noop(struct ata_queued_cmd *qc)
+{
+	/* noop */
+}
+
+static void ata_qc_exec_special_timeout(unsigned long data)
+{
+	struct completion *wait = (void *)data;
+	complete(wait);
+}
+
+/**
+ *	ata_qc_exec_special - execute libata internal special command
+ *	@qc: Command to execute
+ *	@tmout: timeout in jiffies
+ *
+ *	Executes libata internal command with timeout.  Timeout and
+ *	error conditions are reported via return value.  No recovery
+ *	action is taken after a command times out.  It's caller's duto
+ *	to clean up after timeout.
+ *
+ *	Also, note that error condition is checked after the qc is
+ *	completed, meaning that if another command is issued before
+ *	checking the condition, we get the wrong values.  As special
+ *	cmds are used only for initialization and recovery, this
+ *	won't cause any problem currently.
+ *
+ *	LOCKING:
+ *	None.  Should be called with kernel context, might sleep.
+ */
+
+static int ata_qc_exec_special(struct ata_queued_cmd *qc, unsigned long tmout)
+{
+	struct ata_port *ap = qc->ap;
+	DECLARE_COMPLETION(wait);
+	struct timer_list timer;
+	int rc;
+
+	might_sleep();
+
+	if (ata_busy_sleep(ap, ATA_TMOUT_SPECIAL_QUICK, ATA_TMOUT_SPECIAL))
+		return -ETIMEDOUT;
+
+	qc->complete_fn = ata_qc_complete_noop;
+	qc->waiting = &wait;
+
+	if (tmout) {
+		init_timer(&timer);
+		timer.function = ata_qc_exec_special_timeout;
+		timer.data = (unsigned long)&wait;
+		timer.expires = jiffies + tmout;
+		add_timer(&timer);
+	}
+
+	spin_lock_irq(&ap->host_set->lock);
+	rc = ata_qc_issue(qc);
+	spin_unlock_irq(&ap->host_set->lock);
+
+	if (rc) {
+		if (tmout)
+			del_timer(&timer);
+		return -EAGAIN;	/* any better value for issue failure? */
+	}
+
+	wait_for_completion(&wait);
+
+	if (tmout && !del_timer(&timer)) {
+		spin_lock_irq(&ap->host_set->lock);
+		if (qc->waiting == &wait) {
+			ata_qc_complete(qc);
+			rc = -ETIMEDOUT;
+		}
+		spin_unlock_irq(&ap->host_set->lock);
+	}
+
+	if (rc == 0 && !ata_ok(ata_chk_status(ap)))
+		rc = -EIO;
+
+	return rc;
+}
+
 /**
  *	ata_tf_load - send taskfile registers to host controller
  *	@ap: Port to which output is sent
@@ -1126,9 +1210,7 @@ static void ata_dev_identify(struct ata_
 	unsigned long xfer_modes;
 	u8 status;
 	unsigned int using_edd;
-	DECLARE_COMPLETION(wait);
 	struct ata_queued_cmd *qc;
-	unsigned long flags;
 	int rc;
 
 	if (!ata_dev_present(dev)) {
@@ -1166,20 +1248,19 @@ retry:
 		DPRINTK("do ATAPI identify\n");
 	}
 
-	qc->waiting = &wait;
-	qc->complete_fn = ata_qc_complete_noop;
+	rc = ata_qc_exec_special(qc, ATA_TMOUT_IDENTIFY);
 
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	rc = ata_qc_issue(qc);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	switch (rc) {
+	case 0:
+		break;
+	case -EIO:
+		/* Device failed the command */
+		status = ata_chk_status(ap);
 
-	if (rc)
-		goto err_out;
-	else
-		wait_for_completion(&wait);
+		if (!(status & ATA_ERR))
+			/* Weird error condition, give up */
+			goto err_out;
 
-	status = ata_chk_status(ap);
-	if (status & ATA_ERR) {
 		/*
 		 * arg!  EDD works for all test cases, but seems to return
 		 * the ATA signature for some ATAPI devices.  Until the
@@ -1202,6 +1283,9 @@ retry:
 				goto retry;
 			}
 		}
+		/* Fall through */
+	default:
+		/* Issue failed or some other error */
 		goto err_out;
 	}
 
@@ -1326,10 +1410,7 @@ int ata_read_log_page(struct ata_port *a
 		      char *buffer, unsigned int sectors)
 {
 	struct ata_device *dev = &ap->device[device];
-	DECLARE_COMPLETION(wait);
 	struct ata_queued_cmd *qc;
-	unsigned long flags;
-	int rc;
 
 	assert(dev->class == ATA_DEV_ATA);
 
@@ -1347,18 +1428,53 @@ int ata_read_log_page(struct ata_port *a
 	qc->tf.lbal = page;
 	qc->flags |= ATA_QCFLAG_PREEMPT;
 
-	qc->waiting = &wait;
-	qc->complete_fn = ata_qc_complete_noop;
+	return ata_qc_exec_special(qc, ATA_TMOUT_READLOG);
+}
 
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	rc = ata_qc_issue(qc);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+/**
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
 
-	if (rc)
-		return -EIO;
+void ata_eh_qc_complete(struct ata_queued_cmd *qc)
+{
+	BUG_ON(!(qc->ap->flags & ATA_FLAG_RECOVERY));
 
-	wait_for_completion(&wait);
-	return 0;
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
 }
 
 /**
@@ -2133,10 +2249,8 @@ static int ata_choose_xfer_mode(struct a
 
 static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev)
 {
-	DECLARE_COMPLETION(wait);
 	struct ata_queued_cmd *qc;
 	int rc;
-	unsigned long flags;
 
 	/* set up set-features taskfile */
 	DPRINTK("set features - xfer mode\n");
@@ -2150,17 +2264,13 @@ static void ata_dev_set_xfermode(struct 
 	qc->tf.protocol = ATA_PROT_NODATA;
 	qc->tf.nsect = dev->xfer_mode;
 
-	qc->waiting = &wait;
-	qc->complete_fn = ata_qc_complete_noop;
-
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	rc = ata_qc_issue(qc);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
-
-	if (rc)
+	rc = ata_qc_exec_special(qc, ATA_TMOUT_SET_XFERMODE);
+	if (rc) {
+		printk(KERN_ERR "ata%u: failed to set xfermode, disabling... "
+		       "(rc=%d stat=0x%x err=0x%x)\n",
+		       ap->id, rc, ata_chk_status(ap), ata_chk_err(ap));
 		ata_port_disable(ap);
-	else
-		wait_for_completion(&wait);
+	}
 
 	DPRINTK("EXIT\n");
 }
@@ -2530,7 +2640,7 @@ static void ata_pio_complete (struct ata
 
 	ata_irq_on(ap);
 
-	ata_qc_complete(qc, drv_stat);
+	ata_qc_complete(qc);
 }
 
 
@@ -2755,7 +2865,10 @@ static void ata_pio_block(struct ata_por
 
 			ata_irq_on(ap);
 
-			ata_qc_complete(qc, status);
+			if (!(status & (ATA_ERR | ATA_DRQ)))
+				ata_qc_complete(qc);
+			else
+				ata_qc_error(qc);
 			return;
 		}
 
@@ -2787,7 +2900,7 @@ static void ata_pio_error(struct ata_por
 
 	ata_irq_on(ap);
 
-	ata_qc_complete(qc, drv_stat | ATA_ERR);
+	ata_qc_error(qc);
 }
 
 static void ata_pio_task(void *_data)
@@ -2828,9 +2941,7 @@ static void ata_pio_task(void *_data)
 static void atapi_request_sense(struct ata_port *ap, struct ata_device *dev,
 				struct scsi_cmnd *cmd)
 {
-	DECLARE_COMPLETION(wait);
 	struct ata_queued_cmd *qc;
-	unsigned long flags;
 	int rc;
 
 	DPRINTK("ATAPI request sense\n");
@@ -2855,31 +2966,34 @@ static void atapi_request_sense(struct a
 	qc->tf.lbam = (8 * 1024) & 0xff;
 	qc->tf.lbah = (8 * 1024) >> 8;
 	qc->nbytes = SCSI_SENSE_BUFFERSIZE;
+	qc->flags |= ATA_QCFLAG_PREEMPT;
 
-	qc->waiting = &wait;
-	qc->complete_fn = ata_qc_complete_noop;
-
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	rc = ata_qc_issue(qc);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	rc = ata_qc_exec_special(qc, ATA_TMOUT_REQUEST_SENSE);
+	if (rc) {
+		printk(KERN_WARNING "ata%u: failed to read sense data "
+		       "(rc=%d stat=0x%x err=0x%x)\n",
+		       ap->id, rc, ata_chk_status(ap), ata_chk_err(ap));
+		/*
+		 * If this happens, we're returning w/ NULL sense
+		 * data.  Upper layer can handle it.
+		 */
+	}
 
-	if (rc)
-		ata_port_disable(ap);
-	else
-		wait_for_completion(&wait);
+	cmd->result = SAM_STAT_CHECK_CONDITION;
 
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
@@ -2890,102 +3004,65 @@ static void atapi_request_sense(struct a
  *	Inherited from SCSI layer (none, can sleep)
  */
 
-static void ata_qc_timeout(struct ata_queued_cmd *qc)
+void ata_error_handler(struct ata_port *ap)
 {
-	struct ata_port *ap = qc->ap;
-	struct ata_device *dev = qc->dev;
-	u8 host_stat = 0, drv_stat;
+	struct ata_queued_cmd *qc;
+	u8 host_stat = 0, drv_stat, drv_err;
 
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
+	if (qc->flags & ATA_QCFLAG_ERROR) {
 		drv_stat = ata_chk_status(ap);
+		drv_err = ata_chk_err(ap);
+	} else {
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
+			drv_err = ata_chk_err(ap);
 
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
+			ata_to_sense_error(qc, drv_stat, drv_err);
+		else
+			atapi_request_sense(ap, qc->dev, qc->scsicmd);
 	}
 
-	ata_qc_timeout(qc);
+	ata_eh_qc_complete(qc);
 
 out:
 	DPRINTK("EXIT\n");
@@ -3049,100 +3126,142 @@ struct ata_queued_cmd *ata_qc_new_init(s
 	return qc;
 }
 
-static int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat)
-{
-	return 0;
-}
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
 
-static void __ata_qc_complete(struct ata_queued_cmd *qc)
+void ata_qc_free(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	unsigned int tag, do_clear = 0;
+	unsigned int tag = qc->tag;
+
+	assert(ata_tag_valid(qc->tag));
 
 	if (likely(qc->flags & ATA_QCFLAG_ACTIVE)) {
-		assert(ap->queue_depth);
-		ap->queue_depth--;
+		assert(ap->flags & ATA_FLAG_INFLIGHT);
 
-		if (!ap->queue_depth)
-			ap->flags &= ~ATA_FLAG_NCQ_QUEUED;
+		if (ap->active_tag == ATA_TAG_POISON) {
+			assert(ap->sactive & (1 << tag));
+			ap->sactive &= ~(1 << tag);
+			if (!ap->sactive)
+				ap->flags &= ~ATA_FLAG_INFLIGHT;
+		} else {
+			assert(ap->active_tag == tag &&
+			       (qc->flags & ATA_QCFLAG_PREEMPT || !ap->sactive));
+			ap->active_tag = ap->preempted_tag;
+			ap->preempted_tag = ATA_TAG_POISON;
+			if (ap->active_tag == ATA_TAG_POISON && !ap->sactive)
+				ap->flags &= ~ATA_FLAG_INFLIGHT;
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
-
-	if (qc->waiting) {
-		struct completion *waiting = qc->waiting;
-		qc->waiting = NULL;
-		complete(waiting);
-	}
+	qc->tag = ATA_TAG_POISON;
 
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
@@ -3179,6 +3298,14 @@ static inline int ata_qc_issue_ok(struct
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
@@ -3189,7 +3316,7 @@ static inline int ata_qc_issue_ok(struct
 	/*
 	 * If nothing is queued, it's always ok to continue.
 	 */
-	if (!ap->queue_depth)
+	if (!(ap->flags & ATA_FLAG_INFLIGHT))
 		return 1;
 
 	/*
@@ -3203,7 +3330,7 @@ static inline int ata_qc_issue_ok(struct
 	 * Command is NCQ, allow it to be queued if the commands that are
 	 * currently running are also NCQ
 	 */
-	if (ap->flags & ATA_FLAG_NCQ_QUEUED)
+	if (ap->sactive)
 		return 1;
 
 	return 0;
@@ -3281,13 +3408,25 @@ int ata_qc_issue(struct ata_queued_cmd *
 
 	ap->ops->qc_prep(qc);
 
-	qc->ap->active_tag = qc->tag;
 	qc->flags |= ATA_QCFLAG_ACTIVE;
 
-	if (qc->flags & ATA_QCFLAG_NCQ)
-		ap->flags |= ATA_FLAG_NCQ_QUEUED;
+	assert(ap->preempted_tag == ATA_TAG_POISON);
 
-	ap->queue_depth++;
+	if (!(qc->flags & ATA_QCFLAG_PREEMPT)) {
+		assert(ap->active_tag == ATA_TAG_POISON);
+
+		if (qc->flags & ATA_QCFLAG_NCQ)
+			ap->sactive |= 1 << qc->tag;
+		else {
+			assert(!ap->sactive);
+			ap->active_tag = qc->tag;
+		}
+	} else {
+		ap->preempted_tag = ap->active_tag;
+		ap->active_tag = qc->tag;
+	}
+
+	ap->flags |= ATA_FLAG_INFLIGHT;
 
 	rc = ap->ops->qc_issue(qc);
 	if (rc != ATA_QC_ISSUE_OK)
@@ -3655,7 +3794,10 @@ inline unsigned int ata_host_intr (struc
 		ap->ops->irq_clear(ap);
 
 		/* complete taskfile transaction */
-		ata_qc_complete(qc, status);
+		if (!(status & (ATA_ERR | ATA_DRQ)))
+			ata_qc_complete(qc);
+		else
+			ata_qc_error(qc);
 		break;
 
 	default:
@@ -3723,6 +3865,236 @@ irqreturn_t ata_interrupt (int irq, void
 	return IRQ_RETVAL(handled);
 }
 
+/*
+ * NCQ helpers
+ */
+
+/**
+ *     ata_ncq_complete - NCQ driver helper.  Complete requests normally.
+ *     @ap: port in question
+ *
+ *     Complete in-flight commands.  One device per port is assumed.
+ *     This functions is meant to be called from specific driver's
+ *     interrupt routine to complete requests normally.  On
+ *     invocation, if non-NCQ command was in-flight, it's completed
+ *     normally.  If NCQ commands were in-flight, Sactive register is
+ *     read and completed commands are processed.
+ *
+ *     LOCKING:
+ *     spin_lock_irqsave(host_set lock)
+ */
+int ata_ncq_complete(struct ata_port *ap)
+{
+	int nr_done = 0;
+	unsigned long done_mask = 0;
+	unsigned tag;
+
+	/*
+	 * ap->active_tag test should come before ap->sactive test to
+	 * complete EH requests.
+	 */
+	if (ap->active_tag != ATA_TAG_POISON)
+		done_mask = 1 << ap->active_tag;
+	else if (ap->sactive) {
+		unsigned long new_sactive = scr_read(ap, SCR_ACTIVE);
+		done_mask = new_sactive ^ ap->sactive;
+
+		if (unlikely(done_mask & new_sactive)) {
+			printk(KERN_ERR "ata%u: illegal sactive transition (%08lx->%08lx)\n",
+			       ap->id, ap->sactive, new_sactive);
+			done_mask &= ~new_sactive;
+		}
+	}
+
+	ata_for_each_tag(tag, done_mask) {
+		struct ata_queued_cmd *qc = ata_qc_from_tag(ap, tag);
+		assert(qc);
+		ata_qc_complete(qc);
+		nr_done++;
+	}
+
+	return nr_done;
+}
+
+/**
+ *     ata_ncq_error - NCQ driver helper.  Abort commands and invoke EH.
+ *     @ap: port in question.
+ *
+ *     Abort in-flight commands and invoke EH.  This function is
+ *     meant to be called from specific driver's interrupt routine to
+ *     indicate error.
+ *
+ *     LOCKING:
+ *     spin_lock_irqsave(host_set lock)
+ */
+
+int ata_ncq_error(struct ata_port *ap)
+{
+	int nr_aborted = 0;
+	unsigned long sactive = 0;
+	unsigned tag;
+
+	printk(KERN_WARNING "ata%u: aborting commands due to error.  "
+	       "active_tag %d, sactive %08lx\n",
+	       ap->id,
+	       ap->active_tag != ATA_TAG_POISON ? ap->active_tag : -1,
+	       ap->sactive);
+
+	/*
+	 * ap->active_tag test should come before ap->sactive test to
+	 * complete EH requests.
+	 */
+	if (ap->active_tag != ATA_TAG_POISON)
+		sactive = 1 << ap->active_tag;
+	else if (ap->sactive) {
+		/* Complete successful requests before aborting. */
+		ata_ncq_complete(ap);
+		if (!ap->sactive)
+			printk(KERN_WARNING "ata%u: device reports successful "
+			       "completion of all NCQ commands after error\n",
+			       ap->id);
+		sactive = ap->sactive;
+	}
+
+	ata_for_each_tag(tag, sactive) {
+		struct ata_queued_cmd *qc = ata_qc_from_tag(ap, tag);
+		assert(qc);
+		ata_qc_error(qc);
+		nr_aborted++;
+	}
+
+	return nr_aborted;
+}
+
+static inline int ata_read_log_10h(struct ata_port *ap, unsigned *tagp,
+				   u8 *drv_statp, u8 *drv_errp)
+{
+	char *buffer;
+	int rc;
+
+	buffer = kmalloc(512, GFP_KERNEL);
+	if (buffer == NULL) {
+		printk(KERN_ERR "ata%u: unable to allocate memory for error\n",
+		       ap->id);
+		return -ENOMEM;
+	}
+
+	rc = ata_read_log_page(ap, 0, READ_LOG_SATA_NCQ_PAGE, buffer, 1);
+	if (rc < 0) {
+		printk(KERN_ERR "ata%u: failed to read log page 10h (%d)\n",
+		       ap->id, rc);
+		goto out;
+	}
+
+	if (buffer[0] & 0x80) {
+		printk(KERN_WARNING "ata%u: NQ bit set on log page 10h\n",
+		       ap->id);
+		rc = -EIO;
+		goto out;
+	}
+
+	*tagp = buffer[0] & 0x1f;
+	*drv_statp = buffer[2] | ATA_ERR;
+	*drv_errp = buffer[3];
+	rc = 0;
+ out:
+	kfree(buffer);
+	return rc;
+}
+
+/**
+ *     ata_ncq_recover - NCQ driver helper.  Recover from error.
+ *     @ap: port in question
+ *     @did_reset: specific driver performed reset.  Log page 10h might
+ *                 be invalid.
+ *
+ *     This function is to be called from eng_timeout routine of
+ *     specific drivers.  Before calling this function, specific
+ *     drivers are required to
+ *
+ *     - Clear all in-flight requests.  Drivers only have to clear
+ *       low-level state (like stopping DMA engine and clearing
+ *       interrupts).  All generic command cancelling are dealt by
+ *       libata-core layer.
+ *
+ *     - Make the controller ready for new commands.
+ *
+ *     LOCKING:
+ *     Inherited from SCSI layer (in EH context, can sleep)
+ */
+void ata_ncq_recover(struct ata_port *ap, int did_reset)
+{
+	unsigned ncq_abort_tag = ATA_TAG_POISON;
+	u8 stat = 0, err = 0;
+	unsigned long sactive;
+	unsigned tag;
+
+	DPRINTK("ENTER\n");
+
+	stat = ata_chk_status(ap);
+	err = ata_chk_err(ap);
+
+	/*
+	 * if commands have timed out or DRQ/BSY is set, device needs
+	 * to be reset.
+	 */
+	if (!(ap->flags & ATA_FLAG_ERROR) || stat & (ATA_BUSY | ATA_DRQ)) {
+		printk(KERN_WARNING "ata%u: stat=%x, issuing COMRESET\n", ap->id, stat);
+		ap->ops->phy_reset(ap);
+		did_reset = 1;
+	}
+
+	if (ap->sactive) {
+		if (ap->flags & ATA_FLAG_ERROR) {
+			u8 tstat, terr;
+			/*
+			 * Regardless of did_reset, we read log page
+			 * 10h.  The drive might need it to restart
+			 * operation.  If did_reset, we ignore the
+			 * result.
+			 */
+			if (ata_read_log_10h(ap, &tag, &tstat, &terr) == 0) {
+				printk(KERN_INFO "ata%u: log_ext_10h, tag=%d "
+				       "stat=%02x err=%02x%s\n",
+				       ap->id, tag, tstat, terr,
+				       did_reset ? " (ignored due to reset)" : "");
+				if (!did_reset) {
+					ncq_abort_tag = tag;
+					stat = tstat;
+					err = terr;
+				}
+			} else {
+				printk(KERN_WARNING "ata%u: resetting...\n",
+				       ap->id);
+				ap->ops->phy_reset(ap);
+			}
+		}
+		sactive = ap->sactive;
+	} else
+		sactive = 1 << ap->active_tag;
+
+	ata_for_each_tag(tag, sactive) {
+		struct ata_queued_cmd *qc = ata_qc_from_tag(ap, tag);
+		assert(qc);
+		if (ncq_abort_tag != ATA_TAG_POISON && tag != ncq_abort_tag) {
+			ata_eh_qc_retry(qc);
+			continue;
+		}
+
+		if (qc->scsicmd) {
+			if (qc->dev->class == ATA_DEV_ATA ||
+			    !(qc->flags & ATA_QCFLAG_ERROR))
+				ata_to_sense_error(qc, stat | ATA_ERR, err);
+			else
+				atapi_request_sense(ap, qc->dev, qc->scsicmd);
+		}
+
+		ata_eh_qc_complete(qc);
+	}
+
+	DPRINTK("EXIT\n");
+}
+
 /**
  *	atapi_packet_task - Write CDB bytes to hardware
  *	@_data: Port to which ATAPI device is attached.
@@ -3780,7 +4152,7 @@ static void atapi_packet_task(void *_dat
 	return;
 
 err_out:
-	ata_qc_complete(qc, ATA_ERR);
+	ata_qc_error(qc);
 }
 
 
@@ -3900,6 +4272,7 @@ static void ata_host_init(struct ata_por
 	ap->ops = ent->port_ops;
 	ap->cbl = ATA_CBL_NONE;
 	ap->active_tag = ATA_TAG_POISON;
+	ap->preempted_tag = ATA_TAG_POISON;
 	init_waitqueue_head(&ap->cmd_wait_queue);
 	ap->cmd_waiters = 0;
 	ap->last_ctl = 0xFF;
@@ -4538,7 +4911,7 @@ EXPORT_SYMBOL_GPL(ata_sg_init);
 EXPORT_SYMBOL_GPL(ata_sg_init_one);
 EXPORT_SYMBOL_GPL(ata_qc_complete);
 EXPORT_SYMBOL_GPL(ata_qc_issue_prot);
-EXPORT_SYMBOL_GPL(ata_eng_timeout);
+EXPORT_SYMBOL_GPL(ata_error_handler);
 EXPORT_SYMBOL_GPL(ata_tf_load);
 EXPORT_SYMBOL_GPL(ata_tf_read);
 EXPORT_SYMBOL_GPL(ata_noop_dev_select);
@@ -4574,10 +4947,12 @@ EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_id_string);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
 EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
-EXPORT_SYMBOL_GPL(ata_scsi_block_requests);
-EXPORT_SYMBOL_GPL(ata_scsi_unblock_requests);
-EXPORT_SYMBOL_GPL(ata_scsi_requeue);
 EXPORT_SYMBOL_GPL(ata_read_log_page);
+EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
+EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
+EXPORT_SYMBOL_GPL(ata_ncq_complete);
+EXPORT_SYMBOL_GPL(ata_ncq_error);
+EXPORT_SYMBOL_GPL(ata_ncq_recover);
 
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL_GPL(pci_test_config_bits);
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h	2005-08-05 12:55:08.000000000 +0900
+++ work/include/linux/libata.h	2005-08-05 12:55:50.000000000 +0900
@@ -116,25 +116,33 @@ enum {
 	ATA_FLAG_SATA_RESET	= (1 << 7), /* use COMRESET */
 	ATA_FLAG_PIO_DMA	= (1 << 8), /* PIO cmds via DMA */
 	ATA_FLAG_NCQ		= (1 << 9), /* Can do NCQ */
-	ATA_FLAG_NCQ_QUEUED	= (1 << 10), /* NCQ commands are queued */
+	ATA_FLAG_INFLIGHT	= (1 << 10), /* Command(s) in flight */
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
 
 	/* various lengths of time */
-	ATA_TMOUT_EDD		= 5 * HZ,	/* hueristic */
 	ATA_TMOUT_PIO		= 30 * HZ,
 	ATA_TMOUT_BOOT		= 30 * HZ,	/* hueristic */
 	ATA_TMOUT_BOOT_QUICK	= 7 * HZ,	/* hueristic */
 	ATA_TMOUT_CDB		= 30 * HZ,
 	ATA_TMOUT_CDB_QUICK	= 5 * HZ,
+	ATA_TMOUT_SPECIAL	= 30 * HZ,
+	ATA_TMOUT_SPECIAL_QUICK	= 5 * HZ,
+	ATA_TMOUT_IDENTIFY	= 5 * HZ,	/* hueristic */
+	ATA_TMOUT_READLOG	= 5 * HZ,	/* hueristic */
+	ATA_TMOUT_SET_XFERMODE	= 5 * HZ,	/* hueristic */
+	ATA_TMOUT_REQUEST_SENSE	= 5 * HZ,	/* hueristic */
 
 	/* ATA bus states */
 	BUS_UNKNOWN		= 0,
@@ -179,7 +187,7 @@ struct ata_port;
 struct ata_queued_cmd;
 
 /* typedefs */
-typedef int (*ata_qc_cb_t) (struct ata_queued_cmd *qc, u8 drv_stat);
+typedef void (*ata_qc_cb_t) (struct ata_queued_cmd *qc);
 
 struct ata_ioports {
 	unsigned long		cmd_addr;
@@ -315,9 +323,8 @@ struct ata_port {
 	struct ata_device	device[ATA_MAX_DEVICES];
 
 	struct ata_queued_cmd	qcmd[ATA_MAX_CMDS];
-	unsigned long		qactive;
-	unsigned int		active_tag;
-	unsigned int		queue_depth;
+	unsigned long		qactive, sactive;
+	unsigned int		active_tag, preempted_tag;
 
 	wait_queue_head_t	cmd_wait_queue;
 	unsigned int		cmd_waiters;
@@ -362,7 +369,7 @@ struct ata_port_operations {
 	void (*qc_prep) (struct ata_queued_cmd *qc);
 	int (*qc_issue) (struct ata_queued_cmd *qc);
 
-	void (*eng_timeout) (struct ata_port *ap);
+	void (*error_handler) (struct ata_port *ap);
 
 	irqreturn_t (*irq_handler)(int, void *, struct pt_regs *);
 	void (*irq_clear) (struct ata_port *);
@@ -439,8 +446,9 @@ extern void ata_bmdma_start (struct ata_
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
@@ -448,11 +456,13 @@ extern int ata_std_bios_param(struct scs
 			      sector_t capacity, int geom[]);
 extern int ata_scsi_slave_config(struct scsi_device *sdev);
 extern int ata_scsi_change_queue_depth(struct scsi_device *, int);
-extern void ata_scsi_block_requests(struct ata_port *);
-extern void ata_scsi_unblock_requests(struct ata_port *);
-extern void ata_scsi_requeue(struct ata_queued_cmd *);
 extern int ata_read_log_page(struct ata_port *, unsigned int, char, char *,
 			     unsigned int);
+extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
+extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
+extern int ata_ncq_complete(struct ata_port *ap);
+extern int ata_ncq_error(struct ata_port *ap);
+extern void ata_ncq_recover(struct ata_port *ap, int did_reset);
 
 
 #ifdef CONFIG_PCI
Index: work/drivers/scsi/libata-scsi.c
===================================================================
--- work.orig/drivers/scsi/libata-scsi.c	2005-08-05 12:55:08.000000000 +0900
+++ work/drivers/scsi/libata-scsi.c	2005-08-05 12:55:50.000000000 +0900
@@ -160,12 +160,14 @@ struct ata_queued_cmd *ata_scsi_qc_new(s
 	/*
 	 * check if we need to defer this command
 	 */
+	if (ap->flags & (ATA_FLAG_ERROR | ATA_FLAG_RECOVERY))
+		return NULL;
 	if (ap->cmd_waiters)
 		return NULL;
-	if (ap->queue_depth) {
+	if (ap->flags & ATA_FLAG_INFLIGHT) {
 		if (!scsi_rw_ncq_request(dev, cmd))
 			return NULL;
-		if (!(ap->flags & ATA_FLAG_NCQ_QUEUED))
+		if (!ap->sactive)
 			return NULL;
 	}
 
@@ -190,6 +192,7 @@ struct ata_queued_cmd *ata_scsi_qc_new(s
  *	ata_to_sense_error - convert ATA error to SCSI error
  *	@qc: Command that we are erroring out
  *	@drv_stat: value contained in ATA status register
+ *	@drv_err: value contained in ATA error register
  *
  *	Converts an ATA error into a SCSI error. While we are at it
  *	we decode and dump the ATA error for the user so that they
@@ -200,10 +203,9 @@ struct ata_queued_cmd *ata_scsi_qc_new(s
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_to_sense_error(struct ata_queued_cmd *qc, u8 drv_stat)
+void ata_to_sense_error(struct ata_queued_cmd *qc, u8 drv_stat, u8 drv_err)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
-	u8 err = 0;
 	unsigned char *sb = cmd->sense_buffer;
 	/* Based on the 3ware driver translation table */
 	static unsigned char sense_table[][4] = {
@@ -252,10 +254,8 @@ void ata_to_sense_error(struct ata_queue
 	/*
 	 *	Is this an error we can process/parse
 	 */
-
-	if(drv_stat & ATA_ERR)
-		/* Read the err bits */
-		err = ata_chk_err(qc->ap);
+	if(!(drv_stat & ATA_ERR))
+		drv_err = 0;
 
 	/* Display the ATA level error info */
 
@@ -263,7 +263,7 @@ void ata_to_sense_error(struct ata_queue
 	if(drv_stat & 0x80)
 	{
 		printk("Busy ");
-		err = 0;	/* Data is not valid in this case */
+		drv_err = 0;	/* Data is not valid in this case */
 	}
 	else {
 		if(drv_stat & 0x40)	printk("DriveReady ");
@@ -276,21 +276,21 @@ void ata_to_sense_error(struct ata_queue
 	}
 	printk("}\n");
 
-	if(err)
+	if(drv_err)
 	{
-		printk(KERN_WARNING "ata%u: error=0x%02x { ", qc->ap->id, err);
-		if(err & 0x04)		printk("DriveStatusError ");
-		if(err & 0x80)
+		printk(KERN_WARNING "ata%u: error=0x%02x { ", qc->ap->id, drv_err);
+		if(drv_err & 0x04)	printk("DriveStatusError ");
+		if(drv_err & 0x80)
 		{
-			if(err & 0x04)
+			if(drv_err & 0x04)
 				printk("BadCRC ");
 			else
 				printk("Sector ");
 		}
-		if(err & 0x40)		printk("UncorrectableError ");
-		if(err & 0x10)		printk("SectorIdNotFound ");
-		if(err & 0x02)		printk("TrackZeroNotFound ");
-		if(err & 0x01)		printk("AddrMarkNotFound ");
+		if(drv_err & 0x40)	printk("UncorrectableError ");
+		if(drv_err & 0x10)	printk("SectorIdNotFound ");
+		if(drv_err & 0x02)	printk("TrackZeroNotFound ");
+		if(drv_err & 0x01)	printk("AddrMarkNotFound ");
 		printk("}\n");
 
 		/* Should we dump sector info here too ?? */
@@ -301,7 +301,7 @@ void ata_to_sense_error(struct ata_queue
 	while(sense_table[i][0] != 0xFF)
 	{
 		/* Look for best matches first */
-		if((sense_table[i][0] & err) == sense_table[i][0])
+		if((sense_table[i][0] & drv_err) == sense_table[i][0])
 		{
 			sb[0] = 0x70;
 			sb[2] = sense_table[i][1];
@@ -313,8 +313,8 @@ void ata_to_sense_error(struct ata_queue
 		i++;
 	}
 	/* No immediate match */
-	if(err)
-		printk(KERN_DEBUG "ata%u: no sense translation for 0x%02x\n", qc->ap->id, err);
+	if(drv_err)
+		printk(KERN_DEBUG "ata%u: no sense translation for 0x%02x\n", qc->ap->id, drv_err);
 
 	i = 0;
 	/* Fall back to interpreting status bits */
@@ -421,38 +421,6 @@ int ata_scsi_change_queue_depth(struct s
 	return queue_depth;
 }
 
-void ata_scsi_requeue(struct ata_queued_cmd *qc)
-{
-	struct scsi_cmnd *scmd = qc->scsicmd;
-
-	if (scmd) {
-		request_queue_t *q = scmd->device->request_queue;
-
-		scmd->request->flags &= ~REQ_DONTPREP;
-		scsi_delete_timer(scmd);
-		blk_requeue_request(q, scmd->request);
-
-		ata_qc_free(qc);
-	} else
-		ata_qc_complete(qc, ATA_ERR);
-}
-
-void ata_scsi_block_requests(struct ata_port *ap)
-{
-	struct Scsi_Host *host = ap->host;
-
-	scsi_block_requests(host);
-}
-
-void ata_scsi_unblock_requests(struct ata_port *ap)
-{
-	struct Scsi_Host *host = ap->host;
-
-	scsi_unblock_requests(host);
-}
-
-
-
 /**
  *	ata_scsi_error - SCSI layer error handler callback
  *	@host: SCSI host on which error occurred
@@ -469,18 +437,61 @@ void ata_scsi_unblock_requests(struct at
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
+	assert(!(ap->flags & ATA_FLAG_INFLIGHT) && !ap->host->host_busy);
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
 
@@ -753,18 +764,9 @@ static unsigned int ata_scsi_rw_xlat(str
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
@@ -1391,19 +1393,11 @@ void ata_scsi_badcmd(struct scsi_cmnd *c
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
@@ -1415,13 +1409,11 @@ static int atapi_qc_complete(struct ata_
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
@@ -1618,6 +1610,8 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
 
 	ata_scsi_dump_cdb(ap, cmd);
 
+	cmd->result = SAM_STAT_GOOD;
+
 	dev = ata_scsi_find_dev(ap, scsidev);
 	if (unlikely(!dev)) {
 		cmd->result = (DID_BAD_TARGET << 16);
Index: work/drivers/scsi/ata_piix.c
===================================================================
--- work.orig/drivers/scsi/ata_piix.c	2005-08-05 12:55:08.000000000 +0900
+++ work/drivers/scsi/ata_piix.c	2005-08-05 12:55:50.000000000 +0900
@@ -146,7 +146,7 @@ static struct ata_port_operations piix_p
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 
-	.eng_timeout		= ata_eng_timeout,
+	.error_handler		= ata_error_handler,
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
@@ -174,7 +174,7 @@ static struct ata_port_operations piix_s
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 
-	.eng_timeout		= ata_eng_timeout,
+	.error_handler		= ata_error_handler,
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
Index: work/drivers/scsi/sata_sil.c
===================================================================
--- work.orig/drivers/scsi/sata_sil.c	2005-08-05 12:55:08.000000000 +0900
+++ work/drivers/scsi/sata_sil.c	2005-08-05 12:55:50.000000000 +0900
@@ -154,7 +154,7 @@ static struct ata_port_operations sil_op
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
-	.eng_timeout		= ata_eng_timeout,
+	.error_handler		= ata_error_handler,
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= sil_scr_read,
Index: work/drivers/scsi/libata.h
===================================================================
--- work.orig/drivers/scsi/libata.h	2005-08-05 12:55:08.000000000 +0900
+++ work/drivers/scsi/libata.h	2005-08-05 12:55:50.000000000 +0900
@@ -47,7 +47,7 @@ extern void swap_buf_le16(u16 *buf, unsi
 
 
 /* libata-scsi.c */
-extern void ata_to_sense_error(struct ata_queued_cmd *qc, u8 drv_stat);
+extern void ata_to_sense_error(struct ata_queued_cmd *qc, u8 drv_stat, u8 drv_err);
 extern int ata_scsi_error(struct Scsi_Host *host);
 extern unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
 			       unsigned int buflen);
Index: work/drivers/scsi/ahci.c
===================================================================
--- work.orig/drivers/scsi/ahci.c	2005-08-05 12:55:08.000000000 +0900
+++ work/drivers/scsi/ahci.c	2005-08-05 12:55:50.000000000 +0900
@@ -171,7 +171,6 @@ struct ahci_port_priv {
 	dma_addr_t		cmd_tbl_dma;
 	void			*rx_fis;
 	dma_addr_t		rx_fis_dma;
-	u32			sactive;
 };
 
 static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg);
@@ -181,7 +180,7 @@ static int ahci_qc_issue(struct ata_queu
 static irqreturn_t ahci_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 static void ahci_phy_reset(struct ata_port *ap);
 static void ahci_irq_clear(struct ata_port *ap);
-static void ahci_eng_timeout(struct ata_port *ap);
+static void ahci_error_handler(struct ata_port *ap);
 static int ahci_port_start(struct ata_port *ap);
 static void ahci_port_stop(struct ata_port *ap);
 static void ahci_host_stop(struct ata_host_set *host_set);
@@ -227,7 +226,7 @@ static struct ata_port_operations ahci_o
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
 
-	.eng_timeout		= ahci_eng_timeout,
+	.error_handler		= ahci_error_handler,
 
 	.irq_handler		= ahci_interrupt,
 	.irq_clear		= ahci_irq_clear,
@@ -427,6 +426,47 @@ static void ahci_scr_write (struct ata_p
 	writel(val, (void *) ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
+static void ahci_stop_dma(struct ata_port *ap)
+{
+	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	u32 tmp;
+	int work;
+
+	/* stop DMA */
+	tmp = readl(port_mmio + PORT_CMD);
+	tmp &= ~PORT_CMD_START;
+	writel(tmp, port_mmio + PORT_CMD);
+
+	/* wait for engine to stop. */
+	work = 500;
+	while (work-- > 0) {
+		tmp = readl(port_mmio + PORT_CMD);
+		if ((tmp & PORT_CMD_LIST_ON) == 0)
+			break;
+		msleep(1);
+	}
+}
+
+static void ahci_start_dma(struct ata_port *ap)
+{
+	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	u32 tmp;
+
+	/* clear SATA phy error, if any */
+	tmp = readl(port_mmio + PORT_SCR_ERR);
+	writel(tmp, port_mmio + PORT_SCR_ERR);
+
+	/* clear status */
+	tmp = readl(port_mmio + PORT_IRQ_STAT);
+	writel(tmp, port_mmio + PORT_IRQ_STAT);
+
+	/* re-start DMA */
+	tmp = readl(port_mmio + PORT_CMD);
+	tmp |= PORT_CMD_START;
+	writel(tmp, port_mmio + PORT_CMD);
+	readl(port_mmio + PORT_CMD); /* flush */
+}
+
 static void ahci_phy_reset(struct ata_port *ap)
 {
 	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
@@ -434,7 +474,9 @@ static void ahci_phy_reset(struct ata_po
 	struct ata_device *dev = &ap->device[0];
 	u32 tmp;
 
+	ahci_stop_dma(ap);
 	__sata_phy_reset(ap);
+	ahci_start_dma(ap);
 
 	if (ap->flags & ATA_FLAG_PORT_DISABLED)
 		return;
@@ -549,290 +591,22 @@ static void ahci_qc_prep(struct ata_queu
 	ahci_fill_sg(qc, offset);
 }
 
-/*
- * Return 1 if COMRESET was done
- */
-static int ahci_intr_error(struct ata_port *ap, u32 irq_stat)
-{
-	void *mmio = ap->host_set->mmio_base;
-	void *port_mmio = ahci_port_base(mmio, ap->port_no);
-	u32 tmp;
-	int work, reset = 0;
-
-	/* stop DMA */
-	tmp = readl(port_mmio + PORT_CMD);
-	tmp &= ~PORT_CMD_START;
-	writel(tmp, port_mmio + PORT_CMD);
-
-	/* wait for engine to stop.  TODO: this could be
-	 * as long as 500 msec
-	 */
-	work = 1000;
-	while (work-- > 0) {
-		tmp = readl(port_mmio + PORT_CMD);
-		if ((tmp & PORT_CMD_LIST_ON) == 0)
-			break;
-		udelay(10);
-	}
-
-	/* clear SATA phy error, if any */
-	tmp = readl(port_mmio + PORT_SCR_ERR);
-	writel(tmp, port_mmio + PORT_SCR_ERR);
-
-	/* clear status */
-	tmp = readl(port_mmio + PORT_IRQ_STAT);
-	writel(tmp, port_mmio + PORT_IRQ_STAT);
-
-	/* if DRQ/BSY is set, device needs to be reset.
-	 * if so, issue COMRESET
-	 */
-	tmp = readl(port_mmio + PORT_TFDATA);
-	if (tmp & (ATA_BUSY | ATA_DRQ)) {
-		printk(KERN_WARNING "ata%u: stat=%x, issuing COMRESET\n", ap->id, tmp);
-		writel(0x301, port_mmio + PORT_SCR_CTL);
-		readl(port_mmio + PORT_SCR_CTL); /* flush */
-		udelay(10);
-		writel(0x300, port_mmio + PORT_SCR_CTL);
-		readl(port_mmio + PORT_SCR_CTL); /* flush */
-		reset = 1;
-	}
-
-	/* re-start DMA */
-	tmp = readl(port_mmio + PORT_CMD);
-	tmp |= PORT_CMD_START;
-	writel(tmp, port_mmio + PORT_CMD);
-	readl(port_mmio + PORT_CMD); /* flush */
-
-	printk(KERN_WARNING "ata%u: error occurred, port reset\n", ap->id);
-	return reset;
-}
-
-static void ahci_complete_requests(struct ata_port *ap, u32 tag_mask, int err)
-{
-	while (tag_mask) {
-		struct ata_queued_cmd *qc;
-		int tag = ffs(tag_mask) - 1;
-
-		tag_mask &= ~(1 << tag);
-		qc = ata_qc_from_tag(ap, tag);
-		if (qc)
-			ata_qc_complete(qc, err);
-		else
-			printk(KERN_ERR "ahci: missing tag %d\n", tag);
-	}
-}
-
-static void dump_log_page(unsigned char *p)
-{
-	int i;
-
-	printk("LOG 0x10: nq=%d, tag=%d\n", p[0] >> 7, p[0] & 0x1f);
-
-	for (i = 2; i < 14; i++)
-		printk("%d:%d ", i, p[i]);
-
-	printk("\n");
-}
-
-/*
- * TODO: needs to use READ_LOG_EXT/page=10h to retrieve error information
- */
-extern void ata_qc_free(struct ata_queued_cmd *qc);
-static void ahci_ncq_timeout(struct ata_port *ap)
+static void ahci_error_handler(struct ata_port *ap)
 {
-	struct ahci_port_priv *pp = ap->private_data;
-	void *mmio = ap->host_set->mmio_base;
-	void *port_mmio = ahci_port_base(mmio, ap->port_no);
-	struct ata_queued_cmd *qc;
-	unsigned long flags;
-	char *buffer;
-	u32 sactive;
-	int reset;
-
-	printk(KERN_WARNING "ata%u: ncq interrupt error (Q=%d)\n", ap->id, ap->queue_depth);
-
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-
-	sactive = readl(port_mmio + PORT_SCR_ACT);
-
-	printk(KERN_WARNING "ata%u: SActive 0x%x (0x%x)\n", ap->id, sactive, pp->sactive);
-	reset = ahci_intr_error(ap, readl(port_mmio + PORT_IRQ_STAT));
-
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
-
-	/*
-	 * if COMRESET was done, we don't have to issue a log page read
-	 */
-	if (reset)
-		goto done;
-
-	buffer = kmalloc(512, GFP_KERNEL);
-	if (!buffer) {
-		printk(KERN_ERR "ata%u: unable to allocate memory for error\n", ap->id);
-		goto done;
-	}
-
-	if (ata_read_log_page(ap, 0, READ_LOG_SATA_NCQ_PAGE, buffer, 1)) {
-		printk(KERN_ERR "ata%u: unable to read log page\n", ap->id);
-		goto out;
-	}
-
-	dump_log_page(buffer);
-
-	/*
-	 * if NQ is cleared, bottom 5 bits contain the tag of the errored
-	 * command
-	 */
-	if ((buffer[0] & (1 << 7)) == 0) {
-		int tag = buffer[0] & 0x1f;
-
-		qc = ata_qc_from_tag(ap, tag);
-		if (qc)
-			ata_qc_complete(qc, ATA_ERR);
-	}
-
 	/*
-	 * requeue the remaining commands
+	 * Bring controller to known state.  libata layer will take
+	 * care of the drive.
 	 */
-	while (pp->sactive) {
-		int tag = ffs(pp->sactive) - 1;
-
-		pp->sactive &= ~(1 << tag);
-		qc = ata_qc_from_tag(ap, tag);
-		if (qc) {
-			if (qc->scsicmd)
-				ata_qc_free(qc);
-			else
-				ata_qc_complete(qc, ATA_ERR);
-		} else
-			printk(KERN_ERR "ata%u: missing tag %d\n", ap->id, tag);
-	}
-
-out:
-	kfree(buffer);
-done:
-	ata_scsi_unblock_requests(ap);
-}
-
-static void ahci_nonncq_timeout(struct ata_port *ap)
-{
-	void *mmio = ap->host_set->mmio_base;
-	void *port_mmio = ahci_port_base(mmio, ap->port_no);
-	struct ata_queued_cmd *qc;
-
-	DPRINTK("ENTER\n");
-
-	ahci_intr_error(ap, readl(port_mmio + PORT_IRQ_STAT));
-
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-	if (!qc) {
-		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
-		       ap->id);
-	} else {
-		/* hack alert!  We cannot use the supplied completion
-	 	 * function from inside the ->eh_strategy_handler() thread.
-	 	 * libata is the only user of ->eh_strategy_handler() in
-	 	 * any kernel, so the default scsi_done() assumes it is
-	 	 * not being called from the SCSI EH.
-	 	 */
-		qc->scsidone = scsi_finish_command;
-		ata_qc_complete(qc, ATA_ERR);
-	}
-}
-
-static void ahci_eng_timeout(struct ata_port *ap)
-{
-	struct ahci_port_priv *pp = ap->private_data;
-
-	if (pp->sactive)
-		ahci_ncq_timeout(ap);
-	else
-		ahci_nonncq_timeout(ap);
-}
-
-static int ahci_ncq_intr(struct ata_port *ap, u32 status)
-{
-	struct ahci_port_priv *pp = ap->private_data;
-	void *mmio = ap->host_set->mmio_base;
-	void *port_mmio = ahci_port_base(mmio, ap->port_no);
-
-	if (!pp->sactive)
-		return 0;
-
-	if (status & PORT_IRQ_SDB_FIS) {
-		u8 *sdb = pp->rx_fis + RX_FIS_SDB_REG;
-		u32 sactive, mask;
-
-		if (unlikely(sdb[2] & ATA_ERR)) {
-			printk("SDB fis, stat %x, err %x\n", sdb[2], sdb[3]);
-			return 1;
-		}
-
-		/*
-		 * SActive will have the bits cleared for completed commands
-		 */
-		sactive = readl(port_mmio + PORT_SCR_ACT);
-		mask = pp->sactive & ~sactive;
-		if (mask) {
-			ahci_complete_requests(ap, mask, 0);
-			pp->sactive = sactive;
-			return 1;
-		} else
-			printk(KERN_INFO "ata%u: SDB with no bits cleared\n", ap->id);
-	} else if (status & PORT_IRQ_D2H_REG_FIS) {
-		u8 *d2h = pp->rx_fis + RX_FIS_D2H_REG;
-
-		/*
-		 * pre-BSY clear error, let timeout error handling take care
-		 * of it when it kicks in
-		 */
-		if (d2h[2] & ATA_ERR) {
-			VPRINTK("D2H fis, err %x\n", d2h[2]);
-			return 1;
-		}
-
-		printk("D2H fis\n");
-	} else
-		printk(KERN_WARNING "ata%u: unhandled FIS, stat %x\n", ap->id, status);
-
-	return 0;
-}
-
-static void ahci_ncq_intr_error(struct ata_port *ap, u32 status)
-{
-	struct ahci_port_priv *pp = ap->private_data;
-	struct ata_queued_cmd *qc;
-	struct ata_taskfile tf;
-	int tag;
-
-	printk(KERN_ERR "ata%u: NCQ err status 0x%x\n", ap->id, status);
+	ahci_stop_dma(ap);
+	ahci_start_dma(ap);
 
-	if (status & PORT_IRQ_D2H_REG_FIS) {
-		ahci_tf_read(ap, &tf);
-		tag = tf.nsect >> 3;
-
-		qc = ata_qc_from_tag(ap, tag);
-		if (qc) {
-			printk(KERN_ERR "ata%u: ending bad tag %d\n", ap->id, tag);
-			pp->sactive &= ~(1 << tag);
-			ata_qc_complete(qc, ATA_ERR);
-		} else
-			printk(KERN_ERR "ata%u: error on tag %d, but not present\n", ap->id, tag);
-	}
-
-	/*
-	 * let command timeout deal with error handling
-	 */
-	ata_scsi_block_requests(ap);
+	ata_ncq_recover(ap, 0);
 }
 
 static inline int ahci_host_intr(struct ata_port *ap)
 {
-	struct ahci_port_priv *pp = ap->private_data;
-	void *mmio = ap->host_set->mmio_base;
-	void *port_mmio = ahci_port_base(mmio, ap->port_no);
-	struct ata_queued_cmd *qc;
-	u32 status, serr, ci;
+	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	u32 status, serr;
 
 	serr = readl(port_mmio + PORT_SCR_ERR);
 	writel(serr, port_mmio + PORT_SCR_ERR);
@@ -840,29 +614,13 @@ static inline int ahci_host_intr(struct 
 	status = readl(port_mmio + PORT_IRQ_STAT);
 	writel(status, port_mmio + PORT_IRQ_STAT);
 
-	if (status & PORT_IRQ_FATAL) {
-		printk("ata%u: irq error %x %x, tag %d\n", ap->id, serr, status, ap->active_tag);
-		if (pp->sactive)
-			ahci_ncq_intr_error(ap, status);
-		else
-			ahci_intr_error(ap, status);
-
-		return 1;
-	}
-
-	if (ahci_ncq_intr(ap, status))
-		return 1;
-
-	ci = readl(port_mmio + PORT_CMD_ISSUE);
-
-	if ((ci & (1 << ap->active_tag)) == 0) {
-		VPRINTK("NON-NCQ interrupt\n");
-
-		qc = ata_qc_from_tag(ap, ap->active_tag);
-		if (qc && (qc->flags & ATA_QCFLAG_ACTIVE) &&
-		    !(qc->flags & ATA_QCFLAG_NCQ))
-			ata_qc_complete(qc, 0);
-	}
+	if (!(status & PORT_IRQ_FATAL)) {
+		void *cmd_issue = port_mmio + PORT_CMD_ISSUE;
+		if (ap->sactive ||
+		    (readl(cmd_issue) & (1 << ap->active_tag)) == 0)
+			ata_ncq_complete(ap);
+	} else
+		ata_ncq_error(ap);
 
 	return 1;
 }
@@ -919,12 +677,9 @@ static irqreturn_t ahci_interrupt (int i
 static int ahci_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	struct ahci_port_priv *pp = ap->private_data;
 	void *port_mmio = (void *) ap->ioaddr.cmd_addr;
 
 	if (qc->flags & ATA_QCFLAG_NCQ) {
-		pp->sactive |= (1 << qc->tag);
-
 		writel(1 << qc->tag, port_mmio + PORT_SCR_ACT);
 		readl(port_mmio + PORT_SCR_ACT);
 	}

