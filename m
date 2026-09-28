Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C314C33C0
	for <linux-ide@vger.kernel.org>; Mon, 28 Sep 2026 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602272; cv=none; b=IJVY07XawWJOOZzUKqTLpDbnucldxMRpQ45bQcSb8VBp93aF1HS9FXBVmakqs089r3z7Ty4JBPOtV5fSJ4dOCBGIzbGC9UyQbU4UL1cbvz0lP7L92R247C5E2hTuE0iug1zB9onA6RdiD8kXnTX6xWweF2s+b23bvZJP+OnlUhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602272; c=relaxed/simple;
	bh=vdJcUNXVf6ubcPaHSEolYRdRyjYP6m16nV9wayNlaR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7/ASs27tI1pjoBhxi3OSUBxEGBijYGuCm20cFufC8S69UHAC5T/l2lnX/EKTnUsu0kDNqAXRB+kGpXRJ6y086GAFT7BWapWRgn/s/SzKM8i+fL5Fsiimo47qvOlML41xCrUHVT5MpZtX+yybP3dNIIFn2mcf/+TxGMlsT3ibpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/LGRvbY; arc=none smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/LGRvbY"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8a883d8ceafso1766947b3.3
        for <linux-ide@vger.kernel.org>; Mon, 28 Sep 2026 06:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602270; x=1791207070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QJ4wgpPMfRYUeEZiyDIFI8sI0hTBjDqpCbT7VCB6BkY=;
        b=Z/LGRvbYWphCJcZH8PJWWgy5n2aMB9FiERg27Ux6E3gn7wS/HI/sq519B5+Lmg7Bwu
         nEN0383auEBYM2WigP0B/555ZKe9nbR+YBTIHGU55qeDGMWqgyMNy2d1MhzKiMTacLtW
         sOvNH4L5OWBu41U0NJZpcT5BZKh3DX8I9SxEWahT2kXheDl/wFnAk/m9E0uWqvnEe83i
         VZzp6dR8k4GCUeuVfKTXeCsYCGWQXUxkMZnmjdmdwhEmSx3jIVNjM+hcSBDDGnTX3u9/
         ERtXRBZ+L3YnXCNAP/BM+lhn2XFLF7DPWTAGydoudHH3FprlIiIWQhkIkXkCtXwrcilA
         NnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602270; x=1791207070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QJ4wgpPMfRYUeEZiyDIFI8sI0hTBjDqpCbT7VCB6BkY=;
        b=IssE3PRHUkUWVXmsVS+uzjuwTNu7gzmxZVm5FsFbPHi/2EmtdsH8Nl57vRsgk9dpJW
         w6EC2jkNLD83RV7yFC/lUWDIlF/V13I9iPI8UsWj+3yNmzYnNJkhh2j/x5D9UkXXyt5u
         Wf+ta3ErK4rgyKW8XX91QxDO/5KGjd3qudJEAVMGAeJ35YFW0ik0YO1w/4Sw3uI3KNjh
         n8YaTNNuc0u198+kjNNrHDZlDAJO7uTL9LB3agsENqIYjR+hoqq2bucGgOlzZk1MLrlR
         L+i9u13L1l3t/0tRrOwrxazcdxTWAxg2iBJyoIoQXHwQEWowpDqRM/jUVBEunvb4nK85
         tG5g==
X-Forwarded-Encrypted: i=1; AKwUvBzvlVZ1SeInQsBDOpe2F1UdYOOFrBlA1m9sMT7/wRU03WEoWhn/zNj27XFXUDVheR1iT4lJuIGSO3A=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbjtaJmOI+gqNBgkSPu9tSx5C82mELWHt6Ws7DHyyakCnA9P+g
	LPKX6h9guWRkV9sGV0T5GqvM5MHXmNAuzUn2TgNP1EUyMA6gCFsdDSPR
