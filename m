Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADC3445AFB
	for <linux-ide@vger.kernel.org>; Fri, 25 Sep 2026 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364716; cv=none; b=cHwowPeKS8ulodH4aQ55dqwPspxfl22bNfU01Wy4JMhylWeQofBKzFMF7EOtPOZK+NB3uqEa3rODsTBB85EkYloUTwbzpFKQNu8ejnW7WZxJktpiaLV9C3mAMgPY5+/jDiTTdZ1G+l23zTTt71qy1HSmhZPL/KpsNMrzhf1aYfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364716; c=relaxed/simple;
	bh=cYiVeZguetQ2DZ7DdyUR8Q0IdUlxNmguR0zDq8TQ450=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OXnGNUQ/k+nQ1oF2jYQQMd3XTBAUra9gvRzq6+CCd+Hz/FU0BKQsPSULT/Nfo9u6829R7n5qcvA/bPwJedLUeO3+Lz4TbDa29MbJ/HRqTiYHMtb7iylNXAq2VhDId/kEgSOjV/AZ8Qxi4+1duU2rBHQUSkHoL9FoSvdFe3kXFgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXeEC0Yb; arc=none smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXeEC0Yb"
Received: by mail-vs2-f40.google.com with SMTP id 71dfb90a1353d-5c9ec793b6aso42711e0c.0
        for <linux-ide@vger.kernel.org>; Fri, 25 Sep 2026 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790364714; x=1790969514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BHhX4lWU7b61qXvFhT2xwAHTxPoZGFp0LuRIrYtjK68=;
        b=cXeEC0YbpkQNFZXbh3Oy6ws7BSOT5yU2I06BgJCIIJOfkFkkFyZVdNPc05uOicqz8i
         OcwJNTiOFD+SxWc1QhbujKZq9iZ5VsqWbrI1lcneBSpxN+lK2lOAvRNyRLdfgtud/fFf
         esbM7mm1VYZSO+ApJH+zeBjXojB8/5mSvk9McIwd2egHC4wRT14CktBIpi0Gh6UIHSTR
         MDrJkWQ7JeePez2SOyHhHJqqBV0it7jLLzxT73jKnylAtesKVeHElWYDNfPxXsSaknZf
         bYO/Wj8gi157S+1dA1+RxftjUpvEi9pcOnB36dm2bFJOCZqmI+fqppYBklmXzhl48shJ
         0jLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790364714; x=1790969514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BHhX4lWU7b61qXvFhT2xwAHTxPoZGFp0LuRIrYtjK68=;
        b=N1e2N+ws3Z++hM98EN20ydLcmMumR88tBb6mLzvmkqEXe/xwTRLGTadPnu6Hctl5E5
         AzZ1LL7VCPG5WNW8gsLjmGsceF1Cs2F3o8rpqg+5TKTrEffuUtBeslMNL1YDlE8e4Ojp
         BvWxan5CARs2t0mKMPYIgEANiQGDqe9LGBsEcdivmL9napiZ/fObea6M9/0pTxrBHA5R
         kgG1GKwtO3w8ivorId34XDz9+SLJvpYe0GEk0bgCRnyO1AEKc+vDvHvKqGKeHYkOObRM
         7xj1Xzxv9Ju6ZQe0k4VKbHJEPACxmYbZ/WqjccqtgqreFlLMGswLsjHKrcltkv3MwYf9
         ZimA==
X-Gm-Message-State: AFuF++nMIWvX1JZW/VubmsZzxnasxZ7iP2iBOh57w71Apx6oLFhvIAz+
	vkD+fbR5OSUs8JLrJHKKHBrlYXOIvQBRXI400QLlW1ByzDnW+ZcdzNVI
