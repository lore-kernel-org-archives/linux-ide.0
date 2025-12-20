Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88DF1E5718
	for <linux-ide@vger.kernel.org>; Sat, 20 Dec 2025 00:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766190375; cv=none; b=AhOaIO3ANxuWSfrumNY6uUliNcIMpY0zW7Y9Ut81y4Ccojz7SctvhvFVbevDAj9HJ6ECsiZr37Eh8KacLOwjlvKO7Ok+ax8AmSALmzRpQTuZUtNbgfCXYGFLaQt+QjwEsYdHkn5EqSEYzkhKKjfXP+zQtt6GINe5yxh9RHo7fAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766190375; c=relaxed/simple;
	bh=94PuvRI24NArX/s+oUDTStoEUmTpODSXipMztQYLGIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxNVjGoEv3+BxTlf0F3xgkYt4ImWi2NcDZgHYcBC3o/GzFKy7MkZdJ0YqGMGzobu/hdT6citpzwRdOMLN61fQWtjYQfwjJFGJR2UvBU6ZSkS04NWMH4/9VSIbxuYvY0zFZ3HqgJouYoM1Jn3jFZx70Jrqnstbj8OfoUwtJPfc+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+DQQjk0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+DQQjk0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2237C116C6;
	Sat, 20 Dec 2025 00:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766190374;
	bh=94PuvRI24NArX/s+oUDTStoEUmTpODSXipMztQYLGIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K+DQQjk08eyJbp2u8Lxn3SYqVwrNUTfN2M9m+kBNpJVDOzIhHSRkICL4/qYlATLJT
	 HgH46kNsfF3kTKXWLEVKGmwYuqfuAsrdJpPgo3GplNzk2yTkJLfREW47/VIh+6HX2B
	 EqdFpyekMzFFOuQ8QqZpDEmld9OYI2spFiNj9OXSfr3DXN91ENaMbJJ8KsPzj3lgra
	 BMvG1kY1Gx00coWDbYGT86aVYLVics//Pth0TEPDZILQMKQZO+YkHgV5/uohmCzZUd
	 HVFHZV790wWPUEwpDKclK0doluDxlA/NexMVIYTCx51zMXtCf42D/XJEPa/hXEwQid
	 mc3WlRsXb+VGQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Igor Pylypiv <ipylypiv@google.com>,
	Xingui Yang <yangxingui@huawei.com>,
	John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 2/2] ata: libata-scsi: avoid passthrough command starvation
Date: Sat, 20 Dec 2025 09:21:40 +0900
Message-ID: <20251220002140.148854-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251220002140.148854-1-dlemoal@kernel.org>
References: <20251220002140.148854-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a non-NCQ passthrough command is issued while NCQ commands are
being executed, ata_scsi_defer() indicates to ata_scsi_translate() that
ata_qc_issue() should not be called for the passthrough command, and
instead returns SCSI_MLQUEUE_XXX_BUSY to defer the command execution.
This command deferring is correct and as mandated by the ACS
specifications since NCQ and non-NCQ commands cannot be mixed.

However, in the case of a host adapter using multiple submission queues,
when the target device is under a constant load of NCQ read or write
commands, there are no guarantees that requeueing the non-NCQ command
will lead to it not being deferred again repeatedly, since other
submission queues can constantly issue NCQ commands from different CPUs
ahead of the non-NCQ command. This can lead to very long delays for the
execution of non-NCQ passthrough commands, and even complete starvation
in the worst case scenario.

Since the block layer and the SCSI layer do not distinguish between
queuable (NCQ) and non queueable (non-NCQ) commands, libata-scsi SAT
implementation must ensure forward progress for non-NCQ commands in the
presence of NCQ command traffic. This is similar to what SAS HBAs with a
hardware/firmware based implementation do.

Implement such forward progress guarantee by limiting requeueing of
non-NCQ commands: when a non-NCQ command is received and NCQ commands
are in-flight, do not force a requeue of the non-NCQ command by
returning SCSI_MLQUEUE_XXX_BUSY in ata_scsi_translate() and instead
hold on to the qc using the new deferred_qc field of struct ata_port.

