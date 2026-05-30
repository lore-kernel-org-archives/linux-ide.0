Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CA825B0A3
	for <linux-ide@vger.kernel.org>; Sat, 30 May 2026 00:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101410; cv=none; b=udZTd9pHsIoYM49Q+pQZDW590Sgg+kmwnwXGagQidWwP1FfOzqVBjtR5i2meyz9xqWhF5npjFVE8wlsYzJDxCLCAaCTf4BBNd4mjcOikxriBWAKkdNMVn1AMSMnjWJ7xCxE08IBJpuDfVw0vxIOyParxg4T+1oEfxHYSjKUStN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101410; c=relaxed/simple;
	bh=ExrNS+E9K87KpOUzm+3mJfCZUayW5PBJ4Puq439fJOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPAJhXDW2UqEbfhX4WyuBZX4LKt9mIABdLk90FeCZp1EOczuhJYhaX+vx8LaE74g6BvyFcDF2Wtdq//DWFdWd0uINQ2n6VYS6qPaY6vLXKkuFjtcy9mIJPPkLbOjAyd9eYBe1UvwnM/Uk+58ruGRKdXssuKtgPSfbNsrN1FL1Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSkJMXZ0; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSkJMXZ0"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c8532ba6c95so2402265a12.0
        for <linux-ide@vger.kernel.org>; Fri, 29 May 2026 17:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780101409; x=1780706209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Q4l+bqtSyLDFjAoJhFdoW+a5NlFeQ0MoTRHu92XIEU=;
        b=DSkJMXZ0nXNhafIAQqVaOXhcf4N/pmYwyI0SEClfn7Wlhb6HOG5pwP/c1NJyCl5wrB
         AhUO6h284dQypjuqmh+pgkymsTi2d96j9v7IeYkYmQiwUwZcVfg6qZ2Fuv4AghaB8mkx
         mH3mGpKqSgAflUzZSmR5A3jlpCs6K8Fmjgbt8vVkDcXjF3d4sCImbHbeeysXEqbtxZb9
         anetPcRVM4euomQnX3S9wyVAoZa4W9hRcpD3MT38WGSb752fsfFxdP2VcfKMMzU7lYqS
         W+X6ZJWET9E1+o5W4TOyfC+XamOD0x71fRN0+AbioJHNB0rY16D3wtGUYlEkmQCQo3/o
         ew7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780101409; x=1780706209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Q4l+bqtSyLDFjAoJhFdoW+a5NlFeQ0MoTRHu92XIEU=;
        b=Zfbo7/ZcLysSBctantzB8l5uKJ02GO00a3M+9jM+JsVLmi5YPxf/C9TtKZVHeAZuUo
         IZbAqgI8QuWcfZPVnHS5nNlJ7uEQKiMGznmuEzdT6cjRdSem9NyHOYWQyCTpfSYfPeC7
         dqIONvBHM3rqX+VgCW25d/ywZtixxvu0SLf1TLvVrsbUKfBfb5IWa0NKgezw5gDyxFgA
         /shJnA/YBOQPK51ezznXtXpOU1C3+6N7/s+2bPlU2d6BWF6ki75IUiNilh+l961/YS6t
         n9g87sQ3YuKsWcYtMwBegP5gwKn3jnvI2+eogLQyIIKsSG4+D7k7imbFBDr33ir/YqhT
         XIZQ==
X-Gm-Message-State: AOJu0YwP7dKvxLd8KSQYLjbGCeHy6t9tLq33SHyFV9lo9kwCJ872TEpR
	KFIMYe2fCAjMuzfYxyfGKNifADWKkzfn7mP7D++AUvqVKK7PWHH4nf8VKGqEDw==
X-Gm-Gg: Acq92OFm2gkyQt5ABkjFrLH9Pa8fa9XKNh/mR71F5bllXVMXE6j11Hm9r6US2+Nk9me
	f5vnSBt5tHKmcXvJvHjjBeGGVtyTU8L12FHMHKdwtklFvze/Is232Sz2f/y8Td6VaHRe69uwI+Q
	+mTdyotvJZdqjRM3xBNRfdx+Jd8/ztsfRljUvz0aTO4GFJhTZHI5WlXTBFokalpBtyQXNizpE7v
	XPLZ6+rfhNHi42lTMzWbt7Lm6Cq7ycR7jO1GD+LamNvY/ezJpwbhg5L6uU7Su5b+webB7tjGJzG
	BOAHUnivc2pqvBDgcab0DRzjQmtMpbMfzqh1/POADz9oPXcAJBdqZDFiD2E97WULKysRpQISWjV
	sL6L3yydfbbbWmcrwQXjTDenChEdjRN0z5yv2uKqJUREW70ooflkTWPDcAqECzIZ+cYaa5jLT9d
	VRPWghjHUxQrmBMfaGF8Dgw9qfUlMnatyEpc/LKPBidw1lTS2LtSOu9TRZzZldFpW1e2hAE3Rgy
	bRUoJPM1qIOo8KKqEWxA07kYdCfrgZYuDSJWqTkB9MPgKM/tA5RlBKh
X-Received: by 2002:a05:6a00:32cb:b0:82f:38:a5b2 with SMTP id d2e1a72fcca58-842255ce40emr1699958b3a.40.1780101408738;
        Fri, 29 May 2026 17:36:48 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214b2acb7sm3705769b3a.13.2026.05.29.17.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 17:36:48 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] ata: pata_ep93xx: add COMPILE_TEST support
Date: Fri, 29 May 2026 17:36:27 -0700
Message-ID: <20260530003627.42473-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260530003627.42473-1-rosenp@gmail.com>
References: <20260530003627.42473-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the build failures have been fixed, we can add COMPILE_TEST so
the buildbots can find potentially more problems.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 462cbb01567c..6e25e9fcadb2 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -692,7 +692,7 @@ config PATA_EFAR
 
 config PATA_EP93XX
 	tristate "Cirrus Logic EP93xx PATA support"
-	depends on ARCH_EP93XX
+	depends on ARCH_EP93XX || COMPILE_TEST
 	select PATA_TIMINGS
 	help
 	  This option enables support for the PATA controller in
-- 
2.54.0

