From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] phy: qcom-apq8064: fix possible timeout without check
Date: Wed, 16 Jul 2014 09:18:43 +0100
Message-ID: <1405498723-10681-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38273 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbaGPITA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jul 2014 04:19:00 -0400
Received: by mail-wi0-f180.google.com with SMTP id n3so842807wiv.7
        for <linux-ide@vger.kernel.org>; Wed, 16 Jul 2014 01:18:59 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-ide@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch fixes a possible timeout in poll loop without actually
checking the register before return. In theory the there is a possibility
of loop being scheduled after a long lock/delay, which would then force
the loop to exit without actually checking the register.

Reported-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Hi Kishon, 

Just to make it easy for you, am sending this change as a seperate
patch so that you can apply it on top of linux-phy next.

Thanks,
srini

 drivers/phy/phy-qcom-apq8064-sata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-qcom-apq8064-sata.c b/drivers/phy/phy-qcom-apq8064-sata.c
index c9b4dd6..f91e254 100644
--- a/drivers/phy/phy-qcom-apq8064-sata.c
+++ b/drivers/phy/phy-qcom-apq8064-sata.c
@@ -91,7 +91,7 @@ static int read_poll_timeout(void __iomem *addr, u32 mask)
 		 usleep_range(DELAY_INTERVAL_US, DELAY_INTERVAL_US + 50);
 	} while (!time_after(jiffies, timeout));
 
-	return -ETIMEDOUT;
+	return (readl_relaxed(addr) & mask) ? 0 : -ETIMEDOUT;
 }
 
 static int qcom_apq8064_sata_phy_init(struct phy *generic_phy)
-- 
1.9.1

