From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 9/9] ARM: dts: sun8i: sun8i-r40-bananapi-m2-ultra: enable AHCI
Date: Fri, 13 Jul 2018 11:03:06 +0000
Message-ID: <1531479786-4911-10-git-send-email-clabbe@baylibre.com>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hdegoede@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com, maxime.ripard@free-electrons.com, robh+dt@kernel.org, tj@kernel.org, wens@csie.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, thierry.reding@gmail.com, icenowy@aosc.io, Corentin Labbe <clabbe@baylibre.com>
List-Id: linux-ide@vger.kernel.org

This patch enable the AHCI controller.
Since this controller need two regulator, this patch add them.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index c39b9169ea64..07eaf6cd9d19 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -105,6 +105,11 @@
 	};
 };
 
+&ahci {
+	ahci-supply = <&reg_dldo4>;
+	status = "okay";
+};
+
 &de {
 	status = "okay";
 };
@@ -251,6 +256,22 @@
 	regulator-name = "vcc-wifi";
 };
 
+&reg_dldo4 {
+	regulator-min-microvolt = <2500000>;
+	regulator-max-microvolt = <2500000>;
+	regulator-name = "vdd2v5-sata";
+};
+
+&reg_eldo3 {
+	regulator-min-microvolt = <1200000>;
+	regulator-max-microvolt = <1200000>;
+	regulator-name = "vdd1v2-sata";
+};
+
+&sata_port0 {
+	port-supply = <&reg_eldo3>;
+};
+
 &tcon_tv0 {
 	status = "okay";
 };
-- 
2.16.4
