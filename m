From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH v3 1/4] sata_highbank: utilize common ata_platform_remove_one()
Date: Mon,  3 Dec 2012 10:34:39 -0800
Message-ID: <1354559682-30965-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:50377 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879Ab2LCSex (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2012 13:34:53 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so1426137dak.19
        for <linux-ide@vger.kernel.org>; Mon, 03 Dec 2012 10:34:53 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Brian Norris <computersforpeace@gmail.com>

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
v2: fix whitespace
v3: Resend to fix a trivial conflict

(Note: This patch is on its 3rd version, where others are v2.)

 drivers/ata/sata_highbank.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index 75c0f3c..dc7d78e 100644
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
 #ifdef CONFIG_PM_SLEEP
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
1.8.0

