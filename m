From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 06/14] pata_ixp4xx_cf: utilize common ata_platform_remove_one()
Date: Fri,  2 Nov 2012 00:46:20 -0700
Message-ID: <1351842388-27210-7-git-send-email-computersforpeace@gmail.com>
References: <1351842388-27210-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36961 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755273Ab2KBHq6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2012 03:46:58 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2299681pad.19
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2012 00:46:57 -0700 (PDT)
In-Reply-To: <1351842388-27210-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, Tejun Heo <tj@kernel.org>

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/ata/pata_ixp4xx_cf.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index badb178..0566e67 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -187,22 +187,13 @@ static __devinit int ixp4xx_pata_probe(struct platform_device *pdev)
 	return ata_host_activate(host, irq, ata_sff_interrupt, 0, &ixp4xx_sht);
 }
 
-static __devexit int ixp4xx_pata_remove(struct platform_device *dev)
-{
-	struct ata_host *host = platform_get_drvdata(dev);
-
-	ata_host_detach(host);
-
-	return 0;
-}
-
 static struct platform_driver ixp4xx_pata_platform_driver = {
 	.driver	 = {
 		.name   = DRV_NAME,
 		.owner  = THIS_MODULE,
 	},
 	.probe		= ixp4xx_pata_probe,
-	.remove		= __devexit_p(ixp4xx_pata_remove),
+	.remove		= ata_platform_remove_one,
 };
 
 module_platform_driver(ixp4xx_pata_platform_driver);
-- 
1.7.11.3