X-Gm-Gg: AYBFou2OhmBugghLwZre7tJGcGCeyhyhbCemc9LnegKBs/LEF0x+IPsqvon0P4zRg7Y
	1W7Ug9+J/HCh1TvqBNvbrcuH7T1QbNYaSDwyoazF3qZAFPHW3hUwaYtCOwtshVGLjMgjEBqGaxA
	9EkV+Ah0+1b5xWZ3j2RjvQBIb0zczfvP6or97wPQXW0NCmtgKQc5m6m0am3FgtEBkJxwVISP2pI
	dl49Ecr1zul5+59fHGcl9ogFyEZrKVRIfR7sFLsA/Rn8b0XUeNnjplC8xajk+aufoHyjYYzB7GO
	y/xtlmzDmED7F1M5GQduVNOzWsRuXkDqbelsR5/Y6n2M112rJK0KpZC7duD7jszwwp0tMuDzwXI
	OeToT1j/jUsHJJg/l02q8mu4yj8OKaujC1jdzLmEhpLZSJTY80gDzIMaJD6LHPsmmQss+tr8Fa+
	/BbLMnaitv8Du4DoIKDvTHzHG+X6qMH1hqtjFJzWN/FQAWvKVI+kkhZh4hviJlo93LrOBUiKLAo
	dC0/QmtixeBpuO75y7vl+UJdtsTiA==
X-Received: by 2002:ac5:c7d3:0:b0:5c8:39c7:ba55 with SMTP id 71dfb90a1353d-5cb061001fdmr2264470e0c.0.1790364714250;
        Fri, 25 Sep 2026 12:31:54 -0700 (PDT)
Received: from Tifa.lan ([2804:1124:fd10:e01:5236:1a05:963b:44ce])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cd23e654e8sm2043280e0c.16.2026.09.25.12.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 12:31:53 -0700 (PDT)
From: Carlos Junior <cjuniorfox@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlos Junior <cjuniorfox@gmail.com>
Subject: [PATCH] ata: sata_mv: enable SoC SATA LED presence indication
Date: Fri, 25 Sep 2026 16:31:34 -0300
Message-ID: <20260925193134.114566-1-cjuniorfox@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the SoC SATA LED controller in mv_soc_enable_leds().

Set the LED controller enable, device presence multiplexing, and
activity blink bits in the SoC SATA host-controller register. This
enables SATA device presence indication on boards using the SoC SATA
controller.

Signed-off-by: Carlos Junior <cjuniorfox@gmail.com>
---
 drivers/ata/sata_mv.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index d260f04e6..4a6a6dc7b 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -251,6 +251,7 @@ enum {
 	SOC_LED_CTRL		= 0x2c,
 	SOC_LED_CTRL_BLINK	= (1 << 0),	/* Active LED blink */
 	SOC_LED_CTRL_ACT_PRESENCE = (1 << 2),	/* Multiplex dev presence */
+	SOC_LED_CTRL_ENABLE	= (1 << 3),	/* Enable SATA LED control */
 						/*  with dev activity LED */
 
 	/* Shadow block registers */
@@ -3382,12 +3383,21 @@ static void mv6_phy_errata(struct mv_host_priv *hpriv, void __iomem *mmio,
 	writel(m2, port_mmio + PHY_MODE2);
 }
 
-/* TODO: use the generic LED interface to configure the SATA Presence */
-/* & Acitivy LEDs on the board */
+/*
+ * Enable the SoC SATA LED controller and device presence
+ * indication on the board's SATA LEDs.
+ */
 static void mv_soc_enable_leds(struct mv_host_priv *hpriv,
 				      void __iomem *mmio)
 {
-	return;
+	void __iomem *hc_mmio;
+
+	hc_mmio = mv_hc_base(mmio, 0);
+
+	writel(SOC_LED_CTRL_ENABLE |
+		SOC_LED_CTRL_ACT_PRESENCE |
+		SOC_LED_CTRL_BLINK,
+		hc_mmio + SOC_LED_CTRL);
 }
 
 static void mv_soc_read_preamp(struct mv_host_priv *hpriv, int idx,
-- 
2.54.0

