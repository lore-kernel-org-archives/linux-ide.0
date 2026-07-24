Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AB8470133
	for <linux-ide@vger.kernel.org>; Fri, 24 Jul 2026 22:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784933567; cv=none; b=Sb9QZuZglEVGGoBc3bcCE2VIksZHWrxYpXYxTFj4uqadnSfTeO9fofuxaP2VifkN5OT8Gjq6MengWTvDcfUHm7d/Xkc+D5wZyjeaVPWuHW/YCym5Elwk0n8ihcfU92PT18FiaPMGKEcBnZvWcrXAt3Ko8yf+mwE6G004gNaB1PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784933567; c=relaxed/simple;
	bh=4plRYqkV5J1VK4Wwn2r1/kn4Z8FsxuK/ZjasjX4OfGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VVIkBUlo8L/lHZziNss9C6a4tsKLNfKzNjgKedgwmPHlrGGfLpu2DHNmywWQkrFYLbf4l/FhyNp5QNBPBfOdVOJi77pYlDmef7GqtDKIfw0PZKtRokrswLKhm1AxE9yHCcczpxe8VkpSwQ7Tc6174N+812MtLa+DNnE4bkUVfeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwTyGpkB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwTyGpkB"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cab973140bso14027575ad.3
        for <linux-ide@vger.kernel.org>; Fri, 24 Jul 2026 15:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784933555; x=1785538355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QrUhrFObb5bOhWiGrqzISYLTX9FEy6tA1qYJNkVOOEU=;
        b=MwTyGpkBdUru1i1jeUUbwjKbYm3D2rSe43HrDspxvG3ml2feil0jvVLmJ8BWgIKZGr
         44YQCoEhRNYgUs5XIWeLNOyWVvfCuicHn8g95YOKQ4ZDHikoTzZruOY4Gj/rZzYLIG9n
         vRPJNtlsXtEW5GwPHUhMR3t7a9W6ICs+lf2Vz4uxAk/CyVfDFX7JgE21e13MWmCoFbT6
         YzCWKLujmGR2l2NdhFitlHhhIfNdi1Zb4hxPUUOK1HII/RuNiMTNKTLtK7cRRaS/iDnK
         HYIwhBZYD4UZmDEMLW25t4MJUcBSs2xjipNkn+27VbQaXFYYRJMAQoMxdsMF31S4BLkR
         FSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784933555; x=1785538355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QrUhrFObb5bOhWiGrqzISYLTX9FEy6tA1qYJNkVOOEU=;
        b=g7ujRgPTjudM+lHQCWhauIlIvBig4L8ailoPIJfI4o2MyCxWBD8SLEHsGmX78Jsh2o
         cVocCHAFDBpJIrg3sShyNwuh5nQgGKiEX9NDqABhIfxmeNuCNQZjYAXYWbHZ1t0DmTS1
         LJI69uqaG95W+QkRwWFfBxm95+z0JCBIHASQOzaVu0U5LUPRcVouMXEr/7g+xJtt1hc6
         90XbaPPAk9WoPUgNN+8HEdY7Brfhks3WF9fW4yiQa+IT/WId9rHiZ1S+H/uqlmDztBFZ
         7oEhtIh2I4r9YcXtEK7xBNjSZoRHe1uJZiyY4AxP5XtdiceQZdW5IU/CeF4tqXZThpIJ
         sjXQ==
X-Gm-Message-State: AOJu0Yw6tqyR2DWmbC5JSu1zWcixY1ZkCWP7Wygz1+R8XqVOQA66s989
	w5R7ehc4TMXt2QQ3TPdFrwnWIX5lYxHtKOg4gAL3dkvCp3i80NwC8cU+citnXA==
X-Gm-Gg: AR+sD11EAB+jN/Vzli4lOfx8/xXBOwrAZTR0i4hroQj0HjWK7WcZhe1gdtiq9UlUMHc
	pfOoCqYJigjoXa5ctX+YAW4Qgfl17RlIzExwEkACu8XGcb7+w6h1aeJIP3ebp77i72uU4F5uoLY
	QMLtgi64mL0o6DaNa/JpGwvKfYXA939mwkti3dULi+MgaGxvlRa2C2peAa4n6qd/kDUaa+LNZDS
	mDml2fbqXeY88SGI0oAQburH3hiwjFFj6v7sXAaJwi97Pb5FBQfuAP9FXG6KNDqVEgWOTbkR6cH
	qM03v4wFU/C2Jqj5K+l0NMB4JI7mlFcQPGEL2Ev0Ke86IWZzwEADRsDBQS3yqkc+M3YIDAJOJi0
	vjD4sZqhuotRQuzKz8xBuQoopJASngyHriSn/Ri1/h1ub2NR3PvGpEc6Z48zm7pIkgOLTmzowBK
	6Wt5gEVWggTnQgOy4btSYDJEVrgc5JAz5fqoLrQZCkeCp+ZpVglICEmmFB9TFQrAUFSXUWd7Eno
	8cfKd59pk0EC0Dc55Hc2X3ErbD9putIMnRbXRhf0s23Nlztx5afPfg=
X-Received: by 2002:a17:90b:1d44:b0:38e:4b71:8b0 with SMTP id 98e67ed59e1d1-38f296134femr306219a91.25.1784933554946;
        Fri, 24 Jul 2026 15:52:34 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03b0eaa8sm2186444a91.8.2026.07.24.15.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 15:52:34 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] ata: pata_ep93xx: use devm_dma_request_chan for DMA channels
Date: Fri, 24 Jul 2026 15:52:32 -0700
Message-ID: <20260724225232.41149-1-rosenp@gmail.com>
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
 v2: add NULL assignments
 drivers/ata/pata_ep93xx.c | 54 ++++++++++-----------------------------
 1 file changed, 13 insertions(+), 41 deletions(-)

diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index 339ee5e43e9f..c99b8c49a1ce 100644
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
@@ -683,7 +671,9 @@ static int ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 	ret = dmaengine_slave_config(drv_data->dma_rx_channel, &conf);
 	if (ret) {
 		dev_warn(dev, "failed to configure rx dma channel, using PIO\n");
-		goto fail_release_dma;
+		drv_data->dma_rx_channel = NULL;
+		drv_data->dma_tx_channel = NULL;
+		return 0;
 	}
 
 	/* Configure transmit channel direction and destination address */
@@ -694,21 +684,12 @@ static int ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 	ret = dmaengine_slave_config(drv_data->dma_tx_channel, &conf);
 	if (ret) {
 		dev_warn(dev, "failed to configure tx dma channel, using PIO\n");
-		goto fail_release_dma;
+		drv_data->dma_rx_channel = NULL;
+		drv_data->dma_tx_channel = NULL;
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
@@ -959,10 +940,8 @@ static int ep93xx_pata_probe(struct platform_device *pdev)
 
 	/* allocate host */
 	host = ata_host_alloc(&pdev->dev, 1);
-	if (!host) {
-		err = -ENOMEM;
-		goto err_rel_dma;
-	}
+	if (!host)
+		return -ENOMEM;
 
 	ep93xx_pata_clear_regs(ide_base);
 
@@ -999,14 +978,8 @@ static int ep93xx_pata_probe(struct platform_device *pdev)
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
@@ -1015,7 +988,6 @@ static void ep93xx_pata_remove(struct platform_device *pdev)
 	struct ep93xx_pata_data *drv_data = host->private_data;
 
 	ata_host_detach(host);
-	ep93xx_pata_release_dma(drv_data);
 	ep93xx_pata_clear_regs(drv_data->ide_base);
 }
 
-- 
2.55.0

