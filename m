Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4441223E324
	for <linux-ide@vger.kernel.org>; Sat, 30 May 2026 00:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101409; cv=none; b=m8c3uT+WkrS5h722uaBmUaWo0CNeS1HrrTlPcsox6+bQgz10zuQx/aTg+FTswm089awsjFtum3pvup3NJO9RToIrbNtbq7mkm0C2Doid2ULb9MxnEuyxDZLympL/xUMhj70yt/XYFiNUz9FvR2Qi4FQmBExOtVkSt87/pLnh3N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101409; c=relaxed/simple;
	bh=8f166cGLZJwm4vHyUEs/pe04ioyUry567nRUpgO+z7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhgMc4hkQ4j4B8yTnFDlztxwH2wOClVyhDj6mCYjPaCguKbUEvhgCttaXiId82AV3Uq7sKQest01zRKL838MozcfD1vr2P06DXekv+VJUCIRQjmz/ZkUqNZQ72Vj9eQhzTbmN/wcT/AQrKEqYuDYv/Vz3jxRQHGCBrW8eYU8QPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/u6u6QC; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/u6u6QC"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8413ac3d82fso7817990b3a.0
        for <linux-ide@vger.kernel.org>; Fri, 29 May 2026 17:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780101406; x=1780706206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHc+LO7zn4/xm0IYb4V2Ibo53hM2vFJpYoTYBLlRRIo=;
        b=Q/u6u6QCQiQwWH7M/TQip6EXbD8+cOpf+Fcc2KRdYogfPJwGpBkuDG2m+PtEStdSeF
         MhLp/Nd1R32oma9Fe40ELn10YaBmm9QF0clUTiQFtmlt70/Qb4UBq+C/hxoY7ApMeCbS
         CLLQ/e3QlRGEKdxka4s5F4/lIkNRozW2qxHc97RIkENV09x7Kal+Rc4dM9MTkBSuqZHN
         oIzo2VWf6zqMgEGOu+s8pFRm2nhUprI6kEow+mq1UJmB1IqtlOo2+FgXg7S4X/GS6G6U
         YSJMvu9x7lfFDJFUbDbkCKdyGimV8zVXS5SHKLsILhtXNlpg0DbUqqnHmQUE8MgjsMtD
         BXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780101406; x=1780706206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uHc+LO7zn4/xm0IYb4V2Ibo53hM2vFJpYoTYBLlRRIo=;
        b=KzqWX16Yv5/nf/4ihHzpfw0Rf5MJTVdVUuRdvy/vi3K9eIt92EFElbzsXxzktz92kl
         grDbBZ5XWY50Q2dfSbTkt8ofpHyaiUTPUszaoYSArjqOtOPYCuX988P4yt/aV0MX6las
         N5m4aBohFrzsocFKpKhEzUvWaQaTZ6kNsVN/WgdPiKd1Q34bah6Lsq8NYV2Q5gQvTXhM
         emAbDt0VTxk1G060KWof1E2dOx0y/1xoDirjhNN50WKSDgQ9nzFir9kyM3K2XU+7luyx
         CGXWOHrmuuNRYGypya7riqMmYMdgIixhhBbpEI5Zjo6J7dUBDj6xjSCChN6J1OsuhtLT
         arTw==
X-Gm-Message-State: AOJu0Yy4JRGWsQMW0hp0AJAlS3DyyFSb+2hS2RXQuFCMfl4O4DhtkMXZ
	Z+IGOKUdgJsnxXpptQTXCZAZrOid6yQToATNZqFJXF6eL5H75PfLCoU9PwNrsQ==
X-Gm-Gg: Acq92OFQGbEzrgCoE2Xj2OxMWGo44NJa0uGl0TJ0FIrU+yzIwx9JfAXK0tCOaB34o1M
	8TwHuB+S9JMZtCKqNW9byTCrAGTPcHVL5FgTOfnI//mBJlBqKprHIrfFnuy75qqESY87xPw75gv
	XOEHnt6oDPnZKZnqwJFiBMk44GBZVLzihEzExuygUqebe12fTsu9R44gWLuy2TLHBxF9mdT7Hhm
	JiN+vGtvJ7TGxHYibJOhTPITqcPF6LqDILTocOdZbyXF34T8B1Wj4rehBuZjxcvYC+iIejvIBtV
	VaPhGRSVqWQyX/f2hNbvH5TcRFE79cF2eDDWSE5/X6PBIEhppP9k0jfHE87gdQGTkU1N2D/Yfci
	6zsmMrOErvTe/gX3Xk2E5DeiaBOJVgVr1I5JcKe66KNsId5RDGceVjRj5e5m69MHZAHqLdWd2/F
	G+1By3bte6mwXtJWO5Jx67F4pXZTaB8t92IIl3IKm9rY/maaBoZyTZPe6scbe7E4Z7PhUPgLhU+
	EYY2q5UguvxINXyo5GfXVEtFuqV+E1qJ3gRcHXLu+KL9tW6FSoKdtyq
X-Received: by 2002:a05:6a00:3386:b0:82f:776f:a78a with SMTP id d2e1a72fcca58-84225445946mr1555055b3a.30.1780101406532;
        Fri, 29 May 2026 17:36:46 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214b2acb7sm3705769b3a.13.2026.05.29.17.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 17:36:45 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] ata: pata_ep93xx: avoid asm on non ARM
Date: Fri, 29 May 2026 17:36:25 -0700
Message-ID: <20260530003627.42473-2-rosenp@gmail.com>
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

The raw ARM asm delay loop prevents COMPILE_TEST builds on
non-ARM architectures. Guard it with CONFIG_ARM and provide a
cpu_relax() fallback for compilation on other architectures.

Assisted-by: Opencode:Big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/pata_ep93xx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index b2b9e0058333..f7e87d6af264 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -204,6 +204,7 @@ static void ep93xx_pata_enable_pio(void __iomem *base, int pio_mode)
  */
 static void ep93xx_pata_delay(unsigned long count)
 {
+#ifdef CONFIG_ARM
 	__asm__ volatile (
 		"0:\n"
 		"mov r0, r0\n"
@@ -212,6 +213,10 @@ static void ep93xx_pata_delay(unsigned long count)
 		: "=r" (count)
 		: "0" (count)
 	);
+#else
+	while (count--)
+		cpu_relax();
+#endif
 }
 
 static unsigned long ep93xx_pata_wait_for_iordy(void __iomem *base,
-- 
2.54.0

