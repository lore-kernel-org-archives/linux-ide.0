From: Richard Zhu <richard.zhuhongxing@gmail.com>
Subject: [v1 3/3] imx: ahci: enable ahci sata on imx6q platforms
Date: Mon, 17 Jun 2013 17:52:47 +0800
Message-ID: <1371462767-16630-4-git-send-email-r65037@freescale.com>
References: <1371462767-16630-1-git-send-email-r65037@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:60632 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932201Ab3FQJu5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Jun 2013 05:50:57 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so2616305pbc.15
        for <linux-ide@vger.kernel.org>; Mon, 17 Jun 2013 02:50:57 -0700 (PDT)
In-Reply-To: <1371462767-16630-1-git-send-email-r65037@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shawn.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

Only the imx6q contains the ahci sata controller,
other imx6 SoCs don't have it.

Enable the ahci sata only on imx6q platforms

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 arch/arm/mach-imx/mach-imx6q.c |  179 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 178 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 045e5e3..68b0a45 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -10,6 +10,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <linux/ahci_platform.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
@@ -23,6 +24,7 @@
 #include <linux/irqchip.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/opp.h>
@@ -39,6 +41,22 @@
 #include "cpuidle.h"
 #include "hardware.h"
 
+#define MX6Q_SATA_BASE_ADDR	0x02200000
+
+enum {
+	HOST_CAP = 0x00,
+	HOST_CAP_SSS = (1 << 27), /* Staggered Spin-up */
+	HOST_CTL = 0x04, /* global host control */
+	HOST_RESET = (1 << 0),  /* reset controller; self-clear */
+	HOST_PORTS_IMPL	= 0x0c, /* bitmap of implemented ports */
+	HOST_TIMER1MS = 0xe0, /* Timer 1-ms */
+	HOST_VERSIONR = 0xf8, /* host version register*/
+
+	PORT_SATA_SR = 0x128, /* Port0 SATA Status */
+	PORT_PHY_CTL = 0x178, /* Port0 PHY Control */
+	PORT_PHY_CTL_PDDQ_LOC = 0x100000, /* PORT_PHY_CTL bits */
+};
+
 static u32 chip_revision;
 
 int imx6q_revision(void)
@@ -162,12 +180,171 @@ static void __init imx6q_usb_init(void)
 	imx_anatop_usb_chrg_detect_disable();
 }
 
