Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776C1C4338F
	for <linux-ide@archiver.kernel.org>; Sat, 31 Jul 2021 21:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5709E60F36
	for <linux-ide@archiver.kernel.org>; Sat, 31 Jul 2021 21:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhGaViJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 31 Jul 2021 17:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhGaViI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 31 Jul 2021 17:38:08 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D557EC06175F
        for <linux-ide@vger.kernel.org>; Sat, 31 Jul 2021 14:38:01 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id f12so18302564ljn.1
        for <linux-ide@vger.kernel.org>; Sat, 31 Jul 2021 14:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W7qUFzW5XAPgMODU+xc+DKpwo9r3q77YftplfblNgVI=;
        b=mJCeppVmqjSBrvbTKMa2nnzoFAO1JLl8f0wUQlFYVG938UEEWVXNI77QIr5Kq/VTxE
         MN3DSwwHgXtZ+YtSb07xCtD4D1T/jw0uZSzTzcow8tqEe5HD55idiuKr0Gj5DVQJxoxI
         /68jDI+JQt3e7Dw4iVQlHIEnRkhioRSbdykQV6UZ6yScBhjlH6s7Ij4oBCCj27fCoox/
         1YzXf8V6SZWLV/I4yaPCSoETup9les5HBDuWHFqKtumK26v61uKr/4/8yWYl/Htv/q4f
         b/BXsKhyfjzqGWNTL+LSUcPUhJMuNUfpwDvZtabe1Lwkp5gzUHUQ8Y14JovSNVfqh87n
         oA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W7qUFzW5XAPgMODU+xc+DKpwo9r3q77YftplfblNgVI=;
        b=Skne0NzrAltwiF2PwI+RMe3KfnkwC405/iojMPp0HBRFjDCGPAjohhtWWBoCy5KBfB
         ygkM2GbiyHkvxfRcVT4OTc8S1p4Fjxc/Omv07qOA68oamZ1CC+bmJqE5AlYWXJWMN8xj
         UlMQ8so6tEiR4smG8ns97wWmDD7Cr1yF4+GpKQ9ORPsxt43yju04OrG6JuVyZszKmJs5
         eZtTQVA8xrrwQ/mdI9ddKL2G23u68mWaNsp4JoU3jQs8qq37OW0HZRGVHJxjPk2gN8bz
         xH1dzCNRFF/8Ln2XxLJwehyIOCcLXhaCdKr2H6RTktL6qv4qIFovV/Ek7uwHXG5BDmln
         0ByQ==
X-Gm-Message-State: AOAM5330VYTWhU/oClUSUXoXDK5rafDV+u82TVN1FeKrbQevrfEI4OZp
        dquTbpivy1IGzGz8tpTop3ehqQ==
X-Google-Smtp-Source: ABdhPJyS4HS3DvVj5QrSFzJeYphjyLAko6m0p9h+LTFak+WRFXEe4fMouq8OyYtOEaMZtD+zLWd8IQ==
X-Received: by 2002:a2e:2286:: with SMTP id i128mr6184963lji.260.1627767480260;
        Sat, 31 Jul 2021 14:38:00 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id t17sm440430ljk.102.2021.07.31.14.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 14:37:59 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/5 v2] pata: ixp4xx: Use local dev variable
Date:   Sat, 31 Jul 2021 23:35:51 +0200
Message-Id: <20210731213555.2965356-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Let's simplify all &pdev->dev references by creating a
local struct device *dev variable.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- No changes
---
 drivers/ata/pata_ixp4xx_cf.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index 5881d64af943..23f0f7cacd52 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -139,6 +139,7 @@ static int ixp4xx_pata_probe(struct platform_device *pdev)
 	struct resource *cs0, *cs1;
 	struct ata_host *host;
 	struct ata_port *ap;
+	struct device *dev = &pdev->dev;
 	struct ixp4xx_pata_data *data = dev_get_platdata(&pdev->dev);
 	int ret;
 	int irq;
@@ -150,17 +151,17 @@ static int ixp4xx_pata_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	/* allocate host */
-	host = ata_host_alloc(&pdev->dev, 1);
+	host = ata_host_alloc(dev, 1);
 	if (!host)
 		return -ENOMEM;
 
 	/* acquire resources and fill host */
-	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
+	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
 	if (ret)
 		return ret;
 
-	data->cs0 = devm_ioremap(&pdev->dev, cs0->start, 0x1000);
-	data->cs1 = devm_ioremap(&pdev->dev, cs1->start, 0x1000);
+	data->cs0 = devm_ioremap(dev, cs0->start, 0x1000);
+	data->cs1 = devm_ioremap(dev, cs1->start, 0x1000);
 
 	if (!data->cs0 || !data->cs1)
 		return -ENOMEM;
@@ -185,7 +186,7 @@ static int ixp4xx_pata_probe(struct platform_device *pdev)
 
 	ixp4xx_setup_port(ap, data, cs0->start, cs1->start);
 
-	ata_print_version_once(&pdev->dev, DRV_VERSION);
+	ata_print_version_once(dev, DRV_VERSION);
 
 	/* activate host */
 	return ata_host_activate(host, irq, ata_sff_interrupt, 0, &ixp4xx_sht);
-- 
2.31.1

