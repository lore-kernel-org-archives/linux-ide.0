Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F44EC001E0
	for <linux-ide@archiver.kernel.org>; Mon, 31 Jul 2023 09:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjGaJRF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 31 Jul 2023 05:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjGaJQw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 31 Jul 2023 05:16:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C31B12D
        for <linux-ide@vger.kernel.org>; Mon, 31 Jul 2023 02:16:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP1B-0000AU-E9; Mon, 31 Jul 2023 11:16:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP1A-0005ks-N6; Mon, 31 Jul 2023 11:16:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP19-009GVV-En; Mon, 31 Jul 2023 11:16:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 05/12] ata/pata_mpc52xx: Convert to platform remove callback returning void
Date:   Mon, 31 Jul 2023 11:16:29 +0200
Message-Id: <20230731091636.693193-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731091636.693193-1-u.kleine-koenig@pengutronix.de>
References: <20230731091636.693193-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1831; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ZS00hlSzA6zz37u9JSzRQ8YnvQYXqAHhtuZan7ml6g4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkx3uCZaqOmN/TyXSfEshUxJJ7sZpxgbDIwvMlo XYkHI6HRPCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZMd7ggAKCRCPgPtYfRL+ TnL4CAC1xUnLsHz6cg9R+Fsfw42A7tl6C+/1HpZjfn8X7DJX0Ry45SgkRx04TX3kNOvWYhZWSQZ 8kcEafbfGD+d192rhER8GFx1wdg9+XbMf/pBepg3BrRrstxicPMJSw5WUR9mN88VW3uxISC5NfT v/WWdj8CMYCA9Sy5Yzir0Jd2QXspnxCslmQgiw/K40tToYnYuAgLGlRZ4qm95jbH5zT+oIEdGdP 21mnN2UQUsw/UbhP+AQRlKg+usBzqP/Mrnt7DRVZuexTO4w7K0yW8yOnxe3o66yXCsKQPRJRUIo OjK86koA8YH1XanNjJeICP+JJFngNh0e9SVz0YXibjhdoCtE
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
 drivers/ata/pata_mpc52xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 66c9dea4ea6e..bca7f552e2b5 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -800,7 +800,7 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 	return rv;
 }
 
-static int
+static void
 mpc52xx_ata_remove(struct platform_device *op)
 {
 	struct ata_host *host = platform_get_drvdata(op);
@@ -815,8 +815,6 @@ mpc52xx_ata_remove(struct platform_device *op)
 	irq_dispose_mapping(task_irq);
 	bcom_ata_release(priv->dmatsk);
 	irq_dispose_mapping(priv->ata_irq);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -857,7 +855,7 @@ static const struct of_device_id mpc52xx_ata_of_match[] = {
 
 static struct platform_driver mpc52xx_ata_of_platform_driver = {
 	.probe		= mpc52xx_ata_probe,
-	.remove		= mpc52xx_ata_remove,
+	.remove_new	= mpc52xx_ata_remove,
 #ifdef CONFIG_PM_SLEEP
 	.suspend	= mpc52xx_ata_suspend,
 	.resume		= mpc52xx_ata_resume,
-- 
2.39.2

