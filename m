From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH RFC 1/2] libahci_platform: add ahci_platform_get_of_property
Date: Wed, 18 Jun 2014 12:54:08 +0800
Message-ID: <1403067249-8021-2-git-send-email-zhangfei.gao@linaro.org>
References: <xuwei5@hisilicon.com, kefeng.wang@linaro.org,>
 <1403067249-8021-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:56758 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756616AbaFREyW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jun 2014 00:54:22 -0400
Received: by mail-pa0-f52.google.com with SMTP id eu11so315304pac.39
        for <linux-ide@vger.kernel.org>; Tue, 17 Jun 2014 21:54:22 -0700 (PDT)
In-Reply-To: <1403067249-8021-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, hdegoede@redhat.com, arnd@arndb.de, mark.rutland@arm.com
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>

Instead of setting hflags in different files,
ahci_platform_get_of_property set hpriv->flags when ahci_platform_init_host
according to property in dts.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 .../devicetree/bindings/ata/ahci-platform.txt      |    9 +++++
 drivers/ata/libahci_platform.c                     |   39 ++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index c96d8dcf98fd..c0b9f6e76ba4 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -26,6 +26,15 @@ Optional properties:
 - clocks            : must contain the sata, sata_ref and ahb clocks
 - clock-names       : must contain "ahb" for the ahb clock
 
+- no-ncq: when present, controller can't do NCQ, turning off CAP_NCQ
+- 32bit-only: when present, controller can't do 64bit DMA, forcing 32bit
+- no-msi: when present, no PCI MSI
+- no-pmp: when present, controller can't do PMP, turning off CAP_PMP
+- yes-ncq: when present,controller can do NCQ, turning on CAP_NCQ
+- no-suspend: when present, controller can't do suspend
+- yes-fbs: when present, controller can do FBS, turning on CAP_FBS
+- no-fbs: when present, controller can't do FBS, turning off CAP_FBS
+
 Examples:
         sata@ffe08000 {
 		compatible = "snps,spear-ahci";
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 3a5b4ed25a4f..880b9f360056 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -278,6 +278,44 @@ err_out:
 }
 EXPORT_SYMBOL_GPL(ahci_platform_get_resources);
 
+#ifdef CONFIG_OF
+static void ahci_platform_get_of_property(struct platform_device *pdev,
+					  struct ahci_host_priv *hpriv)
+{
+	struct device_node *np = pdev->dev.of_node;
+
+	if (of_device_is_available(np)) {
+		if (of_get_property(np, "no-ncq", NULL))
+			hpriv->flags |= AHCI_HFLAG_NO_NCQ;
+
+		if (of_get_property(np, "32bit-only", NULL))
+			hpriv->flags |= AHCI_HFLAG_32BIT_ONLY;
+
+		if (of_get_property(np, "no-msi", NULL))
+			hpriv->flags |= AHCI_HFLAG_NO_MSI;
+
+		if (of_get_property(np, "no-pmp", NULL))
+			hpriv->flags |= AHCI_HFLAG_NO_PMP;
+
+		if (of_get_property(np, "yes-ncq", NULL))
+			hpriv->flags |= AHCI_HFLAG_YES_NCQ;
+
+		if (of_get_property(np, "no-suspend", NULL))
+			hpriv->flags |= AHCI_HFLAG_NO_SUSPEND;
+
+		if (of_get_property(np, "yes-fbs", NULL))
+			hpriv->flags |= AHCI_HFLAG_YES_FBS;
+
+		if (of_get_property(np, "no-fbs", NULL))
+			hpriv->flags |= AHCI_HFLAG_NO_FBS;
+	}
+}
+#else
+static void ahci_platform_get_of_property(struct platform_device *pdev,
+					  struct ahci_host_priv *hpriv)
+{}
+#endif /* CONFIG_OF */
+
 /**
  * ahci_platform_init_host - Bring up an ahci-platform host
  * @pdev: platform device pointer for the host
@@ -316,6 +354,7 @@ int ahci_platform_init_host(struct platform_device *pdev,
 	/* prepare host */
 	pi.private_data = (void *)host_flags;
 	hpriv->flags |= host_flags;
+	ahci_platform_get_of_property(pdev, hpriv);
 
 	ahci_save_initial_config(dev, hpriv, force_port_map, mask_port_map);
 
-- 
1.7.9.5

