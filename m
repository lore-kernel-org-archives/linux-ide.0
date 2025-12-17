Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E632253FF
	for <linux-ide@vger.kernel.org>; Wed, 17 Dec 2025 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766013701; cv=none; b=DdSUNTUCEQ89a/xhMiRtGfTAynIBYE2wcqk1PFI7f0Pw+eTVVwFszPtdU0R1IN/q5cr+ed1N+eCtaogcjR0mvyjSnm7vd3febCYqU+GGp/shmADlNAGs7CGB2mEr1H4bus/1pCzoxoSQmuCDSHO5hL/2n/0lXVdzVCmTMkmGkAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766013701; c=relaxed/simple;
	bh=v4OsD0DhEACNDkNCda9xyYmGzqSNaZcAWyoz/QH44qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rb++c3nkOr+UF/lC/CiJsyY09sNnP1sbxM11Wcig94rOr69AR/P78zGpUTrmFxiv6Asqm80OUh0AMJ2T+RDlS/FdlOCuY1R5pXnqSBRB/OekipM/Hpyc2fLeQ1cn9P9KUL19b5l2AJsYLIlIR7h8D+8Pkblehs/Cd6Q0GRgVYeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yrvn9p62; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yrvn9p62"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F57C116B1;
	Wed, 17 Dec 2025 23:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766013701;
	bh=v4OsD0DhEACNDkNCda9xyYmGzqSNaZcAWyoz/QH44qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yrvn9p62ooe1xuwII/ALu2WYKVvSXtbhS8iVaa1mys2Rpkt43k6Cv0MWZAjEGVBl4
	 6Q03zzT358axMMMOWZANC4bSuTHXOS5h5fPX12sTn25BgY9GlgKdTHcHJ8fkYuCi++
	 xgyu6CY/TcGfcWLDjFhin8dhWA7oVfDU4pnLsAdolAF3dppTSwgMyQ0YW1hga9RE7L
	 NmsS74SVkHUXiviGF6mzrSaydjiAbDnLfNP3NtTLPCnmPuh8YCOME1cxClqAFPyRIS
	 dFFVRFhts4SzDD2VlAppTncBliQHP3I3+pd+iHsdsMzbyaHLhx4dlsqFsAEuWqKC5P
	 j5kuxiTRCq9zg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Igor Pylypiv <ipylypiv@google.com>,
	Xingui Yang <yangxingui@huawei.com>
Subject: [PATCH 1/2] ata: libata-scsi: refactor ata_scsi_translate()
Date: Thu, 18 Dec 2025 08:17:11 +0900
Message-ID: <20251217231712.490765-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217231712.490765-1-dlemoal@kernel.org>
References: <20251217231712.490765-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out of ata_scsi_translate() the code handling queued command
deferral using the port qc_defer callback into the new function
ata_scsi_defer(), and simplify the goto used in ata_scsi_translate().
While at it, also add a lockdep annotation to check that the port lock
is held when ata_scsi_translate() is called.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 66 ++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 721d3f270c8e..42d103542525 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1691,6 +1691,30 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 	ata_qc_done(qc);
 }
 
+static int ata_scsi_defer(struct ata_port *ap, struct ata_queued_cmd *qc)
+{
+	int ret;
+
+	if (!ap->ops->qc_defer)
+		return 0;
+
+	ret = ap->ops->qc_defer(qc);
+	if (!ret)
+		return 0;
+
+	ata_qc_free(qc);
+
+	switch (ret) {
+	case ATA_DEFER_LINK:
+		return SCSI_MLQUEUE_DEVICE_BUSY;
+	case ATA_DEFER_PORT:
+		return SCSI_MLQUEUE_HOST_BUSY;
+	default:
+		WARN_ON_ONCE(1);
+		return SCSI_MLQUEUE_HOST_BUSY;
+	}
+}
+
 /**
  *	ata_scsi_translate - Translate then issue SCSI command to ATA device
  *	@dev: ATA device to which the command is addressed
@@ -1714,8 +1738,8 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
  *	spin_lock_irqsave(host lock)
  *
  *	RETURNS:
- *	0 on success, SCSI_ML_QUEUE_DEVICE_BUSY if the command
- *	needs to be deferred.
+ *	0 on success, SCSI_ML_QUEUE_DEVICE_BUSY or SCSI_MLQUEUE_HOST_BUSY if the
+ *	command needs to be deferred.
  */
 static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 			      ata_xlat_func_t xlat_func)
@@ -1724,56 +1748,46 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 	struct ata_queued_cmd *qc;
 	int rc;
 
+	lockdep_assert_held(ap->lock);
+
+	/*
+	 * If we fail to allocate a qc, simply return without reporting an error
+	 * as scsi_done(cmd) is already called.
+	 */
 	qc = ata_scsi_qc_new(dev, cmd);
 	if (!qc)
-		goto err_mem;
+		return 0;
 
 	/* data is present; dma-map it */
 	if (cmd->sc_data_direction == DMA_FROM_DEVICE ||
 	    cmd->sc_data_direction == DMA_TO_DEVICE) {
 		if (unlikely(scsi_bufflen(cmd) < 1)) {
 			ata_dev_warn(dev, "WARNING: zero len r/w req\n");
-			goto err_did;
+			cmd->result = (DID_ERROR << 16);
+			goto done;
 		}
 
 		ata_sg_init(qc, scsi_sglist(cmd), scsi_sg_count(cmd));
-
 		qc->dma_dir = cmd->sc_data_direction;
 	}
 
 	qc->complete_fn = ata_scsi_qc_complete;
 
 	if (xlat_func(qc))
-		goto early_finish;
+		goto done;
 
-	if (ap->ops->qc_defer) {
-		if ((rc = ap->ops->qc_defer(qc)))
-			goto defer;
-	}
+	rc = ata_scsi_defer(ap, qc);
+	if (rc)
+		return rc;
 
-	/* select device, send command to hardware */
 	ata_qc_issue(qc);
 
 	return 0;
 
-early_finish:
-	ata_qc_free(qc);
-	scsi_done(cmd);
-	return 0;
-
-err_did:
+done:
 	ata_qc_free(qc);
-	cmd->result = (DID_ERROR << 16);
 	scsi_done(cmd);
-err_mem:
 	return 0;
-
-defer:
-	ata_qc_free(qc);
-	if (rc == ATA_DEFER_LINK)
-		return SCSI_MLQUEUE_DEVICE_BUSY;
-	else
-		return SCSI_MLQUEUE_HOST_BUSY;
 }
 
 /**
-- 
2.52.0

