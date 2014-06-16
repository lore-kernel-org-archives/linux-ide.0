From: =?UTF-8?q?Antoine=20T=C3=A9nart?=
	<antoine.tenart@free-electrons.com>
Subject: [PATCH v6 2/7] Documentation: bindings: add the Berlin SATA PHY
Date: Mon, 16 Jun 2014 12:26:27 +0200
Message-ID: <1402914392-6028-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1402914392-6028-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:54090 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755205AbaFPK0h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jun 2014 06:26:37 -0400
In-Reply-To: <1402914392-6028-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sebastian.hesselbarth@gmail.com, tj@kernel.org, kishon@ti.com
Cc: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

The Berlin SATA PHY drives the PHY related to the SATA interface. Add
the corresponding documentation.

Signed-off-by: Antoine T=C3=A9nart <antoine.tenart@free-electrons.com>
---
 Documentation/devicetree/bindings/phy/berlin-sata-phy.txt | 14 +++++++=
+++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/berlin-sata-p=
hy.txt

diff --git a/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt =
b/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt
new file mode 100644
index 000000000000..72646db2f5fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt
@@ -0,0 +1,14 @@
+Berlin SATA PHY
+---------------
+
+Required properties:
+- compatible: "marvell,berlin-sata-phy"
+- phy-cells: from the generic PHY bindings, must be 1
+- reg: address and length of the register
+
+Example:
+	sata_phy: phy@f7e900a0 {
+		compatible =3D "marvell,berlin-sata-phy";
+		reg =3D <0xf7e900a0 0x200>;
+		#phy-cells =3D <1>;
+	};
--=20
1.9.1

