Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051622DB789
	for <linux-ide@vger.kernel.org>; Sun, 10 May 2026 19:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778442387; cv=none; b=NIWkaBltT/8RZfN36fNsDCFPxpPfKpiX6GUhhHqRuc/JPTonq9UK3VXJXIAAepd9JBhs+eJXQXHVzEtRLPrxPtS5dWhlDiwohX1SlkWzJ33xKr7il6heUghMy2N1O9zQYS0XI8rwEjQzzoynsQLNP3C4nNLqnDgymQ0VfcrAoXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778442387; c=relaxed/simple;
	bh=dx7CTCdfgI9/VwOubrKjgKAV7j3wBdm3ATenpfZhl1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nr4Zr71q3ri1F8uXWOR170op0CJUpS96rKrQh6LipiwXmnVrReJHeFwBiltVbxBvpXzyuCo6+gxqQXV2snmFu6qR4kMMvz8v1FQKEHibWR/bXRXI9OZqljf7fSBJzU/2MVw2B1pPuo0A8GgcT+lbncibjIBrOVdtNkLtu6OjywU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IT1DJnXa; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IT1DJnXa"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c8016d642b2so2069188a12.0
        for <linux-ide@vger.kernel.org>; Sun, 10 May 2026 12:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778442385; x=1779047185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KNV1JSHPdfX4ad5c25kdBdSP0iYBWYMWxSLFq4BW90Y=;
        b=IT1DJnXa8yWVENT0r3TgfTobsBRhDfyaoex0MMODU4U1hdM0n1urCGKmvJ/tcJgwo+
         WRbhgxq0aMnRVewr1qgTgaIEvpgVkdW3nuiePvKwjR7NYShH923VICo0IDgcF2Tym4Ab
         yw3tBVm271uuFtd6tW3yeZ4q4+/LBXJRK2j/v+m5EQOX3R+ofJSUkq6/icwsjvtnVXf7
         OHFaLgMazrqHHCFBFgMNsbPhfOFVOULcKR1LdwtXD4Y15GHWLhgtumO6AY9KxquUItrs
         VHEwW/V1/caK8LPPmsmCPFmolnnnZLwYMqajfS3wHMeOBxawDo00wMAI/Dx47/flFk66
         To6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778442385; x=1779047185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNV1JSHPdfX4ad5c25kdBdSP0iYBWYMWxSLFq4BW90Y=;
        b=se8MAY/0KM0QRyL9qmtEijgYwSXBk+RSczj1KqfvcEdxsaNDDyJ1FgohFV/lsTiJHk
         cl8EQFk+mqsa18wHXJxYWzhz6NegB+MWKhTmqgh6oCWzmd8uWumum7xBlQ9DGAS2x5rj
         YJmha5f6bqb4pTV/XgO5NBks3jDZ81odlU5ttFYg4iEvNLh1VKbI92soFaBR5iO8oPaM
         kmrlvZ2UK0HwxIdAiJfpP4ZgxWmwplo1VwL4hpuF5HAage+ehvyw/FR52sEDxv0mfWti
         U0hAFc07NZ/sy/m72KSpdxPuWeSFEGoxGnfe/uu/T0GuwaHbNfdEQUQW+SZH/URO4WtK
         3WPQ==
X-Gm-Message-State: AOJu0YwBebqv3kbnbV2Hded6kojHzF1DzO0b4XjcVcMHoDI54TYVwQ+q
	Q11UzUSWDgKCWNQxxJIOZ7rQfvWIX+bC6VMiLwDsbbN3Z6HJi4QH7Un+HLM8wg==
X-Gm-Gg: Acq92OEQs7AHtYR+M2ejn80DvNGazvt9fuJbXVhCTu0ncTspCyj7Q3xhZ3LpZU2ZGqJ
	ZXmhRFVPaE0+GebMddBDmeTwYKbCWrnhqydePYLqj2hGxh2dTgMMqhJqvqKDFxctVBXbTYJ42kv
	30YdYSxw0RntjbWWmN/6fasxQ8uefDZpyK7ZGq5jxEk5XuqvU87JBPKV1NlS71Mwg0j+5uaPh5l
	v4lhpNJILQM4jTUeXFbX6BNQkC/sI5V0riPkZWDAw0SI4Jw72QaAloM0sq6rhOZt8TsI8DIWjN6
	RKm5HNSqvCz1dL1303uKwDEzw43K/ZWzaOZQ7hRtlR2timhOvZmy/seEv6z+cY47kC5XZpzJNt4
	zrzELGe4Uj9ydrCIfgVqyUcpf+ckJ+avYNx703MnutpSd7TT3khXTiXyFAoyrEPmEkzBUX6F88a
	sPPN9qRMhSD6Es0xl7hOsy4pOCxhfgA22baBJy4koGcvDMJ9+f8zA8O+Of/5G87PpPhZOnEQWpw
	TYvZiZFbGrv7CMvu6chmC2OJznmRAKWwlQ=
X-Received: by 2002:a17:902:cf0e:b0:2ba:61dd:b41a with SMTP id d9443c01a7336-2babbcf5cc0mr137031195ad.0.1778442384777;
        Sun, 10 May 2026 12:46:24 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e358b2sm77026115ad.54.2026.05.10.12.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 12:46:24 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Viresh Kumar <vireshk@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ata: pata_arasan_cf: simplify ioremap
Date: Sun, 10 May 2026 12:46:07 -0700
Message-ID: <20260510194607.9567-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_platform_get_and_ioremap_resource() to combine
platform_get_resource, request_mem_region, and ioremap.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/pata_arasan_cf.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index b1e281b64f57..d5cb88ae2b76 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -803,16 +803,6 @@ static int arasan_cf_probe(struct platform_device *pdev)
 	irq_handler_t irq_handler = NULL;
 	int ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EINVAL;
-
-	if (!devm_request_mem_region(&pdev->dev, res->start, resource_size(res),
-				DRIVER_NAME)) {
-		dev_warn(&pdev->dev, "Failed to get memory region resource\n");
-		return -ENOENT;
-	}
-
 	acdev = devm_kzalloc(&pdev->dev, sizeof(*acdev), GFP_KERNEL);
 	if (!acdev)
 		return -ENOMEM;
@@ -836,14 +826,14 @@ static int arasan_cf_probe(struct platform_device *pdev)
 		quirk |= CF_BROKEN_MWDMA | CF_BROKEN_UDMA;
 	}
 
-	acdev->pbase = res->start;
-	acdev->vbase = devm_ioremap(&pdev->dev, res->start,
-			resource_size(res));
-	if (!acdev->vbase) {
+	acdev->vbase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(acdev->vbase)) {
 		dev_warn(&pdev->dev, "ioremap fail\n");
-		return -ENOMEM;
+		return PTR_ERR(acdev->vbase);
 	}
 
+	acdev->pbase = res->start;
+
 	acdev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(acdev->clk)) {
 		dev_warn(&pdev->dev, "Clock not found\n");
-- 
2.54.0

