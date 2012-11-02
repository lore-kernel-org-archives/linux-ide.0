From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 09/14] pata_platform: utilize common ata_platform_remove_one()
Date: Fri,  2 Nov 2012 00:46:23 -0700
Message-ID: <1351842388-27210-10-git-send-email-computersforpeace@gmail.com>
References: <1351842388-27210-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56817 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755293Ab2KBHrB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2012 03:47:01 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2297937pbb.19
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2012 00:47:01 -0700 (PDT)
In-Reply-To: <1351842388-27210-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, Tejun Heo <tj@kernel.org>

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/ata/pata_platform.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index f1848ae..449aa29 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -242,14 +242,9 @@ static int __devinit pata_platform_probe(struct platform_device *pdev)
 				     pio_mask);
 }
 
-static int __devexit pata_platform_remove(struct platform_device *pdev)
-{
-	return __pata_platform_remove(&pdev->dev);
-}
-
 static struct platform_driver pata_platform_driver = {
 	.probe		= pata_platform_probe,
-	.remove		= __devexit_p(pata_platform_remove),
+	.remove		= ata_platform_remove_one,
 	.driver = {
 		.name		= DRV_NAME,
 		.owner		= THIS_MODULE,
-- 
1.7.11.3

