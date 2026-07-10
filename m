Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFA03624D7
	for <linux-ide@vger.kernel.org>; Fri, 10 Jul 2026 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711991; cv=none; b=jMWHEjsdOBQJHtTeHxmFCi1zTeH3kef1g+GENySy3COzszclyWEuddG2q8k93Ow1Byo7LgV7rFoG0Zv7xpm+MKRupgwMREUgqndFI68bU55Isn2k+ijRGzQgG+z8deFhYk+XaZLJdAvnmXTkgAl0/Vb/W6UYdNFqMwhVhXlGCyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711991; c=relaxed/simple;
	bh=lbV3sJ/85dO8wq2/UpU64tsZQkIPnBNx1RuUmpYOFzg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BrF0WZkTJrIN3WT1zv+FYbRQ2lWvhN7XlaroimUtWzviPapwRXC0gvFoctg6pdgNtd3ydKQdYAgN41Gg1eX8tSuRvAMdi+DNyXZKH56Q9b4t49sKXvkxsQ68zvRZY1j8RF3LnoLGMT2aHyTgVEV/yFWgxqmVThsakrUu15v8N+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rkaruna.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NxEb3iUb; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rkaruna.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NxEb3iUb"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-384636ba25dso2192583a91.2
        for <linux-ide@vger.kernel.org>; Fri, 10 Jul 2026 12:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783711990; x=1784316790; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CcU03WFNoXU4OUw3PgctfeWuJo6VWxELKV1T8zyFLTc=;
        b=NxEb3iUbHILJVsuZncDnXgoWYQZQvb11LORmoVlG96ymy69diYkspQ/irlsw8aFFW0
         ikU7QGuNFvQU439c1ugc3f1fHSx197FE5juhLbOSVe8HrsodZOHzxWBwSKTNTPZVMkHP
         t81t1jFyLOTZDd3ZqyDFhMicCGycoGkgBL+6LU8Q/vAn1iobCgElwpZ0jYZ7wEZA1fdy
         GUg9riVj8MUYsOX/Qjuq/PmhfnP7tw/ULjH1eE5bgcsy0UCd8hbr9wk/QXdm7oI6lIb+
         lv+PPLyTR5fzype1U/75wtV6U2yui93DSYDGqH8jiTR8cunP2WwryTBqiKh5jPUNcK2c
         nfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783711990; x=1784316790;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CcU03WFNoXU4OUw3PgctfeWuJo6VWxELKV1T8zyFLTc=;
        b=FBUhKRJQGlDM8REWUW6iUHABfYXoZXZig/CpNXWtgKmd+AyUiw4QQ6e/tj+TO5L5aJ
         I2K3r3utRSI5dmv2M/tGBa7z+QYl+fI2ppfLGUUTAcBSWlHBzPxYtR9vhQnVwjXiCMDp
         p5SnjGGOU5xsQJPfAVjjI+/YYMQ2tdDcTqH2CvL8cLsZGKo5lY0GOrNye/40Ri5kdr4L
         mznPDQWgQxpdNAk7vhL2D1r9SUuQM5D8bIAVKL7OCVY1uRNNkephjSDK23v731YQzKUV
         DuZqr3NoMMN6rIPGxcOYFQh13L6jttSGlgg7EgY3Brc1UjKCvWHBU17YIE23ayao5zQB
         z9oQ==
X-Gm-Message-State: AOJu0YyObEipBIn0u0Usds5wpnjyQreZ9qMPxI3T9ABwLEOX/7FhOoZ1
	HZOU23Z9q6O0nemoZMg/E/VCbjOxZUdns17JKWmo7jTkT4mLrydB5BjVk2C/UzgaFuCGzWeE7F5
	rwLpZkdcu3Q==
X-Received: from dycmx8.prod.google.com ([2002:a05:693c:2888:b0:30f:45f6:de06])
 (user=rkaruna job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:560f:b0:37f:c22a:c188
 with SMTP id 98e67ed59e1d1-38dc74c2803mr330801a91.4.1783711989618; Fri, 10
 Jul 2026 12:33:09 -0700 (PDT)
Date: Fri, 10 Jul 2026 19:32:35 +0000
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710193235.334782-1-rkaruna@google.com>
Subject: [PATCH] ata: libata-scsi: add out-of-bounds checks in ata_scsiop_inq_b9
From: Karuna Ramkumar <rkaruna@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ipylypiv@google.com, tadamsjr@google.com, 
	Karuna Ramkumar <rkaruna@google.com>
Content-Type: text/plain; charset="UTF-8"

The function ata_scsiop_inq_b9() currently attempts to write 64 +
nr_cpr * 32 number of bytes. If nr_cpr crosses 62, this can cause a
buffer overflow since rbuf is 2048 bytes (ATA_SCSI_RBUF_SIZE) in size.

Fix this by adding bounds check before writing to rbuf. If the total
bytes are greater than ATA_SCSI_RBUF_SIZE, then fail the command with
ABORTED_COMMAND error and exit the function.

Tested this flow by modifying nr_cpr and confirming that the function
exits early, avoiding performing an out-of-bounds write.

Fixes: fe22e1c2f705 ("libata: support concurrent positioning ranges log")
Link: https://lore.kernel.org/all/0E78BE5F-B4EE-460A-A6D5-F0CE47BFC7DF@kernel.org/
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Karuna Ramkumar <rkaruna@google.com>
---
 drivers/ata/libata-scsi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 5868526301a2..6f54e23a586c 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2361,15 +2361,22 @@ static unsigned int ata_scsiop_inq_b9(struct ata_device *dev,
 	struct ata_cpr_log *cpr_log = dev->cpr_log;
 	u8 *desc = &rbuf[64];
 	int i;
+	int page_len;
 
 	if (!cpr_log) {
 		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
 		return 0;
 	}
 
+	page_len = 64 + (int)cpr_log->nr_cpr * 32;
+	if (page_len > ATA_SCSI_RBUF_SIZE) {
+		ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0, 0);
+		return 0;
+	}
+
 	/* SCSI Concurrent Positioning Ranges VPD page: SBC-5 rev 1 or later */
 	rbuf[1] = 0xb9;
-	put_unaligned_be16(64 + (int)cpr_log->nr_cpr * 32 - 4, &rbuf[2]);
+	put_unaligned_be16(page_len - 4, &rbuf[2]);
 
 	for (i = 0; i < cpr_log->nr_cpr; i++, desc += 32) {
 		desc[0] = cpr_log->cpr[i].num;
-- 
2.55.0.795.g602f6c329a-goog

