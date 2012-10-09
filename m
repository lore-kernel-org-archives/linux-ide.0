From: Vasanth Ananthan <vasanthananthan@gmail.com>
Subject: [PATCH 3/6] DRIVERS: ATA: SATA PHY utility framework
Date: Tue,  9 Oct 2012 17:18:49 +0530
Message-ID: <1349783332-18467-4-git-send-email-vasanthananthan@gmail.com>
References: <1349783332-18467-1-git-send-email-vasanthananthan@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:46756 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534Ab2JILq1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Oct 2012 07:46:27 -0400
In-Reply-To: <1349783332-18467-1-git-send-email-vasanthananthan@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kgene.kim@samsung.com, jgarzik@pobox.com, linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-ide@vger.kernel.org, thomas.abraham@linaro.org, Vasanth Ananthan <vasanthananthan@gmail.com>, Vasanth Ananthan <vasanth.a@samsung.com>

This patch adds SATA PHY utility framework APIs. The framework acts as an
interface between the SATA device and the PHY device. The SATA PHY device
registers itself with the framework through the APIs provided and the SATA
device finds and requests for an appropriate PHY device.

Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
---
 drivers/ata/Kconfig    |    9 ++++
 drivers/ata/Makefile   |    1 +
 drivers/ata/sata_phy.c |   99 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/sata_phy.h |   44 +++++++++++++++++++++
 4 files changed, 153 insertions(+), 0 deletions(-)
 create mode 100644 drivers/ata/sata_phy.c
 create mode 100644 drivers/ata/sata_phy.h

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 27cecd3..0344b78 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -83,6 +83,15 @@ config SATA_AHCI_PLATFORM
 
 	  If unsure, say N.
 
+config SATA_EXYNOS
+	bool "Exynos SATA AHCI support"
+	depends on I2C_S3C2410
+	help
+          This option enables support for Exynos AHCI Serial ATA
+          controllers.
+
+          If unsure, say N.
+
 config SATA_FSL
 	tristate "Freescale 3.0Gbps SATA support"
 	depends on FSL_SOC
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index a454a13..bf3fd91 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_SATA_FSL)		+= sata_fsl.o
 obj-$(CONFIG_SATA_INIC162X)	+= sata_inic162x.o
 obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
 obj-$(CONFIG_SATA_DWC)		+= sata_dwc_460ex.o
+obj-$(CONFIG_SATA_EXYNOS)          += sata_phy.o libahci.o
 
 # SFF w/ custom DMA
 obj-$(CONFIG_PDC_ADMA)		+= pdc_adma.o
diff --git a/drivers/ata/sata_phy.c b/drivers/ata/sata_phy.c
new file mode 100644
index 0000000..dbb4aa3
--- /dev/null
+++ b/drivers/ata/sata_phy.c
@@ -0,0 +1,99 @@
+/*
+ * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
+ *              http://www.samsung.com
+ *
+ * EXYNOS - SATA utility framework.
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
+struct sata_phy *sata_get_phy(enum sata_phy_type type)
+{
+	struct sata_phy *x = NULL;
+	unsigned long flag;
+
+	spin_lock_irqsave(&phy_lock, flag);
+
+	list_for_each_entry(x, &phy_list, head) {
+		if (x->type == type) {
+			get_device(x->dev);
+			break;
+		}
+	}
+
+	spin_unlock_irqrestore(&phy_lock, flag);
+	return x;
+}
+EXPORT_SYMBOL(sata_get_phy);
+
+int sata_add_phy(struct sata_phy *phy, enum sata_phy_type type)
+{
+	unsigned long flag;
+	unsigned int ret = -EINVAL;
+	struct sata_phy *x;
+
+	spin_lock_irqsave(&phy_lock, flag);
+
+	if (phy) {
+
+		list_for_each_entry(x, &phy_list, head) {
+			if (x->type == type) {
+				dev_err(phy->dev, "transceiver type already exists\n");
+				goto out;
+			}
+		}
+		phy->type = type;
+		list_add_tail(&phy->head, &phy_list);
+		ret = 0;
+	}
+
+ out:
+	spin_unlock_irqrestore(&phy_lock, flag);
+	return ret;
+}
+EXPORT_SYMBOL(sata_add_phy);
+
+void sata_remove_phy(struct sata_phy *phy)
+{
+	unsigned long flag;
+	struct sata_phy *x;
+
+	spin_lock_irqsave(&phy_lock, flag);
+
+	if (phy) {
+		list_for_each_entry(x, &phy_list, head) {
+			if (x->type == phy->type)
+				list_del(&phy->head);
+		}
+	}
+
+	spin_unlock_irqrestore(&phy_lock, flag);
+}
+EXPORT_SYMBOL(sata_remove_phy);
+
+void sata_put_phy(struct sata_phy *phy)
+{
+	unsigned long flag;
+
+	spin_lock_irqsave(&phy_lock, flag);
+
+	if (phy)
+		put_device(phy->dev);
+
+	spin_unlock_irqrestore(&phy_lock, flag);
+
+}
+EXPORT_SYMBOL(sata_put_phy);
diff --git a/drivers/ata/sata_phy.h b/drivers/ata/sata_phy.h
new file mode 100644
index 0000000..dc38683
--- /dev/null
+++ b/drivers/ata/sata_phy.h
@@ -0,0 +1,44 @@
+/*
+ * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
+ *              http://www.samsung.com
+ *
+ * EXYNOS - SATA utility framework definitions.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+enum sata_phy_type {
+	SATA_PHY_GENERATION1,
+	SATA_PHY_GENERATION2,
+	SATA_PHY_GENERATION3,
+};
+
+struct sata_phy {
+	int (*init) (struct sata_phy *);
+	int (*shutdown) (struct sata_phy *);
+	struct device *dev;
+	void *priv_data;
+	enum sata_phy_type type;
+	struct list_head head;
+};
+
+static inline int sata_init_phy(struct sata_phy *x)
+{
+	if (x && x->init)
+		return x->init(x);
+
+	return -EINVAL;
+}
+
+static inline void sata_shutdown_phy(struct sata_phy *x)
+{
+	if (x && x->shutdown)
+		x->shutdown(x);
+}
+
+struct sata_phy *sata_get_phy(enum sata_phy_type);
+int sata_add_phy(struct sata_phy *, enum sata_phy_type);
+void sata_remove_phy(struct sata_phy *);
+void sata_put_phy(struct sata_phy *);
-- 
1.7.5.4

