Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F34237DAA2
	for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2026 18:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289172; cv=none; b=nOFoZn7VAL+HPsHGObtXb9Gg2OQszjFbmJMlctmCtkL6RtufUrqyU19SIWgEekysUxwEcoTNgl64e07NXA/tzPhGf0XpVJg4tOzVcQgFT2OJPYo/SvreW8MyInuPoe95KjV2qc+Cgi5kjz3olbZVlac7F+OTEgi5iySlAhmJZlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289172; c=relaxed/simple;
	bh=FD8L5YuK3z3Ex4nC+p1F2vXcxLrq8qYkJAGIzH3NE+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PiYpkEkGLdp/Y+CfPwEqhy3AlSjzJRT4pxU0SCLr+7JE4VF5wlG+dMkeSuG9d5/cBqz1mZu1oBQEiUxK0FkKdVLyiHhg4posnEfSY6eGP7264JaV/GvL/VsNdLTbThOKLki8VUjTRABpSN+tMxkMQNfj8jNmYzapLYUWG6yNPLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnzB/hj5; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnzB/hj5"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c859878eb48so563857a12.0
        for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2026 11:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781289169; x=1781893969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlwNVrLPH5LbUFkkcVuNPTbBUbs81VY5HtgAlxEbItk=;
        b=jnzB/hj5yKzyQjWLS+WrsoBrrw2D24F+lASfqhqsfgYTLiHiDEzWUZr9L7I+YhoRYS
         IHephU34A/5Bo7cLRoMM3fzF5gJLOXLzpkzZspy18s20UMV9q4V8H2fEnkjkcTXXBdja
         UUgD3uCtwpO0j7TTBtB/P8Z8hv18Sre+OBFGHMbtcPW5QElav85g5FHV029+zloGhosK
         yO+XbEWuoyiVkskep6Xr0ElZYkmPdcFZo7t6NdHFimLWnmQGVln5VWzKXmPOSvheUn03
         j5tvHfNePugWPJQgZXqTrkmfaf+GKEA71ADx0FipHaUiWL2ArckPSWoHUCMZ5ll/LGLn
         /mhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781289169; x=1781893969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TlwNVrLPH5LbUFkkcVuNPTbBUbs81VY5HtgAlxEbItk=;
        b=QybkCaCpyQcs3+yvLM8py4ppPrOt2cHroWpIb/JNyBAO6WsF9dOwU4udcgUZ4fgW7N
         oWQxkhS/3IVwoR6a7bUa4bt5EdKXnhWEnbDVEaGSFwkSsAohVqKibZJ8S+PyQRA9F1o2
         kDn5y9qta7B4owSf60aaIFv0cD+gKDgDAiuBrAulQGE8/DxDfuzqSHa4ME2jJ/PKuv7A
         a3FrryQfLr/g2I4QgxcfrD54qIIBaHXBr8Gus4gjK5x3nE4Y9lA3Jo2xMAMK1Qr0rP2S
         iRw8XbHjdOPFrNBx9Io1HnW9oGW+SjY2C8op995zmx/un0uhiBeCni/QtRh25a1qE15z
         JKnA==
X-Gm-Message-State: AOJu0Yw9fDr07qQlCSZWHcHly6VCobOwZ7DrXmOZvyB/eEwfPO85yZZZ
	MkMtaOIRiIIsmk8Zeo6fJ8s/lEkJuS7ZgKuf2aRDppKxp+2B+7BCeu+pNWWWbw==
X-Gm-Gg: Acq92OEkPmhN6JoByxDuLsk9j9ItaGNqM4+okwP2H2Vr00JIXwvFqTOGqioFBTB9aKC
	/d/07/+zt68Sq1HLrvENOCT9aPSftSkZOnCBNQKhcJS0CTGztrvbg5lVcoVcy7yExkVIczGG6Z0
	AIv1w8wRpBU0y3qREXkFkGrqdIMwOdH4MsOMt0X68Fc97R3kexTQK82UNKMsjFl4qMEcUaus6tf
	eaqhmeCn9l2I1bX/qcFBJJQSlcSXbAY0qL/qvdpQFpG8frdnw8yacw0yZ4IjQf16yN4sJmm8hmb
	f45hiu7eXUrymowDxJxqiQCWEAxf9aN7gYNw6jXEwLKC9w9Rka+rl9ShCZhHt7T9FQYtnCfKQUS
	9EX41uS9x/bUEyTG9fEjxWPqrH65KwoSbjIJ0sNsOSHfkExN9VaqSxc3TBnLVeFXgYmIwWyEOAs
	xTLCdGe16LrQHjC+IWZkuw1IU3WDQgLFdO2YOVvS++iEGGDFMyuGZ28y+efYx0p+QCFhgl/b1vB
	Gd2ImBmFX9Wv/LScP3nodBtHEgndQl/XQ==
X-Received: by 2002:a05:6a21:6f0d:b0:3b5:6b5a:4f30 with SMTP id adf61e73a8af0-3b7961fa772mr898075637.6.1781289169494;
        Fri, 12 Jun 2026 11:32:49 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:a073:5e58:ab5:a167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661b5b207sm2795034a12.5.2026.06.12.11.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 11:32:48 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Tim Yamin <plasm@roo.me.uk>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Jeff Garzik <jgarzik@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 3/6] ata: pata_mpc52xx: reset cached DMA direction on resume
Date: Fri, 12 Jun 2026 11:32:24 -0700
Message-ID: <20260612183227.20446-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612183227.20446-1-rosenp@gmail.com>
References: <20260612183227.20446-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mpc52xx_ata_hw_init() is called from both probe and resume, but only
probe initializes priv->mpc52xx_ata_dma_last_write to -1. On resume
the hardware FIFO state is lost, yet the cached direction survives.
If the first post-resume DMA uses the same direction as before suspend,
mpc52xx_bmdma_setup() skips reconfiguring the FIFO (fifo_control,
fifo_alarm) because the cache matches, leaving the FIFO in its default
reset state.

Move the initialization of mpc52xx_ata_dma_last_write into
mpc52xx_ata_hw_init() so it is reset on both probe and resume.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/pata_mpc52xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 72a2b677bc90..b2e2f83aa9ca 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -375,6 +375,7 @@ mpc52xx_ata_hw_init(struct mpc52xx_ata_priv *priv)
 
 	/* Init timings to PIO0 */
 	memset(priv->timings, 0x00, 2*sizeof(struct mpc52xx_ata_timings));
+	priv->mpc52xx_ata_dma_last_write = -1;
 
 	mpc52xx_ata_compute_pio_timings(priv, 0, 0);
 	mpc52xx_ata_compute_pio_timings(priv, 1, 0);
@@ -750,7 +751,6 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 	priv->ata_regs_pa = res_mem.start;
 	priv->ata_irq = ata_irq;
 	priv->csel = -1;
-	priv->mpc52xx_ata_dma_last_write = -1;
 
 	if (ipb_freq/1000000 == 66) {
 		priv->mdmaspec = mdmaspec66;
-- 
2.54.0

