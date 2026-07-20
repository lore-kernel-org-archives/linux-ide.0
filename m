Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BECF17BB21
	for <linux-ide@vger.kernel.org>; Mon, 20 Jul 2026 01:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784512218; cv=none; b=s7tmBdUfuIx8AWWd5QiAeGULHV2r4ACrDrBTHRC3TAyt+4nTy0ZR4iRkIWLLqCCnqbAFvzA0u0t087UPZvXN09DSNt7AgCTSLQWdJq0vMGmtQXV7tZ285cx6vcoYI8yWMOOfrqNyq2bWm3GsGF4UA9KSUIBmRc0qdSyfyYY5Cs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784512218; c=relaxed/simple;
	bh=DU6Ckuf48f/4NqmZmoos0Ko9YBwcRdS4grncBFeBkzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y5waEuTRfSOMbHpVMPQetjjUrJASFkK+FhuVMQI2gS3NhNBx9V4JSrDTvZkiVNPl3T5Nh31vDe3b+DwANxWbIAkspG9D8fSdq3RS5A8rWEEOv6/SPOFf23NwWCfn9GaallkZd9K28HBdzxM4S7ktzu00CWytlc9kyg50U1sey4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewE/a9t3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewE/a9t3"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cea3004256so110845375ad.0
        for <linux-ide@vger.kernel.org>; Sun, 19 Jul 2026 18:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784512217; x=1785117017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YStLGv1jhTctpq6ANWoNwXrNsS0VLH3pxJYPZv46zjc=;
        b=ewE/a9t3aQrZ4F+CA+pqli8zsMc2DJtTQnxkUxY82U8exwpklNN18g27j47NxesYIo
         bXeaK+WHjLWIvr44xvZE+gSYMTC15P0NqRUy3gaRvDTXfyrR+qkNEbhoW73ZwcNbqk6d
         fDyfSi8n29GP2r5m0wMJa4RgryU23aBkYEgj+WHURpRyf9icOB4JCLU8pH6vXQ7B3LUN
         4cM9uX6DoruIueJgMUll7TlqAHOhbo7HRhmBSS74/PoqYIImapu6iQKPdUCspDJcPhUl
         0REMxrvm7AWsY0+XibvXBQuBQAzqS2gRU2XOfckiEEI7UB6FimejqTh+zHD34NF9Eaor
         qkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784512217; x=1785117017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YStLGv1jhTctpq6ANWoNwXrNsS0VLH3pxJYPZv46zjc=;
        b=U+k6fMoukzVppoUU3xQjTO53uKtmv5XhtouLm/yu/dsK/ThOPnY4XP6HoQqibg3fpm
         atZ/mFkB924FwgJUWP+Y85+vqTujIaomm2rmQaScCaT/7TX6nuzLaE9ho3sKSqyH0owh
         5GuLcCbuW3ngWN6wvk60ahAfX6LNWg/QjBmm4OUWiapKaHBCxV2kS6gELpahQXU1eFzW
         9kyECO38uiwG2LCuOARAurwAZDSLg5g5/S+m0roAnmKed6Xr0ZebE9kbrwW7ynB/Mmfp
         EORwK6PxtczszNCBW9Xcr4PLSc4LlJ//PN3qYPgTeguIR0SCFIsC6K1ufrx1nf5sMNI0
         4hFw==
X-Gm-Message-State: AOJu0YxQw0w9dELGs3sdW/OKVxFhmd2/7hX4KwR7VQCIPU23ZAQQD6kS
	ew3dThDkEHpK4tFBaEJ+N7rHOQXbISJPviMTbekuKBYAfvFOADMj4j2HLsxXOg==
X-Gm-Gg: AfdE7cl2ORV15AEyjujRAhC3VlWuJxltsGXwJf1D3ITFlD+pGtQIPpG8cVTPTebX9zU
	YIaIHTfZ9K+YaTAHbegNsuAEukcKVhREULYOyHBJHedYVhBx6FyQzrnC4lKlQQ6mno8cdc7svxT
	HZ4PEJXPYQOabnkJM+p+sIZlKBz0xmxSPkTzj1VF/m57eTYglxU9SUDxH/R4eMUi6iE530YnspH
	TkJj0bBY/yS2t5Nq4GCZCJ5zxMWIzkBqrcX9FNKty7d0H0A/LwNFdmSCawgyPSqRNlc+lOGIErQ
	gSxQz2cPhSaxYeu4q4AyFi50YZvsZRx9DmEXhzK291hkV0q+ZA9cyD+OsYzD/38Sxep2Q7ytinD
	gI70zyA7S3xXScpqeVAfFPUPNq/Co8boWyeDzgCTm3rWYIy4aJFmXVfCuPNkuQA6Cf3txgDhmYk
	qsisQkFwok+hkuhZaMfenTwTwsGhp1eVzR0zNdjxIUut6X7trfi/3GP0S1DqwrSvfqs/QhaxhaZ
	VNfl7mNQuwkQ4dANJpW4E2KzWlymrcFU7vfl6zwgFlzgtPn3l5GjRc=
X-Received: by 2002:a17:902:d588:b0:2c9:e86e:a9f5 with SMTP id d9443c01a7336-2cf348669c4mr143330315ad.18.1784512216823;
        Sun, 19 Jul 2026 18:50:16 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344b78e2sm47174655ad.24.2026.07.19.18.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 18:50:16 -0700 (PDT)
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
Subject: [PATCH] ata: pata_pxa: use devres for DMA channel management
Date: Sun, 19 Jul 2026 18:50:14 -0700
Message-ID: <20260720015014.1912040-1-rosenp@gmail.com>
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

Devres releases in LIFO order, so the managed host detach registered
by ata_host_activate() runs before the DMA channel is released, which
preserves the previous teardown ordering.

Built as a module for arm/pxa_defconfig (CONFIG_PATA_PXA=m) with
LLVM=1 W=1; no new warnings.

Assisted-by: opencode:hy3-free
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/pata_pxa.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index c816997dc0a9..a08b852dd9f9 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -262,33 +262,26 @@ static int pxa_ata_probe(struct platform_device *pdev)
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
 }
 
 static void pxa_ata_remove(struct platform_device *pdev)
 {
 	struct ata_host *host = platform_get_drvdata(pdev);
-	struct pata_pxa_data *data = host->ports[0]->private_data;
-
-	dma_release_channel(data->dma_chan);
 
 	ata_host_detach(host);
 }
-- 
2.55.0

