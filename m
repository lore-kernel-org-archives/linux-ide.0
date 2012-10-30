From: Vasanth Ananthan <vasanthananthan@gmail.com>
Subject: [PATCH v2 6/6] DRIVERS: ATA: SATA PHY controller driver
Date: Tue, 30 Oct 2012 17:01:37 +0100
Message-ID: <1351612897-14923-7-git-send-email-vasanthananthan@gmail.com>
References: <1351612897-14923-1-git-send-email-vasanthananthan@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56890 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933913Ab2J3QCJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2012 12:02:09 -0400
In-Reply-To: <1351612897-14923-1-git-send-email-vasanthananthan@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kgene.kim@samsung.com, jgarzik@pobox.com, linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-ide@vger.kernel.org, thomas.abraham@linaro.org, Vasanth Ananthan <vasanthananthan@gmail.com>, Vasanth Ananthan <vasanth.a@samsung.com>

This patch adds a platform driver and I2C client driver for SATA PHY controller

Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
---
 arch/arm/mach-exynos/include/mach/regs-sata.h |   29 +++
 drivers/ata/Makefile                          |    2 +-
 drivers/ata/sata_exynos_phy.c                 |  300 +++++++++++++++++++++++++
 3 files changed, 330 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-exynos/include/mach/regs-sata.h
 create mode 100644 drivers/ata/sata_exynos_phy.c

diff --git a/arch/arm/mach-exynos/include/mach/regs-sata.h b/arch/arm/mach-exynos/include/mach/regs-sata.h
new file mode 100644
index 0000000..80dd564
--- /dev/null
+++ b/arch/arm/mach-exynos/include/mach/regs-sata.h
@@ -0,0 +1,29 @@
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
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 43bb38e..6a3a8ee 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
 obj-$(CONFIG_SATA_DWC)		+= sata_dwc_460ex.o
 obj-$(CONFIG_SATA_HIGHBANK)	+= sata_highbank.o libahci.o
 obj-$(CONFIG_SATA_PHY)		+= sata_phy.o
-obj-$(CONFIG_SATA_EXYNOS)	+= sata_exynos.o libahci.o
+obj-$(CONFIG_SATA_EXYNOS)	+= sata_exynos.o sata_exynos_phy.o libahci.o
 
 # SFF w/ custom DMA
 obj-$(CONFIG_PDC_ADMA)		+= pdc_adma.o
