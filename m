Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B76940315F
	for <linux-ide@vger.kernel.org>; Thu, 23 Jul 2026 21:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784842892; cv=none; b=rE1OAs2vg+6MLfzPv4OIP5yShA0gmFl5l7Q2ZLaQIM7bIcRS5iuME1fX2JuxrAF3QuKCP+sepCQryihX8IRk5B4+FWOKHayW4ur0Oc4iisOKJTTdBp7sWcjuk5rbGZ0HCifSke9/lPkVQ5tpwzxyS1Sr4VSj4gRv+vCv+V/cGsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784842892; c=relaxed/simple;
	bh=OurC2CGXmWVyVIjyqPmh+99oZP8r+hHQIAxGrWZCINY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MFUfZZaaXswC9qxkNoYrMJWCah4DNxEgiC9mf39VbRb1j5QxvnMF0IFcaqKNklgBlrZaX69DgvaBq07OyIZxhRz88CyDs7DiIib5mSf/p123G6ROsfJR6iINaZOGF3TX9WrFXuw+Z+gvCmkIuunOqDQAwVhv8wPIqkU4ftHs5Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/dYqBa3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/dYqBa3"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ceae1ed204so11858405ad.0
        for <linux-ide@vger.kernel.org>; Thu, 23 Jul 2026 14:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784842890; x=1785447690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=th3CyOZRdZ87A8I5Ep9HgiU5HOY6fR9da2kPJ1AbeuI=;
        b=U/dYqBa34XdKH7vkquHVxDtOvxQFhu0iyyOLe9qFCKEmEgNIHwZIdOiZi2ybK7wVAL
         8QaUDtJrIMbtF6/90a8BjPTRGT7T8k3GRxLWIKhYtv65FyNoTkfhDFfbY053eMw6Q7kS
         uGz43nEno99XcIbad4qBJykJt2caEQDIIn9/hWH6o9sBaOksi8vm3JjoC3rb4rttNL7+
         oEqeTyMCz8k+1Pw8dVJmLGTgpvLwoQ2f7J9DbnmfJrhM3Yk2nzR0y+EwwvDU0IFCIw+x
         cs2sZ0SBz81GXPsa8dpkJPdeNImP274FQVUFXTC7gxGBUKc6tdXRlXmQAIJE+8jzD/BI
         GBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784842890; x=1785447690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=th3CyOZRdZ87A8I5Ep9HgiU5HOY6fR9da2kPJ1AbeuI=;
        b=B+JZOfJCDKkdh/GCqMcwbNqyPAt+SWgS2zGvXWL+He00SdP++lP6g1KuVacq6LIeLb
         b7yTlWRkqI/SJHo65WQMnGJ7YEN8KYcgExX+IKcxFtfIpwPynjA6yG7uzodjkZsEXGAx
         2az6nn1Uyg7j49mfrXo8A+UtcmME1brmCAc5SHvCP9sSV9ogieesj1HBKCO8ZbacEfaR
         j4vhTVyN5bDkLgxShOURLliQ5IEsy7vzgD50i3U6PsFpGYkcvZ8bfdJOsXlX7da/PTfJ
         wSgoytLu2wLDQ8vPQvR2I47/8oBNLHHLOsXNTkL2rDP7IbuU1Sx7H9786kzaGW7O+YtO
         POLQ==
X-Gm-Message-State: AOJu0YwpvIQE+5nVcuJfEQ2ncQBHaU6gp25ir+yFaJQIo63Og0iXU9Ls
	Qx38CMxm+SkNM9e/LuuJ7JCvCnVKCpbAVJbdBGPxYbrCOzVHzkmWTLLb366ZlA==
X-Gm-Gg: AR+sD137XWOGaIn5hTbKQQGcplUXEKV9zmUDSrI60mNJjVZrSqMXa3+/1781Vcpw/eR
	Nn5qKZVAWRdn0s98LhrYdu9iYrSGvMnpz4xgPN90cKaM31aTDWe6LtP/cHlS6j5GHWF8qROLXhu
	d7cDlgiMbfZWW9PpBVyXL36y3JHKV+c5Ihr0N1uGIbax/OQaE8wo1ijUL0hbQ+93P1D2OAgErw5
	FAHB/o8+K1a8nlChntfeup2NVjOHvpU2SJfzmtA6dtXwH/MJ14iN7Zo9MSVF0yMj8mLQGBcS674
	N+XgrYbHDbMl+f5zBq4nfV19Oh1WXwcOeU+ZA4vs9zb/w/NvEU1sqPnk3ItWpx6d402WSeXNdri
	EfNv4msndbMjxQLVm8CE41AycUQPGkv/eHKHzAiZQ1L8qPrWfztCTDnxdbsQDdnGESa1rWhFxiC
	usNwJAcswef/BScqMNUieW8DA2/3NoJwD5ZWaebO01ScvLyN/FCwDwCnLsMOxQiEoAw1AzNvQez
	tmYu9WAdHhe0yoeA3EIgIpeXc08dATOrF0eXHj2g291o/YNdYLh8EEoQWZViOJQfg==
X-Received: by 2002:a17:903:26c4:b0:2c9:bd64:8c8b with SMTP id d9443c01a7336-2cfa6c5700emr60569725ad.31.1784842890470;
        Thu, 23 Jul 2026 14:41:30 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efa39e9sm40277195ad.10.2026.07.23.14.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 14:41:29 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ata: pata_ep93xx: use devm_dma_request_chan for DMA channels
