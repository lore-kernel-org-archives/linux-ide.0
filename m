Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356733E8C45
	for <linux-ide@vger.kernel.org>; Mon,  1 Jun 2026 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780338918; cv=none; b=J4laZs+z+8Zc1VG0jWK2DpTAf48V3so7l88KnUEBDoxYUNec1o1/9zxml/Pne1DfJhRLRXQZcke5GtCABSBm17LrxquUsnYyASxr22V9Q0c06DfDeUttvaCsDMFVj3h7V5SZ/b+Oo5w2aJGUNAMol5kG6a4cz4FXmSR6FBaSOZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780338918; c=relaxed/simple;
	bh=BDdg2CqdVihu/FhI/9k6w160rd28h1cFOQdalHx8QPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F8/5K8gk6o0ZuUKtWFlgzjAmQAHuZmIn+hiDESr3U8vX1ShRGZ/HP4fLkhJQhf3qXa2b9Xf8MzG8lEx5DnJvg+g0dpwOEdo9tiNWPszgSeeCgKerD/i4UEmtHRtp6IgkACLxOehOtn22REwgGAKPw3LCR0kxe1Ced+QmMlgomQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MX70RQQY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MX70RQQY"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf18c30bb2so28471185ad.0
        for <linux-ide@vger.kernel.org>; Mon, 01 Jun 2026 11:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780338916; x=1780943716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ijDscAefgPntTv+939JFdEHOWuem86REi3D2CtOjsw0=;
        b=MX70RQQYIIiZcjWu5UOti71ewmeTNDEsN6Aqd476Ri0vk6ri/xYKzggItvXxo6FpaG
         zkLOleGdZZRtRySo6nkpKdgBq4BXVKIqSHeF/ll+2MblVURN9lYlsUPQmrJeGmi3QvBY
         bNWnHkldgJkV5nXv563HY+AsG/mUCG4M/AS4LMo9sp2tNfUVTHCiOxXVOclhkK0TjB/y
         l7O6aS+SVCJMzASFJlxllGd2cp1wCQsGrGePeX4oOy091smIiJotQAz7fsnmXaEsln/1
         3tkdwVzZWdBBxhTBBqtOY9h2uJ1mTdmFgwOBkAmuJOqH4c7nOO3AXFOAl3mIsXOhd8ir
         fYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780338916; x=1780943716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijDscAefgPntTv+939JFdEHOWuem86REi3D2CtOjsw0=;
        b=eCOCwWV1h9cyydvlOHGZkXXRFm2OftvnCRH22xSzMzfGXE61i2xdVSzsWaKlzDKb5s
         FvvdwEcBuZ7ur2X2kipokJ2RAu0n47k3tx0s9mZiFmE/VXFIoicsm+OJmldlkKJkcBcK
         LS34FW0lMIVBKsNuEgfikeSyCelFXe5Sk+GKLjoFKdsGOQ4P0dDH8YWZwoTWZBu09oAz
         z7yGU62OXxGNK2SXQXfDR6NoDaVY9nx5EeHd6uY0m1vtb2DM9ACHYvNx7BPdZ4AQQB7v
         GRdPIzXFACsKmHKs+/8ZVGAlXPQsm67OQDKQqEn7v3RE/R9W6R8/0msZNaSa9CxkA49f
         uoCA==
X-Gm-Message-State: AOJu0Yw4wFFyV44gBTEvskYkgpUKXSCNGTAdSaf9iuqxUU2/CijIIBfb
	q0G2WTDen709Lw7JTQhNUCMomHOzsDxqaOAoow9xbqh+kqzL9dpFo4AYWlq+mA==
X-Gm-Gg: Acq92OGq9v7qbAumIzz6/TFDDpeHcCljsWLv8C3yHEtcRhv+z33UIlnT2q+L8mAvjGV
	jwQCUQx6Iw3M3dOx1JHIep/POnC1IVGxYHj8in4b8d5s0/XFg5FBT27bN8DRNGflF/M1gAW7O1H
	ZUCSVCondszlJ/1qci4d+OJNEBUUzOnFMLw4LnbAriSeDeEdPf5bcPlYKhwM/6AsoZpi4TYatP5
	qVIE6VXHIDbFfEtkwcEixhh9li7cMcSqpQLQQKMf0QuERDu1pI2MO4sJmnSEzB/TdWHbmHZTAMd
	nwHBW0sz3VnAQsq2J5hygu7wVOm/E6dnWiL/qN9Jc390yhecxKcdUl5UY9xXDo57gy2Ppi2iyfE
	+GXj0fjrOsyYKOwYR6midq3UPv1geabm6F/1chRh2RLKXMJMAIVx5eB19lPvAJT5tn7Xej+SHJ7
	/U4NpKtrXyzekp+qiyRLcwmTHVzKE0zBYMWIDh9F13i5LqzPsV83CD/OUeliE9YShTILZ6pl8LV
	91PFu78dMvMyAwRlcC8+7MYsDC4+ojLUiX55J8xtt6Nig==
X-Received: by 2002:a17:902:ea08:b0:2c0:cb0e:ac42 with SMTP id d9443c01a7336-2c0cb0eb05fmr79167595ad.3.1780338916404;
        Mon, 01 Jun 2026 11:35:16 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c0842esm110926945ad.57.2026.06.01.11.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 11:35:15 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ata: pata_ep93xx: add missing "cc" clobber to inline asm
Date: Mon,  1 Jun 2026 11:34:58 -0700
Message-ID: <20260601183458.11448-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Assisted-by: Opencode:Big-Pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/pata_ep93xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index aa6f8172925d..838cab54d58a 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -211,6 +211,7 @@ static void ep93xx_pata_delay(unsigned long count)
 		"bge 0b\n"
 		: "=r" (count)
 		: "0" (count)
+		: "cc"
 	);
 }
 
-- 
2.54.0

