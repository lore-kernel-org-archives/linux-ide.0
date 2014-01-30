From: Mohit Kumar <mohit.kumar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH V3 6/8] SPEAr13xx: Fixup: Move SPEAr1340 SATA platform code to phy driver
Date: Thu, 30 Jan 2014 16:18:48 +0530
Message-ID: <7b9e0a98a6873f66e519791dfba20418e2a68c5a.1391077731.git.mohit.kumar@st.com>
References: <cover.1391077731.git.mohit.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1391077731.git.mohit.kumar-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: arnd-r2nGTMty4D4@public.gmane.org
Cc: Pratyush Anand <pratyush.anand-qxv4g6HH51o@public.gmane.org>, Viresh Kumar <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

From: Pratyush Anand <pratyush.anand-qxv4g6HH51o@public.gmane.org>

ahci driver needs some platform specific functions which are called at
init, exit, suspend and resume conditions. Till now these functions were
present in a platform driver with a fixme notes.

Similar functions modifying same set of registers will also be needed in
case of PCIe phy init/exit.

So move all these SATA platform code to a proper phy driver.

Same phy driver will be used to add PCIe init/exit routine.

Signed-off-by: Pratyush Anand <pratyush.anand-qxv4g6HH51o@public.gmane.org>
Tested-by: Mohit Kumar <mohit.kumar-qxv4g6HH51o@public.gmane.org>
Cc: Viresh Kumar <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 .../devicetree/bindings/phy/spear13xx-miphy.txt    |    8 +
 arch/arm/boot/dts/spear1310-evb.dts                |    4 +
 arch/arm/boot/dts/spear1310.dtsi                   |   36 +++-
 arch/arm/boot/dts/spear1340-evb.dts                |    4 +
 arch/arm/boot/dts/spear1340.dtsi                   |   12 +-
 arch/arm/boot/dts/spear13xx.dtsi                   |    5 +
 arch/arm/mach-spear/Kconfig                        |    2 +
 arch/arm/mach-spear/spear1340.c                    |  127 +--------
 drivers/phy/Kconfig                                |    6 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/phy-spear13xx-sata-pcie.c              |  305 ++++++++++++++++++++
 11 files changed, 380 insertions(+), 130 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/spear13xx-miphy.txt
 create mode 100644 drivers/phy/phy-spear13xx-sata-pcie.c

diff --git a/Documentation/devicetree/bindings/phy/spear13xx-miphy.txt b/Documentation/devicetree/bindings/phy/spear13xx-miphy.txt
new file mode 100644
index 0000000..208b37d
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/spear13xx-miphy.txt
@@ -0,0 +1,8 @@
+Required properties:
+- compatible : should be "st,spear1340-sata-pcie-phy".
+- reg : offset and length of the PHY register set.
+- misc: phandle for the syscon node to access misc registers
+- #phy-cells : from the generic PHY bindings, must be 2.
+	- 1st arg: phandle to the phy node.
+	- 2nd arg: 0 if phy (in 1st arg) is to be used for sata else 1.
+	- 3rd arg: Instance id of the phy (in 1st arg).
diff --git a/arch/arm/boot/dts/spear1310-evb.dts b/arch/arm/boot/dts/spear1310-evb.dts
index b56a801..d42c84b 100644
--- a/arch/arm/boot/dts/spear1310-evb.dts
+++ b/arch/arm/boot/dts/spear1310-evb.dts
@@ -106,6 +106,10 @@
 			status = "okay";
 		};
 
+		miphy@eb800000 {
+			status = "okay";
+		};
+
 		cf@b2800000 {
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/spear1310.dtsi b/arch/arm/boot/dts/spear1310.dtsi
index 122ae94..0d62418 100644
--- a/arch/arm/boot/dts/spear1310.dtsi
+++ b/arch/arm/boot/dts/spear1310.dtsi
@@ -29,24 +29,54 @@
 			#gpio-cells = <2>;
 		};
 
