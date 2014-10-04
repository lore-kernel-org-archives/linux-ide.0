From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ata: pata_imx: Use the SIMPLE_DEV_PM_OPS() macro
Date: Sat,  4 Oct 2014 09:03:06 -0300
Message-ID: <1412424186-4296-1-git-send-email-festevam@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:38199 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbaJDMDf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Oct 2014 08:03:35 -0400
Received: by mail-qc0-f175.google.com with SMTP id w7so2183526qcr.34
        for <linux-ide@vger.kernel.org>; Sat, 04 Oct 2014 05:03:34 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Using the SIMPLE_DEV_PM_OPS() macro can make the code shorter and cleaner.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/ata/pata_imx.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
index af42457..989ff5a 100644
--- a/drivers/ata/pata_imx.c
+++ b/drivers/ata/pata_imx.c
@@ -221,13 +221,10 @@ static int pata_imx_resume(struct device *dev)
 
 	return 0;
 }
-
-static const struct dev_pm_ops pata_imx_pm_ops = {
-	.suspend	= pata_imx_suspend,
-	.resume		= pata_imx_resume,
-};
 #endif
 
+static SIMPLE_DEV_PM_OPS(pata_imx_pm_ops, pata_imx_suspend, pata_imx_resume);
+
 static const struct of_device_id imx_pata_dt_ids[] = {
 	{
 		.compatible = "fsl,imx27-pata",
@@ -244,9 +241,7 @@ static struct platform_driver pata_imx_driver = {
 		.name		= DRV_NAME,
 		.of_match_table	= imx_pata_dt_ids,
 		.owner		= THIS_MODULE,
-#ifdef CONFIG_PM_SLEEP
 		.pm		= &pata_imx_pm_ops,
-#endif
 	},
 };
 
-- 
1.9.1

