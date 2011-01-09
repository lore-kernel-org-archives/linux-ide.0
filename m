From: mkl0301@gmail.com
Subject: [PATCH v4 2/3] ahci_platform: switch to module device table matching
Date: Sun,  9 Jan 2011 09:49:34 +0800
Message-ID: <1294537775-21714-3-git-send-email-mkl0301@gmail.com>
References: <1294537775-21714-1-git-send-email-mkl0301@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65012 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113Ab1AIBt7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Jan 2011 20:49:59 -0500
Received: by iwn9 with SMTP id 9so18252567iwn.19
        for <linux-ide@vger.kernel.org>; Sat, 08 Jan 2011 17:49:58 -0800 (PST)
In-Reply-To: <1294537775-21714-1-git-send-email-mkl0301@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, cbouatmailru@gmail.com, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Mac Lin <mkl0301@gmail.com>

From: Mac Lin <mkl0301@gmail.com>

Switch the driver to use module device table matching mechanism to add SoC-specific parts to the generic driver.

Signed-off-by: Mac Lin <mkl0301@gmail.com>
---
 drivers/ata/ahci_platform.c  |   14 +++++++++++++-
 drivers/ata/ahci_platforms.h |   16 ++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletions(-)
 create mode 100644 drivers/ata/ahci_platforms.h

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 6fef1fa..190db2c 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -19,9 +19,11 @@
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/libata.h>
 #include <linux/ahci_platform.h>
 #include "ahci.h"
+#include "ahci_platforms.h"
 
 static struct scsi_host_template ahci_platform_sht = {
 	AHCI_SHT("ahci_platform"),
@@ -29,6 +31,7 @@ static struct scsi_host_template ahci_platform_sht = {
 
 static int __init ahci_probe(struct platform_device *pdev)
 {
+	const struct platform_device_id *platid = platform_get_device_id(pdev);
 	struct device *dev = &pdev->dev;
 	struct ahci_platform_data *pdata = dev->platform_data;
 	struct ata_port_info pi = {
@@ -46,6 +49,9 @@ static int __init ahci_probe(struct platform_device *pdev)
 	int i;
 	int rc;
 
+	if (!pdata && platid && platid->driver_data)
+		pdata = (void *)platid->driver_data;
+
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
 		dev_err(dev, "no mmio space\n");
@@ -171,12 +177,19 @@ static int __devexit ahci_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct platform_device_id ahci_pltfm_ids[] = {
+	{ "ahci", },
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, ahci_pltfm_ids);
+
 static struct platform_driver ahci_driver = {
 	.remove = __devexit_p(ahci_remove),
 	.driver = {
 		.name = "ahci",
 		.owner = THIS_MODULE,
 	},
+	.id_table	= ahci_pltfm_ids,
 };
 
 static int __init ahci_init(void)
@@ -194,4 +207,3 @@ module_exit(ahci_exit);
 MODULE_DESCRIPTION("AHCI SATA platform driver");
 MODULE_AUTHOR("Anton Vorontsov <avorontsov@ru.mvista.com>");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:ahci");
diff --git a/drivers/ata/ahci_platforms.h b/drivers/ata/ahci_platforms.h
new file mode 100644
index 0000000..cf16e6f
--- /dev/null
+++ b/drivers/ata/ahci_platforms.h
@@ -0,0 +1,16 @@
+/*
+ * Copyright 2010 MontaVista Software, LLC.
+ * Copyright 2010 Cavium Networks
+ *
+ * Authors: Anton Vorontsov <avorontsov@mvista.com>
+ *	    Mac Lin <mkl0301@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _DRIVERS_SATA_AHCI_PLATFORMS_H
+#define _DRIVERS_SATA_AHCI_PLATFORMS_H
+
+#endif /*_DRIVERS_SATA_AHCI_PLATFORMS_H*/
-- 
1.7.3

