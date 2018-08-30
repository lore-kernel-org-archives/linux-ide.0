From: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH v4 09/13] ARM: dts: sun8i: r40: add sata node
Date: Thu, 30 Aug 2018 21:01:16 +0200
Message-ID: <20180830190120.722-10-clabbe.montjoie@gmail.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830190120.722-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: axboe@kernel.dk, hdegoede@redhat.com, kishon@ti.com, mark.rutland@arm.com, maxime.ripard@bootlin.com, robh+dt@kernel.org, wens@csie.org, clabbe.montjoie@gmail.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
List-Id: linux-ide@vger.kernel.org

R40 have a sata controller which is the same as A20.
This patch adds a DT node for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 852c2ccc3268..d6b5820da850 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -550,6 +550,29 @@
 			#size-cells = <0>;
 		};
 
+		ahci: sata@1c18000 {
+			compatible = "allwinner,sun8i-r40-ahci";
+			reg = <0x01c18000 0x1000>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SATA>, <&ccu CLK_SATA>;
+			resets = <&ccu RST_BUS_SATA>;
+			resets-name = "ahci";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata_port: sata-port@0 {
+				reg = <0>;
+				phys = <&sata_phy>;
+			};
+		};
+
+		sata_phy: sata-phy@1c180c0  {
+			compatible = "allwinner,sun8i-r40-sata-phy";
+			reg = <0x1c180c0 0x200>;
+			#phy-cells = <0>;
+		};
+
 		gmac: ethernet@1c50000 {
 			compatible = "allwinner,sun8i-r40-gmac";
 			syscon = <&ccu>;
-- 
2.16.4
