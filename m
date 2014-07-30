From: =?UTF-8?q?Antoine=20T=C3=A9nart?=
	<antoine.tenart@free-electrons.com>
Subject: [PATCH v13 6/8] Documentation: bindings: document the sub-nodes AHCI bindings
Date: Wed, 30 Jul 2014 19:05:00 +0200
Message-ID: <1406739902-26311-7-git-send-email-antoine.tenart@free-electrons.com>
References: <1406739902-26311-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:57316 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755260AbaG3RFr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jul 2014 13:05:47 -0400
In-Reply-To: <1406739902-26311-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sebastian.hesselbarth@gmail.com, tj@kernel.org
Cc: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

The libahci now allows to use multiple PHYs and to represent each port
as a sub-node. Add these bindings to the documentation.

Signed-off-by: Antoine T=C3=A9nart <antoine.tenart@free-electrons.com>
---
 .../devicetree/bindings/ata/ahci-platform.txt      | 41 ++++++++++++++=
++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/=
Documentation/devicetree/bindings/ata/ahci-platform.txt
index 549ceb8cb93b..4ab09f2202d4 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -3,6 +3,10 @@
 SATA nodes are defined to describe on-chip Serial ATA controllers.
 Each SATA controller should have its own node.
=20
+It is possible, but not required, to represent each port as a sub-node=
=2E
+It allows to enable each port independently when dealing with multiple
+PHYs.
+
 Required properties:
 - compatible        : compatible string, one of:
   - "allwinner,sun4i-a10-ahci"
@@ -12,13 +16,30 @@ Required properties:
   - "snps,dwc-ahci"
   - "snps,exynos5440-ahci"
   - "snps,spear-ahci"
+  - "generic-ahci"
 - interrupts        : <interrupt mapping for SATA IRQ>
 - reg               : <registers mapping>
=20
+Please note that when using "generic-ahci" you must also specify a SoC=
 specific
+compatible:
+	compatible =3D "manufacturer,soc-model-ahci", "generic-ahci";
+
 Optional properties:
 - dma-coherent      : Present if dma operations are coherent
 - clocks            : a list of phandle + clock specifier pairs
 - target-supply     : regulator for SATA target power
+- phys              : reference to the SATA PHY node
+- phy-names         : must be "sata-phy"
+
+Required properties when using sub-nodes:
+- #address-cells    : number of cells to encode an address
+- #size-cells       : number of cells representing the size of an addr=
ess
+
+
+Sub-nodes required properties:
+- reg               : the port number
+- phys              : reference to the SATA PHY node
+
=20
 Examples:
         sata@ffe08000 {
@@ -34,3 +55,23 @@ Examples:
 		clocks =3D <&pll6 0>, <&ahb_gates 25>;
 		target-supply =3D <&reg_ahci_5v>;
 	};
+
+With sub-nodes:
+	sata@f7e90000 {
+		compatible =3D "marvell,berlin2q-achi", "generic-ahci";
+		reg =3D <0xe90000 0x1000>;
+		interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+		clocks =3D <&chip CLKID_SATA>;
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		sata0: sata-port@0 {
+			reg =3D <0>;
+			phys =3D <&sata_phy 0>;
+		};
+
+		sata1: sata-port@1 {
+			reg =3D <1>;
+			phys =3D <&sata_phy 1>;
+		};
+	};
--=20
1.9.1

