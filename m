From: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Subject: [PATCH V3 2/2] MX53 Enable the AHCI SATA on MX53 LOCO
Date: Mon, 11 Apr 2011 16:05:53 +0800
Message-ID: <1302509153-30326-2-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1302509153-30326-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:26135
	"EHLO AM1EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754115Ab1DKIGU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Apr 2011 04:06:20 -0400
In-Reply-To: <1302509153-30326-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: jgarzik@pobox.com, kernel@pengutronix.de, linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, eric@eukrea.com, eric.miao@linaro.org, Richard Zhu <Hong-Xing.Zhu@freescale.com>

Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
---
 arch/arm/mach-mx5/board-mx53_loco.c |   76 +++++++++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 0a18f8d..489830a 100644
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
@@ -203,6 +207,77 @@ static const struct imxi2c_platform_data mx53_loco_i2c_data __initconst = {
 	.bitrate = 100000,
 };
 
+/* HW Initialization, if return 0, initialization is successful. */
+static int mx53_loco_sata_init(struct device *dev, void __iomem *addr)
+{
+	int ret = 0;
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
+	sata_init(addr, clk);
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
+	.init = mx53_loco_sata_init,
+	.exit = sata_exit,
+};
+
 static void __init mx53_loco_board_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx53_loco_pads,
@@ -215,6 +290,7 @@ static void __init mx53_loco_board_init(void)
 	imx53_add_imx_i2c(1, &mx53_loco_i2c_data);
 	imx53_add_sdhci_esdhc_imx(0, NULL);
 	imx53_add_sdhci_esdhc_imx(2, NULL);
+	imx53_add_ahci_imx(0, &sata_data);
 }
 
 static void __init mx53_loco_timer_init(void)
-- 
1.7.1


