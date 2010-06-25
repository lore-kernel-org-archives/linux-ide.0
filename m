From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH] ahci_platform: Provide for vendor specific init
Date: Fri, 25 Jun 2010 13:57:38 +0900
Message-ID: <1277441858-26993-1-git-send-email-jassisinghbrar@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:39935 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab0FYFBi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jun 2010 01:01:38 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, avorontsov@ru.mvista.com, Jassi Brar <jassi.brar@samsung.com>

From: Jassi Brar <jassi.brar@samsung.com>

Some AHCI implementations may use Vendor Specific HBA[A0h, FFh]
and/or Port[70h, 7Fh] registers to 'prepare' for initialization.
For that, the platform needs memory mapped address of AHCI registers.

This patch adds the 'mmio' argument and reorders the call to
platform init function.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 drivers/ata/ahci_platform.c   |   23 +++++++++++++----------
 include/linux/ahci_platform.h |    2 +-
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 5e11b16..4403941 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -54,19 +54,13 @@ static int __init ahci_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	if (pdata && pdata->init) {
-		rc = pdata->init(dev);
-		if (rc)
-			return rc;
-	}
-
 	if (pdata && pdata->ata_port_info)
 		pi = *pdata->ata_port_info;
 
 	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
 	if (!hpriv) {
-		rc = -ENOMEM;
-		goto err0;
+		dev_err(dev, "can't alloc ahci_host_priv\n");
+		return -ENOMEM;
 	}
 
 	hpriv->flags |= (unsigned long)pi.private_data;
@@ -74,8 +68,17 @@ static int __init ahci_probe(struct platform_device *pdev)
 	hpriv->mmio = devm_ioremap(dev, mem->start, resource_size(mem));
 	if (!hpriv->mmio) {
 		dev_err(dev, "can't map %pR\n", mem);
-		rc = -ENOMEM;
-		goto err0;
+		devm_kfree(dev, hpriv);
+		return -ENOMEM;
+	}
+
+	if (pdata && pdata->init) {
+		rc = pdata->init(dev, hpriv->mmio);
+		if (rc) {
+			devm_iounmap(dev, hpriv->mmio);
+			devm_kfree(dev, hpriv);
+			return rc;
+		}
 	}
 
 	ahci_save_initial_config(dev, hpriv,
diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
index f7dd576..f7ffc4c 100644
--- a/include/linux/ahci_platform.h
+++ b/include/linux/ahci_platform.h
@@ -19,7 +19,7 @@ struct device;
 struct ata_port_info;
 
 struct ahci_platform_data {
-	int (*init)(struct device *dev);
+	int (*init)(struct device *dev, void __iomem *addr);
 	void (*exit)(struct device *dev);
 	const struct ata_port_info *ata_port_info;
 	unsigned int force_port_map;
-- 
1.6.2.5

