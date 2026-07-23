Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424243803C2
	for <linux-ide@vger.kernel.org>; Thu, 23 Jul 2026 19:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784833830; cv=none; b=F/tENcMxKwlLwe3JyjY2u/XglDnvZGNm3h8kCAxsDzBVDWaJi9ARF2wYWUPkTnMpPZqhv2gApgqRWxEpTWQkbVGKkY2aEgApSYDT2WSF+0lZpyC49IojsvO3dsXCfJqZdAWuXH4LusL88DzkzyANmrWbOCW/wPS8ilFGTB8umjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784833830; c=relaxed/simple;
	bh=CGvBFdrnBTyCmbklutKLWgHULCfNFj0YpxQdGzvdoVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r4ZCh7/zyKV35IQYG3vQ03aAMfE6c6iehexSq5gdqmN0rsFC2xoiur+8AEWaXKixYrhAgodqq+GuqJBEFawEg+Kvlr1Kq2cpXloyWflClMBabgkcZjS5c11SJ0mlItdQpq+zHu68bAeQDAv9lVcugvCHP3NgaU5eDzwn9HGWobY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcaOb3K0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcaOb3K0"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cab973140bso14293315ad.3
        for <linux-ide@vger.kernel.org>; Thu, 23 Jul 2026 12:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784833827; x=1785438627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kma+H0GidEuVkDhtrT3eR8/peQN+opodaig3EX+nuRs=;
        b=YcaOb3K0TCrjF1oB2cy5+5I8jaEgu7XB2ugG6IDAndYn6ajUglUt/lbg8P4MD5ZG5e
         0HE/G/q4AzjsX2R2jibQJmCkTBqOHYg8XzvbnJsCzV+zA0vfn/c8wRzXUanf56BLlm/f
         weMBn0UWok2oJ6AcbDWTIW/mFJn66Trk5ZoGvisnUADzmSf3HCmm8egp1gXyamGAq+T8
         x8hzDi8cq7/M3REnGkKpsMeP7jOMPYALTAfkZ9y+fcce2z5pJol5O14Q4MRgb+7M2GhD
         ygAIsYiasrclk06UsSevy3Zipp0yEwdtNP78+ENFXsJnJ0YaCngWFSV1GL7aDDrVxjzf
         kseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784833827; x=1785438627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kma+H0GidEuVkDhtrT3eR8/peQN+opodaig3EX+nuRs=;
        b=DFWyDvV3UxPQBwh8e6omyZeqthmT4AOcKVl1jOxBW5sI4gTi9KxbOttgJp5712RNiX
         emIQdaXEDRz86aJViWCoiWwcqT41/e96x83ccFVrBEYBW9Rcp3TajcMJ5dm9YjA1ry4V
         0d4rT8JUPe/tppGxrFyI/ws53Ddh9XYR4xmR4ltRTn/h8113PLN5vnOvu7fscZEmkM4L
         2Y5xjnCpd5W9Mynlm0bWC3RM/NkWuXVZbMKcXFtf5KI6UMeLcI1yr9jZbNCpFFsRXfAC
         G1QoebTaW38pvyiB9M3PPRT2N5jVzLlYxn6feI/ohuwvoGkrBc43alixx76idhe9Y5Wu
         DTkg==
X-Gm-Message-State: AOJu0YwpQfn0tsxeTpRSgyNQe9LG3GOIkgcl+mFmG7Hcbc78HrcYDRkw
	3tsreWYzVo0TRmRMzXc+EsyqJIAuHJpkhVvtz02fY1i1tf1LG+E3taXMibCZwQ==
X-Gm-Gg: AR+sD10Yry30oqtoHV90oY5Fp7uqhqVh8JGcGAByUMRW34iRVCgp5dw5frffb4frMNL
	JvU6thV0Ui8zflbqkdqZfdeei1joKfUj8UlSL41YoWTcANqqsvibMLR9kCOSgAYXCxu0Yyzg1RI
	gs6AT7xPcir7QOVfHgE5YCeNhPDHNbnDZ4aMMoftupPeW3HjIdhCHyGg0x+RVJrk0O7gmAOUTZG
	AAwI62n7hcu9jJrq5sDWVePZaVsUlLa/OaydDojt6wGcPKL0g1nc0GUfJPJacE73pGJ618BKDzG
	pGfltisyoh60n5DCCpfoXkRfGI/b+s3bxK1pNeMHU8zipfgplE8eFpH/byjy1zzG9nqrjwpslCh
	Rcv03vjG9xUOsCxsgjJJK08prsQIn7MgtnhBD5kOBmMIwGDFZr2EmzIXAY6YthjMW85aAkGH+ff
	o/mwlG/lsIpHHWbYW3PU3oPtn3aw9SjeNu7w/v687vrDuceuNHUfSLSog8X9Hlhx6bxgSJbkygr
	PPCqEdmQGJjWwfCQgiHeRa8TGt49795cZdWAd70bYaulte3ssbRTqg=
X-Received: by 2002:a17:903:3b8f:b0:2cf:7882:a444 with SMTP id d9443c01a7336-2cfa6b7e2ecmr55815815ad.16.1784833826654;
        Thu, 23 Jul 2026 12:10:26 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e65e6sm39324025ad.38.2026.07.23.12.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 12:10:25 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Rafal Prylowski <prylowski@metasoft.pl>,
	Jeff Garzik <jgarzik@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] ata: pata_ep93xx: add missing "cc" and "memory" clobbers to inline asm
Date: Thu, 23 Jul 2026 12:10:24 -0700
Message-ID: <20260723191024.128984-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The inline assembly in ep93xx_pata_delay() uses a "subs" instruction
which modifies the ARM condition code flags. Add a "cc" clobber so
the compiler knows the flags are altered. Without it, the compiler may
reorder flag-dependent instructions across the asm block when the
function is inlined, potentially causing incorrect control flow.

Additionally, add a "memory" clobber to prevent the compiler from
reordering I/O accesses across this delay loop. On older ARM
architectures like ARMv4T used in EP93xx, __iormb()/__iowmb() may
evaluate to empty when CONFIG_ARM_DMA_MEM_BUFFERABLE is not set,
leaving writel()/readl() without a compiler memory barrier. Without
a "memory" clobber here, the compiler optimizer might reorder
independent I/O accesses across the delay, violating ATA PIO timing
requirements. This also brings the ARM path in line with the non-ARM
fallback which uses cpu_relax() (a compiler barrier).

Fixes: 2fff27512600 ("PATA host controller driver for ep93xx")
Assisted-by: Opencode:Big-Pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: add memory barrier
 drivers/ata/pata_ep93xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index be8a314654e6..085f1e8e5343 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -211,6 +211,7 @@ static void ep93xx_pata_delay(unsigned long count)
 		"bge 0b\n"
 		: "=r" (count)
 		: "0" (count)
+		: "cc", "memory"
 	);
 #else
 	while (count--)
-- 
2.55.0

