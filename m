From: Richard Zhu <richard.zhu@linaro.org>
Subject: [PATCH V7 4/5] MX53 Enable the AHCI SATA on MX53 LOCO board
Date: Wed, 31 Aug 2011 11:50:34 +0800
Message-ID: <1314762635-3923-5-git-send-email-richard.zhu@linaro.org>
References: <1314762635-3923-1-git-send-email-richard.zhu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:19120
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752300Ab1HaDuw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Aug 2011 23:50:52 -0400
In-Reply-To: <1314762635-3923-1-git-send-email-richard.zhu@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: jgarzik@pobox.com, kernel@pengutronix.de, linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, eric@eukrea.com, eric.miao@linaro.org, Richard Zhu <richard.zhu@linaro.org>

Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
---
 arch/arm/mach-mx5/board-mx53_loco.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 4e1d51d..76a7af7 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -273,6 +273,7 @@ static void __init mx53_loco_board_init(void)
 	imx53_add_sdhci_esdhc_imx(2, &mx53_loco_sd3_data);
 	imx_add_gpio_keys(&loco_button_data);
 	gpio_led_register_device(-1, &mx53loco_leds_data);
+	imx53_add_ahci_imx(0, NULL);
 }
 
 static void __init mx53_loco_timer_init(void)
-- 
1.7.1


