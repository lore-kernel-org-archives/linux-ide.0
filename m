Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B9C274652;
	Tue, 23 Jun 2026 03:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782185026; cv=none; b=Icf7pgJrCUItS58W9xvdh5KtHge3hapixHWfo+6psa7eH8cwwOGL3VmJ/uVWUD/eTVVhfFfcbhl8wvFYgYidpgmuHwmZcMOZ6SJK9lFJv2Gc2FXmX9iIUMORJnu6qNiKE7E/H+sSV0RHyyda4kUJYcwWh1IixiK9RTfO7Y2UfWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782185026; c=relaxed/simple;
	bh=DdJsW96ieHGwpB2NrXutTG0uuuA1LUKcqgh7HjsxweU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f6pcbSo9AMJEvDhM7nT63PSXsrNMGbtFbPIT7d8+TzUZ7Vx13sGkLlFF6IasBXnvAcjM6FozwmcHjDIn7jL30SPFtqlGKynhke8mSPRqAS1oDXXVS4JL82qh4rygtZ38Wcwr1ZWg/dm6EPz31ejdVVCpDhCNLTRghFXtM/Pga/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+PF4ULy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+PF4ULy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C542EC2BCB4;
	Tue, 23 Jun 2026 03:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782185025;
	bh=DdJsW96ieHGwpB2NrXutTG0uuuA1LUKcqgh7HjsxweU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=a+PF4ULy9RyqZMcA5wKz5A4CJBMIYXWYc3oOBehaaO10Y/LQIPT3WxZEdfbRrM528
	 qVEzsm+YTne+qiE84zg2QT91HNbqLuI4KP31dcMwxVZXKYiM5TYciiXxwR2jgvBgZe
	 F4+hIDsNE667GpDWqCcJ+L/k6kAho+oP6ojztUaO0p00Vxbgjmv2H7BqKhO0wspa2i
	 lc/fU6rmWpyNbpcBQ3JjyM2D24r5uXQXYqGWmaLe2u0m3zSLyIBmJwUQGZmK5cbANe
	 XWf1CB9IG1+e5Qc7iLW5JqfRoZfZAg0jn4bxFp/qkSa6YQ/8/k+hQ91o6+WFUrUjjO
	 qVykfVVGJS9Bw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A517ACDB475;
	Tue, 23 Jun 2026 03:23:45 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Mon, 22 Jun 2026 22:23:45 -0500
Subject: [PATCH v3] ata: libata-core: Reject an invalid concurrent
 positioning ranges count
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-b4-disp-1b9ba697-v3-1-14ac65dd4413@proton.me>
X-B4-Tracking: v=1; b=H4sIAED8OWoC/x3MMQqAMAxA0atIZgM1akSvIg6NjZpFpQURxLtbH
 N/w/wNJo2mCoXgg6mXJjj2jLguYN7+vihaygRyxYyKUBoOlEyvpxXPfIXNbu1A1XoQgZ2fUxe5
 /OU7v+wE9a3+AYgAAAA==
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782185024; l=5345;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=Ec/mFCp+NfHtkSGHo6KpjWMP+g6mOzbrM1+SN3wap1o=;
 b=yTe/Djr7/nk5qpt+L2pLP+4nPOCRiEbr/QY45eJ8c5i1bohtBMrZT9qlfq9CvJM3Uu7kLcaUA
 Hhl17d867smBw83lA/NG7WhDdIGMEYy543/35Hl36xIygjJIb7Z8pAN
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
and the number of descriptors the VPD B9h response buffer can hold
(ATA_DEV_MAX_CPR, derived from the rbuf size). Reject an out-of-range
count with a warning; this keeps the emitter in bounds with no separate
change there.

