Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B354E346784;
	Mon, 22 Jun 2026 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782153492; cv=none; b=QcjLmMpque6y+abZIyfoSpa5IrBUSy+5fYPOPCEzcD/sb6BAilCWEehitXSShSowcTRCvVY8gwf0GzGyG4r+sd9blrrqrIeMJhyRYdQC+/BihsLSN5aAV3yAgLuFsc5Pa3/w2u6UPNzkNQXAplcG6KBzLsl7TiAGhXMf3s8Y/Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782153492; c=relaxed/simple;
	bh=QV9VN3bRWQPJxZSM5bePiBAB4fbflpWvMBkV8Or64B8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=N/VqlhnD9BF/U8GLx6XXhz24luQFQIKGrLX8Zptw512fdFd178LIonIne3EEXb0aOlrTc0hBsnlUCVJkKFx7KCPmK+r3218/gewxQ0nK30Nt9a72vs4w4YIxNB3Uoz0pf77bKQwOawS7SDkgHnaZzTysA/V/lw0TmbtGkKYsMtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D64NbnX1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D64NbnX1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D21DC2BCB4;
	Mon, 22 Jun 2026 18:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782153492;
	bh=QV9VN3bRWQPJxZSM5bePiBAB4fbflpWvMBkV8Or64B8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=D64NbnX1If5PlVCw2HccQijUwwxWX4jpACcbFHSxRfEVgYXupAOta653fsGXG0w7K
	 2US/Vx4IJqOl4StUkges89tHLQpAxx4ZnZ+g8e7/kiurJlHs2VoOkThe/Ee8CWZKCV
	 c9p7KlrQ0kVXc1NVs3yLSph/EdkbkEZbIeIZXz1VfW04j/FoVr7crQWejfV/moCHo/
	 7QDZv0oA7I7iJWijT8l8WrZsd8gETLbi/oeHCXmVidsS8dMCVJqRpFWqOeRRcO1AYp
	 z0l1UfpyiI5ZqIJtt2rFMvI2dQRm/mwTvZVPhtTAChKwZxddfEehAa7ESCldrfOvRE
	 dZSlXcX+35GZA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC94CDB466;
	Mon, 22 Jun 2026 18:38:12 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Mon, 22 Jun 2026 13:38:12 -0500
Subject: [PATCH v2] ata: libata-core: Reject an invalid concurrent
 positioning ranges count
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-b4-disp-5734c6f2-v2-1-53083c2df3c6@proton.me>
X-B4-Tracking: v=1; b=H4sIABOBOWoC/x3MMQqAMAxA0atIZgM1alu8ijhoTTSLSgsiSO9uc
 XzD/y8kjsoJhuqFyLcmPY8CqisI+3xsjLoWAxmyxhLh0uGq6cLetV2wQujFh9Y48Ys0ULIrsuj
 zL8cp5w8SWH5TYgAAAA==
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782153491; l=3597;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=s7iWl1A1AVZplle7BVcwv17DnZEN0SJ+S8DOR5LSvyE=;
 b=Z1+ABP+JLnIwd4pXZznefy3o/ZLLvQYGxWqSz0a3j1XWTTHIYdCGOGkYz63EgbznvSov33Mgv
 DdSo5rd3YTYDVtnmb1M9Hpc50NJP1rn9CTwNHr8Qez3HtGTZ7VkfosU
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

ata_dev_config_cpr() takes the number of range descriptors from buf[0]
of the concurrent positioning ranges log (up to 255), which the device
reports independently of the log size in the GPL directory. The count is
then walked at a fixed 32-byte stride in two places with no bound: the
log read here, and the INQUIRY VPD page B9h emitter, which writes one
descriptor per range into the fixed 2048-byte ata_scsi_rbuf. A device
reporting a count larger than its own log overflows the read buffer (up
to 7704 bytes past a 512-byte slab), and a count above 62 overflows the
response buffer on the emit side.

Bound the count once, on probe, against both the log the device returned
and the 62-descriptor capacity of the VPD B9h buffer; warn and ignore the
log when it does not fit. Capping the stored count keeps the emitter in
bounds with no separate change there.

Suggested-by: Damien Le Moal <dlemoal@kernel.org>
Fixes: fe22e1c2f705 ("libata: support concurrent positioning ranges log")
Fixes: c745dfc541e7 ("libata: fix reading concurrent positioning ranges log")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v2: Per Damien Le Moal's review, reject an inconsistent count instead of
    clamping it, and fold the emitter bound into this single probe-time
    check: a count above 62 (the VPD B9h 2048-byte buffer capacity) or one
    that does not fit the device's own log is rejected with a warning. That
    makes the separate emitter patch unnecessary, so v1 2/2 is dropped.
    v1 1/2: https://lore.kernel.org/all/20260619-b4-disp-6200c44e-v1-1-4624a4707d9e@proton.me/
    v1 2/2: https://lore.kernel.org/all/20260619-b4-disp-6200c44e-v1-2-4624a4707d9e@proton.me/

A/B with a userspace AddressSanitizer mirror of both sinks (-m64 and -m32;
the unbounded value is device log content, not bus state, so no hardware is
needed):

  count  buf_len  with this patch
  2      128      accepted (conforming drive)
  62     2048     accepted (62 actuators, the documented maximum)
  63     8704     rejected (exceeds the 62-descriptor VPD B9h buffer)
  255    8704     rejected (self-consistent log, but the emit would overflow)
  62     512      rejected (count does not fit the device's own log)
  255    512      rejected

Without the patch the 512-byte rows fault on the log read and the >62 rows
fault on the VPD B9h emit; with it every count the emitter can still receive
fits the 2048-byte buffer. Reproducer available on request.
---
 drivers/ata/libata-core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3d0027ec33c2..017a16be158b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2832,6 +2832,18 @@ static void ata_dev_config_cpr(struct ata_device *dev)
 	if (!nr_cpr)
 		goto out;
 
+	/*
+	 * The count is reported independently of the log size and is also
+	 * emitted into the fixed 2048-byte VPD B9h buffer, which holds at most
+	 * (2048 - 64) / 32 = 62 descriptors. Reject a count that exceeds that
+	 * or does not fit the log the device returned.
+	 */
+	if (nr_cpr > 62 || buf_len < 64 + (size_t)nr_cpr * 32) {
+		ata_dev_warn(dev,
+			     "Invalid number of concurrent positioning ranges\n");
+		goto out;
+	}
+
 	cpr_log = kzalloc_flex(*cpr_log, cpr, nr_cpr);
 	if (!cpr_log)
 		goto out;

---
base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
change-id: 20260622-b4-disp-5734c6f2-8f8c307f8bf1

Best regards,
-- 
bryamzxz <hexlabsecurity@proton.me>


