Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DF71FAA
	for <linux-ide@vger.kernel.org>; Fri,  6 Sep 2024 14:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725632846; cv=none; b=Aj3aQml51yeCvztnQxbrrTlY0Y/Ft0M9OtaWSTysmcFLvYz5yENz0pA7Sr1lvZmasXF+iwqX9/KdcFUapbGrsDrS61SiLsU8dx11aqfeS6/EpfGJJrcc95t119QfZHaVGsTDMICSRY3bxdE3sjT6RLl+IdFcmUDXi3qGFroHF84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725632846; c=relaxed/simple;
	bh=4kWa7Mzgj1dNmTMh1qBg2j3SN2nqquUcLmb4DSif5Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPzcLZ8PJeWdEhZCApKuUObIZBcb1YphKTiGtxRTqFQQBaseBhJNsRP9zpuq95unch+zcxfmwRGBDkCz0AsZp8mi7u8R818orndnjEcS/pe1LZ3CSxBy5iEu3OS1hL4op/gL7mE2bTBKyI2oqF6wsps1JGRAkXUzOlqsuckysKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ila4tHLK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ila4tHLK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3E2C4CEC4;
	Fri,  6 Sep 2024 14:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725632846;
	bh=4kWa7Mzgj1dNmTMh1qBg2j3SN2nqquUcLmb4DSif5Kg=;
	h=From:To:Cc:Subject:Date:From;
	b=ila4tHLKpNyolT7PW/DifD9Q9zLoc1I23WADqSafuaQc4d318bXkGN8iBOwhzd/Ge
	 KntxzmqGBGY6KYhsAU9yioR1oXmiDT27dRPU1iACpZVrEqzSNXS72o6/QfMlT5M5uO
	 9Ykm/QJ4MLFUNe8z/BUYBSJMpVmpddbmIVjvzoT7RiPjEBNkYGsceG/6GTa9pPM4Ou
	 CBIM5UYy9DM1Bc09SVLAYxl5sg4lbmwryX440ekn6RZArLTy6VTnOLT2R29h7rGU4m
	 lgfPDvcoNwWmdj1fnxUQrP+W4li0hYITBTQ3M+WsRK5J/kaRjqTbCKLlOVeaG+EJ/W
	 QrneA7l1F4jfg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Igor Pylypiv <ipylypiv@google.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata: Clear DID_TIME_OUT at the start of EH instead of at the end
Date: Fri,  6 Sep 2024 16:27:21 +0200
Message-ID: <20240906142720.1977225-2-cassel@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2878; i=cassel@kernel.org; h=from:subject; bh=4kWa7Mzgj1dNmTMh1qBg2j3SN2nqquUcLmb4DSif5Kg=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJuC3rsD9OuFBAoPjY3Sdn6yRLbfm7P/dd6dlUbCqr8D wlVF+vtKGVhEONikBVTZPH94bK/uNt9ynHFOzYwc1iZQIYwcHEKwESUvBkZZmmKnL6us3wF9xQH vXTDJbtV5+xiWyun+LFnib9MVbqzMMM/k90OzfbxWlkhyz9U697sUGZyMH7+QyTmJ59p/r2i17I cAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

When ata_qc_complete() schedules a command for EH using
ata_qc_schedule_eh(), blk_abort_request() will be called, which leads to
req->q->mq_ops->timeout() / scsi_timeout() being called.

scsi_timeout(), if the LLDD has no abort handler (libata has no abort
handler), will set host byte to DID_TIME_OUT, and then call
scsi_eh_scmd_add() to add the command to EH.

Thus, when commands first enter libata's EH strategy_handler, all the
commands that have been added to EH will have DID_TIME_OUT set.

libata has its own flag (AC_ERR_TIMEOUT), that it sets for commands that
have not received a completion at the time of entering EH.

Thus, we don't really care about DID_TIME_OUT at all, and currently clear
the host byte at the end of EH, in ata_scsi_qc_complete(), before
scsi_eh_finish_cmd() is called.

ata_scsi_qc_complete() will be called both for commands that are completed
normally (without going via EH), and for commands that went via EH.

It seems more appropriate to clear DID_TIME_OUT at the start of EH instead
of at the end of EH. That way, someone dumping the host byte at the middle
of EH will not see DID_TIME_OUT as being set. No functional change
intended.

This has the additional advantage that we will not needlessly clear the
host byte for commands that did not go via EH.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-eh.c   | 9 +++++++++
 drivers/ata/libata-scsi.c | 3 ---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 7de97ee8e78b..450e9bd96c97 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -630,6 +630,15 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
 	list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
 		struct ata_queued_cmd *qc;
 
+		/*
+		 * If the scmd was added to EH, via ata_qc_schedule_eh() ->
+		 * scsi_timeout() -> scsi_eh_scmd_add(), scsi_timeout() will
+		 * have set DID_TIME_OUT (since libata does not have an abort
+		 * handler). Thus to clear the DID_TIME_OUT, we clear the host
+		 * byte (but keep the SCSI ML and status byte).
+		 */
+		scmd->result &= 0x0000ffff;
+
 		ata_qc_for_each_raw(ap, qc, i) {
 			if (qc->flags & ATA_QCFLAG_ACTIVE &&
 			    qc->scsicmd == scmd)
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 3a442f564b0d..6a90062c8b55 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1680,9 +1680,6 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 			set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);
 	} else if (is_error && !have_sense) {
 		ata_gen_ata_sense(qc);
-	} else {
-		/* Keep the SCSI ML and status byte, clear host byte. */
-		cmd->result &= 0x0000ffff;
 	}
 
 	ata_qc_done(qc);
-- 
2.46.0