Suggested-by: Damien Le Moal <dlemoal@kernel.org>
Fixes: fe22e1c2f705 ("libata: support concurrent positioning ranges log")
Fixes: c745dfc541e7 ("libata: fix reading concurrent positioning ranges log")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v3: Per Damien Le Moal's review of v2, derive the limit from the response
    buffer size instead of hard-coding 62: define ATA_DEV_MAX_CPR in
    drivers/ata/libata.h (moving ATA_SCSI_RBUF_SIZE there so the producer
    cap and the consumer buffer reference one value), split the two bounds
    into separate checks with distinct warnings, and note in the comment
    that the ACS specs allow up to 255 ranges but we limit to what fits the
    VPD B9h buffer. ATA_DEV_MAX_CPR evaluates to 62, so there is no
    behavioural change.
    v2:     https://lore.kernel.org/all/20260622-b4-disp-5734c6f2-v2-1-53083c2df3c6@proton.me/
    v1 1/2: https://lore.kernel.org/all/20260619-b4-disp-6200c44e-v1-1-4624a4707d9e@proton.me/
    v1 2/2: https://lore.kernel.org/all/20260619-b4-disp-6200c44e-v1-2-4624a4707d9e@proton.me/

A/B with a userspace AddressSanitizer mirror of both sinks (-m64 and -m32;
the unbounded value is device log content, not bus state, so no hardware is
needed):

  count  buf_len  with this patch
  2      128      accepted (conforming drive)
  62     2048     accepted (62 actuators, the documented maximum)
  63     8704     rejected (exceeds the VPD B9h buffer capacity)
  255    8704     rejected (self-consistent log, but the emit would overflow)
  62     512      rejected (count does not fit the device's own log)
  255    512      rejected

Without the patch the 512-byte rows fault on the log read and the >62 rows
fault on the VPD B9h emit; with it every count the emitter can still receive
fits the 2048-byte buffer. Reproducer available on request.
---
 drivers/ata/libata-core.c | 18 ++++++++++++++++++
 drivers/ata/libata-scsi.c |  2 --
 drivers/ata/libata.h      |  9 +++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3d0027ec33c2..437f790ccc88 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2832,6 +2832,24 @@ static void ata_dev_config_cpr(struct ata_device *dev)
 	if (!nr_cpr)
 		goto out;
 
+	/*
+	 * The device reports the number of CPR descriptors independently of the
+	 * log size, and that count is also used to emit VPD page B9h into the
+	 * fixed-size rbuf. Reject a count larger than what that buffer can hold
+	 * (ATA_DEV_MAX_CPR) or larger than the log the device actually returned.
+	 */
+	if (nr_cpr > ATA_DEV_MAX_CPR) {
+		ata_dev_warn(dev,
+			     "Too many concurrent positioning ranges\n");
+		goto out;
+	}
+
+	if (buf_len < 64 + (size_t)nr_cpr * 32) {
+		ata_dev_warn(dev,
+			     "Invalid number of concurrent positioning ranges\n");
+		goto out;
+	}
+
 	cpr_log = kzalloc_flex(*cpr_log, cpr, nr_cpr);
 	if (!cpr_log)
 		goto out;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d43207c6e467..0b5b3afd8f57 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -37,8 +37,6 @@
 #include "libata.h"
 #include "libata-transport.h"
 
-#define ATA_SCSI_RBUF_SIZE	2048
-
 static DEFINE_SPINLOCK(ata_scsi_rbuf_lock);
 static u8 ata_scsi_rbuf[ATA_SCSI_RBUF_SIZE];
 
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index b5423b6e97de..329e9c5776f0 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -148,6 +148,15 @@ static inline bool ata_acpi_dev_manage_restart(struct ata_device *dev) { return
 #endif
 
 /* libata-scsi.c */
+#define ATA_SCSI_RBUF_SIZE	2048
+
+/*
+ * Maximum number of concurrent positioning ranges (CPR) supported. The ACS
+ * specifications allow up to 255, but we limit this to the number of CPR
+ * descriptors that fit in the rbuf buffer used to emit VPD page B9h.
+ */
+#define ATA_DEV_MAX_CPR		min(255, ((ATA_SCSI_RBUF_SIZE - 64) / 32))
+
 extern struct ata_device *ata_scsi_find_dev(struct ata_port *ap,
 					    const struct scsi_device *scsidev);
 extern int ata_scsi_add_hosts(struct ata_host *host,

---
base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
change-id: 20260622-b4-disp-1b9ba697-66530d14abb2

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>


