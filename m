Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A134377EAF
	for <linux-ide@vger.kernel.org>; Wed,  3 Jun 2026 19:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780514447; cv=none; b=dL72zHx3z3dAEA+eKa/cvbbx+97RACZO+jifOLWiNV+/UO3fiOWGPTdWF1miy3EpgF/iweQ88JLIe6fHZcHxC95PcKIzOEEstWkXxX1mlMQC5380azWVi9xjlYltGNFjtoVMxyqqLwLlhE+IaOw7YId1jtyd3MZWVwQx2J1oVDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780514447; c=relaxed/simple;
	bh=ijmaX6yjn0sjj+ZH2BwxSTAcQxqvHChiB2fGgdIuH1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OeJlsXYTUBQOPneA1qPZSjDnj3ufzCWR07aP9H1qnb+XmHvrl7G5CuEiRy5MyvSBdXCKVcaP4tJWNB+FVTd2mgRAU3PKhrHKz+pOjQdqHqhjsgmLe+cnqllS9gsmWzvB7Q/nsFZZQZc+DSRLwoxJVphFZ2eF6ulkJchfJFcLyRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFXnnSjs; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFXnnSjs"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c0c20f0c0aso29389035ad.0
        for <linux-ide@vger.kernel.org>; Wed, 03 Jun 2026 12:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780514446; x=1781119246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2reQ/jQ0gAFpocim60ixJg6bzQabB3U5DqHmXs7odF8=;
        b=PFXnnSjs2Mwq1IED6Wmd+HySyL4SeuBYBxAP+tP0aIZzna5pyKsIO+mCuYe7JQEoF0
         wSWGHBeDxC2lgqs/3s7HMtusHxl7jtumtdiW+buCBiZp1yg0a2KZWF5H5XuWyWggyLPP
         sXjw47HIWSZ7LZarKuvxYh2gJRcfLeUW6wwgnO+AY+tS/NbmxyQDWrqM3Z4CTtVON3jD
         M7S+KtgByH9BaxNpXL9EXWFQutgDoQ5HJ0S7sfbyHw1CJMcz0ZruF8CL6B+0MjwvZQkT
         dT8etRp0EZzpnmAWHYN3+MeQk3SVAZFcMMlPZsxFPzC0nWTlGr6LEL/0lg40R5shtJ/A
         H68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780514446; x=1781119246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2reQ/jQ0gAFpocim60ixJg6bzQabB3U5DqHmXs7odF8=;
        b=QzhzT+syMy8LKXYaWV/IqTEt//5123J/yG8A4v/JNGyRpmKczqkHfCmgDGmL5vWCuf
         C0j7Q6MvZ88rKIkkMij9vfNvKmuJrFmT9xGJE4iQ+wA26WD41/DAOLZL0neej5/3hF8e
         p33PC8sO3n6asm3dASyjEcn3lDOJojT+uaP7SB1as7VbYK7AfvFJEDyMUZrxFukUvq8o
         Uyp1SmI4cseEmQIQBmbM2wiLj9hRKaOw0rcjYM0kuo9T7K4JAae2Thvezvs9ZSSmSM3e
         9fEwjIHLNzgZxm5zpnItU9EYgMrI1Tmjp5OxFrbjdj6rU0XXe0jXEx5D/baMrPT5lg/8
         O8cg==
X-Gm-Message-State: AOJu0YwvXHkq+/56B+j0t1y6JkzVuNd3NGuXRD9TSeJstX82I0Qek/Ig
	2giutFm3K1eWMS3+yBGe3b5+JMNYBKIs5gj3v6apfCmxSE+E8uA52hW7gMA4pgJi
X-Gm-Gg: Acq92OFOxhD4TUeTM0z4r68ZTGMj6NbK7MwoOBjUNcZyXYmU9AwAPZ7CZe17HGgImj3
	yn18KVjMiNevEIu2SeL3l4MklireeJkry26wcCxmgNGUCLy5neNjHIAYNcNuoJgOcGf6TB2y+mJ
	f59PA6XDCjcBsL+fdCVTkPFjMIuXwa2z6D1XmmZq8XR04aEPRAeNR85Hi9xW76qXH8j9d9XjlgJ
	dEPOPEe579rGbStpE7qHFZH/Eil77x3MVzpwWBDn71a9G7SynoQVlhZJoy+kPS7ptdwetazQSsQ
	OWXN38q46nOqTRDz/RkfVhv2ZQqTMzvsb6xh3Qa0OW74V43N2fnin6c1/1+YtjBKwiDX3hI5FCn
	LPlpiy/GtamPTyIEOzyjgwhSuy1RJLP6OcZ7Yc2MGS8jSpa8m8UvQrAeWf0yJ6P6WliLfGwYTR/
	6uMr9wseKivG92V9l++btQY3dJODhtu+hTNf/MQeR/JOb3FkXa/foXlBsHEJrTh6IHYHUJHxUzp
	CWw0T86MDxZwFBRzFu46Y9Yunp2ptNPWQq0GoWHLqlWQQ==
X-Received: by 2002:a17:903:4b46:b0:2c0:c262:b925 with SMTP id d9443c01a7336-2c163d8c0f7mr51784905ad.25.1780514445760;
        Wed, 03 Jun 2026 12:20:45 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c166391d53sm45512105ad.65.2026.06.03.12.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 12:20:44 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ata: pata_mpc52xx: convert to platform_get_irq()
Date: Wed,  3 Jun 2026 12:20:28 -0700
Message-ID: <20260603192028.5818-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace irq_of_parse_and_map() with platform_get_irq(), which returns
a negative errno on failure and integrates with the platform device
model. Since platform_get_irq() does not create a separately managed
mapping, the corresponding irq_dispose_mapping() calls in the probe
error path and remove function are no longer needed.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/pata_mpc52xx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 210a63283f62..f8ecd58765dd 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -730,10 +730,10 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 	if ((prop) && (proplen >= 4))
 		udma_mask = ATA_UDMA2 & ((1 << (*prop + 1)) - 1);
 
-	ata_irq = irq_of_parse_and_map(op->dev.of_node, 0);
-	if (!ata_irq) {
+	ata_irq = platform_get_irq(op, 0);
+	if (ata_irq < 0) {
 		dev_err(&op->dev, "error mapping irq\n");
-		return -EINVAL;
+		return ata_irq;
 	}
 
 	/* Prepare our private structure */
@@ -796,7 +796,6 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 	irq_dispose_mapping(task_irq);
 	bcom_ata_release(dmatsk);
  err1:
-	irq_dispose_mapping(ata_irq);
 	return rv;
 }
 
@@ -813,7 +812,6 @@ static void mpc52xx_ata_remove(struct platform_device *op)
 	task_irq = bcom_get_task_irq(priv->dmatsk);
 	irq_dispose_mapping(task_irq);
 	bcom_ata_release(priv->dmatsk);
-	irq_dispose_mapping(priv->ata_irq);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.54.0

