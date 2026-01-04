Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5200C3A1E63
	for <linux-ide@vger.kernel.org>; Sun,  4 Jan 2026 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767515196; cv=none; b=dU94oJkuF2t+v+Qlg+LrJ/dGATLdOWivTFIv7jn0A5jZRWbk2x47nlqQ9X0RTv/9Y3h4T3vc+XRzFlLyG/84p3EXSrUIC9enFKCsLwIY59xUcrkwZaFs+HO0llkyghKL5tujzlwz/5f5gRJAcrZpTr1X6X34p44ATueAe8IN7lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767515196; c=relaxed/simple;
	bh=yKPyRsDQwSEnIjvB7xSWfxhiJsvApyMYvywasAf3NE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IuG2NMaWkGs2LVxphsAhsFEklTdCFOt92XuYopZ+1vJAafb/kJaFriG7+qVk2hJDGtSTRLaqHuZDjb0pPbK+nqZzuDTDc7rSd/tCX/rPVe7+Zz6RUY+YdiJFVv2lln95qctb2P7A9P14RNZHMwjSQcct1kvHeBeqOK5O+/CjlfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjLTHwef; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjLTHwef"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AE9C116C6;
	Sun,  4 Jan 2026 08:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767515195;
	bh=yKPyRsDQwSEnIjvB7xSWfxhiJsvApyMYvywasAf3NE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bjLTHwefA3tn2eBdcPT06E/sSqxZOPS4icJqs0zEPMzAPIgJFDqWK6gp710EybGyN
	 CBisskxpLajXsVDqQFoueSNA+5i8osXtPtrbJh1mWaxG3hNA4mvZ2Wdf8XDNEDjgwG
	 DQESBgqNNljC3uKQdGlY3X2P0qMuJmW57Xs+wlgxot35xeDTXbKxxdrzs9nWclHARu
	 W2cgzGacJwpe1WtsfTbIx0ezYkpeKEttrl3VruptoHa3XvBw/v3i/GSVIwzoMt79WD
	 IevIu6ebcVmNp0PXiaLBlYj+iO6Xmuv1gRfjj0fC8Tac2JdupNbOmIFJZTlmc0KBI2
	 5AnB/S4mWFMUQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Igor Pylypiv <ipylypiv@google.com>,
	Xingui Yang <yangxingui@huawei.com>,
	John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 2/2] ata: libata-scsi: avoid Non-NCQ command starvation
Date: Sun,  4 Jan 2026 17:22:03 +0900
Message-ID: <20260104082203.1212962-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104082203.1212962-1-dlemoal@kernel.org>
References: <20260104082203.1212962-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a non-NCQ command is issued while NCQ commands are being executed,
ata_scsi_qc_issue() indicates to the SCSI layer that the command issuing
should be deferred by returning SCSI_MLQUEUE_XXX_BUSY.  This command
deferring is correct and as mandated by the ACS specifications since
NCQ and non-NCQ commands cannot be mixed.

However, in the case of a host adapter using multiple submission queues,
when the target device is under a constant load of NCQ commands, there
are no guarantees that requeueing the non-NCQ command will be executed
later and it may be deferred again repeatedly as other submission queues
can constantly issue NCQ commands from different CPUs ahead of the
non-NCQ command. This can lead to very long delays for the execution of
non-NCQ commands, and even complete starvation for these commands in the
worst case scenario.

Since the block layer and the SCSI layer do not distinguish between
queueable (NCQ) and non queueable (non-NCQ) commands, libata-scsi SAT
implementation must ensure forward progress for non-NCQ commands in the
presence of NCQ command traffic. This is similar to what SAS HBAs with a
hardware/firmware based SAT implementation do.

Implement such forward progress guarantee by limiting requeueing of
non-NCQ commands from ata_scsi_qc_issue(): when a non-NCQ command is
received and NCQ commands are in-flight, do not force a requeue of the
non-NCQ command by returning SCSI_MLQUEUE_XXX_BUSY and instead return 0
to indicate that the command was accepted but hold on to the qc using
the new deferred_qc field of struct ata_port.

This deferred qc will be issued using the work item deferred_qc_work
running the function ata_scsi_deferred_qc_work() once all in-flight
commands complete, which is checked with the port qc_defer() callback
return value indicating that no further delay is necessary. This check
is done using the helper function ata_scsi_schedule_deferred_qc() which
is called from ata_scsi_qc_complete(). This thus excludes this mechanism
from all internal non-NCQ commands issued by ATA EH.

When a port deferred_qc is non NULL, that is, the port has a command
waiting for the device queue to drain, the issuing of all incoming
commands (both NCQ and non-NCQ) is deferred using the regular busy
mechanism. This simplifies the code and also avoids potential denial of
service problems if a user issues too many non-NCQ commands.

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
 drivers/ata/libata-core.c |  5 +++
 drivers/ata/libata-eh.c   |  6 +++
 drivers/ata/libata-scsi.c | 89 +++++++++++++++++++++++++++++++++++++++
 drivers/ata/libata.h      |  2 +
 include/linux/libata.h    |  3 ++
 5 files changed, 105 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 09d8c035fcdf..447d8dc666a4 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5561,6 +5561,7 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 	mutex_init(&ap->scsi_scan_mutex);
 	INIT_DELAYED_WORK(&ap->hotplug_task, ata_scsi_hotplug);
 	INIT_DELAYED_WORK(&ap->scsi_rescan_task, ata_scsi_dev_rescan);
+	INIT_WORK(&ap->deferred_qc_work, ata_scsi_deferred_qc_work);
 	INIT_LIST_HEAD(&ap->eh_done_q);
 	init_waitqueue_head(&ap->eh_wait_q);
 	init_completion(&ap->park_req_pending);
@@ -6173,6 +6174,10 @@ static void ata_port_detach(struct ata_port *ap)
 		}
 	}
 
+	/* Make sure the deferred qc work finished. */
+	cancel_work_sync(&ap->deferred_qc_work);
+	WARN_ON(ap->deferred_qc);
+
 	/* Tell EH to disable all devices */
 	ap->pflags |= ATA_PFLAG_UNLOADING;
 	ata_port_schedule_eh(ap);
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
index 5b6b5f1ff3c7..4aeffd6a5640 100644
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
@@ -1689,6 +1754,8 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 	}
 
 	ata_qc_done(qc);
+
+	ata_scsi_schedule_deferred_qc(ap);
 }
 
 static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
@@ -1698,6 +1765,16 @@ static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
 	if (!ap->ops->qc_defer)
 		goto issue;
 
+	/*
+	 * If we already have a deferred qc, then rely on the SCSI layer to
+	 * requeue and defer all incoming commands until the deferred qc is
+	 * processed, once all on-going commands complete.
+	 */
+	if (ap->deferred_qc) {
+		ata_qc_free(qc);
+		return SCSI_MLQUEUE_DEVICE_BUSY;
+	}
+
 	/* Check if the command needs to be deferred. */
 	ret = ap->ops->qc_defer(qc);
 	switch (ret) {
@@ -1716,6 +1793,18 @@ static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
 	}
 
 	if (ret) {
+		/*
+		 * We must defer this qc: if this is not an NCQ command, keep
+		 * this qc as a deferred one and report to the SCSI layer that
+		 * we issued it so that it is not requeued. The deferred qc will
+		 * be issued with the port deferred_qc_work once all on-going
+		 * commands complete.
+		 */
+		if (!ata_is_ncq(qc->tf.protocol)) {
+			ap->deferred_qc = qc;
+			return 0;
+		}
+
 		/* Force a requeue of the command to defer its execution. */
 		ata_qc_free(qc);
 		return ret;
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

