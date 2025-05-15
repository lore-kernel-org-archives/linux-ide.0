Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A20020E002;
	Thu, 15 May 2025 09:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747299638; cv=none; b=G67+PgqIoKcw10os5wUq1TLsrp+WPFF+3Xm3o1jB+zys/I3WPDngP1dZY/2fqzyvmgJ9OkdSm8G6EmP8E29t9YpfO3jwJpiuzjZ0Vd0gLTRM9B3zx72i8upC4LVd0pCN45uOANOKfpgn7yMC0Y2ggvHUwAvbv8zWlIR9NI+CQB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747299638; c=relaxed/simple;
	bh=zg3NJ0Lxk8k3Eb0xw/q9U+sVcCG+0oMw0HfuXr/aeaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYr+TkL3fnvj8ftiifWDPBkKcVjR7AJ8m4dskJUv5IDG/PjX90QheVitz+vFK0RK1R5bSfC5pIet5Ha43Ed5VORiBs5gNxlrfegLO2gX70e6hgL+wXVwqej0VIzBhTpYmL58XxqIc/D+mTSFQYjzbov6WZ0rkMg6tot/A86kVd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005154LT.eswin.cn (unknown [10.12.96.103])
	by app2 (Coremail) with SMTP id TQJkCgCXNpUlrSVozz58AA--.26093S2;
	Thu, 15 May 2025 17:00:22 +0800 (CST)
From: hehuan1@eswincomputing.com
To: dlemoal@kernel.org,
	cassel@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	luyulin@eswincomputing.com,
	Huan He <hehuan1@eswincomputing.com>
Subject: [PATCH v1 2/2] sata: eswin: Add eic7700 sata driver
Date: Thu, 15 May 2025 17:00:18 +0800
Message-ID: <20250515090018.1720-1-hehuan1@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250515085114.1692-1-hehuan1@eswincomputing.com>
References: <20250515085114.1692-1-hehuan1@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgCXNpUlrSVozz58AA--.26093S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKF43Jw1UJw1ruryUGFy3Arb_yoWfZFyrpF
	4rCFW8JrWDWF1Ig34Iy3W8AF4akr4DWFy2ka4UGw42vws2yw1YgFsIvF98tryDJr97Gay5
	Xa1qyay3ua1UZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHCJQUUUUU=
X-CM-SenderInfo: 5khk3tzqr6v25zlqu0xpsx3x1qjou0bp/

From: Huan He <hehuan1@eswincomputing.com>

Add support for the AHCI SATA controller in Eswin's eic7700 soc,
which supports SATA PHY initialization, reset control,
and power management.

Co-developed-by: Yulin Lu <luyulin@eswincomputing.com>
Signed-off-by: Yulin Lu <luyulin@eswincomputing.com>
Signed-off-by: Huan He <hehuan1@eswincomputing.com>
---
 drivers/ata/Kconfig        |  12 ++
 drivers/ata/Makefile       |   1 +
 drivers/ata/ahci_eic7700.c | 248 +++++++++++++++++++++++++++++++++++++
 3 files changed, 261 insertions(+)
 create mode 100644 drivers/ata/ahci_eic7700.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index e00536b49552..474c09543006 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -185,6 +185,18 @@ config AHCI_DWC
 
 	  If unsure, say N.
 
