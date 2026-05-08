Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F300235F163
	for <linux-ide@vger.kernel.org>; Fri,  8 May 2026 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778269873; cv=none; b=BOkIZfSsHsorYUsdjqdhZq5XKNa0zxQftOG0M65Zs813c5JJThldEyYbZxLSSF4Zc0+bCkUcp5mh6zFzZgqL96+H4i4c25LS4iFaDHvgHlcR7cwnPdk5lelS0s1tVmXcIGWT1ULTjR34zf6bTK05mfsbFq14frvypjA+L4c0pPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778269873; c=relaxed/simple;
	bh=EUpoLH9Z4ew9X5HY+RISUyyL5+vBNvoGbCCEEF26DjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIy7I8EQjjKHGY2OOLfMEYRTlX0ovwcOU1TiIV1+ir3N24bY4fkY1UD9xV+H7eRK5inrhdlIGI9hixFtGIVgACT5v28N5LNvxcKIgqA2GEsDk3Dzo57WL0QEwEmiMnaCVvsElKsqRDQPn3iyGoU0xbYJx8pNi4cJo0mceofwIyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cM8aGgTq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cM8aGgTq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19902C2BCC7;
	Fri,  8 May 2026 19:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778269872;
	bh=EUpoLH9Z4ew9X5HY+RISUyyL5+vBNvoGbCCEEF26DjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cM8aGgTqITZUZeW2hAF/pb0kRT1sp7SlEzVbxmo0W++RUZKCT0dVS+lmFbVl7GvHk
	 DOioWTI4sCdwdj02ZCIKFruZaLq50Ll6XGYme5S8N6Ofp7FplP8Y+CKhpzgSXH46GF
	 RUo8YKA+0CongWPSc+YD+lXTVKUq+kJl78IYr/kbyPM4QL5Fsa56eOfj3PGOuJ+fel
	 CyoDJic7Sx7Z7Hs63nMBhkPJxcsqO5bHtBwtK2We/CkdSX6QHx+DUimHyysUIgY9XT
	 EkccV2H2p3BrFlVCVufO/aJ+v9T5yr7lmT8WnmR2tUH/qf9JJQOwgwlaKg3nzwdvuP
	 n8ayINpbkDNwQ==
From: Niklas Cassel <cassel@kernel.org>
To: Tommy Kelly <linux@tkel.ly>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH v3 1/2] ata: libata-scsi: do not use the deferred QC feature on PMPs with CBS
Date: Fri,  8 May 2026 21:50:52 +0200
Message-ID: <20260508195051.188207-5-cassel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508195051.188207-4-cassel@kernel.org>
References: <20260508195051.188207-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6270; i=cassel@kernel.org; h=from:subject; bh=EUpoLH9Z4ew9X5HY+RISUyyL5+vBNvoGbCCEEF26DjA=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDL/2c15czNkbsVOH362A4E/jv/PSzrW0JO1N8X/5EbWK 8s7n7X2dJSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAiv3cyMtx1nSPoFB8ZMTPh rKes0laPntDg40/6Lkj1Suy9mbI78TTDP8W2j6cKw2vb/iYuu11kt3vRrawtFiwrjbSPnU72mBU dzgwA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

When using Port Multipliers (PMPs) with Command-Based Switching (CBS), you
can only issue commands to one link at a time. For PMPs with CBS, there is
already code to handle commands being sent to different links in
sata_pmp_qc_defer_cmd_switch() using ap->excl_link.

