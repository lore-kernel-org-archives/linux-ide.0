Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C85D1A683D
	for <linux-ide@vger.kernel.org>; Wed,  5 Aug 2026 01:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785891692; cv=none; b=XllaOidWxX2tsXi239ynw4GHfQVnLnQV/itkp2NCWSn9peGhBFwbkslHp2COxJwYtJFwz4RdtO3Mdw7geFEcPTMlS7Gh8PD2pKNyH69MpesV+vqleXP/ci7HJlNenCbY/jH8cykIvXGwoQzy1oquK32QSUWPv4ibNhrwmLboPXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785891692; c=relaxed/simple;
	bh=YZ+mS1LuMbk/lPhIaioRVfB6MBGPJLZMQuwuv1REBEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AbqlKs6N8Yt2HR3BqQQ9PEPbgaCR4ANIyDMykcyDrpyMGPNxFxIl0DUSLM2udTeb1PnJhQyvyebjNIOfG9jJ87nHtOsLMi/GeXdzawbdoSgKnfUGfY+CPx6R9snuoPsQxw1Xd/ny5+dVY7utdBTzWZ1c5jrENsodlTyqEzpJdpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpy+puHo; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpy+puHo"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cbb7926836eso278564a12.3
        for <linux-ide@vger.kernel.org>; Tue, 04 Aug 2026 18:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785891691; x=1786496491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4XuxSJP/B0gfu0C+PKEJdo8n87k1qi6fQPOexRsSfd4=;
        b=lpy+puHoSGDOmWR/8HZOdrYBTBPy/8odAcee4jbMqvuI28k8hw7858FdI3Z19kLnA/
         QZ2FpR2wUReb2DG8zYIngOkJKycuQZ5eZZeiz6WhL73v4XxicBcyDduGMJJBJ5lfcJsl
         UYLMafxe78Q7bjeGfc/MDAXlgGWtjBet9pP4XDKbvgcl/sWMXY+VM1LgyAGLtkk58b3X
         HFDne7pAJXdoXyvtYjgDYxrhN5hQA0cRBt7K/FnhwY5/jjekGTIvonGxl5reLrh5YAA9
         E5fYjWMYajTFxepPsfJsMhISa0KW1DQ59Fs7OtHEkaM/ipALGeuhWHXQv9GzsZvz7zXx
         zRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785891691; x=1786496491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4XuxSJP/B0gfu0C+PKEJdo8n87k1qi6fQPOexRsSfd4=;
        b=QuiWoQaxITPBpU4Wbr3rBL7ZanUIxKTq3v4i1nB4IIpNQVloscyrDgd7y88CWgQ86T
         oLcv2sDU66+2OjY2K0Zj26bEGAKp0oqCB3GkMJEGhT7/Gk5pl+jxfefj9Q5XYRzW/aNU
         jKfsITn6bKHxCf008+9BHhasUJK/JirFsskXPXCDSAgQZU5mG/wVgJMfOCfwizPq1yjM
         +6B1UAoCDO4bqB3A3VmyvNAAdiLgVdDf5ePY63IOfkX2VTZNVwiJYeyJhuEWcxZyYlCT
         AzcGcANOVA14KyoMoRaIBwZq9W6ymDbTbluxI/mWCu6ikXfvDqSkm+gy9VxEg7lLqCdX
         4LCg==
X-Gm-Message-State: AOJu0YyF8Go4MV1yWORuJfiWwJMIDy8FbidK+PUZCw22oxUzoOC80LAM
	cYIBOA0yvfEUJWg5av8lXMAEBj1I4SHE1M9/VMBv+fWjj5wsDrOUVO2Qz0FvBg==
