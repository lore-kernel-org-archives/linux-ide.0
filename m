From: Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v4 2/2] dt-bindings: ata: add DT bindings for MediaTek SATA controller
Date: Fri, 18 Aug 2017 09:13:08 +0800
Message-ID: <0ac0ff921914acd95b7b5906ca435571e55c355f.1503018631.git.ryder.lee@mediatek.com>
References: <cover.1503018631.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1503018631.git.ryder.lee@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Long Cheng <long.cheng@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>
List-Id: linux-ide@vger.kernel.org

Add DT bindings for the onboard SATA controller present on the MediaTek
SoCs.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/ata/ahci-mtk.txt | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-mtk.txt

diff --git a/Documentation/devicetree/bindings/ata/ahci-mtk.txt b/Documentation/devicetree/bindings/ata/ahci-mtk.txt
new file mode 100644
index 0000000..d2aa696
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/ahci-mtk.txt
@@ -0,0 +1,51 @@
+MediaTek Serial ATA controller
+
+Required properties:
+ - compatible	   : Must be "mediatek,<chip>-ahci", "mediatek,mtk-ahci".
+		     When using "mediatek,mtk-ahci" compatible strings, you
+		     need SoC specific ones in addition, one of:
+		     - "mediatek,mt7622-ahci"
+ - reg		   : Physical base addresses and length of register sets.
+ - interrupts	   : Interrupt associated with the SATA device.
+ - interrupt-names : Associated name must be: "hostc".
+ - clocks	   : A list of phandle and clock specifier pairs, one for each
+		     entry in clock-names.
+ - clock-names	   : Associated names must be: "ahb", "axi", "asic", "rbc", "pm".
+ - phys		   : A phandle and PHY specifier pair for the PHY port.
+ - phy-names	   : Associated name must be: "sata-phy".
+ - ports-implemented : See ./ahci-platform.txt for details.
+
+Optional properties:
+ - power-domains   : A phandle and power domain specifier pair to the power
+		     domain which is responsible for collapsing and restoring
+		     power to the peripheral.
+ - resets	   : Must contain an entry for each entry in reset-names.
+		     See ../reset/reset.txt for details.
+ - reset-names	   : Associated names must be: "axi", "sw", "reg".
+ - mediatek,phy-mode : A phandle to the system controller, used to enable
+		       SATA function.
+
+Example:
+
+	sata: sata@1a200000 {
+		compatible = "mediatek,mt7622-ahci",
+			     "mediatek,mtk-ahci";
+		reg = <0 0x1a200000 0 0x1100>;
+		interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "hostc";
+		clocks = <&pciesys CLK_SATA_AHB_EN>,
+			 <&pciesys CLK_SATA_AXI_EN>,
+			 <&pciesys CLK_SATA_ASIC_EN>,
+			 <&pciesys CLK_SATA_RBC_EN>,
+			 <&pciesys CLK_SATA_PM_EN>;
+		clock-names = "ahb", "axi", "asic", "rbc", "pm";
+		phys = <&u3port1 PHY_TYPE_SATA>;
+		phy-names = "sata-phy";
+		ports-implemented = <0x1>;
+		power-domains = <&scpsys MT7622_POWER_DOMAIN_HIF0>;
+		resets = <&pciesys MT7622_SATA_AXI_BUS_RST>,
+			 <&pciesys MT7622_SATA_PHY_SW_RST>,
+			 <&pciesys MT7622_SATA_PHY_REG_RST>;
+		reset-names = "axi", "sw", "reg";
+		mediatek,phy-mode = <&pciesys>;
+	};
-- 
1.9.1
