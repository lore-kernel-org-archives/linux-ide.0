Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24356397E64
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2026 07:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778744355; cv=none; b=NT1G7JQNCyU1PIIZ3k/CY5Hr7dQJNOaZj7yWmgCN9YU6qeR0bR5eeApAf1SQzdDK49pahvFvOw1WXMrCjwZbVvUi+giAtum4KiQS2CFlZxiacyQaVmcHrHZIDK8B22YdyoVSC5VG6u02uHMqFGbTK9vucVLRQGte1gzmnJ3Obb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778744355; c=relaxed/simple;
	bh=uuvjrREt/zafTJVoTQRbPXBrfzzJSxfZNwSNSWcq4zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAywUywN9zJyInhZfU4wjBDL3omtPEcfjOQOFicaG3+V7Gd0mb4NhySgtkjbe1Mbs4KO///gYcU4ZdoZmNukMci1OoP+xbftFETE8ruuo0XhaE0i3gLqEqyP6+A4yR7jL7cMj0oUA+g4gBquanO0Sg/qUfGEJwBt+w7MM5LlCbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9wy/Byx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9wy/Byx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E71C2BCC6;
	Thu, 14 May 2026 07:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778744354;
	bh=uuvjrREt/zafTJVoTQRbPXBrfzzJSxfZNwSNSWcq4zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N9wy/ByxvQ7EZkFm3/dM6tdDitshHhVS3MJcO3Xs8ta1/NY+/phw+Jxjko/9bOyQr
	 RwsByml+Q0Jb41QCVklD/S5t1A+6uQbVVWG5mJIePSt8WkyrifVpXRT5INhimTWi+P
	 3usNaMi75hKUA93BDKs8JRQ+7TNMOk5ino0tUqqAUQL2ZkSFhlt/yixjGzUQiJapnt
	 +c4Akz/PWGi9WEq4KJeGfP6QiMZA6NEhCyuRD4YXcGeSXLCa8SnOULO0J9cHRd3zVO
	 4YZoxhv/eyOkenjKWqo+lY5eU2WjRyxW86JknWCTRCpCfxwMt+dYubD8jeEk8ws/9F
	 qRTeWN5wcE1gw==
From: Niklas Cassel <cassel@kernel.org>
To: Tommy Kelly <linux@tkel.ly>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH v5 3/4] ata: libata-scsi: do not use the deferred QC feature on PMPs with CBS
Date: Thu, 14 May 2026 09:39:01 +0200
Message-ID: <20260514073858.1175072-9-cassel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514073858.1175072-6-cassel@kernel.org>
References: <20260514073858.1175072-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5144; i=cassel@kernel.org; h=from:subject; bh=uuvjrREt/zafTJVoTQRbPXBrfzzJSxfZNwSNSWcq4zs=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJYa0QcpxnUVz9zq3Z2WHMgv+uCyqmPs5pDM46zv/p75 sh5zX03OkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRh0qMDJfPCG/g4FrZZ1f6 qOSa5KNtjxj3ue4xT/3qtuL7vQdKmw8z/FONDBCI9rTgKH93rPHE2s45OS01F7LPM8Xc2KEduqz vChsA
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
index 22642a0e6b84..10f1ee8acc37 100644
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
+		goto free_qc;
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

