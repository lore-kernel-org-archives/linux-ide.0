Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C265EC4338F
	for <linux-ide@archiver.kernel.org>; Wed, 28 Jul 2021 09:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1CE860FD8
	for <linux-ide@archiver.kernel.org>; Wed, 28 Jul 2021 09:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhG1JEy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 28 Jul 2021 05:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhG1JEw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 28 Jul 2021 05:04:52 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C985C061757
        for <linux-ide@vger.kernel.org>; Wed, 28 Jul 2021 02:04:51 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id n6so2199643ljp.9
        for <linux-ide@vger.kernel.org>; Wed, 28 Jul 2021 02:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7vdzNXLqYZPUR6XlVx3IPF9M92+EsTbEdv1FLBfrvOA=;
        b=XLl5meNcSaM+ZxAPe1wxRp/WF4sVs0oW83YzcQhRAJ+vXoGkVMoTcZCFZK5VLP7Ok2
         CLXy1by0lTIcHypbywViJ/z9NASPk8UEGiMCmYg4L+vGvZwZ4a6GGDpw0aD3yzBWt59A
         UrBcw5mrgtVxyFiVXVh6ZHvycWi4hP0+ejkoi3+yP1mGRp0t5v/yAxOpXZj1ESroLjjH
         2q8C+NmxetuIjeutxsdP/Dbvi+yMoV8FR+jdeg7TgD2MUgW96WdzH7gPjaWGZEirI2pJ
         p2Xfm6g42wPZDpP/I0fcfeYVVyngp5gdqZg2gEgilX/kV1fl8UkMnpByaZ5iwd9dfl7U
         BviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7vdzNXLqYZPUR6XlVx3IPF9M92+EsTbEdv1FLBfrvOA=;
        b=X0RmOjZ/rkfDBElv0fDcEHPxyDmFP+gFTEV1mTP/Wox46ock6b++R6QnYJ/L8kq8ye
         ErC5E+YBuEtreJHuAJY0mdrT+CGwGPjqxI09x/OJ8OPUSrV/AV7+n+oXJ/5evb55Cxrm
         ZqIe6fncKPesIAF6skbqKtGFn4xHwOl4fPwtkByzAwWW3rq19l1xhKC7Ji/3bfbS6rgh
         N93q+rwM6SY3+XGYeP0k9a3pdO8opPZh6BRDCJKHVc0gBNeNVOD36Q6oVqPucUkAOZH/
         +ZAsBv3a7ry3vjcgoztolskGd+XDS/ps+uloMbp4qcOzlKNHoLOtgCFYhXF7QXKs7hg9
         Ekgg==
X-Gm-Message-State: AOAM5310d//x7zTK+b7gsax6CVx0lMqDLZUfDO+vC/xiKAVOD3K9GzM9
        hDFbIQo2QBx7aamZf6UiyBhP7w==
X-Google-Smtp-Source: ABdhPJxWNMVmRmOTd71Kq+cTNbY1yAhQlyD7OpoeVzYtkQyRuveUPmY1C5/hPm36NO/5ipnsBclO2Q==
X-Received: by 2002:a05:651c:242:: with SMTP id x2mr17930701ljn.231.1627463089531;
        Wed, 28 Jul 2021 02:04:49 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id d9sm505495ljq.54.2021.07.28.02.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 02:04:49 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/5] pata: ixp4xx: Use local dev variable
Date:   Wed, 28 Jul 2021 11:02:38 +0200
Message-Id: <20210728090242.2758812-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210728090242.2758812-1-linus.walleij@linaro.org>
References: <20210728090242.2758812-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Let's simplify all &pdev->dev references by creating a
local struct device *dev variable.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
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

