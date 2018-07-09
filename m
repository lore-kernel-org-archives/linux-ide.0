From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 2/4] ata: ahci_sunxi: add support for R40 SATA controller
Date: Mon,  9 Jul 2018 15:20:56 +0000
Message-ID: <1531149658-27030-3-git-send-email-clabbe@baylibre.com>
References: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux@armlinux.org.uk, mark.rutland@arm.com, maxime.ripard@free-electrons.com, robh+dt@kernel.org, tj@kernel.org, wens@csie.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-sunxi@googlegroups.com, Corentin Labbe <clabbe@baylibre.com>, linux-arm-kernel@lists.infradead.org, icenowy@aosc.io
List-Id: linux-ide@vger.kernel.org

Allwinner R40 SoC has an AHCI SATA controller like the one in A10/A20,
but with a reset control and two dedicated VDD pins for this controller
(one 1.2v and one 2.5v).

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/ata/ahci_sunxi.c | 124 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 121 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index b26437430163..8b1bc04c0435 100644
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
 
+struct ahci_sunxi_variant {
+	bool has_reset;
+	bool has_vdd1v2;
+	bool has_vdd2v5;
+};
+
+struct ahci_sunxi_data {
+	const struct ahci_sunxi_variant *variant;
+	struct reset_control *reset;
+	struct regulator *vdd1v2;
+	struct regulator *vdd2v5;
+};
+
 static void sunxi_clrbits(void __iomem *reg, u32 clr_val)
 {
 	u32 reg_val;
@@ -179,17 +193,75 @@ static int ahci_sunxi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
+	struct ahci_sunxi_data *data;
 	int rc;
 
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->variant = of_device_get_match_data(dev);
+	if (!data->variant)
+		return -EINVAL;
+
+	if (data->variant->has_reset) {
+		data->reset = devm_reset_control_get(dev, NULL);
+		if (IS_ERR(data->reset)) {
+			dev_err(dev, "Failed to get reset\n");
+			return PTR_ERR(data->reset);
+		}
+	}
+
+	if (data->variant->has_vdd1v2) {
+		data->vdd1v2 = devm_regulator_get(dev, "vdd1v2");
+		if (IS_ERR(data->vdd1v2)) {
+			rc = PTR_ERR(data->vdd1v2);
+			if (rc == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+			dev_err(dev, "Failed to get 1.2v VDD regulator\n");
+			return rc;
+		}
+	}
+
+	if (data->variant->has_vdd2v5) {
+		data->vdd2v5 = devm_regulator_get(dev, "vdd2v5");
+		if (IS_ERR(data->vdd2v5)) {
+			rc = PTR_ERR(data->vdd2v5);
+			if (rc == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+			dev_err(dev, "Failed to get 2.5v VDD regulator\n");
+			return rc;
+		}
+	}
+
 	hpriv = ahci_platform_get_resources(pdev);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
+	hpriv->plat_data = data;
 	hpriv->start_engine = ahci_sunxi_start_engine;
 
+	if (data->variant->has_vdd1v2) {
+		rc = regulator_enable(data->vdd1v2);
+		if (rc)
+			return rc;
+	}
+
+	if (data->variant->has_vdd2v5) {
+		rc = regulator_enable(data->vdd2v5);
+		if (rc)
+			goto disable_vdd1v2;
+	}
+
+	if (data->variant->has_reset) {
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
@@ -215,6 +287,35 @@ static int ahci_sunxi_probe(struct platform_device *pdev)
 
 disable_resources:
 	ahci_platform_disable_resources(hpriv);
+assert_reset:
+	if (data->variant->has_reset)
+		reset_control_assert(data->reset);
+disable_vdd2v5:
+	if (data->variant->has_vdd2v5)
+		regulator_disable(data->vdd2v5);
+disable_vdd1v2:
+	if (data->variant->has_vdd1v2)
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
+	if (data->variant->has_reset)
+		reset_control_assert(data->reset);
+	if (data->variant->has_vdd2v5)
+		regulator_disable(data->vdd2v5);
+	if (data->variant->has_vdd1v2)
+		regulator_disable(data->vdd1v2);
+
 	return rc;
 }
 
@@ -248,15 +349,32 @@ static int ahci_sunxi_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(ahci_sunxi_pm_ops, ahci_platform_suspend,
 			 ahci_sunxi_resume);
 
+static const struct ahci_sunxi_variant sun4i_a10_ahci_variant = {
+	/* Nothing special */
+};
+
+static const struct ahci_sunxi_variant sun8i_r40_ahci_variant = {
+	.has_reset = true,
+	.has_vdd1v2 = true,
+	.has_vdd2v5 = true,
+};
+
 static const struct of_device_id ahci_sunxi_of_match[] = {
-	{ .compatible = "allwinner,sun4i-a10-ahci", },
+	{
+		.compatible = "allwinner,sun4i-a10-ahci",
+		.data = &sun4i_a10_ahci_variant,
+	},
+	{
+		.compatible = "allwinner,sun8i-r40-ahci",
+		.data = &sun8i_r40_ahci_variant,
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
2.16.4
