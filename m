From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH V2 2/2] ahci: add support for Hisilicon sata
Date: Thu, 10 Apr 2014 13:24:28 +0800
Message-ID: <1397107468-640-3-git-send-email-wangkefeng.wang@huawei.com>
References: <1397107468-640-1-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397107468-640-1-git-send-email-wangkefeng.wang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, guohanjun@huawei.com, Kefeng Wang <kefeng.wang@linaro.org>
List-Id: linux-ide@vger.kernel.org

From: Kefeng Wang <kefeng.wang@linaro.org>

The hip04 SoC of hisilicon has an AHCI compliant SATA controller,
and it is compliant with the ahci 1.3 and sata 3.0 specification.

There is a wrong bit in HOST_CAP of hip04 sata controller, which
enable unsupported feature of FBS, use AHCI_HFLAG_NO_FBS hflag to
disable it.

Cc: Hans de Geode <hdegoede@redhat.com>
Signed-off-by: Kefeng Wang <kefeng.wang@linaro.org>
---
 .../devicetree/bindings/ata/ahci-platform.txt      |    3 ++-
 drivers/ata/ahci_platform.c                        |    6 +++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 48b285f..aab1d70 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -7,7 +7,8 @@ Required properties:
 - compatible        : compatible list, one of "snps,spear-ahci",
                       "snps,exynos5440-ahci", "ibm,476gtr-ahci",
                       "allwinner,sun4i-a10-ahci", "fsl,imx53-ahci"
-                      "fsl,imx6q-ahci" or "snps,dwc-ahci"
+                      "fsl,imx6q-ahci", "snps,dwc-ahci" or
+                      "hisilicon,hisi-ahci"
 - interrupts        : <interrupt mapping for SATA IRQ>
 - reg               : <registers mapping>
 
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index ef67e79..2ee1923 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -32,6 +32,7 @@ static int ahci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ahci_platform_data *pdata = dev_get_platdata(dev);
+	struct ata_port_info pi = ahci_port_info;
 	struct ahci_host_priv *hpriv;
 	int rc;
 
@@ -54,8 +55,10 @@ static int ahci_probe(struct platform_device *pdev)
 		if (rc)
 			goto disable_resources;
 	}
+	if (of_device_is_compatible(pdev->dev.of_node, "hisilicon,hisi-ahci"))
+		pi.private_data = (void *)AHCI_HFLAG_NO_FBS;
 
-	rc = ahci_platform_init_host(pdev, hpriv, &ahci_port_info, 0, 0);
+	rc = ahci_platform_init_host(pdev, hpriv, &pi, 0, 0);
 	if (rc)
 		goto pdata_exit;
 
@@ -76,6 +79,7 @@ static const struct of_device_id ahci_of_match[] = {
 	{ .compatible = "snps,exynos5440-ahci", },
 	{ .compatible = "ibm,476gtr-ahci", },
 	{ .compatible = "snps,dwc-ahci", },
+	{ .compatible = "hisilicon,hisi-ahci", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_of_match);
-- 
1.7.1
