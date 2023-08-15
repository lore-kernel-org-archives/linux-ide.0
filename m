Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88492C04A6A
	for <linux-ide@archiver.kernel.org>; Tue, 15 Aug 2023 15:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbjHOPOn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 15 Aug 2023 11:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237845AbjHOPOP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 15 Aug 2023 11:14:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BDC173C
        for <linux-ide@vger.kernel.org>; Tue, 15 Aug 2023 08:14:13 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQF7t5rgNztRrD;
        Tue, 15 Aug 2023 23:10:34 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 15 Aug
 2023 23:14:10 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <s.shtylyov@omp.ru>, <dlemoal@kernel.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>
CC:     <lizetao1@huawei.com>, <linux-ide@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH -next] ata: pata_imx: Use helper function devm_clk_get_enabled()
Date:   Tue, 15 Aug 2023 23:13:52 +0800
Message-ID: <20230815151352.1907861-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

After the commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for
prepared and enabled clocks"), it can replace the pair of functions,
devm_clk_get() and clk_prepare_enable() with a single helper function
devm_clk_get_enabled(). Moreover, the driver will keeps a clock prepared
(or enabled) during the whole lifetime of the driver, it is unnecessary to
unprepare or disable clock explicitly when remove driver or in the error
handling path.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/ata/pata_imx.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
index 91da7ecec0fc..d0aa8fc929b4 100644
--- a/drivers/ata/pata_imx.c
+++ b/drivers/ata/pata_imx.c
@@ -141,21 +141,15 @@ static int pata_imx_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->clk = devm_clk_get(&pdev->dev, NULL);
+	priv->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
-		dev_err(&pdev->dev, "Failed to get clock\n");
+		dev_err(&pdev->dev, "Failed to get and enable clock\n");
 		return PTR_ERR(priv->clk);
 	}
 
-	ret = clk_prepare_enable(priv->clk);
-	if (ret)
-		return ret;
-
 	host = ata_host_alloc(&pdev->dev, 1);
-	if (!host) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	if (!host)
+		return -ENOMEM;
 
 	host->private_data = priv;
 	ap = host->ports[0];
@@ -165,10 +159,8 @@ static int pata_imx_probe(struct platform_device *pdev)
 	ap->flags |= ATA_FLAG_SLAVE_POSS;
 
 	priv->host_regs = devm_platform_get_and_ioremap_resource(pdev, 0, &io_res);
-	if (IS_ERR(priv->host_regs)) {
-		ret = PTR_ERR(priv->host_regs);
-		goto err;
-	}
+	if (IS_ERR(priv->host_regs))
+		return PTR_ERR(priv->host_regs);
 
 	ap->ioaddr.cmd_addr = priv->host_regs + PATA_IMX_DRIVE_DATA;
 	ap->ioaddr.ctl_addr = priv->host_regs + PATA_IMX_DRIVE_CONTROL;
@@ -194,13 +186,9 @@ static int pata_imx_probe(struct platform_device *pdev)
 				&pata_imx_sht);
 
 	if (ret)
-		goto err;
+		return ret;
 
 	return 0;
-err:
-	clk_disable_unprepare(priv->clk);
-
-	return ret;
 }
 
 static void pata_imx_remove(struct platform_device *pdev)
@@ -211,8 +199,6 @@ static void pata_imx_remove(struct platform_device *pdev)
 	ata_host_detach(host);
 
 	__raw_writel(0, priv->host_regs + PATA_IMX_ATA_INT_EN);
-
-	clk_disable_unprepare(priv->clk);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.34.1

