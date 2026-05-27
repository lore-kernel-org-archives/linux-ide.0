Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDA33E0C76
	for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 08:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870368; cv=none; b=Osh7igV9sMZE3PAtwSb9nC6xpHkXftz1AHtLWfNckRrSNldOu7QVwHLT5Htg3rMZ0Pb4n1//8yGw1uGgeJ52oMu6FdR2hGuoO4rR641q6ofjnSwVaQmlX7nocuMyQGcMTzUX7TJltgI6Kdx44AmHlZSw7cSo2eomGJSdVqd6HC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870368; c=relaxed/simple;
	bh=00Lv+JmtDP3RKUUm373bg+E3/IB29HtiEQFgbc2dWFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awa/Chnjo68LMonS94Rom8a/yX+w4FS8qflRva30cvXWNf2ySDjBXwZbJXXeOnFZaOSKbBrJ+/a2TWLYCDOYWsoeDawA7QMMr+I1lHUKIKweWBTM15EZ37jjuf9nqM/NmpeyUnZAFOur0Qwn7ueffvMlWevbM149CR6H4EnKnwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfOXtEvN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfOXtEvN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854551F000E9;
	Wed, 27 May 2026 08:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779870366;
	bh=20SxrPhxe43PND+J2l1EKw2icDOEXK1wHtCTLKnW4tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kfOXtEvNW4A/IJUm0r+LAeBOiXgjaRMuPHVIB+BC+wR1DhCODTrgo2gN2Rh8N95Ji
	 jQ5lDrjbG5iGMqK5XCBfL5MiLBLgr2JtyliGZEZJdlryJV0uN9EehH64d7mgKlG6Ib
	 2aam4AJkcU8zm7GlmIccgQEbrDkANzSRPHFCA5RVUYDCLInwxRNLt+B4bRdY4ah6TA
	 jjpvUY1TLDwdFcef68k2qPVWA7DaYby5DcDNK2zcgbMZZSaLJ5pxVT98N3wV3YKASx
	 ie0Jah08BAnk2sWNg1YotTUD3zEtoTn+ucOTDO2NJHHF3PDEgC2eWVwcfpAEv5zW84
	 B4Zj9BIGuQRag==
Date: Wed, 27 May 2026 10:26:02 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Tommy Kelly <linux@tkel.ly>, Damien Le Moal <dlemoal@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>, linux-ide@vger.kernel.org,
	David Dreschner <kernel-2026@dreschner.net>
Subject: Re: [PATCH v5 0/4] ata: fix deferred QC handling for port multipliers
Message-ID: <ahaqmgFGMwO0hPNo@ryzen>
References: <20260514073858.1175072-6-cassel@kernel.org>
 <0685a2fa-1c79-4c38-a6c1-39427d65c267@dreschner.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dIlPAJLVOWHneczN"
Content-Disposition: inline
In-Reply-To: <0685a2fa-1c79-4c38-a6c1-39427d65c267@dreschner.net>


--dIlPAJLVOWHneczN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 26, 2026 at 08:47:53PM +0200, David Dreschner wrote:
> Hello Niklas,
> 
> thank you very much for fixing the issue!
> 
> I tested the first three patches manually on my Debian 13 machine with
> kernel 6.12.90 and can indeed confirm that your patches fixes the issue. The
> fourth patch had some merge-conflicts and were therefore skipped - I'm
> unable to test the changes anyway (my HBA only supports CBS).
> 
> Machine: HP MicroServer Gen8
> HBA: HP Dynamic Smart Array B120i
> Port multiplier: StarTech S322M225R (SATA to 2x M.2 SATA using ASM1092R
> chipset in JBOD mode)
> 
> Could you please make sure that the fixes are being backported to all
> versions that contain the faulty commit 0ea84089dbf6? Looks like that is
> necessary for v7.0, v6.18, v6.12 and v6.6.
> 
> If not, it would be great to get the fixes at least merged into v6.12, as
> I'm otherwise forced to manually build any new stable kernel that's being
> pushed by the Debian team.
> 
> Thanks again and greetings from Germany!
> David

