From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v4 4/4] Phy: Add DT nodes on kirkwood and Dove for the SATA PHY
Date: Thu, 26 Dec 2013 18:25:42 +0100
Message-ID: <1388078742-6726-5-git-send-email-andrew@lunn.ch>
References: <20131219194237.GC22725@htj.dyndns.org>
 <1388078742-6726-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:42373 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753568Ab3LZR04 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Dec 2013 12:26:56 -0500
In-Reply-To: <1388078742-6726-1-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, kishon@ti.com, tj@kernel.org
Cc: devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Andrew Lunn <andrew@lunn.ch>

Add nodes for the two SATA PHYs on kirkwood.
Add node for the one SATA PHY on Dove.
Add pHandles to the PHYs in the sata nodes.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
v1->v2:
sata_phy@... ->sata-phy@
value after '@' matching the first address in the reg.

v2->v3:
"0" -> "port0", etc.
kirkewood -> kirkwood
---
 arch/arm/boot/dts/dove.dtsi          |   11 +++++++++++
 arch/arm/boot/dts/kirkwood-6281.dtsi |    2 ++
 arch/arm/boot/dts/kirkwood-6282.dtsi |    2 ++
 arch/arm/boot/dts/kirkwood.dtsi      |   18 ++++++++++++++++++
 4 files changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 113a8bc..198d036 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -490,10 +490,21 @@
 				reg = <0xa0000 0x2400>;
 				interrupts = <62>;
 				clocks = <&gate_clk 3>;
+				phys = <&sata_phy0>;
+				phy-names = "port0";
 				nr-ports = <1>;
 				status = "disabled";
 			};
 
+			sata_phy0: sata-phy@a2000 {
+				compatible = "marvell,mvebu-sata-phy";
+				reg = <0xa2000 0x0334>;
+				clocks = <&gate_clk 3>;
+				clock-names = "sata";
+				#phy-cells = <0>;
+				status = "ok";
+			};
+
 			rtc: real-time-clock@d8500 {
 				compatible = "marvell,orion-rtc";
 				reg = <0xd8500 0x20>;
diff --git a/arch/arm/boot/dts/kirkwood-6281.dtsi b/arch/arm/boot/dts/kirkwood-6281.dtsi
index 650ef30..18400e7 100644
--- a/arch/arm/boot/dts/kirkwood-6281.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6281.dtsi
@@ -89,6 +89,8 @@
 			interrupts = <21>;
 			clocks = <&gate_clk 14>, <&gate_clk 15>;
 			clock-names = "0", "1";
+			phys = <&sata_phy0>, <&sata_phy1>;
+			phy-names = "port0", "port1";
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kirkwood-6282.dtsi
index 3933a33..69c622b 100644
--- a/arch/arm/boot/dts/kirkwood-6282.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
@@ -117,6 +117,8 @@
 			interrupts = <21>;
 			clocks = <&gate_clk 14>, <&gate_clk 15>;
 			clock-names = "0", "1";
+			phys = <&sata_phy0>, <&sata_phy1>;
+			phy-names = "port0", "port1";
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 8b73c80..ee06951 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -282,5 +282,23 @@
 				/* set phy-handle property in board file */
 			};
 		};
+
+		sata_phy0: sata-phy@82000 {
+			compatible = "marvell,mvebu-sata-phy";
+			reg = <0x82000 0x0334>;
+			clocks = <&gate_clk 14>;
+			clock-names = "sata";
+			#phy-cells = <0>;
+			status = "ok";
+		};
+
+		sata_phy1: sata-phy@84000 {
+			compatible = "marvell,mvebu-sata-phy";
+			reg = <0x84000 0x0334>;
+			clocks = <&gate_clk 15>;
+			clock-names = "sata";
+			#phy-cells = <0>;
+			status = "ok";
+		};
 	};
 };
-- 
1.7.10.4

