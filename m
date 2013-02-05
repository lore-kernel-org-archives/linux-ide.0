From: Vasanth Ananthan <vasanthananthan@gmail.com>
Subject: [PATCH v2 2/2] driver: ata: add new Exynos5250 SATA PHY controller driver
Date: Tue,  5 Feb 2013 19:51:40 +0530
Message-ID: <1360074100-26357-3-git-send-email-vasanthananthan@gmail.com>
References: <1360074100-26357-1-git-send-email-vasanthananthan@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1360074100-26357-1-git-send-email-vasanthananthan@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, jgarzik@redhat.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, thomas.abraham@linaro.org, Vasanth Ananthan <vasanthananthan@gmail.com>, Vasanth Ananthan <vasanth.a@samsung.com>
List-Id: linux-ide@vger.kernel.org

Adding platform driver and I2C client driver for SATA PHY controller
for Samsung Exynos5250.

The PHY controller in Exynos5250 has both the APB interface
and I2C client interface, hence it requires both a platform driver
and an I2C client driver. The PHY controller's primary charecteristics
are handled through the APB interface, facilitated by the platform driver
and the 40 bit interface should be enabled through the I2C interface,
facilitated by the I2C client driver.

Further, this PHY controller driver uses PHY framework introduced by this
patchset. The driver registers its initialization/shutdown call back to the
framework and corresponding port this PHY controller is assciated with
gets this PHY and initializes it.

Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
---
 drivers/ata/Kconfig           |   10 ++
 drivers/ata/Makefile          |    1 +
 drivers/ata/sata_exynos_phy.c |  297 +++++++++++++++++++++++++++++++++++++++++
 drivers/ata/sata_exynos_phy.h |   31 +++++
 4 files changed, 339 insertions(+)
 create mode 100644 drivers/ata/sata_exynos_phy.c
 create mode 100644 drivers/ata/sata_exynos_phy.h

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 2ad1080..b7f2e29 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -106,6 +106,16 @@ config SATA_PHY
 	  provided and the SATA controller finds and requests for an appropriate
 	  PHY controller. This can be used by platforms with device tree support.
 
+config SATA_EXYNOS_PHY
+	bool "Exynos5250 SATA PHY support"
+	default n
+	select I2C
+	select HAVE_S3C2410_I2C
+	select I2C_S3C2410
+	select SATA_PHY
+	help
+	  This options enables the support for sata phy in exynos5250.
+
 config SATA_FSL
 	tristate "Freescale 3.0Gbps SATA support"
 	depends on FSL_SOC
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 3d2d128..bed6977 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
 obj-$(CONFIG_SATA_DWC)		+= sata_dwc_460ex.o
 obj-$(CONFIG_SATA_HIGHBANK)	+= sata_highbank.o libahci.o
 obj-$(CONFIG_SATA_PHY)		+= sata_phy.o
+obj-$(CONFIG_SATA_EXYNOS_PHY)	+= sata_exynos_phy.o
 
 # SFF w/ custom DMA
 obj-$(CONFIG_PDC_ADMA)		+= pdc_adma.o
