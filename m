Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3343DDB11
	for <linux-ide@vger.kernel.org>; Sat,  5 Sep 2026 07:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591850; cv=none; b=j/zTlTFNSHH8WHbqhG8J9h/K5ggC77Zzq4g6vD7swpQnIKwAIdD2iPvPfqZWWSnmljwRRbv1vlorils0p6N3ky7pNXTXC6fb9YnLdefWuKvq5jGBbcrOupKjaE35W094t7tln+W7vQa7lCThI+pj2v4Mhm6jCBzDrPrWzw+XawQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591850; c=relaxed/simple;
	bh=YsfDHjDKsIWAkoUgaj1imFKWTfOFfJnvMXwuV6H0pgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VmvfLX1mWv7LhTg+o8YoD+CPOLZ5ieEcrGGluZOLUc1aBNZ8hfvkfn6/K2TXH/3+6GGJ+tfzrSblM5x4mOduul5c1R79q1Ohklm09lCqwNDIhzLQ6r+DA3LpeeHtvnc9kTVxMCUPiZ+Aoilzq8kAfXzGaJXcWVCj9pIBbDGlm+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTgk/Bir; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTgk/Bir"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c259e5c22ffso286657366b.1
        for <linux-ide@vger.kernel.org>; Sat, 05 Sep 2026 00:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591843; x=1789196643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9h3cyhQ1bY0apuRrAImVycgRtlSF3vYdx1yKBS/SgnI=;
        b=CTgk/Bir/irm1HNOtFUvU6UDv+QZsqLHmwn3U1pGvJvT3QHNNspH2iWM6hsvRzd0rQ
         +UBq6r6+i+ciz9GE1cNac5fERSG3fs531KyW86jZ4vkoKuZhDfTmhI7UhkPRKYUZmK01
         MgDyFOjl0fErZ+P01xZbNWAla+v84cUhIsRo7x3Bd9TmDbPPcPbjc9ZQjtLwW5ne+6jT
         w3JZtCZxqL6zrMQZd1HZSv/MFn2o+HtGLaXzamx0uFvJ4VWnHe7uUsowPi7AUWpdqM+6
         jIIak06kMPVed/xh1N37YsqjOe1Tpncqtc1BaaIYFR/Z5MraNH0XqCTmj8DSW4V4yRLa
         jG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591843; x=1789196643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9h3cyhQ1bY0apuRrAImVycgRtlSF3vYdx1yKBS/SgnI=;
        b=fGjjrmuL3rdKwqu6OAHrnJbO1AIxeDDg/JR3vGP/wDVOGT6A95N7LpWhVpOLfFsfNi
         ILEdraBYRFpyx9Vz9zJhWwcd56uA23uEK/+0iXbA//NpTzMXXDQFgsO/UNrsg/f2Ssj1
         aeDa584ce6xtyxSUbzTZ2cO1VV8j2BltxL+Hzfdc6dUreUnw90rvumgxJC/ryH2c8vOD
         wFDe9BgW5660NmYzsBe75O1IHn7u8HJHgypDEkej1xA57zzEGHkcjP5A7mqW7d7tOCE4
         m2cHcLD/Wv08+K7NzrPiLwxtkV/AU8Dto/S3pbzXKpgD6/+FBxcCYvAATDlFAG7t1hys
         2bjg==
X-Forwarded-Encrypted: i=1; AKwUvByzqQsHMNxf2dzlFZ5VG3UOXJtCQWismCmRLMpe7PD1dCjNkSBBeOFCaSi+IGnDZlw8BrgaJbelC2Q=@vger.kernel.org
X-Gm-Message-State: AFuF++nubkjYJDeEusmy0GVFtLeKs/D1JYOZNwov+EFHMo5VnkPWDpew
	q2+vZ7xqGMJxr5n4v1ZoQap+w0sZy0Qq408MkO6v1mG73scSO/6GG9Z2
X-Gm-Gg: AYBFou2Kx/o6b1w9RfjA0A9xqKiAJW7Achvs3sPO9trA+fjiAq2Sh6f9sWjZ8q4/VNX
	Di8NH3NZ8JNmcszLHd1v3tyAvvaYBFZa9waIzUGwMKC8RUwZHIO6UgCsOunqPsU/mFyTNmrXbhO
	3pYpd5dh9Qe0RVx227fmVnFOKxcUy1ZKBLHoozDuTadVcHfWNcPULdnC/yosyHPhfQOg8t8O2VV
	uDkRAUVM/Vo84OIsebY61/20m9KIJBbWTJh/dWzs8k/DlAqFp1Y/QtnBxJ3mYEr9asjXvvG/b5i
	sawKZBrNUCTvtl1q1cnjpKmiNwyeuppLZMB4R0m+ZH28AxK0uWzzUsaybOU0ZnhBx5YFZKhlydJ
	RYHjx3cS7zZKmp/hOdfnbbp3xdzTopO0MwF8GkKhk/cF/Li4qhvkp+iPIhSAZEEX+ncrOfv6vVL
	fc6AA5D83eF7ShwdtAuEUIhOF5Hrku/Si4UWV/NCLUXwcInkA6rEj4uDf7SuVjh6BGuW+GiXC58
	I7GjHfM4s5dmFDKbYYL8r8nboPmCkFLdeqFNQVcANiKhiNTwo+byoVBD0Uz6H0Kv7Hx1e32M8ro
	Inhi8N7B25aNKj3H5fn7q49and4hLwIVJRe3B27hhlnJ+DjwqXCQnob/8GYA7Qt76NU/q/YQmQ=
	=
X-Received: by 2002:a17:907:d94:b0:c16:4df6:176b with SMTP id a640c23a62f3a-c260ca47420mr442803966b.20.1788591842595;
        Sat, 05 Sep 2026 00:04:02 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm12011719f8f.34.2026.09.05.00.04.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 00:04:02 -0700 (PDT)
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
Subject: [PATCH 4/9] docs: kernel-parameters: Drop the enable_timer_pin_1 entry
Date: Sat,  5 Sep 2026 09:03:42 +0200
Message-Id: <20260905070347.25902-5-kmehltretter@gmail.com>
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

