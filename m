Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6256D3DCDA6
	for <linux-ide@vger.kernel.org>; Fri, 26 Jun 2026 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782464423; cv=none; b=pdXkOphAMCpWMw/pOV5U1D7hHJ913MWhfxvGeDJQlfHu0aEjtsNe/7+FotOHTFFvejlMGKMS5QgAMvkcL1ll94OjDuvqwRDiZtmMKPm4CxCzvtSLmOLV1FByc7TGayN5ObyieNoaBe7IX0542Zx15YcQXf6zpP7NINdCaUQaBpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782464423; c=relaxed/simple;
	bh=9xbK0oRJFHC5LKOurDK3IJ0pMM6Wpus6Bcqrz5wDpt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PU4iLepAv0+hZ0K2yud5UU6RmWZlMVPlm+N00cNfYNMaBtrLsEEo1hWQkX9oQL9GU2jBbP4asT3bM2T6ybGYunXl+xBFGoRMIuOD+GXKXcdmP8fQrrTPGmZjkSqhOjRAMaMvbuKU+csfy0ylCwtnecr6psvxQI4NbtClgNze+4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJPA/D5L; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJPA/D5L"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c7f385883cso2851595ad.2
        for <linux-ide@vger.kernel.org>; Fri, 26 Jun 2026 02:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782464421; x=1783069221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7o+20xWpRPr3IaiXNTmq6DkzWNdOpzNej3/0ztxICbs=;
        b=kJPA/D5Lj5i7z1ysRNDoYZxH+MIMu4y8uRETG5O9OI5hsLg6FvcgMRql9BI74hoQki
         fmsNRRKXn4JC2aKHep2Jnd5bUCTYCVIwzS/BDY0d+YmPuImyU3VyUdZfnI2dgZZV9v4h
         1mKWF7KvqEpfLv5h4l5KdEIw2NylD0xe+319GzsYDaAF/7yf/7gQrW1j5jMtKw0h3S8z
         3dVV8+jgbSHMqoU1j8JO2x3hgmubl029mWfFaKz7S0CSQuIWQVI0MyLKWStfnX16vB2P
         VVYfORcI69qqoTrJj+fBM3hNBke7a2gymahM3SLWg7sf6swzUYZ5oVIOxM/rhd3OB/6J
         jhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782464421; x=1783069221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7o+20xWpRPr3IaiXNTmq6DkzWNdOpzNej3/0ztxICbs=;
        b=CUJ5O7u1f2V9Hzw+A3iS/lyczx0MRLfEz8nZIr/oLnSh6gvgx7+neMqC1SgT8OOPyU
         fIFFZmXPyomPVSJCUiHOBxrFEMeZJ+Wxu2B/FZ3z3T0Ok1Fo1I/r4CaoNOSP8GROy8Fx
         1/zFUDf7TJXMS1Y8F2QYAxTh03G+yNwAnICF/DOmLCgU1SCGA1yksOi831Eur0CQxif2
         RyoJxQj45t9Bg7PsZQSU5lP42myVLPOYMyiNyQMGm0uoSnxNPVJ0Wc5097VASjbzwE7/
         f/SWAjDT4aXg7tfzQczzB42T3kJyKgGHNJ8AE696NFHO6cXEdfE7ogkKNoBrNPBRqtUY
         Lo/A==
X-Gm-Message-State: AOJu0Yx/rjrnCbb2IY3GOWknwIejfBLUL/P9GsZRBoK+yhL2cdLS1hdV
	NFNWXZSdV7yA0hRRtuYl0zpGkKTKeizjS7qWSXv8zchgRlqiSL+O1dk=
X-Gm-Gg: AfdE7clY+tX1XM5F/rR4IrmbFiCfcd6qgOWEQYlgv36csbGJBI2kE9lrAdrdrEW/fn6
	kfRS4elOqPt1/izQ3+QK+1Qg/PWNxu/miG/6jzDWbuJzSqU5+UViGhFERoWcR+zj+ZsN9ngBsbF
	WJKEIM/FRrGcJWhkL4e8AiZT1TnP0pUCXLooxgdw3K+6/5BfkvjFBhElw+q7dMIqbsvud4c6QQO
	zgOnNPivO5oEisLtxTJABXYPwjBCMoXzgc36DlHvX1+4gCZKT2NFXbmWQl+59+dGSM/Gr/2Uspv
	s9DSVLjgpUnoUnL3aYiu+Fj8la43YR2kVZvCK3ciL+U6HHcX3c1UdYidOlSVFfaJvvA4W/0KAtj
	7UMMbzX03MmQtg+Fq+hHmE6MRmF5FH+NICwLKCXMBvrMk/dosWkzgb9sNSj/tV7QuoWrc0KDNXj
	2jn5jSQvXw7NVh/ZglH79TtlQYi0+KvojUoV9j72Ywz3a/+KmvQFfuqLk4ytdtJvZFLGkHFdJQN
	R4=
X-Received: by 2002:a17:903:1a28:b0:2c7:f697:2f41 with SMTP id d9443c01a7336-2c7fc73847dmr63702075ad.20.1782464421408;
        Fri, 26 Jun 2026 02:00:21 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5afb5ecsm36000785ad.27.2026.06.26.02.00.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Jun 2026 02:00:20 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] ata: sata_gemini: unwind clocks on IDE pinctrl errors
Date: Fri, 26 Jun 2026 17:58:37 +0900
Message-ID: <20260626085848.40199-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gemini_sata_bridge_init() prepares and enables both SATA PCLKs, then
disables them again while keeping the clocks prepared for later bridge
start and stop operations. If gemini_setup_ide_pins() fails after that,
gemini_sata_probe() returns directly and skips the existing
out_unprep_clk unwind path.

Route the IDE pinctrl failure through out_unprep_clk so the clocks
prepared by gemini_sata_bridge_init() are unprepared before probe
fails.

Fixes: d872ced29d5f ("ata: sata_gemini: Introduce explicit IDE pin control")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/ata/sata_gemini.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index 582c9708275c..92984b34fd3b 100644
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -355,7 +355,7 @@ static int gemini_sata_probe(struct platform_device *pdev)
 	if (sg->ide_pins) {
 		ret = gemini_setup_ide_pins(dev);
 		if (ret)
-			return ret;
+			goto out_unprep_clk;
 	}
 
 	dev_info(dev, "set up the Gemini IDE/SATA nexus\n");
-- 
2.47.1

