From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: failures due to "libata: disable forced PORTS_IMPL for >= AHCI 1.3
 patch"
Date: Wed, 23 Mar 2016 16:36:26 +0000
Message-ID: <56F2C60A.5070504@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33048 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbcCWQg3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2016 12:36:29 -0400
Received: by mail-wm0-f53.google.com with SMTP id l68so241485364wml.0
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2016 09:36:29 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, hdegoede@redhat.com, mikpelinux@gmail.com

Hi Tejun,

Its bit late but just found that commit 566d18 "libata: disable forced 
PORTS_IMPL for >= AHCI 1.3" is breaking AHCI on Qualcomm APQ8064 
platforms in the mainline kernel (arch/arm/boot/dts/qcom-apq8064.dtsi).

This platform uses "generic-ahci" platform driver and reports AHCI 
version as 0x10300, and PORTS_IMPL is never set, so the existing 
workaround was correct for this platform, however the latest patch 
broken this.

There are few ways to fix this issue,

1> Add new compatible string to achi_platform driver so that this 
platform can force the port_map,

Or

2> Have a generic dt binding to force the port map.

I would like to know if you have plans to fix this in any other better 
way? Below patch fixes issue for me, will split the patches once we 
agree if this is the correct direction to fix it.

--------------------------->cut<--------------------------
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 4044233..b5cf9b1 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -51,6 +51,9 @@ static int ahci_probe(struct platform_device *pdev)
         if (rc)
                 return rc;

+       if (of_device_is_compatible(dev->of_node, "qcom,apq8064-ahci"))
+               hpriv->force_port_map = 1;
+
         if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
                 hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;

@@ -72,6 +75,7 @@ static const struct of_device_id ahci_of_match[] = {
         { .compatible = "generic-ahci", },
         /* Keep the following compatibles for device tree compatibility */
         { .compatible = "snps,spear-ahci", },
+       { .compatible = "qcom,apq8064-ahci", },
         { .compatible = "snps,exynos5440-ahci", },
         { .compatible = "ibm,476gtr-ahci", },
         { .compatible = "snps,dwc-ahci", },
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 3982054..a5d7c1c 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -507,6 +507,7 @@ void ahci_save_initial_config(struct device *dev, 
struct ahci_host_priv *hpriv)
                 dev_info(dev, "forcing port_map 0x%x -> 0x%x\n",
                          port_map, hpriv->force_port_map);
                 port_map = hpriv->force_port_map;
+               hpriv->saved_port_map = port_map;
         }

         if (hpriv->mask_port_map) {
--------------------------->cut<--------------------------

Thanks,
srini
