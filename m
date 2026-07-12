Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0858E37F74A
	for <linux-ide@vger.kernel.org>; Sun, 12 Jul 2026 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783895501; cv=none; b=nk9nCghTlk0uTaMJXVrl7zj7JCa3J/WxAlBV+HvzMKqGrVjigfok+9rc/Ot5jwM36ryl41Tlu3vUG0y705g/ePvk3KO/dLKDP85VyQSBUzDrED1MYQ6OQ9fucOCU/YJp4HMidsHIBc4yLCkLiaFBho0XLmldZla3Ftd42X7xR0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783895501; c=relaxed/simple;
	bh=LXt3SYuSUio7uSOR4qDwHFu4zbwaPCwcwdRCeVDgLjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=malDQcMoOTMK973ZLUs43/rMKQadsMegNv+uL81zAmbCuMZar8F67yvJBL50/bZRsuLB2PpJoGpsJUM2feGakz12asumsvlmFH4RnHRIHxZbCTmFaaTgopxpwrLVCgTf8l9j+eXVFPuMZBJbBcU/zB+gpWe+5KXq5HNYIR+RElY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmvvmtVi; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmvvmtVi"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9e30214d8fso1715207a12.3
        for <linux-ide@vger.kernel.org>; Sun, 12 Jul 2026 15:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783895499; x=1784500299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fWsXzUDXlrgiyjY+yyba1ZrF/24VU/2TB0ngAcgYGHo=;
        b=UmvvmtVirPfitqUfRTjUEt1cNX9MvLMAoq0rSwDje2Zw1pGIc5kkZ618APtqJOvDhx
         sUXYJx9Zgrqliwk7nEUh/MqA93eDvl7tYNLr27ilhvyKuEc9uk3/oRj2D/1FRKqMNe4H
         t6Fno5OyxmFrJ4K7a4F4UgJPWk0W4+s017IFhwoALNYywbVqt/lW2q/xznG8iFTA6qgm
         hmDYnzgSXKW0JHe00z3HFbRd7Pfj+V3l7oSqhfD0h0Rvoj+9MXSlxTl6id7ziTl/YxVr
         2U5U64gjew0rIOt+0+MYkw2xm4xTXQyS6oS1atQKOIapPeCXSJw0puXQB/rQ4jIOED3u
         AkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783895499; x=1784500299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fWsXzUDXlrgiyjY+yyba1ZrF/24VU/2TB0ngAcgYGHo=;
        b=ZfILNCJ4RMpTbPqE+QWh9wO8ENoPInqO+Ypv+ofHDaJLxO1qPnizC+gcRMkv4e/xwi
         wn6oKKYLkXgxhlTKkRQUQFwGfqjO9fy7uBxnbCuCUY3JnUevJVuGcNJXUkrdzY/Frqvd
         gB8zJnKm+6+2r7X3jHxuQW92xbix0QR/5E91AGTV7m3Jvs5JWnH32qBdCyzvoVARZDGo
         ozPvlPWGef0Q/Iko3OdOwLaiB+aOcKvH36+EvUicbWpnkd0am2BYlwbqWudfry4xCUVI
         TL1JkaYWVEbyp0RRWPJ/ahFbyjfYkPCPls5ldqt406eMj1sYAnPwh4PLfoyQu4Jw0PH4
         +fgA==
X-Gm-Message-State: AOJu0YzRIgVY/YxDEbNwR3cnOgDeZ8mHIm+7mMBbu+R98gBfsa+gXsVX
	A84fw7zd/aK00s8EscMERDh1fUic6bsWMvAfVdYQzVq9B400Lp9/Q4fYBcARTA==
X-Gm-Gg: AfdE7cna62psFntLl4F2iIVWnhOzXoBqZvj/2X7amoILhYJ7OVcgTqEwiHkYJVTfvJ/
	Lgz/hEEhZscvJ2JqPnMdiCtrI4CMm1xhw6O6t3TzkGnto9blFOND9LdM9QOEq4CW4PY9SdoJUNR
	D93dBXCLz5eSj3FJFcsRsaJM09EMxKKyn2/vuX2d9SDZ2JfNCLP1tLAFFjAXdPCeDLFKCvTrL1m
	kSPDjRjatloYd6zd1/GI2w6ogXAE+bhx9etcpnw99+O44/TToFnPrHIrvysX+BVBxaPp+21nGcX
	P+3cwTiKiXp+3HKSLcWlcn1FVn80IOwsLv3feExnvHOybUHG+EFOm3j1bgUUFwqRjbmvTyycgRG
	mbvSHEdYGCcb0J5EdqDYUazhEgj2sCzOHDdSrHta7YNfucvJI08UP3w/8NqkM8wYnoZ0wo3o68s
	Ovfi3Wpg+iKvLpD78tbBl5QIxaxie1rxiXMMUWPDdCDG4tJ06WROnAjveKFNsnNaYwiAwhkAw03
	vvMAIQmDlVWJoHOSxTvp/iiuOuYHxhtj01glGmbu0cHZDq+OBNra9VHZbhT9sogSQ==
X-Received: by 2002:a05:6a21:b98:b0:3c1:c6e:9360 with SMTP id adf61e73a8af0-3c1104e16b2mr7715706637.32.1783895499400;
        Sun, 12 Jul 2026 15:31:39 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b987fc629sm11966044c88.0.2026.07.12.15.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 15:31:38 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ata: sata_mv: accept 1 or 2 resources in platform probe
Date: Sun, 12 Jul 2026 15:31:37 -0700
Message-ID: <20260712223137.1058531-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Board files in arch/arm/plat-orion, arch/arm/mach-dove,
arch/arm/mach-mv78xx0 and arch/arm/mach-orion5x still register the
"sata_mv" device with two resources (IORESOURCE_MEM plus IORESOURCE_IRQ).
Those devices are rejected with -EINVAL, so SATA no longer probes on
legacy Marvell Orion/Kirkwood-style boards.

Accept both 1 resource (DT, IRQ fetched via platform_get_irq()) and 2
resources (legacy, IRQ supplied as a second resource) so both probing
paths work.

Fixes: b3b2bec9646e ("ata: sata_mv: Fixes expected number of resources now IRQs are gone")
Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_mv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 0de4f9b8e811..d260f04e6384 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4027,7 +4027,7 @@ static int mv_platform_probe(struct platform_device *pdev)
 	/*
 	 * Simple resource validation ..
 	 */
-	if (unlikely(pdev->num_resources != 1)) {
+	if (unlikely(pdev->num_resources != 1 && pdev->num_resources != 2)) {
 		dev_err(&pdev->dev, "invalid number of resources\n");
 		return -EINVAL;
 	}
-- 
2.55.0

