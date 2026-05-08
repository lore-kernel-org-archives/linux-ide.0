Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA8E284662
	for <linux-ide@vger.kernel.org>; Fri,  8 May 2026 19:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778268781; cv=none; b=beOXh7EHFtkWB11IKQQo2whXfn21rb1P9EBvOcewnzo9g6bKmrI5xam0fkZ7Wgh2gsQnkDMn10DnMbdt/Q3RLAjwZR1aX9gDfjYHa9jfV/1YgsGfwaa/xEHkcuV0eHPzki5g2UtojfKK4rfdFR5pAi2CvQyxsp9Ar44Z1xsBZso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778268781; c=relaxed/simple;
	bh=fCzxSc3g8IQvtDPl7PPeMBpuyhUUgjzF0QyA34BWFs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NK/AdkOW1Vn568bwkGhJEe4qslklqYmcS1+vLmc2bdDmG3GPgFjSlBT92qtXxaBfIYyB1ebnOFP4y7jj4DWUjkqTCBGfFthRyKI9qwNttcFJewAk7CUp+sbw9ghgR/WW+DMB0zgdQrXYVbFNekx1Fx1blTtRZUDGPlFMs7XPpGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzjP1WUY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzjP1WUY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C90C2BCB0;
	Fri,  8 May 2026 19:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778268781;
	bh=fCzxSc3g8IQvtDPl7PPeMBpuyhUUgjzF0QyA34BWFs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fzjP1WUY9lvAjvhbb/BPcApKxOJUE0yFh7JI5rvmpxlXTxf3v+8QPcV1dFKbLELvM
	 yHjun/MdTTnRsF+GkUSIsCnaXhVSWONuRF2JLalI/o7NA6DDcuaAnN2N/80osVvjfL
	 qR/OBxmS8xuVO7N3mgP3ersKd5LvUyE81bv5c6/JQ0Skc1BmrIlcVhxkasVHmzhzHv
	 tKtZkjOKvj8k1Wfqw+bScXiFUiJ4AKul+ahvWL8VSru1z3ODd2pWhmOxT2DkKVG7/E
	 chcaX6SaSDQIgnNhnkWSVgBWMb5o/pNLLJANLKdTyOSr14MGxrV4JG7mXmsrgZVlbw
	 HERa0pzYGvvwQ==
From: Niklas Cassel <cassel@kernel.org>
To: Tommy Kelly <linux@tkel.ly>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH v2 1/2] ata: libata-scsi: do not use the deferred QC feature on PMPs with CBS
Date: Fri,  8 May 2026 21:32:41 +0200
Message-ID: <20260508193240.176735-5-cassel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508193240.176735-4-cassel@kernel.org>
References: <20260508193240.176735-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6310; i=cassel@kernel.org; h=from:subject; bh=fCzxSc3g8IQvtDPl7PPeMBpuyhUUgjzF0QyA34BWFs4=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDL/WSXm3Ll9YNr24j0fjveHGvk7v2dh2hRuENX5ZcYfI Wl180bOjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEwkq4GRYZdt2cyna1NSDBfN ebz328oFK/jOm11gmngmNJuZxeSz1zGG/9WRrg6FE9ojuric79VkrEu3X6h2esbh/rVvtCLOFdz w5wQA
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
 drivers/ata/libata-pmp.c  | 24 ++++++++++++++--
 drivers/ata/libata-scsi.c | 58 ++++++++++++++++++++++++---------------
 include/linux/libata.h    |  2 ++
 3 files changed, 60 insertions(+), 24 deletions(-)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index e3adc008fed1..d847bdff6d0a 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -113,14 +113,34 @@ int sata_pmp_qc_defer_cmd_switch(struct ata_queued_cmd *qc)
 
 	if (ap->excl_link == NULL || ap->excl_link == link) {
 		if (ap->nr_active_links == 0 || ata_link_active(link)) {
+			int ret;
+
 			qc->flags |= ATA_QCFLAG_CLEAR_EXCL;
-			return ata_std_qc_defer(qc);
+			ret = ata_std_qc_defer(qc);
+			switch (ret) {
+			case 0:
+				return ret;
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