X-Gm-Gg: AR+sD10ykXK8r2aMl9cxMBMwoGLR3AhlVvD96YkR6V/KSLjIyANWTayGprrEuRIDRnT
	pHiH3LCOoh423Ylrr5sQxFQbLNChQzt/lWl0NWV8yH1T44ETG6KyJOXYLW4xrUlH+XO0nVOcVBf
	Rfdsxqrqs02yBP9uBEhwuI0olJP3bhcvLqTRr0uRIcQlcxP6jJsoh9kZOinNTgOFawa08CrNbs9
	1KrCSzNg8/7T4P9A0NxiJB/r95TCFABoa4f9UEZk4Z/M4xHt4Hy2JAjpkZ/aG/21Fz/JJkRb475
	ugThkwxJj4kUZUVVF+E+oNpD76yveBFnWpCLlD92elhMlssU5Zv2PULhZurSx8wKrkglD6hKT4f
	fDwJadI8tomAE31hUX6KHlMuqTR+I6P4XAEMH4gczzMIE9yKcfJOgASsoNxIutUHTr0f5QLoQYq
	LrUOpiPIdM/UeK4CZC9KVpktU+dMrKl6o09UZMdWUGUseRqzlo/klBvM0gVZlyiZ36x3vBvv+wS
	q/aCHxlPnR6T4r1vn/TOVhg9rvcQKHMhzlnWE7xNYGw+zj9+UqENC5EGBoQKCY/C6nJ25H7/iN4
	3vqOc9CYLO1SY+1JO/NiBHdmnl1Oi/9Pqo/BZA==
X-Received: by 2002:a05:6a00:1886:b0:847:99a7:c751 with SMTP id d2e1a72fcca58-84f2e05d02dmr2505239b3a.25.1785891690531;
        Tue, 04 Aug 2026 18:01:30 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe707cab43sm427021a12.3.2026.08.04.18.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 18:01:29 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ata: sata_mv: init and power phy per-port in port_start
Date: Tue,  4 Aug 2026 18:01:28 -0700
Message-ID: <20260805010128.90171-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move phy_init()/phy_power_on() out of mv_platform_probe() and into
mv_port_start(), with matching phy_power_off()/phy_exit() in
mv_port_stop().  This ties the phy lifecycle to the port lifecycle
instead of powering phys up-front in probe, and lets the generic
ata_platform_remove_one() replace the custom mv_platform_remove().

Rework mv_platform_probe() error handling to return directly now
that cleanup is handled by devres, dropping the err: label and the
now-dead hpriv->n_ports assignments in the per-port error paths.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_mv.c | 72 +++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 43 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index d260f04e6384..e811202a6873 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -1670,8 +1670,10 @@ static int mv_port_start(struct ata_port *ap)
 {
 	struct device *dev = ap->host->dev;
 	struct mv_host_priv *hpriv = ap->host->private_data;
+	struct phy *phy = hpriv->port_phys[ap->port_no];
 	struct mv_port_priv *pp;
 	unsigned long flags;
+	int rc = -ENOMEM;
 	int tag;
 
 	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
@@ -1711,11 +1713,23 @@ static int mv_port_start(struct ata_port *ap)
 	mv_edma_cfg(ap, 0, 0);
 	spin_unlock_irqrestore(ap->lock, flags);
 
+	if (phy) {
+		rc = phy_init(phy);
+		if (rc)
+			goto out_port_free_dma_mem;
+
+		rc = phy_power_on(phy);
+		if (rc)
+			goto out_port_phy_exit;
+	}
+
 	return 0;
 
+out_port_phy_exit:
+	phy_exit(phy);
 out_port_free_dma_mem:
 	mv_port_free_dma_mem(ap);
-	return -ENOMEM;
+	return rc;
 }
 
 /**
@@ -1729,6 +1743,8 @@ static int mv_port_start(struct ata_port *ap)
  */
 static void mv_port_stop(struct ata_port *ap)
 {
+	struct mv_host_priv *hpriv = ap->host->private_data;
+	struct phy *phy = hpriv->port_phys[ap->port_no];
 	unsigned long flags;
 
 	spin_lock_irqsave(ap->lock, flags);
@@ -1736,6 +1752,11 @@ static void mv_port_stop(struct ata_port *ap)
 	mv_enable_port_irqs(ap, 0);
 	spin_unlock_irqrestore(ap->lock, flags);
 	mv_port_free_dma_mem(ap);
+
+	if (phy) {
+		phy_power_off(phy);
+		phy_exit(phy);
+	}
 }
 
 /**
@@ -4096,26 +4117,18 @@ static int mv_platform_probe(struct platform_device *pdev)
 		char port_number[16];
 		sprintf(port_number, "%d", port);
 		hpriv->port_clks[port] = devm_clk_get_optional_enabled(&pdev->dev, port_number);
-		if (IS_ERR(hpriv->port_clks[port])) {
-			rc = PTR_ERR(hpriv->port_clks[port]);
-			hpriv->n_ports = port;
-			goto err;
-		}
+		if (IS_ERR(hpriv->port_clks[port]))
+			return PTR_ERR(hpriv->port_clks[port]);
 
 		sprintf(port_number, "port%d", port);
 		hpriv->port_phys[port] = devm_phy_optional_get(&pdev->dev,
 							       port_number);
 		if (IS_ERR(hpriv->port_phys[port])) {
 			rc = PTR_ERR(hpriv->port_phys[port]);
-			hpriv->port_phys[port] = NULL;
 			if (rc != -EPROBE_DEFER)
 				dev_warn(&pdev->dev, "error getting phy %d", rc);
-
-			/* Cleanup only the initialized ports */
-			hpriv->n_ports = port;
-			goto err;
+			return rc;
 		}
