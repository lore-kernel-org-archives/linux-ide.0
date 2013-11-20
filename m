From: Marek Vasut <marex@denx.de>
Subject: [PATCH 6/6] ARM: dts: imx53: Enable AHCI SATA for M53EVK
Date: Wed, 20 Nov 2013 11:17:39 +0100
Message-ID: <1384942659-5362-6-git-send-email-marex@denx.de>
References: <1384942659-5362-1-git-send-email-marex@denx.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:45108 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311Ab3KTKRs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Nov 2013 05:17:48 -0500
In-Reply-To: <1384942659-5362-1-git-send-email-marex@denx.de>
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
index 7a006cb..c623774 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -315,6 +315,10 @@
 	status = "okay";
 };
 
+&sata {
+	status = "okay";
+};
+
 &ssi2 {
 	fsl,mode = "i2s-slave";
 	status = "okay";
-- 
1.8.4.2

