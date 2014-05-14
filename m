From: Kefeng Wang <kefeng.wang@linaro.org>
Subject: [PATCH v7 3/3] ahci: add support for Hisilicon sata
Date: Wed, 14 May 2014 14:13:42 +0800
Message-ID: <1400048022-15795-4-git-send-email-kefeng.wang@linaro.org>
References: <1400048022-15795-1-git-send-email-kefeng.wang@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:56737 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754085AbaENGPE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 May 2014 02:15:04 -0400
Received: by mail-pa0-f47.google.com with SMTP id lf10so1258280pab.34
        for <linux-ide@vger.kernel.org>; Tue, 13 May 2014 23:15:04 -0700 (PDT)
In-Reply-To: <1400048022-15795-1-git-send-email-kefeng.wang@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: hdegoede@redhat.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com, xuwei5@hisilicon.com, kefeng.wang@linaro.org

The hip04 SoC of hisilicon has an AHCI compliant SATA controller,
and it is compliant with the ahci 1.3 and sata 3.0 specification.

There is a wrong bit in HOST_CAP of hip04 sata controller, which
enable unsupported feature of FBS, use AHCI_HFLAG_NO_FBS hflag to
disable it.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Kefeng Wang <kefeng.wang@linaro.org>
---
 .../devicetree/bindings/ata/ahci-platform.txt      |    1 +
 drivers/ata/ahci_platform.c                        |    9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index d6b07e8..c96d8dc 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -8,6 +8,7 @@ Required properties:
   - "allwinner,sun4i-a10-ahci"
   - "fsl,imx53-ahci"
   - "fsl,imx6q-ahci"
+  - "hisilicon,hisi-ahci"
   - "ibm,476gtr-ahci"
   - "marvell,armada-380-ahci"
   - "snps,dwc-ahci"
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index a476a1f..ebe505c 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/device.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/libata.h>
 #include <linux/ahci_platform.h>
@@ -33,6 +34,7 @@ static int ahci_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ahci_platform_data *pdata = dev_get_platdata(dev);
 	struct ahci_host_priv *hpriv;
+	unsigned long hflags = 0;
 	int rc;
 
 	hpriv = ahci_platform_get_resources(pdev);
@@ -55,7 +57,11 @@ static int ahci_probe(struct platform_device *pdev)
 			goto disable_resources;
 	}
 
-	rc = ahci_platform_init_host(pdev, hpriv, &ahci_port_info, 0, 0, 0);
+	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
+		hflags |= AHCI_HFLAG_NO_FBS;
+
+	rc = ahci_platform_init_host(pdev, hpriv, &ahci_port_info,
+				     hflags, 0, 0);
 	if (rc)
 		goto pdata_exit;
 
@@ -76,6 +82,7 @@ static const struct of_device_id ahci_of_match[] = {
 	{ .compatible = "snps,exynos5440-ahci", },
 	{ .compatible = "ibm,476gtr-ahci", },
 	{ .compatible = "snps,dwc-ahci", },
+	{ .compatible = "hisilicon,hisi-ahci", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_of_match);
-- 
1.7.9.5

