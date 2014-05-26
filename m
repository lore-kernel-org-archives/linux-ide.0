From: =?UTF-8?q?Antoine=20T=C3=A9nart?=
	<antoine.tenart@free-electrons.com>
Subject: [PATCH v5 6/7] ARM: berlin: add the AHCI node for the BG2Q
Date: Mon, 26 May 2014 16:51:47 +0200
Message-ID: <1401115908-2742-7-git-send-email-antoine.tenart@free-electrons.com>
References: <1401115908-2742-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1401115908-2742-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sebastian.hesselbarth@gmail.com, tj@kernel.org, kishon@ti.com
Cc: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The BG2Q has an AHCI SATA controller. Add the corresponding nodes
(AHCI, PHY) into its device tree.

Signed-off-by: Antoine T=C3=A9nart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin=
2q.dtsi
index 07452a7483fa..3486a8c3054a 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -183,6 +183,33 @@
 			};
 		};
=20
+		ahci: sata@e90000 {
+			compatible =3D "generic-ahci";
+			reg =3D <0xe90000 0x1000>;
+			interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
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
+			compatible =3D "marvell,berlin-sata-phy";
+			reg =3D <0xe900a0 0x200>;
+			#phy-cells =3D <1>;
+			status =3D "disabled";
+		};
+
 		apb@fc0000 {
 			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
--=20
1.9.1
