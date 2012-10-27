From: Brian Norris <computersforpeace@gmail.com>
Subject: [RFC v2 3/3] ahci_platform: perform platform exit in host_stop() hook
Date: Sat, 27 Oct 2012 13:09:36 -0700
Message-ID: <1351368576-5264-4-git-send-email-computersforpeace@gmail.com>
References: <1351368576-5264-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44950 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758551Ab2J0UKR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Oct 2012 16:10:17 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3454458pbb.19
        for <linux-ide@vger.kernel.org>; Sat, 27 Oct 2012 13:10:17 -0700 (PDT)
In-Reply-To: <1351368576-5264-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-pm@lists.linux-foundation.org, Kevin Cernekee <cernekee@gmail.com>, Brian Norris <computersforpeace@gmail.com>

AHCI platform devices may provide an exit() routine, via
ahci_platform_data, that powers off the SATA core. Such a routine should
be executed from the ata_port_operations host_stop() hook. That way, the
ATA subsystem can perform any last-minute hardware cleanup (via devres,
for example), then trigger the power-off at the appropriate time.

This patch fixes bus errors triggered during module removal or device
unbinding, seen on an SoC SATA core.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/ata/ahci_platform.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index d9fbd10..dcd23a9 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -23,6 +23,8 @@
 #include <linux/ahci_platform.h>
 #include "ahci.h"
 
+static void ahci_host_stop(struct ata_host *host);
+
 enum ahci_type {
 	AHCI,		/* standard platform ahci */
 	IMX53_AHCI,	/* ahci on i.mx53 */
@@ -45,6 +47,15 @@ static struct platform_device_id ahci_devtype[] = {
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
@@ -52,20 +63,20 @@ static const struct ata_port_info ahci_port_info[] = {
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
 
@@ -202,15 +213,20 @@ err0:
 static int __devexit ahci_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct ahci_platform_data *pdata = dev_get_platdata(dev);
 	struct ata_host *host = dev_get_drvdata(dev);
 
 	ata_host_detach(host);
 
+	return 0;
+}
+
+static void ahci_host_stop(struct ata_host *host)
+{
+	struct device *dev = host->dev;
+	struct ahci_platform_data *pdata = dev_get_platdata(dev);
+
 	if (pdata && pdata->exit)
 		pdata->exit(dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
-- 
1.7.11.3

