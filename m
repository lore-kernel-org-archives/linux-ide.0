Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B8B3DAAC3
	for <linux-ide@vger.kernel.org>; Sat,  5 Sep 2026 07:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591856; cv=none; b=JRZevFDHS37M4ZsqY/xA3gy5NsTjGUUoy8EO8dWXw8rtJWLSIojDoOcw5yFs3TtCqZFHk0D05SxSVXvIfo15PYKov9eWiSEwXjGILIgQEEtGobYmt50JKdygQOkiy1CwALd5XbjgQO/t44TLE3Ux+lYSDn14N7oqt/6vQpoRgmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591856; c=relaxed/simple;
	bh=ItZT5GNunHVnueIdaFQjAOk/BPjP1n6HkFAdihTWgYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VDteWkOveLS0sJwzf5pWv5MImf8N7uqigH7jw8gvH0mOLKPtuDuCcJG18JZUhp2e9mJ2WSdliN/Xx0v+16ewiSxw0SPgKATGRm4Afu/TcEmbqALTTnUSHgnnjVs8PkmxOHxJlPzF4J5vXMVkb4QV4AuRGU1q5rqEDzUWMrgjklI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ot2TgaTS; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ot2TgaTS"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so1910155f8f.1
        for <linux-ide@vger.kernel.org>; Sat, 05 Sep 2026 00:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591848; x=1789196648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kFzQQFmCjPVcuR+l7FGQ0u8MffPmow8qd7a6fWjai5g=;
        b=ot2TgaTSFyf0JGzHOS0qVEAf6ZxzDDZ9GbwaoviLSwiAMvTFLOKcRxlwvGcTuqHzw5
         EkRs1xP7nf03aZMrJAMt2A4vqFH6X5rfGTK0/Vyri5Ijk2c4UffB1TcG58IRkXtYgSV1
         Lqiczg4F7DVsT/bfD8Dx4iw+ZCRZ0G+oAO5ESiQxUiSEN3HFL52rQVd2QFAYy01WVJvc
         AuwmYB7H4ehU2TRk4SWu99reuV00ExXtZkNHcXcIzps/tOjkWE+FX3P8hYqnEYJ1/MCI
         dpBI0NJG8Rj8bLcFMvzVpenCY3Q55LPB62VZMu36usLLEDEOOWtHzGUhvARquerAn5BG
         Sbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591848; x=1789196648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kFzQQFmCjPVcuR+l7FGQ0u8MffPmow8qd7a6fWjai5g=;
        b=Nt0+Lams3ZBPqgWvx7OFqU5qc2LktG+HIq2hAVX62O6qmmOlAOkU5R52igznPQ+zkj
         dwGbX4wZFS1lH1csaHe827fI6qbee+ytmNcHX/rSD9HYZDuEbBQ6DjDj7UtUgoQEScwn
         3rLE8IS+/4+XYwfWC3L0t0R6l3vATFxLHtZZtES9DpjQUTCcGfSkqgCKDVzt64+yoSvi
         xzB9koNmDT+4IgKPhaWvG3gv3oYg3dg4Qn0PWyhbOxupxeWTlAS30Ik+oeQ6ArakJhL6
         qIaMDMSr/YII2E0WtiWF+ljgOuYVgcWtvKTrNHdDhKD5Rh2DPo47eGwBL/8Eeg3Lxe8A
         yqhQ==
X-Forwarded-Encrypted: i=1; AKwUvBy40Os1ujtDCtX1sCUFti1zRuaK0RRjnxcfyqRFfs3hkoyEX264Iq/8VJ5yeBCuU0z40FuS2r9bVfo=@vger.kernel.org
X-Gm-Message-State: AFuF++lNGqqhLNyrOAiq46la++ijmqQeaw2ypMd7Mg1UAOUSPT5G5zLe
	2+xIvIdLIOSEOtIs+CwWws+LLZC7yO9Gqt9geI5yh7iwMh+vrSZ8xyW7
X-Gm-Gg: AYBFou1cgD/o2kKu2R3E2e/Cvm1H8Tu/CSlOKdeXVoLfYCFpcBx+LoLPklEuitKJ5ah
	9W1iAKevoNk8rzuM2c7rmb2T5x7tDgr51CRKltU7OvyjYboZBbJTeq9Tad8ZCxQAe/yxObxoxXW
	NrrzhEEuA8nzQNjHb2K+ZbVAfGC/Gn/OFnDX7or5VdA7Hn3BOBsF7E6jxLuVRZhRAIiEap60v3e
	hVsxnzVe/7Oz7J8BXLwNfZb33SVhzy3yDWboE64gRc+vpCY/8FeC3rTjfHIDCdIjgNNi4fEdZI5
	5liKGFW3xrNYGedPOA+fNVm8XnVxB9AeDF/xSvRlQ9AGy4H8Cr3/r+71OC4L8BsAMlYq9as/z/W
	SJ3hMvU8PyLXJ8zmsUkteMnAniJcvNLa4NkNjvgwy9QaAFoEwz4KvRay4tPEIa75VGtZBywq4mH
	iCO3CEJGWv5q0qiI9AcQPSnwQ0TxLPVQkYoN7KUfCwcfDP3rA4YNgi2xchnizoNdCgtWhCNXRyE
	7Hi65FYqollFJRUY8X7KR0aIm+ym5+aJovltoq/aioMeg9wcnXIXVdb0BiP3vMrF3itGXj8Jgns
	EHMYIvQu+uyXrZSxsVc3hH6p3u9c5FQTydwpvNYDN61snRazuS/yKDPu3H2A0Vq5z8YHbQkpIAV
	PutXN30E=
X-Received: by 2002:a5d:5f55:0:b0:481:503b:b663 with SMTP id ffacd0b85a97d-48587091856mr13328658f8f.18.1788591847580;
        Sat, 05 Sep 2026 00:04:07 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm12011719f8f.34.2026.09.05.00.04.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 00:04:07 -0700 (PDT)
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
Subject: [PATCH 7/9] docs: kernel-parameters: Drop the omap_mux= entry
Date: Sat,  5 Sep 2026 09:03:45 +0200
Message-Id: <20260905070347.25902-8-kmehltretter@gmail.com>
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

omap_mux= went away with commit e9f5f1e45608 ("ARM: OMAP2+: Remove
legacy mux code"); nothing parses it any more.

Drop the entry.

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Fixes: e9f5f1e45608 ("ARM: OMAP2+: Remove legacy mux code")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d44728a45506..48dd273eaf6c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4765,11 +4765,6 @@ Kernel parameters
 			waiting for the ACK, so if this is set too high
 			interrupts *may* be lost!
 
-	omap_mux=	[OMAP] Override bootloader pin multiplexing.
-			Format: <mux_mode0.mode_name=value>...
-			For example, to override I2C bus2:
-			omap_mux=i2c2_scl.i2c2_scl=0x100,i2c2_sda.i2c2_sda=0x100
-
 	onenand.bdry=	[HW,MTD] Flex-OneNAND Boundary Configuration
 
 			Format: [die0_boundary][,die0_lock][,die1_boundary][,die1_lock]
-- 
2.53.0

