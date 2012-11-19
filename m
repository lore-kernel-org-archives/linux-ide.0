From: Daniel J Blueman <daniel@quora.org>
Subject: [PATCH] AHCI: fix build warning when PM && !PM_SLEEP
Date: Mon, 19 Nov 2012 17:06:26 +0800
Message-ID: <1353315986-27317-1-git-send-email-daniel@quora.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:60801 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183Ab2KSJGj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2012 04:06:39 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so308239pad.19
        for <linux-ide@vger.kernel.org>; Mon, 19 Nov 2012 01:06:39 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel J Blueman <daniel@quora.org>

Change the conditional around ahci_suspend/resume to the same as the
SIMPLE_DEV_PM_OPS macro that uses these functions, fixing an unused build
warning.

Signed-off-by: Daniel J Blueman <daniel@quora.org>
---
 drivers/ata/ahci_platform.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index b1ae480..b7078af 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -238,7 +238,7 @@ static int __devexit ahci_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int ahci_suspend(struct device *dev)
 {
 	struct ahci_platform_data *pdata = dev_get_platdata(dev);
-- 
1.7.10.4

