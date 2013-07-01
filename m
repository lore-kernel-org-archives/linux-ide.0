From: Richard Zhu <richard.zhuhongxing@gmail.com>
Subject: [v2 2/4] imx: ahci: enable ahci sata on imx6q platforms
Date: Mon,  1 Jul 2013 18:02:53 +0800
Message-ID: <1372672975-2997-3-git-send-email-r65037@freescale.com>
References: <1372672975-2997-1-git-send-email-r65037@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:65389 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578Ab3GAKAv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Jul 2013 06:00:51 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so4851346pad.37
        for <linux-ide@vger.kernel.org>; Mon, 01 Jul 2013 03:00:51 -0700 (PDT)
In-Reply-To: <1372672975-2997-1-git-send-email-r65037@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shawn.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, avorontsov@ru.mvista.com, rob.herring@calxeda.com, s.hauer@pengutronix.de, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

Only the imx6q contains the ahci sata controller,
other imx6 SoCs don't have it.

Enable the ahci sata only on imx6q platforms

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 arch/arm/mach-imx/mach-imx6q.c |   85 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 84 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 045e5e3..ab81fa3 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -30,6 +30,7 @@
 #include <linux/regmap.h>
 #include <linux/micrel_phy.h>
 #include <linux/mfd/syscon.h>
+#include <linux/ahci_platform.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -39,6 +40,8 @@
 #include "cpuidle.h"
 #include "hardware.h"
 
+#define MX6Q_SATA_BASE_ADDR	0x02200000
+
 static u32 chip_revision;
 
 int imx6q_revision(void)
@@ -162,12 +165,92 @@ static void __init imx6q_usb_init(void)
 	imx_anatop_usb_chrg_detect_disable();
 }
 
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
+		if (ret < 0) {
+			dev_err(dev, "can't prepare-enable sata_ref clock\n");
+			clk_put(sata_ref_clk);
+			ret = PTR_ERR(sata_ref_clk);
+		}
+	} else {
+		/* Disable PHY clock */
+		clk_disable_unprepare(sata_ref_clk);
+	}
+
+	return ret;
+}
+
+static int imx6q_sata_init(struct device *dev, void __iomem *addr)
+{
+	int ret = 0;
+	struct regmap *gpr;
+
+	ret = imx6q_sata_phy_clk(dev, true);
+	if (ret < 0)
+		return ret;
+
+	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
+	if (IS_ERR(gpr)) {
+		pr_err("failed to find fsl,imx6q-iomux-gpr regmap\n");
+		return PTR_ERR(gpr);
+	}
+
+	/*
+	 * set PHY Paremeters, two steps to configure the GPR13,
+	 * one write for rest of parameters, mask of first write
+	 * is 0x07fffffd, and the other one write for setting
+	 * the mpll_clk_en.
+	 */
+	regmap_update_bits(gpr, 0x34, 0x07fffffd, 0x0593e4c4);
+	regmap_update_bits(gpr, 0x34, 0x2, 0x2);
+	usleep_range(100, 200);
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
+		pr_err("failed to find fsl,imx6q-iomux-gpr regmap\n");
+
+	regmap_update_bits(gpr, 0x34, 0x2, 0x0);
+
+	imx6q_sata_phy_clk(dev, false);
+}
+
+static struct ahci_platform_data imx6q_sata_pdata = {
+	.init = imx6q_sata_init,
+	.exit = imx6q_sata_exit,
+};
+
+static const struct of_dev_auxdata imx6q_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("snps,imx-ahci", MX6Q_SATA_BASE_ADDR, "imx-ahci",
+			&imx6q_sata_pdata),
+	{ /* sentinel */ }
+};
+
 static void __init imx6q_init_machine(void)
 {
 	if (of_machine_is_compatible("fsl,imx6q-sabrelite"))
 		imx6q_sabrelite_init();
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table,
+			imx6q_auxdata_lookup, NULL);
 
 	imx_anatop_init();
 	imx6q_pm_init();
-- 
1.7.5.4

