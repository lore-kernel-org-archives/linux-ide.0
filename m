Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2386F432304
	for <linux-ide@vger.kernel.org>; Sat,  5 Sep 2026 09:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601639; cv=none; b=Ffq/mt1SS+pb65qNBJsbd7AYdjoC0yioYerKcjwvewI42fjkORcgJS1EQutR4Ytgva9XI6d/uLDfU3UCy6NrXqVwRNpHzRB8jAbyWcfh1oUwGfTdK62FNgFF39N2mx2miR8A4sd7KgV28JYJwMtIt+7wXO+a/AQRuYfzXDsI2Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601639; c=relaxed/simple;
	bh=zqIZgn7Zgj5WSQepFgJtQ9GMMyKpvR8InLxOiqTa/8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KfilLnZ9uVKLpU/zJl80DK70DRYwnoGMnx6Qja/Ty12zeYop2c+U8Qsvzls9dsdV3uOUUioNmVdupJWFGpdjfZ6ddAPRnuOjv5nM9yoE3WYK9KB7j4Bhx8A1FxcHuQMLxq49KZOkjikIWvrZH9J3gNeh6+n5y+O9IMf7t8N9VcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sS3GkGDt; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sS3GkGDt"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-484374f54d0so1107425f8f.3
        for <linux-ide@vger.kernel.org>; Sat, 05 Sep 2026 02:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601626; x=1789206426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RNFfTw1WuaSNgs5HCMSq2uznGZvnZVsIDtneqTMILXg=;
        b=sS3GkGDtOZOrxGVH2ecp8Y9BijuvKIZGE9cRol9c394h++PWXXMUkrbfk4MaucH7Xb
         U6xnSpOgpPlCLgGRJgFJusDEMpGl6GoEPagk0EBRDekWebDNSJ9c2+7bDODP5t5sx6WO
         S7qWSKaOAWth8EWw5f4FyoVQksRMC12WKRbvoec5wN9+mVJAxfr0JzbGojpcXGDPLycy
         Wm8keJ8zf60yL0isTXgjllly0MsmA/q9Yly09xrEJx9E+b1vfnw2Do6nlXQGx7bqY2/W
         iT83xkaYf1IN7FJtaRTK97E2OxZs+3sKatwn2475v/Wkqn0YcgJ9E5z39H73lyE+5dXm
         3iCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601626; x=1789206426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RNFfTw1WuaSNgs5HCMSq2uznGZvnZVsIDtneqTMILXg=;
        b=GYlDXRZsiZ6F8aqZHV0k8nAQvrniMYBwMbKXrGdwGK+zJ/H0+lK9w3CG4xFyeLIGkB
         k3waxSAHWKf4LPrYO/df2mFS6ODIM/ZNvK5WnWc98LQiGTH9FXlfxdpzJJNR9y/KFWym
         rqYEmjILBibJG0BdfnETn3pw+G3JMIcQ4PLmfNil09NjTkGVQy7pRQcQp2c5jVw5V24J
         B8L7Eoz4982VUDaTqpxhJzE0faan7XSilS8AsCGCCnbO/Fi4EPjioflW5P1nmEo9tP3i
         hT8d8t32Ad6802uOudsO+ISuDoASndIKIi8XPqIdEvtfZUs1og+mY3Ks7uF6eGAa1gjS
         x4fQ==
X-Forwarded-Encrypted: i=1; AKwUvBxljE1jHAa7TZojBLzcRj8x7AJeCOJ94XcDhHJQIIaSgnwgFkmlHjGXzxaMfXyYWPEjyfzI9qb0xwA=@vger.kernel.org
X-Gm-Message-State: AFuF++mJQgm08hun+ZfNQrroMEM8DEqqv1Ez6Q3bQS+MZ5yJCXES+8mW
	G8OejLF4L75C1mgIzaA9zprpcoG5Kl/yI0NdUjuIXYelhhLUIvuCs5Tl
X-Gm-Gg: AYBFou0gdlmpR/HnAVpEQV4MpJYTBsBDNkI1SGzms1mnMNpw1BCgoY9go/kNnvWRXkM
	cAjqueGle/3Bn2DFv0PxZvL2d+B6kMhkyZJ7dvF8RQXM+tqp7ZEapu+h4uDppCevjcBTKXbO3ep
	C88+qBpIN19WLbB9VjnukJuDVEQDseAgQQc3NuCQijwmyK8XK4chubesLfZhpqXFYbz1f1ul6CS
	mag6/PaovQ4Hta1Csd1fQPhFdDy5ydEHnbgpdo5MKO1cBY/7czr7X2MmIIjXUirT16qQT/RCAvL
	p79rm6ApRUjnyUSrLH7muZCCcySr8o4CvhMAjkfaaZJPtygVGzlMFSJWwOMNxAju72vUsNQ/5Uy
	AySz/BeAwwJKxnTuZG9p4TjVOX73uRbcUo4jWyw0yIjEuUPvTmhVjW/YpOb5WA5OrT48BIprhv5
	RFh8WuwMsaro/weRaRoaTp3/Gqx1t109EiLi8IFx9JVNC0kSeUFRm/2DArZ9HV1VOhRLcAhKcKn
	8uJxGEfw/nCJOlmve3fP853eNZYhVHNIhSs+HOrszHIPF8s6dZRyJzIly+R8KmYiHmXxyrOvJjG
	nB6sJhIkybpDvjjzaS+4gcoX0saEV9a887dJ1W07KFVhYM1TDL8wmRPy9qFJqXL7H4g=
X-Received: by 2002:a05:6000:178e:b0:484:3200:b7a1 with SMTP id ffacd0b85a97d-4858708c88amr21220202f8f.13.1788601625675;
        Sat, 05 Sep 2026 02:47:05 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm14232013f8f.25.2026.09.05.02.47.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:47:05 -0700 (PDT)
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
Subject: [PATCH v2 3/9] docs: kernel-parameters: Drop the edac_report= entry
Date: Sat,  5 Sep 2026 11:46:43 +0200
Message-Id: <20260905094649.41996-4-kmehltretter@gmail.com>
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

