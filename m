From: Richard Zhu <richard.zhu@linaro.org>
Subject: [PATCH V6 4/5] MX53 Enable the AHCI SATA on MX53 LOCO board
Date: Mon, 29 Aug 2011 15:18:57 +0800
Message-ID: <1314602339-18392-4-git-send-email-richard.zhu@linaro.org>
References: <1314602339-18392-1-git-send-email-richard.zhu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:17162
	"EHLO VA3EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751080Ab1H2HUo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Aug 2011 03:20:44 -0400
In-Reply-To: <1314602339-18392-1-git-send-email-richard.zhu@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: jgarzik@pobox.com, kernel@pengutronix.de, linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, eric@eukrea.com, eric.miao@linaro.org, Richard Zhu <richard.zhu@linaro.org>

Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
---
 arch/arm/mach-mx5/board-mx53_loco.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 4e1d51d..551fc7c 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -26,6 +26,7 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx53.h>
+#include <mach/ahci_sata.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -257,6 +258,11 @@ static const struct gpio_led_platform_data mx53loco_leds_data __initconst = {
 	.num_leds	= ARRAY_SIZE(mx53loco_leds),
 };
 
+static struct ahci_platform_data sata_data = {
+	.init = sata_init,
+	.exit = sata_exit,
+};
+
 static void __init mx53_loco_board_init(void)
 {
 	imx53_soc_init();
@@ -273,6 +279,7 @@ static void __init mx53_loco_board_init(void)
 	imx53_add_sdhci_esdhc_imx(2, &mx53_loco_sd3_data);
 	imx_add_gpio_keys(&loco_button_data);
 	gpio_led_register_device(-1, &mx53loco_leds_data);
+	imx53_add_ahci_imx(0, &sata_data);
 }
 
 static void __init mx53_loco_timer_init(void)
-- 
1.7.1


