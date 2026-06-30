Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790E0477980
	for <linux-ide@vger.kernel.org>; Tue, 30 Jun 2026 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851067; cv=none; b=OQxILg3pi3cmFS19cDoWhtxjP5BzFhFaJnMpxv9y0u3BQtJJGoDjjiQTJ/RotUArm0+3Gfz+jKOpk5AifuF3BjIoJIR6xakVMuokL0O1YWQi9DAu1LG9T0oGxuSCYr94AkJVNRA/d0JWU/aXVj2oTGHMd4i1LoiB+Vwyaj7o4Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851067; c=relaxed/simple;
	bh=8pC46e06isTAZXLZg960A+c4FKwn9mFlSs3P5i5/5DI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2/PNKix7QKH/YGQwb4rCqxS39Ptj42xCnGvqMJTFg95nbldqBxlTv8Jc6xDY7buUg7jV9zrRYx8PU+S4B3og3t0lGALD3KdUebhN0wdxF321thknkJDVgbRhmhZYc3kI0Y+3I6PPJex/A9T0wKSTEITW0aRGAxmZF4CMT7NA5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwNSD2mM; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwNSD2mM"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-847a52edeb2so753929b3a.0
        for <linux-ide@vger.kernel.org>; Tue, 30 Jun 2026 13:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782851063; x=1783455863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fFPVZY09QPRiho7bwmKVIlrXovbY7I9u7Aw5sAQ1Yo=;
        b=BwNSD2mMYE6BYvPchypHzL/XPZpnx0ujwWlks/XokbE+zU7JiyqHekaGl/HQSpf33+
         588NQ8FT0WDyNowERAz5WXfeH2ErVnogbkdt9WG21wxB0ZsSFirlsMHfLRaw8q40jkJw
         xMcYpqWvje8cqGQz6lV/HBEwFD4ol7YuDIiBxTFY0yY4Sf544b3ABrpsdc10DTg6qulX
         UD3NpFIOhs2lQU3z+LDR/S7Vm+rSicet4ey2X5pAkENssMW63F6w6I60/ZaL+GsAwS8X
         b50VdvGIMyxBuHX7AFcP5FJ0i64hoMoy+UvXsV5/BMzxuSMsDEGyoVoTkctMUiW5YqQo
         xcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782851063; x=1783455863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9fFPVZY09QPRiho7bwmKVIlrXovbY7I9u7Aw5sAQ1Yo=;
        b=CEAZy/KFWh+TT5SDPWYG/rtGNgIWK+Pz7xWxDA0GYOTZMuKLdT6KFegW7v3EfaoNzP
         nNE6uJOXwfw35guwgReHmUrpPdI1Ehc/EscgYTuK06+K+gaahb/vn5SqCBB2xV+qjFgr
         uCEfE/u5qSOM84sDgCTtotVQYIpSFTKjA5T7dSFpa0XZUQybMbIk7MihctbxEiU0pXrp
         wCqOZTIHPfxixvtKbA/NkDSnjG3VofbpMZ34/zOsOKTJBd8e12xd/JD4EiehMpCtnu4Q
         WavFsmNzVFoVoSogEcSgfycwKKjDZ+etYsB8n2JrmoeVf1pSZPDZwSRclj1DEAOqsadu
         zb/A==
X-Gm-Message-State: AOJu0YwU/hjQwL3F2pkox2EI6mPCmkQxGq8GIHDnUmd17cdps77KlTIz
	r0bY6/5XQjeY1/Nt4BJVEZKiW2nckL+PJDUUF3y1bbYbu6OrSuPEc9LUvpl2WpB2
X-Gm-Gg: AfdE7ckYzu8jHMWGL/MeIWH75SV8tRlCTwhXD4Lohd+dku498jPLE5SOBGrhz1nN5uA
	oCzSbvBbr3iBVyKdC0zsbioq8yKybdwFbVb/qeJKH55t0AFENqHm043P4OQAYpz5TmK9+A9mzro
	1vdqtKg1wX/NhiVzlQOkq/D/g8MHnjJjVtiSYTJr3/yZtptl2P7j+vp/9Lp20rWYkDkH5iQpRvh
	bBEIf2KfSBw9Lod1WFuuKJ5bQNjx/RmZmJbFBLA1O4XaHX/PfVTwXf4ltXVVDdGEpDZRPa/tHmg
	MiR43dwQDJyB5ET8gsDwT7jfBFaPYbWZUHTD94oaQWoaTof/AklsAa1aSBl444NgzeHO2MIN1y+
	XIQvyYrQpKt+mCM7zNvQU928ev6tL//38lJ61GRz8rj6KbJEcJu1rfQlniA8m/gE8h5CIUBNSM+
	ZHn2fgyQEkOsIXCYC4eGjtYFkS9tqj1irGfDaJXmRGb0m0v9AqodecJu9fj4+C38tD0nKR58Xfp
	Q/U083OWQ==
X-Received: by 2002:a05:6a00:bc0b:b0:847:9188:e492 with SMTP id d2e1a72fcca58-847addc4784mr1747671b3a.22.1782851062795;
        Tue, 30 Jun 2026 13:24:22 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a0337121sm2688854b3a.44.2026.06.30.13.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 13:24:22 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/5] ata: sata_dwc_460ex: enable SATA interrupts only after IRQ handler is registered
Date: Tue, 30 Jun 2026 13:24:14 -0700
Message-ID: <20260630202415.234463-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260630202415.234463-1-rosenp@gmail.com>
References: <20260630202415.234463-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sata_dwc_enable_interrupts() is called before platform_get_irq() and
ata_host_activate(), leaving the SATA controller's interrupt mask
enabled without a registered handler.  If a later step fails (irq
request, phy init, etc.) or if the controller asserts an interrupt
during probe, the irq line may fire with no handler, causing a
spurious interrupt storm.

Move sata_dwc_enable_interrupts() after ata_host_activate() so that
interrupts are only unmasked once the handler is registered and the
core is fully initialized.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_dwc_460ex.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 34d6d0534e30..fb6042b9ac27 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1168,9 +1168,6 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	/* Save dev for later use in dev_xxx() routines */
 	hsdev->dev = dev;
 
-	/* Enable SATA Interrupts */
-	sata_dwc_enable_interrupts(hsdev);
-
 	/* Get SATA interrupt number */
 	irq = platform_get_irq(ofdev, 0);
 	if (irq < 0)
@@ -1204,6 +1201,8 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 		return err;
 	}
 
+	/* Enable SATA Interrupts */
+	sata_dwc_enable_interrupts(hsdev);
 	return 0;
 }
 
-- 
2.55.0

