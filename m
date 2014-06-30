From: =?UTF-8?q?Antoine=20T=C3=A9nart?=
	<antoine.tenart@free-electrons.com>
Subject: [PATCH v8 6/7] ARM: berlin: add the AHCI node for the BG2Q
Date: Mon, 30 Jun 2014 15:09:31 +0200
Message-ID: <1404133772-11741-7-git-send-email-antoine.tenart@free-electrons.com>
References: <1404133772-11741-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404133772-11741-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sebastian.hesselbarth@gmail.com, tj@kernel.org, kishon@ti.com
Cc: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The BG2Q has an AHCI SATA controller. Add the corresponding nodes
(AHCI, PHY) into its device tree.

Signed-off-by: Antoine T=C3=A9nart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 39 +++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin=
2q.dtsi
index 635a16a64cb4..fa34ae6657ac 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -303,6 +303,45 @@
 			clock-names =3D "refclk";
 		};
=20
+		ahci: sata@e90000 {
+			compatible =3D "generic-ahci";
+			reg =3D <0xe90000 0x1000>;
+			interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&chip CLKID_SATA>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+
+			sata0: sata-port@0 {
+				reg =3D <0>;
+				phys =3D <&sata_phy 0>;
+				status =3D "disabled";
+			};
+
+			sata1: sata-port@1 {
+				reg =3D <1>;
+				phys =3D <&sata_phy 1>;
+				status =3D "disabled";
+			};
+		};
+
+		sata_phy: phy@e900a0 {
+			compatible =3D "marvell,berlin2q-sata-phy";
+			reg =3D <0xe900a0 0x200>;
+			clocks =3D <&chip CLKID_SATA>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			#phy-cells =3D <1>;
+			status =3D "disabled";
+
+			sata-phy@0 {
+				reg =3D <0>;
+			};
+
+			sata-phy@1 {
+				reg =3D <1>;
+			};
+		};
+
 		apb@fc0000 {
 			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
--=20
1.9.1
