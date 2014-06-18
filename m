From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH RFC 2/2] ahci: remove AHCI_HFLAG_NO_FBS setting
Date: Wed, 18 Jun 2014 15:15:37 +0800
Message-ID: <1403075737-19853-1-git-send-email-zhangfei.gao@linaro.org>
References: <1403067249-8021-3-git-send-email-zhangfei.gao@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:59065 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756399AbaFRHPq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jun 2014 03:15:46 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so445678pab.1
        for <linux-ide@vger.kernel.org>; Wed, 18 Jun 2014 00:15:46 -0700 (PDT)
In-Reply-To: <1403067249-8021-3-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, hdegoede@redhat.com, arnd@arndb.de, mark.rutland@arm.com, xuwei5@hisilicon.com, kefeng.wang@linaro.org
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>

AHCI_HFLAG can be set directly in dts.

For example
ahci:sata@f9900000 {
	no-fbs;
	no-ncq;
};

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/ata/ahci_platform.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index ebe505c17763..c29fa4a553f4 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -34,7 +34,6 @@ static int ahci_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ahci_platform_data *pdata = dev_get_platdata(dev);
 	struct ahci_host_priv *hpriv;
-	unsigned long hflags = 0;
 	int rc;
 
 	hpriv = ahci_platform_get_resources(pdev);
@@ -57,11 +56,7 @@ static int ahci_probe(struct platform_device *pdev)
 			goto disable_resources;
 	}
 
-	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
-		hflags |= AHCI_HFLAG_NO_FBS;
-
-	rc = ahci_platform_init_host(pdev, hpriv, &ahci_port_info,
-				     hflags, 0, 0);
+	rc = ahci_platform_init_host(pdev, hpriv, &ahci_port_info, 0, 0, 0);
 	if (rc)
 		goto pdata_exit;
 
-- 
1.7.9.5

