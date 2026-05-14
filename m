Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50B43C1966
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2026 07:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778744358; cv=none; b=SPQCd48GEfduOpM08LM68VBd9/6rb4JmBPqtxv1ECV9VWYba6/WyuACmMpIekEExcBi1TTiL/eGzb5+h7pY+DnhTCmn6szeoIYTa3sEbx7ZURk9EchrJmPhKyHE5IIWmBiYeieF1C2tbYZDbrfhR59OAd2WJI7EES6V9rbMAlAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778744358; c=relaxed/simple;
	bh=nXiehcQhcJx5MSvtykDCpCNlSwsjrpevrgJck7hA/UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aaslf8CNPLnU94BozupzjbLBeMKhtAez4x4FckwP5GEP0NyQo0+B1v6OlIkuiYU1sDe72W5he+i8pJI0WLAuDt3OQDyzNxrsLS2o3p2XDmGofY6raKKFwYo8Ww2Npzb0ZorMYpH0Fw+ndoKoF+bUc3TGyi+pX798FzsXqtPWqyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uH45vtt6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uH45vtt6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07114C2BCB7;
	Thu, 14 May 2026 07:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778744357;
	bh=nXiehcQhcJx5MSvtykDCpCNlSwsjrpevrgJck7hA/UA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uH45vtt6iLLEVhfc5hadUhBHUqk0v3qU35mhoLdq7AgkpTud6QRcc0HJieiBCkXfr
	 k68Bc7JIyAmzIhlIfkBABLfViFC4GYaa5e1TrogdZ/PJDywKpHyJBpZmCi4zIXXSqD
	 c988qTWY3NU72JceeZ5PL/mlBP41ygwHhenlMRsNC/vs/6QftV4yT7Cxrnyt8YVM9l
	 OqOm/nnEPfL9fnV35AEDImCcVfGS7cBOtokxqBNMoLGDIqnymuMaU53WC9kLBxuG+P
	 iw72Z22hV2EAnoFejy79y9r9z3jV5IQt0YvlQ6Wl4HM0opwxwEDaSBiekUWVSt1XuR
	 7JhVVSP/I2Byw==
From: Niklas Cassel <cassel@kernel.org>
To: Tommy Kelly <linux@tkel.ly>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH v5 4/4] ata: libata-scsi: do not needlessly defer commands when using PMP with FBS
Date: Thu, 14 May 2026 09:39:02 +0200
Message-ID: <20260514073858.1175072-10-cassel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514073858.1175072-6-cassel@kernel.org>
References: <20260514073858.1175072-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9691; i=cassel@kernel.org; h=from:subject; bh=nXiehcQhcJx5MSvtykDCpCNlSwsjrpevrgJck7hA/UA=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJYa0TvxGx47/LO3oBJbsbDk/a7dkadui6bcKuWJ/ih6 VYFVY7NHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZjIk82MDDeuO9h8udgaxqmT EFbpHlHmtH672x1vTeUzJ1PlHrOaz2P4p9nkEnz02vQJrdv35yy8GnvgWN1+j3tKh+zPJK2rvxd mzwYA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The SATA specification does not allow a non-NCQ command to be issued while
an NCQ command is outstanding.

Commit 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
introduced a feature where a deferred non-NCQ command gets issued from a
workqueue. The design stores a single non-NCQ command per port.

However, when using Port Multipliers (PMPs), specifically PMPs that
support FIS-Based Switching (FBS), non-NCQ and NCQ commands can be mixed
on the same port, just not for the same link, see e.g. ata_std_qc_defer()
which is, and always has operated on a per-link basis.

Therefore, move the deferred_qc from struct ata_port to struct ata_link.
This way, when using a PMP with FBS, we will not needlessly defer commands
to all other links, just because one link issued a non-NCQ command while
having an NCQ command outstanding. Only commands for that specific link
will be deferred.

Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c |  9 +++++---
 drivers/ata/libata-eh.c   |  8 ++++----
 drivers/ata/libata-pmp.c  |  5 ++++-
 drivers/ata/libata-scsi.c | 43 +++++++++++++++++++++++----------------
 include/linux/libata.h    |  6 +++---
 5 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e76d15411e2a..3d0027ec33c2 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5584,6 +5584,7 @@ void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp)
 	link->pmp = pmp;
 	link->active_tag = ATA_TAG_POISON;
 	link->hw_sata_spd_limit = UINT_MAX;
+	INIT_WORK(&link->deferred_qc_work, ata_scsi_deferred_qc_work);
 
 	/* can't use iterator, ap isn't initialized yet */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
