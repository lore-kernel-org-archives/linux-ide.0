From: Richard Zhu <richard.zhu@linaro.org>
Subject: [PATCH V6 1/5] AHCI Add the AHCI SATA feature on the MX53 platforms
Date: Mon, 29 Aug 2011 15:18:54 +0800
Message-ID: <1314602339-18392-1-git-send-email-richard.zhu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:24532 "EHLO
	TX2EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752824Ab1H2HU0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Aug 2011 03:20:26 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: jgarzik@pobox.com, kernel@pengutronix.de, linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, eric@eukrea.com, eric.miao@linaro.org, Richard Zhu <richard.zhu@linaro.org>

Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c             |   19 ++++
 arch/arm/mach-mx5/devices-imx53.h               |    4 +
 arch/arm/plat-mxc/Makefile                      |    1 +
 arch/arm/plat-mxc/ahci_sata.c                   |  104 +++++++++++++++++++++++
 arch/arm/plat-mxc/devices/Kconfig               |    4 +
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-ahci-imx.c   |   57 ++++++++++++
 arch/arm/plat-mxc/include/mach/ahci_sata.h      |   33 +++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |   10 ++
 9 files changed, 233 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-mxc/ahci_sata.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-ahci-imx.c
 create mode 100644 arch/arm/plat-mxc/include/mach/ahci_sata.h

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 7f20308..e1fadaf 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1397,6 +1397,22 @@ static struct clk esdhc4_mx53_clk = {
 	.secondary = &esdhc4_ipg_clk,
 };
 
+static struct clk sata_clk = {
+	.parent = &ipg_clk,
+	.enable = _clk_max_enable,
+	.enable_reg = MXC_CCM_CCGR4,
+	.enable_shift = MXC_CCM_CCGRx_CG1_OFFSET,
+	.disable = _clk_max_disable,
+};
+
+static struct clk ahci_phy_clk = {
+	.parent = &usb_phy1_clk,
+};
+
+static struct clk ahci_dma_clk = {
+	.parent = &ahb_clk,
+};
+
 DEFINE_CLOCK(mipi_esc_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG5_OFFSET, NULL, NULL, NULL, &pll2_sw_clk);
 DEFINE_CLOCK(mipi_hsc2_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG4_OFFSET, NULL, NULL, &mipi_esc_clk, &pll2_sw_clk);
 DEFINE_CLOCK(mipi_hsc1_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG3_OFFSET, NULL, NULL, &mipi_hsc2_clk, &pll2_sw_clk);
@@ -1503,6 +1519,9 @@ static struct clk_lookup mx53_lookups[] = {
 	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
 	_REGISTER_CLOCK("imx-ssi.2", NULL, ssi3_clk)
 	_REGISTER_CLOCK("imx-keypad", NULL, dummy_clk)
+	_REGISTER_CLOCK("imx53-ahci.0", "ahci", sata_clk)
+	_REGISTER_CLOCK("imx53-ahci.0", "ahci_phy", ahci_phy_clk)
+	_REGISTER_CLOCK("imx53-ahci.0", "ahci_dma", ahci_dma_clk)
 };
 
 static void clk_tree_init(void)
diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/devices-imx53.h
index c27fe8b..bcb3af1 100644
--- a/arch/arm/mach-mx5/devices-imx53.h
+++ b/arch/arm/mach-mx5/devices-imx53.h
@@ -40,3 +40,7 @@ extern const struct imx_imx_ssi_data imx53_imx_ssi_data[];
 extern const struct imx_imx_keypad_data imx53_imx_keypad_data;
 #define imx53_add_imx_keypad(pdata)	\
 	imx_add_imx_keypad(&imx53_imx_keypad_data, pdata)
+
+extern const struct imx_ahci_imx_data imx53_ahci_imx_data __initconst;
+#define imx53_add_ahci_imx(id, pdata)   \
+	imx_add_ahci_imx(&imx53_ahci_imx_data, pdata)
diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index d53c35f..cc8e65a 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_ARCH_MXC_AUDMUX_V1) += audmux-v1.o
 obj-$(CONFIG_ARCH_MXC_AUDMUX_V2) += audmux-v2.o
 obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
 obj-$(CONFIG_CPU_FREQ_IMX)    += cpufreq.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_AHCI)	+= ahci_sata.o
 ifdef CONFIG_SND_IMX_SOC
 obj-y += ssi-fiq.o
 obj-y += ssi-fiq-ksym.o