+config AHCI_EIC7700
+	tristate "Eswin AHCI SATA support"
+	depends on ARCH_ESWIN || COMPILE_TEST
+	select SATA_HOST
+	help
+	  This enables the AHCI SATA controller driver for Eswin SoCs. This driver
+	  is specific to Eswin SoCs and should only be enabled if using such hardware.
+	  The driver supports eic7700 series chips. The controller supports up
+	  to 1 port.
+
+	  If unsure, say N.
+
 config AHCI_ST
 	tristate "ST AHCI SATA support"
 	depends on ARCH_STI || COMPILE_TEST
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 20e6645ab737..af00e55fa593 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_AHCI_CEVA)		+= ahci_ceva.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_DA850)	+= ahci_da850.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_DM816)	+= ahci_dm816.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_DWC)		+= ahci_dwc.o libahci.o libahci_platform.o
+obj-$(CONFIG_AHCI_EIC7700)	+= ahci_eic7700.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_IMX)		+= ahci_imx.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_MTK)		+= ahci_mtk.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_MVEBU)	+= ahci_mvebu.o libahci.o libahci_platform.o
diff --git a/drivers/ata/ahci_eic7700.c b/drivers/ata/ahci_eic7700.c
new file mode 100644
index 000000000000..d2b7cafbfdd7
--- /dev/null
+++ b/drivers/ata/ahci_eic7700.c
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ESWIN EIC7700 AHCI SATA Driver
+ *
+ * Copyright 2024, Beijing ESWIN Computing Technology Co., Ltd.. All rights reserved.
+ *
+ * Authors: Yulin Lu <luyulin@eswincomputing.com>
+ *          Huan He <hehuan1@eswincomputing.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/device.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/libata.h>
+#include <linux/ahci_platform.h>
+#include <linux/acpi.h>
+#include <linux/pci_ids.h>
+#include <linux/iommu.h>
+#include <linux/mfd/syscon.h>
+#include <linux/bitfield.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include "ahci.h"
+
+#define DRV_NAME "ahci"
+
+/* Register Definitions */
+#define SATA_REF_CTRL1                0x338
+#define SATA_PHY_CTRL0                0x328
+#define SATA_PHY_CTRL1                0x32c
+#define SATA_LOS_IDEN                 0x33c
+#define SATA_AXI_LP_CTRL              0x308
+#define SATA_REG_CTRL                 0x334
+#define SATA_MPLL_CTRL                0x320
+#define SATA_RESET_CTRL               0x340
+#define SATA_RESET_CTRL_ASSERT        0x3
+#define SATA_RESET_CTRL_DEASSERT      0x0
+#define SATA_PHY_RESET                BIT(0)
+#define SATA_P0_RESET                 BIT(1)
+#define SATA_LOS_LEVEL                0x9
+#define SATA_LOS_BIAS                 (0x02 << 16)
+#define SATA_REF_REPEATCLK_EN         BIT(0)
+#define SATA_REF_USE_PAD              BIT(20)
+#define SATA_P0_AMPLITUDE_GEN1        0x42
+#define SATA_P0_AMPLITUDE_GEN2        (0x46 << 8)
+#define SATA_P0_AMPLITUDE_GEN3        (0x73 << 16)
+#define SATA_P0_PHY_TX_PREEMPH_GEN1   0x05
+#define SATA_P0_PHY_TX_PREEMPH_GEN2   (0x05 << 8)
+#define SATA_P0_PHY_TX_PREEMPH_GEN3   (0x23 << 16)
+#define SATA_MPLL_MULTIPLIER          (0x3c << 16)
+#define SATA_M_CSYSREQ                BIT(0)
+#define SATA_S_CSYSREQ                BIT(16)
+
+struct eswin_ahci_plat {
+	struct reset_control *apb_rst;
+};
+
+static const struct ata_port_info ahci_port_info = {
+	.flags		= AHCI_FLAG_COMMON,
+	.pio_mask	= ATA_PIO4,
+	.udma_mask	= ATA_UDMA6,
+	.port_ops	= &ahci_platform_ops,
+};
+
+static const struct ata_port_info ahci_port_info_nolpm = {
+	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_LPM,
+	.pio_mask	= ATA_PIO4,
+	.udma_mask	= ATA_UDMA6,
+	.port_ops	= &ahci_platform_ops,
+};
+
+static struct scsi_host_template ahci_platform_sht = {
+	AHCI_SHT(DRV_NAME),
+};
+
+static int eswin_sata_init(struct device *dev)
+{
+	struct regmap *regmap;
+
+	regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "eswin,hsp_sp_csr");
+	if (IS_ERR(regmap)) {
+		dev_dbg(dev, "No hsp_sp_csr phandle specified\n");
+		return -1;
+	}
+
+	regmap_write(regmap, SATA_REF_CTRL1, 0x1);
+	regmap_write(regmap, SATA_PHY_CTRL0, (SATA_P0_AMPLITUDE_GEN1 |
+						 SATA_P0_AMPLITUDE_GEN2 |
+						 SATA_P0_AMPLITUDE_GEN3));
+	regmap_write(regmap, SATA_PHY_CTRL1, (SATA_P0_PHY_TX_PREEMPH_GEN1 |
+						 SATA_P0_PHY_TX_PREEMPH_GEN2 |
+						 SATA_P0_PHY_TX_PREEMPH_GEN3));
+	regmap_write(regmap, SATA_LOS_IDEN, SATA_LOS_LEVEL | SATA_LOS_BIAS);
+	regmap_write(regmap, SATA_AXI_LP_CTRL, SATA_M_CSYSREQ | SATA_S_CSYSREQ);
+	regmap_write(regmap, SATA_REG_CTRL, SATA_REF_REPEATCLK_EN | SATA_REF_USE_PAD);
+	regmap_write(regmap, SATA_MPLL_CTRL, SATA_MPLL_MULTIPLIER);
+	regmap_write(regmap, SATA_RESET_CTRL, 0x0);
+
+	return 0;
+}
+
+static int eswin_ahci_platform_resets(struct ahci_host_priv *hpriv,
+				 struct device *dev)
+{
+	struct eswin_ahci_plat *plat = hpriv->plat_data;
+	struct regmap *regmap;
+	int ret;
+
+	regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "eswin,hsp_sp_csr");
+	if (IS_ERR(regmap)) {
+		dev_dbg(dev, "No hsp_sp_csr phandle specified\n");
+		return -1;
+	}
+
+	plat->apb_rst = devm_reset_control_get_optional(dev, "apb");
+	if (PTR_ERR(plat->apb_rst) == -EPROBE_DEFER)
+		return PTR_ERR(plat->apb_rst);
+
+	ret = reset_control_assert(plat->apb_rst);
+	if (ret) {
+		dev_err(dev, "failed to assert apb_rst\n");
+		return ret;
+	}
+	regmap_write(regmap, SATA_RESET_CTRL, SATA_RESET_CTRL_ASSERT);
+
+	regmap_write(regmap, SATA_RESET_CTRL, SATA_RESET_CTRL_DEASSERT);
+	ret = reset_control_deassert(plat->apb_rst);
+	if (ret) {
+		dev_err(dev, "failed to deassert apb_rst\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ahci_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ahci_host_priv *hpriv;
+	struct eswin_ahci_plat *plat;
+	const struct ata_port_info *port;
+	int ret;
+
+	plat = devm_kzalloc(dev, sizeof(*plat), GFP_KERNEL);
+	if (!plat)
+		return -ENOMEM;
+
+	hpriv = ahci_platform_get_resources(pdev, 0);
+	if (IS_ERR(hpriv))
+		return PTR_ERR(hpriv);
+
+	hpriv->plat_data = plat;
+	ret = eswin_ahci_platform_resets(hpriv, dev);
+	if (ret)
+		return ret;
+
+	ret = ahci_platform_enable_resources(hpriv);
+	if (ret)
+		return ret;
+
+	eswin_sata_init(dev);
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(41));
+	if (ret)
+		return ret;
+
+	of_property_read_u32(dev->of_node, "ports-implemented", &hpriv->saved_port_map);
+
+	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
+		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
+
+	port = acpi_device_get_match_data(dev);
+	if (!port)
+		port = &ahci_port_info;
+
+	ret = ahci_platform_init_host(pdev, hpriv, port, &ahci_platform_sht);
+	if (ret)
+		goto disable_resources;
+
+	return 0;
+
+disable_resources:
+	ahci_platform_disable_resources(hpriv);
+	return ret;
+}
+
+static void ahci_remove(struct platform_device *pdev)
+{
+	ata_platform_remove_one(pdev);
+}
+
+static int eswin_ahci_suspend(struct device *dev)
+{
+	int ret;
+
+	ret = ahci_platform_suspend(dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int eswin_ahci_resume(struct device *dev)
+{
+	int ret;
+
+	ret = ahci_platform_resume(dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(ahci_pm_ops, eswin_ahci_suspend, eswin_ahci_resume);
+
+static const struct of_device_id ahci_of_match[] = {
+	{ .compatible = "eswin,eic7700-ahci", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ahci_of_match);
+
+static const struct acpi_device_id ahci_acpi_match[] = {
+	{ "APMC0D33", (unsigned long)&ahci_port_info_nolpm },
+	{ ACPI_DEVICE_CLASS(PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff) },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, ahci_acpi_match);
+
+static struct platform_driver ahci_driver = {
+	.probe = ahci_probe,
+	.remove = ahci_remove,
+	.shutdown = ahci_platform_shutdown,
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table = ahci_of_match,
+		.acpi_match_table = ahci_acpi_match,
+		.pm = &ahci_pm_ops,
+	},
+};
+module_platform_driver(ahci_driver);
+
+MODULE_DESCRIPTION("ESWIN AHCI SATA driver");
+MODULE_AUTHOR("Yulin Lu <luyulin@eswincomputing.com>");
+MODULE_AUTHOR("Huan He <hehuan1@eswincomputing.com>");
+MODULE_LICENSE("GPL");
-- 
2.25.1

