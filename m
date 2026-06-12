Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE323769F9
	for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2026 18:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289171; cv=none; b=F5fjmkk0zFL0Quci6rHAB35UREqHcLXnS586NUcPbbHHJe4kdvMheoRHzwLMAEPPfJmx7MD10c7bOn+ns0keKV2hcN7iqa6hftf+fmUHtoDFFeYCVLvr16xIeYxgfBalxn35hBY6ZCu9ZzvNtRj2gK+Ni5dzK7dsDQeXV0fl+6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289171; c=relaxed/simple;
	bh=hhKYJazjJge73y6yNe5PGiyzjbkw4XoIZrmixT/ypn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u++rD/xWE/qwTHr8MnbUyAqkqEA+FmRwUbiQ6PfWg2JCr1BJGwnYWhFB/cltt1hb+GPk/SAXqSbPlkUxzNxk6+3acF/ggpHbOiKavyFfiQVpBbnIEYArt9XW5gi50YooFvb4xww7gLS0VjBhZmtET8Kd8t/lbionwaC6T5lWLWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YR+xgSxZ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YR+xgSxZ"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c86214eead7so624759a12.0
        for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2026 11:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781289167; x=1781893967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZebOJ0xoX4ZIU1H13OA9Ye3a+JpFQ7aYIL/Bsme9n2s=;
        b=YR+xgSxZSU4mOefGtwS49bjeUgBorpbMT7Jn4qLcBCCnjh6SngBgx6ETUtZHn5gDg4
         /TmSgqd6cDfBU3jnKJn04mgOhhl7YBljk0bbFBC2MKjFA5IS93g6K0o1gcygnx1o/p70
         7NoIbjeq80XyCY9vMkV33nGF3DUBQr0VZHwOte3WMNkDtoE+RWFg5PHaxbjTjcbDq+9c
         QcWiPtmTldJ8CJRGZxjtVXDb/eu2JWo15F2L3FeHWGIrioVBHKOn/HKxKjiZo1XVmxGA
         D2AX7UxWvAtIXwdKMZ4WMyLfybC8mqOIG4Vhk7wgEjhXBK0BCrhKS93QY/zyzP+vexr2
         0qoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781289167; x=1781893967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZebOJ0xoX4ZIU1H13OA9Ye3a+JpFQ7aYIL/Bsme9n2s=;
        b=QOqFJnnWSMWY4mg6LLkJlGtysrAiDUBZTnargpgBOTnRZ8atj94gQjKlwXoN2B83Ge
         /xeuCYkUewQX41/U3NasTt4CQb9dBn9gdFCnCNUVy5xY37phMw6edYI/5hueTkQMQWcV
         w/hFee4ExOrVPFC79Qq9dosnIJDHzUxO1+IwQ6m0Ji48bi5E7WmKr8jX0x9Wcp5RABf6
         GwKTzwrpdspSLfuQDUs9EcEKDWPM0+qX7LDW/MwpuUGcju/1mTIBVKfvpnjdtNpU982n
         izOGZ38/IPMOLrhgwhUNWu0F1H7PJ7OauE9vFoIq9j+GV/jnQp/yu4qBm0od1s/Mb+Xr
         fIoA==
X-Gm-Message-State: AOJu0Yz5gw9zaKdIAaW6j16bLfRwW8j5GzZ/lYCmDyTbOIaLd2CejKYe
	v76g9NyugGAqkzJydSazZbpJJmJP5KkM5WIuGwLIghh0sYks80SKYSJQ//2jMA==
X-Gm-Gg: Acq92OEUmRVKmd0uo2PvjNffsKoBatWgpxMQbi8z5New/ZolUQfK3YnXnUNagv5WekZ
	VZODH1hbfs9ElAm/mOzbuxTMySpPG4kf63IAOe8l393TNoNWMLM5E3V+PDjhkUQTG3/2RB4/Os+
	SFZxxDkVDsF2XlV79Xm5KokG/libraBEwNB6l6gIz7ijhyzrgcy7Fi8mbxrPYTN+b/2nyV9nJ38
	9haDLpfX8IMwExnPb8XgsobvYN/YO6m3+yLrX7oguktKQ7IEzNx8f39U1JN7XBH321PhYlgF1HS
	772CPXF97pqT6bVEcmHnLgzdsDh/dqFjKGS9a9MS/FsgXGWAr1Gh1s776n0GzG7G6CJIE9g9Mb+
	kSWC/eLMl0iTCsjTbTr0T4GbRbAlaQ8DK6w04hQhPN1cbHYV0wqyo9a8pS6L1zlQvYBcmK4LU+P
	HAYRSSeTEe9pjDaumMyw4E3WIgoObWjX1yZXwqI/szUvrBM4ZE3EEnc5l3jTBXieVx+XZFAhrBw
	Gdo6fwtF6qvIfBSvbkRBT09YSt+YA8rPw==
X-Received: by 2002:a05:6a20:d4c:b0:3a2:ed4a:5d7e with SMTP id adf61e73a8af0-3b7811d18a7mr3956904637.22.1781289166579;
        Fri, 12 Jun 2026 11:32:46 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:a073:5e58:ab5:a167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661b5b207sm2795034a12.5.2026.06.12.11.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 11:32:45 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Tim Yamin <plasm@roo.me.uk>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Jeff Garzik <jgarzik@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 1/6] ata: pata_mpc52xx: fix NULL pointer dereference in IRQ handler
Date: Fri, 12 Jun 2026 11:32:22 -0700
Message-ID: <20260612183227.20446-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612183227.20446-1-rosenp@gmail.com>
References: <20260612183227.20446-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assign priv->dmatsk before request_irq() to ensure the IRQ handler
does not dereference a NULL pointer. The handler accesses priv->dmatsk
via bcom_retrieve_buffer().

Assisted-by: opencode:big-pickle
Fixes: 6b61e69e7bc1 ("powerpc/mpc5200: Add MDMA/UDMA support to MPC5200 ATA driver")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/pata_mpc52xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 210a63283f62..fe445d6aaff6 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -766,6 +766,8 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 		goto err1;
 	}
 
+	priv->dmatsk = dmatsk;
+
 	task_irq = bcom_get_task_irq(dmatsk);
 	rv = devm_request_irq(&op->dev, task_irq, &mpc52xx_ata_task_irq, 0,
 				"ATA task", priv);
@@ -773,7 +775,6 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 		dev_err(&op->dev, "error requesting DMA IRQ\n");
 		goto err2;
 	}
-	priv->dmatsk = dmatsk;
 
 	/* Init the hw */
 	rv = mpc52xx_ata_hw_init(priv);
-- 
2.54.0

