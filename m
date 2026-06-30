Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B9447A0C0
	for <linux-ide@vger.kernel.org>; Tue, 30 Jun 2026 20:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851061; cv=none; b=bRSlNY+l3OFFcDcNlwlzeY00J7Y2Dt5/VxmbmkWUPal8g9qC4nSF1euoJDA/gTEgB1nPKsIHdpk4OLigiHEnGRdUhYlMMSVvh67MqQnzzXc5YsDhJAqwm8PVn9eQfQLCnBG0v8mi5rksSkqLKrwoO44ujjCyNimEHcRvAPt1veg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851061; c=relaxed/simple;
	bh=rX/RmbqUohtiBxDsve+PGfvPFIzDy/imm3HVJgnA0m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbuKMlZZck/GX3P2bp6cvhP/At5q9yzBYMZo9LM7QNWU11ndBHfCUKhD7ZETu1zj6S+39hp9vNDY1xf4dto6IYpOASNaPVQuWXY3cvWTPp2by0x6qlLv9JViwrOM4kwjoT/+S7KbUnaPHc8TU/Bn5rtQRa4ZFoUWqFU+tmd5BR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UncaTx1R; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UncaTx1R"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9aaa90a791so800233a12.3
        for <linux-ide@vger.kernel.org>; Tue, 30 Jun 2026 13:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782851060; x=1783455860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30ycfbV8+VNAs6mHK0aeUIXi9pLDga+rOmgwe58coW0=;
        b=UncaTx1RcwlmQl5C3YnUM1WMVigDUoCt9+EdhHx8zVyKpC5UmGyXT5QEa9Pkwh63/n
         toBSt0H/0xMZ8XXJsMIQxxt1N3LelLJJ71WA0siviL3OuhvF1mxeDMD/Y/3OlCq8NKSD
         TGiO1k7uhPSQFVApBp2RIoKFiYIdHU073XXfM0Mi5X4Tv6GPjNbWaRPcyHSy/DaWRoOs
         uzKgtFUYLGuFiJ6GOtctCoNshmbL+1fkHgKMB8Fjd2bO0qdaJq8DywbQTAdewKKkuqsr
         C955FQTuBEcmGmJd1SBwa5UlD5WPh/Kj4SS6NkyHVM5rOipA0KZnN4LtP2WLruvpC9Ta
         IUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782851060; x=1783455860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=30ycfbV8+VNAs6mHK0aeUIXi9pLDga+rOmgwe58coW0=;
        b=mbR1bBC+sYc3zGznStMnJ5rSfbnNeSLkqKeNaKyp9yq/yLo2SxZsoBtouTxg/CSWiN
         J1frNRMsO5gOAhvFmxTEfQ5KrxPaoIlabUiSUm0NKdfi8PWshGsn64FCIyAMmV5DpDc4
         gfp9ajQULrF+kx20qneyyCd34oKNOS/RJ0qK4uMZBrxgpeivv32U7Q45f1OaUZdnok99
         nBkHNS+qrYcmqzJ668fy51eUQG3O9YAbgIANPoMCNkRFlPK7oAg6suwhFUVYjnOq9kT8
         E0v6ckFE/Eqmhgyu0k57xxMoPTs2pizpnLBi13bwLL+rasZFvCORR8g7g3p3AgPCAORZ
         kIdQ==
X-Gm-Message-State: AOJu0Yzp7/xe6Sdc2xDYogW3Zer4/JI7QV2KgY0wzJwElZ7yAxo9NJKF
	MB/3ciwFsLKtDlgnWE/EdJ3oA/rSHqXbO+GpQDCA9UMewYVM49IBkrcHDau7xjgY
X-Gm-Gg: AfdE7clU7PMZX7vfOBHbUtdYwKfrT68MwXDkePg/s3KnZ8nTwo38B5I27akfDYJnhco
	1gkYQqGPQ5+fItNqNjLEUFehffsN5NIdWqUN+DpL2v+FAlDdTA8SsZGBY0eSsOQ6Nog4e77WZFt
	Rf5QsMFgMCZPidm/QpEHsejfQo3+RtyuzDAzvBu1GlsQ0hz7hO8vAaFyy6GCIM9MufCSehpWmBe
	3viyNu5Ip6L9udrjeC2ut2TtDGFqTPoY2mxQu2dCg1C0OBbeOqt1FGG3iUpziQA8dNcA5ssJIj3
	IrD94JNm6r7VFEmNuXUlkfV1CUDikggP00F8CFxxIHqhFyZbVzIqNalzTV7CMNu3DEKD4Hkwzc9
	0wIyWWiCQZkclRDGo2TaLxRHFzSC5KbSJrPbnZCPsK4zejW9zTTXEwjxUsENvsGfNCM1vobFHgy
	RLQo1y0F8YM+rm4pgKe3vCZksLJ4wjhdlShM9JII798EPhzJS36NF/JBH48h3fVwdFzujNl5Ydz
	7XNrcHVog==
X-Received: by 2002:a05:6a00:2290:b0:82c:6f07:299f with SMTP id d2e1a72fcca58-8479eec64d6mr4285120b3a.14.1782851059735;
        Tue, 30 Jun 2026 13:24:19 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a0337121sm2688854b3a.44.2026.06.30.13.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 13:24:18 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/5] ata: sata_dwc_460ex: use platform_get_irq()
Date: Tue, 30 Jun 2026 13:24:12 -0700
Message-ID: <20260630202415.234463-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260630202415.234463-1-rosenp@gmail.com>
References: <20260630202415.234463-1-rosenp@gmail.com>
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
index 2bcb3ac5ae21..215b5a65527d 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -19,7 +19,6 @@
 #include <linux/device.h>
 #include <linux/dmaengine.h>
 #include <linux/of.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/phy/phy.h>
 #include <linux/libata.h>
@@ -226,7 +225,6 @@ static int sata_dwc_dma_init_old(struct platform_device *pdev,
 				 struct sata_dwc_device *hsdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 
 	hsdev->dma = devm_kzalloc(dev, sizeof(*hsdev->dma), GFP_KERNEL);
 	if (!hsdev->dma)
@@ -236,11 +234,9 @@ static int sata_dwc_dma_init_old(struct platform_device *pdev,
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
@@ -1126,7 +1122,6 @@ static const struct ata_port_info sata_dwc_port_info[] = {
 static int sata_dwc_probe(struct platform_device *ofdev)
 {
 	struct device *dev = &ofdev->dev;
-	struct device_node *np = dev->of_node;
 	struct sata_dwc_device *hsdev;
 	u32 idr, versionr;
 	char *ver = (char *)&versionr;
@@ -1173,11 +1168,9 @@ static int sata_dwc_probe(struct platform_device *ofdev)
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

