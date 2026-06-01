Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEA53DC860
	for <linux-ide@vger.kernel.org>; Mon,  1 Jun 2026 18:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780338860; cv=none; b=CiH6WgGji5SpR1vs4xm3xzYmMPWjLWUi/ceVe82eJmbsyrOJURX/BwtpxHcrUcmGiFvVoJ8Rl4Ol497roecpR5/Hy/kLv8JjrdcLeEFf09p4vzi7/cWVFYyhyiPN/5bu7uhOSBr5ZUQejHzYC2F+l9JGjx1Ev2tKTTc9Qz+o0F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780338860; c=relaxed/simple;
	bh=4BlSnhxudIwdE94lQWc+rpbcBGHGiRrcSvG9E5fcPyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lF+LUmmmmDze1oy3/TegLkvkzvQNVpLFdZZTzkGwcCKu9hk5d6H4vcr8sW8aY3r35MZ/aUqryjci3bn5pd78rk2Hk3Ao00kLtUrKprYwGBHGQxFcxwz0SQMebfNOh/cGMUxHiIf9wWgaUzP7Ay+LdA1nwqzHIFpo9GU8C3BcBUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p5QJFuQ0; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5QJFuQ0"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36bcf3d2565so1834206a91.3
        for <linux-ide@vger.kernel.org>; Mon, 01 Jun 2026 11:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780338858; x=1780943658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V7IhZlFcoO6A06WsDeUJt+rgRSmIqmicbcPIOc+l2zo=;
        b=p5QJFuQ0wFyFAVd65O9UE60D2a1Q+TE/0HY6PGVyvvVr8TllgWc6IgIPocRwphi0Qa
         xw1jhcmjXo0t1NENJO5UZvk+OuYgKv2DSIV1ZHrAlihxiWkl+TE4m/7Wc3tZGvP5Hjw0
         ksxNYOxBwxwFnk6P0LyeQzsg+7oOOKtQvtCetB+JqveI3cHCPcvSIUjARU6QMCukjt/E
         LCAAABOx1HVLgVVruzPl4bDhyywB+Ut2Vyhw4TDyqLhNmtjHHjt57OxE8k9Ofi/wYInw
         lrft0SDPHpSjYIGLKLkRhV5E6ALnETyaN+CjlKbUQgMm9Ct7g2LPK2gkN7kCf44EBkCP
         vkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780338858; x=1780943658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7IhZlFcoO6A06WsDeUJt+rgRSmIqmicbcPIOc+l2zo=;
        b=UK3gK3bGsmEPiAJKS8GRB7W3BXOLAGGK/Hd7pOZAMM06ZawVjv+9DBpRouCr1u3tf1
         fYybZcvatlBiqDkXX/Kbm6wq5sCXfR8GiAZU54ZiKnLIZPD1DdniI5a77XFTGIlxKybI
         Z9RUfuJNRahbrxZzJsSL7GPw2Hg6JrFyreDUqEaweMCNSLM8rk3kBtGOkmsarlf5eZvW
         ZHVEu3b1oivUdrHCa3sze97q9KB5E3USkFaT7xJBPhzr73GUgVlgy3k/ggmlVfdjh9HW
         Rbo8mO5bSZ8USztm50HZCAOyDz9B9uZdja+6hdefFbMwjIMbHi/rBmW6rR8dPpr9/O27
         Pm4g==
X-Gm-Message-State: AOJu0Yxqh8zzEOb5WKKmBcyaHBK9QM+09bEjukbDqqGbnRDopuLQAulH
	5zIIS6N9LE6v/NK0gRnaD2fTASIVkyTYsM+ViERnTRAPAklIF4LwnYfSOxYFaQ==
X-Gm-Gg: Acq92OGhMP8AXjdeBPWPjKRm3fajSG+YLIaY1btROaAxIGroUCMd/g57UORDlCznt9G
	HaFVxba0ta5uZCfQ8Q+22iVkdkzcETb30T712yLkrfuqJavk8EqZSrk1BUNQ3NbljuNPNJcDhbo
	Dgdbvo/gK1i1aK0Y1DVCTXh7kjqEHzSIoEZyO4DsXf6KfIX/K43bWqAJNIKTSOWSKzqn/WdZTsN
	ePY7V+LraKMb2DRkH5jyUpCtgI25L1I194xoE2vFv3GRIFNsja0j2PS4U/7XaLIMqODmppBbI5P
	7QYZ/AYc0eS87/eMeD2Bh3+ptf+CFSdOPRD26hbVR42YeCVBMF+Gtg4z28sblLpAqCQayZ0D906
	ve/kjy5Bpk/MRBsLmf1aHRed3qmTyiaaln30q2A86ELZLHQlU/3rq2OaYHTSFONrqYOnGcsWHm3
	iwduibfaDEtgG6fmGcDTB7wa28uy59d9XNGHeObfH3gXIWZt8UvmuhUnCFrH7l8lyXxXaHpMGUF
	gcWotKyg27lHKsrzpS4dCkv05ABz9IDGqaQxNn1MJeyJg==
X-Received: by 2002:a17:90b:3d84:b0:369:7421:75cf with SMTP id 98e67ed59e1d1-36c501eb0a7mr12771896a91.16.1780338857619;
        Mon, 01 Jun 2026 11:34:17 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbe1a403esm6447110a91.5.2026.06.01.11.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 11:34:16 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Vinod Koul <vkoul@kernel.org>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ata: pata_ep93xx: fix double free and ERR_PTR dereference on DMA error path
Date: Mon,  1 Jun 2026 11:33:59 -0700
Message-ID: <20260601183359.11343-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If dma_request_chan(&pdev->dev, "tx") fails during ep93xx_pata_dma_init(),
drv_data->dma_tx_channel holds an ERR_PTR. The error path at
fail_release_rx releases dma_rx_channel but does not NULL the pointer,
then falls through to ep93xx_pata_release_dma() which attempts to release
dma_rx_channel again (double free) and calls dma_release_channel() on the
ERR_PTR dma_tx_channel (invalid pointer dereference).

Fix by NULLing dma_tx_channel before falling through to
ep93xx_pata_release_dma(), which will then clean up dma_rx_channel.

Fixes: 9963113e3a92 ("ata: pata_ep93xx: add device tree support")
Assisted-by: Opencode:Big-Pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/pata_ep93xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index b2b9e0058333..aa6f8172925d 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -688,7 +688,7 @@ static int ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 	return 0;
 
 fail_release_rx:
-	dma_release_channel(drv_data->dma_rx_channel);
+	drv_data->dma_tx_channel = NULL;
 fail_release_dma:
 	ep93xx_pata_release_dma(drv_data);
 
-- 
2.54.0

