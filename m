Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4FAC001DC
	for <linux-ide@archiver.kernel.org>; Mon, 31 Jul 2023 09:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjGaJQt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 31 Jul 2023 05:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjGaJQs (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 31 Jul 2023 05:16:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F7C126
        for <linux-ide@vger.kernel.org>; Mon, 31 Jul 2023 02:16:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP1B-0000C3-Ux; Mon, 31 Jul 2023 11:16:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP1B-0005l4-AK; Mon, 31 Jul 2023 11:16:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP1A-009GVl-9J; Mon, 31 Jul 2023 11:16:44 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 09/12] ata/sata_fsl: Convert to platform remove callback returning void
Date:   Mon, 31 Jul 2023 11:16:33 +0200
Message-Id: <20230731091636.693193-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731091636.693193-1-u.kleine-koenig@pengutronix.de>
References: <20230731091636.693193-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1874; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=108KFMwRcujgeu+c9h5PdNygcoOpYEEklqzb8TjHamA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkx3uHqy/LJVY5n9YJtaHDjrfrG0Lm6koLGRZj9 tyq6sTJ4DGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZMd7hwAKCRCPgPtYfRL+ TrbCB/48Z4JpUPfmNVIA6x30BQ7UGohYPb5y07LVNw/JoxYaMleFCr65cKt8VPt7L+fr4wA+L/H +fQSUUenpzEmwQNhDIdwDCMkz/sbcadNqY9EXBHF2soErK/E/5oO07F+e71bQxqNuX33DLP/vM1 aI18Keh3S4l1iqXSc8JP0ccUWUaNlOuo95FClbjslO/veAcJNPmydFJom4FAJ6CKd2xFYmu0AMh 6ufx/Tgs0POaXnD/W3NlbLtmq0MnywWzhE4+1au0sD4f4ukG/SCxUUqm8xGD2BXTdpCPL0ehg0+ yINnFFq33MjaES3ke9RlpOMqyEnnzpx1rp+0P9zxnH2tdYBN
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
 drivers/ata/sata_fsl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index ccd99b9aa9ff..744b91fb0022 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1526,7 +1526,7 @@ static int sata_fsl_probe(struct platform_device *ofdev)
 	return retval;
 }
 
-static int sata_fsl_remove(struct platform_device *ofdev)
+static void sata_fsl_remove(struct platform_device *ofdev)
 {
 	struct ata_host *host = platform_get_drvdata(ofdev);
 	struct sata_fsl_host_priv *host_priv = host->private_data;
@@ -1535,8 +1535,6 @@ static int sata_fsl_remove(struct platform_device *ofdev)
 	device_remove_file(&ofdev->dev, &host_priv->rx_watermark);
 
 	ata_host_detach(host);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1591,7 +1589,7 @@ static struct platform_driver fsl_sata_driver = {
 		.of_match_table = fsl_sata_match,
 	},
 	.probe		= sata_fsl_probe,
-	.remove		= sata_fsl_remove,
+	.remove_new	= sata_fsl_remove,
 #ifdef CONFIG_PM_SLEEP
 	.suspend	= sata_fsl_suspend,
 	.resume		= sata_fsl_resume,
-- 
2.39.2

