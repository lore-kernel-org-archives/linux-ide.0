Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3F53A5420
	for <linux-ide@vger.kernel.org>; Fri,  1 May 2026 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777640062; cv=none; b=E142g+s7Ugfd98WkoOoAfF2m0vK1DrPHLkickT+3A7I1h2ffN8MSTw9zA92T+zbJzlvcKSsbI2iv7eXLsXCMKz7ur9kKxnWzB7eaEU2WxRACdtTAWGV4H4sgJJYrouez1avDNU5W+3hhk0LYWcARRn7BtNmXq1dQqIrp++1BE38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777640062; c=relaxed/simple;
	bh=Mhx8R7RfUXtSX09O8KpG01EuKahyvztstMi2Npfyq1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s64OksS/35sEseKA0kG8lQ8bM1f39bARzO+OeMDgGPZ9neXeKdU+X4VFTFUKlBD/rZ40Rp+9WIWeJOUK6ARNoq86x3hE0j8Suo+aPxV+O3DYLcLYgeXphevwwydSe38H/aFFXiW3nvxltD1hRwvSth8tmVeTMk4YVDcR2Y4CryE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqzN7uJT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqzN7uJT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B540FC2BCB4;
	Fri,  1 May 2026 12:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777640062;
	bh=Mhx8R7RfUXtSX09O8KpG01EuKahyvztstMi2Npfyq1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gqzN7uJTGKjfc7alA9431lCE6pWnE/QyTN2oIGxVL8W6iKLJYHgrq5TdMgnWXb+yc
	 sv+Uufek8IVXI9mg2AGkthk2OC/QNb1zFfsHKjFS2imbqKzgzlHAHA4KH71aUqbdgd
	 6J1HO5n/s9fYYz/2kZ+PFeoZTIZxnWjNBacyzfkO2McAIPMZYS5DNe/rHTK5+uY2kY
	 jjUW1x6JdLFixK1pcsPagAQYznkAkjNdBT3udDpNeK71E4jIRN/nQ7xDUmMVDTfxjR
	 hlDp/ilZ+Jq3rZYPr2DxjFpWR9mqZEIHxjq4Zl9k7bflpuhw5a7d2hJCM6ufKclptS
	 9Z7x3+ZiDz16A==
From: Niklas Cassel <cassel@kernel.org>
To: Tommy Kelly <linux@tkel.ly>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH 2/3] ata: libata-scsi: do not use the deferred QC feature on PMPs with CBS
Date: Fri,  1 May 2026 14:54:12 +0200
Message-ID: <20260501125410.1204490-7-cassel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501125410.1204490-5-cassel@kernel.org>
References: <20260501125410.1204490-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3422; i=cassel@kernel.org; h=from:subject; bh=Mhx8R7RfUXtSX09O8KpG01EuKahyvztstMi2Npfyq1g=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDK/LCpWZHhy+mLkrV8Zi5MPWZ2qflOhJr3jSfql8s+1K klTxO9Id5SyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAiU84w/E93XcRf5SRTq776 7dwD7RfsD8iuUj8mwPR584/DuTv1L7xiZNh0fVeQo45WxKWjp5Zv6tyw93DsQot/1fVPZ3BeFnj ZxM8JAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

When using Port Multipliers (PMPs) with Command-Based Switching (CBS), you
can only issue commands to one link at a time. For PMPs with CBS, there is
already code to handle commands being send to different links in
sata_pmp_qc_defer_cmd_switch(), which will return ATA_DEFER_PORT when
trying to send a command (NCQ or non-NCQ) to the non-active link.

After commit 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command
starvation"), in addition to the existing handling PMP CBS handling, we
would also, incorrectly, save a non-NCQ command to another link in
ap->deferred_qc. The deferred qc feature was only meant to defer QCs to
the same link, not to duplicate the existing PMP CBS deferal logic when
dealing with separate links.

Note that when deferring commands to the same link (i.e. because NCQ and
non-NCQ commands are mixed), even when using a PMP with CBS, we will use
the deferred_qc feature that issues the deferred qc via a workqueue
(because sata_pmp_qc_defer_cmd_switch() in this case ATA_DEFER_LINK is
returned).

Since the deferred_qc issuing via workqueue was only meant to deal with a
single link, modify the code to feature to only set link->deferred_qc when
deferring a qc to the same link (ATA_DEFER_LINK), and not when deferring a
qc because we are not issuing a qc to the active link (ATA_DEFER_PORT).

If we want to modify the scope of the workqueue issuing to also handle the
case where we issue commands to the link that is not the active link, then
we should ensure that it can save both NCQ and non-NCQ commands, while also
removing some of the existing PMP CBS handling, such that we don't
duplicate features.

Thus, modify ata_scsi_qc_issue() to only use the deferred_qc workqueue for
ATA_DEFER_LINK and not for ATA_DEFER_PORT.

Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-scsi.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index f44612e269a4..dca7ea7e6315 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1785,18 +1785,6 @@ static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
 	case 0:
 		break;
 	case ATA_DEFER_LINK:
-		ret = SCSI_MLQUEUE_DEVICE_BUSY;
-		break;
-	case ATA_DEFER_PORT:
-		ret = SCSI_MLQUEUE_HOST_BUSY;
-		break;
-	default:
-		WARN_ON_ONCE(1);
-		ret = SCSI_MLQUEUE_HOST_BUSY;
-		break;
-	}
-
-	if (ret) {
 		/*
 		 * We must defer this qc: if this is not an NCQ command, keep
 		 * this qc as a deferred one and report to the SCSI layer that
@@ -1811,7 +1799,20 @@ static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
 
 		/* Force a requeue of the command to defer its execution. */
 		ata_qc_free(qc);
-		return ret;
+		return SCSI_MLQUEUE_DEVICE_BUSY;
+	case ATA_DEFER_PORT:
+		/*
+		 * ATA_DEFER_PORT is returned when the host is busy, e.g. when
+		 * using a PMP with CBS and trying to issue a qc to a link that
+		 * is not the currently active link. In this case, simply
+		 * propagate the error back to the SCSI layer.
+		 */
+		ata_qc_free(qc);
+		return SCSI_MLQUEUE_HOST_BUSY;
+	default:
+		WARN_ON_ONCE(1);
+		ata_qc_free(qc);
+		return SCSI_MLQUEUE_HOST_BUSY;
 	}
 
 issue:
-- 
2.54.0

