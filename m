From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 2/2] ata: ahci: add support for DaVinci DM816 SATA controller
Date: Tue, 14 Mar 2017 12:04:51 +0100
Message-ID: <1489489491-14195-3-git-send-email-bgolaszewski@baylibre.com>
References: <1489489491-14195-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1489489491-14195-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Neil Armstrong <narmstrong@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, Tony Lindgren <tony@atomide.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-ide@vger.kernel.org

This SATA controller is quite similar to the one present on the DA850
SoC, but the PHY configuration is different and it supports two HBA
ports.

The IP suffers from the same PMP issue the DA850 does - if we enable
PMP but don't use it - softreset fails. Appropriate workaround was
implemented in this driver as well.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/ata/Kconfig      |   9 +++
 drivers/ata/Makefile     |   1 +
 drivers/ata/ahci_dm816.c | 200 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 210 insertions(+)
 create mode 100644 drivers/ata/ahci_dm816.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 70b57d2..7f59a7a 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -118,6 +118,15 @@ config AHCI_DA850
 
 	  If unsure, say N.
 
+config AHCI_DM816
+	tristate "DaVinci DM816 AHCI SATA support"
+	depends on ARCH_OMAP2PLUS
+	help
+	  This option enables support for the DaVinci DM816 SoC's
+	  onboard AHCI SATA controller.
+
+	  If unsure, say N.
+
 config AHCI_ST
 	tristate "ST AHCI SATA support"
 	depends on ARCH_STI
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 89a0a19..3052c0a 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_SATA_HIGHBANK)	+= sata_highbank.o libahci.o
 obj-$(CONFIG_AHCI_BRCM)		+= ahci_brcm.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_CEVA)		+= ahci_ceva.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_DA850)	+= ahci_da850.o libahci.o libahci_platform.o
