From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 4/4] ARM: mvebu: Armada 385 GP: Add regulators to the SATA port
Date: Fri,  9 Jan 2015 11:39:49 +0100
Message-ID: <1420799989-10645-5-git-send-email-gregory.clement@free-electrons.com>
References: <1420799989-10645-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1420799989-10645-1-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Add the regulators to each SATA port.

Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 arch/arm/boot/dts/armada-388-gp.dts | 126 ++++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
index 4df22bf91683..c599c71bc5ce 100644
--- a/arch/arm/boot/dts/armada-388-gp.dts
+++ b/arch/arm/boot/dts/armada-388-gp.dts
@@ -173,6 +173,16 @@
 				status = "okay";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				target-port0-supply = <&reg_5v_sata0>;
+				target-port1-supply = <&reg_5v_sata1>;
+
+				sata0: sata-port@0 {
+					reg = <0>;
+				};
+
+				sata1: sata-port@1 {
+					reg = <1>;
+				};
 			};
 
 			sata@e0000 {
@@ -181,6 +191,16 @@
 				status = "okay";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				target-port1-supply = <&reg_5v_sata3>;
+				target-port0-supply = <&reg_5v_sata2>;
+
+				sata2: sata-port@0 {
+					reg = <0>;
+				};
+
+				sata3: sata-port@1 {
+					reg = <1>;
+				};
 			};
 
 			sdhci@d8000 {
@@ -278,6 +298,112 @@
 		regulator-always-on;
 		gpio = <&expander0 4 GPIO_ACTIVE_HIGH>;
 	};
+
+	reg_sata0: pwr-sata0 {
+		compatible = "regulator-fixed";
+		regulator-name = "pwr_en_sata0";
+		enable-active-high;
+		regulator-always-on;
+
+	};
+
+	reg_5v_sata0: v5-sata0 {
+		compatible = "regulator-fixed";
+		regulator-name = "v5.0-sata0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		vin-supply = <&reg_sata0>;
+	};
+
+	reg_12v_sata0: v12-sata0 {
+		compatible = "regulator-fixed";
+		regulator-name = "v12.0-sata0";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
+		vin-supply = <&reg_sata0>;
+	};
+
+	reg_sata1: pwr-sata1 {
+		regulator-name = "pwr_en_sata1";
+		compatible = "regulator-fixed";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		enable-active-high;
+		regulator-always-on;
+		gpio = <&expander0 3 GPIO_ACTIVE_HIGH>;
+	};
+
+	reg_5v_sata1: v5-sata1 {
+		compatible = "regulator-fixed";
+		regulator-name = "v5.0-sata1";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		vin-supply = <&reg_sata1>;
+	};
+
+	reg_12v_sata1: v12-sata1 {
+		compatible = "regulator-fixed";
+		regulator-name = "v12.0-sata1";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
+		vin-supply = <&reg_sata1>;
+	};
+
+	reg_sata2: pwr-sata2 {
+		compatible = "regulator-fixed";
+		regulator-name = "pwr_en_sata2";
+		enable-active-high;
+		regulator-always-on;
+		gpio = <&expander0 11 GPIO_ACTIVE_HIGH>;
+	};
+
+	reg_5v_sata2: v5-sata2 {
+		compatible = "regulator-fixed";
+		regulator-name = "v5.0-sata2";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		vin-supply = <&reg_sata2>;
+	};
+
+	reg_12v_sata2: v12-sata2 {
+		compatible = "regulator-fixed";
+		regulator-name = "v12.0-sata2";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
+		vin-supply = <&reg_sata2>;
+	};
+
+	reg_sata3: pwr-sata3 {
+		compatible = "regulator-fixed";
+		regulator-name = "pwr_en_sata3";
+		enable-active-high;
+		regulator-always-on;
+		gpio = <&expander0 12 GPIO_ACTIVE_HIGH>;
+	};
+
+	reg_5v_sata3: v5-sata3 {
+		compatible = "regulator-fixed";
+		regulator-name = "v5.0-sata3";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		vin-supply = <&reg_sata3>;
+	};
+
+	reg_12v_sata3: v12-sata3 {
+		compatible = "regulator-fixed";
+		regulator-name = "v12.0-sata3";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
+		vin-supply = <&reg_sata3>;
+	};
 };
 
 &pinctrl {
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
