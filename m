Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78851397E64
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2026 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778744350; cv=none; b=hZjAguWkF2kg/oMtH36Pt9D0GMWG2VbzYvQ7SK4zL7dVrOpAsZeuT2oFYja6mqzrP9tfabYEBMdxvc7DQAQKB56jmbPbANqC2b4Xc7McETA6BLcxjWJUbRGT1ERjLE6yZTXTXyqfvx3YNAFvkNUhxSzT89xEsawPmxD20E+zPe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778744350; c=relaxed/simple;
	bh=7XVAuWe9jwMAcS2atGTSKlwZh4NFZXOJ0YhwSzZ0zxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBYTr2ZFCL47SWgy/FrEl7B1goTV32zGOda1MWA8ChMtBEKBop0KcT+14BzlKoEln/6Cq06nfmqtDt/Xr1/7jRcVppBaDRn3ykdf6x0ZHT9iGLFKE9aMywHF9GGLeay3dA/N8CPZ/rNS+CGf3H5t54y+caJYBNjGEvxCV3IE6YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bpx3cL0b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bpx3cL0b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A558DC2BCB7;
	Thu, 14 May 2026 07:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778744350;
	bh=7XVAuWe9jwMAcS2atGTSKlwZh4NFZXOJ0YhwSzZ0zxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bpx3cL0bCkgjrrYnzVtbU3tz/FvfXD29qJFbYqLbfpmy1q92RJajG8rgE6q7ad/eU
	 6Rm47S628IUuW+DWGq4+xeuri3TxZApt/s7H7KOtX91Jbget9nC+ITgqTOaGdUigPv
	 MNgsOovhhrR+8I69FI+3w7EugspEaM5NHjfwoPjLxuhevb4lpzWdnh0BC5ydnUboPw
	 8ReOT5uppZG8oE59GZnJaWu4xcrl/WEqr2r5tOfA4GQhe5KsesxtFeV1BaxMFNCISW
	 7bGpIsSZ+bsKBDzYWdBaBsxsBgxkrZelR3cS21DlegyBB0or0dveoKtZjF6ipie/qp
	 pSExNLRerP3BA==
From: Niklas Cassel <cassel@kernel.org>
To: Tommy Kelly <linux@tkel.ly>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH v5 1/4] ata: libata-scsi: improve readability of ata_scsi_qc_issue()
Date: Thu, 14 May 2026 09:38:59 +0200
Message-ID: <20260514073858.1175072-7-cassel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514073858.1175072-6-cassel@kernel.org>
References: <20260514073858.1175072-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2217; i=cassel@kernel.org; h=from:subject; bh=7XVAuWe9jwMAcS2atGTSKlwZh4NFZXOJ0YhwSzZ0zxk=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJYa4Qv9q0/61a4Uf3fSx7G31afzqzzSJ4TqXU47duaD xOfH/2T3FHKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJyKgw/FMQ4/DdUdlh4d3T 1LTq4ps8xgqp963soucL+V+tPlxsY8jwz9KDf+uEti82lhUrnZ6FPSiz9eL54zl1gvg8O3utH2G LOQA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Improve readability of ata_scsi_qc_issue().

No functional changes.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-scsi.c | 43 +++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 6733f2b14521..b9064dd4390c 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1767,7 +1767,7 @@ static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
 	int ret;
 
 	if (!ap->ops->qc_defer)
-		goto issue;
+		goto issue_qc;
 
 	/*
 	 * If we already have a deferred qc, then rely on the SCSI layer to
@@ -1786,38 +1786,37 @@ static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
 		break;
 	case ATA_DEFER_LINK:
 		ret = SCSI_MLQUEUE_DEVICE_BUSY;
-		break;
+		goto defer_qc;
 	case ATA_DEFER_PORT:
 		ret = SCSI_MLQUEUE_HOST_BUSY;
-		break;
+		goto defer_qc;
 	default:
 		WARN_ON_ONCE(1);
 		ret = SCSI_MLQUEUE_HOST_BUSY;
-		break;
+		goto defer_qc;
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
+issue_qc:
+	ata_qc_issue(qc);
+	return 0;
 
-		/* Force a requeue of the command to defer its execution. */
-		ata_qc_free(qc);
-		return ret;
+defer_qc:
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
-	ata_qc_issue(qc);
+	/* Force a requeue of the command to defer its execution. */
+	ata_qc_free(qc);
 
-	return 0;
+	return ret;
 }
 
 /**
-- 
2.54.0

