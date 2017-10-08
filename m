From: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Subject: [PATCH 2/2] ata: ahci_sunxi: add support for R40 SATA controller
Date: Sun,  8 Oct 2017 12:35:41 +0800
Message-ID: <20171008043541.48564-2-icenowy@aosc.io>
References: <20171008043541.48564-1-icenowy@aosc.io>
Reply-To: icenowy-h8G6r0blFSE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDS6XAN6ZADRBTGW43HAKGQESVWOPDQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20171008043541.48564-1-icenowy-h8G6r0blFSE@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Allwinner R40 SoC has an AHCI SATA controller like the one in A10/A20,
but with a reset control and two dedicated VDD pins for this controller
(one 1.2v and one 2.5v).

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
---
 drivers/ata/ahci_sunxi.c | 118 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 115 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index b26437430163..a650fd6508be 100644
--- a/drivers/ata/ahci_sunxi.c
+++ b/drivers/ata/ahci_sunxi.c
@@ -25,6 +25,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include "ahci.h"
 
 #define DRV_NAME "ahci-sunxi"
@@ -58,6 +59,19 @@ MODULE_PARM_DESC(enable_pmp,
 #define AHCI_P0PHYCR	0x0178
 #define AHCI_P0PHYSR	0x017c
 
+struct ahci_sunxi_quirks {
+	bool has_reset;
+	bool has_vdd1v2;
+	bool has_vdd2v5;
+};
+
+struct ahci_sunxi_data {
+	const struct ahci_sunxi_quirks *quirks;
+	struct reset_control *reset;
+	struct regulator *vdd1v2;
+	struct regulator *vdd2v5;
+};
+
 static void sunxi_clrbits(void __iomem *reg, u32 clr_val)
 {
 	u32 reg_val;
@@ -179,17 +193,69 @@ static int ahci_sunxi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
+	struct ahci_sunxi_data *data;
 	int rc;
 
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->quirks = of_device_get_match_data(dev);
+	if (!data->quirks)
+		return -EINVAL;
+
+	if (data->quirks->has_reset) {
+		data->reset = devm_reset_control_get(dev, NULL);
+		if (IS_ERR(data->reset)) {
+			dev_err(dev, "Failed to get reset\n");
+			return PTR_ERR(data->reset);
+		}
+	}
+
+	if (data->quirks->has_vdd1v2) {
+		data->vdd1v2 = devm_regulator_get(dev, "vdd1v2");
+		if (IS_ERR(data->vdd1v2)) {
+			dev_err(dev, "Failed to get 1.2v VDD regulator\n");
+			return PTR_ERR(data->vdd1v2);
+		}
+	}
+
+	if (data->quirks->has_vdd2v5) {
+		data->vdd2v5 = devm_regulator_get(dev, "vdd2v5");
+		if (IS_ERR(data->vdd2v5)) {
+			dev_err(dev, "Failed to get 2.5v VDD regulator\n");
+			return PTR_ERR(data->vdd2v5);
+		}
+	}
+
 	hpriv = ahci_platform_get_resources(pdev);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
+	hpriv->plat_data = data;
 	hpriv->start_engine = ahci_sunxi_start_engine;
 
+	if (data->quirks->has_vdd1v2) {
+		rc = regulator_enable(data->vdd1v2);
+		if (rc)
+			return rc;
+	}
+
+	if (data->quirks->has_vdd2v5) {
+		rc = regulator_enable(data->vdd2v5);
+		if (rc)
+			goto disable_vdd1v2;
+	}
+
+	if (data->quirks->has_reset) {
+		rc = reset_control_deassert(data->reset);
+		if (rc)
+			goto disable_vdd2v5;
+	}
+
 	rc = ahci_platform_enable_resources(hpriv);
 	if (rc)
-		return rc;
+		goto assert_reset;
 
 	rc = ahci_sunxi_phy_init(dev, hpriv->mmio);
 	if (rc)
@@ -215,6 +281,35 @@ static int ahci_sunxi_probe(struct platform_device *pdev)
 
 disable_resources:
 	ahci_platform_disable_resources(hpriv);
+assert_reset:
+	if (data->quirks->has_reset)
+		reset_control_assert(data->reset);
+disable_vdd2v5:
+	if (data->quirks->has_vdd2v5)
+		regulator_disable(data->vdd2v5);
+disable_vdd1v2:
+	if (data->quirks->has_vdd1v2)
+		regulator_disable(data->vdd1v2);
+	return rc;
+}
+
+static int ahci_sunxi_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
+	struct ahci_sunxi_data *data = hpriv->plat_data;
+	int rc;
+
+	rc = ata_platform_remove_one(pdev);
+
+	if (data->quirks->has_reset)
+		reset_control_assert(data->reset);
+	if (data->quirks->has_vdd2v5)
+		regulator_disable(data->vdd2v5);
+	if (data->quirks->has_vdd1v2)
+		regulator_disable(data->vdd1v2);
+
 	return rc;
 }
 
@@ -248,15 +343,32 @@ static int ahci_sunxi_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(ahci_sunxi_pm_ops, ahci_platform_suspend,
 			 ahci_sunxi_resume);
 
+static const struct ahci_sunxi_quirks sun4i_a10_ahci_quirks = {
+	/* Nothing special */
+};
+
+static const struct ahci_sunxi_quirks sun8i_r40_ahci_quirks = {
+	.has_reset = true,
+	.has_vdd1v2 = true,
+	.has_vdd2v5 = true,
+};
+
 static const struct of_device_id ahci_sunxi_of_match[] = {
-	{ .compatible = "allwinner,sun4i-a10-ahci", },
+	{
+		.compatible = "allwinner,sun4i-a10-ahci",
+		.data = &sun4i_a10_ahci_quirks,
+	},
+	{
+		.compatible = "allwinner,sun8i-r40-ahci",
+		.data = &sun8i_r40_ahci_quirks,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ahci_sunxi_of_match);
 
 static struct platform_driver ahci_sunxi_driver = {
 	.probe = ahci_sunxi_probe,
-	.remove = ata_platform_remove_one,
+	.remove = ahci_sunxi_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = ahci_sunxi_of_match,
-- 
2.13.6
