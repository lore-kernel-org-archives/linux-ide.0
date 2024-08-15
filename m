Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBE87DA80
	for <linux-ide@vger.kernel.org>; Thu, 15 Aug 2024 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723721123; cv=none; b=HQd+08DKSQEjfJ1FSKpP6MnohO7VIbzHd6+EaJrcVfrSHzYIK0tWuQaKbl8qYGFMAEPyOL0veMoCYj0KDdJjIa3sTWqxygrCnTYJuZXWQ/0UYAKL+JSjNHzmAUNWwqqyN0EsEo/gjY5gyA7HNyFE/lcycELBzJ5j0BgCS4+JZHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723721123; c=relaxed/simple;
	bh=9r69U4+Vlyv0XEbqFBAdBfxH7OVJ2VXkioo1Q5babH8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r5S0GzOiwmDAP3pgW6EksDL62hRyboiiCvVF5CYrAGWSOZxyxX6EwXNkPtZ7UycWCWRA5pCk1MNW60nLO2ueH3Hz0NrbX2eBR0s6KxvgjF25QWkmmsykYj/SYIA/doxPjBj8znLjP8BMZ2YpWjBbT3CcU7+PuFi0k452b1XIhzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nqnjnnJf; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nqnjnnJf"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a15692b6f6so1144344a12.0
        for <linux-ide@vger.kernel.org>; Thu, 15 Aug 2024 04:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723721121; x=1724325921; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qswmFLJc+rRJnvMK5o1RhUuE0PL9fCewlpe2LTSF+JQ=;
        b=nqnjnnJf1rHF/uJZn/spsnW74eBXGyx7YH9gvunkPJUwrsWFb+eglQrIXF6ACVucY3
         WAxYb7UHO4uJUFMaiASIx4AonUjmgQdA5yDOjm0jTaHl5iFc5yw9HWNWbqTkkkSr2BUz
         LZHStdI41ipF4c1OHTL/G1dodqC/u1TwmQHbvREf3piAWFUcJ2M4j3ycWvpiKRw4QXSm
         5SkwevxcA+yGdpbrB7w1pNUKQ3aalop59RXyBRwAODkeNb60eOhm7cQ9pHYTWLLdCypl
         Ugd4zSSmDpqFRUjlByl6zkpJRpj2/2GUrxKj5rhCNi5lKSNSSFLCRfCfaDDe3Urjc+Cj
         yQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723721121; x=1724325921;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qswmFLJc+rRJnvMK5o1RhUuE0PL9fCewlpe2LTSF+JQ=;
        b=fDwAuE1QWwgChd2BxDchBTvrTKWBx1ZI70sWt52K9BSICpcwIh+7qTLbPtsGgVgBAD
         ntSuFcG2+qaKD2Qnr1ZyGUS/YzDZ3gxlKr1asb4c0V6BLUxjvBa0RmFxYP87vPYWH4Ma
         ZtItxix4ezes+z2Yrf4LVEmTbyI5sOZ9dEEzC6ymzToWzxCLxvGL0E2RBORCH3OhWNai
         ISx7l+Zl3TykCwKmfG0paHQdsXiM4Np/TyU7hA97S/T35hiORQey/KSIpopCH0Iy58jl
         1nL0LUbqsPwFf3qwk9lmPLkudey5Mfian25juSYiiQ4QQ8y88MME9ZJ7PBRYFAIR+zka
         k1bQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8kmtW4tMtlUfVk0xvoDJCFaaN8jyS/4tKMbDx/LDHbOXuH0YmZVqjBFB751+7X2Cf1hoEZ7KZbXKPr8sNBySR147SewEMiWY+
X-Gm-Message-State: AOJu0YxPvvb+MINrJ9DbYxCDMqKlBQxb5w+REW5Ly3V5kAeC4DvY0xf8
	fpluptAeiwhj6un53BD3l7z5WDk5hsqeqBL2apKy5KATujHmP4W47uo2h1qPPsk=
X-Google-Smtp-Source: AGHT+IE04IYzhOFDEe/StHeMv+I9KreAuEIMLJabn0MgWVsiJJeJsCqyh9XE5pP5z25EACFGgtwnLA==
X-Received: by 2002:a17:907:f1d4:b0:a77:e1fb:7de9 with SMTP id a640c23a62f3a-a8366c0f0e2mr501782366b.5.1723721120636;
        Thu, 15 Aug 2024 04:25:20 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396ce0asm85941166b.206.2024.08.15.04.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 04:25:20 -0700 (PDT)
Date: Thu, 15 Aug 2024 14:25:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	linux-ide@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] ata: ahci_imx: Fix error code in probe()
Message-ID: <cbcbdfc2-ddc7-4684-8ad4-018227823546@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Return a negative error code if devm_clk_get() fails.  Don't return
success.

Fixes: 3156e1b2c071 ("ata: ahci_imx: AHB clock rate setting is not required on i.MX8QM AHCI SATA")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/ata/ahci_imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 65f98e8fdf07..6f955e9105e8 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -963,6 +963,7 @@ static int imx_ahci_probe(struct platform_device *pdev)
 		imxpriv->ahb_clk = devm_clk_get(dev, "ahb");
 		if (IS_ERR(imxpriv->ahb_clk)) {
 			dev_err(dev, "Failed to get ahb clock\n");
+			ret = PTR_ERR(imxpriv->ahb_clk);
 			goto disable_sata;
 		}
 		reg_val = clk_get_rate(imxpriv->ahb_clk) / 1000;
-- 
2.43.0

