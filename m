Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99690494A00
	for <linux-ide@vger.kernel.org>; Wed, 13 May 2026 15:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685255; cv=none; b=GCvSyTogkbKrTSjr0GbiTXJ4MFpRUz3m+yZvgLeEE1KQ6AvbcK/hdeS30aP9LMTBRFQVRcb+Nfac5niJV+AjC6z6GXpXbI3BYybSxFpZAyHfxnKB3fLEU2KtKMJ4Gh24GxJXJMD6iGlqDlr6heXiSSKvxw+Qp0MTClaMlFGEePo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685255; c=relaxed/simple;
	bh=YrB9IdA6xIKP5/LObDbHkjJiP8FkYMQohK0ttu4BjEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXtRQSlHPlNCS2Fh7ie6+PvEtlgV3/K9yOgYP46C5Jed3nq4ArsxJVZch77BS8UPg2U1ae1Hr8qtFge/0kIjro+H6aZpek7ngFHIqg2k7nmZSAfwekQ5R12ST+tdwOd+CMK8YkBGRBtZ4xNKisoh043ewVZ/azDqSERoMReoRX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaXFmM4W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaXFmM4W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0833C2BCB3;
	Wed, 13 May 2026 15:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778685255;
	bh=YrB9IdA6xIKP5/LObDbHkjJiP8FkYMQohK0ttu4BjEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UaXFmM4WjzhEFb0nXja0zRa5/L/GMdgC3JqwsWHrJ8Qa1tVpE4qnAZV3dU+OuQnWA
	 pMnDgAhUpUke6FNsD8km0TjzNNFIzKZSxHA6YB9c7ECXyZZGPMDh/xEidNJl5dsHMK
	 BTo2im6NYEESiN+QVHZVR8tMxC4by2nqkRgMCRKCdLTQauWqkUfKsE8TjC5Ptdpkdu
	 dwfong8IS8XgqcrmKagY24/uXfK3fooiAEZLMz/UL6v5aCf9aRM/90BW7GEq9Y5CA4
	 Uvcc/VffpmtMOHHMBjP3mVNiQOmqkMqcLWiHbtCDMaVsjUp9Hhf1rajMTwsGKgyzuP
	 VtO5NsCAdMABw==
From: Niklas Cassel <cassel@kernel.org>
To: Tommy Kelly <linux@tkel.ly>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH v4 3/4] ata: libata-scsi: do not use the deferred QC feature on PMPs with CBS
Date: Wed, 13 May 2026 17:14:02 +0200
Message-ID: <20260513151359.1075403-9-cassel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513151359.1075403-6-cassel@kernel.org>
References: <20260513151359.1075403-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5145; i=cassel@kernel.org; h=from:subject; bh=YrB9IdA6xIKP5/LObDbHkjJiP8FkYMQohK0ttu4BjEw=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJYplr8YJn/WMRE9ZbIbobtRW+nfsv81njiW3q1b0ezu +YM3jtLO0pZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRiyWMDO3VnxRqTF78a97r IhFYnPEm8d6Ny/9Z3L0exjLtm/Duvgojw+xr8x5cEOVSLv8gqjh7/0bjdo0s3lU+c18/+zHvZvF WcSYA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

When using Port Multipliers (PMPs) with Command-Based Switching (CBS), you
can only issue commands to one link at a time. For PMPs with CBS, there is
already code to handle commands being sent to different links in
sata_pmp_qc_defer_cmd_switch() using ap->excl_link. sata_sil24 also makes
use of ap->excl_link.

A user on the list reported that commit 0ea84089dbf6 ("ata: libata-scsi:
avoid Non-NCQ command starvation") broke PMPs with CBS. The commit
introduced code that stores a deferred qc in ap->deferred_qc, to later be
issued via a workqueue. It turns out that this change is incompatible with
the existing ap->excl_link handling used by PMPs with CBS.

Thus, modify sata_pmp_qc_defer_cmd_switch() and sil24_qc_defer() to return
ATA_DEFER_LINK_EXCL, and make sure that the deferred QC handling via
workqueue is not used for this return value.

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
 drivers/ata/libata-pmp.c  | 13 ++++++++++++-
 drivers/ata/libata-scsi.c |  8 ++++++++
 drivers/ata/sata_sil24.c  |  6 +++++-
 include/linux/libata.h    |  1 +
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index e3adc008fed1..7e889534d73b 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -110,13 +110,24 @@ int sata_pmp_qc_defer_cmd_switch(struct ata_queued_cmd *qc)
 {
 	struct ata_link *link = qc->dev->link;
 	struct ata_port *ap = link->ap;
+	int ret;
 
 	if (ap->excl_link == NULL || ap->excl_link == link) {
 		if (ap->nr_active_links == 0 || ata_link_active(link)) {
 			qc->flags |= ATA_QCFLAG_CLEAR_EXCL;
-			return ata_std_qc_defer(qc);
+			ret = ata_std_qc_defer(qc);
+			if (ret == ATA_DEFER_LINK)
+				return ATA_DEFER_LINK_EXCL;
+			return ret;
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
 
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 22642a0e6b84..02f2d7416c83 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1787,6 +1787,14 @@ static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
 	case ATA_DEFER_LINK:
 		ret = SCSI_MLQUEUE_DEVICE_BUSY;
 		goto defer_qc;
+	case ATA_DEFER_LINK_EXCL:
+		/*
+		 * Drivers making use of ap->excl_link cannot store the QC in
+		 * ap->deferred_qc, because the ap->excl_link handling is
+		 * incompatible with the ap->deferred_qc workqueue handling.
+		 */
+		ret = SCSI_MLQUEUE_DEVICE_BUSY;
+		goto defer_qc;
 	case ATA_DEFER_PORT:
 		ret = SCSI_MLQUEUE_HOST_BUSY;
 		goto free_qc;
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index d642ece9f07a..57f1081b86db 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -789,6 +789,7 @@ static int sil24_qc_defer(struct ata_queued_cmd *qc)
 	struct ata_link *link = qc->dev->link;
 	struct ata_port *ap = link->ap;
 	u8 prot = qc->tf.protocol;
+	int ret;
 
 	/*
 	 * There is a bug in the chip:
@@ -826,7 +827,10 @@ static int sil24_qc_defer(struct ata_queued_cmd *qc)
 		qc->flags |= ATA_QCFLAG_CLEAR_EXCL;
 	}
 
-	return ata_std_qc_defer(qc);
+	ret = ata_std_qc_defer(qc);
+	if (ret == ATA_DEFER_LINK)
+		return ATA_DEFER_LINK_EXCL;
+	return ret;
 }
 
 static enum ata_completion_errors sil24_qc_prep(struct ata_queued_cmd *qc)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5c085ef4eda7..360776016b50 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -371,6 +371,7 @@ enum {
 	/* return values for ->qc_defer */
 	ATA_DEFER_LINK		= 1,
 	ATA_DEFER_PORT		= 2,
+	ATA_DEFER_LINK_EXCL	= 3,
 
 	/* desc_len for ata_eh_info and context */
 	ATA_EH_DESC_LEN		= 80,
-- 
2.54.0

