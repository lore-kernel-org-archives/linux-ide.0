Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3FB3A7F5D
	for <linux-ide@vger.kernel.org>; Mon,  8 Jun 2026 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780955264; cv=none; b=ZZimlFKZKN5F/h03TnG/GjmfrvgIsQNL6jPTXCUOaWUoa2T7gymdQuKRiKQEYD6Pem84mmMMD72IP2C0nuaFe8Gm27XQdOA8OseOn362wwdTwT4Te7N3VJT+nt5meSancM+OG29CUMqeI36XSXSypgm6bLRGhgbPyiaSXXoxFkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780955264; c=relaxed/simple;
	bh=lLgdyNzqPPEwWg0RhFjk7hX/lYGyZog4c3lOVR4ekdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhZIcxcrOqbJTvJQYRaVKPyyIjeBLogGP+GxEGzO2PxSESsTyXGbpcY/pQY8Ih3VmjBcZPaCQW68wHZskQgHI6U/WT5Tdl8VzNHOl3/U5Q8H0SagK/1hEPxAzBYU4SLGGa6mDjHu5bCXocGRGrfyikhdXsQiZ0j1jsirQyLqv5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfZ9UXZq; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfZ9UXZq"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c85a297d2d2so2821114a12.0
        for <linux-ide@vger.kernel.org>; Mon, 08 Jun 2026 14:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780955263; x=1781560063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1aO31R9po/ToHJHFiNQQMCUQkh7948MgzIZhlOe7Vw=;
        b=hfZ9UXZq/hy5klis/llyTueSxRdJiG4xCHnnxEAkwFTV9aowjpIgLAKZattoxMnprS
         gjULy4RUGwbTRvY8nVQRWGFOseQS5w49e5i4dwO0VDUp5k6rjB9FuK5IOmbgX7F+5att
         2B4b7rrWI+DmSeZ9auYNFLS73GQIsbrciyf6KDzbVE+X6FEANZ1gSG7lMC93+MbicfpM
         YGcIwO3FqRc/H7ICILIMtwfXST97P6s6U/ylAkxrb53+uc3gNGlNRs36YM7qOo2bMVnE
         2PABabTSpqA6Bghk59vPcBa/7HCLD+R/631bey8WHAXhk8nDt+68G1RTHixrMv+EcPbI
         xf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780955263; x=1781560063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c1aO31R9po/ToHJHFiNQQMCUQkh7948MgzIZhlOe7Vw=;
        b=GOsLLTBXiyB1yqmeMURuFgYzguVNAGPyjHytCcmyNE/jgylMVx8os9TWgS+KST+2u1
         Vw/YOeVBJn/CPNrR0x9+Z6FkKS6gsUQPaZaVD/z1M7Lx/XkYaYsSWFN7tgbc2P3S3Qio
         kKsX/6tEGitfDT8fX71fd10MCBC+ho9fgvnYKb9J4XmMrqO+nDiBfH/bAfGMghSRAj7h
         vePDmy53qGrwKJbcUc9VCXJ8iHVZ3M1dDyXkngXSA80aT1T9PPP3iSB7t+rpyJI9R1yo
         zoSLQFJlf+T7uK7IAt9M4h4p+Map0UtcSvTRnct77ECSVHsQwpToJNhXYn22YqkgOLcn
         035A==
X-Gm-Message-State: AOJu0YwEEL8Gk+EwYC6wKsqxJOonPKegvHrD0WxPiCglXIG6xEwsWhHO
	WadjRCPwWQVSKIFB18mz93/2j9kWEPUGg8o2+sY1IzkPJs6VMLBCJVrsJzr7AnJZ
