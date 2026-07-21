Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47DD313E38
	for <linux-ide@vger.kernel.org>; Tue, 21 Jul 2026 01:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784599140; cv=none; b=YhsBZBCYTltmwoaxMlhYEWnI8JdcoUKP+Snqq1xKQJxDP1TBb5p1n/gseBr7G+C+8RJcTqLe9twxmFUdsWdFaXXbrNGjBl99k/Z1vSJ2mBEbWioXiFLCthpld+19gLHI65p/5W64K21c/p99aIlnpD1H9wr5V6vqBOFLORs+Q6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784599140; c=relaxed/simple;
	bh=64BryWhazFiSQGTHWsvVf9n0qNYmhx/nkK0q5awa1cI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MyIZgDqee/zmrU9fD3bj1h/opDyez2TbCVSmruPpnzqm3/BeV0J6a6nCf5IuUF3svpSxKXwxGIb5gczjw5ZJ1ZpcICitRiCba/CJSk594SlgqGr+8JwMd6nG32D2U9VDOk18dg3/fnqJWCl9rTwn0/WNZrVUpKKXJ0d4N6Eug8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjO3ncyT; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjO3ncyT"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso3475878a91.1
        for <linux-ide@vger.kernel.org>; Mon, 20 Jul 2026 18:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784599139; x=1785203939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4L7OFyjs0agWHOOlRPNJjGmbLFr+eh96a4dzibePYvg=;
        b=VjO3ncyTDuVE1xGsyZN5nIfQDfN3bT9y6xOspNZJar/z8Yho095fy51X2/jgsVCpkX
         DXUaopXzzJodG2yMaeijLWOccZoYAtFtB79r9xYAo98yOrp/AjgO9km03Q6KrCBd9iSU
         evvikB/RuotL1XcAGJ+ksk99JU9KI4a/LPy/Mn0gaPBw4t4bqTUk3l9IjFdnVRyiP7W+
         Kay78KmuqLQHHdOVW9Kb+VZ23vMY2tHT34cT60o7hPtGoEAyoAOxTUeu2qh4iNMsoGYN
         sWWrv65mf8lMByZxxIb3//z49rPF/r5tXmtE1k2inwfaGZC5GWrF9jPArc6pHpClDIhy
         G/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784599139; x=1785203939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4L7OFyjs0agWHOOlRPNJjGmbLFr+eh96a4dzibePYvg=;
        b=ookt12uT9brNnCu7T4F8PH4AOsJNV9T3OOKOsRvV7/N+OMC8mLwKst/tHEvlOvG77h
         yZq65dGN1yanCWIOLGPcHaarT/kM3Op8zdqB3/bXdkQkAKB/FYmMf9Tzn3pX+zYpnj5J
         NYxtdam02mgaO+0pQ0ZUzWcodEtkjR/hDZs+lgE42+b9LW8efCvASealOF4DYW1oKxTd
         itwKDdJxR7gUplxQBvb8gOcfxwTvrzoYzgKAa7h/KcX5p4d23/MeBRaPcfVoGaXOMoyW
         pHa628/AHaW7lcAxRGGbMB0rQqCRgPwKlfMdb0s2XLJf/AwTwEGJIjOLhnLCsSdpGJ02
         bJ4w==
X-Gm-Message-State: AOJu0YxFGAMxUtXofZvCjDVa+VM6oF62ajB+8tJjxJe56Phf4m+Hrg2L
	0xmouz/7KQYsH9kXTpxi4avxBw0BsivV+UJy7ugPUMAS8Oez82jQZPSzxh7mDA==
X-Gm-Gg: AR+sD11C18KMJ7WrIxwsZipJ5LuPKKZYq+A0/y3zDycwbLM0P8ucIoO4tmbuNPEBZBb
	05J7X1T9ChhEqHC8CYTrjW7vz6+CNQuusupfPoyLH8iavvP/s3ePRkYo/bPpmtve/ipewbDxkUK
	jiKBfZ55gjZiPLAHbNBQebSNtkulFke541xzCl6RJE8cj7pEUltUojXnpF8hJJOALGlTfjF1ifr
	IKpwa3sVcI8c5zznJVtfTGZZDzFpCpx1FmF9X9Iihq43ZxYKOlRRfqMjGRa9JLojek49gcKh7b0
	vlWRZUOGceiRxxFpbLpzzt1JdkOPTqA4mlevHjJkg1TCdrFb1bPbltXXy1TjsgoCvthNO4OUolR
	VFInzcoprRXt4EeILHe0YH3ac/znf9EPxYKxJxS12UHfTRGu5LrpYr4Gr9Bw+nTRsXWteTZc2w8
	0/0vOfP2PvzeHnLVRXnNh2qEqgfwi+RpQyeLkvX9mwmuH2Iu0WRdMgykHOEcXOWEoh6jDFBBfdZ
	Gz5qxdJN0E8TTNVragPSAiTxRnCjsrcbSmdnQVVTc2BPZyNkcMikL0=
X-Received: by 2002:a17:90b:2891:b0:37f:9e21:91d8 with SMTP id 98e67ed59e1d1-38e4b68268bmr15320913a91.15.1784599138974;
        Mon, 20 Jul 2026 18:58:58 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e92064c77sm620646a91.1.2026.07.20.18.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 18:58:57 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCHv2] ata: pata_pxa: use devres for DMA channel management
Date: Mon, 20 Jul 2026 18:58:56 -0700
Message-ID: <20260721015856.17503-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the DMA channel request to devm_dma_request_chan() so the
channel is released automatically on device teardown. This removes
the explicit dma_release_channel() calls in the probe error paths
and in pxa_ata_remove(), simplifying the driver.

Use ata_platform_remove_one() which is now equivalent to what remains of
the remove function after dma_release_channel() removal.

Built as a module for arm/pxa_defconfig (CONFIG_PATA_PXA=m) with
LLVM=1 W=1; no new warnings.

Assisted-by: opencode:hy3-free
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: Use ata_platform_remove_one()
 drivers/ata/pata_pxa.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index c816997dc0a9..a694f6a178e3 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -262,40 +262,26 @@ static int pxa_ata_probe(struct platform_device *pdev)
 	/*
 	 * Request the DMA channel
 	 */
-	data->dma_chan = dma_request_chan(&pdev->dev, "data");
+	data->dma_chan = devm_dma_request_chan(&pdev->dev, "data");
 	if (IS_ERR(data->dma_chan))
 		return PTR_ERR(data->dma_chan);
+
 	ret = dmaengine_slave_config(data->dma_chan, &config);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "dma configuration failed: %d\n", ret);
-		dma_release_channel(data->dma_chan);
 		return ret;
 	}
 
 	/*
 	 * Activate the ATA host
 	 */
-	ret = ata_host_activate(host, irq, ata_sff_interrupt,
+	return ata_host_activate(host, irq, ata_sff_interrupt,
 				pdata->irq_flags, &pxa_ata_sht);
-	if (ret)
-		dma_release_channel(data->dma_chan);
-
-	return ret;
-}
-
-static void pxa_ata_remove(struct platform_device *pdev)
-{
-	struct ata_host *host = platform_get_drvdata(pdev);
-	struct pata_pxa_data *data = host->ports[0]->private_data;
-
-	dma_release_channel(data->dma_chan);
-
-	ata_host_detach(host);
 }
 
 static struct platform_driver pxa_ata_driver = {
 	.probe		= pxa_ata_probe,
-	.remove		= pxa_ata_remove,
+	.remove		= ata_platform_remove_one,
 	.driver		= {
 		.name		= DRV_NAME,
 	},
-- 
2.55.0

