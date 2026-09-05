Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18324442B15
	for <linux-ide@vger.kernel.org>; Sat,  5 Sep 2026 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601646; cv=none; b=CgDRI0Hmef5nfjgv0yMzJ2gVfNbAJl00nZBxOBasFq/YH8W9Z+oJ8Z8xLoeZRUkTOz1qT3Urer6JxwhIKNJx3M1pzpNwo3JXEU0JDbGqlniv2YFHD85KTPz21SE5J5J9I8FRovjx87Gj3t+HGHZ1awCZha9261Qnkn7xs9D/Cas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601646; c=relaxed/simple;
	bh=8GOJ1bBhkXnXFQ/xtc+4fZdZejRnue5u+K5BgJsvQus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dLatm1NZxz3AbxI5b/rHUN1pp2dSy98WpwExaUsWeIMd4vN43FLJvku6DmjIynUNU0Krq0ZEj0Z0BzJyd3shBQMkh5ZjahjnkCkIwX5qOhY9TDCN6g1jyYFmLT49til5BHx4KU2L+etGYsS89nBrcI+THzN2Id+qemzRJMuemO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ucx/KA64; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ucx/KA64"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-484392e3d33so1205459f8f.2
        for <linux-ide@vger.kernel.org>; Sat, 05 Sep 2026 02:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601631; x=1789206431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OVDepIdvewIAkDae/qknvPHnA6zOWa1HlsWKZdzZmcw=;
        b=Ucx/KA64UP7YYy5FQQDaPv4iVpJGN9cu4a6gtRoYPN/MlsoWrBgL9kqhFiscfmpZzL
         r3p6A7rGwpSo6U00Cb10wjtr+mD6z0RLWlLAGmEE8eyqONRmuXoNkL/FV689kTIzZBWP
         gqEKeCMO2k4MN8VMPu92HuDd0AlqnTh1jQBi+ZvkLa0A7mZOm9Tkn1+mZhoGemzlxztQ
         YEtV2aJBvuK1aZt1EKWgo7D5sSEqC36gCblrWzvmQX3yyNe04+mJSOI0JWRmrg1dVZ71
         oylWSAJmkL2qP7fdvg4GTZMjKK5y7eqyXLGgH/+rq8Ob1Xept9jfj6uuti0/qYNUcrlG
         e3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601631; x=1789206431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OVDepIdvewIAkDae/qknvPHnA6zOWa1HlsWKZdzZmcw=;
        b=mVsJ5LJLFrQZvaKktYkMC7rPcYMTWzPJ+3+tVDPfCJs/6iFw1gOxKtGAQt/CvOlKhm
         DOVNeDB6HcyduvM0FBb1qTqsC6WTYnqndEZuXQgPWprBCo1zGIINJbS3wUqyiw57H8xq
         NfAxbyCc9vQpzhZbieBbNom2PgG9ZrVGoNXfPSq+9/qfAeOaMFiRvyZnenyik9jbGVAi
         Ry+LZiqJmjzgmuUHZ674hswNtZQu6I4KXX3PZlTKXYx9Os13itqN3zBoDI/2Nm9b+H6r
         cURQgpzPyC11EdKxuVy0zE/fcip9/iNxlr8vaUEOPrJGIIP9ntwujKwhffuD1BCU6JTh
         RY7A==
X-Forwarded-Encrypted: i=1; AKwUvBxRhFZ6lL3mDKQ5tqWhEE8Cvw7g1efkrVqnPfWbXe4kdg9z9KVuXPUKN4Sjv2OD9gzW05EIKzg33FI=@vger.kernel.org
X-Gm-Message-State: AFuF++lkuoN7TDzDpgD2mXLgOM3XDO29LkVgBqOi1r4Mau+GebS1TJoU
	dZyXJRNUBJAJXjc0WATY1xxIui12FieDV2MLS8sXoleMYTn3mPtW5Bjb
X-Gm-Gg: AYBFou1JUZ+bsOAVdsGqYU63lUzJGlOutTaZUMaajncHs3i0o0rlqGMhM8yx6/RVxOq
	wDOUn7/a3l2vC+6xW48w0OUgHMP9KCVb+8CxUB7CCIB1tyM0eWtONM0tGxhMzlmYQykKj8tR061
	6S2EGqpSz11oSp1dZs5UOR4WGj8n/MvnRYODkuhqUEtbdSKrbqW19dNYSosNQVKzKIvzd0RsCGc
	a3NtqbGwn3iun8In1JXU0c3bRtLJvttZmd0kZwTPM+RNfVSzUxofJ0XK/+lDomwfrbK/trjWZcm
	UsAuctKthNYvcEHGRSVm1JJY0Hrh6drVh92VZMDko7Jz9NEoZEAs/8PUOfirVJ77TYrvneAoeJ6
	eJrfjGusVCjcfycDhij8lpD+snDoN9/WHkM7eRqKJnytoT3elXMOBLOD+BtUEYjhS7svCJK94X/
	d7mZqNGD2n7gztMgvR3pLrHcDnb46rRXtM0iVJI7iufBz3g6XCT+OrFrn4ZN6A6r5NOQuobH79L
	PITGqgvbbKE9FnCbERwU1QbOhrrkt9Y8+HZzF/HANAtwudIkPJneo1qJZREDtWKziraujzd3E9t
	d5VU3dx6cBbHX8AhQCbxo3gORQO44t+ZiFlA92Pz5YqwF1Wjgb9zKQXCfR7O8JCyGydm
X-Received: by 2002:a05:6000:2584:b0:482:b813:8315 with SMTP id ffacd0b85a97d-485872ac3b1mr14547032f8f.21.1788601630963;
        Sat, 05 Sep 2026 02:47:10 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm14232013f8f.25.2026.09.05.02.47.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:47:10 -0700 (PDT)
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
Subject: [PATCH v2 6/9] docs: kernel-parameters: Drop the nomfgpt entry
Date: Sat,  5 Sep 2026 11:46:46 +0200
Message-Id: <20260905094649.41996-7-kmehltretter@gmail.com>
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

