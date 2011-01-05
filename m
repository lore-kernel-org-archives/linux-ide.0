From: mkl0301@gmail.com
Subject: [PATCH v2 1/3] ahci_platform: rename to ahci_pltfm, but keep the original module name
Date: Wed,  5 Jan 2011 13:43:05 +0800
Message-ID: <1294206187-11487-2-git-send-email-mkl0301@gmail.com>
References: <1294206187-11487-1-git-send-email-mkl0301@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:60956 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047Ab1AEFnX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2011 00:43:23 -0500
Received: by yib18 with SMTP id 18so3685059yib.19
        for <linux-ide@vger.kernel.org>; Tue, 04 Jan 2011 21:43:23 -0800 (PST)
In-Reply-To: <1294206187-11487-1-git-send-email-mkl0301@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: cbouatmailru@gmail.com, htejun@gmail.com, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Mac Lin <mkl0301@gmail.com>

From: Mac Lin <mkl0301@gmail.com>

Due to build system limitations, intermediate and final objects can't have the
same names. And as we're going to start building SoC-specific objects, rename
ahci_platform to ahci_pltfm to be linked with SoC-specific objects into
ahci_platform.

Signed-off-by: Mac Lin <mkl0301@gmail.com>
---
 drivers/ata/Makefile        |    4 +-
 drivers/ata/ahci_platform.c |  197 -------------------------------------------
 drivers/ata/ahci_pltfm.c    |  197 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 200 insertions(+), 198 deletions(-)
 delete mode 100644 drivers/ata/ahci_platform.c
 create mode 100644 drivers/ata/ahci_pltfm.c

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 2b67c90..5b62be8 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -3,7 +3,6 @@ obj-$(CONFIG_ATA)		+= libata.o
 
 # non-SFF interface
 obj-$(CONFIG_SATA_AHCI)		+= ahci.o libahci.o
-obj-$(CONFIG_SATA_AHCI_PLATFORM) += ahci_platform.o libahci.o
 obj-$(CONFIG_SATA_FSL)		+= sata_fsl.o
 obj-$(CONFIG_SATA_INIC162X)	+= sata_inic162x.o
 obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
@@ -99,6 +98,9 @@ obj-$(CONFIG_ATA_GENERIC)	+= ata_generic.o
 # Should be last libata driver
 obj-$(CONFIG_PATA_LEGACY)	+= pata_legacy.o
 
