From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 5/5] ARM: dts: brcmstb: add nodes for SATA controller and PHY
Date: Wed, 18 Mar 2015 18:23:42 -0700
Message-ID: <1426728222-8197-5-git-send-email-computersforpeace@gmail.com>
References: <1426728222-8197-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426728222-8197-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
Light dependency on:
  http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/331921.html
for the surrounding text.

 arch/arm/boot/dts/bcm7445.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/bcm7445.dtsi b/arch/arm/boot/dts/bcm7445.dtsi
index 9eaeac8dce1b..7a7c4d8c2afe 100644
--- a/arch/arm/boot/dts/bcm7445.dtsi
+++ b/arch/arm/boot/dts/bcm7445.dtsi
@@ -108,6 +108,42 @@
 			brcm,int-map-mask = <0x25c>, <0x7000000>;
 			brcm,int-fwd-mask = <0x70000>;
 		};
+
+		sata@f045a000 {
+			compatible = "brcm,bcm7445-ahci", "brcm,sata3-ahci";
+			reg-names = "ahci", "top-ctrl";
+			reg = <0x45a000 0xa9c>, <0x458040 0x24>;
+			interrupts = <GIC_SPI 30 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			sata0: sata-port@0 {
+				reg = <0>;
+				phys = <&sata_phy 0>;
+			};
+
+			sata1: sata-port@1 {
+				reg = <1>;
+				phys = <&sata_phy 1>;
+			};
+		};
+
+		sata_phy: sata-phy@f0458100 {
+			compatible = "brcm,bcm7445-sata-phy", "brcm,phy-sata3";
+			reg = <0x458100 0x1e00>, <0x45804c 0x10>;
+			reg-names = "phy", "port-ctrl";
+			#phy-cells = <1>;
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+
+			sata-phy@0 {
+				reg = <0>;
+			};
+
+			sata-phy@1 {
+				reg = <1>;
+			};
+		};
 	};
 
 	smpboot {
-- 
1.9.1
