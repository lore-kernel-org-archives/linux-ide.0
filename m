Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804952;
	b=jfsOHsLC7qpACOsTAuNc6JNlKZcGnSZj9hVxAxxcEVkLMBpGV0JK7DT1NgzxFwrhLA0m
	 y8o+TIx4SYqlL7EF/EvyPbNaL/Wpa7BbCbDQSR1KhNnDTDeDWzT5u3cLKOapcft5Wqel2
	 qwILUEIQzALgMsPVFprgeZoW+jLpEGz5qmIptVg9i6PCyd0w2PtLINLR3YAc3/JajOvTA
	 bigGvUqxHhWHaGk9H/S0Sg8Lxx1AsOt51F4yIItTFP/7QHRK3ntqYjLTDpFvomh8uZeA5
	 pvWGCesNGlVl1dUSarXFj8Nqj7ZTGWuzA6YjkrZnKfS/g4NYlzpqnIvaRA3LJB+JTug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804952;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vWsF7/sGRnQcNHhIssCpGPPEwDUF/AFXvsQJ0lFQQ60=;
	b=Q2lsLtVlJOlHenWgBtsCiD9mbgc2jCZF+i9W+zehbbfxehJl2EkEW6MSM2p7qV5IJPlt
	 ruFRd6YWyoScfG1NMd82Vk+H+SzLo2f9iY99nW4TnQs5rqnB+NHA26AwLj4A5keIq+Kt8
	 UJZnUyomNd36Dcw8HDF/faewBOo8Zqs/+b7E9Tg4p5bYczBjg39B9aQc94my5K5T0JffK
	 5T+pOIn4pwms/7bDetuUUWkUdChXpcy9z1XIuD1bGHD8aZ6guwTFW/INBk702f9i70ZAR
	 5n9YxkGdZpn2JurWX9cuflWDlWhVcL85Ki7jfFf5zLP4Bi/bjghlE187KfXTB7T5pOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WSpsqNGR;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90961606A33E
	for <linux-ide@vger.kernel.org>; Fri, 27 Nov 2026 18:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90961606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WSpsqNGR
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc758830601so6196397a12.2
        for <linux-ide@vger.kernel.org>; Fri, 27 Nov 2026 10:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795804952; x=1796409752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vWsF7/sGRnQcNHhIssCpGPPEwDUF/AFXvsQJ0lFQQ60=;
        b=WSpsqNGRs44xK3Qs/oFYox+a1jTv0CydTsHh+xqeHY/b5X5TLsuiZVePyFrd6XZHQO
         oOq6jmtEcLbFVp1Co2JsOnDs8ikB7LCeVQwgzqaWninE/yOJJk42h4EQ444NdVDkMjdF
         LG5wklvV8K3KtjIc4Epb/8NscMJv73T59YwqXLc2pVE9V52aWYIm7Rsy3snIx9xQhfd2
         0WvoKmPaCpt3nohcAgpUSllwcdTYfCW1k26op1bMCr09yvqnazTb75aAEVpLbKg2+C2h
         ymofPkK8HSWhesXBO6qE6sIu6Ae/IDO0xRPPQ0JdLDo1+EEImz+jhq9EGOy3m+EmTsNB
         ieWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795804952; x=1796409752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vWsF7/sGRnQcNHhIssCpGPPEwDUF/AFXvsQJ0lFQQ60=;
        b=bfr0VRPTO4T8vnufyswU7GKUWcANNa9mnEzKYX1Xge/Gdy4NnwVSSfuVWkQdmn4LT2
         c2bTs/ivANKaZEsL5VM1BHaadEs1jU0avH2e9RAhLls7q2Av1iShbW+eNuCa3fGZUNxX
         h1W2YvOcfty0tW84L97+68MpPrtJGhV34xX+riF5dYLEIhoRsZDb7fZiBfFxx4untxeO
         qpPKyDXs/3LYD1s4fAyzozsgVg6W1YaIWHx7deJNqtOTr5qBefSeio3aH1mAoKYMJ8Oz
         mpiMvjOhFsdGc33doL5jfT16a9jcdY1Ts1JGNWHLfj2nBczGrGw0sm8yUDcfx4qx31jn
         afYw==
