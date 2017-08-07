From: Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 1/2] ata: mediatek: add support for MediaTek SATA controller
Date: Mon, 7 Aug 2017 17:52:20 +0800
Message-ID: <7859e9ed333ab2803ac21c0178a78e448e7d87aa.1502098458.git.ryder.lee@mediatek.com>
References: <cover.1502098458.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <cover.1502098458.git.ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Long Cheng <long.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-ide@vger.kernel.org

This adds support the AHCI-compliant Serial ATA controller present
on MediaTek SoCs.

Signed-off-by: Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/ata/Kconfig    |  10 +++
 drivers/ata/Makefile   |   1 +
 drivers/ata/ahci_mtk.c | 196 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 207 insertions(+)
 create mode 100644 drivers/ata/ahci_mtk.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 363fc53..488c937 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -153,6 +153,16 @@ config AHCI_CEVA
 
 	  If unsure, say N.
 
+config AHCI_MTK
+	tristate "MediaTek AHCI SATA support"
+	depends on ARCH_MEDIATEK
+	select MFD_SYSCON
+	help
+	  This option enables support for the MediaTek SoC's
+	  onboard AHCI SATA controller.
+
+	  If unsure, say N.
+
 config AHCI_MVEBU
 	tristate "Marvell EBU AHCI SATA support"
 	depends on ARCH_MVEBU
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index a26ef5a..ff9cd2e 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_AHCI_CEVA)		+= ahci_ceva.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_DA850)	+= ahci_da850.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_DM816)	+= ahci_dm816.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_IMX)		+= ahci_imx.o libahci.o libahci_platform.o
+obj-$(CONFIG_AHCI_MTK)		+= ahci_mtk.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_MVEBU)	+= ahci_mvebu.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_OCTEON)	+= ahci_octeon.o
 obj-$(CONFIG_AHCI_SUNXI)	+= ahci_sunxi.o libahci.o libahci_platform.o