This deferred qc will be issued using the work item deferred_qc_work
running the function ata_scsi_deferred_qc_work() once all in-flight
commands complete, which is checked with the port qc_defer() callback
indicating that no further delay is necessary. This check is done using
the helper function ata_scsi_schedule_deferred_qc() which is called from
ata_scsi_qc_complete(). This thus excludes this mechanism from all
internal non-NCQ commands issued by ATA EH.

When a port deferred_qc is non NULL, that is, the port has a command
waiting for the device queue to drain, the issuing of all incoming
commands (both NCQ and non-NCQ) is deferred using the regular busy
mechanism. This simplifies the code and also avoids potential denial of
service problems if a user issues too many non-NCQ passthrough commands.

Finally, whenever ata EH is scheduled, regardless of the reason, a
deferred qc is always requeued so that it can be retried once EH
completes. This is done by calling the function
ata_scsi_requeue_deferred_qc() from ata_eh_set_pending(). This avoids
the need for any special processing for the deferred qc in case of NCQ
error, link or device reset, or device timeout.

Reported-by: Xingui Yang <yangxingui@huawei.com>
Reported-by: Igor Pylypiv <ipylypiv@google.com>
Fixes: 42f22fe36d51 ("scsi: pm8001: Expose hardware queues for pm80xx")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c |  1 +
 drivers/ata/libata-eh.c   |  6 +++
 drivers/ata/libata-scsi.c | 93 ++++++++++++++++++++++++++++++++++++++-
 drivers/ata/libata.h      |  2 +
 include/linux/libata.h    |  3 ++
 5 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0b24bd169d61..121f35115d33 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5558,6 +5558,7 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 	mutex_init(&ap->scsi_scan_mutex);
 	INIT_DELAYED_WORK(&ap->hotplug_task, ata_scsi_hotplug);
 	INIT_DELAYED_WORK(&ap->scsi_rescan_task, ata_scsi_dev_rescan);
+	INIT_WORK(&ap->deferred_qc_work, ata_scsi_deferred_qc_work);
 	INIT_LIST_HEAD(&ap->eh_done_q);
 	init_waitqueue_head(&ap->eh_wait_q);
 	init_completion(&ap->park_req_pending);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 2586e77ebf45..b90b17f680f8 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -917,6 +917,12 @@ static void ata_eh_set_pending(struct ata_port *ap, bool fastdrain)
 
 	ap->pflags |= ATA_PFLAG_EH_PENDING;
 
+	/*
+	 * If we have a deferred qc, requeue it so that it is retried once EH
+	 * completes.
+	 */
+	ata_scsi_requeue_deferred_qc(ap);
+
 	if (!fastdrain)
 		return;
 
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 8e04fc173ea3..e39837846566 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1658,8 +1658,73 @@ static void ata_qc_done(struct ata_queued_cmd *qc)
 	done(cmd);
 }
 