+obj-$(CONFIG_AHCI_DM816)	+= ahci_dm816.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_IMX)		+= ahci_imx.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_MVEBU)	+= ahci_mvebu.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_OCTEON)	+= ahci_octeon.o
diff --git a/drivers/ata/ahci_dm816.c b/drivers/ata/ahci_dm816.c
new file mode 100644
index 0000000..fbd827c
--- /dev/null
+++ b/drivers/ata/ahci_dm816.c
@@ -0,0 +1,200 @@
+/*
+ * DaVinci DM816 AHCI SATA platform driver
+ *
+ * Copyright (C) 2017 BayLibre SAS
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/pm.h>
+#include <linux/platform_device.h>
+#include <linux/libata.h>
+#include <linux/ahci_platform.h>
+
+#include "ahci.h"
+
+#define AHCI_DM816_DRV_NAME		"ahci-dm816"
+
+#define AHCI_DM816_PHY_ENPLL(x)		((x) << 0)
+#define AHCI_DM816_PHY_MPY(x)		((x) << 1)
+#define AHCI_DM816_PHY_LOS(x)		((x) << 12)
+#define AHCI_DM816_PHY_RXCDR(x)		((x) << 13)
+#define AHCI_DM816_PHY_RXEQ(x)		((x) << 16)
+#define AHCI_DM816_PHY_TXSWING(x)	((x) << 23)
+
+#define AHCI_DM816_P0PHYCR_REG		0x178
+#define AHCI_DM816_P1PHYCR_REG		0x1f8
+
+#define AHCI_DM816_PLL_OUT		1500000000LU
+
+static const unsigned long pll_mpy_table[] = {
+	  400,  500,  600,  800,  825, 1000, 1200,
+	 1250, 1500, 1600, 1650, 2000, 2200, 2500
+};
+
+static int ahci_dm816_get_mpy_bits(unsigned long refclk_rate)
+{
+	unsigned long pll_multiplier;
+	int i;
+
+	/*
+	 * We need to determine the value of the multiplier (MPY) bits.
+	 * In order to include the 8.25 multiplier we need to first divide
+	 * the refclk rate by 100.
+	 */
+	pll_multiplier = AHCI_DM816_PLL_OUT / (refclk_rate / 100);
+
+	for (i = 0; i < ARRAY_SIZE(pll_mpy_table); i++) {
+		if (pll_mpy_table[i] == pll_multiplier)
+			return i;
+	}
+
+	/*
+	 * We should have divided evenly - if not, return an invalid
+	 * value.
+	 */
+	return -1;
+}
+
+static int ahci_dm816_phy_init(struct ahci_host_priv *hpriv, struct device *dev)
+{
+	unsigned long refclk_rate;
+	int mpy;
+	u32 val;
+
+	/*
+	 * We should have been supplied two clocks: the functional and
+	 * keep-alive clock and the external reference clock. We need the
+	 * rate of the latter to calculate the correct value of MPY bits.
+	 */
+	if (!hpriv->clks[1]) {
+		dev_err(dev, "reference clock not supplied\n");
+		return -EINVAL;
+	}
+
+	refclk_rate = clk_get_rate(hpriv->clks[1]);
+	if ((refclk_rate % 100) != 0) {
+		dev_err(dev, "reference clock rate must be divisible by 100\n");
+		return -EINVAL;
+	}
+
+	mpy = ahci_dm816_get_mpy_bits(refclk_rate);
+	if (mpy < 0) {
+		dev_err(dev, "can't calculate the MPY bits value\n");
+		return -EINVAL;
+	}
+
+	/* Enable the PHY and configure the first HBA port. */
+	val = AHCI_DM816_PHY_MPY(mpy) | AHCI_DM816_PHY_LOS(1) |
+	      AHCI_DM816_PHY_RXCDR(4) | AHCI_DM816_PHY_RXEQ(1) |
+	      AHCI_DM816_PHY_TXSWING(3) | AHCI_DM816_PHY_ENPLL(1);
+	writel(val, hpriv->mmio + AHCI_DM816_P0PHYCR_REG);
+
+	/* Configure the second HBA port. */
+	val = AHCI_DM816_PHY_LOS(1) | AHCI_DM816_PHY_RXCDR(4) |
+	      AHCI_DM816_PHY_RXEQ(1) | AHCI_DM816_PHY_TXSWING(3);
+	writel(val, hpriv->mmio + AHCI_DM816_P1PHYCR_REG);
+
+	return 0;
+}
+
+static int ahci_dm816_softreset(struct ata_link *link,
+				unsigned int *class, unsigned long deadline)
+{
+	int pmp, ret;
+
+	pmp = sata_srst_pmp(link);
+
+	/*
+	 * There's an issue with the SATA controller on DM816 SoC: if we
+	 * enable Port Multiplier support, but the drive is connected directly
+	 * to the board, it can't be detected. As a workaround: if PMP is
+	 * enabled, we first call ahci_do_softreset() and pass it the result of
+	 * sata_srst_pmp(). If this call fails, we retry with pmp = 0.
+	 */
+	ret = ahci_do_softreset(link, class, pmp, deadline, ahci_check_ready);
+	if (pmp && ret == -EBUSY)
+		return ahci_do_softreset(link, class, 0,
+					 deadline, ahci_check_ready);
+
+	return ret;
+}
+
+static struct ata_port_operations ahci_dm816_port_ops = {
+	.inherits = &ahci_platform_ops,
+	.softreset = ahci_dm816_softreset,
+};
+
+static const struct ata_port_info ahci_dm816_port_info = {
+	.flags		= AHCI_FLAG_COMMON,
+	.pio_mask	= ATA_PIO4,
+	.udma_mask	= ATA_UDMA6,
+	.port_ops	= &ahci_dm816_port_ops,
+};
+
+static struct scsi_host_template ahci_dm816_platform_sht = {
+	AHCI_SHT(AHCI_DM816_DRV_NAME),
+};
+
+static int ahci_dm816_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ahci_host_priv *hpriv;
+	int rc;
+
+	hpriv = ahci_platform_get_resources(pdev);
+	if (IS_ERR(hpriv))
+		return PTR_ERR(hpriv);
+
+	rc = ahci_platform_enable_resources(hpriv);
+	if (rc)
+		return rc;
+
+	rc = ahci_dm816_phy_init(hpriv, dev);
+	if (rc)
+		goto disable_resources;
+
+	rc = ahci_platform_init_host(pdev, hpriv,
+				     &ahci_dm816_port_info,
+				     &ahci_dm816_platform_sht);
+	if (rc)
+		goto disable_resources;
+
+	return 0;
+
+disable_resources:
+	ahci_platform_disable_resources(hpriv);
+
+	return rc;
+}
+
+static SIMPLE_DEV_PM_OPS(ahci_dm816_pm_ops,
+			 ahci_platform_suspend,
+			 ahci_platform_resume);
+
+static const struct of_device_id ahci_dm816_of_match[] = {
+	{ .compatible = "ti,dm816-ahci", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ahci_dm816_of_match);
+
+static struct platform_driver ahci_dm816_driver = {
+	.probe = ahci_dm816_probe,
+	.remove = ata_platform_remove_one,
+	.driver = {
+		.name = AHCI_DM816_DRV_NAME,
+		.of_match_table = ahci_dm816_of_match,
+		.pm = &ahci_dm816_pm_ops,
+	},
+};
+module_platform_driver(ahci_dm816_driver);
+
+MODULE_DESCRIPTION("DaVinci DM816 AHCI SATA platform driver");
+MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
+MODULE_LICENSE("GPL");
-- 
2.9.3
