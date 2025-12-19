Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6839D23E342
	for <linux-ide@vger.kernel.org>; Fri, 19 Dec 2025 03:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766115612; cv=none; b=uD1uGKCPbYIcxU9lrMCW1EfwluenQBpCetJVAth75frpxY/c15IM9OR4OR06fJ6bH0WD1BBpb3fr1RF05ddpqetm8mdForqILKKT08UfWYVGWTCUJFM2NVgqXUygTZeFGAHa9iN5pNhvbw2trB7fFWbXaKM0FYX021y0l7JXsy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766115612; c=relaxed/simple;
	bh=+No9mWXolw6GlMzMLpvUnpKg3bymg9CNlAYJ9pLTyb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YTrXAYpVRVKMRqURg3sfOvQ5eFyJO2K3asTv11zrUCcGBPWFMkVHpwF5TQXaleMBzzyfJKXMnLBebAHXhhqbGkBGw5+Y+4wM8cZimJMFsDsRg97CL2OLz273LerKUfucYleVaWVeNUiKOrgl2VphaQqof1a5oNRMht0ifJWOwyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fh3VKUJc; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fh3VKUJc"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-bc274b8b15bso1300022a12.1
        for <linux-ide@vger.kernel.org>; Thu, 18 Dec 2025 19:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766115610; x=1766720410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ainucZVJ548kaf1D5zWh+YsPMd+HDRJnhzctZTzMtiI=;
        b=Fh3VKUJc77rnFM+huNbI/AZ2xN+dshM2G9VM9pOLlxhWR5vzU9nDBjaEKMnpW30GhR
         9oSduIWr0jnsk4eVPBUZcFOo9HI4jZDL3XdIT58jRka3/rywbsssBGsjC9Zn03eGidoo
         cyMFJq36CBpXmje+c+unwoe41YoFeDQn2Jzv1iInYAYvlxmuuzfRMN5MTk3qzl44cQI0
         YEfE0rZAmZGSR0strZ7SU9ZuzQkGQYbDNeYdOgKxfKMofRFia7W2+xHH8Ydn93K0UD0R
         1tSE5oxVhML5EoyUCGgEk9RDRyrlMXb6gXgUezm7/W0lmJ7Fn8/ri3ze0j+shfOINR6G
         79Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766115610; x=1766720410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ainucZVJ548kaf1D5zWh+YsPMd+HDRJnhzctZTzMtiI=;
        b=jNHUmplhJx4ql3EzaxGf1Auxbe1Of5JEAaM6d199DosuWBG4cFbRIn+Inz6GNBkHJx
         5Y+PYDDCrkRqDmNCuWTsf5ZuJYRiYnm5zanvVPujbJomj4P/YyyRxqfn+K9XfLCpBNVU
         eWfBFwum5Yq5sRDvCxfb0ru2EWsgTRetmgkoQAYtQ+L69ev71TRNR33Zx/MucIitVTr3
         bCW2RKV3j7svGIHNBAZMRvZYyctzxbEO5Az0Rld6g9ybXhKkodO3+ouVwZpJA1KNonzo
         9GPWPyJerTut6FKLsZX4r/fFc/Movx7lRPwYaI20bWM+ac8iPdpjVJ8IvRZO37Zm7HUG
         qFJQ==
X-Gm-Message-State: AOJu0YwYxpOViC3jh3h2+SzU+61SBTs7KoFkhyFe86kNSKgNOaYxnmwi
	pPRuMzduCl6ROXurcy+t8k8Y36Jm5O4QkOpRZFgUaPCrldz5Av+ZrUHMpeAAzIwxd40=
X-Gm-Gg: AY/fxX5h36pMvdpoQI9Su2pF8rjK7FCuBIsp+IRlrtBzbIviIt1p4Y6VWz+KWz+P9H6
	Ccuru/NwYXO1FC/rD98wSyC+2qiU2aytP3ir5Yi/TJ320dZyqlct2Dkam0oSfyDAjBpuuHVJHEB
	Fd9vc/GxCLOXAYohiJAsxnnBSW/Xt3y5GZ5MqfG7LHoZoxtqpidMdOMhKa3rBuzhFSRh1D0WOm9
	T0OLjfTTV504YxZhSA04xC7kEJfEdFeQDZK/mnPLGsJun2djZ2uWyB7GYfgu+HFssbQ9MhvOr21
	ytgkY5T+5Khy2DcVmhB7nMxQW1oHST19R7+Gkg4vcjqTnyncgNjO8M2XGRTvJBCDPeXpxcq3gSG
	04lhuztDoe0BZRWtbH7DMngCEwzJ/od+9a84s6XAhF5ET2AyLzvmf33rN0AOuXzxhABvhi8/JRe
	SXstuThWHvYUnpGeq7oxRy8CWHiPuEMW2rsY6/C7ykGTt6jotZZMNK0QxiokXh/kLYNSPwJw6b1
	U+U6P9Hd9Wxa/6L7UesevITaLd/ueP2oHpjeCLlVo80irdDMahInA04xXKa8MaqdbnYp7xa1ChR
	qdxp77eTKiR14Fc=
X-Google-Smtp-Source: AGHT+IH8bNhFIjd7v3qolBm2Twxl4rBbk7EZzcoNsSR5zDn5n9NwGpH10/uQUeKasl57BVzlBBaR7Q==
X-Received: by 2002:a05:7022:238d:b0:11b:a3a7:65cd with SMTP id a92af1059eb24-121722b253bmr1724537c88.12.1766115610443;
        Thu, 18 Dec 2025 19:40:10 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfd95sm4051512c88.1.2025.12.18.19.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 19:40:10 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH] ata: pata_cypress: fix typo in error message
Date: Thu, 18 Dec 2025 19:40:04 -0800
Message-ID: <20251219034004.14298-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/ata/pata_cypress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_cypress.c b/drivers/ata/pata_cypress.c
index ae347b5c2871..3b0e6858d727 100644
--- a/drivers/ata/pata_cypress.c
+++ b/drivers/ata/pata_cypress.c
@@ -62,7 +62,7 @@ static void cy82c693_set_piomode(struct ata_port *ap, struct ata_device *adev)
 	u32 addr;
 
 	if (ata_timing_compute(adev, adev->pio_mode, &t, T, 1) < 0) {
-		ata_dev_err(adev, DRV_NAME ": mome computation failed.\n");
+		ata_dev_err(adev, DRV_NAME ": mode computation failed.\n");
 		return;
 	}
 
-- 
2.43.0