Dear stable maintainers,

Sorry for the extra work put on you.

Could your please help us backport:

$ git log --reverse --oneline v7.1-rc4..v7.1-rc5 drivers/ata/
360190bd965f ata: libata-scsi: improve readability of ata_scsi_qc_issue()
ce4548807d2e ata: libata-scsi: do not use the deferred QC feature for ATA_DEFER_PORT
f233124fb36c ata: libata-scsi: do not use the deferred QC feature on PMPs with CBS
759e8756da00 ata: libata-scsi: do not needlessly defer commands when using PMP with FBS


The first three patches apply cleanly to at least v6.12.

The final commit does not apply cleanly, attaching a backported version.

Again, sorry for the trouble.
Hopefully our AI overlords / Sashiko will manage to find some of these
problems that was missed during the review of the faulty commit.


Kind regards,
Niklas

--dIlPAJLVOWHneczN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-ata-libata-scsi-do-not-needlessly-defer-commands-whe.patch

From bd5d8ab6f84dc19918704dad6c669bd29c8df30c Mon Sep 17 00:00:00 2001
From: Niklas Cassel <cassel@kernel.org>
Date: Thu, 14 May 2026 09:39:02 +0200
Subject: [PATCH] ata: libata-scsi: do not needlessly defer commands when using
 PMP with FBS

[ Upstream commit 759e8756da00aa115d504a18155b1d1ee1cc12e8 ]

The ACS specification does not allow a non-NCQ command to be issued while
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
will be deferred. This is in line with how PMPs with FBS worked before
commit 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation").

Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
Tested-by: Tommy Kelly <linux@tkel.ly>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c |  9 ++++---
 drivers/ata/libata-eh.c   |  8 +++---
 drivers/ata/libata-pmp.c  |  5 +++-
 drivers/ata/libata-scsi.c | 54 ++++++++++++++++++++++-----------------
 include/linux/libata.h    |  6 ++---
 5 files changed, 47 insertions(+), 35 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3e02402329a6..434934927928 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5444,6 +5444,7 @@ void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp)
 	link->pmp = pmp;
 	link->active_tag = ATA_TAG_POISON;
 	link->hw_sata_spd_limit = UINT_MAX;
+	INIT_WORK(&link->deferred_qc_work, ata_scsi_deferred_qc_work);
 
 	/* can't use iterator, ap isn't initialized yet */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
@@ -5526,7 +5527,6 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 	mutex_init(&ap->scsi_scan_mutex);
 	INIT_DELAYED_WORK(&ap->hotplug_task, ata_scsi_hotplug);
 	INIT_DELAYED_WORK(&ap->scsi_rescan_task, ata_scsi_dev_rescan);
-	INIT_WORK(&ap->deferred_qc_work, ata_scsi_deferred_qc_work);
 	INIT_LIST_HEAD(&ap->eh_done_q);
 	init_waitqueue_head(&ap->eh_wait_q);
 	init_completion(&ap->park_req_pending);
