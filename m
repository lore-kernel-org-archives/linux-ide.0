Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5883DBD4E
	for <linux-ide@vger.kernel.org>; Sat,  5 Sep 2026 07:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591847; cv=none; b=DdWdbdlwt1dTVHrI52R9xFhFDgnGoNmKDqZrc4APDKjMeWe5K6XzCgQlI/v+ZO1EZt2EyHvcUKqy01A58t+ahSWiYiODGWjEiZVL4Nh9XHcPQVZu24reKn152Qh85lUVKnp4rXrr3VVZSw38F949UnTvS6imXTYK5VvtB6UhSw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591847; c=relaxed/simple;
	bh=zqIZgn7Zgj5WSQepFgJtQ9GMMyKpvR8InLxOiqTa/8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ubbOmGBTS27MB8JYlVpHbY22w4qDSbrkb+pPS64hRYEQklCE/8o3ucRszaCl1LEDmkuO2geQO97DM/k0tnVYEYn0O1UOw5lToDq7jVy32XIJxvfhH/9k5GlpzFegwX5PThqVEmAweAPe+B0zXSRuQYsZPwfa2kMaHJljkNfdsLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsSYwLwK; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsSYwLwK"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a5e392b2b3so2890587a12.1
        for <linux-ide@vger.kernel.org>; Sat, 05 Sep 2026 00:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591841; x=1789196641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RNFfTw1WuaSNgs5HCMSq2uznGZvnZVsIDtneqTMILXg=;
        b=XsSYwLwKu7HA+M9qQDLAv4qyhXqLO3Y3B2nrMauWYL5U/x9gMoPFVblanGk8nChIvd
         le6ND8o0ZGm4oLALDhgc8N7ll0NDm2ZuPPkg3BJ06DJiogDlzQZ7zgsVhbbx8LbTWTMz
         mJUu/Jy2EurM5VuMdsk3Uh3EF78ZdYkgcASPo4/iFhmVEz3GAbWH7dHmqsvIEDnJUq5t
         lb/gNVUNWETamXJAzcASXkot7DuMJvhXDEsA1GTzHxHbB2VyBuB5mB8CDW0siMQqovX/
         k/fP1XF6rKWc+9P18y9oJQoOw4mcO+2An2bQ56vnNdwBBSq7VrcBgCOkAHtz/ZsR5Mq9
         3s5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591841; x=1789196641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RNFfTw1WuaSNgs5HCMSq2uznGZvnZVsIDtneqTMILXg=;
        b=bTjKOl86wSFcXOylCWoUFXDKO0Q8ax5JsRc2lcGT160sUhs/YpPzomDS0+dSE5euDh
         Mp/8c4x4+2ycPnrRqvi0u208ISzw+CugDls/JCHbp57zM0csEe7iyVa3FYQMhrwgWZCO
         NDqME/47gcfybhgCaeGhAZRyFdxdTbOV42IwNc/v+QeoIPmor1QzN6K+2iD+jP8wA8zQ
         By8qndLx9yW+erSwUMhH7u5ZW+QQu5VVAsB8rRLXpAC2adMuIU+s/+53Au7rzxXV3m6V
         wJI1sQreRssF90Ya/KkaIPyKBtExOTssyd1lZXPx4DYs9TEtPcLVPFui2ikyL2y/L+l+
         ukRQ==
X-Forwarded-Encrypted: i=1; AKwUvBzFpcLiINuURzLfzni9eL8zZbAb9mtrfXne1rDE7VM/NjE+QLlRGgAX7LxdfQGLTJ2YfsbYv208mwg=@vger.kernel.org
X-Gm-Message-State: AFuF++mlrCEqPDvh36PMmMnSqzD0rl86mCRBSDp5YCm7tb+dI6GhMISk
	Uq/TzZTGfKP3yu0273f+b+A2z7MN9c67uefY7QhFatuqHAUE5lu9og6i
X-Gm-Gg: AYBFou3tEHyrW86O4FAbxDzznzcArnVJc9rlD1FlN6YmqVdUM0cUty3F9EkFf2eYs3f
	zK0vJByZcHkJfeIE0VJH95YFL04l8Dy8+9eDGYO1HbvmoCFYDh5LbA3CIHBYPi06ZFvPYj68hy/
	V33aYAxJ6BMWDLSyMMHgcgKyw0DjxaVkZ0ZD6HAW+0x8wZ3UbiWfl25oSHSHK74KQwUCOFJWyvX
	NH4pexODVsUhftRyWpDTOLfPosxiF0/pEg38ltlmPqzhfqFPWaWPCDBBDYH7NlN+IU0vDokycgw
	n9lnxaFaY5r9mMHfBbSff9GZf0xMApNniHfP8wY9q7vuhARgKSqaPf+AANKUd3K4qtgFBrpFkCa
	dNwPOUOCe5iF4tUELdoIEWt8CSWWzUx+Ac6XiaIdjkqlXN+OmqpILLFFQANH5XV8JdDR/Ed5gon
	QkNmYM+43RS5P5KOuspg7CdB10KAAuK7N3BJHjhs7AVF6mnPmhXwb1ul3IPlucxbrHk21l27AXc
	X8tE2wKLfXlVg09Mu5YGNzzH0U2sc4sDNj6UMuHTK6sBTHVdr2q+OAFCMpnY/r4nh2DIbbwQ07L
	tEW5odTxxVMjb7WNWTD18SjVaKdHIFaV+qnBtauAtNRTA6uhgr9DQQlaJO6b09AWReSxesha
X-Received: by 2002:a17:907:1c9f:b0:c26:1691:b374 with SMTP id a640c23a62f3a-c261691ba04mr359894966b.45.1788591840842;
        Sat, 05 Sep 2026 00:04:00 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm12011719f8f.34.2026.09.05.00.03.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 00:03:59 -0700 (PDT)
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
Subject: [PATCH 3/9] docs: kernel-parameters: Drop the edac_report= entry
Date: Sat,  5 Sep 2026 09:03:41 +0200
Message-Id: <20260905070347.25902-4-kmehltretter@gmail.com>
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

edac_report= went away with commit fee27d7d9788 ("EDAC: Delete
edac_stub.c"); nothing parses it any more.

Drop the entry.

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Fixes: fee27d7d9788 ("EDAC: Delete edac_stub.c")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 99d5bb68968a..2a8d862ef30f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1578,14 +1578,6 @@ Kernel parameters
 			PCI device even when its classcode is not of the
 			UART class.
 
-	edac_report=	[HW,EDAC] Control how to report EDAC event
-			Format: {"on" | "off" | "force"}
-			on: enable EDAC to report H/W event. May be overridden
-			by other higher priority error reporting module.
-			off: disable H/W event reporting through EDAC.
-			force: enforce the use of EDAC to report H/W event.
-			default: on.
-
 	edd=		[EDD]
 			Format: {"off" | "on" | "skip[mbr]"}
 
-- 
2.53.0

