Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315D43815FF
	for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2026 18:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289174; cv=none; b=aN9LguWrCAW3ME6abcDSx253dq9gf3xNfjKUz1bk//bZGWaBcNtm2qWXq/7OGV3nCq0hBjHygP6xG2QHp8rIr+ErmZTzmDxVbk0i+zw1YOJOUKQru+Kz7HXIeXX824wwc7HRc3///HXqBTiBZw0rVUbnHmQDWe39PuQ9297y+HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289174; c=relaxed/simple;
	bh=hpaCrbY6o5Cx8ezToB31YG70wN5iU1pTkYv+6bp1F9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkuTMF1SCiLBM8rRYTNZv6DKGjOxeHslryaf/QBV2/xrq3W/1xRVBWhknzLYY+yg0/OG/teLMuci43p1Z4L5i5ddHCJII59w/2WJFq9PWXfRovnaOeWmWIeavMVstRNlDJV/pZMJV6uypbYJKaMZhLdkf/UfhvA1jANTulLuLgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1hn/Ex/; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1hn/Ex/"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c857fba35cfso642936a12.1
        for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2026 11:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781289172; x=1781893972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XktS4YSahvbJ20DQyO6ECx/9CmFfhSZb6AakeIyXtY=;
        b=F1hn/Ex/Kdywz3yWoyseGPgZYmwrcWzIDS0mjKxHbFvLzWs6rNaE2XUosTC+cgDwsJ
         jBc/9auU4cn7DBbvXusp+56qRP4Yjf+EUFV0iH89BbLQU+SQ2+G9HDAk+ljQQptCQeAy
         0xGjvN5R05avNurjhbnS1PVfwRDrFpflcti1MifjI2JQcq8fI0Q3K99l8Qv8b5BWbND3
         XVKjkNn8dYLCGQZJwDRu0BJK1KJfvCODATSs7Y90/q55uq5dXmoqfn69iez76/+gTxvC
         awsxOa7UqozSUdf+6mBBfmbKoOGQCbbgjElJKlEVHIQ3KbDcBylAe1MF7hAe79nC2L2Y
         wFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781289172; x=1781893972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3XktS4YSahvbJ20DQyO6ECx/9CmFfhSZb6AakeIyXtY=;
        b=FAMxFYbSeqOM4UAiwb6pza2AuQWHUCzV+XWPq4pdEWLlxnqofQomgQayOxo+pinxFv
         GgkLuCWKTAMb6AEVrtW7HWe3JYmNvGcaVvSa4dAMNMzU5pJWBBhTNwSc7FACzahoBp85
         /BknkfP5aYRiabU4616pM3zUojOpCgFiBoXrENdcNwSylql1x9uJO/ocwy14FfL130Oh
         JpL5p1C3+QSindfr6UjZT1CAAB09hDuOgwgiS5PySWz/KIUvRsNlWybV9IUfoNppppAD
         uznXEJ/cqBqEmu19oAd5rcjxOW+tEdcBiGlItr/rE7FXdc31jxqQZopunWqEnuzPNUmS
         JM4g==
X-Gm-Message-State: AOJu0YyijJwjuV+khtvXMf0xTfqZMlElBhShGmzjfnDHieEEYIpzntzf
	ZLNHG+9l77A+3K8kyFQJ62xOW8jOzh0L2dkC7ILPXB964ES8GRSX3bDDl8zYfQ==
