Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF032E339D;
	Thu,  3 Apr 2025 03:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743651930; cv=none; b=MVxAlhXPh+2RoEPrCQn5wwZg2+YBkILrJToQw4imb9Xy5vt3OYcBv1wEuKeYzqmtopqifzgkti6MUEIIY80cx9at4akUJ40MZ6k1BeEBMzrLGsp452gYhS3Ny0O8W5gCGEgbKPjhnIG0/XJVhQsZFMErY5mk9SY8LgBJ3Kuy8mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743651930; c=relaxed/simple;
	bh=wzGWIf2FB1q0DOg13NZ39UTzns9D7dBSNr9vPGyZCb0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VMu1sJHI/OAtFtMKWgzyhtEPO8CPY0qHOfSrM6U/jibIbI0igw4dn/STaHUksHMxBNJAhwYreJ40zRVWXotFt6Sn1EJ1HJRzz4YcH0oxJtSDMZoF9QDX24JrjI8Ae7CG50JgMZaYq6Hy6MPsiC2w5DwRuJXgVxHGNIBHv+gPPqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYfTfa7P; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYfTfa7P"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-22928d629faso4520425ad.3;
        Wed, 02 Apr 2025 20:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743651928; x=1744256728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tw2FNjZg97zEj3C90ptNSlwRVtq6qjFq0b/HRBNiad4=;
        b=UYfTfa7PSE6aTW/3xEGtePQjbSTNu3WFOx5nZvIWAXic2z4rENdGBLSoOi+06yant4
         iw048VzLXx2GFTDKOiA6heXQuY9m6qQpuLmbCnGKf9jYLkkQQJu/rMfBv1ngE4VGos/D
         tTfED3obb4S6NB+piynIgzn66j+gMYPDuPyirzupefJOTfNcRCFbqI0p62WnHh2E6mYP
         me+O5vUhSykCYnyYybI7E+qKs3QSBYDy3JWqTzUODsmhf5W+YRlxK+Knq3J1fB3Euj9J
         vH5d3ikCLtGBryHgD/0aMORdWCWgPiBcsezee+jMigv8dfJUqSJiyMlQwriQqxPiK0h0
         jpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743651928; x=1744256728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tw2FNjZg97zEj3C90ptNSlwRVtq6qjFq0b/HRBNiad4=;
        b=fykJNLJVZSuWFW8H8ndqElHWkCdkds8dCQZym7CZzfjCjv5jIXxEA+9SHzQ53m9879
         J8HAOYFG4gUhd6CrKBOnst7DbohS2yOdMUja8kNu7WllyBeAreHxmwNEqKA05zPX23NU
         1mgxnM26cxxevMmqkyuzZ2VRsAX056Ie9b2pOItLswZTK+wbRRmCSnirP7B8eGpMlEqR
         g2ZgeeUrklpTFcQ7ISpDLptJFsW8iIbppNGvSClTJD8fXMUeZL0m0X9rF20MzS2F/gKP
         d9TeL07a5bN+60qK43QONGel17laqWVzH2BIAsuElDLoXDBU487L3pgcH4nlQ/ZRoXF6
         yOEg==
X-Forwarded-Encrypted: i=1; AJvYcCUZWzuG5s0n6Mm3XT9PmbnhdMBDqp972X/eL2JW5HeWjVWjKCt+q12awQ6ga1MJjoh53W+ygYOSQ8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhaWYoKxW3Cu/H6dHacOZ4wHO0ww8haz6YLfVmeGHbf70oqqQ5
	Nh2EuvI8hnig6tV51YFXaaah9Qt75vGjC1CvalgWVQkJX+hw0Um2
X-Gm-Gg: ASbGncueZ2sCuKQm+WxaJ/Apd7Ed0bOrVC/fgUDwIwDqU7qlmP7X6feTW7SJ99bSEM2
	043ZF1ChGZmu44C3AW7xVtLyDR54ON+L7ZXA8WxG2zewTqf3EtouVJQPydvgrceUvlqvvzrvSH7
	2hmtFVZqYoDe6qWHV2S9+vwn2cJpj2cTTBHvajmXPD2gXdK4MtL3yD6CfWR/V5wjnkQgusyZQlh
	XKVJgOIiWKG7Dzuik47mfm+yoVO7wrWcuG5cfzs5MX+uyPqAncGmkG1GWInA9KBZNQS6MAg1WUM
	wPypmaHYiEYlKfC+cSI0vCdsa07bNUIj2d4cKtb3F1Yy/2b9T7SiCNkdzh4poU4qyNCHXiM=
X-Google-Smtp-Source: AGHT+IEsZviSPWU5erAdmB+yYTEcid7r7jqoBDS4VRoer2qsYY99qTObr9INv6/B7nY2jDRez/iJ4Q==
X-Received: by 2002:a17:903:19ef:b0:223:33cb:335f with SMTP id d9443c01a7336-2292f9493e3mr300357035ad.3.1743651928403;
        Wed, 02 Apr 2025 20:45:28 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ada60sm4037155ad.3.2025.04.02.20.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 20:45:27 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: dlemoal@kernel.org,
	cassel@kernel.org,
	linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v1] [ARM] pata_pxa: Fix null-ptr-deref in pxa_ata_probe()
Date: Thu,  3 Apr 2025 11:45:20 +0800
Message-Id: <20250403034520.59597-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_ioremap() returns NULL on error. Currently, pxa_ata_probe() does
not check for this case, which results in a NULL pointer dereference.

Add NULL check after devm_ioremap() to prevent this issue.

Fixes: 2dc6c6f15da9 ("[ARM] pata_pxa: DMA-capable PATA driver")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/ata/pata_pxa.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index 434f380114af..cc76290a3b1a 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -223,11 +223,16 @@ static int pxa_ata_probe(struct platform_device *pdev)
 
 	ap->ioaddr.cmd_addr	= devm_ioremap(&pdev->dev, cmd_res->start,
 						resource_size(cmd_res));
+	if (!ap->ioaddr.cmd_addr)
+		return -ENOMEM;
 	ap->ioaddr.ctl_addr	= devm_ioremap(&pdev->dev, ctl_res->start,
 						resource_size(ctl_res));
+	if (!ap->ioaddr.ctl_addr)
+		return -ENOMEM;
 	ap->ioaddr.bmdma_addr	= devm_ioremap(&pdev->dev, dma_res->start,
 						resource_size(dma_res));
-
+	if (!ap->ioaddr.bmdma_addr)
+		return -ENOMEM;
 	/*
 	 * Adjust register offsets
 	 */
-- 
2.34.1