diff --git a/arch/arm/plat-mxc/ahci_sata.c b/arch/arm/plat-mxc/ahci_sata.c
new file mode 100644
index 0000000..4f54816
--- /dev/null
+++ b/arch/arm/plat-mxc/ahci_sata.c
@@ -0,0 +1,104 @@
+/*
+ * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/device.h>
+#include <mach/ahci_sata.h>
+
+static struct clk *sata_clk, *sata_ref_clk;
+
+/* AHCI module Initialization, if return 0, initialization is successful. */
+int sata_init(struct device *dev, void __iomem *addr)
+{
+	u32 tmpdata;
+	int ret = 0;
+	struct clk *clk;
+
+	sata_clk = clk_get(dev, "ahci");
+	if (IS_ERR(sata_clk)) {
+		dev_err(dev, "no sata clock.\n");
+		return PTR_ERR(sata_clk);
+	}
+	ret = clk_enable(sata_clk);
+	if (ret) {
+		dev_err(dev, "can't enable sata clock.\n");
+		goto put_sata_clk;
+	}
+
+	/* FSL IMX AHCI SATA uses the internal usb phy1 clk on loco */
+	sata_ref_clk = clk_get(dev, "ahci_phy");
+	if (IS_ERR(sata_ref_clk)) {
+		dev_err(dev, "no sata ref clock.\n");
+		ret = PTR_ERR(sata_ref_clk);
+		goto release_sata_clk;
+	}
+	ret = clk_enable(sata_ref_clk);
+	if (ret) {
+		dev_err(dev, "can't enable sata ref clock.\n");
+		goto put_sata_ref_clk;
+	}
+
+	/* Get the AHB clock rate, and configure the TIMER1MS reg later */
+	clk = clk_get(dev, "ahci_dma");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "no dma clock.\n");
+		ret = PTR_ERR(clk);
+		goto release_sata_ref_clk;
+	}
+	tmpdata = clk_get_rate(clk) / 1000;
+	clk_put(clk);
+
+	writel(tmpdata, addr + HOST_TIMER1MS);
+
+	tmpdata = readl(addr + HOST_CAP);
+	if (!(tmpdata & HOST_CAP_SSS)) {
+		tmpdata |= HOST_CAP_SSS;
+		writel(tmpdata, addr + HOST_CAP);
+	}
+
+	if (!(readl(addr + HOST_PORTS_IMPL) & 0x1))
+		writel((readl(addr + HOST_PORTS_IMPL) | 0x1),
+			addr + HOST_PORTS_IMPL);
+
+	return 0;
+
+release_sata_ref_clk:
+	clk_disable(sata_ref_clk);
+put_sata_ref_clk:
+	clk_put(sata_ref_clk);
+release_sata_clk:
+	clk_disable(sata_clk);
+put_sata_clk:
+	clk_put(sata_clk);
+
+	return ret;
+}
+
+void sata_exit(struct device *dev)
+{
+	clk_disable(sata_ref_clk);
+	clk_put(sata_ref_clk);
+
+	clk_disable(sata_clk);
+	clk_put(sata_clk);
+
+}
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index bd294ad..f63887b 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -76,3 +76,7 @@ config IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 
 config IMX_HAVE_PLATFORM_SPI_IMX
 	bool
+
+config IMX_HAVE_PLATFORM_AHCI
+	bool
+	default y if ARCH_MX53
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index b41bf97..e858ad9 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -25,3 +25,4 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_RTC) += platform-mxc_rtc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_W1) += platform-mxc_w1.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX) += platform-sdhci-esdhc-imx.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_SPI_IMX) +=  platform-spi_imx.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_AHCI) +=  platform-ahci-imx.o
diff --git a/arch/arm/plat-mxc/devices/platform-ahci-imx.c b/arch/arm/plat-mxc/devices/platform-ahci-imx.c
new file mode 100644
index 0000000..77c0552
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-ahci-imx.c
@@ -0,0 +1,57 @@
+/*
+ * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <linux/dma-mapping.h>
+#include <asm/sizes.h>
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+
+#define imx_ahci_imx_data_entry_single(soc, _devid)		\
+	{								\
+		.devid = _devid,					\
+		.iobase = soc ## _SATA_BASE_ADDR,			\
+		.irq = soc ## _INT_SATA,				\
+	}
+
+#ifdef CONFIG_SOC_IMX53
+const struct imx_ahci_imx_data imx53_ahci_imx_data __initconst =
+	imx_ahci_imx_data_entry_single(MX53, "imx53-ahci");
+#endif
+
+struct platform_device *__init imx_add_ahci_imx(
+		const struct imx_ahci_imx_data *data,
+		const struct ahci_platform_data *pdata)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobase,
+			.end = data->iobase + SZ_4K - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = data->irq,
+			.end = data->irq,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+
+	return imx_add_platform_device_dmamask(data->devid, 0,
+			res, ARRAY_SIZE(res),
+			pdata, sizeof(*pdata),  DMA_BIT_MASK(32));
+}
diff --git a/arch/arm/plat-mxc/include/mach/ahci_sata.h b/arch/arm/plat-mxc/include/mach/ahci_sata.h
new file mode 100644
index 0000000..ba297e1
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/ahci_sata.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef __PLAT_MXC_AHCI_SATA_H__
+#define __PLAT_MXC_AHCI_SATA_H__
+
+enum {
+	HOST_CAP = 0x00,
+	HOST_CAP_SSS = (1 << 27), /* Staggered Spin-up */
+	HOST_PORTS_IMPL	= 0x0c,
+	HOST_TIMER1MS = 0xe0, /* Timer 1-ms */
+};
+
+extern int sata_init(struct device *dev, void __iomem *addr);
+extern void sata_exit(struct device *dev);
+#endif /* __PLAT_MXC_AHCI_SATA_H__ */
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 524538a..f04e063 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -301,3 +301,13 @@ struct platform_device *__init imx_add_spi_imx(
 struct platform_device *imx_add_imx_dma(void);
 struct platform_device *imx_add_imx_sdma(char *name,
 	resource_size_t iobase, int irq, struct sdma_platform_data *pdata);
+
+#include <linux/ahci_platform.h>
+struct imx_ahci_imx_data {
+	const char *devid;
+	resource_size_t iobase;
+	resource_size_t irq;
+};
+struct platform_device *__init imx_add_ahci_imx(
+		const struct imx_ahci_imx_data *data,
+		const struct ahci_platform_data *pdata);
-- 
1.7.1


