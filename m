Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14275246BBA
	for <linux-ide@vger.kernel.org>; Fri, 19 Dec 2025 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766130964; cv=none; b=pJuoc3vqS5F8d/HQFNWvvcWLTc5EB7LAR+C7e9B9bIA3sL/t7Ps4z0OasoS6jYKUAd/nMvryUjbMHwwJkdqU3wqqIjybIRJi35srDLffn9Rd+5x+R9G69xY/OD1/a6F8PrbGwRHsRaIGCDP9+Wcg3cyynXLCkvA8I3fXYCGLroU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766130964; c=relaxed/simple;
	bh=CPoyAbuk6Gz/8xzUr4zU7H2z7Po9wWi83kqnjF9gSKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQfl0WbmYvI+wMyiFo4HZ20f0SJ1I19NeaMmc2wXA+cNBI0z1J1EWpVbSnH3Tq9qBN+1Lqtg8FlHUMOeEGAeIK6tVjiynaqVdnQps1hm03i8dXKMSBrX9kUVn0CHs5L9a9B7+yuOQ0G4zDX5AhDpFRWK5bBlE7LvL+U0nJ9CC5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3fDrj5f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3fDrj5f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22832C116B1;
	Fri, 19 Dec 2025 07:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766130963;
	bh=CPoyAbuk6Gz/8xzUr4zU7H2z7Po9wWi83kqnjF9gSKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u3fDrj5fW8lICHNdXwdcbHZwO+KjXBgsjpQTcfl5rtesALaBQrLQ0boMdPUQJEAwD
	 IR0CLLJCm0IY+aVTr1TLVjY9mcwO7PzjeE7njV79Z7Q0pNz42+4mDfidXJAkyn7b6Q
	 rDVlkjrGJcBxIdyPJyLwmuaPsMqDV7V7ZZlJwGa+v8XpKA41HzyQyMBHUGoEk9hcxo
	 gYJEAQ+tI+gnBgy9L7yK84T2QPFNc6M3IAX4DLrGlvHnaOXAeqnSAh3uxy/d7RgtLD
	 ipiSeu1h6VdJjcXIHKP3Vq6IFj+2YyKR7JzqyHmEUrgGBRHh1EXP2XcPRMxAcch4wr
	 ScUk1MaF0o7sw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Igor Pylypiv <ipylypiv@google.com>,
	Xingui Yang <yangxingui@huawei.com>
Subject: [PATCH v2 1/2] ata: libata-scsi: refactor ata_scsi_translate()
Date: Fri, 19 Dec 2025 16:51:33 +0900
Message-ID: <20251219075134.501727-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219075134.501727-1-dlemoal@kernel.org>
References: <20251219075134.501727-1-dlemoal@kernel.org>
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

