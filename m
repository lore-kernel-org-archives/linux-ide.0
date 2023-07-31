Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2537C001DC
	for <linux-ide@archiver.kernel.org>; Mon, 31 Jul 2023 09:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjGaJQy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 31 Jul 2023 05:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjGaJQt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 31 Jul 2023 05:16:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E78127
        for <linux-ide@vger.kernel.org>; Mon, 31 Jul 2023 02:16:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP1C-0000CH-64; Mon, 31 Jul 2023 11:16:46 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP1B-0005lC-Gz; Mon, 31 Jul 2023 11:16:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP1A-009GVh-34; Mon, 31 Jul 2023 11:16:44 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 08/12] ata/sata_dwc_460ex: Convert to platform remove callback returning void
Date:   Mon, 31 Jul 2023 11:16:32 +0200
Message-Id: <20230731091636.693193-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731091636.693193-1-u.kleine-koenig@pengutronix.de>
References: <20230731091636.693193-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1805; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=3ZOxtfMDX9p6lg8iNSG8mCBmBipw/6wbtZ/uN6BmuW0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkx3uGzAt+YBbc19b0tySW4agFVMW7HvIQ0x1Ud BdOdboHuQaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZMd7hgAKCRCPgPtYfRL+ TguHCACcvPVGhIB5/Qm+mYDSStxBnaVShBEb68FqPyrtvYAsbf6NNcW5VJ67beicyWhFQ1/c318 1UrXS4BjClV2XtCf+iYGjFVQQQb+3dtEST9i1ALGCdfQ/GvfgONWv5hC0JYVlxxPgUH0cA21W6B t60tgLv2nhf4XD5Esx08KFo322ASoVlOw2grn4B0jtwclkDls8z2FWvBaS8nNq3Tdz7o9SNELyn 6QxW8hl14Xus362N1UbXMHZB6Mev4Fij9woJdHZsBNkCv9a/MvHPjC3v2HPvGZHkha0VhGRhGPy OvIu/lQVRaQ+DLAF5ZkRnxtvdWHfmB1LPbEo/XEaQexLXnG/
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
 drivers/ata/sata_dwc_460ex.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index fabdd1e380f9..20ac56da6b47 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1211,7 +1211,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	return err;
 }
 
-static int sata_dwc_remove(struct platform_device *ofdev)
+static void sata_dwc_remove(struct platform_device *ofdev)
 {
 	struct device *dev = &ofdev->dev;
 	struct ata_host *host = dev_get_drvdata(dev);
@@ -1227,7 +1227,6 @@ static int sata_dwc_remove(struct platform_device *ofdev)
 #endif
 
 	dev_dbg(dev, "done\n");
-	return 0;
 }
 
 static const struct of_device_id sata_dwc_match[] = {
@@ -1242,7 +1241,7 @@ static struct platform_driver sata_dwc_driver = {
 		.of_match_table = sata_dwc_match,
 	},
 	.probe = sata_dwc_probe,
-	.remove = sata_dwc_remove,
+	.remove_new = sata_dwc_remove,
 };
 
 module_platform_driver(sata_dwc_driver);
-- 
2.39.2

