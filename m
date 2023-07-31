Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E48C001DC
	for <linux-ide@archiver.kernel.org>; Mon, 31 Jul 2023 09:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjGaJRk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 31 Jul 2023 05:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjGaJQx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 31 Jul 2023 05:16:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D8912A
        for <linux-ide@vger.kernel.org>; Mon, 31 Jul 2023 02:16:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP1C-0000CO-FT; Mon, 31 Jul 2023 11:16:46 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP1B-0005lH-OL; Mon, 31 Jul 2023 11:16:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP1A-009GVs-O9; Mon, 31 Jul 2023 11:16:44 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 11/12] ata/sata_mv: Convert to platform remove callback returning void
Date:   Mon, 31 Jul 2023 11:16:35 +0200
Message-Id: <20230731091636.693193-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731091636.693193-1-u.kleine-koenig@pengutronix.de>
References: <20230731091636.693193-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1965; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=oGTGzGe5MSm67rut1RPtNLoDXYZ/1rOQlKvc5tGNVpk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkx3uJ4Pgxz15u/LNqQL3q3dstJhD0rXFnNS4IG vfEbYLA3pmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZMd7iQAKCRCPgPtYfRL+ Tl7qCACPb0AkLL2obiK3FoKldmgY8J8SyRW9APyfGJlFoi8sQl/dtX9iUM0OROTmVTMn8/MDfUs REAdCWYuycK0LOsYZQGGKbQNDBISh1adixy4EFT7GJr94EeCGmg5pt7oHPcPZi40SV1thqJrunH MxR9xQWkDaUaPvGpmF8rGWh4hFQuG7zf+Fz4Bvk+bHGvCdWuh3BHuWg86F9+y+B4lxBDFBdM9Gh DIZr9ZzbFDleKopX5e+j+O4BL2aGLfQfk13F7kmNpMzQucxGOIsPoZ49mEQ9HdXcP8Q8AKRdbNJ mM8B8WIhCLDJFyG+kAFLsdtlb06genZj4llTA9QH+3i86rhH
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
 drivers/ata/sata_mv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index d404e631d152..c691b89a417b 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4210,7 +4210,7 @@ static int mv_platform_probe(struct platform_device *pdev)
  *      A platform bus SATA device has been unplugged. Perform the needed
  *      cleanup. Also called on module unload for any active devices.
  */
-static int mv_platform_remove(struct platform_device *pdev)
+static void mv_platform_remove(struct platform_device *pdev)
 {
 	struct ata_host *host = platform_get_drvdata(pdev);
 	struct mv_host_priv *hpriv = host->private_data;
@@ -4228,7 +4228,6 @@ static int mv_platform_remove(struct platform_device *pdev)
 		}
 		phy_power_off(hpriv->port_phys[port]);
 	}
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -4284,7 +4283,7 @@ MODULE_DEVICE_TABLE(of, mv_sata_dt_ids);
 
 static struct platform_driver mv_platform_driver = {
 	.probe		= mv_platform_probe,
-	.remove		= mv_platform_remove,
+	.remove_new	= mv_platform_remove,
 	.suspend	= mv_platform_suspend,
 	.resume		= mv_platform_resume,
 	.driver		= {
-- 
2.39.2

