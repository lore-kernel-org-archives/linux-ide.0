From: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Subject: [PATCH V1 1/3] ahci_platform: add two clk pointer member into ahci_platform_data struct
Date: Thu, 17 Mar 2011 15:10:58 +0800
Message-ID: <1300345860-16574-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ch1outboundpool.messaging.microsoft.com ([216.32.181.186]:22526
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750845Ab1CQHL0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Mar 2011 03:11:26 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: jgarzik@pobox.com, kernel@pengutronix.de, linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, eric@eukrea.com, eric.miao@linaro.org, Richard Zhu <Hong-Xing.Zhu@freescale.com>

Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
---
 include/linux/ahci_platform.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
index be3d9a7..86b5e24 100644
--- a/include/linux/ahci_platform.h
+++ b/include/linux/ahci_platform.h
@@ -26,6 +26,8 @@ struct ahci_platform_data {
 	const struct ata_port_info *ata_port_info;
 	unsigned int force_port_map;
 	unsigned int mask_port_map;
+	struct clk *sata_clk;
+	struct clk *sata_ref_clk;
 };
 
 #endif /* _AHCI_PLATFORM_H */
-- 
1.7.1


