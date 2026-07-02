Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81D22772D
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 00:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782950640; cv=none; b=F3pQGjcVjC95YBScZ1iIL+OARMErTJWhMcDqCaBTlpLhvjk4JK4RVGBwrKst7w7UItjxQjqBZw3FzGkWEM2iJcoKHYrK0DvAD7+ZJluZOycYXPgbhnlGUJ3an7yLNp6XvdXUGUSDEF+1qgvEm6W2pnqJ+uL53rTAA6X9ZIi/leE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782950640; c=relaxed/simple;
	bh=hzMVMGhQxXbBTM+0QEEJKvmA/RIHY5AkQzr/tOqXCRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASgpuwgawyu+1qascBZfDgN2yodrFiOWr7GU0yRUVsxlxRsB3Rjvotq+a72zWMGFdxiT+YnAJMFNOtFNGRxH5AyPklJVj7rEQUXbnaXN0jqxpJaph80Ll5CitZKZwkaMGSYVuf3Tt8doj5sJuTaK+Nkqra9CU+aUjNfFrawdSoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwNv2Rv0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwNv2Rv0"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c979d03538so7416305ad.1
        for <linux-ide@vger.kernel.org>; Wed, 01 Jul 2026 17:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782950635; x=1783555435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4K1yJvjl3LDz0HKXj0G+y3epwVoflXkfJKD4725XnY=;
        b=BwNv2Rv0DQi2o1FEUfoJsY/uXRJKU1q5Q7pJhuKzvynDhZP0bfPEDbjxn+kHMRTHKn
         NefsP//fH9gxlUClBSmkZWFgBggx+GDOes2cKv0hE9lmP7n7ziIOaANU6SjG9TCH2n82
         EDkrvQ6yG++AxRS+1/MT0nd7dHVDtQyeVQT2K/CyUUiQBtR5ZHK8PsLjiF5zWuBx9FBw
         1ZBsPTR5bF1T5foudD8EhGJexQ8OVJT1nYgc6yt8IeNbJnGonRp/hC60XO34cjU3k67L
         ZYb7oulQ6R/kGzQ9DYYXeKC+xOSH/JY/Ek7xmDfrqWmA+ATmdVDP1/xI6IgAVgrvMq50
         bapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782950635; x=1783555435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x4K1yJvjl3LDz0HKXj0G+y3epwVoflXkfJKD4725XnY=;
        b=o17k1d4RJvQBAn8oDetc1/tpOmZL1LWU87I5m3ekj1lOr4KbNKM8Bx8tlBDrzXDxt1
         ryRjDD75aqW8iZSZTWX+D+6Md4KfPumBABnyVWlu21IDVwogxex5JX/svnWYjhWFe9eg
         Mf93Vtpz4PIo5Ogs+YgcHuW3nMIQQ1iOyoYaNxMFYbqouM7j0eeBTph3RRW+941RYMtf
         n0NU5k/PPzhAH7E+B1gJxF+8jiyjTk11PFQUYy62hjdIQ1eFdYVnGzxMWxwn1AZh5Jvm
         xXwGvx/BoHhFVEE7oF/o7GIau9z+5oiZ6aVs63/dcYQjtzbZkwasykhdooT9Zy0+ttH/
         HoxA==
X-Gm-Message-State: AOJu0Yyr7ifLZYmQxr0wnkj6rWhZ7WD8WzYZepKJGW388/qBmBmSm3G9
	q0a++C21kO1Y9DtCGBkG1Oa1tEZ7rcwBBAUliiYaJPCca+asr/7NsPWkBEvkZQ==
