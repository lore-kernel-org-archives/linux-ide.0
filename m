Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF183E1208
	for <linux-ide@vger.kernel.org>; Sat,  5 Sep 2026 07:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591853; cv=none; b=YDbXtuGAPRX6xT+D29IOHFrzrkeCzjrwIuoNQPpucdbjAGM6ka5dHq5U4j5P4dscq5A6zd/PCUlrJFZsF434pZnUw3juqESR4FiwE+K/2nokFuj9BiMrZ+DRn0Pc91RmK7B+KKshR8CooBXujfMxeiSuWcLh8699WLEL6m2aksQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591853; c=relaxed/simple;
	bh=8GOJ1bBhkXnXFQ/xtc+4fZdZejRnue5u+K5BgJsvQus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=epS7CoxcshRLLM8OFnhpfwuW4msMopjHgvq8fx4YmOfe+zVizUzHulAqBG2czRr6eyHJTU2p4Ke3Hexf8Dx7qNSPcfcykVBNCMFpXvrdo+/7KmNZJs8x0dzJM7GM5nKrw1/jwNYWMoRzQzAxMXRdRTn6rfHwViAp94EBmXS4WLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RncqAtK4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RncqAtK4"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49954b88fffso13162595e9.0
        for <linux-ide@vger.kernel.org>; Sat, 05 Sep 2026 00:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591846; x=1789196646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OVDepIdvewIAkDae/qknvPHnA6zOWa1HlsWKZdzZmcw=;
        b=RncqAtK4nFcBPPTgUs8AMiwXa2wMoBlgCSap1WCpkog2HtcMl2dY0x6D3q6dmaNRdv
         dICsimEaPz30ld1lTg0ZiKxsLwFIftpMqaKvhdk05060EGt0E/TH9wY1NjnUxgLHrxpl
         xv5k835yE02E708d8v5CHjGi4xQDLYi0grCez+M8lkOCwlFNTWgxrabpNifw0coZTVKl
         3M94khTCkWfOlr56gra/i6mPDGQC/HAyeu9sioXVfRX5a2izI+B9jI0HqjvLPJSJ2uKQ
         o9xkwaqBSsK6NIKcOiZXcWQmBYJ8fkAy8Nv9UPXWxOtAtXNA6WCvCEdNkipGdHKIoSXo
         6zGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591846; x=1789196646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OVDepIdvewIAkDae/qknvPHnA6zOWa1HlsWKZdzZmcw=;
        b=kJFWyxi7rBC8RZvPxZO+OWbbAq6lKWQE8NLhLslOGlZ0kcT3VGGA+TCzIGyALunj2U
         /qXLpfYHFHkf9c7sAlHayWkkqk/1scJ8AtjOFA5G7ufsteDvSvUlL87ustXZyilIa1lc
         mljlsuDsJsYICsx29Fj76eDkV9gJyvXWgs4htQ7OiqAZhCvcYjqWGSep7rDus70M6cC3
         x8OmI6VzpCL1Ziy/maQ0H0aRrv6fM1ZwQgq6VisX7uGFOEBdtQAx1fv3dz67TCDewcgP
         oIIXyIiDqggqeLdUxD4oz/rTkeCurbWXeJUJNgGmT3ST7TPDc53IJgw5W3Pg3WqkLSim
         1znQ==
X-Forwarded-Encrypted: i=1; AKwUvBw9YocrdWV/iEAOzn1nfczW2I2WHU+y/9VFyxlv8zXapBPyQFJEeDtNBz49tF0SEdxWfVxzGAGKX/A=@vger.kernel.org
X-Gm-Message-State: AFuF++kYRfsiVVjUjFWa4AP4xPBzcluGEkGs6SlIruNJUKOJ2gnnJDXH
	wmNwRoDZX4W5RWzvyoVhUCZTusHl1ETO+Y3nGlQV3c4vCrRLDI5aWlHS
X-Gm-Gg: AYBFou1d7oAHLaPFsisexfquvGXEq1lIdP+CBCHYAjuaucxkF8cf55qsTam1xg0WUxL
	zbrMhKG14EEmSBO55NvUwAZ1l0XL/u1PP7qKNb2VYmWWVVWyI5dRv7Brho7XjBWdKfhTRDVNgZs
	mLgGCl54jYyP5Ot9SkKDEFIkckVUwqfcnF0oGEJGYJyhZ3bF8+QUh4Ccgv4CVmeCyP/AWoXwuuF
	hrV+N7K0WnSZ7QHyuqPk6ajn/DirEl9RqA8u49qHpPw7TN+5RLL9f1RGZgUdGFWpUd3zPUoODCe
	ajykMyxbKlnNKM2Bjm9VFh58A5FSHwyo+qWdnZCesav0v7oD7UnNyW9+Y1EDr118W9RAr3L+qVo
	ffJ5bKb3xkoNJaryGQeXEwMxdKL2b2GXdmMhRCOx0JX/AhmrvCpMHgHi7LoM29PElQA8Mnz9d95
	k/yiYVb8VEISmuhdb6rUWwK/yjO9YTwJh71xnad4zTJviW0YIIMEYv6OemsFhol7cUJhFMVfVf1
	On194N5TqAQVZgCRjjzPd5i/SZgwedZmgGEx5+xZ7yoki7oXP6u1f2MJ3Mu9EDZegEtAtCIxMOl
	0QsOGkamW298la/MvtRc0J7Q0V8NabYGonvWyYdAvzMXqg10EIuNV4i9uwIvidjVnwU8iMUm
X-Received: by 2002:a05:600c:46d5:b0:49c:fc6c:be06 with SMTP id 5b1f17b1804b1-49cfc6cc142mr76992175e9.29.1788591845868;
        Sat, 05 Sep 2026 00:04:05 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm12011719f8f.34.2026.09.05.00.04.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 00:04:05 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Steve Wahl <steve.wahl@hpe.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
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
	linux-ide@vger.kernel.org
Subject: [PATCH 6/9] docs: kernel-parameters: Drop the nomfgpt entry
Date: Sat,  5 Sep 2026 09:03:44 +0200
Message-Id: <20260905070347.25902-7-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260905070347.25902-1-kmehltretter@gmail.com>
References: <20260905070347.25902-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nomfgpt went away with commit c95d1e53ed89 ("cs5535: drop the
Geode-specific MFGPT/GPIO code"); nothing parses it any more.

Drop the entry.

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Fixes: c95d1e53ed89 ("cs5535: drop the Geode-specific MFGPT/GPIO code")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2ed1e2c03c61..d44728a45506 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4553,9 +4553,6 @@ Kernel parameters
 
 	nomce		[X86-32] Disable Machine Check Exception
 
-	nomfgpt		[X86-32] Disable Multi-Function General Purpose
-			Timer usage (for AMD Geode machines).
-
 	nomodeset	Disable kernel modesetting. Most systems' firmware
 			sets up a display mode and provides framebuffer memory
 			for output. With nomodeset, DRM and fbdev drivers will
-- 
2.53.0

