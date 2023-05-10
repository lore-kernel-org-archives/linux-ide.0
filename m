Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC663C7EE24
	for <linux-ide@archiver.kernel.org>; Wed, 10 May 2023 22:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbjEJWwk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 10 May 2023 18:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbjEJWwf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 10 May 2023 18:52:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A5A6188
        for <linux-ide@vger.kernel.org>; Wed, 10 May 2023 15:52:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D68A91FD6B;
        Wed, 10 May 2023 22:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683759141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fijsmnnxFB6vDJcQLvPi4C84D/e80Lsvp9YD1qm4Pok=;
        b=mdk8Q88WQ7Y+VFKoq1bu6cMRAEAXjmG0gYHEftIlCOboKl9V9UuLgvsdsWhU0Sk15zChhO
        DLxHfV8SEPM396oXQHC57iQ3iw6Q2wRAOuKyUlHFHj8CoCLg41QejIzNeH8GbsIYKeQ/CI
        VyUTEpkbnfdblavKUcHEK+2+Jxg9Ch4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683759141;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fijsmnnxFB6vDJcQLvPi4C84D/e80Lsvp9YD1qm4Pok=;
        b=QHPG27uyxY29bMQk98kgXsEZRsf2hshXVjrhjR5l6vl8gofSmLkinMYX+3kW/PhttnxJd7
        8Ik01PkdMUT4hwCw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id C9C2E2C142;
        Wed, 10 May 2023 22:52:21 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id BF4AB51C34E1; Thu, 11 May 2023 00:52:21 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/6] ata: remove reference to non-existing error_handler()
Date:   Thu, 11 May 2023 00:52:06 +0200
Message-Id: <20230510225211.111113-2-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230510225211.111113-1-hare@suse.de>
References: <20230510225211.111113-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

With commit 65a15d6560df ("scsi: ipr: Remove SATA support") all
libata drivers now have the error_handler() callback provided,
so we can stop checking for non-existing error_handler callback.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 158 ++++++++++++++------------------------
 drivers/ata/libata-eh.c   | 148 +++++++++++++++--------------------
 drivers/ata/libata-sata.c |   5 +-
 drivers/ata/libata-scsi.c |  21 ++---
 drivers/ata/libata-sff.c  |  32 +++-----
 5 files changed, 139 insertions(+), 225 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8bf612bdd61a..920ebea69cd8 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1556,13 +1556,11 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
 		}
 	}
 
-	if (ap->ops->error_handler)
-		ata_eh_release(ap);
+	ata_eh_release(ap);
 
 	rc = wait_for_completion_timeout(&wait, msecs_to_jiffies(timeout));
 
-	if (ap->ops->error_handler)
-		ata_eh_acquire(ap);
+	ata_eh_acquire(ap);
 
 	ata_sff_flush_pio_task(ap);
 
