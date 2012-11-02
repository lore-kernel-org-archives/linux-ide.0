From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 05/14] ahci_platform: utilize common ata_platform_remove_one()
Date: Fri,  2 Nov 2012 00:46:19 -0700
Message-ID: <1351842388-27210-6-git-send-email-computersforpeace@gmail.com>
References: <1351842388-27210-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36961 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754801Ab2KBHq5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2012 03:46:57 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2299681pad.19
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2012 00:46:57 -0700 (PDT)
In-Reply-To: <1351842388-27210-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, Tejun Heo <tj@kernel.org>

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/ata/ahci_platform.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 05806e0..13e4456 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -229,16 +229,6 @@ free_clk:
 	return rc;
 }
 
-static int __devexit ahci_remove(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct ata_host *host = dev_get_drvdata(dev);
-
-	ata_host_detach(host);
-
-	return 0;
-}
-
 static void ahci_host_stop(struct ata_host *host)
 {
 	struct device *dev = host->dev;
@@ -343,7 +333,7 @@ MODULE_DEVICE_TABLE(of, ahci_of_match);
 
 static struct platform_driver ahci_driver = {
 	.probe = ahci_probe,
-	.remove = __devexit_p(ahci_remove),
+	.remove = ata_platform_remove_one,
 	.driver = {
 		.name = "ahci",
 		.owner = THIS_MODULE,
-- 
1.7.11.3

