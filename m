From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 1/5] Phy: DT binding documentation for Marvell MVEBU SATA phy.
Date: Wed,  4 Dec 2013 18:16:00 +0100
Message-ID: <1386177364-10164-2-git-send-email-andrew@lunn.ch>
References: <1386177364-10164-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:56807 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753970Ab3LDRQT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Dec 2013 12:16:19 -0500
In-Reply-To: <1386177364-10164-1-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, kishon@ti.com
Cc: devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Andrew Lunn <andrew@lunn.ch>

Describe the binding for the Marvell MVEBU SATA phy. This driver
can be used at least with Kirkwood, Dove and maybe others.
Additionally, update the SATA binding with the properties to link
to the phy nodes.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 Documentation/devicetree/bindings/ata/marvell.txt  |  6 ++++++
 .../devicetree/bindings/phy/phy-mvebu-sata.txt     | 22 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mvebu-sata.txt

diff --git a/Documentation/devicetree/bindings/ata/marvell.txt b/Documentation/devicetree/bindings/ata/marvell.txt
index b5cdd20cde9c..e072fa105b49 100644
--- a/Documentation/devicetree/bindings/ata/marvell.txt
+++ b/Documentation/devicetree/bindings/ata/marvell.txt
@@ -6,11 +6,17 @@ Required Properties:
 - interrupts    : Interrupt controller is using
 - nr-ports      : Number of SATA ports in use.
 
+Optional Properties:
+- phys		: List of phandles to sata phys
+- phy-names	: Should be "0", "1", etc, one number per phandle
+
 Example:
 
 	sata@80000 {
 		compatible = "marvell,orion-sata";
 		reg = <0x80000 0x5000>;
 		interrupts = <21>;
+		phys = <&sata_phy0>, <&sata_phy1>;
+		phy-names = "0", "1";
 		nr-ports = <2>;
 	}
diff --git a/Documentation/devicetree/bindings/phy/phy-mvebu-sata.txt b/Documentation/devicetree/bindings/phy/phy-mvebu-sata.txt
new file mode 100644
index 000000000000..1cf9cef50b4b
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-mvebu-sata.txt
@@ -0,0 +1,22 @@
+* Marvell MVEBU SATA PHY
+
+Power control for the SATA phy found on Marvell MVEBU SoCs.
+
+This document extends the binding described in phy-bindings.txt
+
+Required properties :
+
+ - reg		   : Offset and length of the register set for the SATA device
+ - compatible	   : Should be "marvell,mvebu-sata-phy"
+ - clocks	   : phandle of clock that supplies the SATA device
+ - clock-names	   : Should be "sata"
+
+Example:
+		sata-phy@1 {
+			compatible = "marvell,mvebu-sata-phy";
+			reg = <0x84000 0x0334>;
+			clocks = <&gate_clk 15>;
+			clock-names = "sata";
+			#phy-cells = <1>;
+			status = "ok";
+		};
-- 
1.8.5