@@ -1577,10 +1575,7 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
 		if (qc->flags & ATA_QCFLAG_ACTIVE) {
 			qc->err_mask |= AC_ERR_TIMEOUT;
 
-			if (ap->ops->error_handler)
-				ata_port_freeze(ap);
-			else
-				ata_qc_complete(qc);
+			ata_port_freeze(ap);
 
 			ata_dev_warn(dev, "qc timeout after %u msecs (cmd 0x%x)\n",
 				     timeout, command);
@@ -4713,96 +4708,71 @@ static void ata_verify_xfer(struct ata_queued_cmd *qc)
 void ata_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
+	struct ata_device *dev = qc->dev;
+	struct ata_eh_info *ehi = &dev->link->eh_info;
 
 	/* Trigger the LED (if available) */
 	ledtrig_disk_activity(!!(qc->tf.flags & ATA_TFLAG_WRITE));
 
-	/* XXX: New EH and old EH use different mechanisms to
-	 * synchronize EH with regular execution path.
-	 *
-	 * In new EH, a qc owned by EH is marked with ATA_QCFLAG_EH.
-	 * Normal execution path is responsible for not accessing a
-	 * qc owned by EH.  libata core enforces the rule by returning NULL
-	 * from ata_qc_from_tag() for qcs owned by EH.
-	 *
-	 * Old EH depends on ata_qc_complete() nullifying completion
-	 * requests if ATA_QCFLAG_EH_SCHEDULED is set.  Old EH does
-	 * not synchronize with interrupt handler.  Only PIO task is
-	 * taken care of.
-	 */
-	if (ap->ops->error_handler) {
-		struct ata_device *dev = qc->dev;
-		struct ata_eh_info *ehi = &dev->link->eh_info;
-
-		if (unlikely(qc->err_mask))
-			qc->flags |= ATA_QCFLAG_EH;
-
-		/*
-		 * Finish internal commands without any further processing
-		 * and always with the result TF filled.
-		 */
-		if (unlikely(ata_tag_internal(qc->tag))) {
-			fill_result_tf(qc);
-			trace_ata_qc_complete_internal(qc);
-			__ata_qc_complete(qc);
-			return;
-		}
+	if (unlikely(qc->err_mask))
+		qc->flags |= ATA_QCFLAG_EH;
 
-		/*
-		 * Non-internal qc has failed.  Fill the result TF and
-		 * summon EH.
-		 */
-		if (unlikely(qc->flags & ATA_QCFLAG_EH)) {
-			fill_result_tf(qc);
-			trace_ata_qc_complete_failed(qc);
-			ata_qc_schedule_eh(qc);
-			return;
-		}
+	/*
+	 * Finish internal commands without any further processing
+	 * and always with the result TF filled.
+	 */
+	if (unlikely(ata_tag_internal(qc->tag))) {
+		fill_result_tf(qc);
+		trace_ata_qc_complete_internal(qc);
+		__ata_qc_complete(qc);
+		return;
+	}
 
-		WARN_ON_ONCE(ata_port_is_frozen(ap));
+	/*
+	 * Non-internal qc has failed.  Fill the result TF and
+	 * summon EH.
+	 */
+	if (unlikely(qc->flags & ATA_QCFLAG_EH)) {
+		fill_result_tf(qc);
+		trace_ata_qc_complete_failed(qc);
+		ata_qc_schedule_eh(qc);
+		return;
+	}
 
-		/* read result TF if requested */
-		if (qc->flags & ATA_QCFLAG_RESULT_TF)
-			fill_result_tf(qc);
+	WARN_ON_ONCE(ata_port_is_frozen(ap));
 
-		trace_ata_qc_complete_done(qc);
-		/* Some commands need post-processing after successful
-		 * completion.
-		 */
-		switch (qc->tf.command) {
-		case ATA_CMD_SET_FEATURES:
-			if (qc->tf.feature != SETFEATURES_WC_ON &&
-			    qc->tf.feature != SETFEATURES_WC_OFF &&
-			    qc->tf.feature != SETFEATURES_RA_ON &&
-			    qc->tf.feature != SETFEATURES_RA_OFF)
-				break;
-			fallthrough;
-		case ATA_CMD_INIT_DEV_PARAMS: /* CHS translation changed */
-		case ATA_CMD_SET_MULTI: /* multi_count changed */
-			/* revalidate device */
-			ehi->dev_action[dev->devno] |= ATA_EH_REVALIDATE;
-			ata_port_schedule_eh(ap);
-			break;
+	/* read result TF if requested */
+	if (qc->flags & ATA_QCFLAG_RESULT_TF)
+		fill_result_tf(qc);
 
-		case ATA_CMD_SLEEP:
-			dev->flags |= ATA_DFLAG_SLEEPING;
+	trace_ata_qc_complete_done(qc);
+	/* Some commands need post-processing after successful
+	 * completion.
+	 */
+	switch (qc->tf.command) {
+	case ATA_CMD_SET_FEATURES:
+		if (qc->tf.feature != SETFEATURES_WC_ON &&
+		    qc->tf.feature != SETFEATURES_WC_OFF &&
+		    qc->tf.feature != SETFEATURES_RA_ON &&
+		    qc->tf.feature != SETFEATURES_RA_OFF)
 			break;
-		}
-
-		if (unlikely(dev->flags & ATA_DFLAG_DUBIOUS_XFER))
-			ata_verify_xfer(qc);
+		fallthrough;
+	case ATA_CMD_INIT_DEV_PARAMS: /* CHS translation changed */
+	case ATA_CMD_SET_MULTI: /* multi_count changed */
+		/* revalidate device */
+		ehi->dev_action[dev->devno] |= ATA_EH_REVALIDATE;
+		ata_port_schedule_eh(ap);
+		break;
 
-		__ata_qc_complete(qc);
-	} else {
-		if (qc->flags & ATA_QCFLAG_EH_SCHEDULED)
-			return;
+	case ATA_CMD_SLEEP:
+		dev->flags |= ATA_DFLAG_SLEEPING;
+		break;
+	}
 
-		/* read result TF if failed or requested */
-		if (qc->err_mask || qc->flags & ATA_QCFLAG_RESULT_TF)
-			fill_result_tf(qc);
+	if (unlikely(dev->flags & ATA_DFLAG_DUBIOUS_XFER))
+		ata_verify_xfer(qc);
 
-		__ata_qc_complete(qc);
-	}
+	__ata_qc_complete(qc);
 }
 EXPORT_SYMBOL_GPL(ata_qc_complete);
 
