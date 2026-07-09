Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C82F357CFB
	for <linux-ide@vger.kernel.org>; Thu,  9 Jul 2026 02:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564328; cv=none; b=nvGO8B3yJh/RVCrQAcsOBu2U074IzVmvF42oSecvEfPKcik2zog/OMN9NlzG1iwP45mr0iiO5QqzuCcJ5BEPrUiVBIefcHRDDHTSsumAOI9Vp6QrYE+KPMeuqc3SlQMmTjd/ff2++AaY5/GGy9d62LIWAujVANqspRaisDJyJ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564328; c=relaxed/simple;
	bh=wJjNXunTmN/MYe4oUjZRp/YGTs91QQlxjgUklhWSgMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vb1u8qS33Uo3pd4sRmhqeZswAHcDd+Ki9mFZHFyT/3lL1Z+o990JQY09UlTDFp1LVcAieQ0znC8a8YRcNY4Y7RO2izH5M32kCY0Ml2N3smUYivRvfHRjvcYz9+cRncLPT/N++iT7n6gxMwciK3JTzV7qvoH8DJznu7IphXxh0lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rlyUsasN; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlyUsasN"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so458180b3a.1
        for <linux-ide@vger.kernel.org>; Wed, 08 Jul 2026 19:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783564326; x=1784169126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=koaJY8MiU+/O0i7vIvjrCwskqgMmon3+CjPbqR68EWg=;
        b=rlyUsasNUaAQ1+Wv3XdCD9ACGWVmDCGLsIXL0w7IUT/4jk7x+kMhuGD3vpbe7jlj/r
         FZ6e9Tv0jFMcMWtRsp+V0KLyaMJYeB9cHI4azhadnOpru3/3pEf+Gxcr/xy53MRtdMsZ
         xeTlDkgGYE9MLrR6BcI7ebIZvhvrRKwiv07EQSfdpbHCShpBVen9nrNBlDhsv8u4LMcB
         z0giF/lqSNx7BSPMY4sCDtHuX2isn0IvPxMc+L3gGP8zPSrqgmWfh0FXK+11u+3VR94+
         zdJ0QGtSX20oaiJ65vTUfUZfwzxoN/Y+fVTnXRYJkoabwaB5Tp0aQprYN0rItyhM+5ff
         36dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783564326; x=1784169126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=koaJY8MiU+/O0i7vIvjrCwskqgMmon3+CjPbqR68EWg=;
        b=cANdEdVhxpD0JttmxqygZwUBtyB+Xd16maEV3RvwcjDh4Yo3SajwIArUB0HiBEySD/
         rFUOcZrR+H4MrsCzWsXaeb4UIOA9Vh9909xAlvy6fbfdGDoSuCVWwxCXJkiVvhW75N8A
         ahJ/1jdHT9oF65AQvGdCD2PHu6/qjELPk77nPZK7xqhdyUTJuUKordNUo8NRrwdjtHnd
         Vif++ew+UUQqARL5oFIBrxhGdeDUk3k1nc2ii5DPE3H7s2up5PPHAHophGQb8qORf/kG
         MruLG2jWr97x5QBwvi29ziEoDkrtoU26lNeX/UdXmZ5/wonGF/BqtmHdnFny32aLK2HU
         zLyQ==
X-Gm-Message-State: AOJu0YxuvykdWqLXIqSqG/VsyL3dG51m0s+brdcn/PSUndBnVSB3My7m
	gj7Md+ogLmboBBvoWSLExXILgJrbnH7BUzwl805u/cpoBhQZl7llvtJMrr8mvw==
X-Gm-Gg: AfdE7ckgkOUJSSTO1otNuy8kbXZJZCkrzemzbrNdM/3GE9rb1OO0EercsS75TkRJCfu
	zSbcA8CgZ2pseLKEG88VATIDZnKnWx3sfZX5XaTG6PMAT2Wpzw1nZQbHP0XTbFMfc10op+Yhh4H
	phB0K8Vedl8tZxPZnpRC/dul4f18BVI411AGTRNIX8JBF0D2jqf0VplfLhKjoqwRNio5J6oqddS
	USZzlQ2Nxh0HyXCkG/hPHJghR1MIW6IxEpRM0QPkRQiEhW/A3CYGG9u7nX0geWLy1XSfFqtb1Bl
	9vF0vg26XhPIBGF1eZfAoqf4Vb6M1suzdqBMDhDkbImYRMxScAyYeWGiC0p8q/5UWGCQmkQ5C4U
	3hbr6SNk/QMWINEYz8Ddd3apFzGLTI/thjbE4ECGAI8UBRuoBI6TZsiHZvovbqZBPb+5jylMFI6
	ffBjONrc4/oElSNdCjaC+rOv/RtT68btmrithEtdSBEDhg8Gmz7gOdLs6LYcNrsuU3uGkMNPa2x
	zvm4g0MnGWbz1E7x3S+39i8PzuwPwE1WIPu4t4q8O0s+n13+TQDLw0eFuUdtbPybA==
X-Received: by 2002:a05:6a00:139d:b0:848:50ef:4157 with SMTP id d2e1a72fcca58-8485acfe79cmr864072b3a.27.1783564326165;
        Wed, 08 Jul 2026 19:32:06 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b975a0sm7935954b3a.14.2026.07.08.19.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 19:32:05 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Jeff Garzik <jgarzik@redhat.com>,
	Prodyut Hazarika <phazarika@appliedmicro.com>,
	Mark Miesfeld <mmiesfeld@appliedmicro.com>,
	Rupjyoti Sarmah <rsarmah@amcc.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 1/5] ata: sata_dwc_460ex: use platform_get_irq()
Date: Wed,  8 Jul 2026 19:31:58 -0700
Message-ID: <20260709023202.2132165-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709023202.2132165-1-rosenp@gmail.com>
References: <20260709023202.2132165-1-rosenp@gmail.com>
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

Fixes: 62936009f35a ("[libata] Add 460EX on-chip SATA driver, sata_dwc_460ex")
Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_dwc_460ex.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 4fc22ce4bd9a..442c6e9d06e0 100644
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
 	if (!of_property_present(np, "dmas")) {
-- 
2.55.0

