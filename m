From: Richard Zhu <richard.zhuhongxing@gmail.com>
Subject: [v3 3/3] sata: imx: add ahci sata support on imx platforms
Date: Fri,  5 Jul 2013 17:52:22 +0800
Message-ID: <1373017942-12583-4-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1373017942-12583-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:43514 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757069Ab3GEJuV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Jul 2013 05:50:21 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so1988222pbc.7
        for <linux-ide@vger.kernel.org>; Fri, 05 Jul 2013 02:50:21 -0700 (PDT)
In-Reply-To: <1373017942-12583-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shawn.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, avorontsov@ru.mvista.com, rob.herring@calxeda.com, s.hauer@pengutronix.de, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

From: Richard Zhu <r65037@freescale.com>

imx6q contains one Synopsys AHCI SATA controller,
But it can't shares ahci_platform driver with other
controllers.
Because there are some misalignments of the bits
definitions of the HBA registers and the Vendor
Specific registers
 - CAP_SSS(bit20) of the HOST_CAP is writable, default
 value is '0', should be configured to be '1'
 - bit0 (only one AHCI SATA port on imx6q) of the
 HOST_PORTS_IMPL should be set to be '1'.(default 0)
 - One Vendor Specific register HOST_TIMER1MS(offset:0xe0)
 should be configured regarding to the frequency of AHB
 bus clock.
 - Configurations of the AHCI PHY clock, and the signal
 parameters of the GPR13

Setup its own ahci sata driver, enable the imx6q ahci
sata support.

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 drivers/ata/Kconfig    |    9 ++
 drivers/ata/Makefile   |    1 +
 drivers/ata/sata_imx.c |  230 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 240 insertions(+), 0 deletions(-)
 create mode 100644 drivers/ata/sata_imx.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index a5a3ebc..45ed2f0 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -97,6 +97,15 @@ config SATA_AHCI_PLATFORM
 
 	  If unsure, say N.
 
+config SATA_IMX
+	tristate "Freescale iMX AHCI SATA support"
+	depends on SATA_AHCI_PLATFORM
+	help
+	  This option enables support for the Freescale iMX SoC's
+	  onboard AHCI SATA.
+
+	  If unsure, say N.
+
 config SATA_FSL
 	tristate "Freescale 3.0Gbps SATA support"
 	depends on FSL_SOC
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index c04d0fd..04b1c6c 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_SATA_INIC162X)	+= sata_inic162x.o
 obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
 obj-$(CONFIG_SATA_DWC)		+= sata_dwc_460ex.o
 obj-$(CONFIG_SATA_HIGHBANK)	+= sata_highbank.o libahci.o
+obj-$(CONFIG_SATA_IMX)		+= sata_imx.o
 
 # SFF w/ custom DMA
 obj-$(CONFIG_PDC_ADMA)		+= pdc_adma.o
