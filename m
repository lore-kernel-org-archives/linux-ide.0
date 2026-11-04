Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797624;
	b=Lgm5Y87dshqN2+HHgvATY6wYwPxa0lrM78U2lh6v0s3zagTefOE2v1+1+hIh3fPWwIk8
	 Dktri+U8lhmkhSED0Ht5QOzG+RTJKGoOYbd8ktY2YOmz1N8w9JvfkQQMZp3BeKFfCVISp
	 FX4oY6mAGgXDc4otRbT0x5wx+ryb9h+aoftwZxAiqYtTr40BX4HGtl1Gh/x+AiezTZ3hF
	 6rfNWvIqVZHKadcVH8LGfTM7fAirYdG+4v0/ooTnpxtRzMye8TakIC2Wrh6d0uTu4elav
	 KQ2skGmiw6PSdufjUL9uMcB+VETIzetEm9lXXEATAxWw21yxMl02WCjOoPLtle5NZtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797624;
	h=DMARC-Filter:DKIM-Signature:X-Original-From:Content-Type:From:
	 Subject:Content-Transfer-Encoding:X-Mailer:To:Message-Id:Date:
	 X-Lms-Return-Path:Cc:Mime-Version;
	bh=ssqABgwn+TJRIuR4xu4s2IFSA60D4Z2Ujj7xMIuSIR4=;
	b=UZyDCLAgWDh3bXPo04mJhYnQnyuT+/GDYO7TaM0aXQBXv8w5tfsX0qfWgRSfbxyO2sLx
	 lehaltkXEPzKUmsrVf8zgi9PpYJIPo1INYJ0jyLL+329OdT+daKSZ0E8P9r+mQhZDZXFB
	 x9GNXc1Lc5Ne86X/pNL1vnmYsI34LSviXC7t9G9tNlfQTq/LQF/hEchkVSPy+1mTLMhLX
	 I5QSGw6iSdH0ulVY720cMyaikDI+xE48m+Cia9gNRRak+1xjRBkWnuucuQYKiCtjAU9Au
	 1hv7cfNGYjOZCFjuG1VxGkna7gDYMEmqzBXckEh+uWpqGystJhkhOa+WpYa2QL7J3jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=FtwmsGRs;
	arc=none smtp.remote-ip=209.127.230.113
Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51059606A326
	for <linux-ide@vger.kernel.org>; Wed,  4 Nov 2026 13:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51059606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=FtwmsGRs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1793797617; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ssqABgwn+TJRIuR4xu4s2IFSA60D4Z2Ujj7xMIuSIR4=;
 b=FtwmsGRsW1Ra48CO3pb7K+ebxoakIOsj0RCjtddDDbRQHIBQzeowymyoJijJ0h8pZwRAHL
 EgMVnDrOlKWfML6LtBcWZh7NCFnZrchQDQv+GU6gSxrgziyNLIPmBtepqCDjIFm/OXHfEk
 8nibrCT57DSmeeqCQ5UNuKEMtFu/+Z5fVidh3rLHBeG6gq//kXNKE0UECQmsxg4ACC5F0Z
 081JQYRO58VrRVLGhmM51w72kUbO1gCauivJXZKFX9b5NytXyNX+fBjCtST+HfexJsgyHa
 QNHx4JhqjJhT/CA59bkvhRoDbRYWy4FacXjpUDe4IhK6EZdHi+dt/6xLM3aFNw==
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
Subject: [PATCH v3] ata: libata-scsi: reject data-in commands with a data-out buffer
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
To: <dlemoal@kernel.org>, <cassel@kernel.org>
Message-Id: <20261104130638.37882-1-zhaogongyi@bytedance.com>
Date: Wed,  4 Nov 2026 21:06:38 +0800
X-Lms-Return-Path: <lba+26aeb2def+34f3b6+vger.kernel.org+zhaogongyi@bytedance.com>
Cc: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Zhao Gongyi" <zhaogongyi@bytedance.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0

SG_IO can submit a data-in SCSI command with DMA_TO_DEVICE. The
scatterlist can then contain pages pinned without write access.
ata_scsi_rbuf_fill() writes simulated replies to that scatterlist;
in the reported case, the copy tried to write the shared zero page
and faulted in the kernel.

