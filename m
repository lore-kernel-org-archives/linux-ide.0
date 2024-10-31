Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8723F19DF99
	for <linux-ide@vger.kernel.org>; Thu, 31 Oct 2024 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730383672; cv=none; b=CzBckgzP1IplMAgWLKWevqsk1rz6RWctQPFOb4ULoMY+Txnaf1wGnOi5CCD4FbSuF73wKcykiMq/SjdmLcbQHwnaOWao2ANBNqNaqW9oYnL249XsWaeLRB5Dp3v/IE8EJPDrySawUMnSA88dQsMSW5VwbXEXU4hNLxjkMf8/SyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730383672; c=relaxed/simple;
	bh=Vn5Xbkv5q0VinZNfOmW/r/6nFajYJIfPTgww+E48F7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhMRpgYZUv614iEgunY+KoYQD0HFoBHTP9i/xV8rYYgs+dutHnqUiR1qbH+6X/uZ72diTuXTSiKUcbP+BpWSlgKycEdF4YiIJG/Bo6+PeLr6q6bJeDcsqE4o5bsBywWkIT8R/MNEISZpSA3N/jpOFp8kdeFG+tmwNJ7opUgHcOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epthx5A7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epthx5A7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55BEC4CEFF;
	Thu, 31 Oct 2024 14:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730383672;
	bh=Vn5Xbkv5q0VinZNfOmW/r/6nFajYJIfPTgww+E48F7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=epthx5A7WSUPoGFDNFnTuaWrPwcgcl2gFNQnAHc6d5xhSHkBDRH5zjGLLkT6lPwDn
	 PCKXrQCTkI7mH0Me5IRVY3Y0JWfoqDeFAFIYdu8Z91rbGtUbK09a4Z4A4ZdavoeK0c
	 kldLnyEXboIGpcHww7ySMc6yUo6MZIlWQOtjZo4ALdCRmTJZtHG4Zbx8ScIeNc3Mtp
	 RghWSlLmwR/HtWZNDRwKLjhmI3PmJ9cKU1Q2AFBqcZ0Ncl/CRXZ5lklte/qBRVw1Ys
	 KjDxwG7IiBDAELl7NOMVuvnYpMIEng0rbU/dIxwYc1WONO3Sq+TyHGoa+yhPANxfzY
	 vpnfzBXOuTSaA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>,
	Xingui Yang <yangxingui@huawei.com>,
	Yu Kuai <yukuai1@huaweicloud.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH 2/2] ata: libata: Issue non-NCQ command via EH when NCQ commands in-flight
Date: Thu, 31 Oct 2024 15:07:33 +0100
Message-ID: <20241031140731.224589-6-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031140731.224589-4-cassel@kernel.org>
References: <20241031140731.224589-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15105; i=cassel@kernel.org; h=from:subject; bh=Vn5Xbkv5q0VinZNfOmW/r/6nFajYJIfPTgww+E48F7M=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNKV+1W8HjzfKJzE//1PEHdWRvgyl/xk2acJf/3ErxuWm 9X2zo/tKGVhEONikBVTZPH94bK/uNt9ynHFOzYwc1iZQIYwcHEKwESWX2RkeF3sYqd26XgXy51F y5kF1nztCMuYZX3x+vSzCSXPKnSWOjMydP9a0uK944GA1tbcN6H8d+zN7J1O9ShG/nGLj1Lte/e GGwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

libata is responsible to ensure that NCQ and non-NCQ commands are not mixed
in the command list for the same device.

This is handled using the .qc_defer callback (ata_std_qc_defer()), which
will defer a non-NCQ command as long as there are NCQ commands in flight.

The problem is that if an application is continuously submitting NCQ
commands (e.g. fio with a queue depth greater than 1), this can completely
starve out another application that is sending a non-NCQ command (because
the non-NCQ command will be deferred forever).

Solve this by triggering EH if there are NCQ commands in flight when a
non-NCQ is submitted. If EH is scheduled, no new commands will be accepted,
and EH will wake up when there are no commands in flight. We will then
submit the non-NCQ command from EH context, and synchronously wait for the
completion. When EH is finished, libata will continue to accept new
commands like normal.