X-Forwarded-Encrypted: i=1; AL+hErHJqUOSha6hNszmg84LImq+hB902tRk3oIAm4fcWZM13Frpe2hoTMJGN0aYMu492+rK7mtTSzHGJ+Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z+alatercOh7yclcoZi+jWO7eWVR4qGYRJNCXvsZ1+p9B1J+sGL
	pV0YTQxNdDQWRaJKd0fYAND4dTn0OKaPeK8aiA7pDtRamEL01tmrWLDr
X-Gm-Gg: AZFdTZcKBRJFADgGEuitNnhjnFSX+OrPZNUBMvKnDlVSrlNpBCHqyDVDl2FXCO8LyC1
	mev+TWxhTd20LhIWpTi+80dY+5SJknkNv8I+LBsJspGTyHpUPChS4Nagyz/oT6wZ+/+/N1y+FoU
	zBcT47axEPpRlNmCvLO/FuFG4KZLJzW7aSqc8J+IB8HsfGrU6O9CWAAK5pT4nVFi3d0M+6HIxMf
	22sVkho35XiNqi5F5VNO1Q+ncIqr4uzjG4jg1aSCktOg8/XZbnAoiJC6QNb2WGbDhFfETOQZ1PJ
	TP5frmHACzCtzESjg1mCHcNtqL1x4gH2x0DV9hzMzzpsX5g9Gm/Hin8kQ+/ULmqSQCSbpbtaXa7
	a4mhwME/PWs9lAzWFh/sbZ/YBjyrlE9EQ+M/8tCw7SnEJvOwZUXC+5x76L+pzU8eJCC7iTY7pSo
	bLWWC9qW7qP7HYeyVRhUvIdOMd2WDE/2ChIBwEflg9qHPw1krQBVeeSlLYuROnENWpykraweapf
	gj+tFK91nDm8BJ8S6Zv8jL7KjrP8znmL/Ch8tNk6SCbyBK8C4CmbSQEP7bVE5iBpcimlPsugq0R
	y90YhnFFiiI7cuhpu+NTgKnsV6Jxf7jMvDXq8RGtrA47FI/y5/8=
X-Received: by 2002:a17:90b:248f:b0:3b4:2394:7cb8 with SMTP id 98e67ed59e1d1-3b423947e12mr18091674a91.48.1795804951932;
        Fri, 27 Nov 2026 10:42:31 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4dfbe54a2sm19149071a91.17.2026.11.27.10.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 10:42:31 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: artem122novak@gmail.com
Cc: cassel@kernel.org,
	dlemoal@kernel.org,
	linusw@kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vireshk@kernel.org
Subject: [PATCH v5 1/4] ata: pata_arasan_cf: add missing newline to warning
Date: Fri, 27 Nov 2026 12:42:25 -0600
Message-ID: <20261127184228.185827-2-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127184228.185827-1-artem122novak@gmail.com>
References: <20261127181619.183139-1-artem122novak@gmail.com>
 <20261127184228.185827-1-artem122novak@gmail.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Terminate the clock-rate failure warning with a newline so that
subsequent kernel messages are properly separated.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/pata_arasan_cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index 5e02d227ddda..61977f0ed84c 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -318,7 +318,7 @@ static int cf_init(struct arasan_cf_dev *acdev)
 
 	ret = clk_set_rate(acdev->clk, 166000000);
 	if (ret) {
-		dev_warn(acdev->host->dev, "clock set rate failed");
+		dev_warn(acdev->host->dev, "clock set rate failed\n");
 		clk_disable_unprepare(acdev->clk);
 		return ret;
 	}
-- 
2.56.1

