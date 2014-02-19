From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v6 18/18] ARM: sun7i: dt: Add ahci / sata support
Date: Wed, 19 Feb 2014 13:02:00 +0100
Message-ID: <1392811320-3132-19-git-send-email-hdegoede@redhat.com>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBH53SKMAKGQEOVH7MBI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1392811320-3132-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

This patch adds sunxi sata support to A20 boards that have such a connector.
Some boards also feature a regulator via a GPIO and support for this is also
added.

Signed-off-by: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     |  6 ++++++
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 18 ++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts |  6 ++++++
 arch/arm/boot/dts/sun7i-a20.dtsi                |  8 ++++++++
 4 files changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 7bf4935..07823c2 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -13,12 +13,18 @@
 
 /dts-v1/;
 /include/ "sun7i-a20.dtsi"
+/include/ "sunxi-ahci-reg.dtsi"
 
 / {
 	model = "Cubietech Cubieboard2";
 	compatible = "cubietech,cubieboard2", "allwinner,sun7i-a20";
 
 	soc@01c00000 {
+		ahci: sata@01c18000 {
+			target-supply = <&reg_ahci_5v>;
+			status = "okay";
+		};
+
 		pinctrl@01c20800 {
 			led_pins_cubieboard2: led_pins@0 {
 				allwinner,pins = "PH20", "PH21";
diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 025ce52..403bd2e 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -13,13 +13,26 @@
 
 /dts-v1/;
 /include/ "sun7i-a20.dtsi"
+/include/ "sunxi-ahci-reg.dtsi"
 
 / {
 	model = "Cubietech Cubietruck";
 	compatible = "cubietech,cubietruck", "allwinner,sun7i-a20";
 
 	soc@01c00000 {
+		ahci: sata@01c18000 {
+			target-supply = <&reg_ahci_5v>;
+			status = "okay";
+		};
+
 		pinctrl@01c20800 {
+			ahci_pwr_pin_cubietruck: ahci_pwr_pin@1 {
+				allwinner,pins = "PH12";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
 			led_pins_cubietruck: led_pins@0 {
 				allwinner,pins = "PH7", "PH11", "PH20", "PH21";
 				allwinner,function = "gpio_out";
@@ -90,4 +103,9 @@
 			gpios = <&pio 7 7 0>;
 		};
 	};
+
+	reg_ahci_5v: ahci-5v {
+		pinctrl-0 = <&ahci_pwr_pin_cubietruck>;
+		gpio = <&pio 7 12 0>;
+	};
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index b02a796..d5c6799 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -13,12 +13,18 @@
 
 /dts-v1/;
 /include/ "sun7i-a20.dtsi"
+/include/ "sunxi-ahci-reg.dtsi"
 
 / {
 	model = "Olimex A20-Olinuxino Micro";
 	compatible = "olimex,a20-olinuxino-micro", "allwinner,sun7i-a20";
 
 	soc@01c00000 {
+		ahci: sata@01c18000 {
+			target-supply = <&reg_ahci_5v>;
+			status = "okay";
+		};
+
 		pinctrl@01c20800 {
 			led_pins_olinuxino: led_pins@0 {
 				allwinner,pins = "PH2";
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index daaafd0..3385994 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -392,6 +392,14 @@
 			#size-cells = <0>;
 		};
 
+		ahci: sata@01c18000 {
+			compatible = "allwinner,sun4i-a10-ahci";
+			reg = <0x01c18000 0x1000>;
+			interrupts = <0 56 4>;
+			clocks = <&pll6 0>, <&ahb_gates 25>;
+			status = "disabled";
+		};
+
 		pio: pinctrl@01c20800 {
 			compatible = "allwinner,sun7i-a20-pinctrl";
 			reg = <0x01c20800 0x400>;
-- 
1.8.5.3
