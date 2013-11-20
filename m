From: Marek Vasut <marex@denx.de>
Subject: [PATCH V2 5/6] ARM: dts: imx53: Add AHCI SATA DT node
Date: Wed, 20 Nov 2013 11:17:38 +0100
Message-ID: <1384942659-5362-5-git-send-email-marex@denx.de>
References: <1384942659-5362-1-git-send-email-marex@denx.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:47846 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328Ab3KTKRt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Nov 2013 05:17:49 -0500
In-Reply-To: <1384942659-5362-1-git-send-email-marex@denx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marex@denx.de>, Shawn Guo <shawn.guo@linaro.org>, Richard Zhu <r65037@freescale.com>, Tejun Heo <tj@kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>

The AHCI-IMX driver now supports i.MX53 as well. Add DT node.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Richard Zhu <r65037@freescale.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Linux-IDE <linux-ide@vger.kernel.org>
---
 arch/arm/boot/dts/imx53.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

V2: Rename 'IMX5_CLK_SATA_PHY' to 'IMX5_CLK_SATA_REF' as well as
    'sata_phy' to 'sata_ref' .

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index b330ef7..4b2053b 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -86,6 +86,17 @@
 		interrupt-parent = <&tzic>;
 		ranges;
 
+		sata: sata@10000000 {
+			compatible = "fsl,imx53-ahci";
+			reg = <0x10000000 0x1000>;
+			interrupts = <28>;
+			clocks = <&clks IMX5_CLK_SATA_GATE>,
+				 <&clks IMX5_CLK_SATA_REF>,
+				 <&clks IMX5_CLK_AHB>;
+			clock-names = "sata_gate", "sata_ref", "ahb";
+			status = "disabled";
+		};
+
 		ipu: ipu@18000000 {
 			#crtc-cells = <1>;
 			compatible = "fsl,imx53-ipu";
-- 
1.8.4.2

