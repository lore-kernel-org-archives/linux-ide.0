Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D70C4361B
	for <linux-ide@archiver.kernel.org>; Wed, 16 Dec 2020 21:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74828235E4
	for <linux-ide@archiver.kernel.org>; Wed, 16 Dec 2020 21:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgLPVmi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 16 Dec 2020 16:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgLPVmi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 16 Dec 2020 16:42:38 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A386C06138C;
        Wed, 16 Dec 2020 13:41:30 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id t37so18557617pga.7;
        Wed, 16 Dec 2020 13:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a8gJi+ana1NlWcm0KFOutFc313KZAok0yh+CKAqFjyQ=;
        b=OdhXpnJwabdtKR8/TTe35nCvGbb1I48LJRTHNThwseGjUP6bf5keqVwRzNVb/7eQLF
         YYO75COYkC19HQTISMUtp/nEv5+x2zEzgxCK5UubLlJnsprDrM7dtk95GF9K/Wt8y1hg
         4zVY2lEfmIm3AGWv0RW3xPrYNnkuEyuQQpyc8CLyWsQlJJnVVRtCNLhWCu3QcNgU2dRa
         GmKqv7Prq45/Ffi9mg4yb0CbtYA5RS2ETb65r+FTD/6uHHas9DaMLXvpsxhyf6niakjE
         71f4qqYBqJhCMxg4nzvPrpdvhauSgTeeeBtLWefgboqJ3cqrtVYYuJkO+nXMIcdC1rWW
         WLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a8gJi+ana1NlWcm0KFOutFc313KZAok0yh+CKAqFjyQ=;
        b=jMMmG6Y4MBcUrulD+XYtfysFETDX12YeMlK/WNuhOcAa2nkdnqBaCVo7/gnCu/D9R3
         qkYxzk20MhgEYTtlgbL4UjBgXhg9uthsrTQ8Wy1hxWT8coURs5w/BqtsMe5jii23gf2y
         WrFmi3RzaIYK4dROIITctM0rH+pM/iKN1ak7nZX3Cg1LY7xfE8AFFlIvKPlOwVEpmReO
         e8LaTP7EJZ5bsha0Ig4nLIXDFSO1MfbmKmpcBynvigVyC1ORiJib+cihWmbmwzIW7b+b
         9WB+g3dJB/pS6NkN2ChZk5rYp/8C7izoNnr7mfhHUomm+FVLVe3sHVJ5ADMAJKPYaI7u
         QPEA==
X-Gm-Message-State: AOAM533mvZ/+Kh7kWkMXRGvm2X8C4GA4PTPup4Xni9qqel5UALZ8+SAI
        3HsCSDNXt4PXqSnmmpbhhaE=
X-Google-Smtp-Source: ABdhPJzjjWQ6wAq0wn2TWelymAkSgMWu4vZORO7my3cAxzvmL3vgBFFQviFAnBqovKpvyAK8FZUj1w==
X-Received: by 2002:aa7:80c9:0:b029:197:6775:4a5b with SMTP id a9-20020aa780c90000b029019767754a5bmr33766294pfn.36.1608154889561;
        Wed, 16 Dec 2020 13:41:29 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id h12sm3612237pgf.49.2020.12.16.13.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 13:41:29 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
X-Google-Original-From: Jim Quinlan <james.quinlan@broadcom.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Jim Quinlan <jquinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH v3 1/2] ata: ahci_brcm: Fix use of BCM7216 reset controller
Date:   Wed, 16 Dec 2020 16:41:04 -0500
Message-Id: <20201216214106.32851-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201216214106.32851-1-james.quinlan@broadcom.com>
References: <20201216214106.32851-1-james.quinlan@broadcom.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Jim Quinlan <jquinlan@broadcom.com>

This driver may use one of two resets controllers.  Keep them in separate
variables to keep things simple.  The reset controller "rescal" is shared
between the AHCI driver and the PCIe driver for the BrcmSTB 7216 chip.  Use
devm_reset_control_get_optional_shared() to handle this sharing.

