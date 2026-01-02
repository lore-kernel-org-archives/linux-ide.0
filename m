Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9077029408
	for <linux-ide@vger.kernel.org>; Fri,  2 Jan 2026 01:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767318005; cv=none; b=WsWPktMBXIL9UkvGHHMOrhmzBPbauq5CnYpe0k68ko3N+Q4J3XMm1f8KZe59b5FSMRhtR5ve96S/Tin4M+1LqhmSlIRR2+TL/5Bd6MPgsdpHJdLxRm+h9KYoTLxYR3fW9hSCXgvezGlaJPN6idYjyXxjwwuuF3IzLB9PhS95d9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767318005; c=relaxed/simple;
	bh=HOQI/8pA55Lt8JRQw34MKFb6rnuuhDNuN3LTArB53yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXavSs9PIJ0eeYLqX+uo2m0G9zZ+1niTseDnmQRyp44e8vC+mj8TQL6r3POQ9RWILmd96iRNi4BTgH8Xa20NSV0H2aLnGo4ROgZxnIIqg8302y1zwDgEqZ/uX1P78NJ937kyWvwFprhH3kswCUrubscMONppwcqyhMMeb5UrJC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnmIxv5d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnmIxv5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE68C116B1;
	Fri,  2 Jan 2026 01:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767318005;
	bh=HOQI/8pA55Lt8JRQw34MKFb6rnuuhDNuN3LTArB53yQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YnmIxv5daNmY6JtAwFpsAOvBvdJJQsxBFIemMetWeIOk8Bcew8UWXQREW+7UwUeE8
	 jwDZSX2R+iJRCBkh/6/zzy+iQdj+R7wbr/v/GGcerI0wPiU9dbDMvDgs/dMVcxuxf3
	 w44wwi6hz9abohEe77JN4mgVbf+iEWwwlWZqbgH0aMQ0ug2yTxUJZ7gpWGnCJXfZNS
	 zPcXs/00VQMOagJYMmd/w9oo4C0SuRD6UuSL71qna4L+ulV30MCWLxrkEiW9J2OLAP
	 Qg8k+OBSU+/iAtxBPOpyuqAHPDrjj3GI6WA0o50Ip+u7MikIwZIkBh1jkREMmhoiRC
	 KfRgNZg20Y74Q==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Igor Pylypiv <ipylypiv@google.com>,
	Xingui Yang <yangxingui@huawei.com>,
	John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 1/2] ata: libata-scsi: refactor ata_scsi_translate()
Date: Fri,  2 Jan 2026 10:35:32 +0900
Message-ID: <20260102013533.1131768-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260102013533.1131768-1-dlemoal@kernel.org>
References: <20260102013533.1131768-1-dlemoal@kernel.org>
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

Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
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

