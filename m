Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A64A4399E5
	for <linux-ide@vger.kernel.org>; Sat,  5 Sep 2026 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601644; cv=none; b=Tl3wX3q1Ia6EniFQ/3fOyrLJmcUyMFGtPZZDVPq6dlT90JV1CrnLdMhTTU7BYhftaJEB7INYxI7hPdknLK6XR5+zYBoXWV0VvInnZZ5/9LoddJLb2eBxXucUxnRq3w/Lid2cXSxRTk3KGoa96AdgbDCxgd8Hq1+TxhymxRI7Dx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601644; c=relaxed/simple;
	bh=iIEWAYVGI2FzX5iZTyH81lDATptMQacAG0wTPy+abXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MTQ1vaOSm0SlLJxdpbkJPX+SWn1D5vzG1NPY+P10ogzuK2YO71Gu407nRzj+3P7s3CdtcbfDZyHwQuPZL1arFFOp4beEDITHAf5CTh0N6g1JdsCMT2B/iOrj5xb5uFdB9p1/CB58uWTFsG1jHImdKwYBurR+/gU+cB+EKV2yrqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyvrpKrH; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyvrpKrH"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4843e397f74so2283224f8f.1
        for <linux-ide@vger.kernel.org>; Sat, 05 Sep 2026 02:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601635; x=1789206435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8xnteEJpCubomPwB6glv59IEZPm5BMjzUqWSxe52tsE=;
        b=WyvrpKrHJwVM/8ZcX1GSWFju4g14O4oDahiOI0OS+wcnypQuvsomCZxxoNsngGdcpS
         iMNMMyLbpjtmvW/EWl4iZ53rr0WuVL50Je9Pi/ewScX5oXjVlbyTy66vsM00pKJDHekp
         zbXJPoTpg2PVAHDnNeCDSEqB6+IXMYfMRVEYlxkySrV1FIftT3xdeKrCHXTmz2dCvBqi
         G7Nx24hz/S/2cGB8bDg0xlI/4JzXD2cIxs27X9WE+cEHW97xbSD60x2O4TuuUiiEtmMN
         gLz7tKdUexx74iuFiJ5OWz548lW326b3vnw9JZ0uUDJlkfikeabOhE0wjsV0JZs8aZoF
         EjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601635; x=1789206435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8xnteEJpCubomPwB6glv59IEZPm5BMjzUqWSxe52tsE=;
        b=hq62f/d/epTPEAydlYcx6BmlPKDBPI60y5JLwBJzq93eMUZeA80hW3ytdVmV1At7c4
         I0p16kqWE54QI9pB/sDV6EHHFvs0J97bcP9rtSKUpbw24XNaAPMRlTTYaxQfS3ZJK8rB
         I6JJoupS+KftamqDbgPLHJ7rl05ACzWk1UY0eHIA5Kn2cHJrQzdU8Wi40eC2dQ/7m/k2
         MSP+Jx2HKOr1i63zCwauDPJ3B6FP36Rei/ZG9U9641VP2Nbq9MsUxT7Rc/3+sRa3Mbyu
         A8HfCXkBxUCj47r0+isCKmJTw9vOLtb+4kGFIkSINc8XS7hW9LMNxTalU/aI3LoFL5vZ
         6RYQ==
X-Forwarded-Encrypted: i=1; AKwUvBzrCnVL48+RH4H8o9zWuYfgX/E/cKvouWOVvdBAFWUNY+TeGRfXcyc9/VgUIzYQR4sIw+ZdZcskKjo=@vger.kernel.org
X-Gm-Message-State: AFuF++ky6Bkv3tTz+5v0eDm963rwL0DBp5x6+QlHjuUBuInMM7vE79nM
	VX9qw29tNZoTDkLJSq2Y0OpuC+6hr5sesuR7LzoQb7zranTWzb54RIPc
X-Gm-Gg: AYBFou3CXsAXpyWrKsDX+4OMYmILbU64D4wmRSqe6xkkr1wFfneQgHtQHISZRyECQSJ
	+QT42X+vYT4VpZUPC6kxjf8LuVOeWBvzc4oSSU4pH0wBYguScXUqhA098I8zEGZdrW16RTo5bmV
	lMiwS+Xq4/EcnPy/LAwqHeWodmurG4ZOpo+Bu1s9tczBMWewJqwxLdDyybB7Mmfl1pSBLaCp+j3
	oO52r6KWg9g8RyntPKv4tjzRdWHieZAI2BiE1pVPeBOQRO7zO3sBb6JVhMr6nJa02SOJpzn5KRO
	M0R31iDEPl3UMkTt6QwSo/YQW5+ZYc8kPutx1LVQnIsAbW+zVbuPhwZT+ac87IzsSnRCYxe7r8/
	GBy8h66yExNxapd7pwR40xOmZO6rqnSpArBs/hyFg997wIxhC0iKUYlC6GgWo9RNfPUb6YQgm3W
	Nc8cEaqzyxCq6LlD2M7X/C8eEy30dHP24CQgwcekXRNlH/gRuaNb0n2xNveDUhhND0OqPGW/2PR
	fF2BwFSEr0P76JxRHPh15F4rOWof0Q99GuPH4FBAy50wZCTPseBwrWpDAbChMhEj6KZ7IKib/Ho
	jvlfiKcLDVOmFDfnjhT5C2EBXrXh22r8czww8IQB0PP3phQPGHT0GE/kfty3cNLQ764=
X-Received: by 2002:adf:ecc6:0:b0:484:49f8:b56a with SMTP id ffacd0b85a97d-4857e4f4adamr18253955f8f.8.1788601634554;
        Sat, 05 Sep 2026 02:47:14 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm14232013f8f.25.2026.09.05.02.47.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:47:14 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Steve Wahl <steve.wahl@hpe.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Mike Travis <mike.travis@hpe.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Tony Lindgren <tony@atomide.com>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-omap@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Michael Schmitz <schmitzmic@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 8/9] docs: kernel-parameters: Drop the pcmv= entry
Date: Sat,  5 Sep 2026 11:46:48 +0200
Message-Id: <20260905094649.41996-9-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260905094649.41996-1-kmehltretter@gmail.com>
References: <20260905094649.41996-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcmv= went away with commit 7aeffbf2ddec ("pcmcia: remove unused
pxa/sa1100 drivers"); nothing parses it any more.

Drop the entry.

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Fixes: 7aeffbf2ddec ("pcmcia: remove unused pxa/sa1100 drivers")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 48dd273eaf6c..4864e37005be 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5311,8 +5311,6 @@ Kernel parameters
 		nomsi	Do not use MSI for native PCIe PME signaling (this makes
 			all PCIe root ports use INTx for all services).
 
-	pcmv=		[HW,PCMCIA] BadgePAD 4
-
 	pd_ignore_unused
 			[PM]
 			Keep all power-domains already enabled by bootloader on,
-- 
2.53.0

