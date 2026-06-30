Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C31182899
	for <linux-ide@vger.kernel.org>; Tue, 30 Jun 2026 00:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782778656; cv=none; b=OinavdmAs3I+shIa5ayCOuiaQHlLpn8akF9fQHCupITq2qShmsRGg7fJfx+HgYGuMmB4Utg17iR2bSAO2H56a3R9YKa7IYkDhaEORODFVbt+BP9mxr+rdfUrrMCOSJmzabIaTQpkzM/Yjl/hbrqyquBhWmWYhpms9xhoRLk9hJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782778656; c=relaxed/simple;
	bh=1X7u2qogig97WHzYmetqcMo4Gw1twVs+klDYUFt+U1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pk5Ay9igmvJQd4lbKTJNs6wr5CVGbm4abiCM6XF49eDvyhkr3pnumT1y7mQa5lIdhQt1gDZLfdVrFJiN3SXiQIl20b1kPxZVjMnsmx4ncVAZHig1WrpZmzjvht2ib863PlpG/rMLI9UctpCw2UpTPMyEQiszg3aI+zFrwNpg/1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4Cm95j6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4Cm95j6"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c81d799ef2so19291155ad.3
        for <linux-ide@vger.kernel.org>; Mon, 29 Jun 2026 17:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782778654; x=1783383454; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AN1+T1OcODqmjZQWA/uGwVcJolEqcHslNGmGmNauEos=;
        b=j4Cm95j6RKiV+wTgTrxHTQCs5Tw7V+8DCqECuvlYaolm0HPrq7BwDXPt1Oj6KZQtPy
         idYIsHTxJhFH/PoQDGmUeyPXKwTylDd3dUtoE/F03oot12XK5A3FYU/mJhgli7JFH7k5
         6o2oS78e9L6WbpQCvONe/qC2upjQtJeU+rskzq7lA0u0xJ79+uDpbXBOimlzbPT1neuI
         myoJeGcBgWoFQaQ6CYxpWsg1ncnK2/ZsBWYCArAVKd8rYZDebqiP3hH9u2C09RfYdkEV
         QgxKzbODG24cH0XFCgzAf58YENQxgwcRqfNswDDGOzy5CIxzUkSGbawPRFuEkB+j8I/n
         qiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782778654; x=1783383454;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AN1+T1OcODqmjZQWA/uGwVcJolEqcHslNGmGmNauEos=;
        b=Q445Ie4bLxAer925xa7heLBNtZTUWBmp7R2VI+X6WBXPs3Vy8ILYkGXU383HQgvJaV
         Yv8LP+tVzSbscp188UVbaTSlz/uBU4LVU6+YTJGyjZzIHCO6Fy7k9P32RBUJ0A0wxCFb
         c6EklBmoCGe6MCuCDECJBofhJw6fh1nI8CLZl8HyYFPIfkkrmOGEFUCtB7AwlvKPZ3ZS
         f0kpObRNDYPAW94257UFAEIGKKRQyvMv0GKd0RRBUbPV18BqGgJeTGXocq027WglKsBF
         5CSQlIM7bAR8z6/DeJ+DuktO9DbDmGfCsvtzsfPGyfMd43gCjinJEoRU52oB/Ftr2KiD
         Yifg==
X-Gm-Message-State: AOJu0YySRwoom/reJpMMFU+8yVYk7pdh2mrCIsscG0JvCSjOI2eB+cA9
	SM01ZlXt1MFYxmceV/hFH7xWO/53OrIbgNRe+8FKJFIrQYMixdgM/0dEFMsrqn/V
X-Gm-Gg: AfdE7cn39dFCPVeFR1KgHM/n5lJOnfuf/uH7f4XAKxX8DTBn5cSRzgV5esDAtow++9g
	3MYfLDRuuXSxOnG+7qbeIR4hDS8BnVlW7flUYxWb/JSnA7jLa5SUwPLyZkcxARiEle3vWkBCjJO
	9oan2T/XWVlK2qcPpF4esN86qLwYd1FHjqsOf0vDJ4Gpk8kYt24BnWJ7azhckyTY3Mg59jubxWI
	U3RkObciIanKyWJlgYV9/FrJqSeY6rxY8o44Vb8oKxT/YMzq+x4LNjQha4r5ByiAZaze5iz6MAt
	+g8ZXI4+fg3Ax6tILL+xR6SvjB+PzK6Z9U620gRmKQSo//X4n05IQpxQIIzsRkuZtkqBM/sy44N
	MHVc6O9tyGiOsWslouZuFYsZBoGyfFUGcNV88BbC5I3JgZc6J2Yxvdevi3N0ncDkqDPBeUto59x
	hEPjceHuMMpx05sldH7OjTKxtfoD79pWyWxSKJ6WJikAnYTrHc0qp501qg+cN6jFzN4CYC5MC5/
	RKXv/Xhh+7k8Bvkm1Kx
X-Received: by 2002:a17:902:f688:b0:2c9:97a7:f545 with SMTP id d9443c01a7336-2ca2ed35e13mr9588685ad.43.1782778654494;
        Mon, 29 Jun 2026 17:17:34 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca3828c6d2sm1839595ad.39.2026.06.29.17.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 17:17:33 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ata: sata_dwc_460ex: use devm for old DMA resource lifetime management
Date: Mon, 29 Jun 2026 17:17:31 -0700
Message-ID: <20260630001731.1174739-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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
 drivers/ata/sata_dwc_460ex.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 35aa7f9acdf7..a1e319deb0b4 100644
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
@@ -1187,7 +1191,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 
 	err = phy_init(hsdev->phy);
 	if (err)
-		goto error_out;
+		return err;
 
 	/*
 	 * Now, register with libATA core, this will also initiate the
@@ -1195,12 +1199,10 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	 * error_handler() to execute a dummy Softreset EH session
 	 */
 	err = ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_sht);
-	if (err)
-		dev_err(dev, "failed to activate host");
+	if (!err)
+		return err;
 
-	return 0;
-
-error_out:
+	dev_err(dev, "failed to activate host");
 	phy_exit(hsdev->phy);
 	return err;
 }
@@ -1215,11 +1217,6 @@ static void sata_dwc_remove(struct platform_device *ofdev)
 
 	phy_exit(hsdev->phy);
 
-#ifdef CONFIG_SATA_DWC_OLD_DMA
-	/* Free SATA DMA resources */
-	sata_dwc_dma_exit_old(hsdev);
-#endif
-
 	dev_dbg(dev, "done\n");
 }
 
-- 
2.54.0

