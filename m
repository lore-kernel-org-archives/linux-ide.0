Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A3C285CB3
	for <linux-ide@vger.kernel.org>; Thu, 19 Feb 2026 06:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771482510; cv=none; b=uNlnAAopCh/QqtGYzbBiIOH+MOdJ3q+1v3phzXJVdQhRZrat0oNYccK1aGUlOT5i7KDo8sWN5N/JXQIELteGRGy5fOH3FEJDcPB4L/LG21xkOzTHgKModyRY9uNx150hQ6ghYcafkv95tKX+lvU0fSmy5awKxfE8MJi4qHkwjxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771482510; c=relaxed/simple;
	bh=wZLlL1KwtSO1kMsJvBEU+MBFbevqcaCRJwDuymA53Tg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVsS2B3fahWQQP4BaMfyoRziAyJfgbccJBZBxKEStPAi5mElfn/gxkzua8UYrRyotmXIYjoG0ft4JLPkMOlTDvCvf1Vm3alU8XPMiTzvszP11WB9iRXV91QvKZaljpYUAz8LwTXDkWRF8xNikMa80xTYvyjv7TqWUr9CwDbbehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8+n2VA8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8+n2VA8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91D7C19421;
	Thu, 19 Feb 2026 06:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771482510;
	bh=wZLlL1KwtSO1kMsJvBEU+MBFbevqcaCRJwDuymA53Tg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=C8+n2VA8INZ/65qDMTZMPxhcCc7BIMQ3EB3ktU6kP3NCmWkZdvh6MoRLmYDcQisM3
	 Na1c4vnhz+XZOjWRcFyDZKZXu43zAlxHFKfcWIsMyRgVKL8f19a99hqGHS1DVc+cKW
	 d7wOk9IUk6X5lklilvu6bAkvwb+Vr6IRc75g1Z4YRbCvM4jz9KTT1GQuSZD9jAXRnu
	 0wzzKm8Q8m94DJRoSq94JowUE5rJV4SQwBVBPWbtAXnf2V7A9pw9xc2xBaIivIRaMD
	 K4YdZKg8QLuy/1weEvUk52RcNDgAiEBNXMQqvfN3LAyWagd0Z2Gm7BdxUGYmuuFQuZ
	 hmi8TxXxIiVhA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 5/5] ata: libata-scsi: rename and improve ata_qc_done()
Date: Thu, 19 Feb 2026 15:23:12 +0900
Message-ID: <20260219062312.1030867-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219062312.1030867-1-dlemoal@kernel.org>
References: <20260219062312.1030867-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename ata_qc_done() to ata_scsi_qc_done() and allow to pass a scsi
command result value to set for the completed command to simplify the
caller sites.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index ad628b398fc3..4225c6d7ff35 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1649,12 +1649,16 @@ static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc)
 	return 1;
 }
 
-static void ata_qc_done(struct ata_queued_cmd *qc)
+static void ata_scsi_qc_done(struct ata_queued_cmd *qc, bool set_result,
+			     u32 scmd_result)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	void (*done)(struct scsi_cmnd *) = qc->scsidone;
 
 	ata_qc_free(qc);
+
+	if (set_result)
+		cmd->result = scmd_result;
 	done(cmd);
 }
 
@@ -1693,12 +1697,10 @@ void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
 	 * do not try to be smart about what to do with this deferred command
 	 * and simply retry it by completing it with DID_SOFT_ERROR.
 	 */
-	if (!qc)
-		return;
-
-	ap->deferred_qc = NULL;
-	qc->scsicmd->result = (DID_SOFT_ERROR << 16);
-	ata_qc_done(qc);
+	if (qc) {
+		ap->deferred_qc = NULL;
+		ata_scsi_qc_done(qc, true, DID_SOFT_ERROR << 16);
+	}
 }
 
 static void ata_scsi_schedule_deferred_qc(struct ata_port *ap)
@@ -1754,7 +1756,7 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 		ata_scsi_set_sense_information(qc);
 	}
 
-	ata_qc_done(qc);
+	ata_scsi_qc_done(qc, false, 0);
 
 	ata_scsi_schedule_deferred_qc(ap);
 }
@@ -2913,17 +2915,15 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
 		if (qc->cdb[0] == ALLOW_MEDIUM_REMOVAL && qc->dev->sdev)
 			qc->dev->sdev->locked = 0;
 
-		qc->scsicmd->result = SAM_STAT_CHECK_CONDITION;
-		ata_qc_done(qc);
+		ata_scsi_qc_done(qc, true, SAM_STAT_CHECK_CONDITION);
 		return;
 	}
 
 	/* successful completion path */
 	if (cmd->cmnd[0] == INQUIRY && (cmd->cmnd[1] & 0x03) == 0)
 		atapi_fixup_inquiry(cmd);
-	cmd->result = SAM_STAT_GOOD;
 
-	ata_qc_done(qc);
+	ata_scsi_qc_done(qc, true, SAM_STAT_GOOD);
 }
 /**
  *	atapi_xlat - Initialize PACKET taskfile
-- 
2.53.0

