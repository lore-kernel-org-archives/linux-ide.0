Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C37C361DBE
	for <linux-ide@vger.kernel.org>; Sun, 28 Jun 2026 23:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782687794; cv=none; b=fhaRp57cHlweqJUnZ1I4JfjcfYK6wbEbjd7crPYcYyp58PzqQBIT3FK/zA9WRNiu98YglYbLjhrjKpWviDSbIlbkiOKR5yTj2oycEBLrloZv1/fMd3TCxv5+S+qvhOzYqD+kjqKgFdspXdRRmb6E/dPlAUREFbvFlJjrh8y0Ea8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782687794; c=relaxed/simple;
	bh=FQj8ckGZysNfiJUSLqBXvUF99XsO/lnSAXbrD2QnJQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AXbX7QVCUz4++//7aMThpoC2WfTd++L9fqRbre88g9Y/zBQklUzTJUK5LJB8Zkj3eZ9rIC6XvdNmdh9mk9gSrrwEogS7sMnDWskvHmxxhCMYNWyD0gW60c0K8f7ZwAeS9wtuvQVlMhe5zUd/C7hE2UfT8iBXIFw4xMCHJ5tWraE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5b5qGz3; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5b5qGz3"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-13809223fd4so3218853c88.1
        for <linux-ide@vger.kernel.org>; Sun, 28 Jun 2026 16:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782687792; x=1783292592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O3JHfzlaEWeCBPq/GnkthTuQ06HXnVphKOSwXmVpV54=;
        b=l5b5qGz3FNRJ2TzYz/wgvuxi9hEH1YZqzpyKM/E0RInH/gM1y3VJNtpMXnXhsm+xTU
         Zyaf5nyYiFk1wxjQ0leKtEpMwuFqjPxiSYlWIbaO8i16FibJUGrivneMYORB/Enc3TLc
         oZEX7ohqDMCccoM//rDmzvvkqM1upMyxPyBHqQPMuCu4qUfx+OfqN3mjqLnVzBASx9ms
         PJdfdxAO2F8tBY37+G9m+ORoJVPjg9LNjBhPxKZap4YeloKixsUz6bpEHi97dWZ3XdyV
         gqT1uDHSUujfuO+CzgP5YvqeQGLtmLLjKEygD8lAsnaTl9jNyMVmj7Xm23qqJCr/TDeg
         tTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782687792; x=1783292592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3JHfzlaEWeCBPq/GnkthTuQ06HXnVphKOSwXmVpV54=;
        b=eI6TZqlvJmya4iBJAZlNy1ZP1i2fK10BjzvNjEJdrVZanpQnhSNlfcl0BQVQ6ROCCb
         cTy0TEb7qXeGolj1c8QaGCY4DT/ID2VTPt/hbTEuRUtxqYfp1VPx2jdl0vDDRG0REk4H
         GoYzGZ+iydsQPSofxig70iToM7qUuukRc0Pd6WqHISZxXMctak5z0x/noLx/Jo93IAqX
         UFnAqnGlLxOMTTViiz4iW8XLLwf6UuR/yV10e1DqWD3BpkYMgWKrHN9ZAjGGTGiS1sZ8
         kTkQqlitbB26FSB4FVixaMEPYqlEOr12iGindsZBZGb5dGIK7j3DPP/e2NL05RczHFmf
         HyOA==
X-Gm-Message-State: AOJu0YzaOTA6+n46st/aW3u8eY14smaRuk4T9sNGtHSdgDpNOHpolSDI
	+VsGHS/fQWpWQrFDLLTKE3gNcZTdHqmNdfFDa06SoULXG6Tc1/llYTDgP4eHEw==
X-Gm-Gg: AfdE7ck1EXXuZXQ00jfbNXdfQJnl7CXoxJ0Dj56dvz4D/wSMhggMj+GOaAjTjSHTdXZ
	eFxyFKG9ca1KN+n8PYyU3RomBSvCP9xVPYkAS/c4jTOjXbNvgq/5rUC0Na2SjngbWQcZ643xrcg
	J3VtHKnVHRHjVra4QmNksNfHjSL3STCLmNxvCN042nwEdz2uP1gTx6kIWbsrIzOzgUxBBmBKBDW
	UIoxlaVb/acGb4+aAWRkKebF4AIbVQ7dIxSq6CVTQe9VuZAuDy4d5jcnapmifG/zXnxI763ZCLa
	YYui3JCfhHj66r1XbWQvSlG8i15zVYEyg88/2RU8auP2lnN8wkkIyRBSsN9HF3halvh0iwl7lgC
	x8XbLiNfS/L7YawAFPjWOr0Gpx64BRnkcEGxoKA/FYbsaGpsXhiwrzF4HJad0R2NRtEFb/Affu8
	4vmEcAXKWpV8D32MiaB2qqPU0jfhloIJeE/cOfxv8D1Keg0IVjdeZxw0IS3XiXBNa10OYN/QEbv
	HsvoBYGmg==
X-Received: by 2002:a05:7022:6885:b0:138:177c:b971 with SMTP id a92af1059eb24-139dbab88fdmr11636945c88.29.1782687792205;
        Sun, 28 Jun 2026 16:03:12 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d8f6d2e4sm39140513c88.7.2026.06.28.16.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 16:03:11 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ata: sata_dwc_460ex: use platform_get_irq()
Date: Sun, 28 Jun 2026 16:03:10 -0700
Message-ID: <20260628230310.1214770-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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
 drivers/ata/sata_dwc_460ex.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 4fc22ce4bd9a..35aa7f9acdf7 100644
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
@@ -1173,11 +1169,9 @@ static int sata_dwc_probe(struct platform_device *ofdev)
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
 	if (!of_property_present(np, "dmas")) {
-- 
2.54.0

