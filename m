From: =?UTF-8?q?Antoine=20T=C3=A9nart?=
	<antoine.tenart@free-electrons.com>
Subject: [PATCH 5/6] ARM: berlin: add the AHCI node for the BG2
Date: Tue, 22 Apr 2014 17:38:24 +0200
Message-ID: <1398181105-19714-6-git-send-email-antoine.tenart@free-electrons.com>
References: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:49891 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933056AbaDVPjC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Apr 2014 11:39:02 -0400
In-Reply-To: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sebastian.hesselbarth@gmail.com, tj@kernel.org
Cc: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>, alexandre.belloni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

The BG2 has an AHCI SATA controller. Add the corresponding node
in its device tree.

Signed-off-by: Antoine T=C3=A9nart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2=
=2Edtsi
index 56a1af2f1052..3e98d9fa9ec7 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -176,6 +176,13 @@
 			};
 		};
=20
+		ahci: sata@e90000 {
+			compatible =3D "marvell,berlin-ahci";
+			reg =3D <0xe90000 0x10000>;
+			interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			status =3D "disable";
+		};
+
 		apb@fc0000 {
 			compatible =3D "simple-bus";
 			#address-cells =3D <1>;
--=20
1.8.3.2

