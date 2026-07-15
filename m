Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E3F29ACFD
	for <linux-ide@vger.kernel.org>; Wed, 15 Jul 2026 01:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784078222; cv=none; b=QlzYtVLXmFp/gZ2zlvV9pqKEHhoCeNzWSeOieN4l57N76ocQKW2DSqvPoIntedebAWdQV7cEz2sE4vAb2LRFUrWFIngWEFWwF6ED5ygtz7o7hOWUdBRwXE0sn7nqq9KNS/EHXN6Dpvrw8B2zDWbUN8Kh6FG37b0tOG4uUEgWdMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784078222; c=relaxed/simple;
	bh=BP/51ZrzCuUH18tmFa47SYVzg6KlW1yHQnc30QxX/js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rxTK4o4hN7tEsDKbq+CRbul/Nc1HphvKsIwm/9CB/fR+k6TG0eWFAeSzVhzr5gTzepalI/cxFqFCyE3tm732jMUOCz2y0jMgbA6NKavNavBxIox6ubMTx3owDDrjuNTVFZs90XD9pa58fTrxGkChvle8ge8vsi4hbrA+2l+XHLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dB4wsgMG; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dB4wsgMG"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso3550339a12.0
        for <linux-ide@vger.kernel.org>; Tue, 14 Jul 2026 18:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784078220; x=1784683020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MwJBrQ0pKijpyzFHsFaJHm7N376wuBcGnxSFAS9F0K4=;
        b=dB4wsgMG3+hBWgK32izxKWc1nSYs7/XGSPHwyrEK1KmGcZ+2BMRMJJyJ/Q6EV7xbGV
         T0RROqKaVHja7cKZMsTZp+u1RiZyswN4GYSrdgWBpRf5m6GQOoe0TrBMrnN3/sVHMLSv
         OIwiZHYPmYxnW9K2QGZj1PxvtTs/tGvvUa+H25QzKm8zR7jDTC1dGNn3VbwMz97ymgC1
         +feUxwl9eiwIGzRKc+a1bepa9pvNOyv+K6TS/91bm2mi7rSQtxWAC+2yVze12CYw1Fc5
         RyLFf7BtVJx+e2RDPN9KOSXI7I+2W1jvM2guuCxxi4EjNvcleJWu7kabBtV5ilDX7hCm
         RGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784078220; x=1784683020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MwJBrQ0pKijpyzFHsFaJHm7N376wuBcGnxSFAS9F0K4=;
        b=rsu7HxphHQ7gSQXUjYMYjt5GumS83OkLnhYy2IaPgHfIyin3pHNNMD+69Fm+mddz/n
         gj5fQKfqZ7uQi9qW5lXhxAPoUCxUAivqP5DUo0vbgscv6ea7c04xhKVRw1z8XzEO57FG
         /FV6hcec9hGcgQEsB3vCBbElVnnhWbtJ2K7A38u/o9dP3N7QixKC+PSspIeZLLgEn0Fo
         QfhFuFvHoh9RXRhAoSF+vdJFg1It22G71Qhh2VhjmUbzcMVxx3qR8CNgbVuIVDjidYV5
         vsUQrU3ewpXyXMQDpnRhhN144Yro5T1sTKlUogbksrdXr00xF/fufXLy5Wcfu5Ug3ZMX
         D0zQ==
X-Gm-Message-State: AOJu0YyATpIUXlByf7+TePnAAd/zYreS+iTpguXRIvmnaBr5BrMi8jCr
	g7lqlCFafMZHQj8CkbpYyoYy5JwZKL9lQcZL0mqLh8Pocynd1mX5hBuAw5XstfM7
X-Gm-Gg: AfdE7clMU6SUaiLHvJOk8ZGXiNrW0Q4L+TFogWpBmTrNo1FTymzByExHFPGGNZaVo8t
	OdSfEXO+aczYrvplGTgyPw2X1oFWsyadFinppIah9YlXGmOYl+gUlmOXWlqDXeH1k4sGPWWZJOH
	y4aCUatX4khstCCcnG10okYbYkNO0+7r95Ter6jbkbi3Y1et5ij+EzhnbIt4U1q3a2491SwCJB/
	XO2OIYn6WjrfWdTGB3XK54XOsoo+6Ni/nrqwoCC70MPiAvoszY1zHm8Fk+UOwtAc1XaWXBdOF0f
	gbfCBJb0fuL/MsWCnsblDEE+V1YWmorBd4ITbeu3KWeo4JoS8HCtl1JIJerxOO08HumPkNd2+/N
	ZYQTrdtTvD9uV2a4k+T8BH848DAizc2W8dNi5/hMicxVz8q0OPwK83rpZTtaXzw6HPV8Psn3HB+
	HQqywjV3G1JXbhOa9PfsjeMfsAYZuZ4tNiUjL810oI/JSVq6Fqh5Nl79ljUElJQD7wAT8JdIGSi
	tOsVXZ0RH0EH/yoeY4oZcHmhJJ20f647f0jKy9CNwuU2ei1WbcSICHoe8k5JU2b+w==
X-Received: by 2002:a05:6a21:7a9b:b0:3bf:64cd:c45e with SMTP id adf61e73a8af0-3c35731bd15mr5639748637.4.1784078220446;
        Tue, 14 Jul 2026 18:17:00 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4cbafa1sm83586250eec.6.2026.07.14.18.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 18:16:59 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCH] ata: ahci_da850: use devm_platform_ioremap_resource()
Date: Tue, 14 Jul 2026 18:16:58 -0700
Message-ID: <20260715011658.1284298-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the open-coded platform_get_resource(IORESOURCE_MEM, 1) plus
devm_ioremap() sequence with devm_platform_ioremap_resource(pdev, 1),
which looks up resource index 1 (the power-down control register),
reserves it and maps it in one call, returning an ERR_PTR checked with
IS_ERR()/PTR_ERR(). Resource index 0 (the AHCI register block) is still
mapped separately as hpriv->mmio via ahci_platform_get_resources().

Built for ARM (davinci_all_defconfig + CONFIG_AHCI_DA850) with LLVM=1;
drivers/ata/ahci_da850.o compiles cleanly.

Assisted-by: opencode:hy3-free
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/ahci_da850.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
index f97566c420f8..4e53ff96d712 100644
--- a/drivers/ata/ahci_da850.c
+++ b/drivers/ata/ahci_da850.c
@@ -162,7 +162,6 @@ static int ahci_da850_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
 	void __iomem *pwrdn_reg;
-	struct resource *res;
 	u32 mpy;
 	int rc;
 
@@ -198,22 +197,14 @@ static int ahci_da850_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	pwrdn_reg = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(pwrdn_reg))
+		return PTR_ERR(pwrdn_reg);
+
 	rc = ahci_platform_enable_resources(hpriv);
 	if (rc)
 		return rc;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res) {
-		rc = -ENODEV;
-		goto disable_resources;
-	}
-
-	pwrdn_reg = devm_ioremap(dev, res->start, resource_size(res));
-	if (!pwrdn_reg) {
-		rc = -ENOMEM;
-		goto disable_resources;
-	}
-
 	da850_sata_init(dev, pwrdn_reg, hpriv->mmio, mpy);
 
 	rc = ahci_platform_init_host(pdev, hpriv, &ahci_da850_port_info,
-- 
2.55.0

