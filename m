Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C132F43801B
	for <linux-ide@vger.kernel.org>; Sat,  5 Sep 2026 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601640; cv=none; b=B5Wr2PqCyOoDdwsRYGxqfjg0+Ltoz7XLCvQzHeb79txiajVkUuF/TmTd5Y1bcTna3PClECyDn1XJ2v/vqIPhN2/dQFUQlNaF956LNumQs0X4oZGn4CZE4X9rne3SnyRgl50ubw4nktk0jtuiS0O5VyYl1sPstAsSVYiuU0cA0Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601640; c=relaxed/simple;
	bh=YsfDHjDKsIWAkoUgaj1imFKWTfOFfJnvMXwuV6H0pgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HgFUF7AdNCIyAZcycfOT8uhIwEwzRethQW47HaOvoVMG+B7dLGvRQSmPoe4JeUEsdneHG8pWgKYrRPyXzf2fNjYTGUQQqBOW+ayZ2Um9BF7H4W2rMyP9B/VL3mf0iIBjmg56G8PiHKx6SikTWaCtY+9ELhZnmTgubPd9YxynaZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WF6eznBR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF6eznBR"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-495437bb891so12847145e9.1
        for <linux-ide@vger.kernel.org>; Sat, 05 Sep 2026 02:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601628; x=1789206428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9h3cyhQ1bY0apuRrAImVycgRtlSF3vYdx1yKBS/SgnI=;
        b=WF6eznBRtkwHGPWcdSI5zmE6nOZXyfhdN2pXXayZzx0BbgJPuw+KlFuKyGt+oPL4Gn
         x5Fdmar1PYKUgTWNQMERUPVz0nv7Mxix0vYmZEYWQJJOKq2IhCwllLS0NUlGI53+Sb5v
         5/bNjxfGOVPTwMCDRyEgg8niqb1POYfm+DvWwohpgMrPJQpIvHANwiBLbEd1TEAyWkB6
         Yk0kGOVhMD6W24IF/0oUwz3EPVKNZvvniPgnF/EmaNhO2oDa4d3jzD/DgSjSYE1SDRdD
         eJVT5P/AMMCz+8MsEccoS5fKN9eLm8DUge+M/Pg7OhsbQTmPGElHSKeWCxs9g7wuy/tx
         Kv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601628; x=1789206428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9h3cyhQ1bY0apuRrAImVycgRtlSF3vYdx1yKBS/SgnI=;
        b=WzYyIarOY2louWhw6CQdHmVc1+PBw6sexVVpkNp9s4x9v7Zb3FuQ4LyY9ZgCKHAN9G
         wMLMeRWUPJ8TcXOnRaR/3bTcu9mUdNo8n9nGtkildCOeoSJFR7tXwSg2FQtqOpk1HXUI
         4Bzc4iIijlAkP5TJpqqzKAPNzw2secVLYAFJiFNUw/GnD3/TdiZGyUl5KQHwH1B7kQMo
         iQ8HiFm9QumZRkbYTnbv8XKqpDNAWtD6s7bItX+Ox53jX3aW/acLzOXwFycbU5gmXG+c
         +kQxAnSKYrLnSfWCZB6UAIFWlrYksp6+8FWPDIpp3yg9H06NFJO/+8Kwqbp4tglvIE1f
         5QAg==
X-Forwarded-Encrypted: i=1; AKwUvBxoXUXnYyGPRIdMzejQLvMO2wa4MgXL9ys42bI8sNPp4UwC5aCVEw5u9BST7h4IpQM6UGQvj7GO2k0=@vger.kernel.org
X-Gm-Message-State: AFuF++kliI5EMv5afDdCXK3ZqWyl3XcYMC7YmqtdhK/T8iCmXjH0psqE
	fVtcl68PBjAh69UCfyOE1obHaldo6tiuQlXVQXf3c+YjPY8hKroW7Qxi
X-Gm-Gg: AYBFou3VtFKBIGcPJxbAPgLZwSij7za8dY0Y1CYdWLqzTBzug+eS6rZ0vIWwWMLBQiz
	C1aTeWH+ZoBiEAzfSO2XBBe6CH8mMZ3nSTEM1gGa0sKbC+R4wQomEBJ8ExbXF9QE/TDEkGaH2gl
	lNbACqDlQLZhDIb4CWkhoZfwm6hm5T9/XUi38muJkoRpWeRLFhWLfXpL86dBwz4a0tZ2Ge24H/0
	qTRH2VJNdfK5PxKTJwHMozZontx3KR/9wkQTx/GFS1H5k+Uq36WfblT+e+vmQK/iWBA3giUinwx
	RQVRsYD1padTiOh2s7E1Luh8I3yF4rt64s39w4e3X7oDrBFAz5AO8Fe4EbE6gSeTMFamwHnQP39
	Ze+bQ4oy7f28l+GKDosEl7zzg3H3zORps5DD81D3II5Q9Fi0kU6IlU6OmlFCJpgiBd+iuuvuB7I
	avJq9fKvsLJbWRYjlJsJ3juO5EZwno6cS0QskwREWLYJRcbc6OO0aa/kBCd8EnoVaVZPDSc208j
	DGeFiednWfK95dTQErNvBY8VbbWgHSiplOD977tVfQus1K2aPtgzsH9V/5XHLwNNRBVJiMytl4b
	meYMHntLwhsUUzI9bSKzj2nROLtQ8GwovNfXJNBdzfEADryz/tcUOwA33reyqFAU6pViznwb8Qo
	axQ==
X-Received: by 2002:a05:600c:a307:b0:49c:f13d:ffea with SMTP id 5b1f17b1804b1-49cf13e05c2mr154976805e9.14.1788601627485;
        Sat, 05 Sep 2026 02:47:07 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm14232013f8f.25.2026.09.05.02.47.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:47:06 -0700 (PDT)
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
Subject: [PATCH v2 4/9] docs: kernel-parameters: Drop the enable_timer_pin_1 entry
Date: Sat,  5 Sep 2026 11:46:44 +0200
Message-Id: <20260905094649.41996-5-kmehltretter@gmail.com>
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

enable_timer_pin_1 lost its early_param() in commit efa2559f6516 ("x86:
order variables in io_apic_xx.c"); nothing parses it any more.

Drop the entry.

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Fixes: efa2559f6516 ("x86: order variables in io_apic_xx.c")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2a8d862ef30f..f4314492953d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1647,12 +1647,6 @@ Kernel parameters
 			to discrete, to make X server driver able to add WB
 			entry later. This parameter enables that.
 
-	enable_timer_pin_1 [X86]
-			Enable PIN 1 of APIC timer
-			Can be useful to work around chipset bugs
-			(in particular on some ATI chipsets).
-			The kernel tries to set a reasonable default.
-
 	enforcing=	[SELINUX] Set initial enforcing status.
 			Format: {"0" | "1"}
 			See security/selinux/Kconfig help text.
-- 
2.53.0

