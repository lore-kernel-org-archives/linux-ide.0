Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9793F272E6D
	for <linux-ide@vger.kernel.org>; Mon, 20 Jul 2026 02:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784513353; cv=none; b=QzA5I93p4c3mnQO/0FmzRGuHfYoTVEmCoXyADOEPu3okvam3hloCgpqu/ONe7RLrzJ7QVOF74zO5FQGeNVXOEnD9QN5+yJEPrvRA8uKph2GtuBaDY3GWZLhpuhr2MhVMu4FUQAUWTWwbiNPVUeovDOTI8MCb2cU4RqE5DcsMmkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784513353; c=relaxed/simple;
	bh=Qp+8v8xeLdewqRc7DicuCMBj15mpz4wfB6nsfukV+7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wca6zxUTfZx9D1oCgHIAGLYk7GMw2wpfOx0oMD/CqB5VSXyqv64LYCTLKGnAvhq3eQgy4STP30VEZnon7wMc192zAd3m4T0B7KiPOyRpGcDRxXjLIfU9RGByY4Ox/FJCc97b/P+l1YozDUpMdh88W4RkChj6ZGkEN0dqd+IuKko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkpO/hsf; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkpO/hsf"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ee88fce572so73193346d6.1
        for <linux-ide@vger.kernel.org>; Sun, 19 Jul 2026 19:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784513350; x=1785118150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SaPW5A1Sk4IueK0qNz7OPYuFBk9omXY8zTZ0G2a4L5g=;
        b=KkpO/hsfJMCxfs90hoWlZj+LlAo77/7V2MCcY1IT6JYw3lfMFNyAcBdefCwzy+BwIc
         6qCRcpKOuRlrAccAJWsR3Nyx0/K6BjY+K9V0AWq/+cwmfWj90sW+UuDHvYT3LGaOkWHk
         7ftjCZMOAEzddw2kwXKzuixrtQU8s400f3HR5KOsgrrV6nkL/w4GrdG803PYP8eMSMjX
         R4QV3F6nwprm+AUbHJLEoSuy5Ew/HQXIlt0AFW50PeO4ESETuQEFxU+MPpIkNcl1t1+v
         Ac6YZPDYZ7DU0/8Xl5pII7p0x9JVSYzr+cJ68qK+0IuHl8cpBfhLRblnmw8ebQbvPbmT
         XsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784513350; x=1785118150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SaPW5A1Sk4IueK0qNz7OPYuFBk9omXY8zTZ0G2a4L5g=;
        b=fqqw6C/XLJuscajvnxl7HWwEyN5KQCKLAe0E0TR3SsS2b7nBXRwxk+3D7k/9z2K94h
         SBN/9cFaRvHqUISz9sRwla/od6XgTlcLsHAYQsdT4erO/sjLxA5Rg91oevVykJ8O9srs
         YIukIgOmFYU3TylD0D6fN8TRnA0egZGhY69eJNqsPxkrs+zQ1jNeLQLF8YrYRw9996z/
         6uiovutfIyM5FjPaHR4VpId0/tpotqygsSMXmNHIohN5cH3vwcoasDzC6ULvFS5KEMKd
         wn8Jn72BdLaeKrZA3yRDIFXsG8RKf3cUut+HzDc1eZoYS7erMmK6hPRq7pX8FBc9HYjS
         LUvA==
X-Gm-Message-State: AOJu0Ywxj1k9fdAZgDAzcUo9VibMgo7Lw/bwCmvgyv3hmU6Kbck8E3BB
	FAmokRm/0Oncp5dF/P6UmT+DQV/hwcmFJb/SksaIvWE1hPVebUTjLHHdANh/iQ==
X-Gm-Gg: AfdE7cnbLMPj7eQps7iNfyqDSPVJpqSrItXtZPqof51zYUUF5V6Z2uum3BiXEgz9lu4
	IsshX6E+VNOIPeQnntXxlps5P+QdGPCj70WFwbv4mCVnAoSPjCcUSmmNlmNN64yxkNz67eCeB/K
	cnPMWfGDQSBiZNuTura0EhKfy+FdTj5UbmKTkXlkzOcPLxeW/SAhOmqENx27hMRi/dx/HnOXpNS
	eCoy2DbJVYmGGsjylnFNmr+OxrCwdIW9Wg13bMICbxRwe/kU79UvrbsbhjglLS2P0mXuuz7pOUI
	IcPt8eWcmS1kvPG1J5oyJ6d/J+bCEhCiPYhvbi02f5VoVohAPdbbbccECu9Gf2y/0qFj06Ew4qr
	sSCWlLKZz311xI+FGT7ZimwPZVdh273F8CbZ8diD8QsPZWjbvPnu/J8oFAS9Yn8gBTaHRS+a7KY
	56geM0pMOYg40ytMVPZgYlWJiJh7w61jwYuTUpx27IId3Ld18a1lYXahUBhbCvmYpP1Ys1HwB8b
	sOSa320MbOixdQSXvKvjeakymRHTII/VKDIiWhTJcatRIp5pizQMyg=
X-Received: by 2002:a05:6214:212c:b0:8ec:a010:9af5 with SMTP id 6a1803df08f44-90778310af9mr134021156d6.10.1784513350415;
        Sun, 19 Jul 2026 19:09:10 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9077856a9e8sm79969766d6.17.2026.07.19.19.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 19:09:09 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ata: pata_ep93xx: fix incorrect return value in data_xfer
Date: Sun, 19 Jul 2026 19:09:07 -0700
Message-ID: <20260720020907.2004063-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The while (words--) loop post-decrements words, so it underflows from
0 to UINT_MAX on exit.  The function then returns "words << 1", which
is either 0 (for odd-length transfers after words++) or 0xFFFFFFFE
(for even-length transfers).  Callers like __atapi_pio_bytes() depend
on the correct byte count to manage scatter-gather progress; a wrong
value causes ATAPI PIO transfer errors.

Fix by returning ALIGN(buflen, 2) instead of the corrupted words
counter, matching what ata_sff_data_xfer() effectively returns via
its words counter.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/pata_ep93xx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index 21d7261f537e..97dda6213878 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -502,15 +502,13 @@ static unsigned int ep93xx_pata_data_xfer(struct ata_queued_cmd *qc,
 	if (unlikely(buflen & 0x01)) {
 		buf += buflen - 1;
 
-		if (rw == READ) {
+		if (rw == READ)
 			*buf = ep93xx_pata_read_data(drv_data, IDECTRL_ADDR_DATA);
-		} else {
+		else
 			ep93xx_pata_write_data(drv_data, *buf, IDECTRL_ADDR_DATA);
-		}
-		words++;
 	}
 
-	return words << 1;
+	return ALIGN(buflen, 2);
 }
 
 /* Note: original code is ata_devchk */
-- 
2.55.0

