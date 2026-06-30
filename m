Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A7047A0CB
	for <linux-ide@vger.kernel.org>; Tue, 30 Jun 2026 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851063; cv=none; b=UeCFGsZaCPSZIgHv+VcrL26BSZjVoT2xVHR2I9D4sNEGjGiqaPQQyyfhiVigDbY7pjPjQG6TP8ulK0Z1WdHxbwTpDoA9wsKME5m+mwoWi2KYOSM0RR/1naMw2QXrDf/GLSM9Vqnwmb3voFQ1UCVxalOn0suS5gL9J2Yp98x6QQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851063; c=relaxed/simple;
	bh=Vsza6noEf03zMGO4BRVIOrpMtjQ4Wr4W388lPafDzH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMNCr62N6XoPpS9ncnFHlUHf3fMPMY41YxYw8f9ukIH5/SYZJQ4C++ahog/5vQsQ/LUqmSvd8Ud13M5oEgrqBBgF2bk/mfJvJvL937lO5Ln0FQLfwuIST5V8MyeVX/8k5DWp3n06HoDHOEHqlGAESIY6o3fvRsJ1kTgnH1bIZrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvmGPE+m; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvmGPE+m"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-847a483e344so707335b3a.0
        for <linux-ide@vger.kernel.org>; Tue, 30 Jun 2026 13:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782851061; x=1783455861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCeWZT68Agra37M3FGW1CBI1Ha++QSZ6nKW98hAQljU=;
        b=QvmGPE+mNAzS4nMaEc2dZ/TpQ4TledoOihRHyhP/4TnU3hYLm9wkz7DgD+eQCP0+O1
         xbPdOK4pWn6fHCv5mw9PLFiHn1+pFbjbaugH0VIUOI7bz+MJm1ul8aYsFdKiTBO4K4WL
         agWwFvcMuITbYEfGX1ldijHvMsVqN0WgSeYTUSoKQ2F3qitFK46dBt0BhCDIgnrJa/1u
         SCvBKXVRjlm/hrfb87x4UUQSh2P0Fp4o2HK46AhygPv8K8K9fLUYiZnza9EsU3v7/A9B
         HkTZAazJK61UTBsNJew0CK4+Np4d4iy7zbEO83r6ePWyHpriDFgK1ohrete0z9t5P+CA
         vWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782851061; x=1783455861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hCeWZT68Agra37M3FGW1CBI1Ha++QSZ6nKW98hAQljU=;
        b=SC/I4Ql/T0upvaIv+f/U9I/es5hHVrP1mNEvX9dW2lSqmUoeKXDQTIEem3b9sn11Zd
         isaYsOEEOEidUxECFu1ruFraSHzrvuIefy7VWo+bEmuuldETh2r8RTL3FoAv7Uz59YvE
         MVXtnRKDH40BWt7YvuTJlSZfyyuF39kTUR68sM9cImojjb2OGn6G8dQ3uADWsfZPiLRW
         cB8iONCYaP+IAlon1c3GItTAFa2RV1XY/u+Bnl8stMa+xuyUesdAr2CtGMV41cmAQ2st
         82Fs0ruDbTsSUeDyi1Pzm6we4EO5cWKe76fqQ7mOmADKMe1J6tUNUAV1W88LihLqq7P1
         DCPg==
X-Gm-Message-State: AOJu0Yyy/NE4IC8gVyEfw7lo6K0tcAX02TFf5+HcXZK5CJ5w3T/hQTWd
	+PDqWSvYhuUdtcQQ37GUCf6ae1SvJkOJtbconwjpprz3XFXMCBgGaIeDcVn0rCwG
X-Gm-Gg: AfdE7ck2hIZaamSGFrl9FHb/fMjj51O+liTRNZgEbCK0v5jL8vZc1ubAJgCmS6COKKf
	YZXJ2yKRHvuVrjRx6k1+pgUcGW5YkIzAGOCY18rPf87pPdB9iTlgw+C883Fd35KUBqfX5UMbY5Q
	yt4TFdMWnuVx6hpHzdhzGYnBwBx6qD5cXfpsTKJlcAiFw04ozc2yjfnBeJ93Nq5auyV8ZKKC9HJ
	2+6tfKEvwkk1mM93Q1JCSuN9hsudfWqq3IQPps62H+salsUxpupwkqf/XMtGfOPDKpqNzq26swm
	F4642GB5OD05axV3k8SRRBn40Q9xFXyEBZKLsabdjcoI/xq/h9nJ3bKDGNDCmQN+JzyPdQeZN9H
	pkNNL8Xy6xhCmOfMwAC2BYBo+ZjteHbv6I9jSl+APAJN+v9tKyBJA91pQRySnEjtTfgwoDSjH/X
	LbVcah8PMSwkVitlSbXAZU4YEVdwaUrz5u0bWYZrrEA4uMQxcNIIJCwviM/Z8IPgeh0Tozbs5P0
	kD3iwfQ8g==
X-Received: by 2002:a05:6a00:23ca:b0:847:8d0e:5d83 with SMTP id d2e1a72fcca58-847a825023emr2518147b3a.26.1782851061252;
        Tue, 30 Jun 2026 13:24:21 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a0337121sm2688854b3a.44.2026.06.30.13.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 13:24:20 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/5] ata: sata_dwc_460ex: use devm for old DMA resource lifetime management
Date: Tue, 30 Jun 2026 13:24:13 -0700
Message-ID: <20260630202415.234463-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260630202415.234463-1-rosenp@gmail.com>
References: <20260630202415.234463-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert sata_dwc_dma_exit_old() to a devm action callback and register
it via devm_add_action_or_reset() after dw_dma_probe() succeeds.  This
lets the devm framework handle DMA controller teardown automatically on
probe failure and driver removal.

As a result the probe function can use plain return-on-error for all
failure paths — the dma_initialized flag, the goto labels, and the
explicit sata_dwc_dma_exit_old() call in sata_dwc_remove() are all
eliminated.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_dwc_460ex.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 215b5a65527d..34d6d0534e30 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -221,10 +221,18 @@ static int sata_dwc_dma_get_channel_old(struct sata_dwc_device_port *hsdevp)
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
@@ -244,15 +252,11 @@ static int sata_dwc_dma_init_old(struct platform_device *pdev,
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
@@ -1186,7 +1190,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 
 	err = phy_init(hsdev->phy);
 	if (err)
-		goto error_out;
+		return err;
 
 	/*
 	 * Now, register with libATA core, this will also initiate the
@@ -1194,14 +1198,13 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	 * error_handler() to execute a dummy Softreset EH session
 	 */
 	err = ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_sht);
-	if (err)
+	if (err) {
 		dev_err(dev, "failed to activate host");
+		phy_exit(hsdev->phy);
+		return err;
+	}
 
 	return 0;
-
-error_out:
-	phy_exit(hsdev->phy);
-	return err;
 }
 
 static void sata_dwc_remove(struct platform_device *ofdev)
@@ -1214,11 +1217,6 @@ static void sata_dwc_remove(struct platform_device *ofdev)
 
 	phy_exit(hsdev->phy);
 
-#ifdef CONFIG_SATA_DWC_OLD_DMA
-	/* Free SATA DMA resources */
-	sata_dwc_dma_exit_old(hsdev);
-#endif
-
 	dev_dbg(dev, "done\n");
 }
 
-- 
2.55.0

