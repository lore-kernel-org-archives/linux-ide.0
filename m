Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8386D23909C
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 00:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782950645; cv=none; b=dG0gszluuvGiJ2wQZWJYB+Px7+EldYVWHp2mZCB7kywLwQl/dL3m65p/uITnU2u3CfAiBqommpSWzXy4bYRUAYMWHGpryT0yJL2DUGYjijPTPdKBjqUW+NtuagY7Hgd7qauasHTV8PKk8jQzVSjtlljxaOZdDCMp3RFo6ROqCzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782950645; c=relaxed/simple;
	bh=tVSOGYvPABB44kDBTtPeT0PZcIIZmuo8dSkfWTdu0WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHgttRVFeYmm+ENA7BkUA3IBQQc4amCQxlC+NKPn8eGEm8bIWuNdI9/SqvX+W2AayPbq0m5iLTKH/CdliAdWibNUCMlNYLc/8nryQDXPqMFEUvSGqITf037bchAvo7zJ71tvOSAme1NnJyY0ymzyWTVbxMBJYAlzUSpoyUxGgRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goHNkwBw; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goHNkwBw"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c9d87b1f9eso11397145ad.3
        for <linux-ide@vger.kernel.org>; Wed, 01 Jul 2026 17:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782950644; x=1783555444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKzPJLKirfbftLn1G5jAp4SVmx2q5SsvmYor83AaAqE=;
        b=goHNkwBwkX38VM41CXYvYCbHkb8vgYHecsyF4SuwfW/Ek0P4NVvkfyN9a3MP1VgqL2
         GFgbTdPANOox4QhtIa4QZXByJgecT6YpQQbgL6uCLPO1cM8SHqjur2sEplTewCNZVD16
         JUGdCUeFQ9T6qWtRlVjiYIyi0Fq1dA4ane07mh1IPVNYHNHSlHPpfxSiwNX9PU3SbuvZ
         Nlpat1AIumf0S1OY6Pt8HCEkgsL+VLsxjfzpLtJsDzZ0JqkWhRjLTNaaQ9Kr7ukNY93p
         LDvIigV4Xju9KLm4f3y4Ps9CqplfbIKDCsiSqCyNdKxHeFHsUP54R7R0lkui/XBTqobX
         gJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782950644; x=1783555444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cKzPJLKirfbftLn1G5jAp4SVmx2q5SsvmYor83AaAqE=;
        b=VZDR9BJsWvcv7jlJlS0r8LwbOqhOSjUzJtl6OJeSMsSpyoSAsKHSuat0NKqXmI9flW
         6OkPSELv2CLsex/8ckoy3CKZF5OqXxDyONIKPjjAUo0ZG/lir8dydxcQscrtZzNU7Zfq
         8Gdko2U1JSLHfLeUBhpVbqXI5ZLnXx6vnXl9M5Vb+p0Y72xWMRWP+H1YJqErEugqbnD3
         bfc20pDDMSzBrhpqsGTgAnaPOxmIE5xUL9SPCEd6VRcFwcJYNGWFs6Po5MsQgNlF8DnU
         bO99eXvuMce8bnUZPLbj1aYH5ld1NONebd6vOz7xKEi3KQY7S7ESFo7upHaoNn1y8CBH
         oe2g==
X-Gm-Message-State: AOJu0YzOPFPprRpzLviZNHK79Xz1QzQSwLucsuezj1kiieyageMlZz2Y
	qTJsYJOCqY8LHyDIV8rdLMtx6xbJEIU4vLOIZY9nYrn/r17RoJWLtScy3W+T0A==
