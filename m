Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EDB1465AE;
	Fri,  4 Apr 2025 06:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743747291; cv=none; b=kt6VZXlCqwsNsdCJpRQ1+ZDksL8Ps1l4cJLQORW/rBM4hzrrp1fJDqmqgPL5PUbBQgdv1JJFI+DJytapbY45U6wScBpK+FqVA+vG0mHJmSSHNVKmYJkHIbnQ4Qmb5ICbVqdWAV5/FjHrOjCyvzS5PJf6Vkfl9QRjHAhS3AYuk+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743747291; c=relaxed/simple;
	bh=Q+X2nc6nomcFw4vX18B8NcWcC56hgCUDWerNGnkpS3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cyb9FmGpKbq4UzY1A6DNKEfAt+DGHlmFeOJYlIm7vi1eCbuj7IGuGCxYtEoUOy9gHdfmv2yjqFVM+rPDNR8LzVce+Nxbh7AWVwy+lNZ7rwQ9sDW51UbrWoUJ6XJSEcruKtk5A4IBXGPvabfET3UWxTrrZGJio1tMfYvpuLoezRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYLKwGkT; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYLKwGkT"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-736c3e7b390so1584302b3a.2;
        Thu, 03 Apr 2025 23:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743747289; x=1744352089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wHSEINwNnkoIONDsN3NFU6pUQ/aEiqLdUv7c1cE3AE=;
        b=XYLKwGkTt8U70e5vwSgwMvO9NdseE3D8b5UpY53la4YtCGl/VOyTuM06o3LkSgVsv2
         rrFHpet0xBhdZopJHOQWlJELHs3DJ2MzczdFkhTVal1g9APoA3oZkdmHRFSgYjmgbACz
         c8nzmiK8DsJ6khVaiqtH5T+3j/y9m2evIhdDBU+cRxvpyzejFvnqKODPmthQ5SICazzP
         bZWcX1bBLs+zE7ju/y+B4ChRd+ckphrVm+/dbmRPPHT1YCtyvQk7Tb0XXPbftFrqON+y
         oEoPFDtTsgz9AmFKyTBlOpDrZrJ+tRUU8a+Sdaady40X1rxrqXk9k5Gacqj+48UE7YUj
         bTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743747289; x=1744352089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wHSEINwNnkoIONDsN3NFU6pUQ/aEiqLdUv7c1cE3AE=;
        b=o4Sk3ywO6HZyxYxViNzQxN5+Cf+Mw0oPYMmEiGIzZ+jJPZfrPwmX3AvlB+wRIc1GpH
         jZOqYXAWH2P77ZDrSnuY/P56hQO8r+/+WpCifvCHd/0M8u0siZIcw6LziNfABaw8Ih9H
         zy7Kwfb1pTT/GKhWN+y32oYTKyMn1HY0NmAnIcL/uQGgkXKNtxXCqs9dKdT9RncRoYZe
         3M3AZ+oe+Qn7aCNc9XONn9cUaKKQ8vVVCpSvczz/K1GXFqfaqG4j9T1uXzt+tLXt5K/0
         wKsOy8D1QQ0/ebKbpze7DUgxyrc27Ttbmh5d3otUBqHirGBooxiS/78zUlCg+s0P+XqM
         mU1g==
X-Forwarded-Encrypted: i=1; AJvYcCVgDGKFUn8BYmnQpfp26S2KPLh0WU67Gws0UFCUwi301BOt5+82QFYO5UqcheC/SxZmClRf50fImILVYS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWItagoUsUMZiZTRkpa+aKy7Wad+MmTXERiegvURUXX0ErbCzq
	0KEDNyisgjQKJYWOGxHdpLXk/L0eKn/xqOM8GzEgSU92rAJyJv7X
X-Gm-Gg: ASbGnctv57DJgSeYRQ0cq5HCMumNi9EjdDQ8WDbA5dSO5Y4FAVJ2ytiNtcDwo35l3Gf
	L2Sr6jiXVFytd4FOir03KHZYMX9S89WhLMJw7Pgw91uFmm21wfdZvAO5USL+uCxbR1z9AEpOzsE
	wbQTEu7fCWmIjMNkr4zEE9PzzW31biMwobMO1J5goNDDnTLq7LvB+BMuzfJdT0lkR5zSmv0PXk3
	dU6Agw6NkjusErmRCxiDvy6Qv7OdyzjJA+nGRVKT50skG+qnHGEtWqmOHvJGad5E7TIpUP94dwQ
	XSnrx6ngOGSZmH5+zrBi7ZWmbrP5UqzEaYTkK2N9xQ5zpg/mXoV3YaSwVYetnXvRqwLXUw==
X-Google-Smtp-Source: AGHT+IHK6KAghY4r6JYoithJV2ZGL4jKogLKnmv2gszlamlSnbrI1gSpcnkAdg54t7RMxDURdTLUog==
X-Received: by 2002:a05:6a00:2e0f:b0:736:3d7c:2368 with SMTP id d2e1a72fcca58-739e6ff1d17mr1953597b3a.7.1743747289156;
        Thu, 03 Apr 2025 23:14:49 -0700 (PDT)
Received: from henry.localdomain ([223.72.104.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0b41dfsm2602210b3a.136.2025.04.03.23.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 23:14:48 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: dlemoal@kernel.org,
	cassel@kernel.org
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v2] ata: pata_pxa: Fix potential NULL pointer dereference in pxa_ata_probe()
Date: Fri,  4 Apr 2025 14:14:38 +0800
Message-Id: <20250404061438.67557-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d16bdd67-5060-4bb1-991b-6c82f3936ace@kernel.org>
References: <d16bdd67-5060-4bb1-991b-6c82f3936ace@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_ioremap() returns NULL on error. Currently, pxa_ata_probe() does
not check for this case, which can result in a NULL pointer dereference.

Add NULL check after devm_ioremap() to prevent this issue.

Fixes: 2dc6c6f15da9 ("[ARM] pata_pxa: DMA-capable PATA driver")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
V1 -> V2: Correct commit message and keep a blank line after check.

 drivers/ata/pata_pxa.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index 434f380114af..03dbaf4a13a7 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -223,10 +223,16 @@ static int pxa_ata_probe(struct platform_device *pdev)
 
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
+	if (!ap->ioaddr.bmdma_addr)
+		return -ENOMEM;
 
 	/*
 	 * Adjust register offsets
-- 
2.34.1

