Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D74AC001DF
	for <linux-ide@archiver.kernel.org>; Mon, 31 Jul 2023 09:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjGaJRG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 31 Jul 2023 05:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjGaJQx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 31 Jul 2023 05:16:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0126123
        for <linux-ide@vger.kernel.org>; Mon, 31 Jul 2023 02:16:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP1C-0000CL-Bn; Mon, 31 Jul 2023 11:16:46 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP1B-0005lG-NO; Mon, 31 Jul 2023 11:16:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP1A-009GVo-Fh; Mon, 31 Jul 2023 11:16:44 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 10/12] ata/sata_gemini: Convert to platform remove callback returning void
Date:   Mon, 31 Jul 2023 11:16:34 +0200
Message-Id: <20230731091636.693193-11-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731091636.693193-1-u.kleine-koenig@pengutronix.de>
References: <20230731091636.693193-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1821; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=LqpaDW1WLOTsK730jj7ErLVlvRs2+wZ4omftvew40Ls=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkx3uI5yId3Lkis7o0rTTawOI/W8mKZ/Eh0gVBi jmJ0Mtie/WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZMd7iAAKCRCPgPtYfRL+ Tk00B/9DB02yJmSqebpIhnVvx0q1OagkONh4vfNmZl4w3Qds2Go0X9ziahQ0ssxq0yMIbt4ZuEc 5QnuzbhF+Wl3SAL6aTTLJ8+pTC5/ZcfHnoRqA9pejrZwxx5vWN9TLm02aqR2Xb9QEoQ17FYCaLt rOrSTgKeKxeFSCDhI1NpitefpeDyILbEl/sFwZWyGsbqA9b17+jiOt03M2aO/ehLpMQgWnMDUM7 VF0+BH8g4iJKEZXGTBFQxpnyxwjyDtjW/GLzZ1g8tyIVIBvjJb7cKEwnbB0Iz9w8fe0AxiA4mWT kl62kFFe7is53WWsK+QGlRPUfKPvzS61qKDTplAO391oaH9b
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
 drivers/ata/sata_gemini.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index c42cc9bbbc4e..94bbb9b69f50 100644
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -400,7 +400,7 @@ static int gemini_sata_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int gemini_sata_remove(struct platform_device *pdev)
+static void gemini_sata_remove(struct platform_device *pdev)
 {
 	struct sata_gemini *sg = platform_get_drvdata(pdev);
 
@@ -409,8 +409,6 @@ static int gemini_sata_remove(struct platform_device *pdev)
 		clk_unprepare(sg->sata0_pclk);
 	}
 	sg_singleton = NULL;
-
-	return 0;
 }
 
 static const struct of_device_id gemini_sata_of_match[] = {
@@ -424,7 +422,7 @@ static struct platform_driver gemini_sata_driver = {
 		.of_match_table = gemini_sata_of_match,
 	},
 	.probe = gemini_sata_probe,
-	.remove = gemini_sata_remove,
+	.remove_new = gemini_sata_remove,
 };
 module_platform_driver(gemini_sata_driver);
 
-- 
2.39.2