X-Gm-Gg: AfdE7clKPidNDj8VC1brh7ZR4MLweiaE8Dry50+XIT9cUwNS4sHOxVGect3dSMn//U2
	jSjnLm4mlXHXPd/LjkSt+N7so6+sBE3VIwu9tZf9i6XRWpAxyCDvaJ+EoHVVA39GOwMqc71S1PM
	WOhPcTq2sfJ+WVmOrbX0H41qZUEeznmrXEfiu61uI06YmJNmdPaVxobjnFAG4LMHtLjMixKO4eF
	ld1KodFUSt1qFW2FrJ0r/7k1g+1sQ8BoJRbCS8ytlwJmoTHIrL9JMrabLvgG077sONVL5OZ7JEF
	f4oPLczqSeMzGnKZDvSeLW+gmkhis8cAACeLEC4EOvcDbok96KYSSX3iYwwUN85iv2HrL3Rlpr7
	tMNLUfiDaE05d+D5XU5DbNdVmpS7wlMqrdTXE5n71OjLI7b6BXvpgLbTJ7+q5MRa9Dy/Lm0eeJO
	MMz17qNrZpEg7SCWz+3NJemr3nEa5ZQX5g7Rcr2r/7SMGiaGWHPhM3W8TLHi7qyG4GNN5iS2R1G
	WoHuz0uXw==
X-Received: by 2002:a17:902:d48b:b0:2ca:6514:9201 with SMTP id d9443c01a7336-2ca9114c100mr24813495ad.15.1782950634923;
        Wed, 01 Jul 2026 17:03:54 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a9fee7csm5023255ad.69.2026.07.01.17.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 17:03:54 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 2/8] ata: sata_dwc_460ex: use platform_get_irq()
Date: Wed,  1 Jul 2026 17:03:44 -0700
Message-ID: <20260702000350.68331-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702000350.68331-1-rosenp@gmail.com>
References: <20260702000350.68331-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace irq_of_parse_and_map() with platform_get_irq() in both
sata_dwc_dma_init_old() and sata_dwc_probe(). This is the preferred
way to obtain IRQs for platform devices and provides better error
reporting.  Remove the now-unnecessary #include <linux/of_irq.h>.

irq_of_parse_and_map() requires irq_dispose_mapping(), which is missing.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_dwc_460ex.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index d4c554f0979d..1561adea323a 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -19,7 +19,6 @@
 #include <linux/device.h>
 #include <linux/dmaengine.h>
 #include <linux/of.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/phy/phy.h>
@@ -227,7 +226,6 @@ static int sata_dwc_dma_init_old(struct platform_device *pdev,
 				 struct sata_dwc_device *hsdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 
 	hsdev->dma = devm_kzalloc(dev, sizeof(*hsdev->dma), GFP_KERNEL);
 	if (!hsdev->dma)
@@ -237,11 +235,9 @@ static int sata_dwc_dma_init_old(struct platform_device *pdev,
 	hsdev->dma->id = pdev->id;
 
 	/* Get SATA DMA interrupt number */
-	hsdev->dma->irq = irq_of_parse_and_map(np, 1);
-	if (!hsdev->dma->irq) {
-		dev_err(dev, "no SATA DMA irq\n");
-		return -ENODEV;
-	}
+	hsdev->dma->irq = platform_get_irq(pdev, 1);
+	if (hsdev->dma->irq < 0)
+		return hsdev->dma->irq;
 
 	/* Get physical SATA DMA register base address */
 	hsdev->dma->regs = devm_platform_ioremap_resource(pdev, 1);
@@ -1127,7 +1123,6 @@ static const struct ata_port_info sata_dwc_port_info[] = {
 static int sata_dwc_probe(struct platform_device *ofdev)
 {
 	struct device *dev = &ofdev->dev;
-	struct device_node *np = dev->of_node;
 	struct sata_dwc_device *hsdev;
 	u32 idr, versionr;
 	char *ver = (char *)&versionr;
@@ -1174,11 +1169,9 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	sata_dwc_enable_interrupts(hsdev);
 
 	/* Get SATA interrupt number */
-	irq = irq_of_parse_and_map(np, 0);
-	if (!irq) {
-		dev_err(dev, "no SATA DMA irq\n");
-		return -ENODEV;
-	}
+	irq = platform_get_irq(ofdev, 0);
+	if (irq < 0)
+		return irq;
 
 #ifdef CONFIG_SATA_DWC_OLD_DMA
 	if (!device_property_present(dev, "dmas")) {
-- 
2.55.0

