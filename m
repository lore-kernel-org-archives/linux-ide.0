Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7A737881F
	for <linux-ide@vger.kernel.org>; Sun, 12 Jul 2026 21:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783892253; cv=none; b=oXUDWCONq+LHue/BnFVR7srzM3WABFkRz4wWrmhmSv/1lgfCHqB6GkGFtN5bo5RceViMj3nZAVjM0bYitTs7dmJXm52wmIYckXUXR3RFQbO/56kgsEbEt91rBT9Nr6NzC3WJ3hb+QsrPmL2jwBTpm1qR41J8qd7QG5SnRWHQw/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783892253; c=relaxed/simple;
	bh=POCI9+mB1JSWNcNfDabfa8EbUVAr67ljGTZM4RhdEIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0kj266ypNEaKcxNKCxhH5d8Dppsh7rPDC/Lw+wtXS21B+XsqlkQ8xOzoo8MR4E9UWpfN9X3mSJWTy7czWgEII7dBUBdTF0NMOscGEm6OZoaBQUu+lppAIjf8LwEUTTXjjFsi1HiwuhUL0FoWW/3EI8B9K6Pf8sPprva6ya7ZvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oVgsHgHG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVgsHgHG"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ceb096e675so10770155ad.0
        for <linux-ide@vger.kernel.org>; Sun, 12 Jul 2026 14:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783892252; x=1784497052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5y5XJYUzbCCx3dlBk01XmOZCMqCB1gsJEEHZ92fwapU=;
        b=oVgsHgHGlCl9HUprDT+5pV6rTgZtyvZmtxLh/RTxQWiULf5mND80i4Tsgk4yrbGo/Z
         KgAbKNNH1jcaLOraNm9sRdYOTutwyuCU3A2E8KcXx2yFtgqTGDhlOzVkINGvuBnV99Ae
         ys9wUzVIIkwCSevdVIf90ibko4aIcRO5biaN9JRABYVa9RGtehbAY6r80XyesUXfmbzB
         qJOCSyQX6CqfPKFysDL7Um0o2HFSpJjZE3Q3CAzjPbbAfkcOR7Ky7v66lJefQ1u0jNFb
         vqznbGCjTpjv1OQzVz+BC8C9u5eTlUYebThV7g/yWrYa0t1/29INDjVXDpEkQMOsxWw+
         hXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783892252; x=1784497052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5y5XJYUzbCCx3dlBk01XmOZCMqCB1gsJEEHZ92fwapU=;
        b=sAt1l5mRr5n72BkiVc2Csj3KD2Dbn/oVC7UoNF5M5byQ52U7AmJuCUMW3xfZ7VDZ8R
         C33KLKcdcBc10M1JEszRAHbpTEIuDceYzfSR+YXwduLU34evfDo0OYVZb39zdXt3bhAy
         +nBEoSkIhu6GW5KOeRDB0ovZ7BsThbkpuxF1O8sP5c6fSkhXpKZv+WcJyQgualMIFOT+
         4awLrjszQHM5Xy68iIoV6R1rOc9RBfSKj5lbF1fakEcVVuoBAdohavLqWZwOVzqR/RTQ
         iMZJvhzqPZ/jUd55/SqLZKLE0AHLx6yLk6S8RCNXhgFKouelv3ZLz3wubv2hSd63bkIg
         Ci0g==
X-Gm-Message-State: AOJu0YxwyTMpAY9vt2+R4Y7r9XChxRIQgdjNWPrITXVhPHDTEGlO4VWo
	7s59sC7dubys3AuxjUD/AAfiVYIPk2NzwTTnBIdLaLZfDCvbMk9nGx0UgeEbhQ==
X-Gm-Gg: AfdE7clevAJKtgQC7gfm8vRTK0uIvmnBqxTNk0FNOXwpimDbEVOM70DuMdgWI0qOyWS
	Mu0L02bIyZS3ktXH8Ndf+IPA6smgMWDiDfAbOGYViHae3mDEtnLRnoCV2n0+XgkkoA4+p7ES/dQ
	yQiaPQrDnmQlIGlRPLgbeEaktHijsyq7gb0ZUbhJFfumEKnofg8xpPsCvNv+nMViRgXIDk51PPt
	a/oRhuKmOYKkolGlv9l0DoMK/YOJV9OOYt6gfFchW8kxgHc4ElNIt2jmM1zi3PxHsB/7L4Yiq86
	Z8r62rCI6Hh8wFx7XSYsi4LYg6TGT3f73ShhKnKa1l/w0gh/H7K6DOa2ItRQw57J8Q/igrs3qKm
	fCEFauVfV1HmWU7N+Fj1MRZyyH2ejKGHYpSec575OxnBF/BMABEv6UgaouuA61uqq4fq37ACU/L
	cho3cyAZA8HZU/h2AoM949UNr1pzQuml6PXIbOZ8xwJGHrvUCeVKXeXtGGk9gwTrtpRic7kYP4r
	6Cc5qfsepeUi7KTXuci1Z3kI7X2izn1u935cJUOe/gq8ZA+IfvU++XGFmYYYkeh9Q==
X-Received: by 2002:a17:902:f60c:b0:2c6:90ec:f601 with SMTP id d9443c01a7336-2ce9e7a5234mr68312255ad.8.1783892251794;
        Sun, 12 Jul 2026 14:37:31 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bfb7aesm89082605ad.29.2026.07.12.14.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 14:37:31 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Jeff Garzik <jgarzik@redhat.com>,
	Mark Miesfeld <mmiesfeld@appliedmicro.com>,
	Rupjyoti Sarmah <rsarmah@amcc.com>,
	Prodyut Hazarika <phazarika@appliedmicro.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv4 1/4] ata: sata_dwc_460ex: use platform_get_irq()
Date: Sun, 12 Jul 2026 14:37:25 -0700
Message-ID: <20260712213728.824420-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260712213728.824420-1-rosenp@gmail.com>
References: <20260712213728.824420-1-rosenp@gmail.com>
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

Also fix unused variable when CONFIG_SATA_DWC_OLD_DMA is disabled.

Fixes: 62936009f35a ("[libata] Add 460EX on-chip SATA driver, sata_dwc_460ex")
Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_dwc_460ex.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 4fc22ce4bd9a..092272753749 100644
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
@@ -1173,14 +1168,12 @@ static int sata_dwc_probe(struct platform_device *ofdev)
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
-	if (!of_property_present(np, "dmas")) {
+	if (!of_property_present(dev->of_node, "dmas")) {
 		err = sata_dwc_dma_init_old(ofdev, hsdev);
 		if (err)
 			return err;
-- 
2.55.0

