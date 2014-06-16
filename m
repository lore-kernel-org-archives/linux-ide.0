From: =?UTF-8?q?Antoine=20T=C3=A9nart?=
	<antoine.tenart@free-electrons.com>
Subject: [PATCH v6 5/7] Documentation: bindings: document the sub-nodes AHCI bindings
Date: Mon, 16 Jun 2014 12:26:30 +0200
Message-ID: <1402914392-6028-6-git-send-email-antoine.tenart@free-electrons.com>
References: <1402914392-6028-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402914392-6028-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sebastian.hesselbarth@gmail.com, tj@kernel.org, kishon@ti.com
Cc: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The libahci now allows to use multiple PHYs and to represent each port
as a sub-node. Add these bindings to the documentation.

Signed-off-by: Antoine T=C3=A9nart <antoine.tenart@free-electrons.com>
---
 .../devicetree/bindings/ata/ahci-platform.txt      | 37 ++++++++++++++=
++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/=
Documentation/devicetree/bindings/ata/ahci-platform.txt
index c96d8dcf98fd..24d95fccfb4a 100644
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
@@ -14,6 +18,7 @@ Required properties:
   - "snps,dwc-ahci"
   - "snps,exynos5440-ahci"
   - "snps,spear-ahci"
+  - "generic-ahci"
 - interrupts        : <interrupt mapping for SATA IRQ>
 - reg               : <registers mapping>
=20
@@ -21,11 +26,23 @@ Optional properties:
 - dma-coherent      : Present if dma operations are coherent
 - clocks            : a list of phandle + clock specifier pairs
 - target-supply     : regulator for SATA target power
+- phys              : reference to the SATA PHY node
+- phy-names         : must be "sata-phy"
=20
 "fsl,imx53-ahci", "fsl,imx6q-ahci" required properties:
 - clocks            : must contain the sata, sata_ref and ahb clocks
 - clock-names       : must contain "ahb" for the ahb clock
=20
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
+
 Examples:
         sata@ffe08000 {
 		compatible =3D "snps,spear-ahci";
@@ -40,3 +57,23 @@ Examples:
 		clocks =3D <&pll6 0>, <&ahb_gates 25>;
 		target-supply =3D <&reg_ahci_5v>;
 	};
+
+With sub-nodes:
+	sata@f7e90000 {
+		compatible =3D "generic-ahci";
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