Reported-by: Xingui Yang <yangxingui@huawei.com>
Closes: https://lore.kernel.org/linux-block/eef1e927-c9b2-c61d-7f48-92e65d8b0418@huawei.com/
Suggested-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 169 +++++++++++++++++++++++++++++++++++---
 drivers/ata/libata-eh.c   |  60 +++++++++++++-
 drivers/ata/libata-scsi.c |  16 +++-
 drivers/ata/libata.h      |   1 +
 include/linux/libata.h    |   7 +-
 5 files changed, 237 insertions(+), 16 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2b7d265e4a7b..c53de1d3baba 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1633,6 +1633,134 @@ unsigned int ata_exec_internal(struct ata_device *dev, struct ata_taskfile *tf,
 	return err_mask;
 }
 
+/**
+ *	ata_issue_via_eh - issue non-NCQ command via EH synchronously
+ *	@qc: command to issue to device
+ *
+ *	Issues a non-NCQ command via EH and waits for completion. @qc contains
+ *	the command on entry and the result on return. Timeout and error
+ *	conditions are reported via the return value. No recovery action is
+ *	needed, since flag ATA_QCFLAG_EH is set on entry and on exit, so in case
+ *	of error, EH will clean it up during ata_eh_finish().
+ *
+ *	LOCKING:
+ *	None.  Should be called with kernel context, might sleep.
+ *
+ *	RETURNS:
+ *	Zero on success, AC_ERR_* mask on failure
+ */
+unsigned int ata_issue_via_eh(struct ata_queued_cmd *qc)
+{
+	struct ata_device *dev = qc->dev;
+	struct ata_port *ap = qc->ap;
+	u8 command = qc->tf.command;
+	ata_qc_cb_t orig_complete_fn = qc->complete_fn;
+	bool auto_timeout = false;
+	DECLARE_COMPLETION_ONSTACK(wait);
+	unsigned long flags;
+	unsigned int err_mask;
+	unsigned int timeout = 0;
+	int rc;
+
+	spin_lock_irqsave(ap->lock, flags);
+
+	/* This function is only for ATA_QCFLAG_NEED_ISSUE_VIA_EH commands */
+	if (!(qc->flags & ATA_QCFLAG_NEED_ISSUE_VIA_EH)) {
+		spin_unlock_irqrestore(ap->lock, flags);
+		return AC_ERR_INVALID;
+	}
+
+	if (ata_port_is_frozen(ap)) {
+		/*
+		 * If the port is frozen, we will not issue any command, so set
+		 * ATA_QCFLAG_RETRY, so that the command is potentially retried,
+		 * and so that we avoid scrutiny by ata_eh_link_autopsy().
+		 */
+		qc->flags |= ATA_QCFLAG_RETRY;
+		spin_unlock_irqrestore(ap->lock, flags);
+		return AC_ERR_SYSTEM;
+	}
+
+	/*
+	 * Temporarily clear ATA_QCFLAG_EH, such that ata_port_freeze() will
+	 * call ata_qc_complete() on the command if it times out.
+	 * (So that we behave similar to ata_exec_internal().)
+	 */
+	qc->flags &= ~ATA_QCFLAG_EH;
+	qc->flags &= ~ATA_QCFLAG_NEED_ISSUE_VIA_EH;
+	qc->flags |= ATA_QCFLAG_ISSUED_VIA_EH | ATA_QCFLAG_RESULT_TF;
+	qc->private_data = &wait;
+	qc->complete_fn = ata_qc_complete_internal;
+
+	ata_qc_issue(qc);
+
+	spin_unlock_irqrestore(ap->lock, flags);
+
+	if (!timeout) {
+		if (ata_probe_timeout) {
+			timeout = ata_probe_timeout * 1000;
+		} else {
+			timeout = ata_internal_cmd_timeout(dev, command);
+			auto_timeout = true;
+		}
+	}
+
+	ata_eh_release(ap);
+
+	rc = wait_for_completion_timeout(&wait, msecs_to_jiffies(timeout));
+
+	ata_eh_acquire(ap);
+
+	ata_sff_flush_pio_task(ap);
+
+	if (!rc) {
+		/*
+		 * We are racing with irq here. If we lose, the following test
+		 * prevents us from completing the qc twice. If we win, the port
+		 * is frozen and will be cleaned up by ->post_internal_cmd().
+		 */
+		spin_lock_irqsave(ap->lock, flags);
+		if (qc->flags & ATA_QCFLAG_ACTIVE) {
+			qc->err_mask |= AC_ERR_TIMEOUT;
+			/*
+			 * ata_port_freeze() above will cause an abort, which
+			 * will call ata_qc_complete() (and thus
+			 * __ata_qc_complete()), so after this call,
+			 * ATA_QCFLAG_ACTIVE will no longer be set, and the
+			 * DMA mapping will have been cleaned up.
+			 */
+			ata_port_freeze(ap);
+			ata_dev_warn(dev, "qc timeout after %u msecs (cmd 0x%x)\n",
+				     timeout, command);
+		}
+		spin_unlock_irqrestore(ap->lock, flags);
+	}
+
+	if (ap->ops->post_internal_cmd)
+		ap->ops->post_internal_cmd(qc);
+
+	/* Finish up */
+	spin_lock_irqsave(ap->lock, flags);
+
+	err_mask = qc->err_mask;
+
+	/* Restore QC */
+	qc->flags |= ATA_QCFLAG_EH;
+	qc->complete_fn = orig_complete_fn;
+	if (!qc->err_mask) {
+		qc->scsicmd->flags |= SCMD_FORCE_EH_SUCCESS;
+		qc->flags |= ATA_QCFLAG_EH_SUCCESS_CMD;
+		ata_qc_complete_success(qc);
+	}
+
+	spin_unlock_irqrestore(ap->lock, flags);
+
+	if ((err_mask & AC_ERR_TIMEOUT) && auto_timeout)
+		ata_internal_cmd_timed_out(dev, command);
+
+	return err_mask;
+}
+
 /**
  *	ata_pio_need_iordy	-	check if iordy needed
  *	@adev: ATA device
@@ -4574,12 +4702,14 @@ int ata_std_qc_defer(struct ata_queued_cmd *qc)
 	if (ata_is_ncq(qc->tf.protocol)) {
 		if (!ata_tag_valid(link->active_tag))
 			return 0;
+		return ATA_DEFER_LINK;
 	} else {
 		if (!ata_tag_valid(link->active_tag) && !link->sactive)
 			return 0;
+		if (ata_tag_valid(link->active_tag))
+			return ATA_DEFER_LINK;
+		return ATA_DEFER_ISSUE_VIA_EH;
 	}
-
-	return ATA_DEFER_LINK;
 }
 EXPORT_SYMBOL_GPL(ata_std_qc_defer);
 
@@ -4781,12 +4911,16 @@ static void ata_verify_xfer(struct ata_queued_cmd *qc)
  *
  *	When a QC receives a successful completion, we need to perform some
  *	additional post processing.
+ *	Note that a QC that received a successful completion might have flag
+ *	ATA_QCFLAG_EH (and ATA_QCFLAG_ISSUED_VIA_EH) set if the QC was issued
+ *	from EH context.
  */
 void ata_qc_complete_success(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_device *dev = qc->dev;
 	struct ata_eh_info *ehi = &dev->link->eh_info;
+	bool issued_via_eh = qc->flags & ATA_QCFLAG_ISSUED_VIA_EH;
 
 	WARN_ON_ONCE(ata_port_is_frozen(ap));
 
@@ -4812,13 +4946,16 @@ void ata_qc_complete_success(struct ata_queued_cmd *qc)
 		qc->flags |= ATA_QCFLAG_EH_SUCCESS_CMD;
 		ehi->dev_action[dev->devno] |= ATA_EH_GET_SUCCESS_SENSE;
 
-		/*
-		 * set pending so that ata_qc_schedule_eh() does not trigger
-		 * fast drain, and freeze the port.
-		 */
-		ap->pflags |= ATA_PFLAG_EH_PENDING;
-		ata_qc_schedule_eh(qc);
-		return;
+		/* Do not schedule EH for a command that is already in EH */
+		if (!issued_via_eh) {
+			/*
+			 * set pending so that ata_qc_schedule_eh() does not
+			 * trigger fast drain, and freeze the port.
+			 */
+			ap->pflags |= ATA_PFLAG_EH_PENDING;
+			ata_qc_schedule_eh(qc);
+			return;
+		}
 	}
 
 	/* Some commands need post-processing after successful completion. */
