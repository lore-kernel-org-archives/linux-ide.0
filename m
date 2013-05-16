From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 01/33] drivers/ata: don't check resource with devm_ioremap_resource
Date: Thu, 16 May 2013 13:15:29 +0200
Message-ID: <1368702961-4325-2-git-send-email-wsa@the-dreams.de>
References: <1368702961-4325-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:56050 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752337Ab3EPLOg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 May 2013 07:14:36 -0400
In-Reply-To: <1368702961-4325-1-git-send-email-wsa@the-dreams.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

devm_ioremap_resource does sanity checks on the given resource. No need to
duplicate this in the driver.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/ata/pata_ep93xx.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index c1bfaf4..980b88e 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -933,11 +933,6 @@ static int ep93xx_pata_probe(struct platform_device *pdev)
 	}
 
 	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem_res) {
-		err = -ENXIO;
-		goto err_rel_gpio;
-	}
-
 	ide_base = devm_ioremap_resource(&pdev->dev, mem_res);
 	if (IS_ERR(ide_base)) {
 		err = PTR_ERR(ide_base);
-- 
1.7.10.4

