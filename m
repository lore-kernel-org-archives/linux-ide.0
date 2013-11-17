From: Marek Vasut <marex@denx.de>
Subject: [PATCH 5/5] ARM: dts: imx53: Enable AHCI SATA for M53EVK
Date: Sun, 17 Nov 2013 23:56:22 +0100
Message-ID: <1384728982-19834-5-git-send-email-marex@denx.de>
References: <1384728982-19834-1-git-send-email-marex@denx.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:60459 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646Ab3KQW4j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Nov 2013 17:56:39 -0500
In-Reply-To: <1384728982-19834-1-git-send-email-marex@denx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marex@denx.de>, Shawn Guo <shawn.guo@linaro.org>, Richard Zhu <r65037@freescale.com>, Tejun Heo <tj@kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Richard Zhu <r65037@freescale.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Linux-IDE <linux-ide@vger.kernel.org>
---
 arch/arm/boot/dts/imx53-m53evk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index 658d32a..c45a8d9c 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -44,6 +44,10 @@
 				};
 			};
 		};
+
+		sata@10000000 {
+			status = "okay";
+		};
 	};
 
 	backlight {
-- 
1.8.4.2

