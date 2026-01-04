Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4463A1E63
	for <linux-ide@vger.kernel.org>; Sun,  4 Jan 2026 08:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767515195; cv=none; b=uxzx7SGoWZrUlMKG6wh5aY7ho0v1wQE6GAhZquWvY1G/mV6xY0V21+hQfh61i1ayuLKRE7UOFOCuBlCm1k78Z8N5XEW5z9tYJbhyyyjoBf3EHzv7iejMM3nUw1lx/lE0Ubt1bI0ffZ1xyvRrhLRu501OnVnHbx9ZBJe5hpxPrOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767515195; c=relaxed/simple;
	bh=bNXJihTjncJHPS+bFT0Dr18jL8O6U3Ti8JlmHdIOj4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AF3yLRK1rGpzExY7WaLUT7wWOIQleKSn2LDs8Fkdqhp1Lll3F3fzuB30eDPy4FLK0zY5sptAuyNjMG159PZRlt8ZKH49eX21FWzqfXXbEtJPejRu1j5qjwzdRM9G4zA2fzBQvfFn40k7oKSbxP8ETA3BL7U5OaeVC4FbCTE16wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZcWrhmh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZcWrhmh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762C5C19424;
	Sun,  4 Jan 2026 08:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767515195;
	bh=bNXJihTjncJHPS+bFT0Dr18jL8O6U3Ti8JlmHdIOj4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fZcWrhmhahARvJ6lKoLC97wDFqGeKGh3tjeAS9t8GlMElWANQQ8ERU7tQocQsscir
	 VO2V0U5HKZ6wDs+iQ3CSHxI/nKGUMu3+F8SpWVpoTW0m0fW25Q3t0TafPAYVmYVFgX
	 3t1PsyHrUdcFDxLRuxtzfAuuoPtHdVXEElKorzuT3KDmvkX6d1f3SzIuT38JyLKH6k
	 DRL0NGAgVIyT+Pp+AVFN9m573MPwQNvZxO97inHHYfwP0SBsmAxsPsd6eTa4cghr7V
	 xglEa0ZX7Ri4yQ80xFOPTWIBTKm/OtMZX7Fktkgb4IhjavUYrPMPF98iODfOW2g/JM
	 uButdKEWu8O6g==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Igor Pylypiv <ipylypiv@google.com>,
	Xingui Yang <yangxingui@huawei.com>,
	John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 1/2] ata: libata-scsi: refactor ata_scsi_translate()
Date: Sun,  4 Jan 2026 17:22:02 +0900
Message-ID: <20260104082203.1212962-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104082203.1212962-1-dlemoal@kernel.org>
References: <20260104082203.1212962-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out of ata_scsi_translate() the code handling queued command
deferral using the port qc_defer callback and inssuing the queued
command with ata_qc_issue() into the new function ata_scsi_qc_issue(),
and simplify the goto used in ata_scsi_translate().
While at it, also add a lockdep annotation to check that the port lock
is held when ata_scsi_translate() is called.

No functional changes.

Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 81 ++++++++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 31 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 721d3f270c8e..5b6b5f1ff3c7 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1691,6 +1691,42 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 	ata_qc_done(qc);
 }
 
+static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
+{
+	int ret;
+
+	if (!ap->ops->qc_defer)
+		goto issue;
+
+	/* Check if the command needs to be deferred. */
+	ret = ap->ops->qc_defer(qc);
+	switch (ret) {
+	case 0:
+		break;
+	case ATA_DEFER_LINK:
+		ret = SCSI_MLQUEUE_DEVICE_BUSY;
+		break;
+	case ATA_DEFER_PORT:
+		ret = SCSI_MLQUEUE_HOST_BUSY;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		ret = SCSI_MLQUEUE_HOST_BUSY;
+		break;
+	}
+
+	if (ret) {
+		/* Force a requeue of the command to defer its execution. */
+		ata_qc_free(qc);
+		return ret;
+	}
+
+issue:
+	ata_qc_issue(qc);
+
+	return 0;
+}
+
 /**
  *	ata_scsi_translate - Translate then issue SCSI command to ATA device
  *	@dev: ATA device to which the command is addressed
@@ -1714,66 +1750,49 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
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
 {
 	struct ata_port *ap = dev->link->ap;
 	struct ata_queued_cmd *qc;
-	int rc;
 
+	lockdep_assert_held(ap->lock);
+
+	/*
+	 * ata_scsi_qc_new() calls scsi_done(cmd) in case of failure. So we
+	 * have nothing further to do when allocating a qc fails.
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
-
-	if (ap->ops->qc_defer) {
-		if ((rc = ap->ops->qc_defer(qc)))
-			goto defer;
-	}
-
-	/* select device, send command to hardware */
-	ata_qc_issue(qc);
+		goto done;
 
-	return 0;
-
-early_finish:
-	ata_qc_free(qc);
-	scsi_done(cmd);
-	return 0;
+	return ata_scsi_qc_issue(ap, qc);
 
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

