Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6C63A7F5D
	for <linux-ide@vger.kernel.org>; Mon,  8 Jun 2026 21:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780955263; cv=none; b=ifYJkK4tQV6ZW9E9yKj9dlv2hX0bZlguUjDUyZN3yVSi/zQNBjr86lWO8ISYlZONrABbL6bVwwZ876ckLM/PwKQwc5mMyO59WBG375Qqlq7vHQ1oVjgsLpGEzZsSAQ40EZ5I5R1H8JmNLnKOHW6voUV8255zI+oBijdEq2xVPps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780955263; c=relaxed/simple;
	bh=mH4UXneLMQlgwJC54B5X9djafT4n4egGwumSQC0gE54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtmw2EB1V02rzgJr1/fHyNI8+aelP8WoiSP6inIBQwDF9nLnKKpzBuDh1/iSJClf9+Vq3D1I6COKFeCdlkadx7Zdu4EBjK+uHy5QqZ+lIXABJY096ANyOxOLimHOFZPeqqc/WAvDoeQ6lXxQucAe2Rc4grPkTv3WwaVguNb+hmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oOUu0GFM; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOUu0GFM"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8423f420455so1987822b3a.3
        for <linux-ide@vger.kernel.org>; Mon, 08 Jun 2026 14:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780955261; x=1781560061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGnPot3rNTA/7m0+v2hZiWI+DD+twIWNS3Rz842/+VU=;
        b=oOUu0GFMn8eK8+SnSeC+NiqfEmpe5pgmAFSGGAsa4TBw+RoqcCt4edaFUDH77Y/AE9
         35P9CwQ0Ga3/VtCzmo+zhHApIG8Eihp9pz5x8THQ7+fn+cf3CYXNhYTCAH631gz667aY
         0TEo+6irlN7rndYmeA3lXc7khzAL7G9ruEu8mrtzMJokK64TGsUHrZz0obKlxENDcEle
         MHEQxc4oMNVKkhEt73dGfsL1D+YM30+UtwKvuy4ar40H2op0vcGGBT52D2PG2rUnJyYa
         wrGDskSSGfQUYdLWjpLx/eV60vA4zaDNYMib45tWsh4HCyutdwnpDqLqW5038gKvEIvu
         GDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780955261; x=1781560061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mGnPot3rNTA/7m0+v2hZiWI+DD+twIWNS3Rz842/+VU=;
        b=d/6M6wrmJ/5iRl1KonqF3QIPMH8KE4krjhGSjtv9+tRryfRQnRQbIO5us10/jxJHZD
         ORmVUARqW4/kdbz7KVBuYfcj/ZXK+EPnA/iUvG6rZMuF7Svpm5pJ1INRP9F6Dt/7O5H9
         W/IFVHNz6bPaJs9W7z8yzcIuM65ntq3CgKaiyTfXw2WNiUFAVxbXgDegwCEN0ZijDOcE
         XR/ymiGjXepFhwKuorjS/kvuyx0DI9qATN6O1oSxb5jfr+BjheImK985LRa37sQpyFBG
         tpSjUsMErZ2chcA5QKpJ8oh7HtN8fvfEC28TR1vqMoyvc4htyX3P0gcF1ZhHfwtrXmNo
         uVXw==
X-Gm-Message-State: AOJu0YydivvCKFfrb8uNgTD9CK7ZTA5L3+ll5r9Y/tUoBCtQnbWTXYs0
	6wbIX3FqLsxIzeeD/hbS3NpFD0+nMIk5ktLs7RPKlC8KuXk8YLnaZ5CC5RfnrTh/
X-Gm-Gg: Acq92OGhzSFOdgXzCI4MqAYh3p24/vDbrZWvzyW1JXxj4sY07sS6IrnOK4tSKDGqoTe
	Q5g7EKXWlC5SwNDsOiCaq3yUfL/2xcOd1MeDOF6H/syF8Kyu46EsCU4qAdKE3ZjtrMLBrP+D2Er
	sKjRE+TmwyhmSMU1bfQ67tWC1btdPGjIxYVE8z4E7reW9CZsTjC6X+iSQClIs00xh/4QzQNN0l8
	6GQzEgUv0csfpAHo4B/oymAmmSlz0MOKa9bll1KbyMnh34g6DkWCjkvYFSicRwhscnNvcJZjFh6
	56nigeGXyUifIPZkA/eZi+Vti+ya+agD86VGgxE8VfEenem9dxZRITVDU4a4QtDSCuTZkRuI001
	ZtEGNv3gmD+YtJlCLy2waZ1gYleWOtDa6De4PEIEYcL6/7EIIwCnzXN55cm0or+bRprqJjde34P
	ATHxODt/WWQwKBgIGSFASgIyNQJRx5wBFRfiiPX9bj4V1RAcwxbi5698J3zrSqdSn0AJMlJJvez
	WPyKQT55ndzIly/Vfwc4skq98GSE/1rxf8KpDdOaJy0FhNJ79FxpyXc
X-Received: by 2002:a05:6a00:b90b:b0:83a:ebec:452f with SMTP id d2e1a72fcca58-842b0fecf0bmr16376135b3a.42.1780955261553;
        Mon, 08 Jun 2026 14:47:41 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0b2ddbsm16016505a12.24.2026.06.08.14.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:47:40 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Jeff Garzik <jgarzik@redhat.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/4] ata: pata_mpc52xx: convert to platform_get_irq()
Date: Mon,  8 Jun 2026 14:47:17 -0700
Message-ID: <20260608214718.49503-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608214718.49503-1-rosenp@gmail.com>
References: <20260608214718.49503-1-rosenp@gmail.com>
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

Remove most gotos from probe. Simpler to return directly.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/pata_mpc52xx.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 1246b705a411..d27390eda98e 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -21,7 +21,6 @@
 #include <linux/libata.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
@@ -730,18 +729,14 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 	if ((prop) && (proplen >= 4))
 		udma_mask = ATA_UDMA2 & ((1 << (*prop + 1)) - 1);
 
-	ata_irq = irq_of_parse_and_map(op->dev.of_node, 0);
-	if (!ata_irq) {
-		dev_err(&op->dev, "error mapping irq\n");
-		return -EINVAL;
-	}
+	ata_irq = platform_get_irq(op, 0);
+	if (ata_irq < 0)
+		return ata_irq;
 
 	/* Prepare our private structure */
 	priv = devm_kzalloc(&op->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		rv = -ENOMEM;
-		goto err1;
-	}
+	if (!priv)
+		return -ENOMEM;
 
 	priv->ipb_period = 1000000000 / (ipb_freq / 1000);
 	priv->ata_regs = ata_regs;
@@ -762,8 +757,7 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 	dmatsk = bcom_ata_init(MAX_DMA_BUFFERS, MAX_DMA_BUFFER_SIZE);
 	if (!dmatsk) {
 		dev_err(&op->dev, "bestcomm initialization failed\n");
-		rv = -ENOMEM;
-		goto err1;
+		return -ENOMEM;
 	}
 
 	task_irq = bcom_get_task_irq(dmatsk);
@@ -796,8 +790,6 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 	free_irq(task_irq, priv);
  err_free_task:
 	bcom_ata_release(dmatsk);
- err1:
-	irq_dispose_mapping(ata_irq);
 	return rv;
 }
 
@@ -814,7 +806,6 @@ static void mpc52xx_ata_remove(struct platform_device *op)
 	task_irq = bcom_get_task_irq(priv->dmatsk);
 	free_irq(task_irq, priv);
 	bcom_ata_release(priv->dmatsk);
-	irq_dispose_mapping(priv->ata_irq);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.54.0

