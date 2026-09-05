Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915713DB980
	for <linux-ide@vger.kernel.org>; Sat,  5 Sep 2026 07:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591845; cv=none; b=XS5yKrV1qd8jATnV37Jn117cEBUFKY3wQtV4IprqmPTIBO66nuLPwfYpR/ZBbNXPVMG2eqQetFrl/JCLzextD8louZ4lo+tcAGtEopJEKBbq3TevjnAc9EvH5XOq6bBOPfzFtGz9ZvyxAYCAr1pSbm2xZi/7rwnbjhxPxybz2aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591845; c=relaxed/simple;
	bh=BaEoG/6SLaF+j+PN5tp7+Wdp37OedR46Vcq2/qxVkD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hsJMJWYYZ7jX2XJrV0Rhl+qA9j0qUT6ZNTaSDiVZr7SWqqMs9iJKYW3H0V/IKp/cA9CaH49FTQOkJzroXlgaMKW+7cedecZQ4Xx5Yv9KTAqn0nugWhvQIx81KE4U28e3OfDpjZq8ZnbOJYJULhz6YNcLpmBNKKkZOQxgiCbqNcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oXucSUZp; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXucSUZp"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso16516495e9.1
        for <linux-ide@vger.kernel.org>; Sat, 05 Sep 2026 00:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591838; x=1789196638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8I1Jlm5MucKkfjFwaOiA/wi4L8q8pr7cNwUH5XJFU8M=;
        b=oXucSUZp2Ol3i2pEYHldD3DV+2ASo+RTBaAeQzrMSdJwFrR5JTHpquTfUGJO0VfRIE
         nefv+Ft9QF+dcQrSpTKb+iYlhkj58POTcznx68yNS2hDNCcTJdUCP88Zu0+afuCjy9IC
         7gNO6PgkNSM31jvqT0DA7Zwli22mUDcz0OfS/y8E7cQyIjV+TOQPD3EmJhc32MvzlrqW
         ppVUzNkWullisof5hdVTWYukpstjDvRQD28atGI2A/LQKX/B3ZXElMe7YWp7xNwWh2f/
         l1D/r8Xgl58iLGD3h9V85GVYvVjIuiwEHWZYDkvQtAcAyXa8xPaCYW6G+IShSsQN+ix/
         ncHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591838; x=1789196638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8I1Jlm5MucKkfjFwaOiA/wi4L8q8pr7cNwUH5XJFU8M=;
        b=MAwnJPSPtsUeqTSyVgvAYV05BSm1Es/tqC6L5qIaQq5Quqfe5Inhfmr4CDFN/6IoEU
         xLti+K9sG+l3EbRIwWeMPAEQQFjzqvzNS25pUt3trlRNXU75kFL9xQiGZFLaUSEb6o7x
         R+M6m8ZZB0LCUOQc7DpFi1Xp5ItB51shKISsC4mEExPcHO68xqX84JgbQGKyNIg+s3jz
         o5vxg9//oAyFXWdcBpZbjigF1mWIiWXYdOp+F6DsFz0n/lyISzkErkc/ZCOOrm5GmFY2
         BIqnnXNG2eVcWzlfsRe2nN8Oh7YUmS4239qP2orB9K8IZdT+K7cigam+82lAtcC6blKa
         KovQ==
X-Forwarded-Encrypted: i=1; AKwUvBzMnqtCa1u962tI1w6d3hvQOLlaOCoV5CcaCPNUKrjppsShoZVtBgZxz3PbfN5nLzieWHCxCEz4ryg=@vger.kernel.org
X-Gm-Message-State: AFuF++lzC4x+0UdxCIfYfaa66JZ2tcjatQfjwI5S6Tuv21htVo8EYOYy
	PZNcL4gSp3oglbeN3RWZzUhwg4XB4DnoA6kpoN2amoHpOONMcpJbZDH+
X-Gm-Gg: AYBFou2f72gsww3WkGckxls6UMtq8Cx7rrDkX/FQ7J/uPfmsi1+yWbP1syI7csY3aqK
	H9rMiKvwg4bT9EeoYtb4r9pDrTBucv84Mjrx1I3pOIffAVAQGATGdokQGUiTP6c2FbBeJDPJ5Zj
	OMr5qyRR989MZjpQAYA1ExAfP3+a9hrHvI8leIY6Auksqh3fYh2pvlqhaDKsMOcShTHUo3oSwhS
	djoQrgqEpXLERIlRo3Oc7ml1lF84c+HO795UdxdGLqAhwJzkGuG+s0VXwtQrdCZN0CFf1iZgFID
	2N4YhCY3Rdyr0STPiASoj7z3vhxJEy7KOaUSnYacsF09KPRt/ya93I/L2kp5brSl7OkJY0PmmcW
	S3FJ4AB4fEQ1DxEuvK2Y1jpIKnMXyF6QtZzvBlxGdJgr3qz7f9OvJtAQYuPaoO30/M+cTwNO6lp
	PwWjkYLYzt/Q9SZHH5XkC+GEk7E3Ty+Oqf9kn72Z5wmHFeywOWc2xPlF9HGbG77ozO9d1Qqa+h9
	64qA2PEicKvaOzWUiZJ+mxVJXEuX8FbpyQwbR4H6jfr6fSS68g/7sQLPaolQdKAeLTFoe5VWI95
	xceOWoSMNbfg1YY64BO7j9qQpS7hbsr3omsR8+Sx3pEnIvDXbWNSUi2dUWeIWpuyQzahlN/y
X-Received: by 2002:a05:600c:c168:b0:49c:edfa:15a with SMTP id 5b1f17b1804b1-49cf826c5f5mr97941975e9.13.1788591838387;
        Sat, 05 Sep 2026 00:03:58 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm12011719f8f.34.2026.09.05.00.03.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 00:03:57 -0700 (PDT)
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
Subject: [PATCH 2/9] docs: kernel-parameters: Drop the bau= entry
Date: Sat,  5 Sep 2026 09:03:40 +0200
Message-Id: <20260905070347.25902-3-kmehltretter@gmail.com>
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

bau= went away with commit 39297dde7390 ("x86/platform/uv: Remove UV
BAU TLB Shootdown Handler"); nothing parses it any more.

Drop the entry.

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Fixes: 39297dde7390 ("x86/platform/uv: Remove UV BAU TLB Shootdown Handler")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c8d96de4c00d..99d5bb68968a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -624,13 +624,6 @@ Kernel parameters
 			Format: <int> (must be >=0)
 			Default: 64
 
-	bau=		[X86_UV] Enable the BAU on SGI UV.  The default
-			behavior is to disable the BAU (i.e. bau=0).
-			Format: { "0" | "1" }
-			0 - Disable the BAU.
-			1 - Enable the BAU.
-			unset - Disable the BAU.
-
 	bdev_allow_write_mounted=
 			Format: <bool>
 			Control the ability to open a mounted block device
-- 
2.53.0

