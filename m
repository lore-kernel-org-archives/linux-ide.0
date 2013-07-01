From: Richard Zhu <richard.zhuhongxing@gmail.com>
Subject: [v2 1/4] ARM: dtsi: enable ahci sata on imx6q platforms
Date: Mon,  1 Jul 2013 18:02:52 +0800
Message-ID: <1372672975-2997-2-git-send-email-r65037@freescale.com>
References: <1372672975-2997-1-git-send-email-r65037@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:48878 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335Ab3GAKAq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Jul 2013 06:00:46 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so4629300pbc.35
        for <linux-ide@vger.kernel.org>; Mon, 01 Jul 2013 03:00:46 -0700 (PDT)
In-Reply-To: <1372672975-2997-1-git-send-email-r65037@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shawn.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, avorontsov@ru.mvista.com, rob.herring@calxeda.com, s.hauer@pengutronix.de, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

Only imx6q has the ahci sata controller, enable
it on imx6q platforms.

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 arch/arm/boot/dts/imx6q-sabreauto.dts |    4 ++++
 arch/arm/boot/dts/imx6q-sabrelite.dts |    4 ++++
 arch/arm/boot/dts/imx6q-sabresd.dts   |    4 ++++
 arch/arm/boot/dts/imx6q.dtsi          |    9 +++++++++
 4 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabreauto.dts b/arch/arm/boot/dts/imx6q-sabreauto.dts
index 09a7580..dd40f00 100644
--- a/arch/arm/boot/dts/imx6q-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6q-sabreauto.dts
@@ -20,6 +20,10 @@
 	compatible = "fsl,imx6q-sabreauto", "fsl,imx6q";
 };
 
+&ahci { /* AHCI SATA */
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 6a00066..fde2afd 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -65,6 +65,10 @@
 	};
 };
 
+&ahci { /* AHCI SATA */
+	status = "okay";
+};
+
 &ecspi1 {
 	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio3 19 0>;
diff --git a/arch/arm/boot/dts/imx6q-sabresd.dts b/arch/arm/boot/dts/imx6q-sabresd.dts
index 0038228..e9b6825 100644
--- a/arch/arm/boot/dts/imx6q-sabresd.dts
+++ b/arch/arm/boot/dts/imx6q-sabresd.dts
@@ -20,6 +20,10 @@
 	compatible = "fsl,imx6q-sabresd", "fsl,imx6q";
 };
 
+&ahci { /* AHCI SATA */
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index e7dd2c4..7c1af2b 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -424,6 +424,15 @@
 			};
 		};
 
+		ahci: ahci@02200000 { /* AHCI SATA */
+			compatible = "snps,imx-ahci";
+			reg = <0x02200000 0x4000>;
+			interrupts = <0 39 0x04>;
+			clocks = <&clks 154>, <&clks 187>;
+			clock-names = "sata", "sata_ref_100m";
+			status = "disabled";
+		};
+
 		ipu2: ipu@02800000 {
 			#crtc-cells = <1>;
 			compatible = "fsl,imx6q-ipu";
-- 
1.7.5.4

