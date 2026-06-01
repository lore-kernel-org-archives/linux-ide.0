Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E921363C61
	for <linux-ide@vger.kernel.org>; Mon,  1 Jun 2026 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780340890; cv=none; b=NYoLB2OX+UuTa5frz2uyKzLpf3RR1j2dzkMcvevqs2vcAX6YemvTb57E4ZU3QrEnxUf2hC9IRo0FmBPPfNpaq18a5kLCXdIrZrEP2L/dNpCj+eC+Y3IfWox5Fx+XCMbXjX1VfO83NH2eG8U4msVBOgEpd8AT9+BzY5PGWuPWguI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780340890; c=relaxed/simple;
	bh=qAUGvBzkxA6TpkLCxlJdwVQbQz7YiLvTF21/Xgmw060=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XNK8cPCVInp/hEAJCohjJleMqs54Jw+hXrp+nQwwlOt02v7pF3tI2EkdDO66Qx5RvGSHyA/KVMPYE2B52rFoBRrxVcCNZHtri76UTBr6SX3+jJanUhLx5bxAOhx27N6LQJK8a3yqIXBaOiS9Kj4kY3VzdBRE3qBsRQb0xMy6wmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvEpN+zR; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvEpN+zR"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-841513664bbso5721672b3a.1
        for <linux-ide@vger.kernel.org>; Mon, 01 Jun 2026 12:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780340889; x=1780945689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pByPR7FPVC/TgTQk/X8vSkaOmVTOv+7EtE2U+iObh2w=;
        b=MvEpN+zRJu66KkQ/psV4fwn6KrX5MTvJtGAaY/aTtFWWnSWs4DUXfxC4NZuxmjcRjL
         uPYG+cdYxHVzXUYkmCVLGYK3Mr3QGkpGB7KciL7Jjq+fK7MQMy5FsrRjxpjKYYfjgS4g
         7SpIjQ58vsoKJwkO6p7m2yo+EDRjeomalv1DMlDKPxUZ+GsyLYELRSV61g3Cm/50kZew
         HBTbv55fzDsersGOevgp/hMbKjgx/9g5DklkESw5vx1lD890DVhh95uUWLTFXYzQRvHm
         GRottwwmx1+QcHIKqUR9RneC/k5xS27iF/+5EmjXuA115SudBIWYad5ZGS1NEis2unjR
         LaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780340889; x=1780945689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pByPR7FPVC/TgTQk/X8vSkaOmVTOv+7EtE2U+iObh2w=;
        b=XY9KC/JpyMBAB7ssOJLsccJT2Hb16+wb55W+1pXvSYRgGJ//NBWA2w9g8ycFi+LCff
         FLg7MM+mT4XlwG7IOGnLm90g7Klk9q6ya/sEIcZCIPl7MXR9PWWGgQF2xdyvsv0lt1q4
         iYKqqT2XRaPGqiYW+rLLo98seW9b6e+BbchZQpukKdyFU7YWRupueLa1pFujthS1Vh3G
         zBUuElH2IuGic02xaBFduAgeRXtQ3GwOWcNWCnyR5xqzPEWrGa91HxKcw8C/8Ch7+LEY
         bnNjbK5ev3xAHATF6Z6ZbHdvlIZ2hbAPRsBbfFkpfUk5GBCcgIRByVnCgWCCCeZlFcJI
         jVJA==
X-Gm-Message-State: AOJu0YzFvZclfm2BD56AyIqXsvKs0T2zzI6W2vn4QaybybuyAwJN4MbY
	ha3evNM4D90P+51NjXwVES1nYJf/0JJcONorRsOT2J+Lbaj++9F3KNNtWWPE/A==
X-Gm-Gg: Acq92OEPfC9FQbpJuxg6LK/EUtELw4megmedDHzeFm1tTpGMXHouvy+Gi5O7TodwRw/
	rvmbjnXJBFn3I3coGYGrL2vUe9eXsoJPcTEt8ZENiVqr1fSoGhnCmSDasO70PkclzivUVrenQOR
	X7gxRa+VGltALBOWfI8jLjvgw6SbWAbX7tddt2I/pudsOo9YCvR2gRmi5suEBQ4o6wwrF9i6aAA
	z9BWxPfryGnl8/7o57hvTNcJNvxttQyQL06SB+vpweQX4QN/I4n41e/zGcRKtENmHSDdaYLFhJF
	uJXHRDxTQYa2zxnT56uPnnfi/gEc5oxTYY3wr3/hJrUo87I3m8kk6Hvd42q4Jz/7XQt4L/H9Tgi
	CgqQWnrO9yxqOUSUY6nlqYlZboM39Zn5uCVNZViVseJ3I+tJT6myamK3Rn2K5aEIHO+pAfMJ79H
	ydxJ0D18isLgERkRUzd0f4tdq0w8hoVhSNou7pqrohu5PXQzP/KejePlGHP9KM1+xzKFqxP7fgs
	k7H4u87zVKPwWO/S1EN+O+O0tcr8QlSGvGTezBqQ1ZWwQ==
