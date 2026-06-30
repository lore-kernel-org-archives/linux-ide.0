Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB21DED5C
	for <linux-ide@vger.kernel.org>; Tue, 30 Jun 2026 20:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851053; cv=none; b=sR1p2sLAoHQ7WmrKYZSBWQBDExg/2inOF7VZlOl6kGQ5envh+R36gDgmENHjoey9l8+KP6z4AR8dcGTY93WUBHN/jXq3y1NO1wBCuF4GX/KdbjxnFyA7nNNjcBIPRjnDZjrRRRiCrE8iT67RtsHBG09dtDbq7M8V/ADHqacIRgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851053; c=relaxed/simple;
	bh=nUI5TbDWTweGekNOjKAYQGyyTp7oUDvk6+QBMM+0b+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulGdieJs3W3pGbnsDRJIIekrcSjI/w4YNGwiFIVgOyqswShbQ6qgiT9GV/Ff0nFreK5URKq2Lyx/vL/eujnXEkXal+iDtdMDq9XGhvD8Um9/5UOd3/z+qy/8GUkZ/oc92Rg+a4NL8M2AOn0d0qjYccWM6Bbwi7llAWEmslK4rRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByO4IsAB; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByO4IsAB"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c9c1779fc8so12641535ad.3
        for <linux-ide@vger.kernel.org>; Tue, 30 Jun 2026 13:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782851051; x=1783455851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhuCqNnq3rKv0ga2RMxQC7IRM/PJTZC3NOqkYu05+Fc=;
        b=ByO4IsABLTY27NkD3ldLPGwpNLlICV0f1SoArDhpJWxWxilSg+tHPmH2FF6tA+QmdX
         1vVo+4aBHapWJvJynvGBbtzxxF0Hj6Xt5RILLaOaBwLHj3VOczxIwPDY8EWQ/b2CupTj
         gt3qAcX50bYk1vkpJFWhPN4LlMiQKtbDt/pHFDyKraqbG0e9JGMSvc8h1kjU/CHRiIU+
         hpjjslU3pzZUsUotFvgExPRg10iiw7lWfDeEd/m0vZJqkmpSe4DkhaN2LPWhPjK8NPJ8
         L9BMdxkxtub/ZgOyoxAHlihp114y2DAsZ0seCfqOJCgGID07Ggj9lWRgdWc926IHevvj
         SUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782851051; x=1783455851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zhuCqNnq3rKv0ga2RMxQC7IRM/PJTZC3NOqkYu05+Fc=;
        b=CV6lNOK7wTzezn/nm/llsKore1eXoNXHML2KhzxP873GthcXJDdbeAOTo1q6h/uErH
         wNb6/D9h19FW2+vlwyFxC4B8xRdUsW1+eR/1hjyQhBUKMIDggGRDGgCkEZAMLn4ukwRP
         QIbXKYvjs5JUqWWpSqeJrA5wmS/1trDPkTsWRR55S4p9x7hV2XXfqKBCimjZbvqJe/sC
         tiLrm3KZQc6c3okvmnpJouCzkW7pM8pJKxz0Lq7EK6OWN8I6fD3j8UmZttxHZnPHwVjH
         XKKq3z4V8Sf1noOkGoOuqo2f4bAR71tBuWd1snNFZ7rBIg2jUWgJkQTAU4Y+cIQ6rfry
         ZMKw==
X-Gm-Message-State: AOJu0Yyyj/liSvbvl5b35LSejnXNZKoQUzbno4+u5lUgCSh5X29eeUxo
	cJOennI4skpC4nnwKqMYaEC0DN6AHLaUJUwtewerBrDD7KCxz9LgxfCs6rcwhYQC
X-Gm-Gg: AfdE7cmYJYwYFxFhF+TStvg7SlwS8t9EjPL+Lhk+K/fOe3ioAANv0XBeGrYcfnDpPhY
	uMhSo3XbOBkIqXG9IKASty//dPmKDtV37dpx+p1HLKtvUmoQ8oN3BiKi3cplU3NFOe5PpQaOVdd
	l80m9jkOTJ14afKqY9neGlFgPKaksyrKY4QvV9FI15pV3YZ7RxRyoPPeRN2kXNa9Pbv4RyjCpsZ
	ycWr10hDO/1WaaD5cy322puRY1AJHbdsddhV0s8z66B0ZT4L+8wS4uaY232wZNw8NGGkDmGwkHE
	EGmuRTO3yiEdNfTHn0NOq1Q/m0BaGZ/4IEZVFWEhXjAoLwJgNfgzvBowbnkZDpZZXnbRioRusd0
	o1EfYACZjyO5zZBBHkjNo9cusbgpaiZsu4CtH/yccZEAzP0dSNZ0dZ1E1+Qrdc52jSdgty7PBOD
	OCAbUDXeVFEMW1MVfUH5VXUt0PD4IwEfh5qIOKgowc+ZGAE9+N6urvgjDM+Bp622S3Jy5O8g6Ll
	5yOqQ+uMA==
X-Received: by 2002:a17:902:f788:b0:2c8:1c2d:b9c6 with SMTP id d9443c01a7336-2ca2e715005mr41938395ad.22.1782851051202;
        Tue, 30 Jun 2026 13:24:11 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca3828c2e8sm20520525ad.43.2026.06.30.13.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 13:24:10 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/5] ata: sata_dwc_460ex: use device_property_present()
Date: Tue, 30 Jun 2026 13:24:03 -0700
Message-ID: <20260630202407.233964-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260630202407.233964-1-rosenp@gmail.com>
References: <20260630202407.233964-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no need to use np here when dev is enough. Follows the similar
pattern elsewhere where of APIs are replaced with device ones,
especially when using platform_device.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_dwc_460ex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 4fc22ce4bd9a..2bcb3ac5ae21 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1180,7 +1180,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	}
 
 #ifdef CONFIG_SATA_DWC_OLD_DMA
-	if (!of_property_present(np, "dmas")) {
+	if (!device_property_present(dev, "dmas")) {
 		err = sata_dwc_dma_init_old(ofdev, hsdev);
 		if (err)
 			return err;
-- 
2.55.0

