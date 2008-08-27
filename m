From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 1/1] libata: Blackfin Pata Driver: Add proper PM operation into ATAPI driver.
Date: Wed, 27 Aug 2008 11:51:18 +0800
Message-ID: <1219809078-15767-1-git-send-email-cooloney@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:62262 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120AbYH0DvK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Aug 2008 23:51:10 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>, Bryan Wu <cooloney@kernel.org>

From: Sonic Zhang <sonic.zhang@analog.com>

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 drivers/ata/pata_bf54x.c |   29 ++++++++++++++++++++++++-----
 1 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
index d393290..60f4872 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -1632,6 +1632,8 @@ static int __devinit bfin_atapi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	dev_set_drvdata(&pdev->dev, host);
+
 	return 0;
 }
 
@@ -1648,6 +1650,7 @@ static int __devexit bfin_atapi_remove(struct platform_device *pdev)
 	struct ata_host *host = dev_get_drvdata(dev);
 
 	ata_host_detach(host);
+	dev_set_drvdata(&pdev->dev, NULL);
 
 	peripheral_free_list(atapi_io_port);
 
@@ -1657,11 +1660,27 @@ static int __devexit bfin_atapi_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 int bfin_atapi_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	return 0;
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	if (host)
+		return ata_host_suspend(host, state);
+	else
+		return 0;
 }
 
 int bfin_atapi_resume(struct platform_device *pdev)
 {
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	int ret;
+
+	if (host) {
+		ret = bfin_reset_controller(host);
+		if (ret) {
+			printk(KERN_ERR DRV_NAME ": Error during HW init\n");
+			return ret;
+		}
+		ata_host_resume(host);
+	}
+
 	return 0;
 }
 #endif
@@ -1669,13 +1688,13 @@ int bfin_atapi_resume(struct platform_device *pdev)
 static struct platform_driver bfin_atapi_driver = {
 	.probe			= bfin_atapi_probe,
 	.remove			= __devexit_p(bfin_atapi_remove),
+#ifdef CONFIG_PM
+	.suspend		= bfin_atapi_suspend,
+	.resume			= bfin_atapi_resume,
+#endif
 	.driver = {
 		.name		= DRV_NAME,
 		.owner		= THIS_MODULE,
-#ifdef CONFIG_PM
-		.suspend	= bfin_atapi_suspend,
-		.resume		= bfin_atapi_resume,
-#endif
 	},
 };
 
-- 
1.5.6