@@ -5666,7 +5667,6 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 	mutex_init(&ap->scsi_scan_mutex);
 	INIT_DELAYED_WORK(&ap->hotplug_task, ata_scsi_hotplug);
 	INIT_DELAYED_WORK(&ap->scsi_rescan_task, ata_scsi_dev_rescan);
-	INIT_WORK(&ap->deferred_qc_work, ata_scsi_deferred_qc_work);
 	INIT_LIST_HEAD(&ap->eh_done_q);
 	init_waitqueue_head(&ap->eh_wait_q);
 	init_completion(&ap->park_req_pending);
@@ -6291,12 +6291,15 @@ static void ata_port_detach(struct ata_port *ap)
 
 	/* It better be dead now and not have any remaining deferred qc. */
 	WARN_ON(!(ap->pflags & ATA_PFLAG_UNLOADED));
-	WARN_ON(ap->deferred_qc);
 
-	cancel_work_sync(&ap->deferred_qc_work);
 	cancel_delayed_work_sync(&ap->hotplug_task);
 	cancel_delayed_work_sync(&ap->scsi_rescan_task);
 
+	ata_for_each_link(link, ap, PMP_FIRST) {
+		WARN_ON(link->deferred_qc);
+		cancel_work_sync(&link->deferred_qc_work);
+	}
+
 	/* Delete port multiplier link transport devices */
 	if (ap->pmp_link) {
 		int i;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 6cb79a09423d..715bc525b38f 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -651,11 +651,11 @@ int ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
 			if (qc->scsicmd != scmd)
 				continue;
 			if ((qc->flags & ATA_QCFLAG_ACTIVE) ||
-			    qc == ap->deferred_qc)
+			    qc == qc->dev->link->deferred_qc)
 				break;
 		}
 
