Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A611E397E64
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2026 07:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778744352; cv=none; b=F8Xb9ARKDRtrfTtaHn2SllsYNdRWKsCKHFCWBFqg4+jtl8Lg6P90otsJa6oN89M0z/eG+P6f1xI5ACcdZfs/SOgq76qOMp/l0jV6RP0b+Wn4t+1YqzsIkYrmhGflbT+iQJFA7Z6ib9HVX/kAIgCekGi6x+u8BYdY2PtYteoLo3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778744352; c=relaxed/simple;
	bh=QL1hgyowVfja/vcJIALXSKCDzjwmNt42m3BowKG8WeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cwh9mcaXcp7N9cBxAjraIkmvifFCNUnruG+56pwIvPh9n+p4INyxDVt6LTosnLxcWV9HhFMWB9GbH3ywEOKENrIX8GjP6RSdYlYxFOjGisk8cSt/filLw3boB636cIttDAKH2eUTCjLqs5k64v7vrMWQqGhV2+UpXG3MC11vblc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oY0jxReP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oY0jxReP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AA7C2BCB7;
	Thu, 14 May 2026 07:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778744352;
	bh=QL1hgyowVfja/vcJIALXSKCDzjwmNt42m3BowKG8WeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oY0jxRePNuItuTodjqPMEqFWwfg0gn1Rq5xCBWQBCEsJ9VJncLvjRav5PE58avugd
	 jGS4hrDB4QrwDirYDBlR+jQpnQ/oO/ph0iM2q4YXEs6N6TXs0H2axGnhFtbzurLDbp
	 zWa4Gr+kBU25kfKw6PHdC4ubXwepSsfmno9c4ThYyLwuZQgddusJOCCcWwuEasceo3
	 ldBOy+Bb7M7rFE2dJv5i745HV8JvJal7J4AkdS3hNM5TCiS14kECNXK4rTeYgZAuFw
	 4s3XWsFjW4g4xPC4R88bNZ9KqOKhN+tcKoHSzhE78yc03COVZDaFz/A8Ua/uR4qw+O
	 ubLsRRKlQCz1g==
From: Niklas Cassel <cassel@kernel.org>
To: Tommy Kelly <linux@tkel.ly>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH v5 2/4] ata: libata-scsi: do not use the deferred QC feature for ATA_DEFER_PORT
Date: Thu, 14 May 2026 09:39:00 +0200
Message-ID: <20260514073858.1175072-8-cassel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514073858.1175072-6-cassel@kernel.org>
References: <20260514073858.1175072-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1567; i=cassel@kernel.org; h=from:subject; bh=QL1hgyowVfja/vcJIALXSKCDzjwmNt42m3BowKG8WeQ=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJYa4RdHytmaC1dwPNi7/F1OUEvqv5xVN7qKWX9Kj6Pw /tmidm+jlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEzkTinD/4gdvnq3mYUrvpUp cj/VW8nKa3774pWLggreagFnLKULnRkZmtuXO7ByTqxQPzZl/d0ojY9XrGrZFhl+Lfh8t+CRGes 7DgA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The deferred QC feature was meant to handle mixed NCQ and non-NCQ commands,
i.e. for return value ATA_DEFER_LINK.

ATA_DEFER_PORT is returned by PATA drivers, but also certain SATA drivers
like sata_mv and sata_sil24 that uses ap->excl_link to workaround hardware
bugs in these HBAs. Regardless of the reason, using the deferred QC feature
for ATA_DEFER_PORT is always wrong, and will break the ap->excl_link usage
of the SATA drivers that rely on that feature.

Modify ata_scsi_qc_issue() to only use the deferred QC feature when mixing
NCQ and non-NCQ commands, i.e. ATA_DEFER_LINK.

Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-scsi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b9064dd4390c..22642a0e6b84 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1789,11 +1789,11 @@ static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
 		goto defer_qc;
 	case ATA_DEFER_PORT:
 		ret = SCSI_MLQUEUE_HOST_BUSY;
-		goto defer_qc;
+		goto free_qc;
 	default:
 		WARN_ON_ONCE(1);
 		ret = SCSI_MLQUEUE_HOST_BUSY;
-		goto defer_qc;
+		goto free_qc;
 	}
 
 issue_qc:
@@ -1813,6 +1813,7 @@ static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
 		return 0;
 	}
 
+free_qc:
 	/* Force a requeue of the command to defer its execution. */
 	ata_qc_free(qc);
 
-- 
2.54.0

