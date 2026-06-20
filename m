Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391FA4C6D;
	Sat, 20 Jun 2026 02:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781922990; cv=none; b=KrBFQLdZlT5wxPWRSSpFUi7BY2z7do/uYDzy3GZzGbaK4DvrbPST7QCCuGwdfmcUIKQSb++l83mR7fV1htFDjXtuGgxJHU7i7Q8u0Fr6nBi0sT4fIJxBhFsF2R4UE8AEDlAewaSp3SX5k4rO+TQzAWk/sHFv82YHX+lPmT30f1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781922990; c=relaxed/simple;
	bh=+f5QQ8EfeQdyatB+pUXBIfKbkRNqfv/khhUjWCFgPGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O6Q6w1Q3qoRdw/4a9Ua0wJDAm8XS8dmaSFOem7UEFgp0nMQ9mSDvrhIOvVRCX5ccX7fIQX+iRDMgwyyupYvlxXTvUfJ1Epkme7/WOVY9B/5kICq8lHtQdrROfnTRLu7HBwgrvRKWDBGgJEqRzIHQRTNB/SXjzQfSTEUsR2MM6HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqGVsczJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqGVsczJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECA71C2BCC7;
	Sat, 20 Jun 2026 02:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781922990;
	bh=+f5QQ8EfeQdyatB+pUXBIfKbkRNqfv/khhUjWCFgPGo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LqGVsczJF15MqrmDuAKjPXhkpGH/oG8z0kJuWhP6o8pF2MzOKGp+igVx9Eg4jrzSM
	 T4q3GtkwO6DL8SG9Rwf9+eI0n2SOHKvlCZDbVstdOEJ1B54l3c0XhxsjMXJwwdyIDH
	 5GZtBLxvIhO9czeVPAULYYpKIyWpZ7+SewIyO8S14A2sCplZwgEtFISbz/iMniCOQo
	 9wxozYNq2tU15zJfXcEQ3+PjB7WfTpufYqFVe3G4JugPxrxOh4Cu5Ptqz/CIdJQDvq
	 ecCqQV+s21wAiouBefxSgpsL4fHfcpSfSQGPJwFn/VWjYawqSTfycyP1G3sD0z6s7k
	 uZH5sqxEMIavw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC354CD98F2;
	Sat, 20 Jun 2026 02:36:29 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Fri, 19 Jun 2026 21:36:30 -0500
Subject: [PATCH 2/2] ata: libata-scsi: Bound the VPD B9h ranges to the
 response buffer
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-b4-disp-6200c44e-v1-2-4624a4707d9e@proton.me>
References: <20260619-b4-disp-6200c44e-v1-0-4624a4707d9e@proton.me>
In-Reply-To: <20260619-b4-disp-6200c44e-v1-0-4624a4707d9e@proton.me>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781922988; l=2123;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=etuEVYLjhJ1FT+81wFk8q9Lg1k6MxM4NwywWjYbfzbc=;
 b=5qN0S5L3QVPbKFwwEJSUL8skJpsnwJX8mO+Eg7n3G9ubCEDKtTMKNd8lEwhwe33gjJhKcfonW
 DLfIDhYdb8yBTgZs6d/DHw4KFUy8A2YvXVrmjbgLYuTs/GQd7mzBHxO
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

ata_scsiop_inq_b9() writes one 32-byte range descriptor per
cpr_log->nr_cpr into the fixed 2048-byte ata_scsi_rbuf with no bound.
The count originates from the device (concurrent positioning ranges log
0x47, up to 255), so an INQUIRY VPD page B9h to a drive whose log
advertises more than 62 ranges overflows the static buffer by up to 6168
bytes: a global out-of-bounds write into adjacent kernel data.

Emit only as many descriptors as the response buffer can hold and size
the page length to match. The companion core fix bounds the stored count
against the device log, but a large self-consistent log still yields
nr_cpr up to 255, so the emitter needs its own bound.

Fixes: fe22e1c2f705 ("libata: support concurrent positioning ranges log")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 drivers/ata/libata-scsi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d43207c6e467..d43306c5d375 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2355,18 +2355,24 @@ static unsigned int ata_scsiop_inq_b9(struct ata_device *dev,
 {
 	struct ata_cpr_log *cpr_log = dev->cpr_log;
 	u8 *desc = &rbuf[64];
-	int i;
+	int i, nr_cpr;
 
 	if (!cpr_log) {
 		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
 		return 0;
 	}
 
+	/*
+	 * The page is built in the fixed-size ata_scsi_rbuf, so the number of
+	 * range descriptors returned is bounded by that buffer's size.
+	 */
+	nr_cpr = min_t(int, cpr_log->nr_cpr, (ATA_SCSI_RBUF_SIZE - 64) / 32);
+
 	/* SCSI Concurrent Positioning Ranges VPD page: SBC-5 rev 1 or later */
 	rbuf[1] = 0xb9;
-	put_unaligned_be16(64 + (int)cpr_log->nr_cpr * 32 - 4, &rbuf[2]);
+	put_unaligned_be16(64 + nr_cpr * 32 - 4, &rbuf[2]);
 
-	for (i = 0; i < cpr_log->nr_cpr; i++, desc += 32) {
+	for (i = 0; i < nr_cpr; i++, desc += 32) {
 		desc[0] = cpr_log->cpr[i].num;
 		desc[1] = cpr_log->cpr[i].num_storage_elements;
 		put_unaligned_be64(cpr_log->cpr[i].start_lba, &desc[8]);

-- 
2.43.0


