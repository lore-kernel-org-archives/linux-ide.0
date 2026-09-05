Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE065442387
	for <linux-ide@vger.kernel.org>; Sat,  5 Sep 2026 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601639; cv=none; b=c8SMAkdYoK/kWZMTd1dmSFMmNTBth4dQBRPUu5eoXpUOy3ErT8JXcLs5BYmyTeGNY+rk5nBZOZ7xaNC1D1v3sttXoSEqV2RSM+LLI5kRVwrPachZG9XmQ1clSGmUaXJcSYVIXIMsjCU2mgXGTYFOfnjahzPoF77HlewuwV66z18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601639; c=relaxed/simple;
	bh=/cAOJWdBCi1HZBkEDQRQ71AKnd55wOx5U/6xyND51hI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WjhpsVsOXSrbJzetaT7nz91RVIaazylpkBWW2wgCe8AGvUdnUbSxv1SUvBSWHVqEisX9lvAVBl9FA8/ywxHN0DIFkc+BqZh5IafPcpPC7e+TwqoUG+nCxN1F5zjxVmTaY9HFy41doZJ3kphiefmct7ETEgylyNTnGhiXaeHpMw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFI+tp15; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFI+tp15"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48442ea8f59so2373668f8f.1
        for <linux-ide@vger.kernel.org>; Sat, 05 Sep 2026 02:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601629; x=1789206429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2UF/kDvW954cskV6VTtZlG+ZJZtMcv/59sgPBL3REqE=;
        b=EFI+tp158j2wiB21Myvk/wgCpoY7SpCPPV4iM44MN9ai29MJeDR2nrW4gt9EJ4yBX9
         oHU++5jfkKuVqZ3GyJ2Xu0+VD1oPEJnBtBo8yd+gPXmvF/j5RNQL5xYYUv3klx+f3DcH
         SsbYzLfoe1QR6WTm5fyyoQo2pDWEm3LXOW13u/4iwyE+GEOF2PPRMdcOCSAe9Z9TTfnT
         gwETBy1Tdw05aGpcBqwbi5tXmNFwvu6wDwNyqksYI2rWH2Nmgj0EIDCRYDI6gQqLbk2V
         vqnfZmOHbYl3KDfaVlfZrIwQEB6/XTcvA6AHdfLlrTfSYKkwn26eOhRk5UjGiB7xx2Xd
         pi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601629; x=1789206429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2UF/kDvW954cskV6VTtZlG+ZJZtMcv/59sgPBL3REqE=;
        b=KAt3/gwqk5ORTuSPEecDxydi4VtWiE+Fzj7B+Mqomcve/vmBhXltlfJNAe2M/BKE8O
         pS3zndFGDdlU8NH5Lj00YhFo0GIGwm3aqqkl2oCigGrOHHMEpSNrci4R2AHxlvNBZTKQ
         fD7cNdI3PnKaCDxpA+WRfRkoOefxcUCKs6UmglcjtK1HBWQFvKoDDpVGaROCffcd9pxN
         mD/sepQja9v0ig1fAoXmozwxpDtQPRFBhFTrU9miOfDvOUDl8WaqYZKprgmBOA0nuCw9
         v0Ol5Eac937cLEWqIWT3BSKVrtAgfy6YJlPFx233vs1ou4oKe1LEq3hIohesGW+YVeRC
         lSQQ==
X-Forwarded-Encrypted: i=1; AKwUvBwKYVUZ9VBMM9+jnLlLchvM2Twj35xkTcnZ0piGJI6BmLUNy84AakfQhDmb6NAFdfDBzLIESAcGVJE=@vger.kernel.org
X-Gm-Message-State: AFuF++kTmy42dJs/agZPeeU0UdBd9O96AcApr8lHttZx2yZnr13a2dBZ
	xKIaJiTNj2e7Z/QV7UDmZjDWk3Dnzghk7Yr8Wj4w4FAp4D2SN9fQwy5v
X-Gm-Gg: AYBFou2e/RugF3Urilzv6rTix1ELo3nrqYt5Q6x/0L1XAuZchLtrUgbnYS6qx+bxCp8
	nBvQM4GpiMHEyn3Wa0VaibXnfltKWk+a3VW89m8/fEJiLiPmV8OatuC1HW7AZriRAVBUEuxGCij
	6wvhbOk355zdYAh4f9AJk3ciKinIBvDLswAimv1J5rGzAoUGmy8qT7YYdbUiTYT+HR3GdC4Xy9s
	ypv6OkoePSpjJux4DICkTtblGccPRRCcRQjFG9VgFPyb6kPyXEw4cSWj4I9mNjkgPUUG+I3qyZ1
	aybPRiz7/4gGSCXcyCX3SUiKjW9i1FxYYGaFnH0sCmQk7K5ld2fhq5d6ze/dijIRdh4mo3z0ZGN
	XjaxH4IC1VMzrTSCmItJHHfMpJzkVTpWLSPOueS8KOc3xoSzkdWQLT5OV02MFhmxVCx28K5Pn9G
	qQ5JxLwuT5JzCtPcOL1+f6uDZOVhQ6mWRCFwJfgcrOTcKu7N647hXTLd+REFKc6wTdX1mMvPv+5
	H/8FH1s67kgKiAmUVM0Z4qHWTx26jJeXDMolc246PhRNUvkly2w/62tHRzWkV5FfyjdtG9kmtqq
	CLBAwilVwEGVfYsVhSSJ8N+eKj3rZ/17qketF4NwkCxmKwd9WBPcJACupDaOYHS4jFo=
X-Received: by 2002:a05:600c:3544:b0:49b:8f5e:51fb with SMTP id 5b1f17b1804b1-49cf82bea0amr94305605e9.3.1788601629194;
        Sat, 05 Sep 2026 02:47:09 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm14232013f8f.25.2026.09.05.02.47.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:47:08 -0700 (PDT)
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
	Andreas Kemnade <andreas@kemnade.info>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 5/9] docs: kernel-parameters: Drop the mini2440= entry
Date: Sat,  5 Sep 2026 11:46:45 +0200
Message-Id: <20260905094649.41996-6-kmehltretter@gmail.com>
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

mini2440= went away with commit 61b7f8920b17 ("ARM: s3c: remove all
s3c24xx support"); nothing parses it any more.

Drop the entry.

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Fixes: 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

