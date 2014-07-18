From: =?UTF-8?q?Antoine=20T=C3=A9nart?=
	<antoine.tenart@free-electrons.com>
Subject: [PATCH v10 2/8] Documentation: bindings: add the Berlin SATA PHY
Date: Fri, 18 Jul 2014 14:30:01 +0200
Message-ID: <1405686607-8126-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1405686607-8126-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:40743 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761405AbaGRMaM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jul 2014 08:30:12 -0400
In-Reply-To: <1405686607-8126-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sebastian.hesselbarth@gmail.com, tj@kernel.org, kishon@ti.com
Cc: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

The Berlin SATA PHY drives the PHY related to the SATA interface. Add
the corresponding documentation.

Signed-off-by: Antoine T=C3=A9nart <antoine.tenart@free-electrons.com>
---
 .../devicetree/bindings/phy/berlin-sata-phy.txt    | 34 ++++++++++++++=
++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/berlin-sata-p=
hy.txt

diff --git a/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt =
b/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt
new file mode 100644
index 000000000000..88f8c23384c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt
@@ -0,0 +1,34 @@
+Berlin SATA PHY
+---------------
+
+Required properties:
+- compatible: should be "marvell,berlin2q-sata-phy"
+- address-cells: should be 1
+- size-cells: should be 0
+- phy-cells: from the generic PHY bindings, must be 1
+- reg: address and length of the register
+- clocks: reference to the clock entry
+
+Sub-nodes:
+Each PHY should be represented as a sub-node.
+
+Sub-nodes required properties:
+- reg: the PHY number
+
+Example:
+	sata_phy: phy@f7e900a0 {
+		compatible =3D "marvell,berlin2q-sata-phy";
+		reg =3D <0xf7e900a0 0x200>;
+		clocks =3D <&chip CLKID_SATA>;
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		#phy-cells =3D <1>;
+
+		sata-phy@0 {
+			reg =3D <0>;
+		};
+
+		sata-phy@1 {
+			reg =3D <1>;
+		};
+	};
--=20
1.9.1

