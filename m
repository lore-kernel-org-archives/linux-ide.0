From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 4/4] ARM: sun7i: dts: Add ahci / sata support
Date: Sat,  4 Jan 2014 10:14:38 +0100
Message-ID: <1388826878-5602-5-git-send-email-hdegoede@redhat.com>
References: <1388826878-5602-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBFVCT6LAKGQECESCLCQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1388826878-5602-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Oliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

This patch adds sunxi sata support to A20 boards that have such a connector.
Some boards also feature a regulator via a GPIO and support for this is also
added.

Signed-off-by: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 27 +++++++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 27 +++++++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 26 ++++++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi                |  9 +++++++++
 4 files changed, 89 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 48777cd..a26711c 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -28,7 +28,19 @@
 			status = "okay";
 		};
 
+		sata: ahci@01c18000 {
+			pwr-supply = <&reg_ahci_5v>;
+			status = "okay";
+		};
+
 		pinctrl@01c20800 {
+			ahci_pwr_pin_cubieboard2: ahci_pwr_pin@0 {
+				allwinner,pins = "PB8";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
 			mmc0_cd_pin_cubieboard2: mmc0_cd_pin@0 {
 				allwinner,pins = "PH1";
 				allwinner,function = "gpio_in";
@@ -86,4 +98,19 @@
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
+			pinctrl-0 = <&ahci_pwr_pin_cubieboard2>;
+			gpio = <&pio 1 8 0>;
+			enable-active-high;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 2684f27..a5f3418 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -28,6 +28,11 @@
 			status = "okay";
 		};
 
+		sata: ahci@01c18000 {
+			pwr-supply = <&reg_ahci_5v>;
+			status = "okay";
+		};
+
 		pinctrl@01c20800 {
 			mmc0_cd_pin_cubietruck: mmc0_cd_pin@0 {
 				allwinner,pins = "PH1";
@@ -36,6 +41,13 @@
 				allwinner,pull = <0>;
 			};
 
+			ahci_pwr_pin_cubietruck: ahci_pwr_pin@0 {
+				allwinner,pins = "PH12";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
 			led_pins_cubietruck: led_pins@0 {
 				allwinner,pins = "PH7", "PH11", "PH20", "PH21";
 				allwinner,function = "gpio_out";
@@ -84,4 +96,19 @@
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
+			pinctrl-0 = <&ahci_pwr_pin_cubietruck>;
+			gpio = <&pio 7 12 0>;
+			enable-active-high;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index bf6f6c8..20b1000 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -37,7 +37,19 @@
 			status = "okay";
 		};
 
+		sata: ahci@01c18000 {
+			pwr-supply = <&reg_ahci_5v>;
+			status = "okay";
+		};
+
 		pinctrl@01c20800 {
+			ahci_pwr_pin_olinuxinom: ahci_pwr_pin@0 {
+				allwinner,pins = "PB8";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
 			mmc0_cd_pin_olinuxinom: mmc0_cd_pin@0 {
 				allwinner,pins = "PH1";
 				allwinner,function = "gpio_in";
@@ -116,4 +128,18 @@
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
+			pinctrl-0 = <&ahci_pwr_pin_olinuxinom>;
+			gpio = <&pio 1 8 0>;
+			enable-active-high;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index c9c123a..3242a29 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -448,6 +448,15 @@
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
1.8.4.2
