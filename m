Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFF5372B57
	for <linux-ide@vger.kernel.org>; Wed, 10 Jun 2026 06:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781073332; cv=none; b=ZMpp/NpOGWCefBOKCeGUnokOc8rZ6J5BUFK8uh4f2Td7slqzikq25yAgc7psSABelZuiiyvYLhpZah2011a0KmLthxMwOgnCnePaELIubL1lnYrsS7vr5Iac02Jyj2fA8qQPx6h6F9muw2lAlum0qUS2115A4mpOu7bAD9B10J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781073332; c=relaxed/simple;
	bh=xKbnNbZnqB2nd85SrmMAVGWPLWF5LKQ/BFwrABZk+2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VSkr3t1lOVxhZ6JlbVgrmEjk1dDHEQhfnN3NFaSDBt+X12w58PtwA5qvr2dDrXOnwci9pYuP6183QI+OCIWBwkY9YMuoEcrz9lvcq6GuVu8CJ6ekz1m3U8tvoLLtSlHHp3VlS8+XJcty8Ar+3Ql1P9bmmsOqeMUjQOObq9Nb0Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hK8pCXR3; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hK8pCXR3"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c0b9328c4aso44339465ad.0
        for <linux-ide@vger.kernel.org>; Tue, 09 Jun 2026 23:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781073330; x=1781678130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bJ8wGY3Oxo53ZMrvTeyzLuOS7slHbJkEn0sMzVfN/G0=;
        b=hK8pCXR3JULSoEd+BykI19j90bR+Ea/54gWySeZqBWI5nWTery4Ltlga8ktHcDT7un
         jVNEi6wbAO/fgoAlz7O6tQ2nVbFPelWZX18zcg+jnSUme/HR/187dYyNVVIbTVV2jLNP
         9tgsXH9gZOAkXNmBrGkt4vx8XGIfaZHGIxVQG8V5i5gtt1XZdL/oD+xYUoSQhl68ODcQ
         owVzaYqp2PYhUYoj8W+RGay6UwghDfc5EGPmYEnU0JfhEUbHZL1sEvT9GjFdd4tebU78
         2nJjlhmUpGVKrNNKbzOaq8CqI6IZlAVIpqkyKYNkBxYOqBJHVFFH14gBTNLLJQJ/NYRI
         Krng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781073330; x=1781678130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJ8wGY3Oxo53ZMrvTeyzLuOS7slHbJkEn0sMzVfN/G0=;
        b=kMVnMBPRhdx+qaPmbaQHVJlr9pyU85SQad2RqPVvYyTypQ6y38vIWjDR00cZF7sL+N
         DrWQpcn6TSUu18Wr4byHSRZp1wFKtmxlYSmYdaxHHoaWF9lrKUSDVTMGIemgKCEamePi
         m+2UprjbkVAlh/php5fOtxPTEQGUAVAeug48um2DlmB1c+bOqe8TzRnOs7QV7Rj6wGyi
         GkQ2P1xvH1pnt3UnepfnqxF1rbqjjI2L0kY4ZUdsXrnLeYaKF491gdAFiXnTtPQ0EQa5
         OWWpTYOEMAFiYOKYOnThv1/gyS6Bo+cjVmIND1M1HGRYqMZtLdNXwQEuqEzLpU5TiGz2
         cyOg==
X-Gm-Message-State: AOJu0YxrA9SBqwJC9UmoRWFdN2x0bScIsNpKbeSjmhUDT/QeCXnXuKek
	0/VERsGqFoRHfFVtLwSCGgRSkAe0T8Oe6kW4xmil3pm5fX77B7NsuDq5EtkXlVRL
X-Gm-Gg: Acq92OESvfIzWsN8798/5VjhzOzMZubN0yJrRZlBqaVxJz9W6/0/6pbYoB4BHVWqvGJ
	HwOBfFFy8GIQrHQCNOhjFYrmm6qvG7YDauIkTucuEM5awpN0qx3ZXOPrPOZjeOqi4P/sHSOcayz
	905WpKH5XNfSb7x4oOsiTx50mPLnliHfCXESNlXdxbp3+KIaqwS2MPKV6bHnPh4FotLwo8gBHdV
	liUqm5kEA8muvHdjqmw3z75115hBTg2aG40znNKrsqNZYBNz+7CLk3oBUXyAy+9UJbxegX1Jcn+
	zVYW4gZHsdlSsEai5VzhcczfIKjTpwfqosIHxYjFs+0Y6rfAEKj4x3ql+Ru8BSBDW/hdLkVM9ze
	zuqnemYSfjY9fC8BbnV1BY53dak840es96EkJCDeeXrIpAx0xpmqKd36c7hbXbva+IAYe8ITNYS
	MpcLZKSdsYakZ+nZjH5JNv/pCdrz1CBX4xqx8A+y2+BZHHsRKKEhSvjN5BmlzWhoarjtCDA1nIc
	+9PoIQX6kYf49jqU+eTi/q7N8TXRRiMmT/irSb5qnq8Al5DoXG/G5bj
