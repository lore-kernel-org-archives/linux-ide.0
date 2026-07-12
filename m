Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60701385D73
	for <linux-ide@vger.kernel.org>; Sun, 12 Jul 2026 22:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783895858; cv=none; b=L5E+3ut1i1REQeF0i1llnLUKfxYwMAWuqyYFa6Uw9/2JMbBg4pqJkf7p7HbclEVH0Zlf/Rrd2yzNaVAG9QgKa9+F1jpuS7B0doAvE8kbumfPljzXOEXobklyhUYpNkZpz4pP4s+humdFavvHUvtl0lJlQ3Oa1gLMd7FZA2rBD1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783895858; c=relaxed/simple;
	bh=08oSprP+WwMmz0m9FBUy9RlZxGSVrMAPZ0iqQCT2AYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tgd43cMEy7i+mo0n93aJB2uT7dfGDQXYwJWzKmHgfcE2kRRqELxFln7EltiaorPkbVt+6WYF+vUqsbjuXLadgHz/s8KAiOoCnBZBj0PPtwzwcbRwyr6zsaS5nRlghfxLsJAkTZ9qCeK5opeTFC5Ip+DADfYEhsjuA+UagvDXKhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6oheFM3; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6oheFM3"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-383cb94f742so2128712a91.3
        for <linux-ide@vger.kernel.org>; Sun, 12 Jul 2026 15:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783895855; x=1784500655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YWATwDIutTx1ltHXfU6mx7SFptf2vWEErjZvLZxT9JI=;
        b=i6oheFM3Jljkgt+O0MgzUGTdtxyYEHpREKStRO4vbQ1UTMyRrb+S7njXfangv9ghg/
         j/C6Txk5gN7X3glbroOz1xvH8ycHTrEfCc6aZ4KkpSdMVhImoavLFl6GEMBGl2bBYr4e
         uKqDEA/8MDpx/Qto6vcXtXQZ+gd+AI8A0Jbdzg2XyTDdkXBUqfGWQ4jyYz5MsEUU0M6L
         4acJRPrU15n0qW/Zhpq3jXKJ35zjT+LjVnzXCtAEaOMp/L3WkOrT/Cui9irJLUmpx1h1
         Al1EOQR38uCg9gXyK8KvWxwO0G7+qavJjU3R4hxTEBjyOsHMVlYD3WWVi8xUmcGFglWd
         PQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783895855; x=1784500655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YWATwDIutTx1ltHXfU6mx7SFptf2vWEErjZvLZxT9JI=;
        b=ITNs/chuKgb9zP4jupjEWcwIJrKsiQ7PFyFyXmcgcxXY49Z3pf1dXVn+k0hMrnGogC
         U3FuPR6pYWkVHsoIlCNlxWOqNZLBQaq0bH1PMW8fpwFYwRQfTxs/z7opgANNh/tJZTvJ
         q7jRmq1+101CGCWRkNM/3Brt5emyL8u1DX+7gz+5xK80CQ+BhDd1ZF2OAAjH4SMHxPQj
         ydsARqi9EaDZX9fT/Ai+1DzFp/UZg7DcHcKHO/Lw0bVmSVUU886ZjmiOX9NCDvljr4wf
         7X5YfGdR+qDONkqoEofVE5VHXXF9qU2QibVZSGg5iIC2IKjQI0bLtd35y9UMebx7Ep/8
         nlxw==
X-Gm-Message-State: AOJu0YwXgs/n1IhpnU2ADxKhCUy3TIzgQqWDLuj1ENyy7llVDkExR7Qw
	x61vkn1BhvVzwpwSbqrSzIb6uevYltINhEz1gBEBwXzCRGQt4Pi6KXlbQNEPXQ==
X-Gm-Gg: AfdE7ck8/A+/ufVAElNNY94vuVHf/aJDQ42iy3Sw8SxR5+KItmCN6dlrDisVoY3e0YV
	iYLZ2A2ZlqD2SAkSx/T8sDuSScVu+W8J4XHZp27ORAc0LayFoCyk35fTOJYDl6Vin6GKP93wT7C
	/VrKplmpXqlclwp2hid1ChU9R/DLvpzOqN4QJedMoHomIgVTVrleYlQAMJYjZt6dybgCMvEeJvJ
	OJVEJmdI3M4PJkNkGzgo0eU01+zzS2atS8FDCEnYNatB26VGb1DBiZKxxT1p4hdo0W/qbvQxTgD
	mU8eynaJ4Y/rjDdRJhfjNI8UYKLQ2P+0IDrNK6X1V7yT+oWXF1V+s4RjMagqC8obOb9zICvhjDJ
	qVIoip1M4nxOuLihY/yI2JNsDQZHxiqh174t8zz/3+Gj2RsY++2mqzIHyhKr4msHofoFoyjuHks
	ZOzRwvNmlb8dY5eVx+0ILOU5EWy1Lpapw0Fc+8u/v9RECdv+BxCq0q05cdiOeVsD0rN6uJohK2S
	n2SaeADKT1ter6+t13y6DKe3KHA3g2dIx/doyDBpXg4bRGkCZZDyOe3Vud4K2Ncpt89atdNlXZV
X-Received: by 2002:a17:90b:3c8d:b0:36d:7b62:4767 with SMTP id 98e67ed59e1d1-38dc78229ffmr6302452a91.5.1783895855294;
        Sun, 12 Jul 2026 15:37:35 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a5506b48bsm5517278a91.1.2026.07.12.15.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 15:37:34 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] ata: sata_mv: use devm clock helpers
Date: Sun, 12 Jul 2026 15:37:33 -0700
Message-ID: <20260712223733.1084077-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
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
 v2: sashiko: use goto instead of return.
 drivers/ata/sata_mv.c | 46 ++++++++++++-------------------------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 145ba6880c82..d260f04e6384 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4088,21 +4088,19 @@ static int mv_platform_probe(struct platform_device *pdev)
 
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
+		if (IS_ERR(hpriv->port_clks[port])) {
+			rc = PTR_ERR(hpriv->port_clks[port]);
+			hpriv->n_ports = port;
+			goto err;
+		}
 
 		sprintf(port_number, "port%d", port);
 		hpriv->port_phys[port] = devm_phy_optional_get(&pdev->dev,
@@ -4116,8 +4114,8 @@ static int mv_platform_probe(struct platform_device *pdev)
 			/* Cleanup only the initialized ports */
 			hpriv->n_ports = port;
 			goto err;
-		} else
-			phy_power_on(hpriv->port_phys[port]);
+		}
+		phy_power_on(hpriv->port_phys[port]);
 	}
 
 	/* All the ports have been initialized */
@@ -4156,17 +4154,8 @@ static int mv_platform_probe(struct platform_device *pdev)
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
@@ -4186,17 +4175,8 @@ static void mv_platform_remove(struct platform_device *pdev)
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
2.55.0

