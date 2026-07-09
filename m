Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B54A31B100
	for <linux-ide@vger.kernel.org>; Thu,  9 Jul 2026 02:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783563156; cv=none; b=bDsZRqcn2uZodGucXC5fAumeqvvbOKFjy91m3A1Ms8mbHiqxp+Jtd9+zrrBObY5OLorqgN/7LLqCapUJGkDxBeWkuGzE8yBS/62GphvWtQeFknDfta4CP09KDyPq05dtFbawRGWO8jTxslv0bhuiZVgf7Szcyadkj5lPAZHD4ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783563156; c=relaxed/simple;
	bh=LbFWNG+N46FqZb4f9RIPc0gWL5VSNJ9ndAg4F/zqjyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S6+iUksodFavQ3oHWfkZBqDVyfQ+BGYZhWKis2wZDyKoHAO7pGMiRz2EXsW3SOVU58+C1NFDOq0Uqv2evcYRVoq/xB+pXZTejnp5/Rp+vPUs4r7rYU646Bn333VPgZf7mqMQiGGjliPxT+tVtLc5IixPuWhS0J/ekNdaYUmk3K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gc6ukcX5; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gc6ukcX5"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-381891a9525so528221a91.3
        for <linux-ide@vger.kernel.org>; Wed, 08 Jul 2026 19:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783563154; x=1784167954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jy6d1g2T2hXuxyjtCxJ4Kmcck4bvVBCsfUoFNsD1Fi4=;
        b=Gc6ukcX5sDRK/S9wuyNaF22BpKQt6xQtvT7PVM0Qn75llZqPVq2sEoR6t+5g4SUBto
         aVPBlHi55XSrULH89PxuVJD9h/w1G8Wy5zWnuf+BH5jc9LkFKT2BZpKi5wn3sv8eVm/D
         ahZMVgTfZ3Rzt7qRUpkOoFE/l7KQJae7muTvnONerfscq0LPVlXE2zvNC6iYet87yiwJ
         S5eMgYWgrzxrNK4k+dg7t/4LbnoK3wW1eaHjYOP44RiCbphRQNuzfUVYqsdU/8bz2CaY
         U20ahswE+LYVhg7bMkQVD0pjsR8rvLpPJf9ywuZcyBJoK+hi5ORujZOhdQYZk6b3BfOi
         9Htw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783563154; x=1784167954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jy6d1g2T2hXuxyjtCxJ4Kmcck4bvVBCsfUoFNsD1Fi4=;
        b=dd+dvS+/NUcap0PvceBrL0j4UEKuWrIrbuiVZcF6kDqxWYRCY52dm2VhkXLoEcq+1/
         buDPHARAuwkfBAYLi0uIQqUXp7REWH+tvL8R7BgPf4az2N5y3p5AYADG6VlPW5kiYmnU
         nhKDg3vUdOld3dF/Z9LZ9CzHmUY8pAmHQICKHpacGQBgPU+uDGz2hBo4Y7Ozh7sOcOKT
         jGBAHwTm3nULXAjueyBwdT7AjQCJyupazX23tIMlN9ji/c9AEyJrqPoaf0bwEPL76eOz
         +DQQLxLkli/Lo/r8obit0NW//gqlMad1cghTmDUBkaQmxdDsY6XNXGKpLp8ReC/lhcWe
         2KHA==
X-Gm-Message-State: AOJu0Yyq20W9nZZIGKWEpHc7MB7vcjMcgMdbIEX9b49qk8X57Ymw095L
	L8FVHeq9Evay0sYv9bszaQ8P+Hr3sTLRf8vw5/h3wzSaHNS/gGfWjFW9G3GsWA==
X-Gm-Gg: AfdE7cn/BsL+XuL0v9DnaPs/egpt4PcHNupVw4RuKC8fD0Lzk+zyvDnJkyCPYBY6wq5
	qdxo4mfRo0KWU/UtYELjMjOA7zuN6fKBgaDiK8rd6UeT4QEdp8leJkiWhXL9QPSTzPaa1vH5CAo
	LV41/j5U357F6Y7ftDt/BZHTh8NOmSliwn/HlVB6jX00aH2/EM8bg8D7S/14yzGySYc486qrDkI
	qsCLp4zynk5BEdlQKzmhE1jj1S0AiihrxsZ4eAG3sFRXxT+/R8XJT/um0shTQgD3/T9vA4QEleN
	As2mezRe9E24PziDiRwqQO10uq9XUS8uohck2EZNuYw41uNc4zY6Xv4D0xKSFVwTnLKzTqYq7sE
	sLHq/C7R2iMkitVcEB2/f1DgpDrr6UuhVTL7GAl6BKiL5IshzTyHxa0Lw9H2fHZjXFMrDUeQ/vG
	6LF5EKhhs6IHGl4b3Yiu1AuxId5pFx5yIrVvo3TOIQnLFiRodo8kixAef4ZHaEktdVBiqnWGwVR
	0hEz//FId8MTIeZc/pUEwibGpCzv6mrJUXlzthQUeCyD4wCpR8psvIhuvrv75oXFMHzTUN3J0NO
X-Received: by 2002:a17:90b:3dc5:b0:381:bc4c:da5b with SMTP id 98e67ed59e1d1-3893ff62068mr4919084a91.18.1783563154541;
        Wed, 08 Jul 2026 19:12:34 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb9bbsm36485895ad.4.2026.07.08.19.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 19:12:33 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ata: sata_mv: Use platform_get_irq() to get interrupt
Date: Wed,  8 Jul 2026 19:12:32 -0700
Message-ID: <20260709021232.2042777-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract platform_get_irq() out of the conditional block to run it
unconditionally, replacing the direct use of irq_of_parse_and_map()
for DT-based systems. This simplifies the probe logic and avoids the
need for irq_dispose_mapping.

Assisted-by: Antigravity:Gemini-3.5-Flash
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_mv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 41647a56a9f4..b109eb4ef995 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4054,13 +4054,11 @@ static int mv_platform_probe(struct platform_device *pdev)
 				n_ports);
 			return -EINVAL;
 		}
-
-		irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
 	} else {
 		mv_platform_data = dev_get_platdata(&pdev->dev);
 		n_ports = mv_platform_data->n_ports;
-		irq = platform_get_irq(pdev, 0);
 	}
+	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
 	if (!irq)
-- 
2.55.0

