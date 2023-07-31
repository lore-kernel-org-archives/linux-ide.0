Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CBFC001E0
	for <linux-ide@archiver.kernel.org>; Mon, 31 Jul 2023 09:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjGaJRA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 31 Jul 2023 05:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjGaJQu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 31 Jul 2023 05:16:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CCA10B
        for <linux-ide@vger.kernel.org>; Mon, 31 Jul 2023 02:16:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP1B-0000A9-4C; Mon, 31 Jul 2023 11:16:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP1A-0005kg-1b; Mon, 31 Jul 2023 11:16:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP18-009GVM-R9; Mon, 31 Jul 2023 11:16:42 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 02/12] ata/pata_ep93xx: Convert to platform remove callback returning void
Date:   Mon, 31 Jul 2023 11:16:26 +0200
Message-Id: <20230731091636.693193-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731091636.693193-1-u.kleine-koenig@pengutronix.de>
References: <20230731091636.693193-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1931; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=0Yewu0bYPIFzw9QueRvudP4lc1nDjVyKgEPp8BzYCZ4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkx3t/G/fs6LaGeBUc2sxdRkYC7ng/tT6tVPS4J uNrxIy8gWqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZMd7fwAKCRCPgPtYfRL+ TmxjB/0U6wYr6rSBQtCSCHUYbUR8urdkNtmMb3q8uTHStDZtpqiQfwILrMDEfTBwrlGSVO2IQCf ox4tX9wOoJC4eO/tgUOzb/Y5k39frCre2dmm1AWXXnYSR+Y0KU9MF2nOarvIEL/8yv05Jhrj0HU u+kguug/7XY672BwlT+ou8hPloYaq4WnUtE3V8S2zX6xcsdH6JOiivAPxFkuaaiMP+20XqQbKTR pPF/fsAsCMmOvW+HLhHy37wb5Pi+6N2HC55c6UhWeVQ/q2uU79qR/vzQLDTuXHSrS+gw1BeiJIf L4/FwAfZOuTy6m+0sw9cigwKFGu3uTjS4NofPfpnzW8HnS+Z
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
 drivers/ata/pata_ep93xx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index c6e043e05d43..744ad5e8cfbf 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -1004,7 +1004,7 @@ static int ep93xx_pata_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int ep93xx_pata_remove(struct platform_device *pdev)
+static void ep93xx_pata_remove(struct platform_device *pdev)
 {
 	struct ata_host *host = platform_get_drvdata(pdev);
 	struct ep93xx_pata_data *drv_data = host->private_data;
@@ -1013,7 +1013,6 @@ static int ep93xx_pata_remove(struct platform_device *pdev)
 	ep93xx_pata_release_dma(drv_data);
 	ep93xx_pata_clear_regs(drv_data->ide_base);
 	ep93xx_ide_release_gpio(pdev);
-	return 0;
 }
 
 static struct platform_driver ep93xx_pata_platform_driver = {
@@ -1021,7 +1020,7 @@ static struct platform_driver ep93xx_pata_platform_driver = {
 		.name = DRV_NAME,
 	},
 	.probe = ep93xx_pata_probe,
-	.remove = ep93xx_pata_remove,
+	.remove_new = ep93xx_pata_remove,
 };
 
 module_platform_driver(ep93xx_pata_platform_driver);
-- 
2.39.2

