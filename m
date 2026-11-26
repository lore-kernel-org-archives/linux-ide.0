Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729482;
	b=DRYQcdaQLnk0gUyEOTP/YzMySq6ETLB+LVD5pjq0ujBRGd9zR2dsLpdeKb2CErUQ98Li
	 kM6kajwgUjVEMXkJzCCPFL1q0uJAke/sbVVZG6fUuSGDwqzsl/HpzHK+IRZ0MHPoQpqHg
	 poLR4ybVxym8Q+RNWCo7AQ3dO/BlSr1JIAqdBOJIyM1aMP8Tiio91guSRv7Ue95Gi1luh
	 kJg3IARpL1J8mWaZE0q6rqHJHE0b7aM8SsWNV6kXGcTPsXK86xSyDy/YyH3uZku9Qk4H8
	 UJDUxo0foteXFj3AJKq7mzv0cvQaCIurusVia/zvh/AjTekQTlUKyanAcuhl4L9vjqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aBxl91IFHxSp98BX9SH0COzdVVb1RDUdXups0y1oPJc=;
	b=BmErFrmM59lt0NIktvJYbOpzMttOFP0h60/jyhAU4i5T0lEX2k0ZTGhLf9vHmOH1H61R
	 /lMmvsJcjroqOxKsSLYdxAh82+bfayMh+UeAFa71uvzZD2mAkm/arBdt2oxwBlLrUjPNH
	 ct0nmDxXf05f0T/AY9budAK8xZ+Yd9eEdQaLltaur0+qEFkvxXYMFaCZufpsZgRyfSeNr
	 Gim2Ee1ArrT82vOmBv8AMOOYTB0tyok86MReJJJ9ZN3BNwkcrqIAI2IgV8DHVpLq7xA38
	 8jZOkliNtX/EfVAnf5IqFjkPUDfgVnpyswMwZblJJHVA24aZ5T99hMl5nKq0F1O0xTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IW6BPGYV;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5180D606A6BB
	for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 21:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5180D606A6BB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IW6BPGYV
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2f041f88577so40680285ad.1
        for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 13:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795729482; x=1796334282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aBxl91IFHxSp98BX9SH0COzdVVb1RDUdXups0y1oPJc=;
        b=IW6BPGYVOrol0f4wJZcjab8yATdY8piebeY5iaUxFJo1v9tlQOaY8ruNdgBoLdlHfB
         bzmoXiSHiG9u135X/CbTkWqp9Y/InWcVRcO9+7ZqH5VrTCbFQlL8CTj28UhGBvcpj3LW
         Ha6VdRLS9l7A0rlc/wTK4d5xmdaEv32XjOgstJkY5q6VwuthX5ygfZ3UFVT86couTDLE
         H33E8uyS9aHATUmHvQvlKPiCL01H6sJbmkTml4HYbMXkVkT4znO019VMEY4oTTG8M3JS
         DZM7SY5zLgGq9qeIx6ijRI4fEuuC6xRDvHbK9Urljii5KJzEs0Buw6hT5GFklzV0tvbd
         LlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795729482; x=1796334282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aBxl91IFHxSp98BX9SH0COzdVVb1RDUdXups0y1oPJc=;
        b=gqQPn8SPJNHxXYGgsaiSJSH2xf9mrDmDvZZ1Wpa9OpWKva/HZkJ5Liq/bvnGFfzr5J
         MgkXOIw0pS/MveJ3IPORcmKlOl0TODa4/CFoFXuTihcI5lmVltSfQeKeOcSJFcWkLcWf
         WlK/YU/DzaVjXT/EgyKqLDVn0jti5La/jAftDWYtPpXK8R/CCG3+87wpGVKn0yBl3D06
         CBVGFBDJFRg6gArP7YSVl5JN5UrKKHGVOajgg1abX79GjCeLfmzsNDTaHC60+YQFG8MC
         VEMFTlTNxAg0W+Hb021Zn8NfZeOXSkkskgU9FOI3XPsZqEaxNTo9u/u3WGBUIzQUSbK2
         XE5Q==