@@ -6149,12 +6149,15 @@ static void ata_port_detach(struct ata_port *ap)
 
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
index 59788a34871a..e9d2d84034fd 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -645,11 +645,11 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
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
@@ -660,8 +660,8 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
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
index a489f1b33a08..e954fc07ddbb 100644
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
index f416a9abcdae..4cf537b6f492 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1673,8 +1673,9 @@ static void ata_qc_done(struct ata_queued_cmd *qc)
 
 void ata_scsi_deferred_qc_work(struct work_struct *work)
 {
-	struct ata_port *ap =
-		container_of(work, struct ata_port, deferred_qc_work);
+	struct ata_link *link =
+		container_of(work, struct ata_link, deferred_qc_work);
+	struct ata_port *ap = link->ap;
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
 
@@ -1685,10 +1686,10 @@ void ata_scsi_deferred_qc_work(struct work_struct *work)
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
 
@@ -1697,8 +1698,7 @@ void ata_scsi_deferred_qc_work(struct work_struct *work)
 
 void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
 {
-	struct ata_queued_cmd *qc = ap->deferred_qc;
-	struct scsi_cmnd *scmd;
+	struct ata_link *link;
 
 	lockdep_assert_held(ap->lock);
 
@@ -1707,20 +1707,25 @@ void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
 	 * do not try to be smart about what to do with this deferred command
 	 * and simply requeue it by completing it with DID_REQUEUE.
 	 */
-	if (!qc)
-		return;
-
-	scmd = qc->scsicmd;
-	ap->deferred_qc = NULL;
-	cancel_work(&ap->deferred_qc_work);
-	ata_qc_free(qc);
-	scmd->result = (DID_REQUEUE << 16);
-	scsi_done(scmd);
+	ata_for_each_link(link, ap, PMP_FIRST) {
+		struct ata_queued_cmd *qc = link->deferred_qc;
+		struct scsi_cmnd *scmd;
+
+		if (qc) {
+			scmd = qc->scsicmd;
+			link->deferred_qc = NULL;
+			cancel_work(&link->deferred_qc_work);
+			ata_qc_free(qc);
+			scmd->result = (DID_REQUEUE << 16);
+			scsi_done(scmd);
+		}
+	}
 }
 
-static void ata_scsi_schedule_deferred_qc(struct ata_port *ap)
+static void ata_scsi_schedule_deferred_qc(struct ata_link *link)
 {
-	struct ata_queued_cmd *qc = ap->deferred_qc;
+	struct ata_queued_cmd *qc = link->deferred_qc;
+	struct ata_port *ap = link->ap;
 
 	lockdep_assert_held(ap->lock);
 
@@ -1737,12 +1742,12 @@ static void ata_scsi_schedule_deferred_qc(struct ata_port *ap)
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
@@ -1771,11 +1776,12 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 
 	ata_qc_done(qc);
 
-	ata_scsi_schedule_deferred_qc(ap);
+	ata_scsi_schedule_deferred_qc(link);
 }
 
 static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
 {
+	struct ata_link *link = qc->dev->link;
 	int ret;
 
 	if (!ap->ops->qc_defer)
@@ -1786,7 +1792,7 @@ static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
 	 * requeue and defer all incoming commands until the deferred qc is
 	 * processed, once all on-going commands complete.
 	 */
-	if (ap->deferred_qc) {
+	if (link->deferred_qc) {
 		ata_qc_free(qc);
 		return SCSI_MLQUEUE_DEVICE_BUSY;
 	}
@@ -1802,8 +1808,8 @@ static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
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
@@ -1829,7 +1835,7 @@ static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
 	 * commands complete.
 	 */
 	if (!ata_is_ncq(qc->tf.protocol)) {
-		ap->deferred_qc = qc;
+		link->deferred_qc = qc;
 		return 0;
 	}
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index eee76f3eea25..a78227fb66a8 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -853,6 +853,9 @@ struct ata_link {
 	unsigned int		sata_spd;	/* current SATA PHY speed */
 	enum ata_lpm_policy	lpm_policy;
 
+	struct work_struct	deferred_qc_work;
+	struct ata_queued_cmd	*deferred_qc;
+
 	/* record runtime error info, protected by host_set lock */
 	struct ata_eh_info	eh_info;
 	/* EH context */
@@ -898,9 +901,6 @@ struct ata_port {
 	u64			qc_active;
 	int			nr_active_links; /* #links with active qcs */
 
-	struct work_struct	deferred_qc_work;
-	struct ata_queued_cmd	*deferred_qc;
-
 	struct ata_link		link;		/* host default link */
 	struct ata_link		*slave_link;	/* see ata_slave_link_init() */
 
-- 
2.54.0


--dIlPAJLVOWHneczN--
