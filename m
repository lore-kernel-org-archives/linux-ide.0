From: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Subject: [PATCH V5 2/2] MX53 Enable the AHCI SATA on MX53 LOCO
Date: Thu, 14 Apr 2011 18:28:12 +0800
Message-ID: <1302776892-17243-2-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1302776892-17243-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:59344
	"EHLO VA3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932610Ab1DNK20 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Apr 2011 06:28:26 -0400
In-Reply-To: <1302776892-17243-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: jgarzik@pobox.com, kernel@pengutronix.de, linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, eric@eukrea.com, eric.miao@linaro.org, Richard Zhu <Hong-Xing.Zhu@freescale.com>

Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
---
 arch/arm/mach-mx5/board-mx53_loco.c |   75 +++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 1b947e8..a990992 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -26,6 +26,7 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx53.h>
+#include <mach/ahci_sata.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -39,6 +40,8 @@
 #define MX53_LOCO_UI2			IMX_GPIO_NR(2, 15)
 #define LOCO_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
 
+static struct clk *sata_clk, *sata_ref_clk;
+
 static iomux_v3_cfg_t mx53_loco_pads[] = {
 	/* FEC */
 	MX53_PAD_FEC_MDC__FEC_MDC,
@@ -225,6 +228,77 @@ static const struct imxi2c_platform_data mx53_loco_i2c_data __initconst = {
 	.bitrate = 100000,
 };
 
+/* HW Initialization, if return 0, initialization is successful. */
+static int mx53_loco_sata_init(struct device *dev, void __iomem *addr)
+{
+	u32 tmpdata;
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
+		goto put_sata_clk;
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
+		goto put_sata_ref_clk;
+	}
+
+	/* Get the AHB clock rate, and configure the TIMER1MS reg later */
+	clk = clk_get(NULL, "ahb");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "no ahb clock.\n");
+		ret = PTR_ERR(clk);
+		goto release_sata_ref_clk;
+	}
+	tmpdata = clk_get_rate(clk) / 1000;
+	clk_put(clk);
+
+	sata_init(addr, tmpdata);
+
+	return ret;
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
+static void mx53_loco_sata_exit(struct device *dev)
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
+	.exit = mx53_loco_sata_exit,
+};
+
 static void __init mx53_loco_board_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx53_loco_pads,
@@ -238,6 +312,7 @@ static void __init mx53_loco_board_init(void)
 	imx53_add_sdhci_esdhc_imx(0, NULL);
 	imx53_add_sdhci_esdhc_imx(2, NULL);
 	imx_add_gpio_keys(&loco_button_data);
+	imx53_add_ahci(0, &sata_data);
 }
 
 static void __init mx53_loco_timer_init(void)
-- 
1.7.1