diff --git a/drivers/ata/sata_exynos_phy.c b/drivers/ata/sata_exynos_phy.c
new file mode 100644
index 0000000..538ff95
--- /dev/null
+++ b/drivers/ata/sata_exynos_phy.c
@@ -0,0 +1,297 @@
+/*
+ * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
+ *              http://www.samsung.com
+ *
+ * EXYNOS - SATA PHY controller driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/ahci_platform.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+
+#include <plat/cpu.h>
+
+#include <mach/irqs.h>
+#include <mach/map.h>
+#include <mach/regs-pmu.h>
+
+#include "sata_phy.h"
+#include "sata_exynos_phy.h"
+
+#define	SATA_TIME_LIMIT		1000
+
+static struct i2c_client *i2c_client;
+
+static struct i2c_driver sataphy_i2c_driver;
+
+struct exynos_sata_phy {
+	void __iomem *mmio;
+	void __iomem *pmureg;
+	struct clk *clk;
+	struct device *dev;
+	struct sata_phy phy;
+};
+
+static bool sata_is_reg(void __iomem *base, u32 reg, u32 checkbit, u32 status)
+{
+	if ((readl(base + reg) & checkbit) == status)
+		return true;
+	else
+		return false;
+}
+
+static bool wait_for_reg_status(void __iomem *base, u32 reg, u32 checkbit,
+				u32 status)
+{
+	unsigned long timeout = jiffies + usecs_to_jiffies(1000);
+
+	while (time_before(jiffies, timeout)) {
+		if (sata_is_reg(base, reg, checkbit, status))
+			return true;
+	}
+
+	return false;
+}
+
+static int exynos_sataphy_parse_dt(struct device *dev,
+					struct exynos_sata_phy *phy)
+{
+	struct device_node *sataphy_pmu;
+
+	sataphy_pmu = of_get_child_by_name(dev->of_node, "sataphy-pmu");
+	if (!sataphy_pmu) {
+		dev_err(dev,
+			"PMU control register for sata-phy not specified\n");
+		return -ENODEV;
+	}
+
+	phy->pmureg = of_iomap(sataphy_pmu, 0);
+
+	of_node_put(sataphy_pmu);
+
+	if (!phy->pmureg) {
+		dev_err(dev, "Can't get sata-phy pmu control register\n");
+		return -EADDRNOTAVAIL;
+	}
+
+	return 0;
+}
+
+static int exynos_sataphy_init(struct sata_phy *phy)
+{
+	int ret;
+	u32 val;
+
+	/* Values to be written to enable 40 bits interface */
+	u8 buf[] = { 0x3A, 0x0B };
+
+	struct exynos_sata_phy *sata_phy;
+
+	if (!i2c_client)
+		return -EPROBE_DEFER;
+
+	sata_phy = container_of(phy, struct exynos_sata_phy, phy);
+
+	ret = clk_enable(sata_phy->clk);
+	if (ret < 0) {
+		dev_err(phy->dev, "failed to enable source clk\n");
+		return ret;
+	}
+
+	if (sata_is_reg(sata_phy->mmio , EXYNOS5_SATA_CTRL0,
+		CTRL0_P0_PHY_CALIBRATED, CTRL0_P0_PHY_CALIBRATED))
+		return 0;
+
+	writel(SATA_PHY_PMU_EN, sata_phy->pmureg);
+
+	val = 0;
+	writel(val, sata_phy->mmio + EXYNOS5_SATA_RESET);
+
+	val = readl(sata_phy->mmio + EXYNOS5_SATA_RESET);
+	val |= 0xFF;
+	writel(val, sata_phy->mmio + EXYNOS5_SATA_RESET);
+
+	val = readl(sata_phy->mmio + EXYNOS5_SATA_RESET);
+	val |= LINK_RESET;
+	writel(val, sata_phy->mmio + EXYNOS5_SATA_RESET);
+
+	val = readl(sata_phy->mmio + EXYNOS5_SATA_RESET);
+	val |= RESET_CMN_RST_N;
+	writel(val, sata_phy->mmio + EXYNOS5_SATA_RESET);
+
+	val = readl(sata_phy->mmio + EXYNOS5_SATA_PHSATA_CTRLM);
+	val &= ~PHCTRLM_REF_RATE;
+	writel(val, sata_phy->mmio + EXYNOS5_SATA_PHSATA_CTRLM);
+
+	/* High speed enable for Gen3 */
+	val = readl(sata_phy->mmio + EXYNOS5_SATA_PHSATA_CTRLM);
+	val |= PHCTRLM_HIGH_SPEED;
+	writel(val, sata_phy->mmio + EXYNOS5_SATA_PHSATA_CTRLM);
+
+	val = readl(sata_phy->mmio + EXYNOS5_SATA_CTRL0);
+	val |= CTRL0_P0_PHY_CALIBRATED_SEL | CTRL0_P0_PHY_CALIBRATED;
+	writel(val, sata_phy->mmio + EXYNOS5_SATA_CTRL0);
+
+	writel(0x2, sata_phy->mmio + EXYNOS5_SATA_MODE0);
+
+	ret = i2c_master_send(i2c_client, buf, sizeof(buf));
+	if (ret < 0)
+		return -ENXIO;
+
+	/* release cmu reset */
+	val = readl(sata_phy->mmio + EXYNOS5_SATA_RESET);
+	val &= ~RESET_CMN_RST_N;
+	writel(val, sata_phy->mmio + EXYNOS5_SATA_RESET);
+
+	val = readl(sata_phy->mmio + EXYNOS5_SATA_RESET);
+	val |= RESET_CMN_RST_N;
+	writel(val, sata_phy->mmio + EXYNOS5_SATA_RESET);
+
+	if (wait_for_reg_status(sata_phy->mmio, EXYNOS5_SATA_PHSATA_STATM,
+				PHSTATM_PLL_LOCKED, 1)) {
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static int exynos_sataphy_shutdown(struct sata_phy *phy)
+{
+
+	struct exynos_sata_phy *sata_phy;
+
+	sata_phy = container_of(phy, struct exynos_sata_phy, phy);
+	clk_disable(sata_phy->clk);
+
+	return 0;
+}
+
+static int __init exynos_sata_i2c_probe(struct i2c_client *client,
+			  const struct i2c_device_id *i2c_id)
+{
+	i2c_client = client;
+	return 0;
+}
+
+static int __init exynos_sata_phy_probe(struct platform_device *pdev)
+{
+	struct exynos_sata_phy *sataphy;
+	struct device *dev = &pdev->dev;
+	int ret = 0;
+
+	sataphy = devm_kzalloc(dev, sizeof(struct exynos_sata_phy), GFP_KERNEL);
+	if (!sataphy) {
+		dev_err(dev, "failed to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	sataphy->mmio = of_iomap(dev->of_node, 0);
+	if (!sataphy->mmio) {
+		dev_err(dev, "failed to remap IO\n");
+		return -EADDRNOTAVAIL;
+	}
+
+	ret = exynos_sataphy_parse_dt(dev, sataphy);
+	if (ret != 0)
+		goto err_iomap;
+
+	sataphy->clk = devm_clk_get(dev, "sata-phy");
+	if (IS_ERR(sataphy->clk)) {
+		dev_err(dev, "failed to get clk for PHY\n");
+		ret = PTR_ERR(sataphy->clk);
+		goto err_pmu;
+	}
+
+	sataphy->phy.init = exynos_sataphy_init;
+	sataphy->phy.shutdown = exynos_sataphy_shutdown;
+	sataphy->phy.dev = dev;
+
+	ret = sata_add_phy(&sataphy->phy);
+	if (ret < 0) {
+		dev_err(dev, "PHY not registered with framework\n");
+		goto err_iomap;
+	}
+
+	ret = i2c_add_driver(&sataphy_i2c_driver);
+	if (ret < 0)
+		goto err_phy;
+
+	platform_set_drvdata(pdev, sataphy);
+
+	return ret;
+
+ err_phy:
+	sata_remove_phy(&sataphy->phy);
+
+ err_pmu:
+	iounmap(sataphy->pmureg);
+
+ err_iomap:
+	iounmap(sataphy->mmio);
+
+	return ret;
+}
+
+static int exynos_sata_phy_remove(struct platform_device *pdev)
+{
+	struct exynos_sata_phy *sataphy;
+
+	sataphy = platform_get_drvdata(pdev);
+	iounmap(sataphy->mmio);
+	i2c_del_driver(&sataphy_i2c_driver);
+	sata_remove_phy(&sataphy->phy);
+
+	return 0;
+}
+
+static const struct of_device_id sata_phy_of_match[] = {
+	{ .compatible = "samsung,exynos5250-sata-phy", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, sata_phy_of_match);
+
+static const struct i2c_device_id phy_i2c_device_match[] = {
+	{ "sata-phy", 0 },
+};
+
+MODULE_DEVICE_TABLE(of, phy_i2c_device_match);
+
+static struct platform_driver sata_phy_driver = {
+	.probe = exynos_sata_phy_probe,
+	.remove = exynos_sata_phy_remove,
+	.driver = {
+		   .name = "sata-phy",
+		   .owner = THIS_MODULE,
+		   .of_match_table = sata_phy_of_match,
+	},
+};
+
+static struct i2c_driver sataphy_i2c_driver = {
+	.driver = {
+		   .name = "sata-phy-i2c",
+		   .owner = THIS_MODULE,
+		   .of_match_table = (void *)phy_i2c_device_match,
+	},
+	.probe = exynos_sata_i2c_probe,
+	.id_table = phy_i2c_device_match,
+};
+
+module_platform_driver(sata_phy_driver);
+
+MODULE_DESCRIPTION("EXYNOS SATA PHY DRIVER");
+MODULE_AUTHOR("Vasanth Ananthan, <vasanth.a@samsung.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/ata/sata_exynos_phy.h b/drivers/ata/sata_exynos_phy.h
new file mode 100644
index 0000000..2eea737
--- /dev/null
+++ b/drivers/ata/sata_exynos_phy.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
+ *              http://www.samsung.com
+ *
+ * EXYNOS - SATA PHY controller definition
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#define EXYNOS5_SATA_RESET		0x4
+#define RESET_CMN_RST_N			(1 << 1)
+#define LINK_RESET			0xF0000
+
+#define EXYNOS5_SATA_MODE0		0x10
+
+#define EXYNOS5_SATA_CTRL0		0x14
+#define CTRL0_P0_PHY_CALIBRATED_SEL	(1 << 9)
+#define CTRL0_P0_PHY_CALIBRATED		(1 << 8)
+
+#define EXYNOS5_SATA_PHSATA_CTRLM	0xE0
+#define PHCTRLM_REF_RATE		(1 << 1)
+#define PHCTRLM_HIGH_SPEED		(1 << 0)
+
+#define EXYNOS5_SATA_PHSATA_STATM	0xF0
+#define PHSTATM_PLL_LOCKED		(1 << 0)
+
+#define SATA_PHY_CON_RESET              0xF003F
+
+#define SATA_PHY_PMU_EN			0x1
-- 
1.7.9.5
