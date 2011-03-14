From: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Subject: [RFC PATCH 1/2] AHCI Add the AHCI SATA feature on MX53 platforms
Date: Mon, 14 Mar 2011 17:55:43 +0800
Message-ID: <1300096544-1946-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:35893
	"EHLO DB3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754506Ab1CNOJx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Mar 2011 10:09:53 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: jgarzik@pobox.com, kernel@pengutronix.de, linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, eric@eukrea.com, eric.miao@linaro.org, Richard Zhu <Hong-Xing.Zhu@freescale.com>

Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c             |   11 +++++
 arch/arm/mach-mx5/devices-imx53.h               |    4 ++
 arch/arm/plat-mxc/devices/Kconfig               |    4 ++
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-ahci-imx.c   |   55 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/ahci_sata.h      |   51 +++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |   10 ++++
 7 files changed, 136 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-ahci-imx.c
 create mode 100644 arch/arm/plat-mxc/include/mach/ahci_sata.h

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 652ace4..2b3d27c 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1380,6 +1380,14 @@ static struct clk esdhc4_mx53_clk = {
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
 DEFINE_CLOCK(mipi_esc_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG5_OFFSET, NULL, NULL, NULL, &pll2_sw_clk);
 DEFINE_CLOCK(mipi_hsc2_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG4_OFFSET, NULL, NULL, &mipi_esc_clk, &pll2_sw_clk);
 DEFINE_CLOCK(mipi_hsc1_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG3_OFFSET, NULL, NULL, &mipi_hsc2_clk, &pll2_sw_clk);
@@ -1468,6 +1476,9 @@ static struct clk_lookup mx53_lookups[] = {
 	_REGISTER_CLOCK("imx53-cspi.0", NULL, cspi_clk)
 	_REGISTER_CLOCK("imx2-wdt.0", NULL, dummy_clk)
 	_REGISTER_CLOCK("imx2-wdt.1", NULL, dummy_clk)
+	_REGISTER_CLOCK(NULL, "imx_sata_clk", sata_clk)
+	_REGISTER_CLOCK(NULL, "usb_phy1", usb_phy1_clk)
+	_REGISTER_CLOCK(NULL, "ahb_clk", ahb_clk)
 };
 
 static void clk_tree_init(void)
diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/devices-imx53.h
index 9251008..09ebb43 100644
--- a/arch/arm/mach-mx5/devices-imx53.h
+++ b/arch/arm/mach-mx5/devices-imx53.h
@@ -33,3 +33,7 @@ extern const struct imx_spi_imx_data imx53_ecspi_data[] __initconst;
 extern const struct imx_imx2_wdt_data imx53_imx2_wdt_data[] __initconst;
 #define imx53_add_imx2_wdt(id, pdata)	\
 	imx_add_imx2_wdt(&imx53_imx2_wdt_data[id])
+
+extern const struct imx_ahci_imx_data imx53_ahci_imx_data[] __initconst;
+#define imx53_add_ahci_imx(id, pdata)   \
+	imx_add_ahci_imx(&imx53_ahci_imx_data[id], pdata)
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index b9ab1d5..087595a 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -71,3 +71,7 @@ config IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 
 config IMX_HAVE_PLATFORM_SPI_IMX
 	bool
+
+config IMX_HAVE_PLATFORM_SATA_AHCI
+	bool
+	default y if SOC_IMX53
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index 75cd2ec..e0b7fa3 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -22,3 +22,4 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_RNGA) += platform-mxc_rnga.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_W1) += platform-mxc_w1.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX) += platform-sdhci-esdhc-imx.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_SPI_IMX) +=  platform-spi_imx.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_SATA_AHCI) +=  platform-ahci-imx.o
diff --git a/arch/arm/plat-mxc/devices/platform-ahci-imx.c b/arch/arm/plat-mxc/devices/platform-ahci-imx.c
new file mode 100644
index 0000000..a3ed6f7
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-ahci-imx.c
@@ -0,0 +1,55 @@
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
+#include <asm/sizes.h>
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+
+#define imx_ahci_data_entry_single(soc)					\
+	{								\
+		.iobase = soc ## _SATA_BASE_ADDR,			\
+		.irq = soc ## _INT_SATA,				\
+	}
+
+#ifdef CONFIG_SOC_IMX53
+const struct imx_ahci_imx_data imx53_ahci_imx_data __initconst =
+	imx_ahci_data_entry_single(MX53);
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
+	return imx_add_platform_device_dmamask("ahci", 0 /* -1? */,
+			res, ARRAY_SIZE(res),
+			pdata, sizeof(*pdata),  DMA_BIT_MASK(32));
+}
diff --git a/arch/arm/plat-mxc/include/mach/ahci_sata.h b/arch/arm/plat-mxc/include/mach/ahci_sata.h
new file mode 100644
index 0000000..25df23e
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/ahci_sata.h
@@ -0,0 +1,51 @@
+/*
+ * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
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
+	/* Offest used to control the MPLL input clk */
+	PHY_CR_CLOCK_FREQ_OVRD = 0x12,
+	/* Port0 SATA Status */
+	PORT_SATA_SR = 0x128,
+	/* Port0 PHY Control */
+	PORT_PHY_CTL = 0x178,
+	/* PORT_PHY_CTL bits */
+	PORT_PHY_CTL_CAP_ADR_LOC = 0x10000,
+	PORT_PHY_CTL_CAP_DAT_LOC = 0x20000,
+	PORT_PHY_CTL_WRITE_LOC = 0x40000,
+	PORT_PHY_CTL_READ_LOC = 0x80000,
+	/* Port0 PHY Status */
+	PORT_PHY_SR = 0x17c,
+	/* PORT_PHY_SR */
+	PORT_PHY_STAT_DATA_LOC = 0,
+	PORT_PHY_STAT_ACK_LOC = 18,
+	/* SATA PHY Register */
+	SATA_PHY_CR_CLOCK_CRCMP_LT_LIMIT = 0x0001,
+	SATA_PHY_CR_CLOCK_DAC_CTL = 0x0008,
+	SATA_PHY_CR_CLOCK_RTUNE_CTL = 0x0009,
+	SATA_PHY_CR_CLOCK_ADC_OUT = 0x000A,
+	SATA_PHY_CR_CLOCK_MPLL_TST = 0x0017,
+};
+
+#endif /* __PLAT_MXC_AHCI_SATA_H__ */
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 8658c9c..81baca6 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -264,3 +264,13 @@ struct imx_spi_imx_data {
 struct platform_device *__init imx_add_spi_imx(
 		const struct imx_spi_imx_data *data,
 		const struct spi_imx_master *pdata);
+
+#include <linux/ahci_platform.h>
+struct imx_ahci_imx_data {
+	int id;
+	resource_size_t iobase;
+	resource_size_t irq;
+};
+struct platform_device *__init imx_add_ahci_imx(
+		const struct imx_ahci_imx_data *data,
+		const struct ahci_platform_data *pdata);
-- 
1.7.1


