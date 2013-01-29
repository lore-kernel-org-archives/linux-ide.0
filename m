From: Vasanth Ananthan <vasanthananthan@gmail.com>
Subject: [PATCH 1/2] driver: ata: SATA PHY framework
Date: Tue, 29 Jan 2013 20:49:17 +0530
Message-ID: <1359472758-31350-2-git-send-email-vasanthananthan@gmail.com>
References: <1359472758-31350-1-git-send-email-vasanthananthan@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:50737 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858Ab3A2PTh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jan 2013 10:19:37 -0500
In-Reply-To: <1359472758-31350-1-git-send-email-vasanthananthan@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, jgarzik@redhat.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, thomas.abraham@linaro.org, girish.shivananjappa@linaro.org, Vasanth Ananthan <vasanthananthan@gmail.com>, Vasanth Ananthan <vasanth.a@samsung.com>

This patch adds SATA PHY framework APIs. The framework acts as an
interface between the SATA controller and the PHY controller.
The SATA PHY controller driver registers the PHY  with the framework
through the sata_add_phy call, passing its device_node. The SATA controller
requests for an appropriate PHY controller by passing the device_node of
the PHY, the SATA controller node is mapped to in the device tree, to
sata_get_phy call. After getting the PHY, SATA controllers initializes
corresponding PHY controller through sata_init_phy call.

Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
---
 drivers/ata/Kconfig    |   10 ++++
 drivers/ata/Makefile   |    1 +
 drivers/ata/sata_phy.c |  146 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/sata_phy.h |   29 ++++++++++
 4 files changed, 186 insertions(+)
 create mode 100644 drivers/ata/sata_phy.c
 create mode 100644 drivers/ata/sata_phy.h

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 996d16c..99c1e1b 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -96,6 +96,16 @@ config SATA_AHCI_PLATFORM
 
 	  If unsure, say N.
 
+config SATA_PHY
+	bool "SATA PHY Framework"
+	default n
+	help
+	  This option enables the SATA PHY utility framework APIs.
+	  The framework acts as an interface between the SATA
+	  controller and the PHY controller. The PHY controller
+	  registers itself with the framework through the APIs provided and the SATA
+	  controller finds and requests for an appropriate PHY controller.
+
 config SATA_FSL
 	tristate "Freescale 3.0Gbps SATA support"
 	depends on FSL_SOC
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 85e3de4..3d2d128 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_SATA_INIC162X)	+= sata_inic162x.o
 obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
 obj-$(CONFIG_SATA_DWC)		+= sata_dwc_460ex.o
 obj-$(CONFIG_SATA_HIGHBANK)	+= sata_highbank.o libahci.o
+obj-$(CONFIG_SATA_PHY)		+= sata_phy.o
 
 # SFF w/ custom DMA
 obj-$(CONFIG_PDC_ADMA)		+= pdc_adma.o
