Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415062;
	b=O84F72zO3KOftUXzwMyRNTywry2/RS8ND+1ggHENpprlUsmsnDf6e3Y8x4BAGiF+8Edp
	 1G9WkhLyaT3SHNf3X9f/9Uq+lM1lXsAAm5QzlsqoPjmgxSGNX1NS659XNoWlsuK9K6dRW
	 eTovyjYbCBzTI79c8Uj6LJjqJxCfiKpHHwHPygZ/K1mWEbVX4fpGxyneZHunuD9ZAElic
	 gp9hNrYibYx1MyvwC1t/sKdfnGz1f2PXIewqq32ITDp6wuGSr/ydjzjRUdrIwOXPbOUhq
	 UsP+qQuX+8OPNLPrEDIE3s4DY84OimyFC13KXCD32x4WrnV9nui1Vx5ICByLBzkH/ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=urN55C0hSRid+Cb4EhN5hFHoQJs+a/cKjFFO3dJMiqc=;
	b=LePA2rphtnoyU6/xdgjb8UGMZjz3Qh6mtdcjGMfZ+9zbRU8/kuZ3LZKs8FcYsmTvnJvB
	 60qSAae6vAUeyssIbqAYcwNxWbkjosCKetEpdggYbCYi7MxOq5g51arjAkrj+Vp3YkSi6
	 3a3NDmuLWO4iX9ij8LQipBrzAGkiWYkZwqk56w4wd2oQFmyTCLS44NCE10tpkl7R4lVMv
	 CnUOFvb/LdejRwbxynTKMhYTkVrr2+XoRlOZLWfHIr2y2somA/J3Ll1TIenGlCGdLd2qo
	 NLIr2694YoHbO+PIhkfuKitmRcaPqYyLD35eK5bWBVGag7YooY/9qUZ37/3sq1TEP/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z8SKiMbt;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06050606A33A
	for <linux-ide@vger.kernel.org>; Wed, 11 Nov 2026 16:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06050606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z8SKiMbt
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a210470b49so27964635e9.2
        for <linux-ide@vger.kernel.org>; Wed, 11 Nov 2026 08:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415060; x=1795019860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=urN55C0hSRid+Cb4EhN5hFHoQJs+a/cKjFFO3dJMiqc=;
        b=z8SKiMbtsioEG8BEDmDNhfB2vwKql5oh1BPP52d2Dpxsx/OemeCcemDPcThx6J7rKN
         cXfp3TQkAUw4V6kEU4kgeU3Bph2WMo4EetbnMJc2/Tgujrq9scp+lAQqVKjMDwI0oitt
         8E9DKhdn7ils0gksqKYfw57vlkMzxnSTg0LrbL9u6MPLBTv/kcWv6dtEaDxXigNi/hhj
         lYHvyR8vMJczlxjFroYqh3l/WOiKlAZCo+h1Wfn99u7CCPPmrjUWwryGlo/LkVQeIbCp
         9wBVHA6rFOf7pT/OIqMr1w6ybjX5a8BNhfFpsheqARETFob21JmhzpZNmee2dssuCJ8x
         2WoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415060; x=1795019860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=urN55C0hSRid+Cb4EhN5hFHoQJs+a/cKjFFO3dJMiqc=;
        b=XUsesvzO1MEqCnMBaOmPpHLwYWCxsXA0f56JR4NDfQ1fo8WX0FV7e/ZsKf+HhdDUH0
         peQ0okJIIjsJyRRcykgMV2fmalAzGa99+6t0EesMy10mUItOLbikQK+TqhFgH+Jg6A8n
         omZF3PAILPBZNLVp1r/Rhi88E3l5FzgRJ++rnMSik4/9en8zRpqRxjcXeFfqPV6HO9GV
         2V4fkbh9+1GUz6bnPgj027HzpoWX9FFNu16VDB/oJE6F93vl65r7MHvS20fo3s6XX6x6
         iB7r5KU7Qv5Az2+M3oqgxsJwkcuE0WexqGCZkCDzTpded3U2OsXuBRamPOUh5cyKmvDq
         ag9g==
