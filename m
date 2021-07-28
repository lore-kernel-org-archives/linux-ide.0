Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB98C4338F
	for <linux-ide@archiver.kernel.org>; Wed, 28 Jul 2021 09:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 123EA60FD8
	for <linux-ide@archiver.kernel.org>; Wed, 28 Jul 2021 09:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhG1JE4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 28 Jul 2021 05:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhG1JEz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 28 Jul 2021 05:04:55 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA21C061757
        for <linux-ide@vger.kernel.org>; Wed, 28 Jul 2021 02:04:53 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bp1so2631305lfb.3
        for <linux-ide@vger.kernel.org>; Wed, 28 Jul 2021 02:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o6oanoNU+TgtBqwksYdKRCzEmGnOQXmO6urUjLig0JM=;
        b=JfoFegnQYxIcmXU20lpx+XX5Fmnzv9Bp5cc9/89Hs6i9EOcE7rqoDzXEYSnu0oEAt4
         Zk1cZUi7v9YUKPsmJNgERZSdesX40hjB3Y66uANteGDRkKriUhDwlL/o//E31/UHgaUZ
         ouZ8hIj5aJFAxgEgDs70qfjbYYKRLdS9g+2mxe721DgoGyrt4nn6ha0PGaiz9bYnqY4a
         wt9Gvs2r5SFH0pqVWhsey79CN1TJYfhnbDd048cb5Q8etADD1VhgfMac/D6KXUo7CUHh
         yw786M2vh2Un3bGdaUAkimvDWkItm2cNaK0M6NrdzTh3TTmJlQPofxZwKwcdueNewiQx
         woEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o6oanoNU+TgtBqwksYdKRCzEmGnOQXmO6urUjLig0JM=;
        b=udZ7aZY9/nCggYwLbZfR7cq/RfGH1ef3p0oVX7v/SxR2mK4fRth8zymIKtY2SvUSvO
         x5oNI20DeDUR19I3vpDlRb+pJsDlhMdBnO301zoV94kfcxNnBSGmkAwBLWwgqGhaBWsX
         P3iCBcOAXsbeRbkcdInm50dSrItue2oRJbeBmEokV+HRFBkm5wDBVYP19lCycSJrLRlK
         XXsOq+sCsh7q767I6MCn/vNc0z7xvbdEQk3hIcK0ggJCXWHyuUED5Y445pVHc3cl9CdK
         yW9C2Qc92/+futEA/GcjFg+AiBnO+FpDG3IhjcCdZO6Lbmklw59iaFS4A3cXmR/fEvCL
         aLWw==
X-Gm-Message-State: AOAM530Sv1szUjjceYphVvUuMjSWoj9YM2WWLrKmJ0dQGRsxnO5tlhil
        vAaYeZL1PWxwtN3GjVvB56be8w==
X-Google-Smtp-Source: ABdhPJyXegSWd2i+Ex8RhwW/D2Sg4c+oV2dJeTqZSqHaERAsH/LGtTJk2ZqQNMg1RmX5x+4olvmtVA==
X-Received: by 2002:a05:6512:3697:: with SMTP id d23mr20401932lfs.552.1627463092161;
        Wed, 28 Jul 2021 02:04:52 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id d9sm505495ljq.54.2021.07.28.02.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 02:04:51 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/5] pata: ixp4xx: Refer to cmd and ctl rather than csN
Date:   Wed, 28 Jul 2021 11:02:40 +0200
Message-Id: <20210728090242.2758812-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210728090242.2758812-1-linus.walleij@linaro.org>
References: <20210728090242.2758812-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The two "cs0" and "cs1" are "chip selects" but on some
platforms such as GW2358 they are actually both in CS3
making this terminology very confusing. Call the
addresses "cmd" and "ctl" after function instead.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/ata/pata_ixp4xx_cf.c                 | 27 ++++++++++----------
 include/linux/platform_data/pata_ixp4xx_cf.h |  4 +--
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index bc5029d6525d..72d6d6f2ef99 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -95,15 +95,14 @@ static struct ata_port_operations ixp4xx_port_ops = {
 
 static void ixp4xx_setup_port(struct ata_port *ap,
 			      struct ixp4xx_pata_data *data,
-			      unsigned long raw_cs0, unsigned long raw_cs1)
+			      unsigned long raw_cmd, unsigned long raw_ctl)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
-	unsigned long raw_cmd = raw_cs0;
-	unsigned long raw_ctl = raw_cs1 + 0x06;
 
-	ioaddr->cmd_addr	= data->cs0;
-	ioaddr->altstatus_addr	= data->cs1 + 0x06;
-	ioaddr->ctl_addr	= data->cs1 + 0x06;
+	raw_ctl += 0x06;
+	ioaddr->cmd_addr	= data->cmd;
+	ioaddr->altstatus_addr	= data->ctl + 0x06;
+	ioaddr->ctl_addr	= data->ctl + 0x06;
 
 	ata_sff_std_ports(ioaddr);
 
@@ -135,7 +134,7 @@ static void ixp4xx_setup_port(struct ata_port *ap,
 
 static int ixp4xx_pata_probe(struct platform_device *pdev)
 {
-	struct resource *cs0, *cs1;
+	struct resource *cmd, *ctl;
 	struct ata_host *host;
 	struct ata_port *ap;
 	struct device *dev = &pdev->dev;
@@ -143,10 +142,10 @@ static int ixp4xx_pata_probe(struct platform_device *pdev)
 	int ret;
 	int irq;
 
-	cs0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	cs1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	cmd = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ctl = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 
-	if (!cs0 || !cs1)
+	if (!cmd || !ctl)
 		return -EINVAL;
 
 	/* allocate host */
@@ -159,10 +158,10 @@ static int ixp4xx_pata_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	data->cs0 = devm_ioremap(dev, cs0->start, 0x1000);
-	data->cs1 = devm_ioremap(dev, cs1->start, 0x1000);
+	data->cmd = devm_ioremap(dev, cmd->start, 0x1000);
+	data->ctl = devm_ioremap(dev, ctl->start, 0x1000);
 
-	if (!data->cs0 || !data->cs1)
+	if (!data->cmd || !data->ctl)
 		return -ENOMEM;
 
 	irq = platform_get_irq(pdev, 0);
@@ -183,7 +182,7 @@ static int ixp4xx_pata_probe(struct platform_device *pdev)
 	ap->pio_mask = ATA_PIO4;
 	ap->flags |= ATA_FLAG_NO_ATAPI;
 
-	ixp4xx_setup_port(ap, data, cs0->start, cs1->start);
+	ixp4xx_setup_port(ap, data, cmd->start, ctl->start);
 
 	ata_print_version_once(dev, DRV_VERSION);
 
diff --git a/include/linux/platform_data/pata_ixp4xx_cf.h b/include/linux/platform_data/pata_ixp4xx_cf.h
index 601ba97fef57..e60fa41da4a5 100644
--- a/include/linux/platform_data/pata_ixp4xx_cf.h
+++ b/include/linux/platform_data/pata_ixp4xx_cf.h
@@ -14,8 +14,8 @@ struct ixp4xx_pata_data {
 	volatile u32	*cs1_cfg;
 	unsigned long	cs0_bits;
 	unsigned long	cs1_bits;
-	void __iomem	*cs0;
-	void __iomem	*cs1;
+	void __iomem	*cmd;
+	void __iomem	*ctl;
 };
 
 #endif
-- 
2.31.1

