Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143C1235045
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 00:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782950644; cv=none; b=ePiwtUriDZYL5x7SgWdYOgTTabVfjn/HdfKM4eSrXYexQc67E8ZvfgGDnyjdqyCgnm/BcqS/B4OI621A2C8sl2oeJbBH26zHIk+yMWI2+AGkvkD7jLClnzai4ZKvk/kT1WbLi2qVyZrkYBkZ0/5GsO+uVx86lZWumiIy8Y7MgPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782950644; c=relaxed/simple;
	bh=u2ur4E6pDPxKJs3uEW3rMjm2qyJ0xBNnYlMSjUeCyRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dU6eYwNifWGOeNHrXpj+Pytf6FQC0VLxGrenFJfqaXNLpUBR+uqLY5BefzrIXORE738rm6uEwfh8R0c9n5n6MHoDF/1QQNsXMu0jpmEBy2Dt7bMkH5u0m9gOsuD9haHtbzVl9eOaLYUX42kkWsUk/+fNxZ2Ez9vESH7movWDGwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rJR8wwAF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJR8wwAF"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c9d87b1f9eso11396985ad.3
        for <linux-ide@vger.kernel.org>; Wed, 01 Jul 2026 17:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782950642; x=1783555442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N43A/aEWqRA4BuvedjMHJxBh4VYj+KoAKOtszsGRxeY=;
        b=rJR8wwAFhZDR97SWOzsLdAYJ6JulkTgozd9jJuoEw6GHYtZCFY0WUlROJBTFhn9mTZ
         +zvJ9bWVjujXjdUNsUOmyL1uBVs/5WrLKHt/WHVUcSwpAiJBQZ5eE3NQpe97Vp52f3E7
         YKBLN4kY9sH4Z5zlrwKBUB3SDTOyZlw+j6n1atMDlXm4VLSaJJPPKTtXKnxEmuJZRDSf
         0/v7qkr3fhQfnaLli59CCP/dPdS49O1JQ0Lxae7WxuVnv2SgbJ80rRYmCE953hkoSkwo
         Q8CN6AyvHJoM1mgn10zc7igR+cwphyCxw0G130z81UrCP+1w4T1j97ADZjkOK8AjPZMB
         F+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782950642; x=1783555442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N43A/aEWqRA4BuvedjMHJxBh4VYj+KoAKOtszsGRxeY=;
        b=Te1WvNQhPXFv68pVUhxfNKYgazbh4ImTK9VorQ0GPKKVcNCQvJHGGE0lYV4SOIrutk
         y5PtQdrBek+6+gcl/TmXt9D3xKLCC4r47ms20Vu2/yPL8fSCQsyfJ696lvQuTHor//Up
         hlHqkV3lrCOYe4+colrMMRqO72Szya8QFPG3iI5LzAGfhJItU/IhABE1CflvN3sv+tu5
         Yigb1kabj7HEfPvbkyGu6Az/uFMFFPvEqON1Y9fY9ZlrR4FtH5gYuFjuDu53k7G61og6
         NO6LG68OeF6EAzjIs90hE6RwGyA+VZFYTkHILR2Fn30DihBVv5fkLsXigZSrGBn7ZX1K
         xKcQ==
X-Gm-Message-State: AOJu0YyMGpVaqXkuwhjrYhUeUlCas3gUhcvYWsVhqHYLj/m3tmCPYzf3
	frqf1vExnc/1EsoaqpatjVtw+4j+6h9OX0romCtAKtt9lmdsiqb7rY/XTCI/rw==
X-Gm-Gg: AfdE7cnWjEajS53/jZ/CAFnlP+O+/hmf7B38isDXmx+sDK0J0acAU6a5btPtGe0X9TK
	1vOmwd41jNSkfKBgoIVg3L7djNW1MGUKyl4GzIUM/gNlS+JZcCoTHVDii39nYwiIxstMPRrBblj
	+IxqkDEa54ujpcV1W8gg4w3NfRyVZ9QPqeRoeFOAin1XCvlyDpx7GbTWXOnbB86nac2NaWOQat2
	sEYHdj/oopKTlhv6BNGp6gqFEP/JaFgofF1VsYxtM0Q908DeMydPcOsKpiS+Rpzzp0HU8z/a89S
	A3ziGVG2uVxABDHDc/Hj4LHQSTmvjjrcq7v/7EDFhvqlDNvpI42A4siSCCqS/kGiM1TXS/C78Gq
	PB6kB6RtjePSJa4ffkRYUbkrIw2rb0F3ZukQdpdKEilpl2a7I759u8A8+e0CbcU1KHd+FzYR1NC
	VFTFvqGS3+UzSndZqBHDS1yF2VK10ivcEr0q2jHJ6TBeH8GWdf7LqtQy2Iv7dxjwrhFVQRv/tmA
	RT2j4aGNw==
