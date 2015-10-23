From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 09/10] MIPS: BMIPS: brcmstb: add SATA nodes for bcm7360
Date: Fri, 23 Oct 2015 10:44:22 +0900
Message-ID: <1445564663-66824-10-git-send-email-jaedon.shin@gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35386 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209AbbJWBpx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Oct 2015 21:45:53 -0400
In-Reply-To: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-mips@linux-mips.org, devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>

Add AHCI and PHY device nodes to BMIPS based BCM7360 platform.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7360.dtsi     | 40 ++++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts |  8 +++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm7360.dtsi b/arch/mips/boot/dts/brcm/bcm7360.dtsi
index 9e1e571ba346..1f5c99e9d0d1 100644
--- a/arch/mips/boot/dts/brcm/bcm7360.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7360.dtsi
@@ -183,5 +183,45 @@
 			interrupts = <66>;
 			status = "disabled";
 		};
+
+		sata: sata@181000 {
+			compatible = "brcm,bcm7360-ahci", "brcm,sata3-ahci";
+			reg-names = "ahci", "top-ctrl";
+			reg = <0x181000 0xa9c>, <0x180020 0x8>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <86>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
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
+		sata_phy: sata-phy@1800000 {
+			compatible = "brcm,bcm7360-sata-phy", "brcm,phy-sata3";
+			reg = <0x180100 0x0eff>;
+			reg-names = "phy";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
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
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97360svmb.dts b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
index eee8b0e32681..0088925cc36a 100644
--- a/arch/mips/boot/dts/brcm/bcm97360svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
@@ -40,3 +40,11 @@
 &ohci0 {
 	status = "okay";
 };
+
+&sata {
+	status = "okay";
+};
+
+&sata_phy {
+	status = "okay";
+};
-- 
2.6.2

