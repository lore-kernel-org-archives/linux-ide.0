Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2FD19D093
	for <linux-ide@vger.kernel.org>; Fri, 20 Feb 2026 22:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771625997; cv=none; b=SFkG1in9FiWBqC0sQ6sDCQHKDNy2HnMhJ+X+Qd1MJpw0pHEZeQimVbHEx33VvG7JJ23tVEVkxnd7wadzaNec3zw3/NZOAQKkPyOyB7blFgObqYkam4f4YNUNsWMJr5XpUSQncERQP1jKTsv5zZ5w8xjBUEXT40iFf22Vp6U5Z64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771625997; c=relaxed/simple;
	bh=3ZdorDKnvbuuqq3GgNbmAFe5hBNinUpK9VNPGJUP2QE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lp29iQIZ4CdiF0F4dAKAQfLp7nbOj6kc/xKVOyKZrwGJjnV2eQyz3vukfsLy2yiGtHu7Ao200yKxFVWMa+tem2Y0hfYggR64sXkrilpfRGh1xYAohlhxMbQqtX8sqHz8iOW+s5z+flzlEs5mxpKCN7ZuTx2URB8HRClPu8g5m9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzyHBV3l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzyHBV3l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C168C116D0;
	Fri, 20 Feb 2026 22:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771625997;
	bh=3ZdorDKnvbuuqq3GgNbmAFe5hBNinUpK9VNPGJUP2QE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=uzyHBV3ljTmOZk65cF03QF1lWQu73HfIYgRNxtv1MygjiQ/NodEDEZ+N3W/kxJhsC
	 nvwFDHV2N2JP5YskOB3UajDBUuyVDP/Xgz+9XY+broQguWN0khwGZ56Z8Rt3hBM86m
	 pvApoCXCSO+tKLmWxny7O4gVwbZBS9BnAfwW+KlFXgzOTUWOdPO4BrQzH5nMh+XrVO
	 0fuBX0JKvcOslKOBKILa7YhPWKOIhed3zzttr29XPBSSSb/wOzwSify/ib76P/dq85
	 wwjvWipy5+SyY0TqAealXw1vIHIlRXO4wLNQZG1B03xYESndsfENS9x1h2Ny3mwp8S
	 WNOhHPkIrXfhA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 1/2] ata: libata-eh: correctly handle deferred qc timeouts
Date: Sat, 21 Feb 2026 07:14:38 +0900
Message-ID: <20260220221439.533771-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220221439.533771-1-dlemoal@kernel.org>
References: <20260220221439.533771-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A deferred qc may timeout while waiting for the device queue to drain
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

Fix this by checking if the qc of a timed out SCSI command is a deferred
one, and in such case, clear the port deferred_qc field and finish the
SCSI command with DID_TIME_OUT.

Reported-by: syzbot+1f77b8ca15336fff21ff@syzkaller.appspotmail.com
Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-eh.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 72a22b6c9682..b373cceb95d2 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -640,12 +640,28 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
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
+			 * This is a deferred command that timed out while
+			 * waiting for the command queue to drain. Since the qc
+			 * is not active yet (deferred_qc is still set, so the
+			 * deferred qc work has not issued the command yet),
+			 * simply signal the timeout by finishing the SCSI
+			 * command and clear the deferred qc to prevent the
+			 * deferred qc work from issuing this qc.
+			 */
+			WARN_ON_ONCE(qc->flags & ATA_QCFLAG_ACTIVE);
+			ap->deferred_qc = NULL;
+			set_host_byte(scmd, DID_TIME_OUT);
+			scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
+		} else if (i < ATA_MAX_QUEUE) {
 			/* the scmd has an associated qc */
 			if (!(qc->flags & ATA_QCFLAG_EH)) {
 				/* which hasn't failed yet, timeout */
-- 
2.53.0