@@ -4845,7 +4982,15 @@ void ata_qc_complete_success(struct ata_queued_cmd *qc)
 	if (unlikely(dev->flags & ATA_DFLAG_DUBIOUS_XFER))
 		ata_verify_xfer(qc);
 
-	__ata_qc_complete(qc);
+	/*
+	 * For a command that was issued via EH, regardless if we got a
+	 * completion (IRQ -> ata_qc_complete()), or if the command didn't
+	 * receive a completion within timeout time (ata_port_freeze() will have
+	 * called ata_qc_complete() on all commands). In either case
+	 * ata_qc_complete() will have called __ata_qc_complete() already.
+	 */
+	if (!issued_via_eh)
+		__ata_qc_complete(qc);
 }
 
 /**
@@ -4865,6 +5010,8 @@ void ata_qc_complete_success(struct ata_queued_cmd *qc)
  */
 void ata_qc_complete(struct ata_queued_cmd *qc)
 {
+	bool issued_via_eh = qc->flags & ATA_QCFLAG_ISSUED_VIA_EH;
+
 	/* Trigger the LED (if available) */
 	ledtrig_disk_activity(!!(qc->tf.flags & ATA_TFLAG_WRITE));
 
@@ -4883,7 +5030,7 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
 	 * Finish internal commands without any further processing and always
 	 * with the result TF filled.
 	 */
-	if (unlikely(ata_tag_internal(qc->tag))) {
+	if (unlikely(ata_tag_internal(qc->tag) || issued_via_eh)) {
 		fill_result_tf(qc);
 		trace_ata_qc_complete_internal(qc);
 		__ata_qc_complete(qc);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 3b303d4ae37a..7d30f2c996a9 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1182,7 +1182,35 @@ static void __ata_eh_qc_complete(struct ata_queued_cmd *qc)
 
 	spin_lock_irqsave(ap->lock, flags);
 	qc->scsidone = ata_eh_scsidone;
-	__ata_qc_complete(qc);
+	if (qc->flags & ATA_QCFLAG_NEED_ISSUE_VIA_EH) {
+		/*
+		 * A command that still has ATA_QCFLAG_NEED_ISSUE_VIA_EH set,
+		 * was never issued to the device (and has no DMA mapping), so
+		 * it would be wrong to call __ata_qc_complete(). Such a command
+		 * will be retried by upper layers. Simply call complete_fn() so
+		 * that the QC will be freed.
+		 */
+		WARN_ON_ONCE(qc->flags & ATA_QCFLAG_ACTIVE);
+		qc->complete_fn(qc);
+	} else if (qc->flags & ATA_QCFLAG_ISSUED_VIA_EH) {
+		/*
+		 * For a command that was issued via EH, regardless if we got a
+		 * completion (IRQ -> ata_qc_complete()), or if the command
+		 * didn't receive a completion within timeout time
+		 * (ata_port_freeze() will have called ata_qc_complete() on all
+		 * commands). In either case ata_qc_complete() will have called
+		 * __ata_qc_complete() already.
+		 *
+		 * Simply call complete_fn() to call the original complete_fn().
+		 * (For ATA_QCFLAG_ISSUED_VIA_EH commands, complete_fn() is
+		 * temporarily overloaded, to complete the "struct completion".
+		 * Thus, we still need to call the original complete_fn() here.)
+		 */
+		WARN_ON_ONCE(qc->flags & ATA_QCFLAG_ACTIVE);
+		qc->complete_fn(qc);
+	} else {
+		__ata_qc_complete(qc);
+	}
 	WARN_ON(ata_tag_valid(qc->tag));
 	spin_unlock_irqrestore(ap->lock, flags);
 
@@ -2066,6 +2094,28 @@ static void ata_eh_get_success_sense(struct ata_link *link)
 	ata_eh_done(link, dev, ATA_EH_GET_SUCCESS_SENSE);
 }
 
+static void ata_eh_issue_deferred_cmd(struct ata_link *link)
+{
+	struct ata_eh_context *ehc = &link->eh_context;
+	struct ata_device *dev = link->device;
+	struct ata_port *ap = link->ap;
+	struct ata_queued_cmd *qc;
+	int tag;
+
+	if (!(ehc->i.dev_action[dev->devno] & ATA_EH_ISSUE_DEFERRED_CMD))
+		return;
+
+	ata_qc_for_each_raw(ap, qc, tag) {
+		if (!(qc->flags & ATA_QCFLAG_NEED_ISSUE_VIA_EH) ||
+		    qc->err_mask ||
+		    ata_dev_phys_link(qc->dev) != link)
+			continue;
+
+		ata_issue_via_eh(qc);
+	}
+	ata_eh_done(link, dev, ATA_EH_ISSUE_DEFERRED_CMD);
+}
+
 /**
  *	ata_eh_link_autopsy - analyze error and determine recovery action
  *	@link: host link to perform autopsy on
@@ -2106,6 +2156,14 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 	/* analyze NCQ failure */
 	ata_eh_analyze_ncq_error(link);
 
+	/*
+	 * Issue deferred non-NCQ command if needed, this should be done before
+	 * ata_eh_get_success_sense(), as the non-NCQ command completion might
+	 * have ATA_SENSE set. Issuing a non-NCQ command will not affect the
+	 * Successful NCQ commands log.
+	 */
+	ata_eh_issue_deferred_cmd(link);
+
 	/*
 	 * Check if this was a successful command that simply needs sense data.
 	 * Since the sense data is not part of the completion, we need to fetch
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index f915e3df57a9..966059f82386 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1774,11 +1774,21 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 	return 0;
 
 defer:
-	ata_qc_free(qc);
-	if (rc == ATA_DEFER_LINK)
+	switch (rc) {
+	case ATA_DEFER_LINK:
+		ata_qc_free(qc);
 		return SCSI_MLQUEUE_DEVICE_BUSY;
-	else
+	case ATA_DEFER_PORT:
+		ata_qc_free(qc);
 		return SCSI_MLQUEUE_HOST_BUSY;
+	case ATA_DEFER_ISSUE_VIA_EH:
+		qc->flags |= ATA_QCFLAG_NEED_ISSUE_VIA_EH;
+		dev->link->eh_info.dev_action[dev->devno] |= ATA_EH_ISSUE_DEFERRED_CMD;
+		ata_qc_schedule_eh(qc);
+		return 0;
+	}
+
+	return 0;
 }
 
 struct ata_scsi_args {
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 0337be4faec7..bc84ed26f530 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -59,6 +59,7 @@ unsigned int ata_exec_internal(struct ata_device *dev, struct ata_taskfile *tf,
 			       const u8 *cdb, enum dma_data_direction dma_dir,
 			       void *buf, unsigned int buflen,
 			       unsigned int timeout);
+unsigned int ata_issue_via_eh(struct ata_queued_cmd *qc);
 extern int ata_wait_ready(struct ata_link *link, unsigned long deadline,
 			  int (*check_ready)(struct ata_link *link));
 extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e6c80557a8c7..e89f83025555 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -257,6 +257,8 @@ enum {
 	ATA_QCFLAG_SENSE_VALID	= (1 << 17), /* sense data valid */
 	ATA_QCFLAG_EH_SCHEDULED = (1 << 18), /* EH scheduled (obsolete) */
 	ATA_QCFLAG_EH_SUCCESS_CMD = (1 << 19), /* EH should fetch sense for this successful cmd */
+	ATA_QCFLAG_NEED_ISSUE_VIA_EH = (1 << 20), /* The command should be issued from EH context */
+	ATA_QCFLAG_ISSUED_VIA_EH = (1 << 21), /* The command has been issued from EH context */
 
 	/* host set flags */
 	ATA_HOST_SIMPLEX	= (1 << 0),	/* Host is simplex, one DMA channel per host only */
@@ -348,6 +350,7 @@ enum {
 	/* return values for ->qc_defer */
 	ATA_DEFER_LINK		= 1,
 	ATA_DEFER_PORT		= 2,
+	ATA_DEFER_ISSUE_VIA_EH	= 3,
 
 	/* desc_len for ata_eh_info and context */
 	ATA_EH_DESC_LEN		= 80,
@@ -361,9 +364,11 @@ enum {
 	ATA_EH_PARK		= (1 << 5), /* unload heads and stop I/O */
 	ATA_EH_GET_SUCCESS_SENSE = (1 << 6), /* Get sense data for successful cmd */
 	ATA_EH_SET_ACTIVE	= (1 << 7), /* Set a device to active power mode */
+	ATA_EH_ISSUE_DEFERRED_CMD = (1 << 8), /* Issue a deferred cmd from EH context */
 
 	ATA_EH_PERDEV_MASK	= ATA_EH_REVALIDATE | ATA_EH_PARK |
-				  ATA_EH_GET_SUCCESS_SENSE | ATA_EH_SET_ACTIVE,
+				  ATA_EH_GET_SUCCESS_SENSE | ATA_EH_SET_ACTIVE |
+				  ATA_EH_ISSUE_DEFERRED_CMD,
 	ATA_EH_ALL_ACTIONS	= ATA_EH_REVALIDATE | ATA_EH_RESET |
 				  ATA_EH_ENABLE_LINK,
 
-- 
2.47.0

