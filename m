Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519BC2C86D
	for <linux-ide@vger.kernel.org>; Mon, 20 Jul 2026 02:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784512955; cv=none; b=QJUfzbByUZk/HaIZJQOF2CZ7FOBVd6REPykeDJA3TwWgib1NyND4y/UyxTedBtYnz666ialyVnzjYRELPPmbvNPHFv8WPeaTqHEmeAv04UZWLUlK61ImMGtX9EqExmIE86z+IAIpvQgzmrdDHNZjpwHpiZ+io+0/V1TnH3CbPh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784512955; c=relaxed/simple;
	bh=N7bV8IhOFF9GBhLm5PFUUKuPkaLfsq/MU5lnX57/+gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=erC4c5GG5D2NFbQPkFpREPEyIWTcSxzx+s06+Fs9NHBNNpgoc1U/iXdcwZkU9QNDbhhkq44WK1HG9TVikNIqWFmLkQiJealodw+ck+GLTfVAmngZqdRLIn28DI+6+SS7PTZNHVevczoEIcJ3E5o2C94cFGTtDaZpcXM7ngz/XgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCrXCfdV; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCrXCfdV"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ef1dc934d1so38308706d6.0
        for <linux-ide@vger.kernel.org>; Sun, 19 Jul 2026 19:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784512952; x=1785117752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fZjEI+rH+GkZRFlNAE3Vjq6nP1qdwM39GIwm4i94NEE=;
        b=GCrXCfdVZO82gWt5lwl6V9c1kguGnyEXUnVFyJXBYgOZ1/IVxpKyKGtd2FU77leDfz
         u6sH7nzy7vfQYM9VTcM5s7BDrYPlm0rDZQqCbrEcZg0OlUCX1rUgcHSb6d+lCBnFOqM8
         isSIX8I7nylg9YCRs90RtdPpU34xQprLmvd0zFkb+oekEKZ6gMMvcU5BiiVbjD3lVagA
         +GG5sjjDxnjaZVEhEa+5y2aIfNUy8i5WiwEd3f2IdnmVc9Dvx9acBtwsMguw7pgbsMWX
         yCvVwG9DvivbpHmPp64YZYdXO6fEvHyevgtpR4iuDyB+eMR0Nhoc0h1TEvBkg2xG/MUg
         jCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784512952; x=1785117752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fZjEI+rH+GkZRFlNAE3Vjq6nP1qdwM39GIwm4i94NEE=;
        b=n5nCZ+rFHkBihxf6SY93SihjxIb2AvKH+zH7xmaS3VtbqqIgLBn8RJeO8WZ6YrR1S/
         KGnwcN+zdYacz4L+gffkksuan1Cm2+DkKLCgB4seqUyCaljiEPBig9dHiPrDoOV76aMF
         +PnZbvU+c2Rn65Ch8/s5BiORMWOVVpyStDCvM/E+py4IoJu7gy3PrrtCVWgt6ACtIVDp
         b6BchC7vxEwuSiUh2dhBz5osGnVoDYwrYZqN0xuJivgCDbpAWsSZVN6NbpcwyUDPzLzM
         cVgMn8S2hSG7XPoYQiSInWeRRUYjPcKvbZCSL5ghOirgoVPETWe5QBHW0OjYXVuwRp07
         0kDw==
X-Gm-Message-State: AOJu0Yw0oZeoBsIhWnPaQ1nxaMwBUFkPywFqti2LzxCCM8+1Kia3UO5p
	ql2LyBLdCiRhWuEojIpk4AMhFwIowO60bQkkWYJNLE8HxG2oRTmMEXRCD/n8yg==
X-Gm-Gg: AfdE7clBrWiOuXIFq3XBodN4Zic/Zu/2qYpfNQRn635VAeUjN29EYqdlvRv3E6snPQc
	xd3yTovdEXf6RBLC/0RXX7lg33u8LdlLnUgLUVI20SDAtJjofSUHOj5V/YMNHqUJVDWzq/nUlf9
	XLa2zSi+G1qcb32lTcsuVtsv9tQWUMz2iMV9ICK8dDxmL1ks8Zcz8/yF1w+dqd+HcluumkArEJ1
	xzPy05zEgVf8rXpBCySWJhhk9vvuMFTwrikkdw2mVTvYXK8Tsvw5kRlS9RbAv6yeYAGy79Ab1Bv
	ifGmlWjKsc5PZvdMY9kgthGZVaaMxC9YxOhlUMaYjmavhsmNfcwO+aJdpC69IkHa75Kn7r9cS9L
	VfHAMCXayRxzl5Rv/H5KwLlL19dO6ntm/N4Hkuy7LQQjUD2XElBzglfTrRsqIzRXfBlMht8TSzD
	B3TP3gZuCuuO471Ow1qlkDjIo96lUi3QPXuGLRWdYdwzyXOzXjZvi+Rp4dIfhw1MZYzQMvJ2W97
	jKY4mB2w0xMAjP291BNUK7BeI8pKYzvKxchN4Cqoi7weFKupLmhSOQ=
X-Received: by 2002:a05:6214:600d:b0:907:8960:fb59 with SMTP id 6a1803df08f44-9078960fde1mr75673126d6.34.1784512952081;
        Sun, 19 Jul 2026 19:02:32 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9077871d06csm81613826d6.43.2026.07.19.19.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 19:02:31 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] ata: pata_ep93xx: fix PIO fallback when DMA init fails
Date: Sun, 19 Jul 2026 19:02:29 -0700
Message-ID: <20260720020229.1972888-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Propagate -EPROBE_DEFER, such that we allow the DMA controller driver
to load, in case we got probed before the DMA controller driver.
For all other failures (e.g. -ENODEV when the DMA controller is missing
in the device tree), fall back to PIO.

Assisted-by: Opencode:Big-Pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: fix EPROBE_DEFER description
 drivers/ata/pata_ep93xx.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index 42a24dc51d26..339ee5e43e9f 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -656,14 +656,22 @@ static int ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
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
 
@@ -674,7 +682,7 @@ static int ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 	conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	ret = dmaengine_slave_config(drv_data->dma_rx_channel, &conf);
 	if (ret) {
-		dev_err_probe(dev, ret, "failed to configure rx dma channel");
+		dev_warn(dev, "failed to configure rx dma channel, using PIO\n");
 		goto fail_release_dma;
 	}
 
@@ -685,7 +693,7 @@ static int ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 	conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	ret = dmaengine_slave_config(drv_data->dma_tx_channel, &conf);
 	if (ret) {
-		dev_err_probe(dev, ret, "failed to configure tx dma channel");
+		dev_warn(dev, "failed to configure tx dma channel, using PIO\n");
 		goto fail_release_dma;
 	}
 
@@ -693,10 +701,14 @@ static int ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 
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
2.55.0

