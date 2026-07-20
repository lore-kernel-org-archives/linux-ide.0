Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBC137C92C
	for <linux-ide@vger.kernel.org>; Mon, 20 Jul 2026 23:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784592008; cv=none; b=eogwJv0A8tWoY6ZqT4cfdyrC5ha66uAVL+mpPBCir1/Jn5cxOm8VpeKaECLvLJ8rMP00rqLsGkyJeZUEkVbZcDTq+1vTG59Acb8u7Rw+qvf23XH3Z+RsKIXePbmcbrzUgfmY93/qz0Tvf3AZkHPjs93+KnPEOBbhlZNobVgDVyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784592008; c=relaxed/simple;
	bh=i1DAcfsh3RuSKk16XtJYv0IvaG5nSmN5OjVV4mOIG3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H+QJ/TC8oHdmtNX3lyJ2l00NBBlN2+nPVZCsLEg8Ozla3h/ZQbjhdcKEH5BNXuYlkvRq4DOWFlthsyOsVe/sM4VuF6oHhedRgxM+K+0Z0L4UlXqnfzsF1wp23IKiEbIUA83bWGmWHBB+//6fvOPHcA2MiTmPWTx8PqnB4gK5Dow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tLy3VS31; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLy3VS31"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso3424896a91.1
        for <linux-ide@vger.kernel.org>; Mon, 20 Jul 2026 16:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784591995; x=1785196795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h9JVRYfS7k+t1ox8I0apzr6CCDqndFJDiGHdQM7HZMw=;
        b=tLy3VS31+tc9K0HmThQo8J9iNNEckVrpZGqoJ/CiCYeD7fJ3nZjvycgznevraHInds
         lR0aoTCX8FekxLRPlpC28C4ploPRRZdXb9JDoGAmlQ0wkGfYRHbZHmeGezX1o+VaBVFd
         CW9tk/3sWHuzaJPu7VLjboawST13Je1qh2OS40qp/CMHkl3snNZW4sHGlLMP6B9aVjSr
         iu5ox7GfuIeVnc4cFcM/3+rQgrV84YnLLmtYdXBKd0VDTWJ8sMvDixX3TOkqX136s+fy
         w9dACX56ny/oFP7xFuO7oex9IkPnqXYlvt/doeWI8EIFz030D5fKyC6zRwHs1+HIZfHQ
         sSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784591995; x=1785196795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h9JVRYfS7k+t1ox8I0apzr6CCDqndFJDiGHdQM7HZMw=;
        b=FC3Dyx2KEf5xg8tvU0DbltUW5M2NGfSZmr01gpfprvGei/NuxROCue9zfUwPzYsp4r
         uZVFrzR9JSXzeXIrwT0wCiRqT6YOwVQF3lEC1IjMZZ/sLedKKP19Peo4uuvFFFDWSShp
         kSshgh74kxw4P/fuQXL5cUrdX3QaI8PQ+lwX2607anAXbyT19ifh/Mw8guRGziYLc1KK
         dh/qgP86FPMO7EjX1WQpxvlfn5MFrmkhaRvSnyR9T1JsFhL1gX1h5S3BwBbADnlr8gdZ
         rTR/Mzk4xJHrOthXdE4Kh5GTe+7/W0fsz6QQXl1FXlk13gT1c9a1aGKBT60Qn+s35Ogf
         sBGQ==
X-Gm-Message-State: AOJu0YxGFpLxWYQUGsPqQZpCJu8+DpCFClvGflLSy+3OiGRCzvs3t7uY
	kfcuPIcKZy7gbDd702IbK5MbjF9reZ1+je+0Ka6uR4732KGF2WfErmsu9Ajbjw==
X-Gm-Gg: AR+sD13blBY8ERqUYc+rvXT1Bo/f/OzsF352o4s4x1VGTPxeSbcyAlG8payDRuRh/mL
	3BBMAjEyYkP6e438injiG7nO3qoUUOl64Mlg7aSrM0o9Qx25msyMLTT59wq9Q66w1YSFj0wiF/5
	G4E3h2lNHGmNlfNzbURR8Ej2JRXap5TWUnwBXg8kmlSugfclQmCDr2b91+zRzOzTd2dKuw/oqH2
	g1H1ctQBflraE1y/b/WxYGKW1avBS496ZMoiMVV/Je7bHq3I2PII6nB4XcfUDMny3MkjpksKx8y
	tRdwXZ9IWIBwg4QsKVeCfTZKmG6o/9byFHEY9zIG4QKQ2CVYlS/fWCN1tIEDQE92tQ8Axg75JQ0
	ZBmkzopY5e2VxGVWat5K2GymspIPdj43YmMYTSXPUwxMH57IDvRV4T07Eg/FuH6IPHo8FtXMDJn
	oesWbtab7/0sSQ0ifjvMfr156uTcxGu204mK2wq7kYENrTTILGvyM/IJqFMQL6urRsE6VZj65dC
	z67LfX8cjfCXrj5SlQBSsxF82ogZ0f+NA8meUuoeUVnxkg77/QeYyM=
X-Received: by 2002:a17:90b:2891:b0:37f:9e21:91d8 with SMTP id 98e67ed59e1d1-38e4b68268bmr15072497a91.15.1784591994807;
        Mon, 20 Jul 2026 16:59:54 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e9232c4ccsm449020a91.7.2026.07.20.16.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 16:59:54 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Jeff Garzik <jgarzik@redhat.com>,
	Rafal Prylowski <prylowski@metasoft.pl>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] ata: pata_ep93xx: add missing "cc" clobber to inline asm
Date: Mon, 20 Jul 2026 16:59:52 -0700
Message-ID: <20260720235952.1334318-1-rosenp@gmail.com>
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

Fixes: 2fff27512600 ("PATA host controller driver for ep93xx")
Assisted-by: Opencode:Big-Pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: add Fixes tag
 drivers/ata/pata_ep93xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index be8a314654e6..f149210b1454 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -211,6 +211,7 @@ static void ep93xx_pata_delay(unsigned long count)
 		"bge 0b\n"
 		: "=r" (count)
 		: "0" (count)
+		: "cc"
 	);
 #else
 	while (count--)
-- 
2.55.0

