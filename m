Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D433E3178
	for <linux-ide@vger.kernel.org>; Sat,  5 Sep 2026 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601645; cv=none; b=dQ/vCUjIaIDfv9jea429IXZuY5Lj1IBup4g12scYmW4z1v1P4N7kNd1LhMvBsaQOtGR4ALZl2ICMVhgNjJh+bvpbEKQUWX15tqfftX62yXCZNZkc6wJ3oL8A3yrzjF9rsZMBdpyEFhkAp3wkPKPVrL7fE4w1ZaOcGWqokUQObV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601645; c=relaxed/simple;
	bh=fApNG7pEOll5/tB3rqVahJ6bvMIxHk8hHb2CY3jSzQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XGA8QIMz7C4bnVp5c+wg8vmv+Fth9wB+QTLmkhlWGaGuQLvSvmkAEW7r0QmLQFe51qhjmHmPWMGpaoBj2HtK+tbsSdiR+NDg5gCA0M0A2bfeWzl3rxQaT6UjNP2hCJX2P9lcr+mo/isVnR1ouuGMLcYS+l2mzJfZMA6HGamaJdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B18f2qkz; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B18f2qkz"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47de0093c42so1547572f8f.3
        for <linux-ide@vger.kernel.org>; Sat, 05 Sep 2026 02:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601636; x=1789206436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CQmExMUpeIFcvU7MdenadgThwocm9EsyaVYoR2H42kg=;
        b=B18f2qkzikKfnKphA4OculxGEwrQf0Ep8+PaGaQYv/xYwiV+a89Zau/mKSmPPjQYhK
         jBtOa3jRCJrVMt4WrCdrseZhMIzpxP7K5HyQLvnDuBXwseT6zqLPO6oYjihWs5l5VQw6
         IaPriatQT0RC9lzvBO7VOXXAMuqADXWdKOJvgkOPcub3MdhRvpJ4b7usagxcgO1SuInd
         me06Vd1NkyrlDIAyGAKSjoDVx+LUxHmS9/9ZIUdmxHwmU25+LAqgMQ6GnyW4BcJimHcz
         24lVKx1gKbJppw7SPYNA7p8cpuCncSXDDngh0Emhlo8DhQgZWF0reb0Xaz8DR7S7DvIc
         dv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601636; x=1789206436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CQmExMUpeIFcvU7MdenadgThwocm9EsyaVYoR2H42kg=;
        b=nhWUvssJ2uEODhWObLti3s8BvoXrqQyOSbndyI6fkRLGRu/YEwuNKN97Lsvk+qHdGS
         iz5JI/BCWtwIduRz4CpFzF2/V3RiDLw11JmsX3TulNnv6YuaMQLfjlgfCUbOZOshRzhF
         2RsLyTWsBWpxHRSe3524+YQ3BaU8jdky0wQQbUdpow3rWu0TpGLuIS3MHOoj1JYDygXS
         6AIQAhFF5/rXH7a5Zbn3hTVKgAtCm2LwRKNe2v8KBOmEyJXeuG13A3LH6H978l5I51UV
         SxBc1nMFTZOvFtN+vT2Ue53rBZMat9uuvzDZwNHX8VIa7zEUA2+D8RoklbLWVwc412QA
         c5QQ==
X-Forwarded-Encrypted: i=1; AKwUvBwNrmdHBLEJbcHAIYy6uyatUfIjVINvh1RO+RqgTM5Ld61bFLQAodPftMBebwjUymafxeG2x7tlte0=@vger.kernel.org
X-Gm-Message-State: AFuF++kb+INGpM1My2VBQoP7T1bK/Hgp6YyjKlqQBlvekUzu0dimzOJ8
	ndkSzRhJpTttbBdzyfWmkRJsosol8Gzrd177p364+W66rsHERekRA/rq
X-Gm-Gg: AYBFou0dP2gMWTLJ1xrtivO0wCsDqK9S9LpPE22QbzVuD3Yc5gM/3f2HUXY2rhtMBXj
	z1S3uxM5rFoetx+JS7ZxBXZuhEa+BccE7Au0UdKDiWTWJfwUVYwL4h74zglVD5F5K+734fD49Wj
	uw9DRZHknT3Ewv3xjcw2c+0X6NeV/xW9bF6/1RSdyGPfOaj5XRM4pTLNyzhtyedFLMAfGwNYWfH
	aiiTTMn56YM/yeeapeFD1E9F0nyxzV6mFbF/FrjR6P7cb5PiVnC3AN8GbS34IbASxaMiTXZlAv8
	EBd3TX9Hen0eIjeeJT2cnx4/qsqKQaVXOiN6BxoIRRnhuTzNXR5BSwLqjap7WMePvTBAPhD8/Kv
	YjCwAnYCYbqo/jR1bP8NOgaa392ngPtkHlRrjbxDcpmkoHoip1aV/As6DdlRyM2DWcpiCd5x9Ls
	6LrmKs3bBNTXWfAdqwRgFhQZb90Abpqgrf1MDpaSxhb3mTlVi/ITVS+hmGxnnA8agY7b3kXnSvJ
	gBFstdDXst08WQms7/XvfpE8VJIPzMAu/1SLtTPuR3zbcptbz+tNFWDFLAZ1PXSQVE6h1pOZD2R
	5LEDGiBnqeHIanJlU44YjhaO7F1y/98bflGahdGOk8XsSF10gzr5etTBSdxtk+Ii+05bhvnqJDF
	4Hg==
X-Received: by 2002:a05:6000:2287:b0:485:8b5c:da39 with SMTP id ffacd0b85a97d-4858b5ce1bdmr9454058f8f.12.1788601636313;
        Sat, 05 Sep 2026 02:47:16 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm14232013f8f.25.2026.09.05.02.47.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:47:15 -0700 (PDT)
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
Subject: [PATCH v2 9/9] docs: kernel-parameters: Drop the pata_legacy.qdi and pata_legacy.winbond entries
Date: Sat,  5 Sep 2026 11:46:49 +0200
Message-Id: <20260905094649.41996-10-kmehltretter@gmail.com>
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

pata_legacy no longer has the qdi and winbond module parameters:
commit 3c4d783f6922 ("ata: pata_legacy: remove VLB support") removed
both together with the VLB controller support. The entries also refer
to CONFIG_PATA_QDI_MODULE and CONFIG_PATA_WINBOND_VLB_MODULE, which do
not exist either.

Drop both entries.

Fixes: 3c4d783f6922 ("ata: pata_legacy: remove VLB support")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Acked-by: Damien Le Moal <dlemoal@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4864e37005be..33298da28b55 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4994,19 +4994,6 @@ Kernel parameters
 			the first port in the list above (0x1f0), and so on.
 			By default all supported ports are probed.
 
-	pata_legacy.qdi=	[HW,LIBATA]
-			Format: <int>
-			Set to non-zero to probe QDI controllers.  By default
-			set to 1 if CONFIG_PATA_QDI_MODULE, 0 otherwise.
-
-	pata_legacy.winbond=	[HW,LIBATA]
-			Format: <int>
-			Set to non-zero to probe Winbond controllers.  Use
-			the standard I/O port (0x130) if 1, otherwise the
-			value given is the I/O port to use (typically 0x1b0).
-			By default set to 1 if CONFIG_PATA_WINBOND_VLB_MODULE,
-			0 otherwise.
-
 	pata_platform.pio_mask=	[HW,LIBATA]
 			Format: <int>
 			Supported PIO mode mask.  Set individual bits to allow
-- 
2.53.0