X-Received: by 2002:a17:902:e811:b0:2c9:fec5:ae82 with SMTP id d9443c01a7336-2ca7e8b3a8cmr40694185ad.44.1782950641995;
        Wed, 01 Jul 2026 17:04:01 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a9fee7csm5023255ad.69.2026.07.01.17.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 17:04:00 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 7/8] ata: sata_dwc_460ex: fix PHY lifecycle ordering on device removal
Date: Wed,  1 Jul 2026 17:03:49 -0700
Message-ID: <20260702000350.68331-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702000350.68331-1-rosenp@gmail.com>
References: <20260702000350.68331-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sata_dwc_remove() calls phy_exit() while phy_power_off() is still
pending in sata_dwc_port_stop(), which runs later during device
teardown.  This violates the expected PHY sequencing of power_off
before exit.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_dwc_460ex.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index f26220cac130..e8e2790be1d6 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -864,10 +864,14 @@ static int sata_dwc_port_start(struct ata_port *ap)
 	if (err)
 		goto CLEANUP_ALLOC;
 
-	err = phy_power_on(hsdev->phy);
+	err = phy_init(hsdev->phy);
 	if (err)
 		goto CLEANUP_ALLOC;
 
+	err = phy_power_on(hsdev->phy);
+	if (err)
+		goto CLEANUP_PHY;
+
 	for (i = 0; i < SATA_DWC_QCMD_MAX; i++)
 		hsdevp->cmd_issued[i] = SATA_DWC_CMD_ISSUED_NOT;
 
@@ -893,6 +897,8 @@ static int sata_dwc_port_start(struct ata_port *ap)
 	dev_dbg(ap->dev, "%s: done\n", __func__);
 	return 0;
 
+CLEANUP_PHY:
+	phy_exit(hsdev->phy);
 CLEANUP_ALLOC:
 	kfree(hsdevp);
 CLEANUP:
@@ -910,6 +916,7 @@ static void sata_dwc_port_stop(struct ata_port *ap)
 	dmaengine_terminate_sync(hsdevp->chan);
 	dma_release_channel(hsdevp->chan);
 	phy_power_off(hsdev->phy);
+	phy_exit(hsdev->phy);
 
 	kfree(hsdevp);
 	ap->private_data = NULL;
@@ -1176,6 +1183,10 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	if (irq < 0)
 		return irq;
 
+	hsdev->phy = devm_phy_optional_get(dev, "sata-phy");
+	if (IS_ERR(hsdev->phy))
+		return PTR_ERR(hsdev->phy);
+
 #ifdef CONFIG_SATA_DWC_OLD_DMA
 	if (!device_property_present(dev, "dmas")) {
 		err = sata_dwc_dma_init_old(ofdev, hsdev);
@@ -1184,29 +1195,26 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	}
 #endif
 
-	hsdev->phy = devm_phy_optional_get(dev, "sata-phy");
-	if (IS_ERR(hsdev->phy))
-		return PTR_ERR(hsdev->phy);
-
-	err = phy_init(hsdev->phy);
-	if (err)
-		goto error_out;
-
 	/*
 	 * Now, register with libATA core, this will also initiate the
 	 * device discovery process, invoking our port_start() handler &
 	 * error_handler() to execute a dummy Softreset EH session
 	 */
 	err = ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_sht);
-	if (err)
+	if (err) {
 		dev_err(dev, "failed to activate host");
+		goto error_out;
+	}
 
 	/* Enable SATA Interrupts */
 	sata_dwc_enable_interrupts(hsdev);
 	return 0;
 
 error_out:
-	phy_exit(hsdev->phy);
+#ifdef CONFIG_SATA_DWC_OLD_DMA
+	if (!device_property_present(dev, "dmas"))
+		sata_dwc_dma_exit_old(hsdev);
+#endif
 	return err;
 }
 
@@ -1220,8 +1228,6 @@ static void sata_dwc_remove(struct platform_device *ofdev)
 
 	ata_host_detach(host);
 
-	phy_exit(hsdev->phy);
-
 #ifdef CONFIG_SATA_DWC_OLD_DMA
 	/* Free SATA DMA resources */
 	sata_dwc_dma_exit_old(hsdev);
-- 
2.55.0

