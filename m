Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5941523A99E
	for <linux-ide@vger.kernel.org>; Fri, 20 Feb 2026 05:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771563971; cv=none; b=lyEoK0OieeVbhvEWT8VmhApB/aNSP5xCnmTIRs7cdKvqehyvvUcEWiIDpFSzKVBaH8SsHp9ViAnXBpIYNSa6KUhMy3MZx7GDcSitNRiFD9Jmulv/FkJkw4tFDhOkNffK+t0VfPpeOjOHGTf7NDFCyzQYZtnpaxC4ckAvUOGmKJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771563971; c=relaxed/simple;
	bh=LMRZFGnNSDuFDINxkH2ISoamfaA/GUESZnkgBs+VT5I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbCUvNKneMtuHbTOwhriN/NA0UYtWO5cR7oz64JuuBBsQikytjf2WPeujqhI2joh49oM41VnLZw8NVew8HmwFbwmKDe6lT97M4gr6MxkYUFxxpXqRAnmGqIzxXEAZ2F/E2e+BUOG4rBP01B7CP5c6is+K5ZRJQaazix51BBfi6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d36i28TH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d36i28TH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6632C19425;
	Fri, 20 Feb 2026 05:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771563971;
	bh=LMRZFGnNSDuFDINxkH2ISoamfaA/GUESZnkgBs+VT5I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=d36i28THANlNMCC5sQ/gGoxS9VoAHv2X7wemw0e78y2aNj6Cn4syP0OAeeoR4wsuz
	 UcZPTWEplIKCSJ+ItTANZ4DIOXxN1OeOFb24brpCQ755gUiiFIVe39ntJdOIUdW7Xg
	 njezLyKj3qXqECe7y4gIFPkWC6RlXPvyQqAYCXgN6yWeY9URRzrb9w2cj3KMEFC6ZJ
	 HM2/RvA6xbZ68TpKW2RGFh0XEjJylRuUgNG7TSERX8FxN3keIzO8U3XGtaf2+s4NWU
	 aNPUjzYBMC8/Q4c/QhvNmS90BEKX8NsjBW7qGN/4emflgQqd8BwwU54qolIHJWDxDx
	 Ec89DBB+yfvSA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 1/2] ata: libata-eh: correctly handle deferred qc timeouts
Date: Fri, 20 Feb 2026 14:00:52 +0900
Message-ID: <20260220050053.390135-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220050053.390135-1-dlemoal@kernel.org>
References: <20260220050053.390135-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A differed qc may timeout while waiting for the device queue to drain
to be submitted. In such case, since the qc is not active,
ata_scsi_cmd_error_handler() ends up calling scsi_eh_finish_cmd(),
which frees the qc. But as the port deferred_qc field still references
this finished/freed qc, the deferred qc work may eventually attempt to
call ata_qc_issue() against this invalid qc, leading to errors such as
reported by UBSAN (syzbot run):

UBSAN: shift-out-of-bounds in drivers/ata/libata-core.c:5166:24
shift exponent 4210818301 is too large for 64-bit type 'long long unsigned int'
...
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x279/0x2a0 lib/ubsan.c:494
 ata_qc_issue.cold+0x38/0x9f drivers/ata/libata-core.c:5166
 ata_scsi_deferred_qc_work+0x154/0x1f0 drivers/ata/libata-scsi.c:1679
 process_one_work+0x9d7/0x1920 kernel/workqueue.c:3275
 process_scheduled_works kernel/workqueue.c:3358 [inline]
 worker_thread+0x5da/0xe40 kernel/workqueue.c:3439
 kthread+0x370/0x450 kernel/kthread.c:467
 ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Fix this by checking if the qc of a timed out command is a deferred one,
and in such case, clear the port deferred_qc field and finish the scsi
command with DID_TIME_OUT.

Reported-by: syzbot+1f77b8ca15336fff21ff@syzkaller.appspotmail.com
Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-eh.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 72a22b6c9682..f86085f9b476 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -640,12 +640,26 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
 		set_host_byte(scmd, DID_OK);
 
 		ata_qc_for_each_raw(ap, qc, i) {
-			if (qc->flags & ATA_QCFLAG_ACTIVE &&
-			    qc->scsicmd == scmd)
+			if (qc->scsicmd != scmd)
+				continue;
+			if ((qc->flags & ATA_QCFLAG_ACTIVE) ||
+			    qc == ap->deferred_qc)
 				break;
 		}
 
-		if (i < ATA_MAX_QUEUE) {
+		if (qc == ap->deferred_qc) {
+			/*
+			 * This is a deferred command that timedout while
+			 * waiting for the command queue to drain. Since the qc
+			 * is not active yet, simply signal the timeout by
+			 * finishing the SCSI command and clear the deferred qc
+			 * to prevent the deferred qc work from issuing this
+			 * qc.
+			 */
+			ap->deferred_qc = NULL;
+			set_host_byte(scmd, DID_TIME_OUT);
+			scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
+		} else if (i < ATA_MAX_QUEUE) {
 			/* the scmd has an associated qc */
 			if (!(qc->flags & ATA_QCFLAG_EH)) {
 				/* which hasn't failed yet, timeout */
-- 
2.53.0

