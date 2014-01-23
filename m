From: Mohit Kumar <mohit.kumar@st.com>
Subject: [PATCH V2 4/8] SPEAr13xx: Fixup: Move SPEAr1340 SATA platform code to system cfg driver
Date: Thu, 23 Jan 2014 16:02:44 +0530
Message-ID: <0c4bf78f2a843625f3175cdf259fad653bd2e86d.1390471111.git.mohit.kumar@st.com>
References: <cover.1390471111.git.mohit.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:41198 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752961AbaAWKdx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Jan 2014 05:33:53 -0500
In-Reply-To: <cover.1390471111.git.mohit.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Pratyush Anand <pratyush.anand@st.com>, Viresh Kumar <viresh.linux@gmail.com>, spear-devel@list.st.com, linux-arm-kernel@lists.infradead.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

From: Pratyush Anand <pratyush.anand@st.com>

ahci driver needs some platform specific functions which are called at
init, exit, suspend and resume conditions. Till now these functions were
present in a platform driver with a fixme notes. These functions
modifies only misc registers and not any phy register. Same misc
registers will also be modified in case of PCIe driver initialization.

Therefore, moving those code from mach-spear/spear1340.c to
mfd/spear13xx-cfg.c.

Same file can further be used to add PCIe system configuration part.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
Tested-by: Mohit Kumar <mohit.kumar@st.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: spear-devel@list.st.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/spear13xx.dtsi |    9 ++
 arch/arm/mach-spear/Kconfig      |    1 +
 arch/arm/mach-spear/spear1340.c  |  127 +--------------------
 drivers/mfd/Makefile             |    1 +
 drivers/mfd/spear13xx-cfg.c      |  239 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 251 insertions(+), 126 deletions(-)
 create mode 100644 drivers/mfd/spear13xx-cfg.c

diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
index 3518803..2b4e58e 100644
--- a/arch/arm/boot/dts/spear13xx.dtsi
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@ -78,6 +78,10 @@
 		status = "disabled";
 	};
 
