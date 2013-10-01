From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Subject: [PATCH 2/3] Phy: Exynos: Add Exynos5250 sata phy driver
Date: Tue,  1 Oct 2013 12:03:02 +0530
Message-ID: <1380609183-21430-3-git-send-email-yuvaraj.cd@samsung.com>
References: <1380609183-21430-1-git-send-email-yuvaraj.cd@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1380609183-21430-1-git-send-email-yuvaraj.cd@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tj@kernel.org, kgene.kim@samsung.com, grant.likely@linaro.org, rob.herring@calxeda.com, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, kishon@ti.com
Cc: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, ks.giri@samsung.com, Vasanth Ananthan <vasanth.a@samsung.com>, s.nawrocki@samsung.com, aditya.ps@samsung.com
List-Id: linux-ide@vger.kernel.org

This patch adds the sata phy driver for Exynos5250.Exynos5250 sata
phy comprises of CMU and TRSV blocks which are of I2C register Map.
So this patch also adds a i2c client driver, which is used configure
the CMU and TRSV block of exynos5250 SATA PHY.

This patch incorporates the generic phy framework to deal with sata
phy.

This patch depends on the below patch
	[1].drivers: phy: add generic PHY framework
		by Kishon Vijay Abraham I<kishon@ti.com>

Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
Signed-off-by: Girish K S <ks.giri@samsung.com>
Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
---
 drivers/phy/Kconfig                      |    6 +
 drivers/phy/Makefile                     |    1 +
 drivers/phy/exynos/Kconfig               |    5 +
 drivers/phy/exynos/Makefile              |    5 +
 drivers/phy/exynos/exynos5250_phy_i2c.c  |   53 +++++++
 drivers/phy/exynos/sata_phy_exynos5250.c |  248 ++++++++++++++++++++++++++++++
 drivers/phy/exynos/sata_phy_exynos5250.h |   33 ++++
 7 files changed, 351 insertions(+)
 create mode 100644 drivers/phy/exynos/Kconfig
 create mode 100644 drivers/phy/exynos/Makefile
 create mode 100644 drivers/phy/exynos/exynos5250_phy_i2c.c
 create mode 100644 drivers/phy/exynos/sata_phy_exynos5250.c
 create mode 100644 drivers/phy/exynos/sata_phy_exynos5250.h

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 5f85909..ab3d1c6 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -11,3 +11,9 @@ menuconfig GENERIC_PHY
 	  devices present in the kernel. This layer will have the generic
 	  API by which phy drivers can create PHY using the phy framework and
 	  phy users can obtain reference to the PHY.
+
+if GENERIC_PHY
+
+source "drivers/phy/exynos/Kconfig"
+
+endif
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 9e9560f..e0223d7 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -3,3 +3,4 @@
 #
 
 obj-$(CONFIG_GENERIC_PHY)	+= phy-core.o
