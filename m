From: Marek Vasut <marex@denx.de>
Subject: [PATCH 6/6] ARM: dts: imx53: Enable AHCI SATA for M53EVK
Date: Fri, 22 Nov 2013 12:05:04 +0100
Message-ID: <1385118304-27435-6-git-send-email-marex@denx.de>
References: <1385118304-27435-1-git-send-email-marex@denx.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:58601 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064Ab3KVLFS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Nov 2013 06:05:18 -0500
In-Reply-To: <1385118304-27435-1-git-send-email-marex@denx.de>
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

