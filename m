From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 1/4] dt-bindings: add binding for Allwinner R40 SATA AHCI controller
Date: Mon,  9 Jul 2018 15:20:55 +0000
Message-ID: <1531149658-27030-2-git-send-email-clabbe@baylibre.com>
References: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@armlinux.org.uk, mark.rutland@arm.com, maxime.ripard@free-electrons.com, robh+dt@kernel.org, tj@kernel.org, wens@csie.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, icenowy@aosc.io, Corentin Labbe <clabbe@baylibre.com>
List-Id: linux-ide@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

The Allwinner R40 SoC contains a SATA AHCI controller like the one in
A10/A20 SoCs, however a reset control and two power supplies are added
to it.

Add a binding document for it.

As a dedicated binding document is needed now for the A10/A20/R40 AHCI
controller, drop the A10 compatible line from generic platform AHCI
controller binding document.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../devicetree/bindings/ata/ahci-platform.txt      |  1 -
 .../bindings/ata/allwinner,sun4i-a10-ahci.txt      | 40 ++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.txt

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index c760ecb81381..1bea4b5ef9fd 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -9,7 +9,6 @@ PHYs.
 
 Required properties:
 - compatible        : compatible string, one of:
-  - "allwinner,sun4i-a10-ahci"
   - "brcm,iproc-ahci"
   - "hisilicon,hisi-ahci"
   - "cavium,octeon-7130-ahci"
diff --git a/Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.txt b/Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.txt
new file mode 100644
index 000000000000..0eea78c14ad3
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.txt
@@ -0,0 +1,40 @@
+Allwinner A10/A20/R40 SoC SATA AHCI Controller
+
+Required properties:
+- compatible        : compatible string, one of:
+  - "allwinner,sun4i-a10-ahci"
+  - "allwinner,sun8i-r40-ahci"
+- interrupts        : the SATA IRQ
+- reg               : the register mapping
+- clocks            : the clocks needed by SATA controller, usually contains
+		      an AHB clock and a mod clock
+
+Optional properties:
+- target-supply     : regulator for SATA target power
+
+Required properties for the following compatibles:
+  - "allwinner,sun8i-r40-ahci"
+- resets            : the reset control needed by SATA controller
+- vdd1v2-supply     : regulator for SATA controller's 1.2V VDD
+- vdd2v5-supply     : regulator for SATA controller's 2.5V VDD
+
+
+Examples for A10:
+	ahci: sata@1c18000 {
+		compatible = "allwinner,sun4i-a10-ahci";
+		reg = <0x01c18000 0x1000>;
+		interrupts = <56>;
+		clocks = <&pll6 0>, <&ahb_gates 25>;
+		target-supply = <&reg_ahci_5v>;
+	};
+
+Examples for R40:
+	ahci: sata@1c18000 {
+		compatible = "allwinner,sun8i-r40-ahci";
+		reg = <0x01c18000 0x1000>;
+		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&ccu CLK_SATA>, <&ccu CLK_BUS_SATA>;
+		resets = <&ccu RST_BUS_SATA>;
+		vdd1v2-supply = <&reg_eldo3>;
+		vdd2v5-supply = <&reg_dldo4>;
+	};
-- 
2.16.4