Fixes: 272ecd60a636 ("ata: ahci_brcm: BCM7216 reset is self de-asserting")
Fixes: c345ec6a50e9 ("ata: ahci_brcm: Support BCM7216 reset controller name")
Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
---
 drivers/ata/ahci_brcm.c | 46 ++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 49f7acbfcf01..bad455fb6ab8 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -86,7 +86,8 @@ struct brcm_ahci_priv {
 	u32 port_mask;
 	u32 quirks;
 	enum brcm_ahci_version version;
-	struct reset_control *rcdev;
+	struct reset_control *rcdev_rescal;
+	struct reset_control *rcdev_ahci;
 };
 
 static inline u32 brcm_sata_readreg(void __iomem *addr)
@@ -352,8 +353,8 @@ static int brcm_ahci_suspend(struct device *dev)
 	else
 		ret = 0;
 
-	if (priv->version != BRCM_SATA_BCM7216)
-		reset_control_assert(priv->rcdev);
+	reset_control_assert(priv->rcdev_ahci);
+	reset_control_rearm(priv->rcdev_rescal);
 
 	return ret;
 }
@@ -365,10 +366,10 @@ static int __maybe_unused brcm_ahci_resume(struct device *dev)
 	struct brcm_ahci_priv *priv = hpriv->plat_data;
 	int ret = 0;
 
-	if (priv->version == BRCM_SATA_BCM7216)
-		ret = reset_control_reset(priv->rcdev);
-	else
-		ret = reset_control_deassert(priv->rcdev);
+	ret = reset_control_deassert(priv->rcdev_ahci);
+	if (ret)
+		return ret;
+	ret = reset_control_reset(priv->rcdev_rescal);
 	if (ret)
 		return ret;
 
@@ -428,7 +429,6 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
-	const char *reset_name = NULL;
 	struct brcm_ahci_priv *priv;
 	struct ahci_host_priv *hpriv;
 	struct resource *res;
@@ -450,15 +450,15 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->top_ctrl))
 		return PTR_ERR(priv->top_ctrl);
 
-	/* Reset is optional depending on platform and named differently */
-	if (priv->version == BRCM_SATA_BCM7216)
-		reset_name = "rescal";
-	else
-		reset_name = "ahci";
-
-	priv->rcdev = devm_reset_control_get_optional(&pdev->dev, reset_name);
-	if (IS_ERR(priv->rcdev))
-		return PTR_ERR(priv->rcdev);
+	if (priv->version == BRCM_SATA_BCM7216) {
+		priv->rcdev_rescal = devm_reset_control_get_optional_shared(
+			&pdev->dev, "rescal");
+		if (IS_ERR(priv->rcdev_rescal))
+			return PTR_ERR(priv->rcdev_rescal);
+	}
+	priv->rcdev_ahci = devm_reset_control_get_optional(&pdev->dev, "ahci");
+	if (IS_ERR(priv->rcdev_ahci))
+		return PTR_ERR(priv->rcdev_ahci);
 
 	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
@@ -479,10 +479,10 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 		break;
 	}
 
-	if (priv->version == BRCM_SATA_BCM7216)
-		ret = reset_control_reset(priv->rcdev);
-	else
-		ret = reset_control_deassert(priv->rcdev);
+	ret = reset_control_reset(priv->rcdev_rescal);
+	if (ret)
+		return ret;
+	ret = reset_control_deassert(priv->rcdev_ahci);
 	if (ret)
 		return ret;
 
@@ -527,8 +527,8 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 out_disable_clks:
 	ahci_platform_disable_clks(hpriv);
 out_reset:
-	if (priv->version != BRCM_SATA_BCM7216)
-		reset_control_assert(priv->rcdev);
+	reset_control_assert(priv->rcdev_ahci);
+	reset_control_rearm(priv->rcdev_rescal);
 	return ret;
 }
 
-- 
2.17.1

