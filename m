From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v2 09/10] MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7346
Date: Tue, 27 Oct 2015 15:48:10 +0900
Message-ID: <1445928491-7320-10-git-send-email-jaedon.shin@gmail.com>
References: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33494 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937AbbJ0GtK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Oct 2015 02:49:10 -0400
In-Reply-To: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: Rob Herring <robh+dt@kernel.org>, Kevin Cernekee <cernekee@gmail.com>, Dragan Stancevic <dragan.stancevic@gmail.com>, linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>, devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>

Add AHCI and PHY device nodes to MIPS-based BCM7346 set-top box
platform.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7346.dtsi      | 42 +++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts |  8 ++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm7346.dtsi b/arch/mips/boot/dts/brcm/bcm7346.dtsi
index d817bb46b934..8535a5676d48 100644
--- a/arch/mips/boot/dts/brcm/bcm7346.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7346.dtsi
@@ -246,5 +246,47 @@
 			interrupts = <76>;
 			status = "disabled";
 		};
+
+		sata: sata@181000 {
+			compatible = "brcm,bcm7425-ahci", "brcm,sata3-ahci";
+			reg-names = "ahci", "top-ctrl";
+			reg = <0x181000 0xa9c>, <0x180020 0x1c>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <40>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			brcm,broken-ncq;
+			brcm,broken-phy;
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
+			compatible = "brcm,bcm7425-sata-phy", "brcm,phy-sata3";
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
diff --git a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
index 3fe0445b9d37..e147c61178cc 100644
--- a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
@@ -64,3 +64,11 @@
 &ohci3 {
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

