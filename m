Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04504533D6
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 02:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782957711; cv=none; b=hMGasvRKUXbsLuoM1TxDvHmMxZoVYdYUBpyIqX5GTkYypldeeZYOopJl1fEU2HLEuzIW6Epmp0eHJutVzy8z2U+pIxT+vgBLL5C1ClNxw1Mb7b6IFW89Lydl0ekiqxk/upD4Yxdyy4M6D1+N78CgggiuMtJmfm/QjGvJQBn4ltE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782957711; c=relaxed/simple;
	bh=XIX/YsWDCMnRj4bzIhpzkW89u+1wfuk6w4/tj6ouRd4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uAd6uWQ67srYUTgTMeiHozsuaJEw0tMHS+kEC1gET/Ka0xdC17OV9BbWJYJnZ3ki48wxaGnvKDgsSoiAjq75aMH0GOzbEy5Jh7VPD1ZBVTMBkilE+4YugET8fk+D1NkXDVgNRkyTKeKAmJ+Zq5YSm+R454hpNT2sdjnk5H7YSwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rkaruna.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZIexjWxh; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rkaruna.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZIexjWxh"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-37e1f96b248so1826306a91.3
        for <linux-ide@vger.kernel.org>; Wed, 01 Jul 2026 19:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782957709; x=1783562509; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8hbn6HTosyIRjRZYqgng7RQAWObtXXPI1YpnWEm5t0Y=;
        b=ZIexjWxhWfDKdlYTnDQmOuUioULVUNxkE5Qz5W1jfzzGHUEVK2hQPtU8BX0pdRN50y
         MVsxZsRCNa9pgr1J0rAd3x/wenuoHkrzP0eBYzafxYF+6TxJ3Gn4EOGaZFHAelS7w3e3
         PCA8mQjL9T9/TQprwfCAFOYjmL5tjn+LePtNYWLDFFwBZtiiAw2H4Wl34xzBaLdrOXk9
         io7Y6eOnhTrUApoxzc5qI4XdFpgwGHT7xOVzIbXHShx2wcfyBRwIPldGg0Iq9QmofQC4
         RlpeMX2lNlSv9ecX3Mx789EgLw1zKug1cw3C0+U45DPkr8JAY6G/uQJNnG1D7XAwDCYR
         XQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782957709; x=1783562509;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8hbn6HTosyIRjRZYqgng7RQAWObtXXPI1YpnWEm5t0Y=;
        b=cuamLeVwmN7NL/5+PSsvHX/wERvI0JG59/IS1mQcpkCkAJe8Kfxo5yL7HjCJjBKuXl
         5zoRcFjMy+jSjGEUzhT6VWMtc8k9LHhVqw/z4s5kLYsOWbvgdTPV02W7OGcb2ToqDghD
         AlNa0iesoKKWyL0/mplKX/7TQkZrtgwZkV5CkB0JPtz79qYL2QieLNYBb7BJ2KacDvYi
         buuyOVsVIhUQ6ofpMJxES0F0oi5+QmxXLH8aWIGTa9qSxfTeh2POhNuyHmEppa/va3kp
         +71KK6akg8ej3tlg1Ls7r+N3I07Bc6Orqaml68ckvX7oXJ5j4N0IkNbGvmHu3/485CE5
         kAIg==
X-Gm-Message-State: AOJu0YwML3pKwTJNp7PSoILHxMCyq+bN1Aq9OFsoiBkwmUabgiS1F/dk
	MFgajsnamjMJ2L08rjGua/l5CTHuS5acTpM1LPc3zvznGHMvGAxCFU0rPCoUqZm73CcZTEWPgEx
	NJykXNBRk6Q==
X-Received: from dycmx4.prod.google.com ([2002:a05:693c:2884:b0:304:cffc:fdf7])
 (user=rkaruna job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f87:b0:37f:ed70:cc30
 with SMTP id 98e67ed59e1d1-380aa2040c1mr3951441a91.26.1782957709024; Wed, 01
 Jul 2026 19:01:49 -0700 (PDT)
Date: Thu,  2 Jul 2026 02:01:42 +0000
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260702020142.3399851-1-rkaruna@google.com>
Subject: [PATCH v2] ata: libata-scsi: limit simulated SCSI command copy to
 response length
From: Karuna Ramkumar <rkaruna@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Karuna Ramkumar <rkaruna@google.com>
Content-Type: text/plain; charset="UTF-8"

The function ata_scsi_rbuf_fill() is used to copy the response of
emulated SCSI commands from ata_scsi_rbuf to the SCSI command's
scatterlist.

Currently, sg_copy_from_buffer() is called with the size argument
set to ATA_SCSI_RBUF_SIZE (2048 bytes). Since ata_scsi_rbuf is
zeroed out before the simulation actor is invoked, copying the
full buffer size causes the remainder of the SCSI command's
transfer buffer (beyond the actual response length 'len') to be
overwritten with zeroes. This clobbers any pre-existing sentinel
values or data in the caller's buffer tail, even though the
correct residual count is reported via scsi_set_resid().

Fix this by passing the actual response length 'len' as the copy
size to sg_copy_from_buffer(), ensuring that the tail of the
caller's buffer remains untouched. Also, add a defensive check
to ensure that the actor does not return a length exceeding the
static buffer capacity. If this occurs, trigger a WARN_ON(),
fail the command with an aborted command error, and return
immediately without copying any data.

The fix was tested by invoking an SCSI SG_IO INQUIRY on
an ATA disk on vanilla build, and build with the fix. Confirmed
that the input buffer's tail end remains unmodified with the fix.

Fixes: 5251ae224d8d ("ata: libata-scsi: Return residual for emulated SCSI commands")
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Karuna Ramkumar <rkaruna@google.com>
---
Changes in v2:
   - Instead of capping 'len' and continuing when 'len > ATA_SCSI_RBUF_SIZE',
     fail the SCSI command with an ABORTED_COMMAND error and return immediately,
     as suggested by Damien Le Moal.
   - Link to v1: https://lore.kernel.org/all/20260629175024.2187500-1-rkaruna@google.com/

 drivers/ata/libata-scsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 72744a07c140..052a71540137 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2018,8 +2018,13 @@ static void ata_scsi_rbuf_fill(struct ata_device *dev, struct scsi_cmnd *cmd,
 	memset(ata_scsi_rbuf, 0, ATA_SCSI_RBUF_SIZE);
 	len = actor(dev, cmd, ata_scsi_rbuf);
 	if (len) {
+		if (WARN_ON(len > ATA_SCSI_RBUF_SIZE)) {
+			ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0, 0);
+			spin_unlock_irqrestore(&ata_scsi_rbuf_lock, flags);
+			return;
+		}
 		sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd),
-				    ata_scsi_rbuf, ATA_SCSI_RBUF_SIZE);
+				    ata_scsi_rbuf, len);
 		cmd->result = SAM_STAT_GOOD;
 		if (scsi_bufflen(cmd) > len)
 			scsi_set_resid(cmd, scsi_bufflen(cmd) - len);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