@@ -4852,7 +4822,7 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 	 * check is skipped for old EH because it reuses active qc to
 	 * request ATAPI sense.
 	 */
-	WARN_ON_ONCE(ap->ops->error_handler && ata_tag_valid(link->active_tag));
+	WARN_ON_ONCE(ata_tag_valid(link->active_tag));
 
 	if (ata_is_ncq(prot)) {
 		WARN_ON_ONCE(link->sactive & (1 << qc->hw_tag));
@@ -5725,15 +5695,9 @@ void __ata_port_probe(struct ata_port *ap)
 
 int ata_port_probe(struct ata_port *ap)
 {
-	int rc = 0;
-
-	if (ap->ops->error_handler) {
-		__ata_port_probe(ap);
-		ata_port_wait_eh(ap);
-	} else {
-		rc = ata_bus_probe(ap);
-	}
-	return rc;
+	__ata_port_probe(ap);
+	ata_port_wait_eh(ap);
+	return 0;
 }
 
 
@@ -5938,9 +5902,6 @@ static void ata_port_detach(struct ata_port *ap)
 	struct ata_link *link;
 	struct ata_device *dev;
 
-	if (!ap->ops->error_handler)
-		goto skip_eh;
-
 	/* tell EH we're leaving & flush EH */
 	spin_lock_irqsave(ap->lock, flags);
 	ap->pflags |= ATA_PFLAG_UNLOADING;
@@ -5955,7 +5916,6 @@ static void ata_port_detach(struct ata_port *ap)
 
 	cancel_delayed_work_sync(&ap->hotplug_task);
 
- skip_eh:
 	/* clean up zpodd on port removal */
 	ata_for_each_link(link, ap, HOST_FIRST) {
 		ata_for_each_dev(dev, link, ALL) {
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index a6c901811802..b41a578a8c8b 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -571,9 +571,6 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
 	/* make sure sff pio task is not running */
 	ata_sff_flush_pio_task(ap);
 
-	if (!ap->ops->error_handler)
-		return;
-
 	/* synchronize with host lock and sort out timeouts */
 
 	/*
@@ -659,94 +656,89 @@ EXPORT_SYMBOL(ata_scsi_cmd_error_handler);
 void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap)
 {
 	unsigned long flags;
+	struct ata_link *link;
 
 	/* invoke error handler */
-	if (ap->ops->error_handler) {
-		struct ata_link *link;
 
-		/* acquire EH ownership */
-		ata_eh_acquire(ap);
+	/* acquire EH ownership */
+	ata_eh_acquire(ap);
  repeat:
-		/* kill fast drain timer */
-		del_timer_sync(&ap->fastdrain_timer);
+	/* kill fast drain timer */
+	del_timer_sync(&ap->fastdrain_timer);
 
-		/* process port resume request */
-		ata_eh_handle_port_resume(ap);
+	/* process port resume request */
+	ata_eh_handle_port_resume(ap);
 
-		/* fetch & clear EH info */
-		spin_lock_irqsave(ap->lock, flags);
+	/* fetch & clear EH info */
+	spin_lock_irqsave(ap->lock, flags);
 
-		ata_for_each_link(link, ap, HOST_FIRST) {
-			struct ata_eh_context *ehc = &link->eh_context;
-			struct ata_device *dev;
+	ata_for_each_link(link, ap, HOST_FIRST) {
+		struct ata_eh_context *ehc = &link->eh_context;
+		struct ata_device *dev;
 
-			memset(&link->eh_context, 0, sizeof(link->eh_context));
-			link->eh_context.i = link->eh_info;
-			memset(&link->eh_info, 0, sizeof(link->eh_info));
+		memset(&link->eh_context, 0, sizeof(link->eh_context));
+		link->eh_context.i = link->eh_info;
+		memset(&link->eh_info, 0, sizeof(link->eh_info));
 
-			ata_for_each_dev(dev, link, ENABLED) {
-				int devno = dev->devno;
+		ata_for_each_dev(dev, link, ENABLED) {
+			int devno = dev->devno;
 
-				ehc->saved_xfer_mode[devno] = dev->xfer_mode;
-				if (ata_ncq_enabled(dev))
-					ehc->saved_ncq_enabled |= 1 << devno;
-			}
+			ehc->saved_xfer_mode[devno] = dev->xfer_mode;
+			if (ata_ncq_enabled(dev))
+				ehc->saved_ncq_enabled |= 1 << devno;
 		}
+	}
 
-		ap->pflags |= ATA_PFLAG_EH_IN_PROGRESS;
-		ap->pflags &= ~ATA_PFLAG_EH_PENDING;
-		ap->excl_link = NULL;	/* don't maintain exclusion over EH */
+	ap->pflags |= ATA_PFLAG_EH_IN_PROGRESS;
+	ap->pflags &= ~ATA_PFLAG_EH_PENDING;
+	ap->excl_link = NULL;	/* don't maintain exclusion over EH */
 
-		spin_unlock_irqrestore(ap->lock, flags);
+	spin_unlock_irqrestore(ap->lock, flags);
 
-		/* invoke EH, skip if unloading or suspended */
-		if (!(ap->pflags & (ATA_PFLAG_UNLOADING | ATA_PFLAG_SUSPENDED)))
-			ap->ops->error_handler(ap);
-		else {
-			/* if unloading, commence suicide */
-			if ((ap->pflags & ATA_PFLAG_UNLOADING) &&
-			    !(ap->pflags & ATA_PFLAG_UNLOADED))
-				ata_eh_unload(ap);
-			ata_eh_finish(ap);
-		}
+	/* invoke EH, skip if unloading or suspended */
+	if (!(ap->pflags & (ATA_PFLAG_UNLOADING | ATA_PFLAG_SUSPENDED)))
+		ap->ops->error_handler(ap);
+	else {
+		/* if unloading, commence suicide */
+		if ((ap->pflags & ATA_PFLAG_UNLOADING) &&
+		    !(ap->pflags & ATA_PFLAG_UNLOADED))
+			ata_eh_unload(ap);
+		ata_eh_finish(ap);
+	}
 
-		/* process port suspend request */
-		ata_eh_handle_port_suspend(ap);
+	/* process port suspend request */
+	ata_eh_handle_port_suspend(ap);
 
-		/* Exception might have happened after ->error_handler
-		 * recovered the port but before this point.  Repeat
-		 * EH in such case.
-		 */
-		spin_lock_irqsave(ap->lock, flags);
+	/* Exception might have happened after ->error_handler
+	 * recovered the port but before this point.  Repeat
+	 * EH in such case.
+	 */
+	spin_lock_irqsave(ap->lock, flags);
 
-		if (ap->pflags & ATA_PFLAG_EH_PENDING) {
-			if (--ap->eh_tries) {
-				spin_unlock_irqrestore(ap->lock, flags);
-				goto repeat;
-			}
-			ata_port_err(ap,
-				     "EH pending after %d tries, giving up\n",
-				     ATA_EH_MAX_TRIES);
-			ap->pflags &= ~ATA_PFLAG_EH_PENDING;
+	if (ap->pflags & ATA_PFLAG_EH_PENDING) {
+		if (--ap->eh_tries) {
+			spin_unlock_irqrestore(ap->lock, flags);
+			goto repeat;
 		}
+		ata_port_err(ap,
+			     "EH pending after %d tries, giving up\n",
+			     ATA_EH_MAX_TRIES);
+		ap->pflags &= ~ATA_PFLAG_EH_PENDING;
+	}
 
-		/* this run is complete, make sure EH info is clear */
-		ata_for_each_link(link, ap, HOST_FIRST)
-			memset(&link->eh_info, 0, sizeof(link->eh_info));
+	/* this run is complete, make sure EH info is clear */
+	ata_for_each_link(link, ap, HOST_FIRST)
+		memset(&link->eh_info, 0, sizeof(link->eh_info));
 
-		/* end eh (clear host_eh_scheduled) while holding
-		 * ap->lock such that if exception occurs after this
-		 * point but before EH completion, SCSI midlayer will
-		 * re-initiate EH.
-		 */
-		ap->ops->end_eh(ap);
+	/* end eh (clear host_eh_scheduled) while holding
+	 * ap->lock such that if exception occurs after this
+	 * point but before EH completion, SCSI midlayer will
+	 * re-initiate EH.
+	 */
+	ap->ops->end_eh(ap);
 
-		spin_unlock_irqrestore(ap->lock, flags);
-		ata_eh_release(ap);
-	} else {
-		WARN_ON(ata_qc_from_tag(ap, ap->link.active_tag) == NULL);
-		ap->ops->eng_timeout(ap);
-	}
+	spin_unlock_irqrestore(ap->lock, flags);
+	ata_eh_release(ap);
 
 	scsi_eh_flush_done_q(&ap->eh_done_q);
 
@@ -912,8 +904,6 @@ void ata_qc_schedule_eh(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 
-	WARN_ON(!ap->ops->error_handler);
-
 	qc->flags |= ATA_QCFLAG_EH;
 	ata_eh_set_pending(ap, 1);
 
@@ -934,8 +924,6 @@ void ata_qc_schedule_eh(struct ata_queued_cmd *qc)
  */
 void ata_std_sched_eh(struct ata_port *ap)
 {
-	WARN_ON(!ap->ops->error_handler);
-
 	if (ap->pflags & ATA_PFLAG_INITIALIZING)
 		return;
 
@@ -989,8 +977,6 @@ static int ata_do_link_abort(struct ata_port *ap, struct ata_link *link)
 	struct ata_queued_cmd *qc;
 	int tag, nr_aborted = 0;
 
-	WARN_ON(!ap->ops->error_handler);
-
 	/* we're gonna abort all commands, no need for fast drain */
 	ata_eh_set_pending(ap, 0);
 
@@ -1065,8 +1051,6 @@ EXPORT_SYMBOL_GPL(ata_port_abort);
  */
 static void __ata_port_freeze(struct ata_port *ap)
 {
-	WARN_ON(!ap->ops->error_handler);
-
 	if (ap->ops->freeze)
 		ap->ops->freeze(ap);
 
@@ -1091,8 +1075,6 @@ static void __ata_port_freeze(struct ata_port *ap)
  */
 int ata_port_freeze(struct ata_port *ap)
 {
-	WARN_ON(!ap->ops->error_handler);
-
 	__ata_port_freeze(ap);
 
 	return ata_port_abort(ap);
@@ -1112,9 +1094,6 @@ void ata_eh_freeze_port(struct ata_port *ap)
 {
 	unsigned long flags;
 
-	if (!ap->ops->error_handler)
-		return;
-
 	spin_lock_irqsave(ap->lock, flags);
 	__ata_port_freeze(ap);
 	spin_unlock_irqrestore(ap->lock, flags);
@@ -1134,9 +1113,6 @@ void ata_eh_thaw_port(struct ata_port *ap)
 {
 	unsigned long flags;
 
-	if (!ap->ops->error_handler)
-		return;
-
 	spin_lock_irqsave(ap->lock, flags);
 
 	ap->pflags &= ~ATA_PFLAG_FROZEN;
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index f3e7396e3191..bd2a754b645c 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1138,11 +1138,8 @@ EXPORT_SYMBOL_GPL(ata_sas_port_alloc);
 int ata_sas_port_start(struct ata_port *ap)
 {
 	/*
-	 * the port is marked as frozen at allocation time, but if we don't
-	 * have new eh, we won't thaw it
+	 * the port is marked as frozen at allocation time
 	 */
-	if (!ap->ops->error_handler)
-		ap->pflags &= ~ATA_PFLAG_FROZEN;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ata_sas_port_start);
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 7bb12deab70c..cad8e826b262 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -906,7 +906,6 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 	struct ata_taskfile *tf = &qc->result_tf;
 	unsigned char *sb = cmd->sense_buffer;
 	unsigned char *desc = sb + 8;
-	int verbose = qc->ap->ops->error_handler == NULL;
 	u8 sense_key, asc, ascq;
 
 	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
@@ -918,7 +917,7 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 	if (qc->err_mask ||
 	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
 		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
-				   &sense_key, &asc, &ascq, verbose);
+				   &sense_key, &asc, &ascq, false);
 		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
 	} else {
 		/*
@@ -1001,7 +1000,6 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->result_tf;
 	unsigned char *sb = cmd->sense_buffer;
-	int verbose = qc->ap->ops->error_handler == NULL;
 	u64 block;
 	u8 sense_key, asc, ascq;
 
@@ -1019,7 +1017,7 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 	if (qc->err_mask ||
 	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
 		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
-				   &sense_key, &asc, &ascq, verbose);
+				   &sense_key, &asc, &ascq, false);
 		ata_scsi_set_sense(dev, cmd, sense_key, asc, ascq);
 	} else {
 		/* Could not decode error */
@@ -1181,9 +1179,6 @@ void ata_scsi_slave_destroy(struct scsi_device *sdev)
 	unsigned long flags;
 	struct ata_device *dev;
 
-	if (!ap->ops->error_handler)
-		return;
-
 	spin_lock_irqsave(ap->lock, flags);
 	dev = __ata_scsi_find_dev(ap, sdev);
 	if (dev && dev->sdev) {
@@ -1656,7 +1651,6 @@ static void ata_qc_done(struct ata_queued_cmd *qc)
 
 static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 {
-	struct ata_port *ap = qc->ap;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	u8 *cdb = cmd->cmnd;
 	int need_sense = (qc->err_mask != 0) &&
@@ -1680,9 +1674,8 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 		/* Keep the SCSI ML and status byte, clear host byte. */
 		cmd->result &= 0x0000ffff;
 
-	if (need_sense && !ap->ops->error_handler)
-		ata_dump_status(ap, &qc->result_tf);
-
+	if (!(qc->flags & ATA_QCFLAG_QUIET))
+		ata_dump_status(qc->ap, &qc->result_tf);
 	ata_qc_done(qc);
 }
 
@@ -2548,8 +2541,7 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
 	unsigned int err_mask = qc->err_mask;
 
 	/* handle completion from new EH */
-	if (unlikely(qc->ap->ops->error_handler &&
-		     (err_mask || qc->flags & ATA_QCFLAG_SENSE_VALID))) {
+	if (unlikely(err_mask || qc->flags & ATA_QCFLAG_SENSE_VALID)) {
 
 		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID)) {
 			/* FIXME: not quite right; we don't want the
@@ -4519,9 +4511,6 @@ int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
 	unsigned long flags;
 	int devno, rc = 0;
 
-	if (!ap->ops->error_handler)
-		return -EOPNOTSUPP;
-
 	if (lun != SCAN_WILD_CARD && lun)
 		return -EINVAL;
 
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 9d28badfe41d..aa286d48e847 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -883,31 +883,23 @@ static void ata_hsm_qc_complete(struct ata_queued_cmd *qc, int in_wq)
 {
 	struct ata_port *ap = qc->ap;
 
-	if (ap->ops->error_handler) {
-		if (in_wq) {
-			/* EH might have kicked in while host lock is
-			 * released.
-			 */
-			qc = ata_qc_from_tag(ap, qc->tag);
-			if (qc) {
-				if (likely(!(qc->err_mask & AC_ERR_HSM))) {
-					ata_sff_irq_on(ap);
-					ata_qc_complete(qc);
-				} else
-					ata_port_freeze(ap);
-			}
-		} else {
-			if (likely(!(qc->err_mask & AC_ERR_HSM)))
+	if (in_wq) {
+		/* EH might have kicked in while host lock is
+		 * released.
+		 */
+		qc = ata_qc_from_tag(ap, qc->tag);
+		if (qc) {
+			if (likely(!(qc->err_mask & AC_ERR_HSM))) {
+				ata_sff_irq_on(ap);
 				ata_qc_complete(qc);
-			else
+			} else
 				ata_port_freeze(ap);
 		}
 	} else {
-		if (in_wq) {
-			ata_sff_irq_on(ap);
-			ata_qc_complete(qc);
-		} else
+		if (likely(!(qc->err_mask & AC_ERR_HSM)))
 			ata_qc_complete(qc);
+		else
+			ata_port_freeze(ap);
 	}
 }
 
-- 
2.35.3

