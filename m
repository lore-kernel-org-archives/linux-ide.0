Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7881B283FF0;
	Wed,  9 Jul 2025 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068025; cv=none; b=fQ1sQkMwUwZDk26poKHq7yqUn+kzHeuDh2ehWGPfZ1gADCB6tU4mWE1cGpQ1gr7LPaVH9H+Smc4PLgSKCpfA/3aUs0hryfXBG8RajgxwnW5bo0LXQ8chzqGlVNSejuUo3dcBD930l0aaA1Qtf/VhUgp25pQWxqAbUL6TUqVz8OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068025; c=relaxed/simple;
	bh=QJlrR7trKt+k0DHfB1l8dMYaqpFemIJMJjy9PZjYhGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mJwy5Fq5q91ICtg2E8Kq5avOTaEyal03KQ0MoGGNSvIdjuhywib2F89sBdziSVsMoOCP9NUhLO67m88eS3NuIYGuucJx1qXKAoWdbKyj3vZu/XbHZmr+jsH0VcEcBsXfN+mopXzgxdfXb4gCPHrbu2+O2CUYB93MngcDePVEJxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRh/Pyeh; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRh/Pyeh"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5314b486207so1996732e0c.2;
        Wed, 09 Jul 2025 06:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752068022; x=1752672822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8p8Y7xoNQwZAIw4F7Fb5uJJ11m4t3+5eBeshCHSxAZc=;
        b=KRh/PyehWmz30JkkF3eP7KA+0F0azrF4lR+0lUV4un3JclqIvsjIx5ySw3bc92PInt
         qNgynzQ0aZNW9COWGJoko3CVhBTCS98s9OHuIimE9D3I7Q0o1LqxRa4gAa/yux4N6/G4
         dErG7LsBGUZW29XUhx3kZZFmKcgMuywhD/XMGmGun/1MMmDNbhYt+eFyoyswm2oxRDcO
         YsUznaxx4ZgpAveftX8eFmJSGm+q+mXH5mv5aqP7gwp99ba0I/lU6ROgR/LYCfoefm8m
         d1PIvC04AiSoWZ8M/QWnVWaAcEtiBmB7DOARVObEj8mRQUDhbp702+4eQzwt4KfK9baV
         xDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752068022; x=1752672822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8p8Y7xoNQwZAIw4F7Fb5uJJ11m4t3+5eBeshCHSxAZc=;
        b=pgtZfCPMW8NFwJvObHXlDzIICYBj9EcUevA8gst/mUsoXU4hOTwMAjV5uUJnGU0CVU
         q5h+UTLi95zceOmKTUeKy6J/T+/69C94KwO4TLJlNE5IXm2gWK+rDbTTeSPXaf7e9SHc
         NwXscjBHy4Pl8NTm/njU/map+LWdnumm6DcUICPMRSgbp/4DA7EyRrgHeyG8neqMQBKu
         ON1/lM6RqT89sACUpnaOGkfVTh/yacsOB4RphKpaLJMSqXFY9hUkNrVreseP4WOecUlX
         hdsStEWVE/RPVDpXlK95zX2d0cbcgoIiwFTifPgY6mjzK3kPwMS38z5acyRQHbshb7iw
         SVnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn1XBiXI1dqrnEVoAEk6aFz+coSTCfDJIXeN/W+zUENh3q633YXMQV/5CNvOaCw8jAT18ChV5XYvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlgzF+uMR5q0B6u1sTUDB/XJU5XrrOeoslRQ+ykr5xXNtS+o4x
	Z7lHf6nLjAIovitjQYro99IwQRpE+m3+IzGWLNcRsctOmfdJli9mq8vz
X-Gm-Gg: ASbGncvIuI2MdrlxmhBhvTul4EBNQ4zgyUUvD6KG6k0AUZb6+tk87ZqUr21VBgsTWHm
	aD3oypo+Mzv411Zj1iVdzMeqax5RxJhT7Lnuj0q8X7PnorNirglQPXLhkFA563dN7vRUCt2Hiq9
	F3IKGesIuGBvNT9/b9NNKyxbpaizA0nW7SlJ850P/fYxmuWop3oqgEm/FrBOGJ9eXXHuzJN09T2
	ETUdGqx+DhllzIcdKd0zPsW+IhfKKSxPb7JAB+7/4g/Jm21UliouniU2h7TmJzugIlSbJdsnbCJ
	S4r6SNtBy2Xj7MR2whYzRChxh6mmr4sl2P+nr8D3aElGyhzhC82ZTen8R9ti0tQKB7YATKmrZjt
	WroIaDVvMY7ognMRZrmc4NQqgAblPys+uvLP1j3c=
X-Google-Smtp-Source: AGHT+IHg9yphXawKg0kB+fw0hzH8WzGI686ZA2Hcr8oBVBE+CGD925dBJEbvwISlK1VPKVP3JKW+Qg==
X-Received: by 2002:a05:6122:510:b0:52f:47de:3700 with SMTP id 71dfb90a1353d-535d7367703mr1472242e0c.5.1752068022077;
        Wed, 09 Jul 2025 06:33:42 -0700 (PDT)
Received: from Ubuntu.. (syn-097-097-020-058.res.spectrum.com. [97.97.20.58])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-534790ed831sm2083240e0c.43.2025.07.09.06.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 06:33:41 -0700 (PDT)
From: Jonathan Velez <jonvelez12345@gmail.com>
To: dlemoal@kernel.org,
	cassel@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	shuah@kernel.org,
	Jonathan Velez <jonvelez12345@gmail.com>
Subject: [PATCH] ata: libata-transport: replace scnprintf with sysfs_emit for simple attributes
Date: Wed,  9 Jul 2025 13:33:30 +0000
Message-ID: <20250709133330.3546-1-jonvelez12345@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sprintf, snprintf, and scnprintf do not consider the PAGE_SIZE maximum
of the temporary buffer used for outputting sysfs content and they may
overrun the PAGE_SIZE buffer length.

To avoid output defects with the ATA transport class simple attributes,
use sysfs_emit instead of scnprintf().

This aligns with the sysfs guidance provided in
Documentation/filesystems/sysfs.rst.

Signed-off-by: Jonathan Velez <jonvelez12345@gmail.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index e898be49df6b..62415fe67a11 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -202,7 +202,7 @@ show_ata_port_##name(struct device *dev,				\
 {									\
 	struct ata_port *ap = transport_class_to_port(dev);		\
 									\
-	return scnprintf(buf, 20, format_string, cast ap->field);	\
+	return sysfs_emit(buf, format_string, cast ap->field);	        \
 }
 
 #define ata_port_simple_attr(field, name, format_string, type)		\
@@ -389,7 +389,7 @@ show_ata_dev_##field(struct device *dev,				\
 {									\
 	struct ata_device *ata_dev = transport_class_to_dev(dev);	\
 									\
-	return scnprintf(buf, 20, format_string, cast ata_dev->field);	\
+	return sysfs_emit(buf, format_string, cast ata_dev->field);	\
 }
 
 #define ata_dev_simple_attr(field, format_string, type)		\
-- 
2.43.0

