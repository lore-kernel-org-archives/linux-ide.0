From: Richard Zhu <richard.zhu@linaro.org>
Subject: [PATCH V7 5/5] MX53 Enable the AHCI SATA on MX53 SMD board
Date: Tue, 30 Aug 2011 17:56:10 +0800
Message-ID: <1314698171-7937-5-git-send-email-richard.zhu@linaro.org>
References: <1314698171-7937-1-git-send-email-richard.zhu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:53276
	"EHLO AM1EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750768Ab1H3J61 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Aug 2011 05:58:27 -0400
In-Reply-To: <1314698171-7937-1-git-send-email-richard.zhu@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: jgarzik@pobox.com, kernel@pengutronix.de, linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, eric@eukrea.com, eric.miao@linaro.org, Richard Zhu <richard.zhu@linaro.org>

Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
---
 arch/arm/mach-mx5/board-mx53_smd.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_smd.c b/arch/arm/mach-mx5/board-mx53_smd.c
index bc02894..3005c7c 100644
--- a/arch/arm/mach-mx5/board-mx53_smd.c
+++ b/arch/arm/mach-mx5/board-mx53_smd.c
@@ -26,6 +26,7 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx53.h>
+#include <mach/ahci_sata.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -35,6 +36,7 @@
 #include "devices-imx53.h"
 
 #define SMD_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
+#define MX53_SMD_SATA_PWR_EN    IMX_GPIO_NR(3, 3)
 
 static iomux_v3_cfg_t mx53_smd_pads[] = {
 	MX53_PAD_CSI0_DAT10__UART1_TXD_MUX,
@@ -111,6 +113,35 @@ static const struct imxi2c_platform_data mx53_smd_i2c_data __initconst = {
 	.bitrate = 100000,
 };
 
+static int mx53_smd_sata_init(struct device *dev, void __iomem *addr)
+{
+	int ret;
+
+	/* Enable SATA PWR */
+	ret = gpio_request(MX53_SMD_SATA_PWR_EN, "ahci-sata-pwr");
+	if (ret) {
+		printk(KERN_ERR "failed to get SATA_PWR_EN: %d\n", ret);
+		return ret;
+	}
+	gpio_direction_output(MX53_SMD_SATA_PWR_EN, 1);
+
+	return sata_init(dev, addr);
+}
+
+void mx53_smd_sata_exit(struct device *dev)
+{
+	sata_exit(dev);
+
+	/* Disable SATA PWR */
+	gpio_direction_output(MX53_SMD_SATA_PWR_EN, 0);
+	gpio_free(MX53_SMD_SATA_PWR_EN);
+}
+
+static struct ahci_platform_data sata_data = {
+	.init = mx53_smd_sata_init,
+	.exit = mx53_smd_sata_exit,
+};
+
 static void __init mx53_smd_board_init(void)
 {
 	imx53_soc_init();
@@ -125,6 +156,7 @@ static void __init mx53_smd_board_init(void)
 	imx53_add_sdhci_esdhc_imx(0, NULL);
 	imx53_add_sdhci_esdhc_imx(1, NULL);
 	imx53_add_sdhci_esdhc_imx(2, NULL);
+	imx53_add_ahci_imx(0, &sata_data);
 }
 
 static void __init mx53_smd_timer_init(void)
-- 
1.7.1


