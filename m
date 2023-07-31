Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8724C001E0
	for <linux-ide@archiver.kernel.org>; Mon, 31 Jul 2023 09:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjGaJQz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 31 Jul 2023 05:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbjGaJQu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 31 Jul 2023 05:16:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F0D11A
        for <linux-ide@vger.kernel.org>; Mon, 31 Jul 2023 02:16:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP1B-0000CF-W4; Mon, 31 Jul 2023 11:16:46 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP1B-0005l6-BR; Mon, 31 Jul 2023 11:16:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP19-009GVe-T2; Mon, 31 Jul 2023 11:16:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 07/12] ata/pata_rb532_cf: Convert to platform remove callback returning void
Date:   Mon, 31 Jul 2023 11:16:31 +0200
Message-Id: <20230731091636.693193-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731091636.693193-1-u.kleine-koenig@pengutronix.de>
References: <20230731091636.693193-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1614; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=z2UqSp5tRAXikZAh57VKvvgme/U/5Kex+AA0GT6+ioY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkx3uFNRnCp2tDT76wWDm/FnxUmGyPO8pVVlcWw wGJAKiVucaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZMd7hQAKCRCPgPtYfRL+ TufBB/0XmIlG78KcX0DeMPDf7uxI8jnP32VYTkA8XCqiqKgIaCvl1ALIY8yd+gvztnGoas4RMH7 prPZASfYS4W4IPHRUwlff2sTV5y5Zi53AW3SqWulUFYSFQOH4CngLcr832DDPDlreWYLWq5+tZ+ 3TYx/4PGLtLOCV7Yn/fTJ27/aaRFTWJwWBYgqyx+FshnjJGNezStGVIjGUR3twjM9TAnPLRSZIh 2UAOzQpX46wYQrRE4Ubuy7PHE13Qc8RPKjIeFHmixfvr0DdCBEIDU+rtAdwCC5uz/kTSa8v4j5i CSeCUBY7V8W9dd4dhtIMJfCRP1ChR+eKPrs0nDCI2+kDgrO4
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
 drivers/ata/pata_rb532_cf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index 3974d294a341..0fa253ad7c93 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -155,18 +155,16 @@ static int rb532_pata_driver_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int rb532_pata_driver_remove(struct platform_device *pdev)
+static void rb532_pata_driver_remove(struct platform_device *pdev)
 {
 	struct ata_host *ah = platform_get_drvdata(pdev);
 
 	ata_host_detach(ah);
-
-	return 0;
 }
 
 static struct platform_driver rb532_pata_platform_driver = {
 	.probe		= rb532_pata_driver_probe,
-	.remove		= rb532_pata_driver_remove,
+	.remove_new	= rb532_pata_driver_remove,
 	.driver	 = {
 		.name   = DRV_NAME,
 	},
-- 
2.39.2

