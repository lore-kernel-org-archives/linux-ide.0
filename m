From: Richard Zhu <richard.zhu@linaro.org>
Subject: [PATCH V9 5/5] MX53 Enable the AHCI SATA on MX53 SMD board
Date: Wed, 28 Sep 2011 15:41:57 +0800
Message-ID: <1317195717-21174-6-git-send-email-richard.zhu@linaro.org>
References: <1317195717-21174-1-git-send-email-richard.zhu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:59504
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752245Ab1I1Hox (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Sep 2011 03:44:53 -0400
In-Reply-To: <1317195717-21174-1-git-send-email-richard.zhu@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: jgarzik@pobox.com, kernel@pengutronix.de, linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, eric@eukrea.com, eric.miao@linaro.org, Richard Zhu <richard.zhu@linaro.org>

Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
---
 arch/arm/mach-mx5/board-mx53_smd.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_smd.c b/arch/arm/mach-mx5/board-mx53_smd.c
index bc02894..efcab68 100644
--- a/arch/arm/mach-mx5/board-mx53_smd.c
+++ b/arch/arm/mach-mx5/board-mx53_smd.c
@@ -35,6 +35,7 @@
 #include "devices-imx53.h"
 
 #define SMD_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
+#define MX53_SMD_SATA_PWR_EN    IMX_GPIO_NR(3, 3)
 
 static iomux_v3_cfg_t mx53_smd_pads[] = {
 	MX53_PAD_CSI0_DAT10__UART1_TXD_MUX,
@@ -111,6 +112,19 @@ static const struct imxi2c_platform_data mx53_smd_i2c_data __initconst = {
 	.bitrate = 100000,
 };
 
+static inline void mx53_smd_ahci_pwr_on(void)
+{
+	int ret;
+
+	/* Enable SATA PWR */
+	ret = gpio_request_one(MX53_SMD_SATA_PWR_EN,
+			GPIOF_DIR_OUT | GPIOF_INIT_HIGH, "ahci-sata-pwr");
+	if (ret) {
+		pr_err("failed to enable SATA_PWR_EN: %d\n", ret);
+		return;
+	}
+}
+
 static void __init mx53_smd_board_init(void)
 {
 	imx53_soc_init();
@@ -125,6 +139,8 @@ static void __init mx53_smd_board_init(void)
 	imx53_add_sdhci_esdhc_imx(0, NULL);
 	imx53_add_sdhci_esdhc_imx(1, NULL);
 	imx53_add_sdhci_esdhc_imx(2, NULL);
+	mx53_smd_ahci_pwr_on();
+	imx53_add_ahci_imx();
 }
 
 static void __init mx53_smd_timer_init(void)
-- 
1.7.1


