Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6221DFFB
	for <linux-ide@vger.kernel.org>; Thu, 23 Jul 2026 00:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784765533; cv=none; b=AgwrudxeEEGOOWsdL1SDlSUlW+2XezmBFaluPmwymqMRM8uzo3YorgcJ4GdYlUSVvhL9iJrdzULo2IatQtkfKk0sbq6SbnjzQVDCvQfPxmIXgFYivHfgMSB6bs9fj7B0lvSmUsWiiGG4Xg8rjiUli4V0nA7JGIV2LD2jBGnprIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784765533; c=relaxed/simple;
	bh=6gQ8RELPs7kXsn5PgGweUn+iDbo9LuwS+5snvrITUDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cC/3VFMMnQ1r+swmyDbaoallMCTvj8SBChmHc+xInwZ6HO3TCfqMSpk1Csix7Yumjm1cWhkUWJEWy/svOVly4dZS95FgVylMW1LV+HY04GFD6PADUFEOIc2Pbcbcq/1ubxv+2OMYu9ejMlGsf9lszMN6yJhDIdg7neg02uDD59U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDEoySSv; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDEoySSv"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84867f07d63so50210b3a.2
        for <linux-ide@vger.kernel.org>; Wed, 22 Jul 2026 17:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784765531; x=1785370331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G2Juw97uYRh2DZVmJAt88/3mh1lYhmOIkr6Mu093zTI=;
        b=SDEoySSvU5BBdMM4vOSviMrAauT/C1RL3o5TIKbNf/bOFaSlHSXMncdrr33+Qjxoti
         My45POJioo3PFCdBp0KAf2HGai1JXgStwK8xx7QwKlupZUjXGtEyTqYfLdNnm+A5oMcy
         3km+nUgtDFoc5vVzeyEX26Nr3J1JwGKdUHCOgjIZjyDe42zHZN/owGeT7rbqcROAI/Oq
         b8qY0wpu7QjcuXYQhAgrWxw+boSstcft3l0jEhkS+dDyh3P3L2zn4SOSGMaPr3wi5xjR
         jDgBg/UZXb8Qsp3ekqXFfA3YaIf1ZBNeRbvLYRxymGFWGGy3Mc7KkwPBFZg6tE33/R7U
         t95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784765531; x=1785370331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G2Juw97uYRh2DZVmJAt88/3mh1lYhmOIkr6Mu093zTI=;
        b=ZsUueicSCjuoftWT28pHbkBh8HKJYYie1A4DENSfxixeo/YjkSpyO6+gyh0fjrJqaW
         UNxbR9ryrRi2Y0q4QL3bFUm7GtRqTNaUU0eEpQc4ntPN8XLIx7SPtt3xdeBOXs9ZCnKt
         EBbEB9AQ175C8BhvQJd71eq0ZyCnk4Ys5rvRLBbcXGSycjGieLmFtrRxTAV3dHWp6BT7
         moqM7H6tibNOBRE6Nh7sPxYemaiHP0WIPnHWe6M50ut+EwTlBdee5n3CLD+BvwV5fh4f
         a7rA4f9NBADNI5EDQfj0khJke52d+6P7CfwtyKBcu3ospfkOf0QbrNyzwEH0W9O6F/vb
         jNBw==
X-Gm-Message-State: AOJu0YwrJpTsmLmxmxUB4WBU+f9HrnNQ9JwmPCpfykppTHy+8/ewMSWR
	JJJoZNerilPK7TsTPfz3v05qas+4y4BL5HtSoafd4zJrcbmFqe+kJ5GlOpRN9A==
X-Gm-Gg: AR+sD12XGaV8m+uUL2kmBOAFRxi0vx3YAT7iiWYi6YTKoYxxf6NgdIWCbZnQIGINi5t
	vhkFdQNeGL/A3+vUsMDecTu6EHmqVw7QNBPlYeFTk7h/DeeQV5gjOekohBqyndZtKhDbr6indRI
	SHC4AfRf7glJPBvoOapC73x+PysYR5cCEpqCzH9jzrIiz5HqDSieb8L2nMWpgEVBca0xJbaonc4
	jsxTPzhbDdiSiyeG2WLvGbeO5CbkW6k2i3K+4vSST56yULcE8BzSw9aPWZuAiBswKO93cb91NzK
	IvV4O68N+6bjpIJu20ESA4xa7kR/ZqTOiDHJZmP5hbDgo/3PqT1cK+C0KeLg+tK2zm/pBmwg5q+
	twpW08NqbA1Ky7S5hxS1y1xYjrM6FdlFAr1um/UGcbNubceAE/EMPRgBGdUqHw/dsOrMj5pLYhu
	UDU8RWY49WUY6E9WGWhhw4L605izXVMILg0HK/Y0Xe2Rc/hBehRBUfoSUGBp47e9uYnUfgeVKl4
	Fcuo4XD6zJB59hrgKr+g8KYFuyAyYeij8JaYy6IbfZhlklhGwF1jF4=
X-Received: by 2002:a05:6a00:e88:b0:847:b16b:46d9 with SMTP id d2e1a72fcca58-84e2b8aa77bmr1119696b3a.34.1784765531462;
        Wed, 22 Jul 2026 17:12:11 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e1760025esm2037253b3a.57.2026.07.22.17.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 17:12:10 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Mans Rullgard <mans@mansr.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] ata: sata_dwc_460ex: fix PHY lifecycle ordering on device removal
Date: Wed, 22 Jul 2026 17:12:06 -0700
Message-ID: <20260723001208.1469323-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723001208.1469323-1-rosenp@gmail.com>
References: <20260723001208.1469323-1-rosenp@gmail.com>
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

Fixes: 0f48debdb906 ("ata: sata_dwc_460ex: add phy support")
Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_dwc_460ex.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 8e3fc713891a..8a1d80ac906a 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -851,10 +851,14 @@ static int sata_dwc_port_start(struct ata_port *ap)
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
 
@@ -880,6 +884,8 @@ static int sata_dwc_port_start(struct ata_port *ap)
 	dev_dbg(ap->dev, "%s: done\n", __func__);
 	return 0;
 
+CLEANUP_PHY:
+	phy_exit(hsdev->phy);
 CLEANUP_ALLOC:
 	kfree(hsdevp);
 CLEANUP:
@@ -897,6 +903,7 @@ static void sata_dwc_port_stop(struct ata_port *ap)
 	dmaengine_terminate_sync(hsdevp->chan);
 	dma_release_channel(hsdevp->chan);
 	phy_power_off(hsdev->phy);
+	phy_exit(hsdev->phy);
 
 	kfree(hsdevp);
 	ap->private_data = NULL;
@@ -1163,6 +1170,10 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	if (irq < 0)
 		return irq;
 
+	hsdev->phy = devm_phy_optional_get(dev, "sata-phy");
+	if (IS_ERR(hsdev->phy))
+		return PTR_ERR(hsdev->phy);
+
 #ifdef CONFIG_SATA_DWC_OLD_DMA
 	if (!of_property_present(dev->of_node, "dmas")) {
 		err = sata_dwc_dma_init_old(ofdev, hsdev);
@@ -1171,29 +1182,26 @@ static int sata_dwc_probe(struct platform_device *ofdev)
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
 
@@ -1205,8 +1213,6 @@ static void sata_dwc_remove(struct platform_device *ofdev)
 
 	ata_host_detach(host);
 
-	phy_exit(hsdev->phy);
-
 #ifdef CONFIG_SATA_DWC_OLD_DMA
 	/* Free SATA DMA resources */
 	sata_dwc_dma_exit_old(hsdev);
-- 
2.55.0