diff --git a/drivers/ata/sata_exynos_phy.c b/drivers/ata/sata_exynos_phy.c
new file mode 100644
index 0000000..ec61db5
--- /dev/null
+++ b/drivers/ata/sata_exynos_phy.c
@@ -0,0 +1,300 @@
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
+
+#include <plat/cpu.h>
+
+#include <mach/irqs.h>
+#include <mach/map.h>
+#include <mach/regs-pmu.h>
+#include <mach/regs-sata.h>
+
+#include "sata_phy.h"
+
+#define	SATA_TIME_LIMIT		1000
+
+static struct i2c_client *i2c_client;
+
+static struct i2c_driver sataphy_i2c_driver;
+
+struct exynos_sata_phy {
+	void __iomem *mmio;
+	struct resource *mem;
+	struct clk *clk;
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
+	u16 time_limit_cnt = 0;
+	while (!sata_is_reg(base, reg, checkbit, status)) {
+		if (time_limit_cnt == SATA_TIME_LIMIT)
+			return false;
+		udelay(1000);
+		time_limit_cnt++;
+	}
+	return true;
+}
+
+static int sataphy_init(struct sata_phy *phy)
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
+	sata_phy = (struct exynos_sata_phy *)phy->priv_data;
+
+	clk_enable(sata_phy->clk);
+
+	writel(S5P_PMU_SATA_PHY_CONTROL_EN, EXYNOS5_SATA_PHY_CONTROL);
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
+	writel(SATA_PHY_GENERATION3, sata_phy->mmio + EXYNOS5_SATA_MODE0);
+
+	ret = i2c_master_send(i2c_client, buf, sizeof(buf));
+	if (ret < 0)
+		return -EINVAL;
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
+static int sataphy_shutdown(struct sata_phy *phy)
+{
+
+	struct exynos_sata_phy *sata_phy;
+
+	sata_phy = (struct exynos_sata_phy *)phy->priv_data;
+
+	clk_disable(sata_phy->clk);
+
+	return 0;
+}
+
+static int __init sata_i2c_probe(struct i2c_client *client,
+			  const struct i2c_device_id *i2c_id)
+{
+	i2c_client = client;
+	return 0;
+}
+
+static int __init sata_phy_probe(struct platform_device *pdev)
+{
+	struct exynos_sata_phy *sataphy;
+	struct sata_phy *phy;
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	int ret = 0;
+
+	phy = kzalloc(sizeof(struct sata_phy), GFP_KERNEL);
+	if (!phy) {
+		dev_err(&pdev->dev, "failed to allocate memory\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	sataphy = kzalloc(sizeof(struct exynos_sata_phy), GFP_KERNEL);
+	if (!sataphy) {
+		dev_err(dev, "failed to allocate memory\n");
+		ret = -ENOMEM;
+		goto err0;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "Could not find IO resource\n");
+		ret = -EINVAL;
+		goto err1;
+	}
+
+	sataphy->mem = devm_request_mem_region(dev, res->start,
+					resource_size(res), pdev->name);
+	if (!sataphy->mem) {
+		dev_err(dev, "Could not request IO resource\n");
+		ret = -EINVAL;
+		goto err1;
+	}
+
+	sataphy->mmio =
+	    devm_ioremap(dev, res->start, resource_size(res));
+	if (!sataphy->mmio) {
+		dev_err(dev, "failed to remap IO\n");
+		ret = -ENOMEM;
+		goto err2;
+	}
+
+	sataphy->clk = devm_clk_get(dev, "sata-phy");
+	if (IS_ERR(sataphy->clk)) {
+		dev_err(dev, "failed to get clk for PHY\n");
+		ret = PTR_ERR(sataphy->clk);
+		goto err3;
+	}
+
+	phy->init = sataphy_init;
+	phy->shutdown = sataphy_shutdown;
+	phy->priv_data = (void *)sataphy;
+	phy->dev = dev;
+
+	ret = sata_add_phy(phy, SATA_PHY_GENERATION3);
+	if (ret < 0)
+		goto err4;
+
+	ret = i2c_add_driver(&sataphy_i2c_driver);
+	if (ret < 0)
+		goto err5;
+
+	platform_set_drvdata(pdev, phy);
+
+	return ret;
+
+ err5:
+	sata_remove_phy(phy);
+
+ err4:
+	clk_disable(sataphy->clk);
+	devm_clk_put(dev, sataphy->clk);
+
+ err3:
+	devm_iounmap(dev, sataphy->mmio);
+
+ err2:
+	devm_release_mem_region(dev, res->start, resource_size(res));
+
+ err1:
+	kfree(sataphy);
+
+ err0:
+	kfree(phy);
+
+ out:
+	return ret;
+}
+
+static int sata_phy_remove(struct platform_device *pdev)
+{
+	struct sata_phy *phy;
+	struct exynos_sata_phy *sataphy;
+
+	phy = platform_get_drvdata(pdev);
+
+	sataphy = (struct exynos_sata_phy *)phy->priv_data;
+	sata_remove_phy(phy);
+
+	kfree(sataphy);
+	kfree(phy);
+
+	return 0;
+}
+
+static const struct of_device_id sata_phy_of_match[] = {
+	{ .compatible = "samsung,exynos5-sata-phy", },
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
+	.probe = sata_phy_probe,
+	.remove = sata_phy_remove,
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
+		   .of_match_table = phy_i2c_device_match,
+	},
+	.probe = sata_i2c_probe,
+	.id_table = phy_i2c_device_match,
+};
+
+module_platform_driver(sata_phy_driver);
+
+MODULE_DESCRIPTION("EXYNOS SATA PHY DRIVER");
+MODULE_AUTHOR("Vasanth Ananthan, <vasanth.a@samsung.com>");
+MODULE_LICENSE("GPL");
-- 
1.7.4.1

