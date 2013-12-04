From: oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org
Subject: [PATCH 3/3] ARM: sunxi: dts: Add ahci support to a few
 A10 and A20 boards
Date: Wed,  4 Dec 2013 13:10:55 +0100
Message-ID: <1386159055-10264-4-git-send-email-oliver@schinagl.nl>
References: <1386159055-10264-1-git-send-email-oliver@schinagl.nl>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDC2JNWXZAJBB2FX7SKAKGQE5RQ4BOY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1386159055-10264-1-git-send-email-oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org
Cc: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

From: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>

This patch adds sunxi sata support to A10 and A20 boards that have such
a connector. Some boards also feature a regulator via a GPIO and support
for this is also added.

Signed-off-by: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
---
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts      | 26 +++++++++++++++++++++++++
 arch/arm/boot/dts/sun4i-a10.dtsi                |  9 +++++++++
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 26 +++++++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 26 +++++++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 26 +++++++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi                |  9 +++++++++
 6 files changed, 122 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index 425a7db..b620084 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -42,7 +42,18 @@
 			};
 		};
 
+		sata: ahci@01c18000 {
+			pwr-supply = <&reg_ahci_5v>;
+			status = "okay";
+		};
+
 		pinctrl@01c20800 {
+			ahci_pwr_pin: ahci_pwr_pin@0 {
+				allwinner,pins = "PB8";
+				allwinner,function = "gpio_out";
+				allwinner,driver = <0>;
+				allwinner,pull = <0>;
+			};
 			led_pins_cubieboard: led_pins@0 {
 				allwinner,pins = "PH20", "PH21";
 				allwinner,function = "gpio_out";
@@ -86,4 +97,19 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	regulators {
+		compatible = "simple-bus";
+		pinctrl-names = "default";
+
+		reg_ahci_5v: ahci-5v {
+			compatible = "regulator-fixed";
+			regulator-name = "ahci-5v";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			pinctrl-0 = <&ahci_pwr_pin>;
+			gpio = <&pio 1 8 0>;
+			enable-active-high;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 4dccdb0..53c6cdb 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -306,6 +306,15 @@
 			#size-cells = <0>;
 		};
 
+		sata: ahci@01c18000 {
+			compatible = "allwinner,sun4i-a10-ahci";
+			reg = <0x01c18000 0x1000>;
+			interrupts = <0 56 1>;
+			clocks = <&ahb_gates 25>, <&pll6 0>;
+			clock-names = "ahb_sata", "pll6_sata";
+			status = "disabled";
+		};
+
 		intc: interrupt-controller@01c20400 {
 			compatible = "allwinner,sun4i-ic";
 			reg = <0x01c20400 0x400>;
diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 5c51cb8..99c5e78 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -34,7 +34,18 @@
 			};
 		};
 
+		sata: ahci@01c18000 {
+			pwr-supply = <&reg_ahci_5v>;
+			status = "okay";
+		};
+
 		pinctrl@01c20800 {
+			ahci_pwr_pin: ahci_pwr_pin@0 {
+				allwinner,pins = "PB8";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 			led_pins_cubieboard2: led_pins@0 {
 				allwinner,pins = "PH20", "PH21";
 				allwinner,function = "gpio_out";
@@ -77,4 +88,19 @@
 			gpios = <&pio 7 20 0>;
 		};
 	};
+
+	regulators {
+		compatible = "simple-bus";
+		pinctrl-names = "default";
+
+		reg_ahci_5v: ahci-5v {
+			compatible = "regulator-fixed";
+			regulator-name = "ahci-5v";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			pinctrl-0 = <&ahci_pwr_pin>;
+			gpio = <&pio 1 8 0>;
+			enable-active-high;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 8a1009d..19af23e 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -19,7 +19,18 @@
 	compatible = "cubietech,cubietruck", "allwinner,sun7i-a20";
 
 	soc@01c00000 {
+		sata: ahci@01c18000 {
+			pwr-supply = <&reg_ahci_5v>;
+			status = "okay";
+		};
+
 		pinctrl@01c20800 {
+			ahci_pwr_pin: ahci_pwr_pin@0 {
+				allwinner,pins = "PH12";
+				allwinner,function = "gpio_out";
+				allwinner,driver = <0>;
+				allwinner,pull = <0>;
+			};
 			led_pins_cubietruck: led_pins@0 {
 				allwinner,pins = "PH7", "PH11", "PH20", "PH21";
 				allwinner,function = "gpio_out";
@@ -60,4 +71,19 @@
 			gpios = <&pio 7 7 0>;
 		};
 	};
+
+	regulators {
+		compatible = "simple-bus";
+		pinctrl-names = "default";
+
+		reg_ahci_5v: ahci-5v {
+			compatible = "regulator-fixed";
+			regulator-name = "ahci-5v";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			pinctrl-0 = <&ahci_pwr_pin>;
+			gpio = <&pio 7 12 0>;
+			enable-active-high;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index ead3013..23ed708 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -34,7 +34,19 @@
 			};
 		};
 
+		sata: ahci@01c18000 {
+			pwr-supply = <&reg_ahci_5v>;
+			status = "okay";
+		};
+
 		pinctrl@01c20800 {
+			ahci_pwr_pin: ahci_pwr_pin@0 {
+				allwinner,pins = "PB8";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
 			led_pins_olinuxino: led_pins@0 {
 				allwinner,pins = "PH2";
 				allwinner,function = "gpio_out";
@@ -91,4 +103,18 @@
 			default-state = "on";
 		};
 	};
+
+	regulators {
+		compatible = "simple-bus";
+
+		reg_ahci_5v: ahci-5v {
+			compatible = "regulator-fixed";
+			regulator-name = "ahci-5v";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			pinctrl-0 = <&ahci_pwr_pin>;
+			gpio = <&pio 1 8 0>;
+			enable-active-high;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 0552a64..b72c69e 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -368,6 +368,15 @@
 			};
 		};
 
+		sata: ahci@01c18000 {
+			compatible = "allwinner,sun4i-a10-ahci";
+			reg = <0x01c18000 0x1000>;
+			interrupts = <0 56 1>;
+			clocks = <&ahb_gates 25>, <&pll6 0>;
+			clock-names = "ahb_sata", "pll6_sata";
+			status = "disabled";
+		};
+
 		timer@01c20c00 {
 			compatible = "allwinner,sun4i-timer";
 			reg = <0x01c20c00 0x90>;
-- 
1.8.3.2
