From: girishks2000@gmail.com
Subject: [PATCH 1/2] ahci: sata: add support for exynos5440 sata
Date: Fri,  1 Feb 2013 17:56:24 -0800
Message-ID: <510c7282.a4d1440a.7061.2697@mx.google.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:47725 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757284Ab3BBB5X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Feb 2013 20:57:23 -0500
Received: by mail-pb0-f44.google.com with SMTP id wz12so2388053pbc.31
        for <linux-ide@vger.kernel.org>; Fri, 01 Feb 2013 17:57:22 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org, Girish K S <ks.giri@samsung.com>

From: Girish K S <ks.giri@samsung.com>

This patch adds the compatible string of the exynos5440 sata controller
compliant with the ahci 1.3 and sata 3.0 specification.

Signed-off-by: Girish K S <ks.giri@samsung.com>
---
 drivers/ata/ahci_platform.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 7a8a284..c06f021 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -327,6 +327,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_suspend, ahci_resume);
 
 static const struct of_device_id ahci_of_match[] = {
 	{ .compatible = "snps,spear-ahci", },
+	{ .compatible = "samsung,exynos5440-ahci", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_of_match);
-- 
1.7.10.4

