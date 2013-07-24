From: Richard Zhu <richard.zhuhongxing@gmail.com>
Subject: [v8 1/3] ARM: dtsi: enable ahci sata on imx6q platforms
Date: Wed, 24 Jul 2013 14:15:27 +0800
Message-ID: <1374646529-24432-2-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1374646529-24432-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:60611 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab3GXGNA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Jul 2013 02:13:00 -0400
Received: by mail-pa0-f49.google.com with SMTP id bi5so262369pad.22
        for <linux-ide@vger.kernel.org>; Tue, 23 Jul 2013 23:12:59 -0700 (PDT)
In-Reply-To: <1374646529-24432-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shawn.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, tj@kernel.org, rob.herring@calxeda.com, s.hauer@pengutronix.de, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

From: Richard Zhu <r65037@freescale.com>

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
index 09a7580..18efcbd 100644
--- a/arch/arm/boot/dts/imx6q-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6q-sabreauto.dts
@@ -20,6 +20,10 @@
 	compatible = "fsl,imx6q-sabreauto", "fsl,imx6q";
 };
 
+&sata {
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 6a00066..6021c99 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -65,6 +65,10 @@
 	};
 };
 
+&sata {
+	status = "okay";
+};
+
 &ecspi1 {
 	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio3 19 0>;
diff --git a/arch/arm/boot/dts/imx6q-sabresd.dts b/arch/arm/boot/dts/imx6q-sabresd.dts
index 0038228..d5a90c3 100644
--- a/arch/arm/boot/dts/imx6q-sabresd.dts
+++ b/arch/arm/boot/dts/imx6q-sabresd.dts
@@ -20,6 +20,10 @@
 	compatible = "fsl,imx6q-sabresd", "fsl,imx6q";
 };
 
+&sata {
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index e7dd2c4..af64b81 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -424,6 +424,15 @@
 			};
 		};
 
+		sata: sata@02200000 {
+			compatible = "fsl,imx6q-ahci";
+			reg = <0x02200000 0x4000>;
+			interrupts = <0 39 0x04>;
+			clocks =  <&clks 154>, <&clks 187>, <&clks 105>;
+			clock-names = "sata", "sata_ref", "ahb";
+			status = "disabled";
+		};
+
 		ipu2: ipu@02800000 {
 			#crtc-cells = <1>;
 			compatible = "fsl,imx6q-ipu";
-- 
1.7.5.4