Date: Thu, 23 Jul 2026 14:41:28 -0700
Message-ID: <20260723214128.356942-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the manual DMA channel request/release in ep93xx_pata_dma_init()
to the managed devm_dma_request_chan() API. This removes the now-unused
ep93xx_pata_release_dma() helper and the error-path cleanup in
ep93xx_pata_probe()/ep93xx_pata_remove(), simplifying the code and
avoiding potential leaks if probe fails after DMA init.

Assisted-by: opencode:hy3-free
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/pata_ep93xx.c | 50 +++++++--------------------------------
 1 file changed, 9 insertions(+), 41 deletions(-)

diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index 339ee5e43e9f..04ab37134fb2 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -627,18 +627,6 @@ static int ep93xx_pata_bus_softreset(struct ata_port *ap, unsigned int devmask,
 	return ep93xx_pata_wait_after_reset(&ap->link, devmask, deadline);
 }
 
-static void ep93xx_pata_release_dma(struct ep93xx_pata_data *drv_data)
-{
-	if (drv_data->dma_rx_channel) {
-		dma_release_channel(drv_data->dma_rx_channel);
-		drv_data->dma_rx_channel = NULL;
-	}
-	if (drv_data->dma_tx_channel) {
-		dma_release_channel(drv_data->dma_tx_channel);
-		drv_data->dma_tx_channel = NULL;
-	}
-}
-
 static int ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 {
 	struct platform_device *pdev = drv_data->pdev;
@@ -655,7 +643,7 @@ static int ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 	 * to request only one channel, and reprogram it's direction at
 	 * start of new transfer.
 	 */
-	drv_data->dma_rx_channel = dma_request_chan(dev, "rx");
+	drv_data->dma_rx_channel = devm_dma_request_chan(dev, "rx");
 	if (IS_ERR(drv_data->dma_rx_channel)) {
 		ret = PTR_ERR(drv_data->dma_rx_channel);
 		drv_data->dma_rx_channel = NULL;
@@ -665,14 +653,14 @@ static int ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 		return 0;
 	}
 
-	drv_data->dma_tx_channel = dma_request_chan(&pdev->dev, "tx");
+	drv_data->dma_tx_channel = devm_dma_request_chan(&pdev->dev, "tx");
 	if (IS_ERR(drv_data->dma_tx_channel)) {
 		ret = PTR_ERR(drv_data->dma_tx_channel);
 		drv_data->dma_tx_channel = NULL;
 		if (ret == -EPROBE_DEFER)
-			goto fail_release_rx;
+			return ret;
 		dev_warn(dev, "tx DMA unavailable, using PIO\n");
-		goto fail_release_rx;
+		return 0;
 	}
 
 	/* Configure receive channel direction and source address */
@@ -683,7 +671,7 @@ static int ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 	ret = dmaengine_slave_config(drv_data->dma_rx_channel, &conf);
 	if (ret) {
 		dev_warn(dev, "failed to configure rx dma channel, using PIO\n");
-		goto fail_release_dma;
+		return 0;
 	}
 
 	/* Configure transmit channel direction and destination address */
@@ -694,21 +682,10 @@ static int ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 	ret = dmaengine_slave_config(drv_data->dma_tx_channel, &conf);
 	if (ret) {
 		dev_warn(dev, "failed to configure tx dma channel, using PIO\n");
-		goto fail_release_dma;
+		return 0;
 	}
 
 	return 0;
-
-fail_release_rx:
-	dma_release_channel(drv_data->dma_rx_channel);
-	drv_data->dma_rx_channel = NULL;
-	if (ret == -EPROBE_DEFER)
-		return ret;
-	return 0;
-
-fail_release_dma:
-	ep93xx_pata_release_dma(drv_data);
-	return 0;
 }
 
 static void ep93xx_pata_dma_start(struct ata_queued_cmd *qc)
@@ -959,10 +936,8 @@ static int ep93xx_pata_probe(struct platform_device *pdev)
 
 	/* allocate host */
 	host = ata_host_alloc(&pdev->dev, 1);
-	if (!host) {
-		err = -ENOMEM;
-		goto err_rel_dma;
-	}
+	if (!host)
+		return -ENOMEM;
 
 	ep93xx_pata_clear_regs(ide_base);
 
@@ -999,14 +974,8 @@ static int ep93xx_pata_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "version " DRV_VERSION "\n");
 
 	/* activate host */
-	err = ata_host_activate(host, irq, ata_bmdma_interrupt, 0,
+	return ata_host_activate(host, irq, ata_bmdma_interrupt, 0,
 		&ep93xx_pata_sht);
-	if (err == 0)
-		return 0;
-
-err_rel_dma:
-	ep93xx_pata_release_dma(drv_data);
-	return err;
 }
 
 static void ep93xx_pata_remove(struct platform_device *pdev)
@@ -1015,7 +984,6 @@ static void ep93xx_pata_remove(struct platform_device *pdev)
 	struct ep93xx_pata_data *drv_data = host->private_data;
 
 	ata_host_detach(host);
-	ep93xx_pata_release_dma(drv_data);
 	ep93xx_pata_clear_regs(drv_data->ide_base);
 }
 
-- 
2.55.0

