From: =?UTF-8?q?Antoine=20T=C3=A9nart?=
	<antoine.tenart@free-electrons.com>
Subject: [PATCH v7 6/7] ARM: berlin: add the AHCI node for the BG2Q
Date: Mon, 23 Jun 2014 15:39:42 +0200
Message-ID: <1403530783-17180-7-git-send-email-antoine.tenart@free-electrons.com>
References: <1403530783-17180-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:48856 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755902AbaFWNkr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jun 2014 09:40:47 -0400
In-Reply-To: <1403530783-17180-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sebastian.hesselbarth@gmail.com, tj@kernel.org, kishon@ti.com
Cc: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

The BG2Q has an AHCI SATA controller. Add the corresponding nodes
(AHCI, PHY) into its device tree.

Signed-off-by: Antoine T=C3=A9nart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin=
2q.dtsi
index 635a16a64cb4..60974dabedbc 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -303,6 +303,35 @@
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
+			#phy-cells =3D <1>;
+			status =3D "disabled";
+		};
+
 		apb@fc0000 {
 			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
--=20
1.9.1

