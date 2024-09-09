Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E285176246
	for <linux-ide@vger.kernel.org>; Mon,  9 Sep 2024 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871690; cv=none; b=iv7WuFBALDajC69uVavS/1uoWbjG08gvlZUMN2Mt1zKbgpde/UgoUOOPtAJWMaBNyq1Pgt74okG0omhme6y/Dzc1QainxCzTzrKItjKJUyXsqIl9SIpKCRc9qUFATK6cyjOzQAhW+yTUhutfgA7wVsNFD8ieSLqAe++cbtGDPXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871690; c=relaxed/simple;
	bh=0Z/5NsxXgLfkTLHW7dGZI0Lcn3mlC2+R0gov0+HJM6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=efSq27bm65i68N6fbkyRmhQ01GRXKDMWcBmu3NjFs8a7TQCK59XhFeQvvxrDmXDrJZ2uDWyVxMBUqHdw0qV6g77AieACa5FE/Gw3yw+Kb4/rdoqWxJPNAZk4Sj6aIiZfADUqpK+LC8AZW15qZNaG6De1plwQM6q8xAJdbi2ruXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djyDoLPh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djyDoLPh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47699C4CEC5;
	Mon,  9 Sep 2024 08:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725871689;
	bh=0Z/5NsxXgLfkTLHW7dGZI0Lcn3mlC2+R0gov0+HJM6s=;
	h=From:To:Cc:Subject:Date:From;
	b=djyDoLPh7XOmiDbQY6ehDjyvvtadUDNufv870oJNrCaZkh2KpdTExlPYeTMhP0KNR
	 JcTUIxJXKoHCa7rXDJquNdcGzx+ybfs4kIlp4TFRHd6LDRUh8srnseAE+MDDStkkDE
	 pujbom0HGcfg7WxYGYrJ2KC0JJsNe6S91hVD/9xps2b7ue7YpPsINYDKq5f0EdvuSk
	 g54mNIXJ/SWbYXt17UXPRzt3EUoE5YnCKfjAiAMJRZoi1oEn/NzdDrk0rsXaNMEzKu
	 s0II4gAUlJgBwdgS7GFrWBcinTcFgVvh4jsn09t45wTknIQu3f3h6LknAqvuwajGp5
	 C4ONrNJZLwTaw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Cc: Igor Pylypiv <ipylypiv@google.com>,
	Niklas Cassel <niklas.cassel@wdc.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH v2] ata: libata: Clear DID_TIME_OUT for ATA PT commands with sense data
Date: Mon,  9 Sep 2024 10:47:46 +0200
Message-ID: <20240909084745.2029818-2-cassel@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3945; i=cassel@kernel.org; h=from:subject; bh=0Z/5NsxXgLfkTLHW7dGZI0Lcn3mlC2+R0gov0+HJM6s=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLubTN8JFopd//4lumVR6fWnFPjib0xxf1pvObS6uCbf fcb5lwW6ShlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEhBsYGdpKK2sOfk+Yv3jD p8I1x9ZzOt7K9DJ/o7Y8+8HMqjeN11sYGV5Mt1HwtW08fvmEqJLLDLF3TYppazhjUv63yhqVqTz j5gIA
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

Thus, libata doesn't really care about DID_TIME_OUT at all, and currently
clears the host byte at the end of EH, in ata_scsi_qc_complete(), before
scsi_eh_finish_cmd() is called.

However, this clearing in ata_scsi_qc_complete() is currently only done
for commands that are not ATA passthrough commands.

Since the host byte is visible in the completion that we return to user
space for ATA passthrough commands, for ATA passthrough commands that got
completed via EH (commands with sense data), the user will incorrectly see:
ATA pass-through(16): transport error: Host_status=0x03 [DID_TIME_OUT]

Fix this by moving the clearing of the host byte (which is currently only
done for commands that are not ATA passthrough commands) from
ata_scsi_qc_complete() to the start of EH (regardless if the command is
ATA passthrough or not).

This will make sure that we:
-Correctly clear DID_TIME_OUT for both ATA passthrough commands and
 commands that are not ATA passthrough commands.
-Do not needlessly clear the host byte for commands that did not go via EH.
 ata_scsi_qc_complete() is called both for commands that are completed
 normally (without going via EH), and for commands that went via EH,
 however, only commands that went via EH will have DID_TIME_OUT set.

Fixes: 24aeebbf8ea9 ("scsi: ata: libata: Change ata_eh_request_sense() to not set CHECK_CONDITION")
Reported-by: Igor Pylypiv <ipylypiv@google.com>
Closes: https://lore.kernel.org/linux-ide/ZttIN8He8TOZ7Lct@google.com/
Tested-by: Igor Pylypiv <ipylypiv@google.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since v1:
-Picked up tags from Igor.
-Added Fixes tag.
-Improved the commit message to clearly state that this is currently a
 real bug for ATA PT commands with sense data.

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

