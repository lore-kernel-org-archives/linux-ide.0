From: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Subject: [PATCH V2 2/2] MX53 Enable the AHCI SATA on MX53 LOCO
Date: Thu, 17 Mar 2011 17:58:03 +0800
Message-ID: <1300355883-28484-2-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1300355883-28484-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:22474
	"EHLO VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752890Ab1CQJ6s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Mar 2011 05:58:48 -0400
In-Reply-To: <1300355883-28484-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: jgarzik@pobox.com, kernel@pengutronix.de, linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, eric@eukrea.com, eric.miao@linaro.org, Richard Zhu <Hong-Xing.Zhu@freescale.com>

Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
---
 arch/arm/mach-mx5/board-mx53_loco.c |   88 +++++++++++++++++++++++++++++++++++
 1 files changed, 88 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 0a18f8d..336273b 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -23,11 +23,13 @@
 #include <linux/fec.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/ahci_platform.h>
 
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx53.h>
+#include <mach/ahci_sata.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -38,6 +40,8 @@
 
 #define LOCO_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
 
+static struct clk *sata_clk, *sata_ref_clk;
+
 static iomux_v3_cfg_t mx53_loco_pads[] = {
 	/* FEC */
 	MX53_PAD_FEC_MDC__FEC_MDC,
@@ -203,6 +207,89 @@ static const struct imxi2c_platform_data mx53_loco_i2c_data __initconst = {
 	.bitrate = 100000,
 };
 
+/* HW Initialization, if return 0, initialization is successful. */
+static int sata_init(struct device *dev, void __iomem *addr)
+{
+	int ret = 0;
+	u32 tmpdata;
+	struct clk *clk;
+
+	sata_clk = clk_get(dev, NULL);
+	if (IS_ERR(sata_clk)) {
+		dev_err(dev, "no sata clock.\n");
+		return PTR_ERR(sata_clk);
+	}
+	ret = clk_enable(sata_clk);
+	if (ret) {
+		dev_err(dev, "can't enable sata clock.\n");
+		clk_put(sata_clk);
+		return ret;
+	}
+
+	/* FSL IMX AHCI SATA uses the internal usb phy1 clk on loco */
+	sata_ref_clk = clk_get(NULL, "usb_phy1");
+	if (IS_ERR(sata_ref_clk)) {
+		dev_err(dev, "no sata ref clock.\n");
+		ret = PTR_ERR(sata_ref_clk);
+		goto release_sata_clk;
+	}
+	ret = clk_enable(sata_ref_clk);
+	if (ret) {
+		dev_err(dev, "can't enable sata ref clock.\n");
+		clk_put(sata_ref_clk);
+		goto release_sata_clk;
+	}
+
+	/* Get the AHB clock rate, and configure the TIMER1MS reg later */
+	clk = clk_get(NULL, "ahb");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "no ahb clock.\n");
+		ret = PTR_ERR(clk);
+		goto release_sata_ref_clk;
+	}
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
+	tmpdata = clk_get_rate(clk) / 1000;
+	clk_put(clk);
+	writel(tmpdata, addr + HOST_TIMER1MS);
+
+	clk = NULL;
+	return ret;
+
+release_sata_ref_clk:
+	clk_disable(sata_ref_clk);
+	clk_put(sata_ref_clk);
+
+release_sata_clk:
+	clk_disable(sata_clk);
+	clk_put(sata_clk);
+
+	clk = NULL;
+	return ret;
+}
+
+static void sata_exit(struct device *dev)
+{
+	clk_disable(sata_ref_clk);
+	clk_put(sata_ref_clk);
+
+	clk_disable(sata_clk);
+	clk_put(sata_clk);
+}
+
+static struct ahci_platform_data sata_data = {
+	.init = sata_init,
+	.exit = sata_exit, };
+
 static void __init mx53_loco_board_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx53_loco_pads,
@@ -215,6 +302,7 @@ static void __init mx53_loco_board_init(void)
 	imx53_add_imx_i2c(1, &mx53_loco_i2c_data);
 	imx53_add_sdhci_esdhc_imx(0, NULL);
 	imx53_add_sdhci_esdhc_imx(2, NULL);
+	imx53_add_ahci_imx(0, &sata_data);
 }
 
 static void __init mx53_loco_timer_init(void)
-- 
1.7.1