A user on the list reported that commit 0ea84089dbf6 ("ata: libata-scsi:
avoid Non-NCQ command starvation") broke PMPs with CBS. The commit
introduced code that stores a deferred qc in ap->deferred_qc, to later be
issued via a workqueue. It turns out that this change is incompatible with
the existing ap->excl_link handling used by PMPs with CBS.

Thus, modify sata_pmp_qc_defer_cmd_switch() code to return
ATA_DEFER_PORT_PMP_CBS and ATA_DEFER_LINK_PMP_CBS, and make sure that the
deferred QC handling via workqueue is not used for these return values.

This way, PMPs with CBS will work once again. Note that the starvation
referenced in commit 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ
command starvation") can only happen on libsas ports, and libsas does not
support Port Multipliers, thus there is no harm of reverting back to the
previous way of deferring commands for PMPs with CBS.

Non-libsas ports connected to anything but a PMP with CBS (e.g. a normal
drive or a PMP with FBS) will continue using the deferred workqueue, since
it does result in lower completion latencies for non-NCQ commands, even
though the workqueue is not strictly needed to avoid starvation for
non-libsas ports.

If we want to modify the scope of the workqueue issuing to also handle
PMPs with CBS, then we should ensure that we can save both NCQ and non-NCQ
commands in ap->deferred_qc, while also removing the existing PMP CBS
handling using ap->excl_link, such that we don't duplicate features.

While at it, also add a comment explaining how the ap->excl_link mechanism
works.

Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-pmp.c  | 21 ++++++++++++--
 drivers/ata/libata-scsi.c | 58 ++++++++++++++++++++++++---------------
 include/linux/libata.h    |  2 ++
 3 files changed, 57 insertions(+), 24 deletions(-)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index e3adc008fed1..43a845ab02b9 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -114,13 +114,30 @@ int sata_pmp_qc_defer_cmd_switch(struct ata_queued_cmd *qc)
 	if (ap->excl_link == NULL || ap->excl_link == link) {
 		if (ap->nr_active_links == 0 || ata_link_active(link)) {
 			qc->flags |= ATA_QCFLAG_CLEAR_EXCL;
-			return ata_std_qc_defer(qc);
+			switch (ata_std_qc_defer(qc)) {
+			case 0:
+				return 0;
+			case ATA_DEFER_LINK:
+				return ATA_DEFER_LINK_PMP_CBS;
+			case ATA_DEFER_PORT:
+				return ATA_DEFER_PORT_PMP_CBS;
+			default:
+				WARN_ON_ONCE(1);
+				return ATA_DEFER_PORT_PMP_CBS;
+			}
 		}
 
+		/*
+		 * Note: ap->excl_link contains the link that is next in line,
+		 * i.e. implicit round robin. If there is only one link
+		 * dispatching, ap->excl_link will be left unclaimed, allowing
+		 * other links to set ap->excl_link, ensuring that the currently
+		 * active link cannot queue any more.
+		 */
 		ap->excl_link = link;
 	}
 
-	return ATA_DEFER_PORT;
+	return ATA_DEFER_PORT_PMP_CBS;
 }
 
 /**
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index f44612e269a4..6f273c5d0cd3 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1767,7 +1767,7 @@ static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
 	int ret;
 
 	if (!ap->ops->qc_defer)
-		goto issue;
+		goto issue_qc;
 
 	/*
 	 * If we already have a deferred qc, then rely on the SCSI layer to
@@ -1783,38 +1783,52 @@ static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
 	ret = ap->ops->qc_defer(qc);
 	switch (ret) {
 	case 0:
-		break;
+		goto issue_qc;
 	case ATA_DEFER_LINK:
 		ret = SCSI_MLQUEUE_DEVICE_BUSY;
-		break;
+		goto store_qc;
 	case ATA_DEFER_PORT:
 		ret = SCSI_MLQUEUE_HOST_BUSY;
-		break;
+		goto store_qc;
+	case ATA_DEFER_LINK_PMP_CBS:
+		/*
+		 * PMP in CBS mode has independent handling using ap->excl_link
+		 * that is incompatible with ap->deferred_qc workqueue handling.
+		 */
+		ret = SCSI_MLQUEUE_DEVICE_BUSY;
+		goto free_qc;
+	case ATA_DEFER_PORT_PMP_CBS:
+		/*
+		 * PMP in CBS mode has independent handling using ap->excl_link
+		 * that is incompatible with ap->deferred_qc workqueue handling.
+		 */
+		ret = SCSI_MLQUEUE_HOST_BUSY;
+		goto free_qc;
 	default:
 		WARN_ON_ONCE(1);
 		ret = SCSI_MLQUEUE_HOST_BUSY;
-		break;
+		goto free_qc;
 	}
 
-	if (ret) {
-		/*
-		 * We must defer this qc: if this is not an NCQ command, keep
-		 * this qc as a deferred one and report to the SCSI layer that
-		 * we issued it so that it is not requeued. The deferred qc will
-		 * be issued with the port deferred_qc_work once all on-going
-		 * commands complete.
-		 */
-		if (!ata_is_ncq(qc->tf.protocol)) {
-			ap->deferred_qc = qc;
-			return 0;
-		}
-
-		/* Force a requeue of the command to defer its execution. */
-		ata_qc_free(qc);
-		return ret;
+store_qc:
+	/*
+	 * We must defer this qc: if this is not an NCQ command, keep
+	 * this qc as a deferred one and report to the SCSI layer that
+	 * we issued it so that it is not requeued. The deferred qc will
+	 * be issued with the port deferred_qc_work once all on-going
+	 * commands complete.
+	 */
+	if (!ata_is_ncq(qc->tf.protocol)) {
+		ap->deferred_qc = qc;
+		return 0;
 	}
 
-issue:
+free_qc:
+	/* Force a requeue of the command to defer its execution. */
+	ata_qc_free(qc);
+	return ret;
+
+issue_qc:
 	ata_qc_issue(qc);
 
 	return 0;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5c085ef4eda7..511cdf1a6650 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -371,6 +371,8 @@ enum {
 	/* return values for ->qc_defer */
 	ATA_DEFER_LINK		= 1,
 	ATA_DEFER_PORT		= 2,
+	ATA_DEFER_LINK_PMP_CBS	= 3,
+	ATA_DEFER_PORT_PMP_CBS	= 4,
 
 	/* desc_len for ata_eh_info and context */
 	ATA_EH_DESC_LEN		= 80,
-- 
2.54.0

