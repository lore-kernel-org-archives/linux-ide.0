From: =?UTF-8?q?Antoine=20T=C3=A9nart?=
	<antoine.tenart@free-electrons.com>
Subject: [PATCH v2 4/6] Documentation: bindings: add the berlin-ahci compatible to the ahci platform
Date: Mon, 12 May 2014 11:16:55 +0200
Message-ID: <1399886217-20474-5-git-send-email-antoine.tenart@free-electrons.com>
References: <1399886217-20474-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399886217-20474-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sebastian.hesselbarth@gmail.com, tj@kernel.org
Cc: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The berlin-ahci driver allows Berlin SoCs to support their AHCI SATA co=
ntroller.
Add the corresponding device tree bindings documentation.

Signed-off-by: Antoine T=C3=A9nart <antoine.tenart@free-electrons.com>
---
 Documentation/devicetree/bindings/ata/ahci-berlin.txt | 18 +++++++++++=
+++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-berlin.t=
xt

diff --git a/Documentation/devicetree/bindings/ata/ahci-berlin.txt b/Do=
cumentation/devicetree/bindings/ata/ahci-berlin.txt
new file mode 100644
index 000000000000..388150a1bb00
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/ahci-berlin.txt
@@ -0,0 +1,18 @@
+* Marvell Berlin SATA nodes
+
+Required properties:
+- compatible: "marvell,berlin-ahci"
+- interrupts: interrupt mapping for the SATA IRQ
+- reg: address and length of the register
+- phys: references to the SATA PHY nodes
+- phy-names: should be "port0" or/and "port1"
+
+Example:
+	ahci: sata@f7e90000 {
+		compatible =3D "marvell,berlin-ahci";
+		reg =3D <0xf7e90000 0x1000>;
+		interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+		phys =3D <&sata_phy 0>, <&sata_phy 1>;
+		phy-names =3D "port0", "port1";
+		status =3D "okay";
+	};
--=20
1.9.1