X-Gm-Gg: Acq92OE61B2eQVs71TYZ3SBYQ+fNzUNF0p/L/z3HbC8vSeafgXsDoXBJVRV9kPhqt0y
	ZHg2xpVHHDRzVRbJSmhSzkfNKnE2ayyyA13UIDZxLDwP8HJPY99VEA/cQBICrd4rOaFuJOwuvFY
	kQPNv32Ae1zY1Jh809b8107jCSWFtDdrzDNB5MoARH3MnN3U6soxGPgROCVE6vz3TmZceUz0Otr
	0pX5HqsO2GUGzelONQmrxvP08/qeGRJ6MVbbfeX33eer92Q6cMV6+eJaaayrt3jpcT7K/bEqI0o
	Fop22hep2EKbJnSdayd9o2S8wgBGoidbFz1W1k9avg6fHqqQ5vcvr9IgtK/EWKq92oOocnywjWF
	9FjVX3OiVkYHuafSLghfrGORbY03kEfUMgR4h/6/Tje8uOUQGp9LVaELJqSojKcS2VJjNWX2U7t
	NLtWG4P0Gz8DBMuOGuz9t6NiMoh3ogBEacojKT3qBn1Ov6w8r7WhLgwz5snasEMdSNka+lgf3j8
	xXjOtJ2vZi4cRq/QMIA5FEd861BCpOGig==
X-Received: by 2002:a05:6a21:1519:b0:3b3:486f:f2d1 with SMTP id adf61e73a8af0-3b783b15ed0mr4699970637.3.1781289172421;
        Fri, 12 Jun 2026 11:32:52 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:a073:5e58:ab5:a167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661b5b207sm2795034a12.5.2026.06.12.11.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 11:32:51 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Tim Yamin <plasm@roo.me.uk>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Jeff Garzik <jgarzik@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 5/6] ata: pata_mpc52xx: convert to platform_get_irq()
Date: Fri, 12 Jun 2026 11:32:26 -0700
Message-ID: <20260612183227.20446-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612183227.20446-1-rosenp@gmail.com>
References: <20260612183227.20446-1-rosenp@gmail.com>
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

Move platform_get_irq to after devm_kzalloc, as requested.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>

ata: pata_mpc52xx: move jiowserhfiohoqwe

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/pata_mpc52xx.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 4645de4cc257..238b39af38db 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -21,7 +21,6 @@
 #include <linux/libata.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
@@ -676,7 +675,6 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 {
 	unsigned int ipb_freq;
 	struct resource res_mem;
-	int ata_irq = 0;
 	struct mpc52xx_ata __iomem *ata_regs;
 	struct mpc52xx_ata_priv *priv = NULL;
 	int rv, task_irq;
@@ -733,25 +731,20 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 	if ((prop) && (proplen >= 4))
 		udma_mask = ATA_UDMA2 & ((1 << (*prop + 1)) - 1);
 
-	ata_irq = irq_of_parse_and_map(op->dev.of_node, 0);
-	if (!ata_irq) {
-		dev_err(&op->dev, "error mapping irq\n");
-		return -EINVAL;
-	}
-
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
 	priv->ata_regs_pa = res_mem.start;
-	priv->ata_irq = ata_irq;
 	priv->csel = -1;
 
+	priv->ata_irq = platform_get_irq(op, 0);
+	if (priv->ata_irq < 0)
+		return priv->ata_irq;
+
 	if (ipb_freq/1000000 == 66) {
 		priv->mdmaspec = mdmaspec66;
 		priv->udmaspec = udmaspec66;
@@ -764,8 +757,7 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 	dmatsk = bcom_ata_init(MAX_DMA_BUFFERS, MAX_DMA_BUFFER_SIZE);
 	if (!dmatsk) {
 		dev_err(&op->dev, "bestcomm initialization failed\n");
-		rv = -ENOMEM;
-		goto err1;
+		return -ENOMEM;
 	}
 
 	priv->dmatsk = dmatsk;
@@ -798,8 +790,6 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 
  err2:
 	bcom_ata_release(dmatsk);
- err1:
-	irq_dispose_mapping(ata_irq);
 	return rv;
 }
 
@@ -813,7 +803,6 @@ static void mpc52xx_ata_remove(struct platform_device *op)
 
 	/* Clean up DMA */
 	bcom_ata_release(priv->dmatsk);
-	irq_dispose_mapping(priv->ata_irq);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.54.0

