Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D00C001DC
	for <linux-ide@archiver.kernel.org>; Mon, 31 Jul 2023 09:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjGaJRG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 31 Jul 2023 05:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjGaJQw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 31 Jul 2023 05:16:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B5812B
        for <linux-ide@vger.kernel.org>; Mon, 31 Jul 2023 02:16:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP1B-0000A8-4C; Mon, 31 Jul 2023 11:16:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP19-0005kb-PO; Mon, 31 Jul 2023 11:16:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP19-009GVP-1L; Mon, 31 Jul 2023 11:16:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 03/12] ata/pata_ftide010: Convert to platform remove callback returning void
Date:   Mon, 31 Jul 2023 11:16:27 +0200
Message-Id: <20230731091636.693193-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731091636.693193-1-u.kleine-koenig@pengutronix.de>
References: <20230731091636.693193-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1827; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=6d6GOuRtPKCjUshqSn6ku0LvJ/MQhWAafiYypMjnBcs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkx3uAFsoVRxuVvZOBAi+rFsQZKJD/jo2P+TRgQ rCo5ltybROJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZMd7gAAKCRCPgPtYfRL+ Tn4bB/9lY9NktjuPidNnFACcPkzLzkLE/SN6fartePcjXticO/8SZta7/G1UJdwrxjy1dkqpC03 80CvOUsXA8D6/85u4+I3awMl3IlDDADM7wgw/pC9D0VUV3V3b5bKisobKosCqrOntBs9sBfaWCw DFahJaRNM55BQ4+ghIFgSf7kYyS5rot6q/pkyOuxOMvUxzioPBezhVhZPztTr70Vp0Izm1N97jl o1xA1l/afzd1SaNnlJTU/8FVYRLYwvlmgQNVuN+Bmghz9doaO3OcC3CTfpWlk7qHYBgVQ9CYS/y jEp6sdDwq5YP35kxdmNukZ9Doen7tBoH4qSYCsO9Tfpwi0mK
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
 drivers/ata/pata_ftide010.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_ftide010.c b/drivers/ata/pata_ftide010.c
index 6f6734c09b11..27509ee100c7 100644
--- a/drivers/ata/pata_ftide010.c
+++ b/drivers/ata/pata_ftide010.c
@@ -541,15 +541,13 @@ static int pata_ftide010_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int pata_ftide010_remove(struct platform_device *pdev)
+static void pata_ftide010_remove(struct platform_device *pdev)
 {
 	struct ata_host *host = platform_get_drvdata(pdev);
 	struct ftide010 *ftide = host->private_data;
 
 	ata_host_detach(ftide->host);
 	clk_disable_unprepare(ftide->pclk);
-
-	return 0;
 }
 
 static const struct of_device_id pata_ftide010_of_match[] = {
@@ -563,7 +561,7 @@ static struct platform_driver pata_ftide010_driver = {
 		.of_match_table = pata_ftide010_of_match,
 	},
 	.probe = pata_ftide010_probe,
-	.remove = pata_ftide010_remove,
+	.remove_new = pata_ftide010_remove,
 };
 module_platform_driver(pata_ftide010_driver);
 
-- 
2.39.2

