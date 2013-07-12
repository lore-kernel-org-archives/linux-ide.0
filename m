From: Richard Zhu <richard.zhuhongxing@gmail.com>
Subject: [v6 1/3] ARM: dtsi: enable ahci sata on imx6q platforms
Date: Fri, 12 Jul 2013 17:41:16 +0800
Message-ID: <1373622078-18723-2-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1373622078-18723-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:55648 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757350Ab3GLJjE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jul 2013 05:39:04 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so8420358pdi.13
        for <linux-ide@vger.kernel.org>; Fri, 12 Jul 2013 02:39:03 -0700 (PDT)
In-Reply-To: <1373622078-18723-1-git-send-email-Hong-Xing.Zhu@freescale.com>
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
index 09a7580..5cd5209 100644
--- a/arch/arm/boot/dts/imx6q-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6q-sabreauto.dts
@@ -20,6 +20,10 @@
 	compatible = "fsl,imx6q-sabreauto", "fsl,imx6q";
 };
 
+&ahci {
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 6a00066..6bf6fec 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -65,6 +65,10 @@
 	};
 };
 
+&ahci {
+	status = "okay";
+};
+
 &ecspi1 {
 	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio3 19 0>;
diff --git a/arch/arm/boot/dts/imx6q-sabresd.dts b/arch/arm/boot/dts/imx6q-sabresd.dts
index 0038228..d0579b8 100644
--- a/arch/arm/boot/dts/imx6q-sabresd.dts
+++ b/arch/arm/boot/dts/imx6q-sabresd.dts
@@ -20,6 +20,10 @@
 	compatible = "fsl,imx6q-sabresd", "fsl,imx6q";
 };
 
+&ahci {
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index e7dd2c4..93b65d9 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -424,6 +424,15 @@
 			};
 		};
 
+		ahci: ahci@02200000 {
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

