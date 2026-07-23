Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92CE28F5
	for <linux-ide@vger.kernel.org>; Thu, 23 Jul 2026 00:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784765532; cv=none; b=VEgMWKLntZj/LEhDuuDhl/qF+mnjcNxwCENJ9VzED3ScRb3hwjN0MdOZJ45YdUd5T2QnTljpfLCwgY5i+Yy2VLuIu1BOdAvP6zT6ks6RGY9nP+rftIkZQz4/NihdH9yI0xqg2jWBPyqRAC+fhC15SO0yp+UWj7Bz2N0fxyqI0Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784765532; c=relaxed/simple;
	bh=7ciE6GlTWoduAXVqm8K1PxF50yFxKnqQ3z+EuNloGDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xe0HPg8aFvqvIP0sK8Mvh0MkMaQEAj2yYlpXDdKDX29C3ItDyV17ex3IQ9Amn/sEA/793uLdqY/0Eb7a6jXlchXTGlV/twXtcJc/mbd8NhlOgJFHESRvX7czSOupL2ekBR9LgpgLN5m6vJk+xoLPtU8NTVBQRN+Wpx8khMmt0PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXcxqIZT; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXcxqIZT"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-848595b338cso61741b3a.0
        for <linux-ide@vger.kernel.org>; Wed, 22 Jul 2026 17:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784765530; x=1785370330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Tk9+PZMwC5DCEVvGTZW/JwMM5GP9GJcL6Bm5eNuWZY=;
        b=YXcxqIZTTA4SHl4e+yKXAKVHKYfsMqzRPOhkWH360NYa9qhZ4jfmzNP13YITyGp0BZ
         Q6/PgZ4NCDC300DPcpbPaH/F+CXYIZvrBKyzJPla0jm+rXk6o8+6DL2ndcLOBeHW4nWW
         fqMmT4KGIiBuOXPKqTAUIGdtVjMjk1P/vVAI9TDGrAVc4LEShhXWG08nB7t+qK3uNi4R
         tMACfib9DUXFthCo8XQ+0NuwQaxL7fM6/k+7yB/B6sWftdN3OS4P6LN3XpEwpZHEgm1Q
         8ahIpUAdlJA+L8Xa85ZkIawu1Xw+klQBoHkyMOEE4pNXc4HMsIlGwDnRLPZMA2AXStbM
         kDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784765530; x=1785370330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Tk9+PZMwC5DCEVvGTZW/JwMM5GP9GJcL6Bm5eNuWZY=;
        b=ezxGVeOdtAuC0SSKoOQBRnhODtDQEmaQUIwnh8ChA6CJQSSd7xWHqLBe86R695Z+ZB
         mwKIbwRggxqflb6rP2ViLdWILvfEgmp3sjyOQC1WUA5qvvfXagXxDXfCLnPAojZNDGRK
         CbxX1E8pV1TIRMn7qELyMMuMAIQhoRx/Goy/dKAwjK+jCCyY9n4RcZWhjJCtrdpya+FD
         TQIrCDywSflO019zt091AsZ+pxNdOjZFiihjvnfApDtlE6J99jSS/bW2C3AUT5s0hvS5
         uieevqpX/5fe2E/a1wsTjO3A6t2IzYZWz7tbyyj+nIQJIW8iBlMfE2KRNLDeRYYh64ZP
         7Fnw==
X-Gm-Message-State: AOJu0Yy2I84YX1Cm18f+kOsKG7ukjIQOtf6G/WKq3nKFbeBNy+XBum7v
	vTazGBqfPxTl4EHH9tlLFUC+tpcSpletqRCWuMpk7m+PeUNRWudt5wgHqpXIsg==
X-Gm-Gg: AR+sD12Ht8/Lq1eB+KNMWBRLoQjgP9fwyJbS7sqoY8lqMxBJu9Nz9HM9CVL/fm0krGg
	60NcKz0KuLyMj1pSvCe012nIagpQsk5mTEQPjYXYhTMS+FlG/cEFH02Jx+lxZFEnINkAcIwG2fa
	Ebo1q1wDAe6vwTfesINKFik/cRWLX/r+Yi/TpjBUZo2iV72F50lUegfbLFEZWLzDNBWaxISd2r7
	EtclI5V7qSiHFM3rfJqbpEMwMkUq2716seW+Yn8YJzpKf2O8iW3QedmxtvxIqWlBDmVzW6cOccx
	1nTAhRR0RWlteAcAMWhQB9M/siqNqqt2PsmRpoKVOF4uA6fthh9CxYmHojJ+GzUma61QtKOY054
	7qQg3s9GQ5YUDrCBliaG2jSoo71/k1pR6sLe+0Cicjmw8c++KuBkegdS2hEZHbOaYvaKP+pcvJP
	KI8mWkJBenz+OFCxilgsKjLdQuL40Wx6McR9J6uaGU09YR0/f4U4W84OXUxqhHrbX1IWNBV1iWJ
	b+2c6zWxkENAO3Ux+Lre4/3vuQ9Td+zRebPEi+HLXmR9Uu+1BCFpTafJ6as+wXySA==
X-Received: by 2002:a05:6a00:300c:b0:847:973b:3cf6 with SMTP id d2e1a72fcca58-84e2b5826cfmr1153948b3a.0.1784765530090;
        Wed, 22 Jul 2026 17:12:10 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e1760025esm2037253b3a.57.2026.07.22.17.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 17:12:09 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Mans Rullgard <mans@mansr.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/3] ata: sata_dwc_460ex: fix PHY lifecycle and sactive_issued races
Date: Wed, 22 Jul 2026 17:12:05 -0700
Message-ID: <20260723001208.1469323-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses two related issues in the sata_dwc_460ex driver:

1. PHY lifecycle ordering on device removal: The PHY was being powered off
   before the link was properly torn down, causing issues during device
   removal. The fix ensures proper ordering by tearing down the link first
   before powering off the PHY.

2. Data race on hsdev->sactive_issued in interrupt handler: A data race
   was identified on the sactive_issued field accessed from both the
   interrupt handler and the task context. This is fixed by using atomic
   operations and preserving the state across ISR invocations.

The third patch preserves the sactive_issued state across interrupt handler
invocations to prevent losing track of issued commands during interrupt
processing.

Rosen Penev (3):
  ata: sata_dwc_460ex: fix PHY lifecycle ordering on device removal
  ata: sata_dwc_460ex: fix data race on hsdev->sactive_issued in
    interrupt handler
  ata: sata_dwc_460ex: preserve sactive_issued state across ISR
    invocations

 drivers/ata/sata_dwc_460ex.c | 46 +++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 16 deletions(-)

---
 2.55.0
