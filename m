Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086551B4244
	for <linux-ide@vger.kernel.org>; Sat, 20 Dec 2025 00:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766190374; cv=none; b=Z78XlPHC1rnKYTzlZHzvMS3hywY1MrR6gqjoas41UlnY53zS3C6VCZDV1Z7z+YJPj+V0Rr0e0Ea3EnamrZ4hkPgfwjxEdX+jpIetWtLxrQ3NsDRuG9SmOyd27CS8h9ObSuFOypFeG2JNNFQ1HhRBbyplmpyXL4AYMEKVua2sWy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766190374; c=relaxed/simple;
	bh=3UZhWHXU8kC30YeUa5Qxqt5CgV3/pTubx8vq0NsoFco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGrQ9J1bsILyYvkjtFplZC/3a8e3/3c7y7p6jXeyxpVdWxbaCKy8X8zHwW3RBS/iDjP+yuNqJlx+ECHHc9DPMbulz/6h0IYzi8eLt7achbTm1OALKom5C3QYPIXYsQEDrF2rZy7/J55xaAZR5tbdBh3wvrPonjsTi5vgFW8e9G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgHI94IV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgHI94IV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2F2C4CEF1;
	Sat, 20 Dec 2025 00:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766190373;
	bh=3UZhWHXU8kC30YeUa5Qxqt5CgV3/pTubx8vq0NsoFco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BgHI94IVpGqvR5DuCNylm5kdl4FGcNWaPmG+e4ZWS+9XPs5h9BGfteYIiPtAG93lo
	 DNQmO5bjajve5nUGartxNzYzt/JPOz8RIe1lV6y5F0aoyI38UhBVbGLuu+3NGqK1bJ
	 XM2eKvPTTZ4astuOUqOx3VQSjZkXveP68xb1TCc5d5A90GlPtuxTp/yrlfxjepjlB+
	 CXetOnnGYDWXFkvxpBJwejQhI2NDV8tLQGp8EZwV0ABI6fLliAI0yCztYS9nYZqa2s
	 rq91xj/KVe1gE0HxsvFjO93iRFKnoF7yapkPBlR4xMfLkys9ApxgfrEIgfIh502N2C
	 9v9mKFHnpLC7g==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Igor Pylypiv <ipylypiv@google.com>,
	Xingui Yang <yangxingui@huawei.com>,
	John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 1/2] ata: libata-scsi: refactor ata_scsi_translate()
Date: Sat, 20 Dec 2025 09:21:39 +0900
Message-ID: <20251220002140.148854-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251220002140.148854-1-dlemoal@kernel.org>
References: <20251220002140.148854-1-dlemoal@kernel.org>
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

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 66 ++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 721d3f270c8e..8e04fc173ea3 100644
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
+	 * ata_scsi_qc_new() calls scsi_done(cmd) in case of failure. So we
+	 * have nothing further to do here when allocating a qc fails.
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

