From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 8/9] ARM: dts: sun8i: r40: add sata node
Date: Fri, 13 Jul 2018 11:03:05 +0000
Message-ID: <1531479786-4911-9-git-send-email-clabbe@baylibre.com>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hdegoede@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com, maxime.ripard@free-electrons.com, robh+dt@kernel.org, tj@kernel.org, wens@csie.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, thierry.reding@gmail.com, icenowy@aosc.io, Corentin Labbe <clabbe@baylibre.com>
List-Id: linux-ide@vger.kernel.org

R40 have a sata controller which is the same as A20.
This patch adds a DT node for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index d4ad55eb2245..bd369112a400 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -550,6 +550,22 @@
 			#size-cells = <0>;
 		};
 
+		ahci: sata@1c18000 {
+			compatible = "allwinner,sun4i-a10-ahci";
+			reg = <0x01c18000 0x1000>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SATA>, <&ccu CLK_SATA>;
+			resets = <&ccu RST_BUS_SATA>;
+			resets-name = "ahci";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			sata_port0: sata-port@0 {
+				reg = <0>;
+			};
+		};
+
 		gmac: ethernet@1c50000 {
 			compatible = "allwinner,sun8i-r40-gmac";
 			syscon = <&ccu>;
-- 
2.16.4