+obj-$(CONFIG_SATA_AHCI_PLATFORM) 		+= ahci_platform.o libahci.o
+ahci_platform-y					:= ahci_pltfm.o
+
 libata-y	:= libata-core.o libata-scsi.o libata-eh.o libata-transport.o
 libata-$(CONFIG_ATA_SFF)	+= libata-sff.o
 libata-$(CONFIG_SATA_PMP)	+= libata-pmp.o
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
deleted file mode 100644
index 6fef1fa..0000000
--- a/drivers/ata/ahci_platform.c
+++ /dev/null
@@ -1,197 +0,0 @@
-/*
- * AHCI SATA platform driver
- *
- * Copyright 2004-2005  Red Hat, Inc.
- *   Jeff Garzik <jgarzik@pobox.com>
- * Copyright 2010  MontaVista Software, LLC.
- *   Anton Vorontsov <avorontsov@ru.mvista.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2, or (at your option)
- * any later version.
- */
-
-#include <linux/kernel.h>
-#include <linux/gfp.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/device.h>
-#include <linux/platform_device.h>
-#include <linux/libata.h>
-#include <linux/ahci_platform.h>
-#include "ahci.h"
-
-static struct scsi_host_template ahci_platform_sht = {
-	AHCI_SHT("ahci_platform"),
-};
-
-static int __init ahci_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct ahci_platform_data *pdata = dev->platform_data;
-	struct ata_port_info pi = {
-		.flags		= AHCI_FLAG_COMMON,
-		.pio_mask	= ATA_PIO4,
-		.udma_mask	= ATA_UDMA6,
-		.port_ops	= &ahci_ops,
-	};
-	const struct ata_port_info *ppi[] = { &pi, NULL };
-	struct ahci_host_priv *hpriv;
-	struct ata_host *host;
-	struct resource *mem;
-	int irq;
-	int n_ports;
-	int i;
-	int rc;
-
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem) {
-		dev_err(dev, "no mmio space\n");
-		return -EINVAL;
-	}
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(dev, "no irq\n");
-		return -EINVAL;
-	}
-
-	if (pdata && pdata->ata_port_info)
-		pi = *pdata->ata_port_info;
-
-	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
-	if (!hpriv) {
-		dev_err(dev, "can't alloc ahci_host_priv\n");
-		return -ENOMEM;
-	}
-
-	hpriv->flags |= (unsigned long)pi.private_data;
-
-	hpriv->mmio = devm_ioremap(dev, mem->start, resource_size(mem));
-	if (!hpriv->mmio) {
-		dev_err(dev, "can't map %pR\n", mem);
-		return -ENOMEM;
-	}
-
-	/*
-	 * Some platforms might need to prepare for mmio region access,
-	 * which could be done in the following init call. So, the mmio
-	 * region shouldn't be accessed before init (if provided) has
-	 * returned successfully.
-	 */
-	if (pdata && pdata->init) {
-		rc = pdata->init(dev, hpriv->mmio);
-		if (rc)
-			return rc;
-	}
-
-	ahci_save_initial_config(dev, hpriv,
-		pdata ? pdata->force_port_map : 0,
-		pdata ? pdata->mask_port_map  : 0);
-
-	/* prepare host */
-	if (hpriv->cap & HOST_CAP_NCQ)
-		pi.flags |= ATA_FLAG_NCQ;
-
-	if (hpriv->cap & HOST_CAP_PMP)
-		pi.flags |= ATA_FLAG_PMP;
-
-	ahci_set_em_messages(hpriv, &pi);
-
-	/* CAP.NP sometimes indicate the index of the last enabled
-	 * port, at other times, that of the last possible port, so
-	 * determining the maximum port number requires looking at
-	 * both CAP.NP and port_map.
-	 */
-	n_ports = max(ahci_nr_ports(hpriv->cap), fls(hpriv->port_map));
-
-	host = ata_host_alloc_pinfo(dev, ppi, n_ports);
-	if (!host) {
-		rc = -ENOMEM;
-		goto err0;
-	}
-
-	host->private_data = hpriv;
-
-	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
-		host->flags |= ATA_HOST_PARALLEL_SCAN;
-	else
-		printk(KERN_INFO "ahci: SSS flag set, parallel bus scan disabled\n");
-
-	if (pi.flags & ATA_FLAG_EM)
-		ahci_reset_em(host);
-
-	for (i = 0; i < host->n_ports; i++) {
-		struct ata_port *ap = host->ports[i];
-
-		ata_port_desc(ap, "mmio %pR", mem);
-		ata_port_desc(ap, "port 0x%x", 0x100 + ap->port_no * 0x80);
-
-		/* set enclosure management message type */
-		if (ap->flags & ATA_FLAG_EM)
-			ap->em_message_type = hpriv->em_msg_type;
-
-		/* disabled/not-implemented port */
-		if (!(hpriv->port_map & (1 << i)))
-			ap->ops = &ata_dummy_port_ops;
-	}
-
-	rc = ahci_reset_controller(host);
-	if (rc)
-		goto err0;
-
-	ahci_init_controller(host);
-	ahci_print_info(host, "platform");
-
-	rc = ata_host_activate(host, irq, ahci_interrupt, IRQF_SHARED,
-			       &ahci_platform_sht);
-	if (rc)
-		goto err0;
-
-	return 0;
-err0:
-	if (pdata && pdata->exit)
-		pdata->exit(dev);
-	return rc;
-}
-
-static int __devexit ahci_remove(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct ahci_platform_data *pdata = dev->platform_data;
-	struct ata_host *host = dev_get_drvdata(dev);
-
-	ata_host_detach(host);
-
-	if (pdata && pdata->exit)
-		pdata->exit(dev);
-
-	return 0;
-}
-
-static struct platform_driver ahci_driver = {
-	.remove = __devexit_p(ahci_remove),
-	.driver = {
-		.name = "ahci",
-		.owner = THIS_MODULE,
-	},
-};
-
-static int __init ahci_init(void)
-{
-	return platform_driver_probe(&ahci_driver, ahci_probe);
-}
-module_init(ahci_init);
-
-static void __exit ahci_exit(void)
-{
-	platform_driver_unregister(&ahci_driver);
-}
-module_exit(ahci_exit);
-
-MODULE_DESCRIPTION("AHCI SATA platform driver");
-MODULE_AUTHOR("Anton Vorontsov <avorontsov@ru.mvista.com>");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:ahci");
diff --git a/drivers/ata/ahci_pltfm.c b/drivers/ata/ahci_pltfm.c
new file mode 100644
index 0000000..6fef1fa
--- /dev/null
+++ b/drivers/ata/ahci_pltfm.c
@@ -0,0 +1,197 @@
+/*
+ * AHCI SATA platform driver
+ *
+ * Copyright 2004-2005  Red Hat, Inc.
+ *   Jeff Garzik <jgarzik@pobox.com>
+ * Copyright 2010  MontaVista Software, LLC.
+ *   Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/gfp.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/libata.h>
+#include <linux/ahci_platform.h>
+#include "ahci.h"
+
+static struct scsi_host_template ahci_platform_sht = {
+	AHCI_SHT("ahci_platform"),
+};
+
+static int __init ahci_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ahci_platform_data *pdata = dev->platform_data;
+	struct ata_port_info pi = {
+		.flags		= AHCI_FLAG_COMMON,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	};
+	const struct ata_port_info *ppi[] = { &pi, NULL };
+	struct ahci_host_priv *hpriv;
+	struct ata_host *host;
+	struct resource *mem;
+	int irq;
+	int n_ports;
+	int i;
+	int rc;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		dev_err(dev, "no mmio space\n");
+		return -EINVAL;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0) {
+		dev_err(dev, "no irq\n");
+		return -EINVAL;
+	}
+
+	if (pdata && pdata->ata_port_info)
+		pi = *pdata->ata_port_info;
+
+	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
+	if (!hpriv) {
+		dev_err(dev, "can't alloc ahci_host_priv\n");
+		return -ENOMEM;
+	}
+
+	hpriv->flags |= (unsigned long)pi.private_data;
+
+	hpriv->mmio = devm_ioremap(dev, mem->start, resource_size(mem));
+	if (!hpriv->mmio) {
+		dev_err(dev, "can't map %pR\n", mem);
+		return -ENOMEM;
+	}
+
+	/*
+	 * Some platforms might need to prepare for mmio region access,
+	 * which could be done in the following init call. So, the mmio
+	 * region shouldn't be accessed before init (if provided) has
+	 * returned successfully.
+	 */
+	if (pdata && pdata->init) {
+		rc = pdata->init(dev, hpriv->mmio);
+		if (rc)
+			return rc;
+	}
+
+	ahci_save_initial_config(dev, hpriv,
+		pdata ? pdata->force_port_map : 0,
+		pdata ? pdata->mask_port_map  : 0);
+
+	/* prepare host */
+	if (hpriv->cap & HOST_CAP_NCQ)
+		pi.flags |= ATA_FLAG_NCQ;
+
+	if (hpriv->cap & HOST_CAP_PMP)
+		pi.flags |= ATA_FLAG_PMP;
+
+	ahci_set_em_messages(hpriv, &pi);
+
+	/* CAP.NP sometimes indicate the index of the last enabled
+	 * port, at other times, that of the last possible port, so
+	 * determining the maximum port number requires looking at
+	 * both CAP.NP and port_map.
+	 */
+	n_ports = max(ahci_nr_ports(hpriv->cap), fls(hpriv->port_map));
+
+	host = ata_host_alloc_pinfo(dev, ppi, n_ports);
+	if (!host) {
+		rc = -ENOMEM;
+		goto err0;
+	}
+
+	host->private_data = hpriv;
+
+	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
+		host->flags |= ATA_HOST_PARALLEL_SCAN;
+	else
+		printk(KERN_INFO "ahci: SSS flag set, parallel bus scan disabled\n");
+
+	if (pi.flags & ATA_FLAG_EM)
+		ahci_reset_em(host);
+
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+
+		ata_port_desc(ap, "mmio %pR", mem);
+		ata_port_desc(ap, "port 0x%x", 0x100 + ap->port_no * 0x80);
+
+		/* set enclosure management message type */
+		if (ap->flags & ATA_FLAG_EM)
+			ap->em_message_type = hpriv->em_msg_type;
+
+		/* disabled/not-implemented port */
+		if (!(hpriv->port_map & (1 << i)))
+			ap->ops = &ata_dummy_port_ops;
+	}
+
+	rc = ahci_reset_controller(host);
+	if (rc)
+		goto err0;
+
+	ahci_init_controller(host);
+	ahci_print_info(host, "platform");
+
+	rc = ata_host_activate(host, irq, ahci_interrupt, IRQF_SHARED,
+			       &ahci_platform_sht);
+	if (rc)
+		goto err0;
+
+	return 0;
+err0:
+	if (pdata && pdata->exit)
+		pdata->exit(dev);
+	return rc;
+}
+
+static int __devexit ahci_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ahci_platform_data *pdata = dev->platform_data;
+	struct ata_host *host = dev_get_drvdata(dev);
+
+	ata_host_detach(host);
+
+	if (pdata && pdata->exit)
+		pdata->exit(dev);
+
+	return 0;
+}
+
+static struct platform_driver ahci_driver = {
+	.remove = __devexit_p(ahci_remove),
+	.driver = {
+		.name = "ahci",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init ahci_init(void)
+{
+	return platform_driver_probe(&ahci_driver, ahci_probe);
+}
+module_init(ahci_init);
+
+static void __exit ahci_exit(void)
+{
+	platform_driver_unregister(&ahci_driver);
+}
+module_exit(ahci_exit);
+
+MODULE_DESCRIPTION("AHCI SATA platform driver");
+MODULE_AUTHOR("Anton Vorontsov <avorontsov@ru.mvista.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:ahci");
-- 
1.7.3

