Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346083749F0
	for <linux-ide@vger.kernel.org>; Sat,  5 Sep 2026 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601633; cv=none; b=m9MYuL8Rhk+LI1g8oRcQcliipxy5zOsLwe0Krr0XBQTQj50wuR8OvQTtKTCv8PXgsjuxVZ/LbMLNX8zlmiNH3SmFkor+GrK6owh8iyTbL9Nu3PXmlbjeq8Fw0djpUmNGZ07wihKhnh+WsrbDHcmQ7MNKqN7Bet/4Z2QXk7rvRm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601633; c=relaxed/simple;
	bh=BaEoG/6SLaF+j+PN5tp7+Wdp37OedR46Vcq2/qxVkD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G0PCoDTHEMeI3wOIH8E8j0XQP0ZFT4V2cE2DWAb621Gp+n/QbTtBWdzv+mRjESmxg4+skdfaG5NzyQSpqureaiv2HHXgpCcLigwVs6MNF4TKX+5R6QCpPTxVY9gqfO2mPR2UeMbOEblgAI8a+2Xbk87+yn+wVeQPuo8Ku4Hiyz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sUm8EgSF; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUm8EgSF"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-485850cbac3so1182481f8f.3
        for <linux-ide@vger.kernel.org>; Sat, 05 Sep 2026 02:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601624; x=1789206424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8I1Jlm5MucKkfjFwaOiA/wi4L8q8pr7cNwUH5XJFU8M=;
        b=sUm8EgSFwuePVR3dg/8YeD3vvUCBHQyHHnli9XsusR7+vKD9DDfKLAcOuqxV//tEjW
         bkQXVykoOZYpgWQtwadrXsG60ZWuob8YKhNQOlMpED8Vk5Wq1OmepQwNLFTYE6mHke91
         PXt43eSDBYW5Qy61QkbR3trMXG79Klg2Ib1TuQT9xyxDyAqdI47TYUvTLLuWntcf0Zx0
         uVOjx9mMgo+mOVdU0gyCodl4l0Q4Visp/sm148NDD5eWQZ9gMf7DoPuhujlRgnfcmHGo
         bPHxEDLBltbFqDE+NBRq7Kz+3RpiAd5tSck4yhiJQmLb/UMVxDlDT2QsPYRPnJCdMr3Y
         QmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601624; x=1789206424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8I1Jlm5MucKkfjFwaOiA/wi4L8q8pr7cNwUH5XJFU8M=;
        b=h1FEfyZ0l+24Hff0kyWaMfCgAX+Bfg6M7F8XJfbcDyWOieYG+IEtFGhcZlJ42OIkgi
         bLZNY2N4EVtP4TJVlPrkYaftQZEaqFwVG+c4JDPLOImtNzONyIQbNav7ipNM6z8ehoJX
         7jxOsHXxlkiMxZit+w9rJ7qKV2ooJy9hRWq3sD/lV+ptmyfT++HF9NiwzY1AdgDj8Kyw
         YQizftvRVY/S0xlYk6Vl0J6nhd+09VlkP6U/PbV8R2aKR3vJu4P1/l7ouT/qOiSCNy13
         22efLhWvCyyCj+g3LbSR3jEWjjOy2jpb74weLTkqplppvZuzZIcPsdRo7GrWe07wg4E4
         uoBw==
X-Forwarded-Encrypted: i=1; AKwUvBxHX9W0kHt5Tvv/bT7xf89pCMaGogkcIfBoUlDDEvha9BS1CO1sXVKt7Vl3kpMaEe1CqpAseNMM8nc=@vger.kernel.org
X-Gm-Message-State: AFuF++kDZZiiuUwUwqLGVDmStjICkYWHauWBjad3qbfnKWCEOBtJo++Z
	GETHUFcHnuWVdULkjoLb4E6t146ZLKV/jkxiJeeyAt2Eh08bltqAswNV
X-Gm-Gg: AYBFou1tRTZM04+sR6HwZQ9LvjSB3OkAdUKKkhkvyoE33M7TGh59Pax8dmZMqV8aMOH
	mcOtw3EIG23UjislKcnywibTiqNM7hb8JPjp9RHoGYYdCKW3N+PEMmqHvlAA9fIe19PGrH8wtAZ
	RkJ3HC9fJePYav4wDdoFKndkVTGK2DViXyJ5mPbEL5bKmp6Ixdv+il8wrM5LN285txxUy2vsoLz
	2jcZ5gOlpSrFx9kk3mLQhTfziQGgcGjLBSRdeQWZg05dasXEsJ/GkNvDlCUjdtIBYhZsOjYM51S
	kwo3gpuTO+Q7QZVzAMQME20/7qD5485Cp067F5V8MLQaiSIzjoY3I+J4oI7qAcOG1zUXvGfkskc
	WDxRnILtylEHgII2egxCK11jJ7AnhOQmHmXU7eCAAHTrhs8lTOexcwK+6BZi++xXYZ8XKMbQT8U
	VwMhies/P03p1h0414JSN83vipyHEsgAtj/DzawEEXj8kQrjv0J9TzWUtNbAz71vnCMormzpMlh
	BLwJI1cdl9KxAxpIv5sevWZd92h+E5OwjdlKbUdM864PyNw+KMX+W4D3oZMZvD393589loR9R6U
	zFAB54BgXBIOlagabvJgIYfl1RNWtJX2y9o+MLmgGJkT7qo+op5H0iNyFevOBcqqyRjxuD2lJPd
	1Pg==
X-Received: by 2002:a05:6000:18a9:b0:485:9211:6560 with SMTP id ffacd0b85a97d-485921165d7mr3155784f8f.25.1788601623937;
        Sat, 05 Sep 2026 02:47:03 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm14232013f8f.25.2026.09.05.02.47.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:47:03 -0700 (PDT)
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
Subject: [PATCH v2 2/9] docs: kernel-parameters: Drop the bau= entry
Date: Sat,  5 Sep 2026 11:46:42 +0200
Message-Id: <20260905094649.41996-3-kmehltretter@gmail.com>
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

bau= went away with commit 39297dde7390 ("x86/platform/uv: Remove UV
BAU TLB Shootdown Handler"); nothing parses it any more.

Drop the entry.

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Fixes: 39297dde7390 ("x86/platform/uv: Remove UV BAU TLB Shootdown Handler")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c8d96de4c00d..99d5bb68968a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -624,13 +624,6 @@ Kernel parameters
 			Format: <int> (must be >=0)
 			Default: 64
 
-	bau=		[X86_UV] Enable the BAU on SGI UV.  The default
-			behavior is to disable the BAU (i.e. bau=0).
-			Format: { "0" | "1" }
-			0 - Disable the BAU.
-			1 - Enable the BAU.
-			unset - Disable the BAU.
-
 	bdev_allow_write_mounted=
 			Format: <bool>
 			Control the ability to open a mounted block device
-- 
2.53.0

