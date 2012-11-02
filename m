From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH v2 12/14] sata_highbank: utilize common ata_platform_remove_one()
Date: Fri,  2 Nov 2012 12:12:06 -0700
Message-ID: <1351883526-32412-1-git-send-email-computersforpeace@gmail.com>
References: <1351842388-27210-13-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:34741 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935443Ab2KBTMS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2012 15:12:18 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1767295dak.19
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2012 12:12:17 -0700 (PDT)
In-Reply-To: <1351842388-27210-13-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Brian Norris <computersforpeace@gmail.com>, Sergei Shtylyov <sshtylyov@mvista.com>

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
v2: fix whitespace

 drivers/ata/sata_highbank.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index 0d7c4c2..64c7276 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -368,16 +368,6 @@ err0:
 	return rc;
 }
 
-static int __devexit ahci_highbank_remove(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct ata_host *host = dev_get_drvdata(dev);
-
-	ata_host_detach(host);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM
 static int ahci_highbank_suspend(struct device *dev)
 {
@@ -432,7 +422,7 @@ SIMPLE_DEV_PM_OPS(ahci_highbank_pm_ops,
 		  ahci_highbank_suspend, ahci_highbank_resume);
 
 static struct platform_driver ahci_highbank_driver = {
-        .remove = __devexit_p(ahci_highbank_remove),
+	.remove = ata_platform_remove_one,
         .driver = {
                 .name = "highbank-ahci",
                 .owner = THIS_MODULE,
-- 
1.7.11.3