+	cfg {
+		compatible = "st,spear13xx-cfg";
+	};
+
 	ahb {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -221,6 +225,11 @@
 				  0xd8000000 0xd8000000 0x01000000
 				  0xe0000000 0xe0000000 0x10000000>;
 
+			misc: misc@e0700000 {
+				compatible = "st,spear13xx-misc", "syscon";
+				reg = <0xe0700000 0x1000>;
+			};
+
 			gpio0: gpio@e0600000 {
 				compatible = "arm,pl061", "arm,primecell";
 				reg = <0xe0600000 0x1000>;
diff --git a/arch/arm/mach-spear/Kconfig b/arch/arm/mach-spear/Kconfig
index ac1710e..dedcafb 100644
--- a/arch/arm/mach-spear/Kconfig
+++ b/arch/arm/mach-spear/Kconfig
@@ -26,6 +26,7 @@ config ARCH_SPEAR13XX
 	select MIGHT_HAVE_CACHE_L2X0
 	select PINCTRL
 	select USE_OF
+	select MFD_SYSCON
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
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 8a28dc9..9e5565b 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -164,3 +164,4 @@ obj-$(CONFIG_MFD_RETU)		+= retu-mfd.o
 obj-$(CONFIG_MFD_AS3711)	+= as3711.o
 obj-$(CONFIG_MFD_AS3722)	+= as3722.o
 obj-$(CONFIG_MFD_STW481X)	+= stw481x.o
+obj-$(CONFIG_ARCH_SPEAR13XX)	+= spear13xx-cfg.o
diff --git a/drivers/mfd/spear13xx-cfg.c b/drivers/mfd/spear13xx-cfg.c
new file mode 100644
index 0000000..1cf5785
--- /dev/null
+++ b/drivers/mfd/spear13xx-cfg.c
@@ -0,0 +1,239 @@
+/*
+ * ST SPEAr13xx System Configuration driver
+ *
+ * Copyright (C) 2010-2014 ST Microelectronics
+ * Pratyush Anand <pratyush.anand@st.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/ahci_platform.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
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
+struct spear13xx_cfg_priv {
+	struct regmap		*misc;
+};
+
+/* SATA device registration */
+static void spear1340_sata_miphy_init(struct spear13xx_cfg_priv *cfgpriv)
+{
+	regmap_update_bits(cfgpriv->misc, SPEAR1340_PCIE_SATA_CFG,
+			SPEAR1340_PCIE_SATA_CFG_MASK, SPEAR1340_SATA_CFG_VAL);
+	regmap_update_bits(cfgpriv->misc, SPEAR1340_PCIE_MIPHY_CFG,
+			SPEAR1340_PCIE_MIPHY_CFG_MASK,
+			SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA_25M_CRYSTAL_CLK);
+	/* Switch on sata power domain */
+	regmap_update_bits(cfgpriv->misc, SPEAR1340_PCM_CFG,
+			SPEAR1340_PCM_CFG_SATA_POWER_EN,
+			SPEAR1340_PCM_CFG_SATA_POWER_EN);
+	msleep(20);
+	/* Disable PCIE SATA Controller reset */
+	regmap_update_bits(cfgpriv->misc, SPEAR1340_PERIP1_SW_RST,
+			SPEAR1340_PERIP1_SW_RST_SATA, 0);
+	msleep(20);
+}
+
+static void spear1340_sata_miphy_exit(struct spear13xx_cfg_priv *cfgpriv)
+{
+	regmap_update_bits(cfgpriv->misc, SPEAR1340_PCIE_SATA_CFG,
+			SPEAR1340_PCIE_SATA_CFG_MASK, 0);
+	regmap_update_bits(cfgpriv->misc, SPEAR1340_PCIE_MIPHY_CFG,
+			SPEAR1340_PCIE_MIPHY_CFG_MASK, 0);
+
+	/* Enable PCIE SATA Controller reset */
+	regmap_update_bits(cfgpriv->misc, SPEAR1340_PERIP1_SW_RST,
+			SPEAR1340_PERIP1_SW_RST_SATA,
+			SPEAR1340_PERIP1_SW_RST_SATA);
+	msleep(20);
+	/* Switch off sata power domain */
+	regmap_update_bits(cfgpriv->misc, SPEAR1340_PCM_CFG,
+			SPEAR1340_PCM_CFG_SATA_POWER_EN, 0);
+	msleep(20);
+}
+
+/* SATA device registration */
+static int sata_miphy_init(struct device *dev, void __iomem *addr)
+{
+	struct ahci_platform_data *ahci_pdata = dev_get_platdata(dev);
+	struct spear13xx_cfg_priv *cfgpriv = ahci_pdata->driver_data;
+
+	if (of_machine_is_compatible("st,spear1340"))
+		spear1340_sata_miphy_init(cfgpriv);
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static void sata_miphy_exit(struct device *dev)
+{
+	struct ahci_platform_data *ahci_pdata = dev_get_platdata(dev);
+	struct spear13xx_cfg_priv *cfgpriv = ahci_pdata->driver_data;
+
+	if (of_machine_is_compatible("st,spear1340"))
+		spear1340_sata_miphy_exit(cfgpriv);
+}
+
+static int sata_suspend(struct device *dev)
+{
+	if (dev->power.power_state.event == PM_EVENT_FREEZE)
+		return 0;
+
+	sata_miphy_exit(dev);
+
+	return 0;
+}
+
+static int sata_resume(struct device *dev)
+{
+	if (dev->power.power_state.event == PM_EVENT_THAW)
+		return 0;
+
+	return sata_miphy_init(dev, NULL);
+}
+
+static struct ahci_platform_data sata_pdata = {
+	.init = sata_miphy_init,
+	.exit = sata_miphy_exit,
+	.suspend = sata_suspend,
+	.resume = sata_resume,
+};
+
+static const struct of_device_id spear13xx_cfg_of_match[] = {
+	{ .compatible = "st,spear13xx-cfg" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, spear13xx_cfg_of_match);
+
+static int __init spear13xx_cfg_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ahci_platform_data *ahci_pdata = &sata_pdata;
+	struct spear13xx_cfg_priv *cfgpriv;
+	struct device_node *np_ahci;
+	struct platform_device *ahci_pdev;
+	int ret = 0;
+
+	cfgpriv = devm_kzalloc(dev, sizeof(*cfgpriv), GFP_KERNEL);
+	if (!cfgpriv) {
+		dev_err(dev, "can't alloc sata pcie private date memory\n");
+		return -ENOMEM;
+	}
+
+	cfgpriv->misc =
+		syscon_regmap_lookup_by_compatible("st,spear13xx-misc");
+	if (IS_ERR(cfgpriv->misc)) {
+		dev_err(dev, "failed to find SPEAr13xx misc regmap\n");
+		return PTR_ERR(cfgpriv->misc);
+	}
+
+	np_ahci = of_find_node_by_name(NULL, "ahci");
+	while (!IS_ERR_OR_NULL(np_ahci)) {
+		if (of_device_is_available(np_ahci)) {
+			ahci_pdev = of_find_device_by_node(np_ahci);
+			if (IS_ERR_OR_NULL(ahci_pdev)) {
+				dev_err(dev, "failed to find ahci platform device\n");
+				BUG();
+			}
+
+			ahci_pdata->driver_data = cfgpriv;
+			ret = platform_device_add_data(ahci_pdev, ahci_pdata,
+					sizeof(*ahci_pdata));
+			if (ret)
+				dev_err(dev, "failed to add ahci plat data\n");
+		}
+
+		np_ahci = of_find_node_by_name(np_ahci, "ahci");
+	}
+
+	return ret;
+}
+
+static int __exit spear13xx_cfg_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver spear13xx_cfg_driver = {
+	.remove		= __exit_p(spear13xx_cfg_remove),
+	.driver = {
+		.name = "spear13xx-sata_pcie-cfg",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(spear13xx_cfg_of_match),
+	},
+};
+
+static int __init spear13xx_cfg_init(void)
+{
+
+	return platform_driver_probe(&spear13xx_cfg_driver,
+				spear13xx_cfg_probe);
+}
+arch_initcall(spear13xx_cfg_init);
+
+MODULE_DESCRIPTION("ST SPEAr13xx system configuration driver");
+MODULE_AUTHOR("Pratyush Anand <pratyush.anand@st.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.7.0.1