-		ahci@b1000000 {
+		miphy0: miphy@eb800000 {
+			compatible = "st,spear1340-sata-pcie-phy";
+			reg = <0xeb800000 0x4000>;
+			misc = <&misc>;
+			#phy-cells = <2>;
+			status = "disabled";
+		};
+
+		miphy1: miphy@eb804000 {
+			compatible = "st,spear1340-sata-pcie-phy";
+			reg = <0xeb804000 0x4000>;
+			misc = <&misc>;
+			#phy-cells = <2>;
+			status = "disabled";
+		};
+
+		miphy2: miphy@eb808000 {
+			compatible = "st,spear1340-sata-pcie-phy";
+			reg = <0xeb808000 0x4000>;
+			misc = <&misc>;
+			#phy-cells = <2>;
+			status = "disabled";
+		};
+
+		ahci0: ahci@b1000000 {
 			compatible = "snps,spear-ahci";
 			reg = <0xb1000000 0x10000>;
 			interrupts = <0 68 0x4>;
+			phys = <&miphy0 0 0>;
+			phy-names = "ahci-phy";
 			status = "disabled";
 		};
 
-		ahci@b1800000 {
+		ahci1: ahci@b1800000 {
 			compatible = "snps,spear-ahci";
 			reg = <0xb1800000 0x10000>;
 			interrupts = <0 69 0x4>;
+			phys = <&miphy1 0 1>;
+			phy-names = "ahci-phy";
 			status = "disabled";
 		};
 
-		ahci@b4000000 {
+		ahci2: ahci@b4000000 {
 			compatible = "snps,spear-ahci";
 			reg = <0xb4000000 0x10000>;
 			interrupts = <0 70 0x4>;
+			phys = <&miphy2 0 2>;
+			phy-names = "ahci-phy";
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/spear1340-evb.dts b/arch/arm/boot/dts/spear1340-evb.dts
index d6c30ae..b23e05e 100644
--- a/arch/arm/boot/dts/spear1340-evb.dts
+++ b/arch/arm/boot/dts/spear1340-evb.dts
@@ -122,6 +122,10 @@
 			status = "okay";
 		};
 
+		miphy@eb800000 {
+			status = "okay";
+		};
+
 		dma@ea800000 {
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/spear1340.dtsi b/arch/arm/boot/dts/spear1340.dtsi
index 54d128d..c6b0e34 100644
--- a/arch/arm/boot/dts/spear1340.dtsi
+++ b/arch/arm/boot/dts/spear1340.dtsi
@@ -31,10 +31,20 @@
 			status = "disabled";
 		};
 
-		ahci@b1000000 {
+		miphy0: miphy@eb800000 {
+			compatible = "st,spear1340-sata-pcie-phy";
+			reg = <0xeb800000 0x4000>;
+			misc = <&misc>;
+			#phy-cells = <2>;
+			status = "disabled";
+		};
+
+		ahci0: ahci@b1000000 {
 			compatible = "snps,spear-ahci";
 			reg = <0xb1000000 0x10000>;
 			interrupts = <0 72 0x4>;
+			phys = <&miphy0 0 0>;
+			phy-names = "ahci-phy";
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
index 4382547..3a72508 100644
--- a/arch/arm/boot/dts/spear13xx.dtsi
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@ -220,6 +220,11 @@
 				  0xd8000000 0xd8000000 0x01000000
 				  0xe0000000 0xe0000000 0x10000000>;
 
+			misc: syscon@e0700000 {
+				compatible = "st,spear1340-misc", "syscon";
+				reg = <0xe0700000 0x1000>;
+			};
+
 			gpio0: gpio@e0600000 {
 				compatible = "arm,pl061", "arm,primecell";
 				reg = <0xe0600000 0x1000>;
diff --git a/arch/arm/mach-spear/Kconfig b/arch/arm/mach-spear/Kconfig
index ac1710e..44d8543 100644
--- a/arch/arm/mach-spear/Kconfig
+++ b/arch/arm/mach-spear/Kconfig
@@ -26,6 +26,8 @@ config ARCH_SPEAR13XX
 	select MIGHT_HAVE_CACHE_L2X0
 	select PINCTRL
 	select USE_OF
+	select MFD_SYSCON
+	select PHY_SPEAR13XX_SATA_PCIE
 	help
 	  Supports for ARM's SPEAR13XX family
 
diff --git a/arch/arm/mach-spear/spear1340.c b/arch/arm/mach-spear/spear1340.c
index 3fb6834..8e27093 100644
--- a/arch/arm/mach-spear/spear1340.c
+++ b/arch/arm/mach-spear/spear1340.c
@@ -11,138 +11,13 @@
  * warranty of any kind, whether express or implied.
  */
 
-#define pr_fmt(fmt) "SPEAr1340: " fmt
-
-#include <linux/ahci_platform.h>
-#include <linux/amba/serial.h>
-#include <linux/delay.h>
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
 #include "generic.h"
-#include <mach/spear.h>
-
-/* FIXME: Move SATA PHY code into a standalone driver */
-
-/* Base addresses */
-#define SPEAR1340_SATA_BASE			UL(0xB1000000)
-
-/* Power Management Registers */
-#define SPEAR1340_PCM_CFG			(VA_MISC_BASE + 0x100)
-#define SPEAR1340_PCM_WKUP_CFG			(VA_MISC_BASE + 0x104)
-#define SPEAR1340_SWITCH_CTR			(VA_MISC_BASE + 0x108)
-
-#define SPEAR1340_PERIP1_SW_RST			(VA_MISC_BASE + 0x318)
-#define SPEAR1340_PERIP2_SW_RST			(VA_MISC_BASE + 0x31C)
-#define SPEAR1340_PERIP3_SW_RST			(VA_MISC_BASE + 0x320)
-
-/* PCIE - SATA configuration registers */
-#define SPEAR1340_PCIE_SATA_CFG			(VA_MISC_BASE + 0x424)
-	/* PCIE CFG MASks */
-	#define SPEAR1340_PCIE_CFG_DEVICE_PRESENT	(1 << 11)
-	#define SPEAR1340_PCIE_CFG_POWERUP_RESET	(1 << 10)
-	#define SPEAR1340_PCIE_CFG_CORE_CLK_EN		(1 << 9)
-	#define SPEAR1340_PCIE_CFG_AUX_CLK_EN		(1 << 8)
-	#define SPEAR1340_SATA_CFG_TX_CLK_EN		(1 << 4)
-	#define SPEAR1340_SATA_CFG_RX_CLK_EN		(1 << 3)
-	#define SPEAR1340_SATA_CFG_POWERUP_RESET	(1 << 2)
-	#define SPEAR1340_SATA_CFG_PM_CLK_EN		(1 << 1)
-	#define SPEAR1340_PCIE_SATA_SEL_PCIE		(0)
-	#define SPEAR1340_PCIE_SATA_SEL_SATA		(1)
-	#define SPEAR1340_SATA_PCIE_CFG_MASK		0xF1F
-	#define SPEAR1340_PCIE_CFG_VAL	(SPEAR1340_PCIE_SATA_SEL_PCIE | \
-			SPEAR1340_PCIE_CFG_AUX_CLK_EN | \
-			SPEAR1340_PCIE_CFG_CORE_CLK_EN | \
-			SPEAR1340_PCIE_CFG_POWERUP_RESET | \
-			SPEAR1340_PCIE_CFG_DEVICE_PRESENT)
-	#define SPEAR1340_SATA_CFG_VAL	(SPEAR1340_PCIE_SATA_SEL_SATA | \
-			SPEAR1340_SATA_CFG_PM_CLK_EN | \
-			SPEAR1340_SATA_CFG_POWERUP_RESET | \
-			SPEAR1340_SATA_CFG_RX_CLK_EN | \
-			SPEAR1340_SATA_CFG_TX_CLK_EN)
-
-#define SPEAR1340_PCIE_MIPHY_CFG		(VA_MISC_BASE + 0x428)
-	#define SPEAR1340_MIPHY_OSC_BYPASS_EXT		(1 << 31)
-	#define SPEAR1340_MIPHY_CLK_REF_DIV2		(1 << 27)
-	#define SPEAR1340_MIPHY_CLK_REF_DIV4		(2 << 27)
-	#define SPEAR1340_MIPHY_CLK_REF_DIV8		(3 << 27)
-	#define SPEAR1340_MIPHY_PLL_RATIO_TOP(x)	(x << 0)
-	#define SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA \
-			(SPEAR1340_MIPHY_OSC_BYPASS_EXT | \
-			SPEAR1340_MIPHY_CLK_REF_DIV2 | \
-			SPEAR1340_MIPHY_PLL_RATIO_TOP(60))
-	#define SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA_25M_CRYSTAL_CLK \
-			(SPEAR1340_MIPHY_PLL_RATIO_TOP(120))
-	#define SPEAR1340_PCIE_SATA_MIPHY_CFG_PCIE \
-			(SPEAR1340_MIPHY_OSC_BYPASS_EXT | \
-			SPEAR1340_MIPHY_PLL_RATIO_TOP(25))
-
-/* SATA device registration */
-static int sata_miphy_init(struct device *dev, void __iomem *addr)
-{
-	writel(SPEAR1340_SATA_CFG_VAL, SPEAR1340_PCIE_SATA_CFG);
-	writel(SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA_25M_CRYSTAL_CLK,
-			SPEAR1340_PCIE_MIPHY_CFG);
-	/* Switch on sata power domain */
-	writel((readl(SPEAR1340_PCM_CFG) | (0x800)), SPEAR1340_PCM_CFG);
-	msleep(20);
-	/* Disable PCIE SATA Controller reset */
-	writel((readl(SPEAR1340_PERIP1_SW_RST) & (~0x1000)),
-			SPEAR1340_PERIP1_SW_RST);
-	msleep(20);
-
-	return 0;
-}
-
-void sata_miphy_exit(struct device *dev)
-{
-	writel(0, SPEAR1340_PCIE_SATA_CFG);
-	writel(0, SPEAR1340_PCIE_MIPHY_CFG);
-
-	/* Enable PCIE SATA Controller reset */
-	writel((readl(SPEAR1340_PERIP1_SW_RST) | (0x1000)),
-			SPEAR1340_PERIP1_SW_RST);
-	msleep(20);
-	/* Switch off sata power domain */
-	writel((readl(SPEAR1340_PCM_CFG) & (~0x800)), SPEAR1340_PCM_CFG);
-	msleep(20);
-}
-
-int sata_suspend(struct device *dev)
-{
-	if (dev->power.power_state.event == PM_EVENT_FREEZE)
-		return 0;
-
-	sata_miphy_exit(dev);
-
-	return 0;
-}
-
-int sata_resume(struct device *dev)
-{
-	if (dev->power.power_state.event == PM_EVENT_THAW)
-		return 0;
-
-	return sata_miphy_init(dev, NULL);
-}
-
-static struct ahci_platform_data sata_pdata = {
-	.init = sata_miphy_init,
-	.exit = sata_miphy_exit,
-	.suspend = sata_suspend,
-	.resume = sata_resume,
-};
-
-/* Add SPEAr1340 auxdata to pass platform data */
-static struct of_dev_auxdata spear1340_auxdata_lookup[] __initdata = {
-	OF_DEV_AUXDATA("snps,spear-ahci", SPEAR1340_SATA_BASE, NULL,
-			&sata_pdata),
-	{}
-};
 
 static void __init spear1340_dt_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table,
-			spear1340_auxdata_lookup, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static const char * const spear1340_dt_board_compat[] = {
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index a344f3d..ae34fb8 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -51,4 +51,10 @@ config PHY_EXYNOS_DP_VIDEO
 	help
 	  Support for Display Port PHY found on Samsung EXYNOS SoCs.
 
+config PHY_SPEAR13XX_SATA_PCIE
+	tristate "SPEAr13xx SoC SATA PCIe PHY driver"
+	help
+	  Support for SATA and PCIe PHY for SPEAr13xx SoC
+	select GENERIC_PHY
+
 endmenu
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index d0caae9..8941283 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_PHY_EXYNOS_DP_VIDEO)	+= phy-exynos-dp-video.o
 obj-$(CONFIG_PHY_EXYNOS_MIPI_VIDEO)	+= phy-exynos-mipi-video.o
 obj-$(CONFIG_OMAP_USB2)			+= phy-omap-usb2.o
 obj-$(CONFIG_TWL4030_USB)		+= phy-twl4030-usb.o
+obj-$(CONFIG_PHY_SPEAR13XX_SATA_PCIE)	+= phy-spear13xx-sata-pcie.o
diff --git a/drivers/phy/phy-spear13xx-sata-pcie.c b/drivers/phy/phy-spear13xx-sata-pcie.c
new file mode 100644
index 0000000..6adfa64
--- /dev/null
+++ b/drivers/phy/phy-spear13xx-sata-pcie.c
@@ -0,0 +1,305 @@
+/*
+ * ST SPEAr13xx SATA PCIe PHY driver
+ *
+ * Copyright (C) 2014 ST Microelectronics
+ * Pratyush Anand <pratyush.anand-qxv4g6HH51o@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/phy/phy.h>
+#include <linux/regmap.h>
+
+/* SPEAr1340 Registers */
+/* Power Management Registers */
+#define SPEAR1340_PCM_CFG			0x100
+	#define SPEAR1340_PCM_CFG_SATA_POWER_EN	0x800
+#define SPEAR1340_PCM_WKUP_CFG			0x104
+#define SPEAR1340_SWITCH_CTR			0x108
+
+#define SPEAR1340_PERIP1_SW_RST			0x318
+	#define SPEAR1340_PERIP1_SW_RST_SATA	0x1000
+#define SPEAR1340_PERIP2_SW_RST			0x31C
+#define SPEAR1340_PERIP3_SW_RST			0x320
+
+/* PCIE - SATA configuration registers */
+#define SPEAR1340_PCIE_SATA_CFG			0x424
+	/* PCIE CFG MASks */
+	#define SPEAR1340_PCIE_CFG_DEVICE_PRESENT	(1 << 11)
+	#define SPEAR1340_PCIE_CFG_POWERUP_RESET	(1 << 10)
+	#define SPEAR1340_PCIE_CFG_CORE_CLK_EN		(1 << 9)
+	#define SPEAR1340_PCIE_CFG_AUX_CLK_EN		(1 << 8)
+	#define SPEAR1340_SATA_CFG_TX_CLK_EN		(1 << 4)
+	#define SPEAR1340_SATA_CFG_RX_CLK_EN		(1 << 3)
+	#define SPEAR1340_SATA_CFG_POWERUP_RESET	(1 << 2)
+	#define SPEAR1340_SATA_CFG_PM_CLK_EN		(1 << 1)
+	#define SPEAR1340_PCIE_SATA_SEL_PCIE		(0)
+	#define SPEAR1340_PCIE_SATA_SEL_SATA		(1)
+	#define SPEAR1340_PCIE_SATA_CFG_MASK		0xF1F
+	#define SPEAR1340_PCIE_CFG_VAL	(SPEAR1340_PCIE_SATA_SEL_PCIE | \
+			SPEAR1340_PCIE_CFG_AUX_CLK_EN | \
+			SPEAR1340_PCIE_CFG_CORE_CLK_EN | \
+			SPEAR1340_PCIE_CFG_POWERUP_RESET | \
+			SPEAR1340_PCIE_CFG_DEVICE_PRESENT)
+	#define SPEAR1340_SATA_CFG_VAL	(SPEAR1340_PCIE_SATA_SEL_SATA | \
+			SPEAR1340_SATA_CFG_PM_CLK_EN | \
+			SPEAR1340_SATA_CFG_POWERUP_RESET | \
+			SPEAR1340_SATA_CFG_RX_CLK_EN | \
+			SPEAR1340_SATA_CFG_TX_CLK_EN)
+
+#define SPEAR1340_PCIE_MIPHY_CFG		0x428
+	#define SPEAR1340_MIPHY_OSC_BYPASS_EXT		(1 << 31)
+	#define SPEAR1340_MIPHY_CLK_REF_DIV2		(1 << 27)
+	#define SPEAR1340_MIPHY_CLK_REF_DIV4		(2 << 27)
+	#define SPEAR1340_MIPHY_CLK_REF_DIV8		(3 << 27)
+	#define SPEAR1340_MIPHY_PLL_RATIO_TOP(x)	(x << 0)
+	#define SPEAR1340_PCIE_MIPHY_CFG_MASK		0xF80000FF
+	#define SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA \
+			(SPEAR1340_MIPHY_OSC_BYPASS_EXT | \
+			SPEAR1340_MIPHY_CLK_REF_DIV2 | \
+			SPEAR1340_MIPHY_PLL_RATIO_TOP(60))
+	#define SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA_25M_CRYSTAL_CLK \
+			(SPEAR1340_MIPHY_PLL_RATIO_TOP(120))
+	#define SPEAR1340_PCIE_SATA_MIPHY_CFG_PCIE \
+			(SPEAR1340_MIPHY_OSC_BYPASS_EXT | \
+			SPEAR1340_MIPHY_PLL_RATIO_TOP(25))
+
+enum phy_mode {
+	SATA,
+	PCIE
+};
+
+struct spear13xx_phy_priv {
+	/* regmap for SPEAr13xx misc registers */
+	struct regmap		*misc;
+	/* phy struct pointer */
+	struct phy		*phy;
+	/* phy mode: 0 for SATA and 1 for PCIe */
+	enum phy_mode		mode;
+	/* instance id of this phy */
+	u32			id;
+};
+
+static int spear1340_sata_miphy_init(struct spear13xx_phy_priv *phypriv)
+{
+	regmap_update_bits(phypriv->misc, SPEAR1340_PCIE_SATA_CFG,
+			SPEAR1340_PCIE_SATA_CFG_MASK, SPEAR1340_SATA_CFG_VAL);
+	regmap_update_bits(phypriv->misc, SPEAR1340_PCIE_MIPHY_CFG,
+			SPEAR1340_PCIE_MIPHY_CFG_MASK,
+			SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA_25M_CRYSTAL_CLK);
+	/* Switch on sata power domain */
+	regmap_update_bits(phypriv->misc, SPEAR1340_PCM_CFG,
+			SPEAR1340_PCM_CFG_SATA_POWER_EN,
+			SPEAR1340_PCM_CFG_SATA_POWER_EN);
+	msleep(20);
+	/* Disable PCIE SATA Controller reset */
+	regmap_update_bits(phypriv->misc, SPEAR1340_PERIP1_SW_RST,
+			SPEAR1340_PERIP1_SW_RST_SATA, 0);
+	msleep(20);
+
+	return 0;
+}
+
+static int spear1340_sata_miphy_exit(struct spear13xx_phy_priv *phypriv)
+{
+	regmap_update_bits(phypriv->misc, SPEAR1340_PCIE_SATA_CFG,
+			SPEAR1340_PCIE_SATA_CFG_MASK, 0);
+	regmap_update_bits(phypriv->misc, SPEAR1340_PCIE_MIPHY_CFG,
+			SPEAR1340_PCIE_MIPHY_CFG_MASK, 0);
+
+	/* Enable PCIE SATA Controller reset */
+	regmap_update_bits(phypriv->misc, SPEAR1340_PERIP1_SW_RST,
+			SPEAR1340_PERIP1_SW_RST_SATA,
+			SPEAR1340_PERIP1_SW_RST_SATA);
+	msleep(20);
+	/* Switch off sata power domain */
+	regmap_update_bits(phypriv->misc, SPEAR1340_PCM_CFG,
+			SPEAR1340_PCM_CFG_SATA_POWER_EN, 0);
+	msleep(20);
+
+	return 0;
+}
+
+static int sata_miphy_init(struct spear13xx_phy_priv *phypriv)
+{
+	if (of_machine_is_compatible("st,spear1340"))
+		return spear1340_sata_miphy_init(phypriv);
+	else
+		return -EINVAL;
+}
+
+static int sata_miphy_exit(struct spear13xx_phy_priv *phypriv)
+{
+	if (of_machine_is_compatible("st,spear1340"))
+		return spear1340_sata_miphy_exit(phypriv);
+	else
+		return -EINVAL;
+}
+
+static int sata_miphy_suspend(struct spear13xx_phy_priv *phypriv)
+{
+	return sata_miphy_exit(phypriv);
+}
+
+static int sata_miphy_resume(struct spear13xx_phy_priv *phypriv)
+{
+	return sata_miphy_init(phypriv);
+}
+
+static int miphy_init(struct phy *phy)
+{
+	struct spear13xx_phy_priv *phypriv = phy_get_drvdata(phy);
+
+	switch (phypriv->mode) {
+	case SATA:
+		return sata_miphy_init(phypriv);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int miphy_exit(struct phy *phy)
+{
+	struct spear13xx_phy_priv *phypriv = phy_get_drvdata(phy);
+
+	switch (phypriv->mode) {
+	case SATA:
+		return sata_miphy_exit(phypriv);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int miphy_power_off(struct phy *phy)
+{
+	struct spear13xx_phy_priv *phypriv = phy_get_drvdata(phy);
+	struct device *dev = &phy->dev;
+
+	if (dev->power.power_state.event == PM_EVENT_FREEZE)
+		return 0;
+
+	switch (phypriv->mode) {
+	case SATA:
+		return sata_miphy_suspend(phypriv);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int miphy_power_on(struct phy *phy)
+{
+	struct spear13xx_phy_priv *phypriv = phy_get_drvdata(phy);
+	struct device *dev = &phy->dev;
+
+	if (dev->power.power_state.event == PM_EVENT_THAW)
+		return 0;
+
+	switch (phypriv->mode) {
+	case SATA:
+		return sata_miphy_resume(phypriv);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct of_device_id spear13xx_phy_of_match[] = {
+	{ .compatible = "st,spear1340-sata-pcie-phy" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, spear13xx_phy_of_match);
+
+static struct phy_ops spear13xx_sata_pcie_phy_ops = {
+	.init = miphy_init,
+	.exit = miphy_exit,
+	.power_off = miphy_power_off,
+	.power_on = miphy_power_on,
+	.owner		= THIS_MODULE,
+};
+
+static struct phy *spear13xx_sata_pcie_phy_xlate(struct device *dev,
+					struct of_phandle_args *args)
+{
+	struct spear13xx_phy_priv *phypriv = dev_get_drvdata(dev);
+
+	if (args->args_count < 2) {
+		dev_err(dev, "DT did not pass correct no of args\n");
+		return NULL;
+	}
+
+	phypriv->mode = args->args[0];
+	phypriv->id = args->args[1];
+
+	return phypriv->phy;
+}
+
+static int __init spear13xx_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct spear13xx_phy_priv *phypriv;
+	struct phy_provider *phy_provider;
+
+	phypriv = devm_kzalloc(dev, sizeof(*phypriv), GFP_KERNEL);
+	if (!phypriv) {
+		dev_err(dev, "can't alloc sata pcie private date memory\n");
+		return -ENOMEM;
+	}
+
+	phypriv->misc =
+		syscon_regmap_lookup_by_phandle(dev->of_node, "misc");
+	if (IS_ERR(phypriv->misc)) {
+		dev_err(dev, "failed to find SPEAr13xx misc regmap\n");
+		return PTR_ERR(phypriv->misc);
+	}
+
+	phy_provider = devm_of_phy_provider_register(dev,
+			spear13xx_sata_pcie_phy_xlate);
+	if (IS_ERR(phy_provider)) {
+		dev_err(dev, "failed to register phy provider\n");
+		return PTR_ERR(phy_provider);
+	}
+
+	phypriv->phy = devm_phy_create(dev, &spear13xx_sata_pcie_phy_ops, NULL);
+	if (IS_ERR(phypriv->phy)) {
+		dev_err(dev, "failed to create SATA PCIe PHY\n");
+		return PTR_ERR(phypriv->phy);
+	}
+
+	dev_set_drvdata(dev, phypriv);
+	phy_set_drvdata(phypriv->phy, phypriv);
+
+	return 0;
+}
+
+static int __exit spear13xx_phy_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver spear13xx_phy_driver = {
+	.remove		= __exit_p(spear13xx_phy_remove),
+	.driver = {
+		.name = "spear13xx-sata_pcie-phy",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(spear13xx_phy_of_match),
+	},
+};
+
+static int __init spear13xx_phy_init(void)
+{
+
+	return platform_driver_probe(&spear13xx_phy_driver,
+				spear13xx_phy_probe);
+}
+subsys_initcall(spear13xx_phy_init);
+
+MODULE_DESCRIPTION("ST SPEAr13xx SATA PCIe PHY driver");
+MODULE_AUTHOR("Pratyush Anand <pratyush.anand-qxv4g6HH51o@public.gmane.org>");
+MODULE_LICENSE("GPL v2");
-- 
1.7.0.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