The same mismatch can affect SG_IO commands translated by libata.
ZBC IN and GET PHYSICAL ELEMENT STATUS completion handlers can modify
the receive buffer even if the drive aborts the command. For ATAPI,
the successful INQUIRY completion also rewrites the buffer in
atapi_fixup_inquiry().

Reject these mismatched commands before the buffer is written or the
command is issued. Report ABORTED COMMAND / DATA IN BUFFER ERROR because
the CDB itself can be valid; the supplied transfer direction is wrong.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://lore.kernel.org/r/20261027090809.94126-1-zhaogongyi@bytedance.com
Suggested-by: Niklas Cassel <cassel@kernel.org>
Suggested-by: Damien Le Moal <dlemoal@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>
---
Changes since v2:
  - Reject misdirected ATAPI INQUIRY before issuing the PACKET command;
    its completion fixup also writes to the scatterlist (Niklas Cassel).
  - Use ABORTED_COMMAND / DATA_IN_BUFFER_ERROR for all rejection paths,
    following Damien Le Moal's suggestion.
  - Clarify that the translated commands are SG_IO submissions and move
    detailed test results below the separator.

Previous v2 validation:
  - The original reproducer panicked in ata_scsi_rbuf_fill() on all four
    unpatched runs and completed without a crash with v2 applied.
  - On x86_64 QEMU with an ata_piix disk, correctly directed INQUIRY and
    READ(10) succeeded; misdirected requests returned CHECK CONDITION.
  - ZBC IN and GET PHYSICAL ELEMENT STATUS were inspected in code; the
    QEMU test disk did not support those commands.

New v3 validation:
  - On upstream master 05441d697f7f, libata-scsi.o and bzImage built.
  - On x86_64 QEMU with an ATAPI DVD-ROM, a standard INQUIRY sent with
    SG_DXFER_TO_DEV and a read-only 4 KiB buffer returned GOOD on the
    unpatched kernel. With v3, it returned CHECK CONDITION with
    ABORTED COMMAND / DATA IN BUFFER ERROR. Neither run produced an Oops.
  - The patch applies to the same libata-scsi.c blob used for v2
    (a61fb0331279).

 drivers/ata/libata-scsi.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a61fb03..78a05cc 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2048,6 +2048,19 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 	if (xlat_func(qc))
 		goto done;
 
+	/*
+	 * A data-out request may contain pages pinned without write access.
+	 * Reject a translated data-in command before issuing it, since its
+	 * completion handler may write to the buffer even if the device fails.
+	 */
+	if (unlikely(cmd->sc_data_direction == DMA_TO_DEVICE &&
+		     ata_is_data(qc->tf.protocol) &&
+		     !(qc->tf.flags & ATA_TFLAG_WRITE))) {
+		ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND,
+				   DATA_IN_BUFFER_ERROR);
+		goto done;
+	}
+
 	return ata_scsi_qc_issue(ap, qc);
 
 done:
@@ -2079,6 +2092,13 @@ static void ata_scsi_rbuf_fill(struct ata_device *dev, struct scsi_cmnd *cmd,
 	unsigned long flags;
 	unsigned int len;
 
+	/* A data-out request may contain pages pinned without write access. */
+	if (cmd->sc_data_direction == DMA_TO_DEVICE) {
+		ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND,
+				   DATA_IN_BUFFER_ERROR);
+		return;
+	}
+
 	spin_lock_irqsave(&ata_scsi_rbuf_lock, flags);
 
 	memset(ata_scsi_rbuf, 0, ATA_SCSI_RBUF_SIZE);
@@ -3173,6 +3193,14 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 
 	qc->complete_fn = atapi_qc_complete;
 
+	/* atapi_fixup_inquiry() writes to the buffer on successful completion. */
+	if (scmd->sc_data_direction == DMA_TO_DEVICE &&
+	    scmd->cmnd[0] == INQUIRY) {
+		ata_scsi_set_sense(dev, scmd, ABORTED_COMMAND,
+				   DATA_IN_BUFFER_ERROR);
+		return 1;
+	}
+
 	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	if (scmd->sc_data_direction == DMA_TO_DEVICE) {
 		qc->tf.flags |= ATA_TFLAG_WRITE;

base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
-- 
2.39.5 (Apple Git-154)
