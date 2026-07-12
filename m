Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0180F379C4F
	for <linux-ide@vger.kernel.org>; Sun, 12 Jul 2026 21:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783892259; cv=none; b=hpfP1A8iOlBEExf31nXF/xjfCZQXc2bnxUeHLlf8/hA1VXaA1XoToDylNP5JIfm8Zu/yDjW5GEmtNlTz/ZyehDw6AeXsakyneyrhpV7/sKLI8dCVHGeCGLRMpEOXnjxzkofVNZtarw/9tU+ZgTF/DluFRdUTw6KX4YLVHH/CuoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783892259; c=relaxed/simple;
	bh=VO4t2u2qQdmKg/v0j6i3hHOlLjtd8aS3IHBNDIy+lqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VEdDBQPPgCo9kvGVfTramFuGnQC3W83O9w0N5hk9IlnyJkyqxAiIvIx9L2IWrig5njv3Q3SLNnhRTIFCINMHhTL8Vt69o1ltrmdsTbvbn1oT2qFzJClqF5cbY3X+M7hyDPpnwii+yAy06B2DB+UTB0AbRqjeWtxhDjefq08Zg4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g74bQ+0u; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g74bQ+0u"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cacf197759so36955755ad.2
        for <linux-ide@vger.kernel.org>; Sun, 12 Jul 2026 14:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783892254; x=1784497054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oKqwIHEOqJ6y+293+N3845Mk/6weuqq1m5qiev+Nu1w=;
        b=g74bQ+0uLCeQYX7U9SsmKHBt34Ywdm7xAS5X4JzV9ib1uroytC7zpxPkSYUUPTeEnc
         5RpGUs0ZOmJDYg9NWk3x1J5wfjaV5w3cJJCVP6ZMhoUFFFFW+c55MGlHNoj4uKB/gCLi
         Au2eFeC0zyVL630ZU8YKET2AM+/Kt+yDbx6MD3qr7o8cAVHUklmjucZjkVzHWrhQPcSf
         3Q/MmCKo22LGtEsW1udE8PgXsWR9Pocnhtc/qKtcDEicyxeNg2lhcTluu2aB/RY6aANK
         tOeTjqr+pegTkO8hqWn/pfyhhGr1l5kWXKSRdGhTl+qShmrp3+Z+HFXToXVgyfzzHk5y
         dLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783892254; x=1784497054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oKqwIHEOqJ6y+293+N3845Mk/6weuqq1m5qiev+Nu1w=;
        b=NAhDopJsHIThB9DNN4/t+xXaAE+Sw6zek2rhDClEB6rSJkCaxVpkhR9LZGMsa2pm3m
         jYkQE374nLnaia/NybL/GFaH3OoYrchpXKS9Wjo6eS4xUin2PkRU0Q6W7bVhOcYkvjp5
         upjN2Bm7yeoF33blq690s4AN0lqhsp14VchCLPGahnZVyyIwjBRNHMyidIOV8ROLZ4aC
         XJK+L777aFcWjlN2lHZ8u/E4WHH7uqujrFesSM18E3lU8xyETqJmhUAd8sY5C0Z+LxM9
         8hqN0u7X9yFoAJABPMddjbjVoBAE/XUMz2EJXyIsSri4zpRf4bIh85ZmvL+jVNbGzk4U
         Mhhg==
X-Gm-Message-State: AOJu0YzZ6TPg7Ua0gMunuzoUv6tTeUQismOnAVsNc+XqWFmfcxU3oaHn
	3rLlO42ALr8dh5iwxKxKYFBv3/YZdxKXL00NK/h86TY65dYOn6LfaV005aKUyw==
X-Gm-Gg: AfdE7cnsxAfdOTSjCY+R1i+9mB0ZVOr+S8IQNWgfBTbs3J3gMOI6B3R4FS+JDVJMxJf
	TRYzlPmJYkvGoiysNUnEA2nLoPBQIq9rIOHOcsJaTjxX/dYVQcDw84BHdZVOwbpxx3WK3zAoQxd
	zOMBGVSHcEVysCuHE6IgBP8K3Nj8q3uqapYMlOiwY0C1uIExeiv+/VAD/pbdyQ2Ydt4BClI2iWv
	AWSbBnZq3gev5vg31nqYPRwk6yl2WzdNl0IZ0WezP7YY07JF59KDvDhAlmoN1h4tuag2vOSaoxJ
	k1u3a3FJ41aBmZFsI2ToYuxOO1jTMg8mWcBbBKWW9376zWT/hDaDiwRiMnf6pPr8/IbwAHtFl40
	TVcMBZmpM4t/rL7pI1wBzpbfSKSqSDrFoKat+XzrZMSw1mNYAuOLs/JcoCTMmb18jWK/00BUxXb
	bFS8G3AHl6kYkWUn2La4JISZ7yDfl8yB9qhFNeyKd1jUB8wxnZlIFAQKjPeD7Cn4rPPNK2TjcaI
	eJE4SkePefcgIl/5VPv4bp/+vHiwxokIUSq6NOkTQb5v+ht2rNczeTYiK6BcH682g==
X-Received: by 2002:a17:902:db0e:b0:2cc:80c5:73be with SMTP id d9443c01a7336-2ce9f04da7bmr57517825ad.40.1783892254464;
        Sun, 12 Jul 2026 14:37:34 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bfb7aesm89082605ad.29.2026.07.12.14.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 14:37:33 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Jeff Garzik <jgarzik@redhat.com>,
	Mark Miesfeld <mmiesfeld@appliedmicro.com>,
	Rupjyoti Sarmah <rsarmah@amcc.com>,
	Prodyut Hazarika <phazarika@appliedmicro.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv4 3/4] ata: sata_dwc_460ex: fix clear_interrupt_bit() clearing all pending interrupts
Date: Sun, 12 Jul 2026 14:37:27 -0700
Message-ID: <20260712213728.824420-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260712213728.824420-1-rosenp@gmail.com>
References: <20260712213728.824420-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clear_interrupt_bit() ignores the bit argument and performs a
read-write-back of the entire INTPR register.  If INTPR uses standard
Write-1-to-Clear semantics, this clears every pending interrupt bit,
not just the intended one.  Coalesced interrupts (e.g. DMAT + NEWFP)
would be cleared together, silently losing the second event.

Write only the specific bit to clear so that other pending interrupts
are preserved.

Fixes: 62936009f35a ("[libata] Add 460EX on-chip SATA driver, sata_dwc_460ex")
Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_dwc_460ex.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 85c5e67e9175..bc543a408963 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -394,8 +394,7 @@ static void clear_serror(struct ata_port *ap)
 
 static void clear_interrupt_bit(struct sata_dwc_device *hsdev, u32 bit)
 {
-	sata_dwc_writel(&hsdev->sata_dwc_regs->intpr,
-			sata_dwc_readl(&hsdev->sata_dwc_regs->intpr));
+	sata_dwc_writel(&hsdev->sata_dwc_regs->intpr, bit);
 }
 
 static u32 qcmd_tag_to_mask(u8 tag)
-- 
2.55.0

