Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778ABC41535
	for <linux-ide@archiver.kernel.org>; Sun,  5 Nov 2023 15:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjKEPBC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 5 Nov 2023 10:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjKEPBB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 5 Nov 2023 10:01:01 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FE1D9
        for <linux-ide@vger.kernel.org>; Sun,  5 Nov 2023 07:00:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzecR-0002zw-JS; Sun, 05 Nov 2023 16:00:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzecR-006oUC-5z; Sun, 05 Nov 2023 16:00:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzecQ-00DBtB-Sz; Sun, 05 Nov 2023 16:00:54 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 3/4] ata: pata_falcon: Convert to platform remove callback returning void
Date:   Sun,  5 Nov 2023 16:00:38 +0100
Message-ID: <20231105150037.3724669-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.482.g2e8e77cbac8a.dirty
In-Reply-To: <20231105150037.3724669-6-u.kleine-koenig@pengutronix.de>
References: <20231105150037.3724669-6-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1627; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=qGZIXNcLkKmkcmvvNC0x2/sq25vo9lCGY3k8BLvrzjI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlR64ZV12PaVPndoMngLN0+XeVhWAD9JPL4Ue9W VcPsdn27FqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZUeuGQAKCRCPgPtYfRL+ Tj0dCACsQt624/O/bvUtMmilnKMqgmSOJ1eQ6LZfghgIi16V4WgBCoxr/M4+C5b7aFpcZvZ15i0 NZYSljDkhBw8bztrJ+uKQIoW8QMlSijueLlf4+I/Mf9aoKca0UW2UXOKauuGaYBGpJ0dsyPxC5i BCJLcITLNdIwSf6GxEu6cPGabcagXIrBNwl9ce55YqMn9E8k/csQkrVs74eNUxyL6ungcWV9Zv5 4eCWj6hLDwdm7lSYYKS/KAof0pg5sFDXnOztTC9bUG8BOmpNBs2UvicCWfsFKSvSMU1Tb8mtWPY AvnPYiqLltVOjdDRTJHiEkBv93JRpnbh0uw+niZeqUDqwUYJ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
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
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/ata/pata_falcon.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
index 9dfc2df47cf8..18ceefd176df 100644
--- a/drivers/ata/pata_falcon.c
+++ b/drivers/ata/pata_falcon.c
@@ -216,18 +216,16 @@ static int pata_falcon_init_one(struct platform_device *pdev)
 				 IRQF_SHARED, &pata_falcon_sht);
 }
 
-static int pata_falcon_remove_one(struct platform_device *pdev)
+static void pata_falcon_remove_one(struct platform_device *pdev)
 {
 	struct ata_host *host = platform_get_drvdata(pdev);
 
 	ata_host_detach(host);
-
-	return 0;
 }
 
 static struct platform_driver pata_falcon_driver = {
 	.probe = pata_falcon_init_one,
-	.remove = pata_falcon_remove_one,
+	.remove_new = pata_falcon_remove_one,
 	.driver   = {
 		.name	= "atari-falcon-ide",
 	},
-- 
2.42.0

