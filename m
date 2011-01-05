From: mkl0301@gmail.com
Subject: [PATCH v2 2/3] ahci_pltfm: switch to module device table matching
Date: Wed,  5 Jan 2011 13:43:06 +0800
Message-ID: <1294206187-11487-3-git-send-email-mkl0301@gmail.com>
References: <1294206187-11487-1-git-send-email-mkl0301@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37830 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047Ab1AEFna (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2011 00:43:30 -0500
Received: by ywl5 with SMTP id 5so5882975ywl.19
        for <linux-ide@vger.kernel.org>; Tue, 04 Jan 2011 21:43:30 -0800 (PST)
In-Reply-To: <1294206187-11487-1-git-send-email-mkl0301@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: cbouatmailru@gmail.com, htejun@gmail.com, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Mac Lin <mkl0301@gmail.com>

From: Mac Lin <mkl0301@gmail.com>

Switch the driver to use module device table matching mechanism to add SoC-specific parts to the generic driver.

Signed-off-by: Mac Lin <mkl0301@gmail.com>
---
 drivers/ata/ahci_pltfm.c |   14 +++++++++++++-
 drivers/ata/ahci_pltfm.h |   17 +++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletions(-)
 create mode 100644 drivers/ata/ahci_pltfm.h

diff --git a/drivers/ata/ahci_pltfm.c b/drivers/ata/ahci_pltfm.c
index 6fef1fa..6579d55 100644
--- a/drivers/ata/ahci_pltfm.c
+++ b/drivers/ata/ahci_pltfm.c
@@ -19,9 +19,11 @@
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/libata.h>
 #include <linux/ahci_platform.h>
 #include "ahci.h"
+#include "ahci_pltfm.h"
 
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
diff --git a/drivers/ata/ahci_pltfm.h b/drivers/ata/ahci_pltfm.h
new file mode 100644
index 0000000..b66390c
--- /dev/null
+++ b/drivers/ata/ahci_pltfm.h
@@ -0,0 +1,17 @@
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
+#ifndef _DRIVERS_SATA_AHCI_PLTFM_H
+#define _DRIVERS_SATA_AHCI_PLTFM_H
+
+#endif /* _DRIVERS_SATA_AHCI_PLTFM_H */
+
-- 
1.7.3