X-Received: by 2002:a17:902:c40e:b0:2c1:e9f8:758d with SMTP id d9443c01a7336-2c2a1c65e95mr78126335ad.22.1781073330036;
        Tue, 09 Jun 2026 23:35:30 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664950aesm226488825ad.69.2026.06.09.23.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:35:29 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ata: sata_mv: use devm clock helpers
Date: Tue,  9 Jun 2026 23:35:12 -0700
Message-ID: <20260610063512.109464-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace clk_get/clk_prepare_enable/clk_put with
devm_clk_get_optional_enabled for both the main clock and
per-port clocks. This eliminates the need for manual clock
cleanup in probe error and remove paths.

The err label is retained for phy_power_off cleanup, since
devm_phy_optional_get does not manage phy power state.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_mv.c | 45 +++++++++++--------------------------------
 1 file changed, 11 insertions(+), 34 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index ecf1653321e5..fdd86573a823 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4090,21 +4090,16 @@ static int mv_platform_probe(struct platform_device *pdev)
 
 	hpriv->base -= SATAHC0_REG_BASE;
 
-	hpriv->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(hpriv->clk)) {
-		dev_notice(&pdev->dev, "cannot get optional clkdev\n");
-	} else {
-		rc = clk_prepare_enable(hpriv->clk);
-		if (rc)
-			goto err;
-	}
+	hpriv->clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
+	if (IS_ERR(hpriv->clk))
+		return PTR_ERR(hpriv->clk);
 
 	for (port = 0; port < n_ports; port++) {
 		char port_number[16];
 		sprintf(port_number, "%d", port);
-		hpriv->port_clks[port] = clk_get(&pdev->dev, port_number);
-		if (!IS_ERR(hpriv->port_clks[port]))
-			clk_prepare_enable(hpriv->port_clks[port]);
+		hpriv->port_clks[port] = devm_clk_get_optional_enabled(&pdev->dev, port_number);
+		if (IS_ERR(hpriv->port_clks[port]))
+			return PTR_ERR(hpriv->port_clks[port]);
 
 		sprintf(port_number, "port%d", port);
 		hpriv->port_phys[port] = devm_phy_optional_get(&pdev->dev,
@@ -4117,9 +4112,9 @@ static int mv_platform_probe(struct platform_device *pdev)
 
 			/* Cleanup only the initialized ports */
 			hpriv->n_ports = port;
-			goto err;
-		} else
-			phy_power_on(hpriv->port_phys[port]);
+			return rc;
+		}
+		phy_power_on(hpriv->port_phys[port]);
 	}
 
 	/* All the ports have been initialized */
@@ -4158,17 +4153,8 @@ static int mv_platform_probe(struct platform_device *pdev)
 		return 0;
 
 err:
-	if (!IS_ERR(hpriv->clk)) {
-		clk_disable_unprepare(hpriv->clk);
-		clk_put(hpriv->clk);
-	}
-	for (port = 0; port < hpriv->n_ports; port++) {
-		if (!IS_ERR(hpriv->port_clks[port])) {
-			clk_disable_unprepare(hpriv->port_clks[port]);
-			clk_put(hpriv->port_clks[port]);
-		}
+	for (port = 0; port < hpriv->n_ports; port++)
 		phy_power_off(hpriv->port_phys[port]);
-	}
 
 	return rc;
 }
@@ -4188,17 +4174,8 @@ static void mv_platform_remove(struct platform_device *pdev)
 	int port;
 	ata_host_detach(host);
 
-	if (!IS_ERR(hpriv->clk)) {
-		clk_disable_unprepare(hpriv->clk);
-		clk_put(hpriv->clk);
-	}
-	for (port = 0; port < host->n_ports; port++) {
-		if (!IS_ERR(hpriv->port_clks[port])) {
-			clk_disable_unprepare(hpriv->port_clks[port]);
-			clk_put(hpriv->port_clks[port]);
-		}
+	for (port = 0; port < host->n_ports; port++)
 		phy_power_off(hpriv->port_phys[port]);
-	}
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.54.0

