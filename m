From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] libata: sata_rcar: Convert to devm_ioremap_resource()
Date: Thu,  4 Apr 2013 14:56:36 +0530
Message-ID: <1365067596-8868-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36693 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758923Ab3DDJiW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Apr 2013 05:38:22 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so1319474pde.23
        for <linux-ide@vger.kernel.org>; Thu, 04 Apr 2013 02:38:22 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, vladimir.barinov@cogentembedded.com, sachin.kamat@linaro.org

Use the newly introduced devm_ioremap_resource() instead of
devm_request_and_ioremap() which provides more consistent error handling.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/ata/sata_rcar.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index caf33f6..4799868 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -17,6 +17,7 @@
 #include <linux/libata.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/err.h>
 
 #define DRV_NAME "sata_rcar"
 
@@ -799,9 +800,9 @@ static int sata_rcar_probe(struct platform_device *pdev)
 
 	host->private_data = priv;
 
-	priv->base = devm_request_and_ioremap(&pdev->dev, mem);
-	if (!priv->base) {
-		ret = -EADDRNOTAVAIL;
+	priv->base = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(priv->base)) {
+		ret = PTR_ERR(priv->base);
 		goto cleanup;
 	}
 
-- 
1.7.9.5