X-Forwarded-Encrypted: i=1; AL+hErGhupdkbrk3lCpjZUN23Sm1pQwTzSivtL/py/s2p6RkJ1cm0P5AHd/zqgtw5OAudRN856pNqfSg2us=@vger.kernel.org
X-Gm-Message-State: APuU4Z/joDawHnUglNGuzWwY7NPF/DIam6cgh6SQPm2TX6LwDuvag/hg
	R98zsl4sZwk4idMHrgQjrRwCF6/Ey4MGfyj5P31ncVEjmip3wK1h4eEY
X-Gm-Gg: AZFdTZcsnJqnCrWC6d+C6VlvWmGISb5hikHiXzKECL+/Tja6pJUcyS3cGQtX42G5OJE
	mfyqP5XYDNksazsinm/FTso3KWX7LuxiwS6rr0TgkeEYP9FC7LLqmNZ1Jn9Rh9gULazGvawN+hQ
	jatpFSsCeShhguiiedyEfHLm1AniAaPyKajtj4tkLIyc6MP8ZEy/i68yO3zp22tp9F3HquG8sKG
	gwMYgEjWIFbcE+zFPu4FyTmEthYjOr41qY2nQeXNBcpnhGtdBOt2q05bCrE+2aGBSxTtJ4SJa26
	W4PZ2lMFmavkm3HAWD30Z+4Tj614pN+z4xhN7fpYXSpov0PgJcc0/nqdMN7IvGbqCv1VYboFPPI
	plOmqxrN6NA5XOJQlq/DmsGXauE5P/nf/UC4YVQEckFHTN68o1VgK63BiAr4fUWqWHr539rVx63
	jSX+Y4TWT6x+nY2sZtpL8iBEOEWjk8p1TgDGQjhQtBRsD+d/hvYlpzDg8EPw7r+MGdBLZGV6bQZ
	8XbWncoUM97rSLXAtJ6y1LHcmJGODbHKKyo8R7Pu1B5jbK3QdXCZgEyOtcAJ3TLeeE12iAqk0y5
	bHt2/zm7M+Yqgj92bDjrd4QI8Mus0Wm+9KcWBjs1cIZfWIGl4g==
X-Received: by 2002:a17:90b:4a4f:b0:3ac:8af9:4a6a with SMTP id 98e67ed59e1d1-3b41c93c3b7mr22564159a91.42.1795729481653;
        Thu, 26 Nov 2026 13:44:41 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40f4312dfsm36176538a91.3.2026.11.26.13.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 13:44:40 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: dlemoal@kernel.org
Cc: cassel@kernel.org,
	linus.walleij@linaro.org,
	viresh.kumar@linaro.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH v2 4/4] ata: sata_gemini: add missing newlines to error messages
Date: Thu, 26 Nov 2026 15:44:33 -0600
Message-ID: <20261126214433.38317-5-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126214433.38317-1-artem122novak@gmail.com>
References: <20261126214433.38317-1-artem122novak@gmail.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Terminate the SATA clock lookup error messages with newlines
to keep kernel log messages properly separated.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
---
 drivers/ata/sata_gemini.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index 9d87603ef531..b69db749b49d 100644
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -227,12 +227,12 @@ static int gemini_sata_bridge_init(struct sata_gemini *sg)
 
 	sg->sata0_pclk = devm_clk_get(dev, "SATA0_PCLK");
 	if (IS_ERR(sg->sata0_pclk)) {
-		dev_err(dev, "no SATA0 PCLK");
+		dev_err(dev, "no SATA0 PCLK\n");
 		return -ENODEV;
 	}
 	sg->sata1_pclk = devm_clk_get(dev, "SATA1_PCLK");
 	if (IS_ERR(sg->sata1_pclk)) {
-		dev_err(dev, "no SATA1 PCLK");
+		dev_err(dev, "no SATA1 PCLK\n");
 		return -ENODEV;
 	}
 
-- 
2.56.1

