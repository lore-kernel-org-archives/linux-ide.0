Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B660C41513
	for <linux-ide@archiver.kernel.org>; Mon, 31 Jul 2023 09:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjGaJSK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 31 Jul 2023 05:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjGaJRx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 31 Jul 2023 05:17:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34A61B1
        for <linux-ide@vger.kernel.org>; Mon, 31 Jul 2023 02:16:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP1B-0000AT-CN; Mon, 31 Jul 2023 11:16:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP1A-0005kr-MP; Mon, 31 Jul 2023 11:16:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP19-009GVS-8D; Mon, 31 Jul 2023 11:16:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Damien Le Moal <dlemoal@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/12] ata/pata_imx: Convert to platform remove callback returning void
Date:   Mon, 31 Jul 2023 11:16:28 +0200
Message-Id: <20230731091636.693193-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731091636.693193-1-u.kleine-koenig@pengutronix.de>
References: <20230731091636.693193-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1850; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=TzSO0fMybiSEn7JEaqKjriPwaeueKVBqTMqPBslTagw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkx3uBLWGIgVtXJ2/6B8y2Bud4LE27nFH7OBFxY Wa3rtWJHcmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZMd7gQAKCRCPgPtYfRL+ TvByB/sHHxba+fbsy+YMggfBMqlzcaYo4CzxbHzkfAn6h1xkWH/iLpC3GtVW2/HuZd4dWPbb33A 2v7aOoV7rRPtexzJ4YPe1g+725C1Akx2nF+BhPkvGVEB5tS8J5GPrT8rbQYjPqCnKe51QRi4yXN CSkQPxAEOWwVZgC6IGMlZYDbOGPge4VN57RU9UXxYIkyYfIjzzSR7YfRwr9XrbEoJb1QTd/1B1m sr1D8ZsKYmOItAW+GFLxxQjc4v8dBGnYZ2GQR7TCJ6TF125rnlaT5MWkmYjz0IyeamBUsM314HJ psGLI6ejrgkD0+rJtPPd7Hc3OYuVRO5HwyGgYSReoDeM23c/
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.
To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new() which already returns void. Eventually after all drivers
are converted, .remove_new() is renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/ata/pata_imx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
index 4013f28679a9..6c62b1feade5 100644
--- a/drivers/ata/pata_imx.c
+++ b/drivers/ata/pata_imx.c
@@ -204,7 +204,7 @@ static int pata_imx_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int pata_imx_remove(struct platform_device *pdev)
+static void pata_imx_remove(struct platform_device *pdev)
 {
 	struct ata_host *host = platform_get_drvdata(pdev);
 	struct pata_imx_priv *priv = host->private_data;
@@ -214,8 +214,6 @@ static int pata_imx_remove(struct platform_device *pdev)
 	__raw_writel(0, priv->host_regs + PATA_IMX_ATA_INT_EN);
 
 	clk_disable_unprepare(priv->clk);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -266,7 +264,7 @@ MODULE_DEVICE_TABLE(of, imx_pata_dt_ids);
 
 static struct platform_driver pata_imx_driver = {
 	.probe		= pata_imx_probe,
-	.remove		= pata_imx_remove,
+	.remove_new	= pata_imx_remove,
 	.driver = {
 		.name		= DRV_NAME,
 		.of_match_table	= imx_pata_dt_ids,
-- 
2.39.2

