From: =?UTF-8?q?Antoine=20T=C3=A9nart?=
	<antoine.tenart@free-electrons.com>
Subject: [PATCH v3 5/6] ARM: berlin: add the AHCI node for the BG2Q
Date: Wed, 14 May 2014 11:49:01 +0200
Message-ID: <1400060942-10588-6-git-send-email-antoine.tenart@free-electrons.com>
References: <1400060942-10588-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:45088 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753915AbaENJtN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 May 2014 05:49:13 -0400
In-Reply-To: <1400060942-10588-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sebastian.hesselbarth@gmail.com, tj@kernel.org, kishon@ti.com
Cc: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

The BG2Q has an AHCI SATA controller. Add the corresponding nodes
(AHCI, SATA PHYs) in its device tree.

Signed-off-by: Antoine T=C3=A9nart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin=
2q.dtsi
index 07452a7483fa..53f8d9763589 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -183,6 +183,31 @@
 			};
 		};
=20
+		ahci: sata@e90000 {
+			compatible =3D "marvell,berlin-ahci";
+			reg =3D <0xe90000 0x1000>;
+			interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			status =3D "disabled";
+		};
+
+		sata_phy: phy@e900a0 {
+			compatible =3D "marvell,berlin-sata-phy";
+			reg =3D <0xe900a0 0x10>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+
+			sata_phy0: phy@0 {
+				#phy-cells =3D <0>;
+				reg =3D <0>;
+			};
+
+			sata_phy1: phy@1 {
+				#phy-cells =3D <0>;
+				reg =3D <1>;
+			};
+		};
+
 		apb@fc0000 {
 			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
--=20
1.9.1

