Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894BD37B3F7
	for <linux-ide@vger.kernel.org>; Mon,  1 Jun 2026 19:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780340980; cv=none; b=YSfvTBo94jwz2FjvStI1i+8VtsdCSceyC3nvpsH+EVci1vrmwB25BXk/9a7/KvSaUHw5Kj6VYMD0hLRmzMtroMtOd1SZrDPRhhyJDhWoNltPvsolEtROFfIYgJTcDBdxT2ndR2OanbyyLmVcmP7am1vdHtRoDkoXNqNNYBL1SSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780340980; c=relaxed/simple;
	bh=NzFHien8AQ3W2uRrt9KsIcrUygBSpklL/qEaq/faO9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cUuwZ+HZeYQ7bagDqaA3ayLhLcxlv5XZO9aBHbdp9UDNSudZwEPOQga18EP0XKV2Yt1CV8TDKPYU3bxorqpf1goCuwTxdsYQEJiOCiU3dx5RpvF67t528ECkBnxQb2LyZih/6las8jwE/lsfEKC3pQWFGsbgT6eW+Vw3QHrjkfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLs7VogZ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLs7VogZ"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-842264dde84so1045724b3a.0
        for <linux-ide@vger.kernel.org>; Mon, 01 Jun 2026 12:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780340979; x=1780945779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aJOXn1og4jyTJwWf53fIN3cU7RwZav+WgVRJvKPTYOg=;
        b=OLs7VogZ5CdpaWRccKyJZu7pIun/aUh7vTOR9HhGbVR77Tt66D5Oje1+MD5tZ5xLAn
         DkYDm6BqltQeor3Ly8K1k7tMylR+VgdLdARmZhUoK/9bvI5XJyL00/nTCPiSQg/cMrbd
         dHEaB5mVWXJ8cIGgDmOY1Tb8gjpsHF90dqYiLO8HPl4mue9wvGw4jtTUyLnoDxunQwck
         qXxhYi1qYHSDznqmjVAIi5LCBe0IAGh1tAMtBGTWMUugEijZggL1UlP6UFDQ/nnqdHsn
         xRuwpxZW7IpsV2uKwKOIyIe+7TjE0vxoWoi9l0CD7X56SpuK5C0b73CCxTaEeoWaFMP8
         9H7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780340979; x=1780945779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJOXn1og4jyTJwWf53fIN3cU7RwZav+WgVRJvKPTYOg=;
        b=GHrnjpwQfVwsbQ4N/o2/OWv7toDhIshWctNq7vCV9qSMSDrWAStwQIvBA4EwtZFyHA
         0sTE6KLafFQ/ycAXdrQrA3qixAHbnPNWBzrOGXNymL4AvkkI4U4x6UadHCTIlQYXowBv
         raN2iN6KpPdcUbz5EQR6Yuvz1vr+yUdBptUhnAc2g/e1H2hxJBJELbSl7hsGA4lmQ7bi
         cQ2RPuDO/ae47R1sHlPH9Y3A7BeUTtvjJg8UidrK2hww++jFWEPn8VKn9qzQOWruQP3c
         dohiYso0FBkHeNwXJfQh9o0p1NZvy8i6BiHtbK+gSIufsJ6f0Kg761DD+i5dKKcP33Jr
         xbHQ==
X-Gm-Message-State: AOJu0YzPwgQ9+3BDJAqNh2BPGkXFZS4WtXTT33295qlPG4euAjIQJVAC
	GTEchwOJGKl/FbCHdkRLpW++yUtpBAwqRkWPLEuoJCkcTURWhO9Uk8wOV71rwA==
X-Gm-Gg: Acq92OHounx/ndB+7IcytdrV2eIytX2zvq3vJwBAShg4fO4kZqBErVVq9VgupqhdJTm
	8r9YrrQDs2zTniG8U7W9QEhLtpw25OoVlXgdDX8zj2ibxcmjhABIA05Ld/IlHcw+2z55I5pPwR1
	o3JwcXnYBM8+lOQcmo7UumWxOUhSc1p/o92uvAdsXhYLsbPYhx/eJgA3R3T2xOyxxLJhVl3kWSn
	aXh3HypPsB2WoIdsT4aFImwqpZjHXyPGdom0mYTYRitv/COANvkMArmwkVlleXHb2aW6h0kt2Ky
	JgQIEao9p8Tjl7jzESUkSaYEZSzQ61D4YwEJGA+8mPyZABUMGr9NFX27mktq3KZVfqShEnecV7b
	SmUiB1pPijx3WqwmpfwPwmtt5aN+G0+hlKcdybn2b+7DaMZS5ZVwSOKoUsmAUzDYi/ukTcu60Le
	QuqUfEoOsSe/1FvbyTSTsUiu88ru2yYumwlLnfEnP7StCSdKs6SuIkNz5NMaCzR5C6AcGbDWN7T
	cqcAn7pwCOLYWveoiBkZQH4+x8k0Y37iT89dAo7xdHQFg==
X-Received: by 2002:a05:6a20:3c89:b0:3b3:e4d:5071 with SMTP id adf61e73a8af0-3b4785b0abfmr738872637.0.1780340978672;
        Mon, 01 Jun 2026 12:09:38 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85772d7342sm10593813a12.26.2026.06.01.12.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 12:09:38 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ata: pata_ep93xx: fix endianness bug in trailing byte transfer
Date: Mon,  1 Jun 2026 12:09:21 -0700
Message-ID: <20260601190921.20167-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ep93xx_pata_data_xfer() handles a trailing odd byte by reading/writing
a full 16-bit word and extracting the first byte.  The current code
uses cpu_to_le16()/le16_to_cpu() wrapping, but then assigns through a
u8 pointer (*pad), truncating the value.

On the READ path, *pad = cpu_to_le16(...) truncates the u16 to u8.
On little-endian this happens to give the right byte, but on big-endian
cpu_to_le16() puts the valid byte in the upper 8 bits and truncation
keeps the lower 8 bits (zeros), losing the data.

On the WRITE path, le16_to_cpu(*pad) zero-extends pad[0] (u8) to u16
(0x00BB) and then on big-endian byte-swaps to 0xBB00.  The hardware then
receives 0x00 as the first byte instead of 0xBB.

The readl()/writel() calls inside ep93xx_pata_read_data() and
ep93xx_pata_write_data() already handle endianness correctly, so the
trailing byte can just use the raw read/write value directly without
the cpu_to_le16/le16_to_cpu wrappers.  Remove the pad[] array and
simplify.

Assisted-by: Opencode:Big-Pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/pata_ep93xx.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index 3f61712af5bb..a0dfdacf54e5 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -495,19 +495,12 @@ static unsigned int ep93xx_pata_data_xfer(struct ata_queued_cmd *qc,
 
 	/* Transfer trailing 1 byte, if any. */
 	if (unlikely(buflen & 0x01)) {
-		unsigned char pad[2] = { };
-
 		buf += buflen - 1;
 
 		if (rw == READ) {
-			*pad = cpu_to_le16(
-				ep93xx_pata_read_data(
-					drv_data, IDECTRL_ADDR_DATA));
-			*buf = pad[0];
+			*buf = ep93xx_pata_read_data(drv_data, IDECTRL_ADDR_DATA);
 		} else {
-			pad[0] = *buf;
-			ep93xx_pata_write_data(drv_data, le16_to_cpu(*pad),
-					  IDECTRL_ADDR_DATA);
+			ep93xx_pata_write_data(drv_data, *buf, IDECTRL_ADDR_DATA);
 		}
 		words++;
 	}
-- 
2.54.0