+void ata_scsi_deferred_qc_work(struct work_struct *work)
+{
+	struct ata_port *ap =
+		container_of(work, struct ata_port, deferred_qc_work);
+	struct ata_queued_cmd *qc;
+	unsigned long flags;
+
+	spin_lock_irqsave(ap->lock, flags);
+
+	/*
+	 * If we still have a deferred qc and we are not in EH, issue it. In
+	 * such case, we should not need any more deferring the qc, so warn if
+	 * qc_defer() says otherwise.
+	 */
+	qc = ap->deferred_qc;
+	if (qc && !ata_port_eh_scheduled(ap)) {
+		WARN_ON_ONCE(ap->ops->qc_defer(qc));
+		ap->deferred_qc = NULL;
+		ata_qc_issue(qc);
+	}
+
+	spin_unlock_irqrestore(ap->lock, flags);
+}
+
+void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
+{
+	struct ata_queued_cmd *qc = ap->deferred_qc;
+	struct scsi_cmnd *scmd;
+
+	/*
+	 * If we have a deferred qc when a reset occurs or NCQ commands fail,
+	 * do not try to be smart about what to do with this deferred command
+	 * and simply retry it by completing it with DID_SOFT_ERROR.
+	 */
+	if (!qc)
+		return;
+
+	scmd = qc->scsicmd;
+	ap->deferred_qc = NULL;
+	ata_qc_free(qc);
+	scmd->result = (DID_SOFT_ERROR << 16);
+	scsi_done(scmd);
+}
+
+static void ata_scsi_schedule_deferred_qc(struct ata_port *ap)
+{
+	struct ata_queued_cmd *qc = ap->deferred_qc;
+
+	/*
+	 * If we have a deferred qc, then qc_defer() is defined and we can use
+	 * this callback to determine if this qc is good to go, unless EH has
+	 * been scheduled.
+	 */
+	if (!qc)
+		return;
+
+	if (ata_port_eh_scheduled(ap)) {
+		ata_scsi_requeue_deferred_qc(ap);
+		return;
+	}
+	if (!ap->ops->qc_defer(qc))
+		queue_work(system_highpri_wq, &ap->deferred_qc_work);
+}
+
 static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 {
+	struct ata_port *ap = qc->ap;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	u8 *cdb = cmd->cmnd;
 	bool have_sense = qc->flags & ATA_QCFLAG_SENSE_VALID;
@@ -1689,12 +1754,24 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 	}
 
 	ata_qc_done(qc);
+
+	ata_scsi_schedule_deferred_qc(ap);
 }
 
 static int ata_scsi_defer(struct ata_port *ap, struct ata_queued_cmd *qc)
 {
 	int ret;
 
+	/*
+	 * If we already have a deferred qc, then rely on the SCSI layer to
+	 * requeue and defer all incoming commands until the deferred qc is
+	 * processed, once all on-going commands are completed.
+	 */
+	if (ap->deferred_qc) {
+		ata_qc_free(qc);
+		return SCSI_MLQUEUE_DEVICE_BUSY;
+	}
+
 	if (!ap->ops->qc_defer)
 		return 0;
 
@@ -1702,6 +1779,17 @@ static int ata_scsi_defer(struct ata_port *ap, struct ata_queued_cmd *qc)
 	if (!ret)
 		return 0;
 
+	/*
+	 * We must defer this qc: if this is not an NCQ command, keep this qc
+	 * as a deferred one and wait for all on-going NCQ commands to complete
+	 * before issuing it with the deferred qc work.
+	 */
+	if (!ata_is_ncq(qc->tf.protocol)) {
+		ap->deferred_qc = qc;
+		return SCSI_MLQUEUE_DEVICE_BUSY;
+	}
+
+	/* Use the SCSI layer to requeue and defer the command. */
 	ata_qc_free(qc);
 
 	switch (ret) {
@@ -1777,8 +1865,11 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 		goto done;
 
 	rc = ata_scsi_defer(ap, qc);
-	if (rc)
+	if (rc) {
+		if (qc == ap->deferred_qc)
+			return 0;
 		return rc;
+	}
 
 	ata_qc_issue(qc);
 
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 0e7ecac73680..60a675df61dc 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -165,6 +165,8 @@ void ata_scsi_sdev_config(struct scsi_device *sdev);
 int ata_scsi_dev_config(struct scsi_device *sdev, struct queue_limits *lim,
 		struct ata_device *dev);
 int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev);
+void ata_scsi_deferred_qc_work(struct work_struct *work);
+void ata_scsi_requeue_deferred_qc(struct ata_port *ap);
 
 /* libata-eh.c */
 extern unsigned int ata_internal_cmd_timeout(struct ata_device *dev, u8 cmd);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 39534fafa36a..c5b27d97dfaf 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -903,6 +903,9 @@ struct ata_port {
 	u64			qc_active;
 	int			nr_active_links; /* #links with active qcs */
 
+	struct work_struct	deferred_qc_work;
+	struct ata_queued_cmd	*deferred_qc;
+
 	struct ata_link		link;		/* host default link */
 	struct ata_link		*slave_link;	/* see ata_slave_link_init() */
 
-- 
2.52.0

