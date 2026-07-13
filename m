Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13C03845DC
	for <linux-ide@vger.kernel.org>; Mon, 13 Jul 2026 23:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783984907; cv=none; b=u21EC2Hl2WvF4jFGgwhg0TfsOe0l+XCO8dRIyP1OG4nkwCvyP3/jNFyc3lBAnzsmfplaboRiiqUUFHzMTMEHs9lq8TzBpHOFgPmycefIoP++IHd9x9YsSNmrUUC6t7JVAL1giRxfUJ4BlzomiMP9srraa5yom0n45FnR6xdOd58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783984907; c=relaxed/simple;
	bh=aHq2z5wJgiJJGtDTjASWD2AVN48KvlxybLZ9/CTioZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WnJ99uFjUd4YPveqO/e1pBorV6KrtXx65VAZaN3ANZ8YgDx8IAI4Kh1fVvW+o0Gy8/RVBxJntN75a0K00UvdfuDEX4ifobmg/k9xvTkryHUrccmCiP+WCH0Dj351ZtnA4LYCicp+8UdhadT8sCZkmtKrNbbrNzJuF+btrFA3Xqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggPklpUl; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggPklpUl"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-848882fdb18so102660b3a.0
        for <linux-ide@vger.kernel.org>; Mon, 13 Jul 2026 16:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783984905; x=1784589705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kmt8IO5aqVfL3mDoyy5CaJovs80770UZpxeBY54vlPs=;
        b=ggPklpUlFaK5T9pGM9+5iG/A57PUGBeZ0ASmJf0XRiV5lQNwEN9GEbV+v3E/ylYu11
         8PdhvPQhYlKV9RJWPMJge1N565Vx76ZuxuvoQ2UWh1d2/GLvMeR1X0/uHWONoT9qqFlH
         5N/uPuh9QJyA7j0tqHDFnIq7pC17/9g5QXE/SnA/XqKedFB7YzRSkmqy/1xisMQtbUJF
         nno8yrKc+/SqcxcIzyhYN0LmgR9ehGgJ3+RIUFX7FfQHVg7l48trttl0Po4dzacaXMVd
         uWXDsmGWesJ2UoN6cBjGOA5LeuJ2CqRyES6Ld2wmO9MVoSiGAa7kxbZ1BE6Byf0s1VVc
         k8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783984905; x=1784589705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kmt8IO5aqVfL3mDoyy5CaJovs80770UZpxeBY54vlPs=;
        b=DOLiLIqFChQZVZxEDBz2RSx7v4YEqSOqpkd2VyDsCJpScnwqKLv+J6wMMzwyqfZy2k
         ZnYdfX7Lr6W85iyZ8rRX+D6cKi55P3aadUztTi6ODLSsvIWiilTHriw1+x0HQhaAg6Uy
         Oji1L9H50d+iuN4/9vLTUrc3EzpVcYFXeh0xRm/vPgvP6HlQC943SMFa2h4M3GUm6q1R
         SR1Lv1osLYPqAvfkiZBwvwMFu3AcxHus+ceeIcvUDT+OfwHPHTpq5X2ViBgBJpQfsMfe
         T3EgagpvVdkeTj4MJZtrhq8lfa/Wu4p23NW4xJn2ntkKUr3ilHRPKPBUSxrIndPpqAg/
         t2YQ==
X-Gm-Message-State: AOJu0YyOtqMTSqWB1YP2YmI9WbZJZ4k1WvDDHeiJVSl9tktz1A5DWSs9
	S18E7SWTz31TT1pzCcQFO/YY8im9Co4fd1W+oXrtDqUiUq2G9rq3K8nDqjCpsQ==
X-Gm-Gg: AfdE7ckId0q3cOJhNooREElFtn4nhJiC+WtJ7bmkQMusv0gaDHhnI0SIKM71GYuu0vH
	QfwkcjwMUcwCr4NrSyZ3klJJk+o9gIxuK5NpjqedLYVyLE2Gb/3xT+1Ow10xYEgnWEwDvaRU8jz
	aJjFb/JIIii/SI6HQ0Qcx7cHefjCnaY9vuHO/1Dqi3pXEcfhz8vAO0U5Axs7E9An3s6oMc2D4NR
	WhI9vFiv5CESIk79ioqCNJB7EnIqeRUx8gg8Iffd6LmuG25siS3CqdV2DigOrYhcoo1C8lPLbnz
	MgMXQZRAlmBODsh6YMnRfMdAisfMrcIhln3h/yPF16Utfd/7In9RPTyrMyHxrmt5vt/ClPfgDMA
	vXifCczLx4hTCj//11aKHZ085v4dyqq8IL7GRNyAx4QgdlG8YTr8hhcmC/DUrhsp5TP/tJiRlMA
	3MotuV6BLLvWKRlnHkvAFYsuFhvXqopcq+j+eNus7pWr4TQheWe9fGFR15XfnLco+4KpCQkDq6w
	w6zvfJLj6P+oNdqFk3U0zrcFFcZ6T+3nC3RG47xxhZ1EGPZ95qDI4Ooz8inURpvsUx7KzWysOmY
X-Received: by 2002:a05:6a00:368b:b0:848:6dd5:f61 with SMTP id d2e1a72fcca58-8488971d44amr10074793b3a.44.1783984905296;
        Mon, 13 Jul 2026 16:21:45 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f7e9711sm476090b3a.50.2026.07.13.16.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 16:21:44 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCH] ata: pata_rb532_cf: use devm_platform_ioremap_resource()
Date: Mon, 13 Jul 2026 16:21:43 -0700
Message-ID: <20260713232143.1114497-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the open-coded platform_get_resource() plus devm_ioremap()
sequence with a single devm_platform_ioremap_resource() call, which folds
the resource lookup and mapping into one step and returns an ERR_PTR on
failure, checked with IS_ERR() and propagated via PTR_ERR(). Similar to
platform_get_irq(), it can return -EPROBE_DEFER so move it early.

The pata-rb532-cf platform device (arch/mips/rb532/devices.c) provides a
single IORESOURCE_MEM window at the DEV1BASE chip-select, distinct from
the other RB532 chip-selects, so the region reservation now performed by
devm_platform_ioremap_resource() introduces no conflict. The mapped size
is unchanged. Drop the redundant error message, as
devm_platform_ioremap_resource() already logs on failure.

Built for MIPS (rb532_defconfig) with LLVM=1;
drivers/ata/pata_rb532_cf.o compiles cleanly.

Assisted-by: opencode:hy3-free
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/pata_rb532_cf.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index fd81e75c9402..0144e597707e 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -103,16 +103,14 @@ static int rb532_pata_driver_probe(struct platform_device *pdev)
 {
 	int irq;
 	struct gpio_desc *gpiod;
-	struct resource *res;
 	struct ata_host *ah;
 	struct rb532_cf_info *info;
+	void __iomem *iobase;
 	int ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "no IOMEM resource found\n");
-		return -EINVAL;
-	}
+	iobase = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(iobase))
+		return PTR_ERR(iobase);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -139,11 +137,7 @@ static int rb532_pata_driver_probe(struct platform_device *pdev)
 	ah->private_data = info;
 	info->gpio_line = gpiod;
 	info->irq = irq;
-
-	info->iobase = devm_ioremap(&pdev->dev, res->start,
-				resource_size(res));
-	if (!info->iobase)
-		return -ENOMEM;
+	info->iobase = iobase;
 
 	rb532_pata_setup_ports(ah);
 
-- 
2.55.0