X-Gm-Gg: AYBFou2xK+7cu9/XvwhycMtFsoqmFEiWMVfOL8Rd9+gVobRKVyrZxPziSZL5c37mvrO
	ZPKxXbR47iucyyrtP1LJjUeSVRpoH9uW5OJBZUf+KAjVwKwqV1yf/XRAMXm9lI7TqdHqjJqtn8o
	OzwblGvVICjBUAWfaiuA+kCofdC+aD33yDc2/cLMR31flUnJW7lWJdCRn/+4NpY8X4hI33+y8Uo
	KouXoMnFN0hU8XyoNg4z4Ukh0g0Ci8VuI6U6la0shuWsWIR9MNYRW05ZwOw2JmdBL2LTWAdyRDB
	VUbvLAN8Jj12PRtAGk0nybLR9PPsCRcdBXMJIZqpEzjb/mVvN+Uuk3EsPwZzF4he8GPV8hY0PrF
	SgBWc+ektaxNET+w8ovZyWcooBR5F2dKWiG1QcCwSaNdDcJXreOqK/6+dTz1y49q6kcFZlhkagh
	jlXVvPamahMrA6KsJpC/VjR6Y2fJPprdubsEps/xAfmJm7EvoyVUHkv3yrcKDEX5wOKeZZAaLVi
	yu7iN31IcjWJNh8KrCo9KL5evepDIzKqAZa2v1Bzg==
X-Received: by 2002:a05:690c:74c9:b0:862:7bf8:287a with SMTP id 00721157ae682-8a84c0c3baamr88271717b3.4.1790602269651;
        Mon, 28 Sep 2026 06:31:09 -0700 (PDT)
Received: from Tifa.lan ([2804:1124:fdf6:bf01:7b7c:d58e:4ee8:14ac])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ab33cb27e1sm3571267b3.34.2026.09.28.06.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:31:09 -0700 (PDT)
From: Carlos Junior <cjuniorfox@gmail.com>
To: dlemoal@kernel.org
Cc: cassel@kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlos Junior <cjuniorfox@gmail.com>
Subject: [PATCH v3] ata: sata_mv: enable SoC SATA LED presence indication
Date: Mon, 28 Sep 2026 10:28:18 -0300
Message-ID: <20260928133040.222155-1-cjuniorfox@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925193134.114566-1-cjuniorfox@gmail.com>
References: <20260925193134.114566-1-cjuniorfox@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the SoC SATA LED controller in mv_soc_enable_leds().

Set the LED controller enable and device presence multiplexing bits
in the SoC SATA host-controller register. This enables SATA device
presence indication on boards using the SoC SATA controller.

Signed-off-by: Carlos Junior <cjuniorfox@gmail.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
Changes in v3:
- Simplify the writel() as suggested by Damien Le Moal.
- Add Reviewed-by tag from Damien Le Moal.

Changes in v2:
- Do not initialize the SoC SATA LED blink bit; leave it to the
  existing NCQ LED blink handling.
---
 drivers/ata/sata_mv.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index d260f04e6..c408d04d9 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -252,6 +252,7 @@ enum {
 	SOC_LED_CTRL_BLINK	= (1 << 0),	/* Active LED blink */
 	SOC_LED_CTRL_ACT_PRESENCE = (1 << 2),	/* Multiplex dev presence */
 						/*  with dev activity LED */
+	SOC_LED_CTRL_ENABLE	= (1 << 3),	/* Enable SATA LED control */
 
 	/* Shadow block registers */
 	SHD_BLK			= 0x100,
@@ -3382,12 +3383,15 @@ static void mv6_phy_errata(struct mv_host_priv *hpriv, void __iomem *mmio,
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
+	writel(SOC_LED_CTRL_ENABLE | SOC_LED_CTRL_ACT_PRESENCE,
+	       mv_hc_base(mmio, 0) + SOC_LED_CTRL);
 }
 
 static void mv_soc_read_preamp(struct mv_host_priv *hpriv, int idx,
-- 
2.54.0

