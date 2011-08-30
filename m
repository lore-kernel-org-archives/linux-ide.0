From: Richard Zhu <richard.zhu@linaro.org>
Subject: [PATCH V7 3/5] MX53 Enable the AHCI SATA on MX53 ARD board
Date: Tue, 30 Aug 2011 17:56:08 +0800
Message-ID: <1314698171-7937-3-git-send-email-richard.zhu@linaro.org>
References: <1314698171-7937-1-git-send-email-richard.zhu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from am1ehsobe003.messaging.microsoft.com ([213.199.154.206]:37225
	"EHLO AM1EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750768Ab1H3J60 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Aug 2011 05:58:26 -0400
In-Reply-To: <1314698171-7937-1-git-send-email-richard.zhu@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: jgarzik@pobox.com, kernel@pengutronix.de, linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, eric@eukrea.com, eric.miao@linaro.org, Richard Zhu <richard.zhu@linaro.org>

Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
---
 arch/arm/mach-mx5/board-mx53_ard.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-mx5/board-mx53_ard.c
index 76a67c4..f7cbbc0 100644
--- a/arch/arm/mach-mx5/board-mx53_ard.c
+++ b/arch/arm/mach-mx5/board-mx53_ard.c
@@ -234,6 +234,7 @@ static void __init mx53_ard_board_init(void)
 	imx53_add_imx_i2c(1, &mx53_ard_i2c2_data);
 	imx53_add_imx_i2c(2, &mx53_ard_i2c3_data);
 	imx_add_gpio_keys(&ard_button_data);
+	imx53_add_ahci_imx(0, NULL);
 }
 
 static void __init mx53_ard_timer_init(void)
-- 
1.7.1