-		phy_power_on(hpriv->port_phys[port]);
 	}
 
 	/* All the ports have been initialized */
@@ -4130,7 +4143,7 @@ static int mv_platform_probe(struct platform_device *pdev)
 
 	rc = mv_create_dma_pools(hpriv, &pdev->dev);
 	if (rc)
-		goto err;
+		return rc;
 
 	/*
 	 * To allow disk hotplug on Armada 370/XP SoCs, the PHY speed must be
@@ -4144,39 +4157,12 @@ static int mv_platform_probe(struct platform_device *pdev)
 	/* initialize adapter */
 	rc = mv_init_host(host);
 	if (rc)
-		goto err;
+		return rc;
 
 	dev_info(&pdev->dev, "slots %u ports %d\n",
 		 (unsigned)MV_MAX_Q_DEPTH, host->n_ports);
 
-	rc = ata_host_activate(host, irq, mv_interrupt, IRQF_SHARED, &mv6_sht);
-	if (!rc)
-		return 0;
-
-err:
-	for (port = 0; port < hpriv->n_ports; port++)
-		phy_power_off(hpriv->port_phys[port]);
-
-	return rc;
-}
-
-/*
- *
- *      mv_platform_remove    -       unplug a platform interface
- *      @pdev: platform device
- *
- *      A platform bus SATA device has been unplugged. Perform the needed
- *      cleanup. Also called on module unload for any active devices.
- */
-static void mv_platform_remove(struct platform_device *pdev)
-{
-	struct ata_host *host = platform_get_drvdata(pdev);
-	struct mv_host_priv *hpriv = host->private_data;
-	int port;
-	ata_host_detach(host);
-
-	for (port = 0; port < host->n_ports; port++)
-		phy_power_off(hpriv->port_phys[port]);
+	return ata_host_activate(host, irq, mv_interrupt, IRQF_SHARED, &mv6_sht);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -4232,7 +4218,7 @@ MODULE_DEVICE_TABLE(of, mv_sata_dt_ids);
 
 static struct platform_driver mv_platform_driver = {
 	.probe		= mv_platform_probe,
-	.remove		= mv_platform_remove,
+	.remove		= ata_platform_remove_one,
 	.suspend	= mv_platform_suspend,
 	.resume		= mv_platform_resume,
 	.driver		= {
-- 
2.55.0