diff --git a/drivers/ata/sata_imx.c b/drivers/ata/sata_imx.c
new file mode 100644
index 0000000..a129efb
--- /dev/null
+++ b/drivers/ata/sata_imx.c
@@ -0,0 +1,230 @@
+/*
+ * Freescale IMX AHCI SATA platform driver
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ *
+ * based on the AHCI SATA platform driver by Jeff Garzik and Anton Vorontsov
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/clk.h>
+#include <linux/kernel.h>
+#include <linux/gfp.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/libata.h>
+#include <linux/ahci_platform.h>
+#include <linux/of_device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
+#include "ahci.h"
+#include <linux/clk-private.h>
+
+enum {
+	HOST_TIMER1MS = 0xe0, /* Timer 1-ms */
+};
+
+/* imx6q ahci module initialization. */
+static int imx6q_sata_phy_clk(struct device *dev, int enable)
+{
+	int ret = 0;
+	struct clk *sata_ref_clk;
+
+	sata_ref_clk = devm_clk_get(dev, "sata_ref_100m");
+	if (IS_ERR(sata_ref_clk)) {
+		dev_err(dev, "can't get sata_ref clock.\n");
+		return PTR_ERR(sata_ref_clk);
+	}
+	if (enable) {
+		/* Enable PHY clock */
+		ret = clk_prepare_enable(sata_ref_clk);
+		if (ret < 0)
+			dev_err(dev, "can't prepare-enable sata_ref clock\n");
+	} else {
+		/* Disable PHY clock */
+		clk_disable_unprepare(sata_ref_clk);
+	}
+
+	return ret;
+}
+
+static int imx6q_sata_init(struct device *dev, void __iomem *mmio)
+{
+	int ret = 0;
+	struct regmap *gpr;
+	struct clk *ahb_clk;
+
+	ret = imx6q_sata_phy_clk(dev, true);
+	if (ret < 0)
+		return ret;
+
+	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
+	if (IS_ERR(gpr)) {
+		dev_err(dev, "failed to find fsl,imx6q-iomux-gpr regmap\n");
+		return PTR_ERR(gpr);
+	}
+
+	/*
+	 * set PHY Paremeters, two steps to configure the GPR13,
+	 * one write for rest of parameters, mask of first write
+	 * is 0x07fffffd, and the other one write for setting
+	 * the mpll_clk_en.
+	 */
+	regmap_update_bits(gpr, 0x34, IMX6Q_GPR13_SATA_RX_EQ_VAL_MASK
+			| IMX6Q_GPR13_SATA_RX_LOS_LVL_MASK
+			| IMX6Q_GPR13_SATA_RX_DPLL_MODE_MASK
+			| IMX6Q_GPR13_SATA_SPD_MODE_MASK
+			| IMX6Q_GPR13_SATA_MPLL_SS_EN
+			| IMX6Q_GPR13_SATA_TX_ATTEN_MASK
+			| IMX6Q_GPR13_SATA_TX_BOOST_MASK
+			| IMX6Q_GPR13_SATA_TX_LVL_MASK
+			| IMX6Q_GPR13_SATA_TX_EDGE_RATE
+			, IMX6Q_GPR13_SATA_RX_EQ_VAL_3_0_DB
+			| IMX6Q_GPR13_SATA_RX_LOS_LVL_SATA2M
+			| IMX6Q_GPR13_SATA_RX_DPLL_MODE_2P_4F
+			| IMX6Q_GPR13_SATA_SPD_MODE_3P0G
+			| IMX6Q_GPR13_SATA_MPLL_SS_EN
+			| IMX6Q_GPR13_SATA_TX_ATTEN_9_16
+			| IMX6Q_GPR13_SATA_TX_BOOST_3_33_DB
+			| IMX6Q_GPR13_SATA_TX_LVL_1_025_V);
+	regmap_update_bits(gpr, 0x34, IMX6Q_GPR13_SATA_MPLL_CLK_EN,
+			IMX6Q_GPR13_SATA_MPLL_CLK_EN);
+	usleep_range(100, 200);
+
+	/*
+	 * Configure the HWINIT bits of the HOST_CAP and HOST_PORTS_IMPL,
+	 * and IP vendor specific register HOST_TIMER1MS.
+	 *
+	 * Configure CAP_SSS (support stagered spin up).
+	 * Implement the port0.
+	 * Get the ahb clock rate, and configure the TIMER1MS register.
+	 */
+	ret = readl(mmio + HOST_CAP);
+	if (!(ret & HOST_CAP_SSS))
+		writel(ret |= HOST_CAP_SSS, mmio + HOST_CAP);
+	ret = readl(mmio + HOST_PORTS_IMPL);
+	if (!(ret & 0x1))
+		writel((ret | 0x1), mmio + HOST_PORTS_IMPL);
+
+	ahb_clk = devm_clk_get(dev, "ahb");
+	if (IS_ERR(ahb_clk)) {
+		dev_err(dev, "no ahb clock.\n");
+		return PTR_ERR(ahb_clk);
+	}
+	ret = clk_get_rate(ahb_clk) / 1000;
+	writel(ret, mmio + HOST_TIMER1MS);
+	devm_clk_put(dev, ahb_clk);
+
+	return 0;
+}
+
+static void imx6q_sata_exit(struct device *dev)
+{
+	struct regmap *gpr;
+
+	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
+	if (IS_ERR(gpr))
+		dev_err(dev, "failed to find fsl,imx6q-iomux-gpr regmap\n");
+
+	regmap_update_bits(gpr, 0x34, IMX6Q_GPR13_SATA_MPLL_CLK_EN,
+			!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
+
+	imx6q_sata_phy_clk(dev, false);
+}
+
+static struct ahci_platform_data imx6q_sata_pdata = {
+	.init = imx6q_sata_init,
+	.exit = imx6q_sata_exit,
+};
+static const struct of_device_id imx_ahci_of_match[] = {
+	{ .compatible = "fsl,imx6q-ahci", .data = &imx6q_sata_pdata},
+	{},
+};
+MODULE_DEVICE_TABLE(of, imx_ahci_of_match);
+
+static void imx_ahci_platform_release(struct device *dev)
+{
+	return;
+}
+
+static struct platform_device ahci_pdev = {
+	.name = "ahci",
+	.id = -1,
+	.dev = {
+		.release = imx_ahci_platform_release,
+	}
+};
+
+static int imx_ahci_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *mem, *irq, **res;
+	const struct of_device_id *of_id;
+	const struct ahci_platform_data *pdata = NULL;
+	int ret;
+
+	of_id = of_match_device(imx_ahci_of_match, &pdev->dev);
+	if (of_id)
+		pdata = of_id->data;
+	else
+		return -EINVAL;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!mem || !irq) {
+		dev_err(dev, "no mmio/irq resource\n");
+		return -EINVAL;
+	}
+
+	ahci_pdev.dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	ahci_pdev.dev.dma_mask = &ahci_pdev.dev.coherent_dma_mask;
+	ahci_pdev.dev.of_node = pdev->dev.of_node;
+
+	res[0] = mem;
+	res[1] = irq;
+	platform_device_add_resources(&ahci_pdev, *res, 2);
+	platform_device_add_data(&ahci_pdev, pdata, sizeof(*pdata));
+
+	ret = platform_device_register(&ahci_pdev);
+	if (!ret)
+		return ret;
+
+	return 0;
+}
+
+static int imx_ahci_remove(struct platform_device *pdev)
+{
+	platform_device_unregister(&ahci_pdev);
+	return 0;
+}
+
+static struct platform_driver imx_ahci_driver = {
+	.probe = imx_ahci_probe,
+	.remove = imx_ahci_remove,
+	.driver = {
+		.name = "sata-imx",
+		.owner = THIS_MODULE,
+		.of_match_table = imx_ahci_of_match,
+	},
+};
+module_platform_driver(imx_ahci_driver);
+
+MODULE_DESCRIPTION("Freescale iMX AHCI SATA platform driver");
+MODULE_AUTHOR("Richard Zhu <Hong-Xing.Zhu@freescale.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("sata:imx");
-- 
1.7.5.4