X-Gm-Gg: Acq92OHnXGjqsGnQmjiXTt6avZCw7oGHu9HFcHwDY2ThmxEBTE1rKFdHh3DlW9yu5R3
	FaELowfktJw/VuE3UGqLgA/pFCtjnwAoigVbrwhXLuFbTVdZTl7RBNdJ2TbjmKlFCMIKLBD1txB
	fV7cylEukDnmk0PM3b3G5Iv9XuFv2piRMhs4yrWs8Alzvhkt2vzYBhzOmL3EGTt5vUdWb14xsFr
	0RoEWkSUvWe6VbGlcS9bBAhUbcx2qi3UTrWr6RPWWBRLQTlTm/AH+YmRmDFEYNvkn9elf+0f18a
	UNFU39tr87oDkPVBcBOFtcgqAOduUwn9pqhxliOZljTv5ejXKtsKcF1UWiAqcfoKrfg6B2fzaqR
	IlKvzpGE+cfNhKokUQeVWb0gzaN8DkmYfb7KrpZmPIF42/bX9/D/wQULWDtS5uAcSDhKmiI/rq5
	9j3vm3aWdGtON/nayIMGJ1guhcrNifMWBdebsinqKc2FDcx5xOoOfI0tCR4q3oI7QTxWzaLnyq3
	ka6XA/PIcZf9wZixr6G8VbsLNGS2NCNpxA8844+lRjlkw==
X-Received: by 2002:a05:6a20:b598:b0:39c:a78e:dba9 with SMTP id adf61e73a8af0-3b4cd05d32fmr20752862637.40.1780955263092;
        Mon, 08 Jun 2026 14:47:43 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0b2ddbsm16016505a12.24.2026.06.08.14.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:47:42 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Jeff Garzik <jgarzik@redhat.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/4] ata: pata_mpc52xx: use devm_platform_get_and_ioremap_resource
Date: Mon,  8 Jun 2026 14:47:18 -0700
Message-ID: <20260608214718.49503-5-rosenp@gmail.com>
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

Replace the open-coded sequence of of_address_to_resource(),
devm_request_mem_region(), and devm_ioremap() with the standard
devm_platform_get_and_ioremap_resource() helper.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/pata_mpc52xx.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index d27390eda98e..3c41a7b860bd 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -20,7 +20,6 @@
 #include <linux/delay.h>
 #include <linux/libata.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
@@ -671,7 +670,7 @@ static int mpc52xx_ata_init_one(struct device *dev,
 static int mpc52xx_ata_probe(struct platform_device *op)
 {
 	unsigned int ipb_freq;
-	struct resource res_mem;
+	struct resource *res_mem;
 	int ata_irq = 0;
 	struct mpc52xx_ata __iomem *ata_regs;
 	struct mpc52xx_ata_priv *priv = NULL;
@@ -688,25 +687,9 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 		return -ENODEV;
 	}
 
-	/* Get device base address from device tree, request the region
-	 * and ioremap it. */
-	rv = of_address_to_resource(op->dev.of_node, 0, &res_mem);
-	if (rv) {
-		dev_err(&op->dev, "could not determine device base address\n");
-		return rv;
-	}
-
-	if (!devm_request_mem_region(&op->dev, res_mem.start,
-				     sizeof(*ata_regs), DRV_NAME)) {
-		dev_err(&op->dev, "error requesting register region\n");
-		return -EBUSY;
-	}
-
-	ata_regs = devm_ioremap(&op->dev, res_mem.start, sizeof(*ata_regs));
-	if (!ata_regs) {
-		dev_err(&op->dev, "error mapping device registers\n");
-		return -ENOMEM;
-	}
+	ata_regs = devm_platform_get_and_ioremap_resource(op, 0, &res_mem);
+	if (IS_ERR(ata_regs))
+		return PTR_ERR(ata_regs);
 
 	/*
 	 * By default, all DMA modes are disabled for the MPC5200.  Some
@@ -740,7 +723,7 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 
 	priv->ipb_period = 1000000000 / (ipb_freq / 1000);
 	priv->ata_regs = ata_regs;
-	priv->ata_regs_pa = res_mem.start;
+	priv->ata_regs_pa = res_mem->start;
 	priv->ata_irq = ata_irq;
 	priv->csel = -1;
 	priv->mpc52xx_ata_dma_last_write = -1;
@@ -777,7 +760,7 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 	}
 
 	/* Register ourselves to libata */
-	rv = mpc52xx_ata_init_one(&op->dev, priv, res_mem.start,
+	rv = mpc52xx_ata_init_one(&op->dev, priv, res_mem->start,
 				  mwdma_mask, udma_mask);
 	if (rv) {
 		dev_err(&op->dev, "error registering with ATA layer\n");
-- 
2.54.0