X-Forwarded-Encrypted: i=1; AL+hErEjAWKmMNVUa3JpjLRXXjlrwiT0gFvy751VhqxltDaoh1CQUFVH1H2ihgWIgHiNJW7wpPmh0mXHxQw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+XAkaWHuJKY9fWgppb62lIAr/4DzNX2H/oV3XPSPmppxnMG/Kf
	3KFXn2WIJQD7Cfg8DxzTyG5naY2MHcHFuv5WxB+vNO8IhnjMEuhna02m
X-Gm-Gg: AYBFou0tkhxgcUsvr/DDcLBkZ1FbLAsZWIGWKDeTZiw7hgX+cC/YBj4upG4Quf03Jzd
	Ggzdr+DDeMZ6qypxNtpBHBGUae0XRO4FzodRbCdtGxaUHJmKn/tsFGTO/oMA4tlZk5Zr7BeZkJu
	zjpE9XC5eUPYi64kPlQem50Fze1KKl3WvgS1XNDJyhIILtKaWmjwsIgmuKNB4+bnuXplTR0klEq
	KvimkzgOeTtElIu8uhchOa0RcqV1rB2NrfhqGQ8W9OwlOKnN6CM2SkgK7qEFHahzNUPhA5d/KUI
	vm7SSQmT+x+tMv2JTbFcJtU20LAQ1WG7mxkwfipqefUYbLjrq3J9NAx55wqX22Kgt6wW0s5VmfY
	TQycfQiqbrVev/IatNB1hRfXU1IiDZWlIDqUaeDpYcNuUWNqjH3RG4BwJmQwk0dj/B1h/oD81Ru
	YYS8hSBmsRAjb/Wgrbz2GtYorAhlCCCPu7LmjMZpkE8AGCIUy0HPu+NZ8M6od4wbXES8gvDPlai
	NiCeurMz9T7WWF/tDMp2N49xDq+/QE/6s5BUA5CbGCP27Bcrp81qHRcb6gNbSM6xwjm9bsCWjkG
	0bimWcBbmzgeRcYjFcyUGurZ8FgqbJcxMWGZsrBvKGr6YU7bbQkYRIQDtiRHdOwQtpmBLVcIbwO
	OGN9iWwh28LTx
X-Received: by 2002:a05:600c:3e1a:b0:4a1:ddca:8b66 with SMTP id 5b1f17b1804b1-4ba093b967fmr58000185e9.31.1794415060185;
        Wed, 11 Nov 2026 08:37:40 -0800 (PST)
Received: from gmail.com ([2a01:e11:1403:8620:6e81:13fe:ca06:8db8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e28c882sm91135e9.6.2026.11.11.08.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:37:39 -0800 (PST)
From: Paolo Pisati <p.pisati@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-m68k@lists.linux-m68k.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	mfd@lists.linux.dev
Subject: [PATCH v1 3/7] m68k: defconfig: enable WARP_MFD
Date: Wed, 11 Nov 2026 17:37:30 +0100
Message-ID: <20261111163735.227286-4-p.pisati@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111163735.227286-1-p.pisati@gmail.com>
References: <20261111163735.227286-1-p.pisati@gmail.com>
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

Enable the CS-Lab Warp multifunction driver in the Amiga and multi
defconfigs, which pata_cswarp now depends on.

Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
---
 arch/m68k/configs/amiga_defconfig | 1 +
 arch/m68k/configs/multi_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index e2d474e8cb8f..75d91d502545 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -20,6 +20,7 @@ CONFIG_AMIGA=y
 CONFIG_ZORRO=y
 CONFIG_AMIGA_PCMCIA=y
 CONFIG_ZORRO_NAMES=y
+CONFIG_WARP_MFD=y
 CONFIG_HEARTBEAT=y
 CONFIG_PROC_HARDWARE=y
 CONFIG_AMIGA_BUILTIN_SERIAL=y
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 1bbd2aa653c0..120dc68d492c 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -31,6 +31,7 @@ CONFIG_ZORRO=y
 CONFIG_AMIGA_PCMCIA=y
 CONFIG_ATARI_ROM_ISA=y
 CONFIG_ZORRO_NAMES=y
+CONFIG_WARP_MFD=y
 CONFIG_HEARTBEAT=y
 CONFIG_PROC_HARDWARE=y
 CONFIG_NATFEAT=y
-- 
2.43.0