+/* imx ahci module initialization. */
+static int imx_sata_init(struct device *dev, void __iomem *addr)
+{
+	int ret = 0, iterations = 100;
+	struct clk *ahb_clk, *sata_clk, *sata_ref_clk;
+	struct regmap *gpr;
+
+	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
+	if (IS_ERR(gpr)) {
+		pr_err("failed to find fsl,imx6q-iomux-gpr regmap\n");
+		return PTR_ERR(gpr);
+	}
+
+	/* enable the clks */
+	sata_clk = devm_clk_get(dev, "sata");
+	if (IS_ERR(sata_clk)) {
+		dev_err(dev, "can't get sata clock.\n");
+		return PTR_ERR(sata_clk);
+	}
+	ret = clk_prepare_enable(sata_clk);
+	if (ret < 0) {
+		dev_err(dev, "can't prepare-enable sata clock\n");
+		clk_put(sata_clk);
+		return ret;
+	}
+	sata_ref_clk = devm_clk_get(dev, "sata_ref_100m");
+	if (IS_ERR(sata_ref_clk)) {
+		dev_err(dev, "can't get sata_ref clock.\n");
+		ret = PTR_ERR(sata_ref_clk);
+		goto release_sata_clk;
+	}
+	ret = clk_prepare_enable(sata_ref_clk);
+	if (ret < 0) {
+		dev_err(dev, "can't prepare-enable sata_ref clock\n");
+		clk_put(sata_ref_clk);
+		ret = PTR_ERR(sata_ref_clk);
+		goto release_sata_clk;
+	}
+
+	/* set PHY Paremeters, two steps to configure the GPR13,
+	 * one write for rest of parameters, mask of first write is 0x07fffffd,
+	 * and the other one write for setting the mpll_clk_off_b
+	 *.rx_eq_val_0(iomuxc_gpr13[26:24]),
+	 *.los_lvl(iomuxc_gpr13[23:19]),
+	 *.rx_dpll_mode_0(iomuxc_gpr13[18:16]),
+	 *.mpll_ss_en(iomuxc_gpr13[14]),
+	 *.tx_atten_0(iomuxc_gpr13[13:11]),
+	 *.tx_boost_0(iomuxc_gpr13[10:7]),
+	 *.tx_lvl(iomuxc_gpr13[6:2]),
+	 *.mpll_clk_off(iomuxc_gpr13[1]),
+	 *.tx_edgerate_0(iomuxc_gpr13[0]),
+	 */
+	regmap_update_bits(gpr, 0x34, 0x07fffffd, 0x0593e4c4);
+	regmap_update_bits(gpr, 0x34, 0x2, 0x2);
+
+	/*  reset hba */
+	writel(HOST_RESET, addr + HOST_CTL);
+	ret = 0;
+	while (readl(addr + HOST_VERSIONR) == 0) {
+		ret++;
+		usleep_range(1, 2);
+		if (ret > 100) {
+			dev_info(dev, "can't recover from reset hba!\n");
+			break;
+		}
+	}
+
+	/* get the ahb clock rate, and configure the TIMER1MS reg later */
+	ahb_clk = clk_get_sys(NULL, "ahb");
+	if (IS_ERR(ahb_clk)) {
+		dev_err(dev, "no ahb clock.\n");
+		ret = PTR_ERR(ahb_clk);
+		goto error;
+	}
+	ret = clk_get_rate(ahb_clk) / 1000;
+	clk_put(ahb_clk);
+	writel(ret, addr + HOST_TIMER1MS);
+
+	/*
+	 * configure CAP_SSS (support stagered spin up),
+	 * and implement the port0
+	 */
+	ret = readl(addr + HOST_CAP);
+	if (!(ret & HOST_CAP_SSS))
+		writel(ret |= HOST_CAP_SSS, addr + HOST_CAP);
+	ret = readl(addr + HOST_PORTS_IMPL);
+	if (!(ret & 0x1))
+		writel((ret | 0x1), addr + HOST_PORTS_IMPL);
+
+	/*
+	 * no device detected on the port, in order to save the power
+	 * consumption, enter into iddq mode(power down circuitry)
+	 * and release the clocks.
+	 * NOTE:in this case, the sata port can't be used anymore
+	 * without one system reboot.
+	 */
+	do {
+		if ((readl(addr + PORT_SATA_SR) & 0xF) == 0)
+			usleep_range(100, 200);
+		else
+			break;
+
+		if (iterations == 0) {
+			/*  enter into iddq mode, save power */
+			pr_info("no sata disk, enter into pddq mode.\n");
+			ret = readl(addr + PORT_PHY_CTL);
+			ret |= PORT_PHY_CTL_PDDQ_LOC;
+			writel(ret, addr + PORT_PHY_CTL);
+			ret = -ENODEV;
+			goto error;
+		}
+	} while (iterations-- > 0);
+
+	return 0;
+
+error:
+	regmap_update_bits(gpr, 0x34, 0x2, 0x0);
+	clk_disable_unprepare(sata_ref_clk);
+release_sata_clk:
+	clk_disable_unprepare(sata_clk);
+
+	return ret;
+}
+
+static void imx_sata_exit(struct device *dev)
+{
+	struct clk *sata_clk, *sata_ref_clk;
+	struct regmap *gpr;
+
+	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
+	if (IS_ERR(gpr))
+		pr_err("failed to find fsl,imx6q-iomux-gpr regmap\n");
+
+	regmap_update_bits(gpr, 0x34, 0x2, 0x0);
+
+	sata_clk = devm_clk_get(dev, "sata");
+	if (IS_ERR(sata_clk))
+		dev_err(dev, "can't get sata clock.\n");
+	else
+		clk_disable_unprepare(sata_clk);
+	sata_ref_clk = devm_clk_get(dev, "sata_ref_100m");
+	if (IS_ERR(sata_ref_clk))
+		dev_err(dev, "can't get sata_ref clock.\n");
+	else
+		clk_disable_unprepare(sata_ref_clk);
+}
+
+static struct ahci_platform_data imx_sata_pdata = {
+	.init = imx_sata_init,
+	.exit = imx_sata_exit,
+};
+
+static const struct of_dev_auxdata imx6q_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("snps,imx-ahci", MX6Q_SATA_BASE_ADDR, "imx-ahci",
+			&imx_sata_pdata),
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

