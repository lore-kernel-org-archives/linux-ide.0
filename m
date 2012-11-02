From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 08/14] pata_of_platform: utilize common ata_platform_remove_one()
Date: Fri,  2 Nov 2012 00:46:22 -0700
Message-ID: <1351842388-27210-9-git-send-email-computersforpeace@gmail.com>
References: <1351842388-27210-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36961 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754642Ab2KBHrA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2012 03:47:00 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2299681pad.19
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2012 00:47:00 -0700 (PDT)
In-Reply-To: <1351842388-27210-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, Tejun Heo <tj@kernel.org>

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/ata/pata_of_platform.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
index 1654dc2..cd0f9da 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -76,11 +76,6 @@ static int __devinit pata_of_platform_probe(struct platform_device *ofdev)
 				     reg_shift, pio_mask);
 }
 
-static int __devexit pata_of_platform_remove(struct platform_device *ofdev)
-{
-	return __pata_platform_remove(&ofdev->dev);
-}
-
 static struct of_device_id pata_of_platform_match[] = {
 	{ .compatible = "ata-generic", },
 	{ .compatible = "electra-ide", },
@@ -95,7 +90,7 @@ static struct platform_driver pata_of_platform_driver = {
 		.of_match_table = pata_of_platform_match,
 	},
 	.probe		= pata_of_platform_probe,
-	.remove		= __devexit_p(pata_of_platform_remove),
+	.remove		= ata_platform_remove_one,
 };
 
 module_platform_driver(pata_of_platform_driver);
-- 
1.7.11.3