diff --git a/drivers/ata/ahci_mtk.c b/drivers/ata/ahci_mtk.c
new file mode 100644
index 0000000..5bd3046
--- /dev/null
+++ b/drivers/ata/ahci_mtk.c
@@ -0,0 +1,196 @@
+/*
+ * MeidaTek AHCI SATA driver
+ *
+ * Copyright (c) 2017 MediaTek Inc.
+ * Author: Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/ahci_platform.h>
+#include <linux/kernel.h>
+#include <linux/libata.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include "ahci.h"
+
+#define DRV_NAME		"ahci"
+
+#define SYS_CFG			0x14
+#define SYS_CFG_SATA_MSK	GENMASK(31, 30)
+#define SYS_CFG_SATA_EN		BIT(31)
+
+struct mtk_ahci_plat {
+	struct regmap *mode;
+	struct reset_control *axi_rst;
+	struct reset_control *sw_rst;
+	struct reset_control *reg_rst;
+};
+
+static const struct ata_port_info ahci_port_info = {
+	.flags		= AHCI_FLAG_COMMON,
+	.pio_mask	= ATA_PIO4,
+	.udma_mask	= ATA_UDMA6,
+	.port_ops	= &ahci_platform_ops,
+};
+
+static struct scsi_host_template ahci_platform_sht = {
+	AHCI_SHT(DRV_NAME),
+};
+
+static int mtk_ahci_platform_resets(struct ahci_host_priv *hpriv,
+				    struct device *dev)
+{
+	struct mtk_ahci_plat *plat = hpriv->plat_data;
+	int err;
+
+	/* reset AXI bus and PHY part */
+	plat->axi_rst = devm_reset_control_get_optional_exclusive(dev, "axi");
+	if (PTR_ERR(plat->axi_rst) == -EPROBE_DEFER)
+		return PTR_ERR(plat->axi_rst);
+
+	plat->sw_rst = devm_reset_control_get_optional_exclusive(dev, "sw");
+	if (PTR_ERR(plat->sw_rst) == -EPROBE_DEFER)
+		return PTR_ERR(plat->sw_rst);
+
+	plat->reg_rst = devm_reset_control_get_optional_exclusive(dev, "reg");
+	if (PTR_ERR(plat->reg_rst) == -EPROBE_DEFER)
+		return PTR_ERR(plat->reg_rst);
+
+	err = reset_control_assert(plat->axi_rst);
+	if (err) {
+		dev_err(dev, "assert axi bus failed\n");
+		return err;
+	}
+
+	err = reset_control_assert(plat->sw_rst);
+	if (err) {
+		dev_err(dev, "assert phy digital part failed\n");
+		return err;
+	}
+
+	err = reset_control_assert(plat->reg_rst);
+	if (err) {
+		dev_err(dev, "assert phy register part failed\n");
+		return err;
+	}
+
+	err = reset_control_deassert(plat->reg_rst);
+	if (err) {
+		dev_err(dev, "deassert phy register part failed\n");
+		return err;
+	}
+
+	err = reset_control_deassert(plat->sw_rst);
+	if (err) {
+		dev_err(dev, "deassert phy digital part failed\n");
+		return err;
+	}
+
+	err = reset_control_deassert(plat->axi_rst);
+	if (err) {
+		dev_err(dev, "deassert axi bus failed\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static int mtk_ahci_parse_property(struct ahci_host_priv *hpriv,
+				   struct device *dev)
+{
+	struct mtk_ahci_plat *plat = hpriv->plat_data;
+	struct device_node *np = dev->of_node;
+
+	/* enable SATA function if needed */
+	if (of_find_property(np, "mediatek,phy-mode", NULL)) {
+		plat->mode = syscon_regmap_lookup_by_phandle(
+					np, "mediatek,phy-mode");
+		if (IS_ERR(plat->mode)) {
+			dev_err(dev, "missing phy-mode phandle\n");
+			return PTR_ERR(plat->mode);
+		}
+
+		regmap_update_bits(plat->mode, SYS_CFG, SYS_CFG_SATA_MSK,
+				   SYS_CFG_SATA_EN);
+	}
+
+	of_property_read_u32(np, "ports-implemented", &hpriv->force_port_map);
+
+	return 0;
+}
+
+static int mtk_ahci_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mtk_ahci_plat *plat;
+	struct ahci_host_priv *hpriv;
+	int err;
+
+	plat = devm_kzalloc(dev, sizeof(*plat), GFP_KERNEL);
+	if (!plat)
+		return -ENOMEM;
+
+	hpriv = ahci_platform_get_resources(pdev);
+	if (IS_ERR(hpriv))
+		return PTR_ERR(hpriv);
+
+	hpriv->plat_data = plat;
+
+	err = mtk_ahci_parse_property(hpriv, dev);
+	if (err)
+		return err;
+
+	err = mtk_ahci_platform_resets(hpriv, dev);
+	if (err)
+		return err;
+
+	err = ahci_platform_enable_resources(hpriv);
+	if (err)
+		return err;
+
+	err = ahci_platform_init_host(pdev, hpriv, &ahci_port_info,
+				      &ahci_platform_sht);
+	if (err)
+		goto disable_resources;
+
+	return 0;
+
+disable_resources:
+	ahci_platform_disable_resources(hpriv);
+	return err;
+}
+
+static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
+			 ahci_platform_resume);
+
+static const struct of_device_id ahci_of_match[] = {
+	{ .compatible = "mediatek,ahci", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ahci_of_match);
+
+static struct platform_driver mtk_ahci_driver = {
+	.probe = mtk_ahci_probe,
+	.remove = ata_platform_remove_one,
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table = ahci_of_match,
+		.pm = &ahci_pm_ops,
+	},
+};
+module_platform_driver(mtk_ahci_driver);
+
+MODULE_DESCRIPTION("MeidaTek SATA AHCI Driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
