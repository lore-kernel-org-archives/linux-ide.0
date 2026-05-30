Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBE8246BC0
	for <linux-ide@vger.kernel.org>; Sat, 30 May 2026 00:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101409; cv=none; b=iswP2ZB67wszA3oNlEH9bJ4SnOxbxMoN84km8iLgldlMVIsZSq6WUgmH74gyTaayvbsDt2EOOXDRGptT7TH7/G7pJNRDRNP2/o+iys6KkybdzIuk2jinPxyt4/m5m2ukDbbiE8CD4vH2aHc3zv9sf2XQm+6o5UyF9d2uxgUSYmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101409; c=relaxed/simple;
	bh=bp2r4wt6eoH0T0tbEcQb6TYJRDyMOVTOrGO+KWWGkb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQve6TQNO+6d7CQyX0K6mzKiUdQckGUy9IqR9xzNHoaToReTBA3hQc7LXhb8HYJr9MTDozxXu2la/cKoskvLDQcP8IxMJ1l3N3RKqFFpx/tbrW5bYOvTSQYRS668vwerNMfFScBG02K0m0++t4kC2JILY4BkfOn7Q+al664hunk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VywG+ekq; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VywG+ekq"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-83ef1d17904so14073216b3a.1
        for <linux-ide@vger.kernel.org>; Fri, 29 May 2026 17:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780101407; x=1780706207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muhrfx34oSJ4DT2661L+8u+zEGhLYb4jdR1Jd7CHhbY=;
        b=VywG+ekqno5QOHtNyH1XJK8g9v5So3yURwbdGtjNAteYHWLPRoZLt6kAu9SrllFl/B
         09qao8+B6/ngLXMPj7t37u/2FWT1/HTVbqIpJCnpzKAJcJefgYjUzV/py2gnVzaDCddy
         WoszAg+ykGfXIFy5US9oTzISqTLoP566jbtoMl1oRWYMc0hr4RiG9qNxqVKzPgvVP0h8
         KyvlxU3Icqhqw4KRJfi6cWtFrAFRFiCdKW3Omk+pjMWIAxRSahQeL4TpB9l1jRDhgg+X
         B+VpkVx2tkVIykoSFb8X0OqOuVLZkM4B2+ezJOwieMUZC0wttPMbUkq+fvsTN1gVpuAL
         N89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780101407; x=1780706207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=muhrfx34oSJ4DT2661L+8u+zEGhLYb4jdR1Jd7CHhbY=;
        b=Pf1Ff+btnQYU3tbXM3FO5GnK64tyGHpY0u1uweS6rllvqbVzm+oI4RETL13r7/3Oae
         tD/6+CPYON5e393fITH8g5ZwSmmjCL0Dq6zwjPQcANI/ZMa8NqrlWNhSNxtuVvV8JhOa
         4PYFteiu1CXWLFUjTDY5/9mG6MgMGoTylNc0Tn9Yf7a3hr3S9y/wkndFu/SgrBJxJWSM
         eIFfX20aGuv8pDR79QqwcnYRfsl9i41pr7oouZlDljEb5J9SK91qpVUXSZoF3uPVLih4
         al7nWAiKzj7LiKaO0ShQjl2wQGNaw+ayoparh04SFyMBPs/6wEIP3IEoEsYI2Y4+y74d
         gozg==
X-Gm-Message-State: AOJu0YzU7+MKIC+UhgolVgYl87X4U2+7rCg4OHteBLJEUPtIwyexQp8k
	pjDO6h6K4AZSYLT5+vERdobTci582Xxb2ED097x2EtMmgeNeai8Tev7/LIIuKQ==
X-Gm-Gg: Acq92OGyFnmgiANJtnzwfgZC7tV+LMEvty2On/6mTV8FTu2OwtQ1HV7OlbJYmlBqpFc
	uUC1OzGmPuuCA03Z5iTvrUj3b6vnSi0ADBpcT2iq3qhhpNaKifpD62l4X58AI6nllrq5dhxEEAU
	7Er1HU/JxL6ePmj+3T+P383KjWiVRj9x+0IWJ7LgMiIxdVNSEUOKX+EaCEcoAoDH7QOu0q5vxTa
	ZAoAxYGFijUgnjoHXfJjmszANJle4GlHiakUjvzIvKIM0m/jmEP+wqrvqHKN42fh7nj2K6PgXTU
	n4CYyjOOD9UBoYnWe1M1XcissnIeCG7k2d3j+dqnQrBBCScJq8ldmd0wbw4s9ljlwWvW3fr6w/5
	2MiMbjN7WY4BT8lYn1JyCmJU0ka1Fo3RGis3B4Cf+fcutBH4Js+7ejmAEmQk/kvt2TLb9GGTKVM
	iiODE6Xp5cRySxGIcoo5W/y2QeqyVlRmfFywSWQPnSXSD8+wU4WgjpV2u+HAdwrursqhrEf5OJY
	vdHkSQ6BpYROifc+Jt0LhszkHqsEMuMbsqgR37r48zKJA==
X-Received: by 2002:a05:6a00:6c82:b0:82f:6858:3f6 with SMTP id d2e1a72fcca58-842251b2157mr1706945b3a.0.1780101407598;
        Fri, 29 May 2026 17:36:47 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214b2acb7sm3705769b3a.13.2026.05.29.17.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 17:36:47 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] ata: pata_ep93xx: use unsigned long for data
Date: Fri, 29 May 2026 17:36:26 -0700
Message-ID: <20260530003627.42473-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260530003627.42473-1-rosenp@gmail.com>
References: <20260530003627.42473-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An int is being encoded as a void pointer but that breaks on 64-bit
systems as the type needs to match pointer size.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/pata_ep93xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index f7e87d6af264..1663dcd00a93 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -977,7 +977,7 @@ static int ep93xx_pata_probe(struct platform_device *pdev)
 
 		match = soc_device_match(ep93xx_soc_table);
 		if (match)
-			ap->udma_mask = (unsigned int) match->data;
+			ap->udma_mask = (unsigned long) match->data;
 		else
 			ap->udma_mask = ATA_UDMA2;
 	}
-- 
2.54.0

