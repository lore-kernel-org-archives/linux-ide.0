From: Richard Zhu <richard.zhu@linaro.org>
Subject: [PATCH V7 4/5] MX53 Enable the AHCI SATA on MX53 LOCO board
Date: Tue, 30 Aug 2011 17:56:09 +0800
Message-ID: <1314698171-7937-4-git-send-email-richard.zhu@linaro.org>
References: <1314698171-7937-1-git-send-email-richard.zhu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:50098
	"EHLO AM1EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750768Ab1H3J43 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Aug 2011 05:56:29 -0400
In-Reply-To: <1314698171-7937-1-git-send-email-richard.zhu@linaro.org>
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


