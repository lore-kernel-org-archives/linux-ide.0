Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A11F3DF019
	for <linux-ide@vger.kernel.org>; Sat,  5 Sep 2026 07:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591852; cv=none; b=SQswRL4FGbsv53RuRZ5OUENJyg6d3pZQY+VV2smYg6/4Bv8+qoAYNlM5OxC/Yv2tH2lhUkwIBYZXz+1E/yVap666Q2Or5xzXnt7O+bTmBMCBf6BcF40C7vNdaeBBQ/zDU26mUK7R/T7YrOWxd9+rlRNrnJnssL+fxe7RtsyR/JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591852; c=relaxed/simple;
	bh=snUd49mCf7brp4BBjf0T9QYSF39uzje6kt3MIufRgeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=McGItOXXKaa6K31mBnu15lAZEd7ST0dSc19BHFWDSKQabKo2aNDLDpKyx55VtTvdA+RFmgutABoaxwBGU7Wp+HDVVeTx0cpMtiIrD64CNoaqyq7H9MZaRe/B8R0zNRc/k6JDBX3VLHTV3gB2Yb3x/WNdQziKd2qx3OESanvWJvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APjuR2bm; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APjuR2bm"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-482f2ee53e7so1208113f8f.1
        for <linux-ide@vger.kernel.org>; Sat, 05 Sep 2026 00:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591844; x=1789196644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j5lgSAOpNjAXzpb467QfOiibQnaDkCl6BQceKsplpJE=;
        b=APjuR2bm2EoJb+WyneRnBa4v+b+0gb7YJpOkRd6NJwnZfsB5vS28r8J4Eu9t63azgL
         eq1CmU4amK7XdRzOAQlxkAuAZTSC27/A4oLk0uA6XvH6OpHGBkiqfyDmlBSyMDg7pFzz
         Ps2j2ajeoziQtI9nOrzA6jMUTzw4gkc3gRvl0XAP6u1m7tyoB07kFREGWR2H1636O1s0
         KvzsfVr8h4dOwetmGw9Uw4DbByCFxt6VHHAZCt+ff1H5vEEta/f4wz0ji2+cuE5X4kiG
         CGZpsXGGxqk8/FCEZEPeDQgj9tFcHWk3YpxuyyIviRghmT/2GkWgIisDHXQWhRNvwB3p
         F2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591844; x=1789196644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j5lgSAOpNjAXzpb467QfOiibQnaDkCl6BQceKsplpJE=;
        b=ZSxA4N7KudOFwUJHDahg0vnAnI/tktbQulBdyhNOzIBgaa9CquZWIF0NqDlqGyBy2s
         zadScMBQgMBDnCvoPfybAi6mp6reeGKqkmDl5VvW792RSk9MyCfDv17eodvI3U05QRym
         E7jr9LbzHJ98QcamrM4Uc4s4x4XVTfRw5OfCVdQl/VeXUnjgjBIBrDawdFdtxidO4Ovg
         Yv5ruQImegDfWsBgTnG/q770erx0mdWIDpP0NG1Mdn+dDgcmQGGKcn8TPYUg0yKfX2ji
         N/m6YaL18YvSbmKwZdqLEchEGou6/GQZcLbR44pWxfqYmnXhfU62Zn1yWKSBIC3KY+6q
         HQFg==
X-Forwarded-Encrypted: i=1; AKwUvByoavssaWWrpHWIDReIIqkVjZnHB18r0P5F0BmMTFCT8Gmbwb9OTTcypdy3if/mjNPkfS0oIbeHMos=@vger.kernel.org
X-Gm-Message-State: AFuF++kSbqIRF9hbmx/oxGPtGsNy+IHKQjIGRnLyz4IZgoxbaEWUNF6N
	xn/+W7sjSGKKwD+NzOpigrr/OrIu8FrAxr8nkIvbblLj9+sAvka1pbfN
X-Gm-Gg: AYBFou0rqtnOuxOUGzPN+Vf7xNr5yFm+NbV2fjIl6oocc5Dem/bh7tgh7JHMvj2KcZs
	AUdeHs6/bdnva3rbWvinxXU15ic99v0EI6hW10cZIAQkb9iQGV6+JzUfgwPFiZvJnpqHg5fMMtB
	43rdvKss6LvnRjQ+bm2NjonJmycfNMe8FM+W/ZrXrfJYK+O/yig73cWoridL8EqCgQA5TB4X3BS
	22jUv2SEC1dN64T/INAbarlszp5z7YSn1Lhd9uXxRS3GSESgVpzVHyvkA3E5lNKa2u2iIT+rW3D
	s3TERmVDk3p0QxbC7ujjrC6Zx2zHkBmIh5SmTxv/zVNSru7dPC20fJmIZLsnYAkzCgAndRptS69
	migkRnDFOhF2ljmiXldaSekIgAhppYAZffoLVRdA+h09SGLfurrR+iMoDi6WxFKIiFEXNUnpxf/
	vr8tOGSPH485WkAVo524uzRR9wkN9MUjzS9AWcWU3r6LZYCaBntbB/JVZLwn5UDvss90nLjFJE3
	qfyuDrkfyX2ZnaYiAzar+B6t24eRd3lQRNIBJBvqdh/rgzP66rmNp8seDWNysZIbOuRf6xMQhob
	Lz86vV4SprY+cjh8Ge7mLsPG4WMrLdFmbmLHbpoH2FMofrMdu1a5khZEtS6Dwz2huvwpPdyB
X-Received: by 2002:a05:6000:1843:b0:485:8c17:9767 with SMTP id ffacd0b85a97d-4858c179a7emr8752866f8f.41.1788591844264;
        Sat, 05 Sep 2026 00:04:04 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm12011719f8f.34.2026.09.05.00.04.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 00:04:03 -0700 (PDT)
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
Subject: [PATCH 5/9] docs: kernel-parameters: Drop the mini2440= entry
Date: Sat,  5 Sep 2026 09:03:43 +0200
Message-Id: <20260905070347.25902-6-kmehltretter@gmail.com>
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

mini2440= went away with commit 61b7f8920b17 ("ARM: s3c: remove all
s3c24xx support"); nothing parses it any more.

Drop the entry.

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Fixes: 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         | 21 -------------------
 1 file changed, 21 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f4314492953d..2ed1e2c03c61 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4052,27 +4052,6 @@ Kernel parameters
 			Enable or disable the microcode minimal revision
 			enforcement for the runtime microcode loader.
 
-	mini2440=	[ARM,HW,KNL]
-			Format:[0..2][b][c][t]
-			Default: "0tb"
-			MINI2440 configuration specification:
-			0 - The attached screen is the 3.5" TFT
-			1 - The attached screen is the 7" TFT
-			2 - The VGA Shield is attached (1024x768)
-			Leaving out the screen size parameter will not load
-			the TFT driver, and the framebuffer will be left
-			unconfigured.
-			b - Enable backlight. The TFT backlight pin will be
-			linked to the kernel VESA blanking code and a GPIO
-			LED. This parameter is not necessary when using the
-			VGA shield.
-			c - Enable the s3c camera interface.
-			t - Reserved for enabling touchscreen support. The
-			touchscreen support is not enabled in the mainstream
-			kernel as of 2.6.30, a preliminary port can be found
-			in the "bleeding edge" mini2440 support kernel at
-			https://repo.or.cz/w/linux-2.6/mini2440.git
-
 	mitigations=
 			[X86,PPC,S390,ARM64,EARLY] Control optional mitigations for
 			CPU vulnerabilities.  This is a set of curated,
-- 
2.53.0