-		if (i < ATA_MAX_QUEUE && qc == ap->deferred_qc) {
+		if (i < ATA_MAX_QUEUE && qc == qc->dev->link->deferred_qc) {
 			/*
 			 * This is a deferred command that timed out while
 			 * waiting for the command queue to drain. Since the qc
@@ -666,8 +666,8 @@ int ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
 			 * deferred qc work from issuing this qc.
 			 */
 			WARN_ON_ONCE(qc->flags & ATA_QCFLAG_ACTIVE);
-			ap->deferred_qc = NULL;
-			cancel_work(&ap->deferred_qc_work);
+			qc->dev->link->deferred_qc = NULL;
+			cancel_work(&qc->dev->link->deferred_qc_work);
 			set_host_byte(scmd, DID_TIME_OUT);
 			scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
 		} else if (i < ATA_MAX_QUEUE) {
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 7e889534d73b..e8540931b4a1 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -582,8 +582,11 @@ static void sata_pmp_detach(struct ata_device *dev)
 	if (ap->ops->pmp_detach)
 		ap->ops->pmp_detach(ap);
 
-	ata_for_each_link(tlink, ap, EDGE)
+	ata_for_each_link(tlink, ap, EDGE) {
+		WARN_ON(tlink->deferred_qc);
+		cancel_work_sync(&tlink->deferred_qc_work);
 		ata_eh_detach_dev(tlink->device);
+	}
 
 	spin_lock_irqsave(ap->lock, flags);
 	ap->nr_pmp_links = 0;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 10f1ee8acc37..1f4a4329fc11 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1664,8 +1664,9 @@ static void ata_scsi_qc_done(struct ata_queued_cmd *qc, bool set_result,
 
 void ata_scsi_deferred_qc_work(struct work_struct *work)
 {
-	struct ata_port *ap =
-		container_of(work, struct ata_port, deferred_qc_work);
+	struct ata_link *link =
+		container_of(work, struct ata_link, deferred_qc_work);
+	struct ata_port *ap = link->ap;
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
 
@@ -1676,10 +1677,10 @@ void ata_scsi_deferred_qc_work(struct work_struct *work)
 	 * such case, we should not need any more deferring the qc, so warn if
 	 * qc_defer() says otherwise.
 	 */
-	qc = ap->deferred_qc;
+	qc = link->deferred_qc;
 	if (qc && !ata_port_eh_scheduled(ap)) {
 		WARN_ON_ONCE(ap->ops->qc_defer(qc));
-		ap->deferred_qc = NULL;
+		link->deferred_qc = NULL;
 		ata_qc_issue(qc);
 	}
 
@@ -1688,7 +1689,7 @@ void ata_scsi_deferred_qc_work(struct work_struct *work)
 
 void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
 {
-	struct ata_queued_cmd *qc = ap->deferred_qc;
+	struct ata_link *link;
 
 	lockdep_assert_held(ap->lock);
 
@@ -1697,16 +1698,21 @@ void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
 	 * do not try to be smart about what to do with this deferred command
 	 * and simply requeue it by completing it with DID_REQUEUE.
 	 */
-	if (qc) {
-		ap->deferred_qc = NULL;
-		cancel_work(&ap->deferred_qc_work);
-		ata_scsi_qc_done(qc, true, DID_REQUEUE << 16);
+	ata_for_each_link(link, ap, PMP_FIRST) {
+		struct ata_queued_cmd *qc = link->deferred_qc;
+
+		if (qc) {
+			link->deferred_qc = NULL;
+			cancel_work(&link->deferred_qc_work);
+			ata_scsi_qc_done(qc, true, DID_REQUEUE << 16);
+		}
 	}
 }
 
-static void ata_scsi_schedule_deferred_qc(struct ata_port *ap)
+static void ata_scsi_schedule_deferred_qc(struct ata_link *link)
 {
-	struct ata_queued_cmd *qc = ap->deferred_qc;
+	struct ata_queued_cmd *qc = link->deferred_qc;
+	struct ata_port *ap = link->ap;
 
 	lockdep_assert_held(ap->lock);
 
@@ -1723,12 +1729,12 @@ static void ata_scsi_schedule_deferred_qc(struct ata_port *ap)
 		return;
 	}
 	if (!ap->ops->qc_defer(qc))
-		queue_work(system_highpri_wq, &ap->deferred_qc_work);
+		queue_work(system_highpri_wq, &link->deferred_qc_work);
 }
 
 static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 {
-	struct ata_port *ap = qc->ap;
+	struct ata_link *link = qc->dev->link;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	u8 *cdb = cmd->cmnd;
 	bool have_sense = qc->flags & ATA_QCFLAG_SENSE_VALID;
@@ -1759,11 +1765,12 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 
 	ata_scsi_qc_done(qc, false, 0);
 
-	ata_scsi_schedule_deferred_qc(ap);
+	ata_scsi_schedule_deferred_qc(link);
 }
 
 static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
 {
+	struct ata_link *link = qc->dev->link;
 	int ret;
 
 	if (!ap->ops->qc_defer)
@@ -1774,7 +1781,7 @@ static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
 	 * requeue and defer all incoming commands until the deferred qc is
 	 * processed, once all on-going commands complete.
 	 */
-	if (ap->deferred_qc) {
+	if (link->deferred_qc) {
 		ata_qc_free(qc);
 		return SCSI_MLQUEUE_DEVICE_BUSY;
 	}
@@ -1790,8 +1797,8 @@ static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
 	case ATA_DEFER_LINK_EXCL:
 		/*
 		 * Drivers making use of ap->excl_link cannot store the QC in
-		 * ap->deferred_qc, because the ap->excl_link handling is
-		 * incompatible with the ap->deferred_qc workqueue handling.
+		 * link->deferred_qc, because the ap->excl_link handling is
+		 * incompatible with the link->deferred_qc workqueue handling.
 		 */
 		ret = SCSI_MLQUEUE_DEVICE_BUSY;
 		goto free_qc;
@@ -1817,7 +1824,7 @@ static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
 	 * commands complete.
 	 */
 	if (!ata_is_ncq(qc->tf.protocol)) {
-		ap->deferred_qc = qc;
+		link->deferred_qc = qc;
 		return 0;
 	}
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 360776016b50..127229fbd1a6 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -855,6 +855,9 @@ struct ata_link {
 	unsigned int		sata_spd;	/* current SATA PHY speed */
 	enum ata_lpm_policy	lpm_policy;
 
+	struct work_struct	deferred_qc_work;
+	struct ata_queued_cmd	*deferred_qc;
+
 	/* record runtime error info, protected by host_set lock */
 	struct ata_eh_info	eh_info;
 	/* EH context */
@@ -900,9 +903,6 @@ struct ata_port {
 	u64			qc_active;
 	int			nr_active_links; /* #links with active qcs */
 
-	struct work_struct	deferred_qc_work;
-	struct ata_queued_cmd	*deferred_qc;
-
 	struct ata_link		link;		/* host default link */
 	struct ata_link		*slave_link;	/* see ata_slave_link_init() */
 
-- 
2.54.0

