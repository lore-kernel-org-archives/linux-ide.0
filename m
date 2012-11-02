From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 03/14] ahci_platform: perform platform exit in host_stop() hook
Date: Fri,  2 Nov 2012 00:46:17 -0700
Message-ID: <1351842388-27210-4-git-send-email-computersforpeace@gmail.com>
References: <1351842388-27210-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:43309 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296Ab2KBHqz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2012 03:46:55 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1546133dak.19
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2012 00:46:54 -0700 (PDT)
In-Reply-To: <1351842388-27210-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, Tejun Heo <tj@kernel.org>

AHCI platform devices may provide an exit() routine, via
ahci_platform_data, that powers off the SATA core. Such a routine should
be executed from the ata_port_operations host_stop() hook. That way, the
ATA subsystem can perform any last-minute hardware cleanup (via devres,
for example), then trigger the power-off at the appropriate time.

This patch fixes bus errors triggered during module removal or device
unbinding, seen on an SoC SATA core.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/ata/ahci_platform.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 8ae1c6f..05806e0 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -25,6 +25,8 @@
 #include <linux/ahci_platform.h>
 #include "ahci.h"
 
+static void ahci_host_stop(struct ata_host *host);
+
 enum ahci_type {
 	AHCI,		/* standard platform ahci */
 	IMX53_AHCI,	/* ahci on i.mx53 */
@@ -47,6 +49,15 @@ static struct platform_device_id ahci_devtype[] = {
 };
 MODULE_DEVICE_TABLE(platform, ahci_devtype);
 
+struct ata_port_operations ahci_platform_ops = {
+	.inherits	= &ahci_ops,
+	.host_stop	= ahci_host_stop,
+};
+
+struct ata_port_operations ahci_platform_retry_srst_ops = {
+	.inherits	= &ahci_pmp_retry_srst_ops,
+	.host_stop	= ahci_host_stop,
+};
 
 static const struct ata_port_info ahci_port_info[] = {
 	/* by features */
@@ -54,20 +65,20 @@ static const struct ata_port_info ahci_port_info[] = {
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
-		.port_ops	= &ahci_ops,
+		.port_ops	= &ahci_platform_ops,
 	},
 	[IMX53_AHCI] = {
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
-		.port_ops	= &ahci_pmp_retry_srst_ops,
+		.port_ops	= &ahci_platform_retry_srst_ops,
 	},
 	[STRICT_AHCI] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_DELAY_ENGINE),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
-		.port_ops	= &ahci_ops,
+		.port_ops	= &ahci_platform_ops,
 	},
 };
 
@@ -221,12 +232,19 @@ free_clk:
 static int __devexit ahci_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct ahci_platform_data *pdata = dev_get_platdata(dev);
 	struct ata_host *host = dev_get_drvdata(dev);
-	struct ahci_host_priv *hpriv = host->private_data;
 
 	ata_host_detach(host);
 
+	return 0;
+}
+
+static void ahci_host_stop(struct ata_host *host)
+{
+	struct device *dev = host->dev;
+	struct ahci_platform_data *pdata = dev_get_platdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
+
 	if (pdata && pdata->exit)
 		pdata->exit(dev);
 
@@ -234,8 +252,6 @@ static int __devexit ahci_remove(struct platform_device *pdev)
 		clk_disable_unprepare(hpriv->clk);
 		clk_put(hpriv->clk);
 	}
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
-- 
1.7.11.3