X-Gm-Gg: AfdE7cmBRvwzcO5Ox1dte8QsKXedXTPFe5EbX/IYSGgsOPScXxbvenZ0XkRnNbglfYf
	P/Chb34pLVzSE+QNRQRuHQGASjPKswtP94DeI2nrrJGj9tfrNuJmpMzLr4OFYmOjvdr6Cl/IUqF
	BDOwIWoYS+4fROJGP3suXnHcFhbYzaIDl9qEORGuzPRv22YXBNyBrBb4pzHFWFzYf7OzAjLRYU/
	csr5aOSoOmTQn/vRqqo0Y7AXij+poiQHt0fetutIPUzdoual4C+dQiMPYCZtduPuGyoZ3QhOs8c
	F8vUiz9rZUZ9cxtc8MMgE7hLPvF98KVMcKzhG2WRrxbKFvsxFa68uceqWZCgWjJKJdxIBE/rTbd
	Cnh4OJszqdvTTG4EgQOC20x3XDDDSQBV/LYouFaJQn5iqJqKmsR/pS0PsnfXHfNNJUHJKEFJC5o
	plKZZF4qInuW051TdeToRF9c3uEJX+Abh9SfpZJ4JEUnn5ASTFo6sbxZ8f7AaZJqOTgKfTGQlSd
	Ajf4ChjAw==
X-Received: by 2002:a17:902:eccc:b0:2bf:23c3:34ba with SMTP id d9443c01a7336-2ca7e756e2dmr39116415ad.28.1782950643592;
        Wed, 01 Jul 2026 17:04:03 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a9fee7csm5023255ad.69.2026.07.01.17.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 17:04:02 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 8/8] ata: sata_dwc_460ex: use devm for old DMA resource lifetime management
Date: Wed,  1 Jul 2026 17:03:50 -0700
Message-ID: <20260702000350.68331-9-rosenp@gmail.com>
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

Convert sata_dwc_dma_exit_old() to a devm action callback and register
it via devm_add_action_or_reset() after dw_dma_probe() succeeds.  This
lets the devm framework handle DMA controller teardown automatically on
probe failure and driver removal.

As a result the probe function can use plain return-on-error for all
failure paths - the dma_initialized flag, the goto labels, and the
explicit sata_dwc_dma_exit_old() call in sata_dwc_remove() are all
eliminated.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_dwc_460ex.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index e8e2790be1d6..352cd7f02163 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -222,10 +222,18 @@ static int sata_dwc_dma_get_channel_old(struct sata_dwc_device_port *hsdevp)
 	return 0;
 }
 
+static void sata_dwc_dma_exit_old(void *data)
+{
+	struct sata_dwc_device *hsdev = data;
+
+	dw_dma_remove(hsdev->dma);
+}
+
 static int sata_dwc_dma_init_old(struct platform_device *pdev,
 				 struct sata_dwc_device *hsdev)
 {
 	struct device *dev = &pdev->dev;
+	int err;
 
 	hsdev->dma = devm_kzalloc(dev, sizeof(*hsdev->dma), GFP_KERNEL);
 	if (!hsdev->dma)
@@ -245,15 +253,11 @@ static int sata_dwc_dma_init_old(struct platform_device *pdev,
 		return PTR_ERR(hsdev->dma->regs);
 
 	/* Initialize AHB DMAC */
-	return dw_dma_probe(hsdev->dma);
-}
-
-static void sata_dwc_dma_exit_old(struct sata_dwc_device *hsdev)
-{
-	if (!hsdev->dma)
-		return;
+	err = dw_dma_probe(hsdev->dma);
+	if (err)
+		return err;
 
-	dw_dma_remove(hsdev->dma);
+	return devm_add_action_or_reset(dev, sata_dwc_dma_exit_old, hsdev);
 }
 
 #endif
@@ -1203,19 +1207,12 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	err = ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_sht);
 	if (err) {
 		dev_err(dev, "failed to activate host");
-		goto error_out;
+		return err;
 	}
 
 	/* Enable SATA Interrupts */
 	sata_dwc_enable_interrupts(hsdev);
 	return 0;
-
-error_out:
-#ifdef CONFIG_SATA_DWC_OLD_DMA
-	if (!device_property_present(dev, "dmas"))
-		sata_dwc_dma_exit_old(hsdev);
-#endif
-	return err;
 }
 
 static void sata_dwc_remove(struct platform_device *ofdev)
@@ -1228,11 +1225,6 @@ static void sata_dwc_remove(struct platform_device *ofdev)
 
 	ata_host_detach(host);
 
-#ifdef CONFIG_SATA_DWC_OLD_DMA
-	/* Free SATA DMA resources */
-	sata_dwc_dma_exit_old(hsdev);
-#endif
-
 	dev_dbg(dev, "done\n");
 }
 
-- 
2.55.0