+obj-$(CONFIG_PHY_SAMSUNG_SATA)	+= exynos/
diff --git a/drivers/phy/exynos/Kconfig b/drivers/phy/exynos/Kconfig
new file mode 100644
index 0000000..fa125fb
--- /dev/null
+++ b/drivers/phy/exynos/Kconfig
@@ -0,0 +1,5 @@
+config PHY_SAMSUNG_SATA
+	tristate "Samsung Sata SerDes/PHY driver"
+	help
+	  Support for Samsung sata SerDes/Phy found on Samsung
+	  SoCs.
diff --git a/drivers/phy/exynos/Makefile b/drivers/phy/exynos/Makefile
new file mode 100644
index 0000000..50dc7eb
--- /dev/null
+++ b/drivers/phy/exynos/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for the exynos phy drivers.
+#
+ccflags-y := -Idrivers/phy/exynos
+obj-$(CONFIG_PHY_SAMSUNG_SATA)	+= sata_phy_exynos5250.o exynos5250_phy_i2c.o
diff --git a/drivers/phy/exynos/exynos5250_phy_i2c.c b/drivers/phy/exynos/exynos5250_phy_i2c.c
new file mode 100644
index 0000000..9c75d3b
--- /dev/null
+++ b/drivers/phy/exynos/exynos5250_phy_i2c.c
@@ -0,0 +1,53 @@
+/*
+ * Copyright (C) 2013 Samsung Electronics Co.Ltd
+ * Author:
+ *	Yuvaraj C D <yuvaraj.cd@samsung.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include "sata_phy_exynos5250.h"
+
+static int exynos_sata_i2c_probe(struct i2c_client *client,
+		const struct i2c_device_id *i2c_id)
+{
+	sataphy_attach_i2c_client(client);
+
+	dev_info(&client->adapter->dev,
+		"attached %s into i2c adapter successfully\n",
+		client->name);
+
+	return 0;
+}
+
+static int exynos_sata_i2c_remove(struct i2c_client *client)
+{
+	dev_info(&client->adapter->dev,
+		"detached %s from i2c adapter successfully\n",
+		client->name);
+
+	return 0;
+}
+
+static const struct i2c_device_id phy_i2c_device_match[] = {
+	{ "sata-phy-i2c", 0 },
+};
+MODULE_DEVICE_TABLE(of, phy_i2c_device_match);
+
+struct i2c_driver sataphy_i2c_driver = {
+	.probe    = exynos_sata_i2c_probe,
+	.id_table = phy_i2c_device_match,
+	.remove		= exynos_sata_i2c_remove,
+	.driver   = {
+		.name = "sata-phy-i2c",
+		.owner = THIS_MODULE,
+		.of_match_table = (void *)phy_i2c_device_match,
+		},
+};
diff --git a/drivers/phy/exynos/sata_phy_exynos5250.c b/drivers/phy/exynos/sata_phy_exynos5250.c
new file mode 100644
index 0000000..726c10e
--- /dev/null
+++ b/drivers/phy/exynos/sata_phy_exynos5250.c
@@ -0,0 +1,248 @@
+/*
+ * Samsung SATA SerDes(PHY) driver
+ *
+ * Copyright (C) 2013 Samsung Electronics Co., Ltd.
+ * Authors: Girish K S <ks.giri@samsung.com>
+ *         Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/phy/phy.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/clk.h>
+#include "sata_phy_exynos5250.h"
+
+static struct i2c_client *phy_i2c_client;
+
+struct exynos_sata_phy {
+	struct phy *phy;
+	struct clk *phyclk;
+	void __iomem *regs;
+	void __iomem *pmureg;
+};
+
+static bool wait_for_reg_status(void __iomem *base, u32 reg, u32 checkbit,
+				u32 status)
+{
+	unsigned long timeout = jiffies + usecs_to_jiffies(1000);
+	while (time_before(jiffies, timeout)) {
+		if ((readl(base + reg) & checkbit) == status)
+			return true;
+	}
+	return false;
+}
+
+void sataphy_attach_i2c_client(struct i2c_client *sata_phy)
+{
+	if (sata_phy)
+		phy_i2c_client = sata_phy;
+}
+
+static int __set_phy_state(struct exynos_sata_phy *state, unsigned int on)
+{
+	u32 reg;
+
+	reg = readl(state->pmureg);
+	if (on)
+		reg |= EXYNOS_SATA_PHY_EN;
+	else
+		reg &= ~EXYNOS_SATA_PHY_EN;
+	writel(reg, state->pmureg);
+
+	return 0;
+}
+
+static int exynos_sata_phy_power_on(struct phy *phy)
+{
+	struct exynos_sata_phy *state = phy_get_drvdata(phy);
+
+	return __set_phy_state(state, 1);
+}
+
+static int exynos_sata_phy_power_off(struct phy *phy)
+{
+	struct exynos_sata_phy *state = phy_get_drvdata(phy);
+
+	return __set_phy_state(state, 0);
+}
+
+static int exynos_sataphy_parse_dt(struct device *dev,
+				struct exynos_sata_phy *sata)
+{
+	struct device_node *np = dev->of_node;
+	struct device_node *sataphy_pmu;
+
+	sataphy_pmu = of_get_child_by_name(np, "sataphy-pmu");
+	if (!sataphy_pmu) {
+		dev_err(dev, "No PMU interface for sata-phy\n");
+		return -ENODEV;
+	}
+
+	sata->pmureg = of_iomap(sataphy_pmu, 0);
+	if (!sata->pmureg) {
+		dev_err(dev, "Can't get sata-phy pmu control register\n");
+		of_node_put(sataphy_pmu);
+		return -ENXIO;
+	}
+
+	of_node_put(sataphy_pmu);
+	return 0;
+}
+
+static int exynos_sata_phy_init(struct phy *phy)
+{
+	u32 val;
+	int ret = 0;
+	u8 buf[] = { 0x3A, 0x0B };
+	struct exynos_sata_phy *sata_phy = phy_get_drvdata(phy);
+
+	if (!phy_i2c_client)
+		return -EPROBE_DEFER;
+
+	writel(EXYNOS_SATA_PHY_EN, sata_phy->pmureg);
+
+	val = 0;
+	writel(val, sata_phy->regs + EXYNOS5_SATA_RESET);
+
+	val = readl(sata_phy->regs + EXYNOS5_SATA_RESET);
+	val |= 0xFF;
+	writel(val, sata_phy->regs + EXYNOS5_SATA_RESET);
+
+	val = readl(sata_phy->regs + EXYNOS5_SATA_RESET);
+	val |= LINK_RESET;
+	writel(val, sata_phy->regs + EXYNOS5_SATA_RESET);
+
+	val = readl(sata_phy->regs + EXYNOS5_SATA_RESET);
+	val |= RESET_CMN_RST_N;
+	writel(val, sata_phy->regs + EXYNOS5_SATA_RESET);
+	val = readl(sata_phy->regs + EXYNOS5_SATA_PHSATA_CTRLM);
+	val &= ~PHCTRLM_REF_RATE;
+	writel(val, sata_phy->regs + EXYNOS5_SATA_PHSATA_CTRLM);
+
+	/* High speed enable for Gen3 */
+	val = readl(sata_phy->regs + EXYNOS5_SATA_PHSATA_CTRLM);
+	val |= PHCTRLM_HIGH_SPEED;
+	writel(val, sata_phy->regs + EXYNOS5_SATA_PHSATA_CTRLM);
+
+	val |= CTRL0_P0_PHY_CALIBRATED_SEL | CTRL0_P0_PHY_CALIBRATED;
+	writel(val, sata_phy->regs + EXYNOS5_SATA_CTRL0);
+
+	writel(0x2, sata_phy->regs + EXYNOS5_SATA_MODE0);
+
+	ret = i2c_master_send(phy_i2c_client, buf, sizeof(buf));
+	if (ret < 0)
+		return -ENXIO;
+
+	/* release cmu reset */
+	val = readl(sata_phy->regs + EXYNOS5_SATA_RESET);
+	val &= ~RESET_CMN_RST_N;
+	writel(val, sata_phy->regs + EXYNOS5_SATA_RESET);
+
+	val = readl(sata_phy->regs + EXYNOS5_SATA_RESET);
+	val |= RESET_CMN_RST_N;
+	writel(val, sata_phy->regs + EXYNOS5_SATA_RESET);
+
+	return (wait_for_reg_status(sata_phy->regs, EXYNOS5_SATA_PHSATA_STATM,
+		PHSTATM_PLL_LOCKED, 1)) ? 0 : -EINVAL;
+
+}
+
+static struct phy_ops exynos_sata_phy_ops = {
+	.init		= exynos_sata_phy_init,
+	.power_on	= exynos_sata_phy_power_on,
+	.power_off	= exynos_sata_phy_power_off,
+	.owner		= THIS_MODULE,
+};
+
+static int exynos_sata_phy_probe(struct platform_device *pdev)
+{
+	struct exynos_sata_phy *sata;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	struct phy_provider *phy_provider;
+	char label[9];
+	int ret = 0;
+
+	sata = devm_kzalloc(dev, sizeof(*sata), GFP_KERNEL);
+	if (!sata)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	sata->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(sata->regs))
+		return PTR_ERR(sata->regs);
+
+	dev_set_drvdata(dev, sata);
+
+	if (i2c_add_driver(&sataphy_i2c_driver)) {
+		dev_err(dev, "failed to register sataphy i2c driver\n");
+		return -ENOENT;
+	}
+
+	sata->phyclk = devm_clk_get(dev, "sata_phyctrl");
+	if (IS_ERR(sata->phyclk)) {
+		dev_err(dev, "failed to get clk for PHY\n");
+		return PTR_ERR(sata->phyclk);
+	}
+
+	ret = clk_prepare_enable(sata->phyclk);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable source clk\n");
+		return ret;
+	}
+
+	if (dev->of_node) {
+		ret = exynos_sataphy_parse_dt(dev, sata);
+		if (ret)
+			return ret;
+	}
+
+	phy_provider = devm_of_phy_provider_register(dev,
+					of_phy_simple_xlate);
+	if (IS_ERR(phy_provider))
+		return PTR_ERR(phy_provider);
+
+	snprintf(label, sizeof(label), "%s.%d", "sata-phy", pdev->id);
+
+	sata->phy = devm_phy_create(dev, pdev->id, &exynos_sata_phy_ops, label);
+	if (IS_ERR(sata->phy)) {
+		dev_err(dev, "failed to create PHY %s\n", label);
+		return PTR_ERR(sata->phy);
+	}
+	phy_set_drvdata(sata->phy, sata);
+
+	return 0;
+}
+
+static const struct of_device_id exynos_sata_phy_of_match[] = {
+	{ .compatible = "samsung,exynos5250-sata-phy" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, exynos_sata_phy_of_match);
+
+static struct platform_driver exynos_sata_phy_driver = {
+	.probe	= exynos_sata_phy_probe,
+	.driver = {
+		.of_match_table	= exynos_sata_phy_of_match,
+		.name  = "samsung,sata-phy",
+		.owner = THIS_MODULE,
+	}
+};
+module_platform_driver(exynos_sata_phy_driver);
+
+MODULE_DESCRIPTION("Samsung SerDes PHY driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("ks.giri <ks.giri@samsung.com>");
+MODULE_AUTHOR("Yuvaraj C D <yuvaraj.cd@samsung.com>");
diff --git a/drivers/phy/exynos/sata_phy_exynos5250.h b/drivers/phy/exynos/sata_phy_exynos5250.h
new file mode 100644
index 0000000..64e38a1
--- /dev/null
+++ b/drivers/phy/exynos/sata_phy_exynos5250.h
@@ -0,0 +1,33 @@
+/*
+ *
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ * Author:
+ *	Yuvaraj Kumar C D<yuvaraj.cd@samsung.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#define EXYNOS5_SATA_RESET		0x4
+#define EXYNOS5_SATA_MODE0              0x10
+#define EXYNOS5_SATA_CTRL0              0x14
+#define EXYNOS5_SATA_STAT0		0x18
+#define EXYNOS5_SATA_PHSATA_CTRLM       0xE0
+#define EXYNOS5_SATA_PHSATA_CTRL0       0xE4
+#define EXYNOS5_SATA_PHSATA_STATM       0xF0
+#define EXYNOS5_SATA_PHSTAT0            0xF4
+
+#define RESET_CMN_RST_N			(1 << 1)
+#define LINK_RESET			0xF0000
+#define CTRL0_P0_PHY_CALIBRATED_SEL	(1 << 9)
+#define CTRL0_P0_PHY_CALIBRATED		(1 << 8)
+#define PHCTRLM_REF_RATE		(1 << 1)
+#define PHCTRLM_HIGH_SPEED		(1 << 0)
+#define PHSTATM_PLL_LOCKED		(1 << 0)
+#define SATA_PHY_CON_RESET              (LINK_RESET | 3F)
+#define EXYNOS_SATA_PHY_EN		(1 << 0)
+
+void sataphy_attach_i2c_client(struct i2c_client *sata_phy);
+extern struct i2c_driver sataphy_i2c_driver;
-- 
1.7.9.5
