From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH v2 5/5] ARM: dts: brcmstb: add nodes for SATA controller and PHY
Date: Wed, 22 Apr 2015 19:59:10 -0700
Message-ID: <1429757950-28789-6-git-send-email-computersforpeace@gmail.com>
References: <1429757950-28789-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429757950-28789-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-ide@vger.kernel.org

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
v2:
  - fix up some typos
  - account for binding changes in previous patches

 arch/arm/boot/dts/bcm7445.dtsi | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/bcm7445.dtsi b/arch/arm/boot/dts/bcm7445.dtsi
index 9eaeac8dce1b..2abb639723d2 100644
--- a/arch/arm/boot/dts/bcm7445.dtsi
+++ b/arch/arm/boot/dts/bcm7445.dtsi
@@ -108,6 +108,43 @@
 			brcm,int-map-mask = <0x25c>, <0x7000000>;
 			brcm,int-fwd-mask = <0x70000>;
 		};
+
+		sata@45a000 {
+			compatible = "brcm,bcm7445-ahci", "brcm,sata3-ahci";
+			reg-names = "ahci", "top-ctrl";
+			reg = <0x45a000 0xa9c>, <0x458040 0x24>;
+			interrupts = <GIC_SPI 30 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			sata0: sata-port@0 {
+				reg = <0>;
+				phys = <&sata_phy0>;
+			};
+
+			sata1: sata-port@1 {
+				reg = <1>;
+				phys = <&sata_phy1>;
+			};
+		};
+
+		sata_phy: sata-phy@458100 {
+			compatible = "brcm,bcm7445-sata-phy", "brcm,phy-sata3";
+			reg = <0x458100 0x1f00>;
+			reg-names = "phy";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+
+			sata_phy0: sata-phy@0 {
+				reg = <0>;
+				#phy-cells = <0>;
+			};
+
+			sata_phy1: sata-phy@1 {
+				reg = <1>;
+				#phy-cells = <0>;
+			};
+		};
 	};
 
 	smpboot {
-- 
1.9.1