X-Received: by 2002:a05:6a00:b89:b0:841:d7f6:7286 with SMTP id d2e1a72fcca58-8426a9411demr589477b3a.18.1780340888620;
        Mon, 01 Jun 2026 12:08:08 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842263539a3sm9630807b3a.44.2026.06.01.12.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 12:08:07 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ata: pata_ep93xx: fix PIO fallback when DMA init fails
Date: Mon,  1 Jun 2026 12:07:49 -0700
Message-ID: <20260601190749.20045-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ep93xx_pata_dma_init() returns an error when dma_request_chan() fails,
which causes ep93xx_pata_probe() to abort entirely.  The probe function
already has a PIO fallback path (it checks both channel pointers before
enabling UDMA), so the DMA init should not fail the probe on non-fatal
errors.

Treat only -EPROBE_DEFER as a fatal error.  For all other failures
(ENODEV, ENXIO, configuration errors), release any allocated channels,
NULL the pointers, warn, and return 0 so the driver continues in PIO mode.

Assisted-by: Opencode:Big-Pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/pata_ep93xx.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index b2b9e0058333..3f61712af5bb 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -652,14 +652,22 @@ static int ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 	 * start of new transfer.
 	 */
 	drv_data->dma_rx_channel = dma_request_chan(dev, "rx");
-	if (IS_ERR(drv_data->dma_rx_channel))
-		return dev_err_probe(dev, PTR_ERR(drv_data->dma_rx_channel),
-				     "rx DMA setup failed\n");
+	if (IS_ERR(drv_data->dma_rx_channel)) {
+		ret = PTR_ERR(drv_data->dma_rx_channel);
+		drv_data->dma_rx_channel = NULL;
+		if (ret == -EPROBE_DEFER)
+			return ret;
+		dev_warn(dev, "rx DMA unavailable, using PIO\n");
+		return 0;
+	}
 
 	drv_data->dma_tx_channel = dma_request_chan(&pdev->dev, "tx");
 	if (IS_ERR(drv_data->dma_tx_channel)) {
-		ret = dev_err_probe(dev, PTR_ERR(drv_data->dma_tx_channel),
-				    "tx DMA setup failed\n");
+		ret = PTR_ERR(drv_data->dma_tx_channel);
+		drv_data->dma_tx_channel = NULL;
+		if (ret == -EPROBE_DEFER)
+			goto fail_release_rx;
+		dev_warn(dev, "tx DMA unavailable, using PIO\n");
 		goto fail_release_rx;
 	}
 
@@ -670,7 +678,7 @@ static int ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 	conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	ret = dmaengine_slave_config(drv_data->dma_rx_channel, &conf);
 	if (ret) {
-		dev_err_probe(dev, ret, "failed to configure rx dma channel");
+		dev_warn(dev, "failed to configure rx dma channel, using PIO\n");
 		goto fail_release_dma;
 	}
 
@@ -681,7 +689,7 @@ static int ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 	conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	ret = dmaengine_slave_config(drv_data->dma_tx_channel, &conf);
 	if (ret) {
-		dev_err_probe(dev, ret, "failed to configure tx dma channel");
+		dev_warn(dev, "failed to configure tx dma channel, using PIO\n");
 		goto fail_release_dma;
 	}
 
@@ -689,10 +697,14 @@ static int ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 
 fail_release_rx:
 	dma_release_channel(drv_data->dma_rx_channel);
+	drv_data->dma_rx_channel = NULL;
+	if (ret == -EPROBE_DEFER)
+		return ret;
+	return 0;
+
 fail_release_dma:
 	ep93xx_pata_release_dma(drv_data);
-
-	return ret;
+	return 0;
 }
 
 static void ep93xx_pata_dma_start(struct ata_queued_cmd *qc)
-- 
2.54.0