diff --git a/drivers/ata/sata_phy.c b/drivers/ata/sata_phy.c
new file mode 100644
index 0000000..0f56878
--- /dev/null
+++ b/drivers/ata/sata_phy.c
@@ -0,0 +1,146 @@
+/*
+ * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
+ *              http://www.samsung.com
+ *
+ * SATA PHY framework.
+ *
+ * This file provides a set of functions/interfaces for establishing
+ * communication between SATA controller and the PHY controller. A
+ * PHY controller driver registers call backs for its initialization and
+ * shutdown. The SATA controller driver finds the appropriate PHYs for
+ * its implemented ports and initialize/shutdown PHYs through the
+ * call backs provided.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/export.h>
+#include <linux/err.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include "sata_phy.h"
+
+static LIST_HEAD(phy_list);
+static DEFINE_SPINLOCK(phy_lock);
+
+struct sata_phy *sata_get_phy(struct device_node *phy_np)
+{
+	struct sata_phy *phy;
+	unsigned long flag;
+
+	spin_lock_irqsave(&phy_lock, flag);
+
+	if (list_empty(&phy_list)) {
+		spin_unlock_irqrestore(&phy_lock, flag);
+		return ERR_PTR(-ENODEV);
+	}
+
+	list_for_each_entry(phy, &phy_list, head) {
+		if (phy->dev->of_node == phy_np) {
+			if (phy->status == IN_USE) {
+				pr_info(KERN_INFO
+					"PHY already in use\n");
+				spin_unlock_irqrestore(&phy_lock, flag);
+				return ERR_PTR(-EBUSY);
+			}
+
+			get_device(phy->dev);
+			phy->status = IN_USE;
+			spin_unlock_irqrestore(&phy_lock, flag);
+			return phy;
+		}
+	}
+
+	spin_unlock_irqrestore(&phy_lock, flag);
+	return ERR_PTR(-ENODEV);
+}
+EXPORT_SYMBOL(sata_get_phy);
+
+int sata_add_phy(struct sata_phy *sataphy)
+{
+	unsigned long flag;
+	unsigned int ret = -EINVAL;
+	struct sata_phy *phy;
+
+	if (!sataphy)
+		return ret;
+
+	spin_lock_irqsave(&phy_lock, flag);
+
+	list_for_each_entry(phy, &phy_list, head) {
+		if (phy->dev->of_node == sataphy->dev->of_node) {
+			dev_err(sataphy->dev, "PHY already exists in the list\n");
+			goto out;
+		}
+	}
+
+	sataphy->status = NOT_IN_USE;
+	list_add_tail(&sataphy->head, &phy_list);
+	ret = 0;
+
+ out:
+	spin_unlock_irqrestore(&phy_lock, flag);
+	return ret;
+}
+EXPORT_SYMBOL(sata_add_phy);
+
+void sata_remove_phy(struct sata_phy *sataphy)
+{
+	unsigned long flag;
+	struct sata_phy *phy;
+
+	if (!sataphy)
+		return;
+
+	if (sataphy->status == IN_USE) {
+		pr_info(KERN_INFO
+			"PHY in use, cannot be removed\n");
+		return;
+	}
+
+	spin_lock_irqsave(&phy_lock, flag);
+
+	list_for_each_entry(phy, &phy_list, head) {
+		if (phy->dev->of_node == sataphy->dev->of_node)
+			list_del(&phy->head);
+	}
+
+	spin_unlock_irqrestore(&phy_lock, flag);
+}
+EXPORT_SYMBOL(sata_remove_phy);
+
+void sata_put_phy(struct sata_phy *sataphy)
+{
+	unsigned long flag;
+
+	if (!sataphy)
+		return;
+
+	spin_lock_irqsave(&phy_lock, flag);
+
+	put_device(sataphy->dev);
+	sataphy->status = NOT_IN_USE;
+
+	spin_unlock_irqrestore(&phy_lock, flag);
+}
+EXPORT_SYMBOL(sata_put_phy);
+
+int sata_init_phy(struct sata_phy *sataphy)
+{
+	if (sataphy && sataphy->init)
+		return sataphy->init(sataphy);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(sata_init_phy);
+
+void sata_shutdown_phy(struct sata_phy *sataphy)
+{
+	if (sataphy && sataphy->shutdown)
+		sataphy->shutdown(sataphy);
+}
+EXPORT_SYMBOL(sata_shutdown_phy);
diff --git a/drivers/ata/sata_phy.h b/drivers/ata/sata_phy.h
new file mode 100644
index 0000000..03ae2f9
--- /dev/null
+++ b/drivers/ata/sata_phy.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
+ *              http://www.samsung.com
+ *
+ * SATA utility framework definitions.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#define IN_USE		1
+#define NOT_IN_USE	0
+
+struct sata_phy {
+	int (*init) (struct sata_phy *);
+	int (*shutdown) (struct sata_phy *);
+	struct device *dev;
+	void *priv_data;
+	struct list_head head;
+	unsigned char status;
+};
+
+struct sata_phy *sata_get_phy(struct device_node *);
+int sata_add_phy(struct sata_phy *);
+void sata_remove_phy(struct sata_phy *);
+void sata_put_phy(struct sata_phy *);
+int sata_init_phy(struct sata_phy *);
+void sata_shutdown_phy(struct sata_phy *);
-- 
1.7.9.5

