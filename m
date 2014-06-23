From: =?UTF-8?q?Antoine=20T=C3=A9nart?=
	<antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v7 2/7] Documentation: bindings: add the Berlin SATA PHY
Date: Mon, 23 Jun 2014 15:39:38 +0200
Message-ID: <1403530783-17180-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1403530783-17180-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1403530783-17180-1-git-send-email-antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
Cc: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

The Berlin SATA PHY drives the PHY related to the SATA interface. Add
the corresponding documentation.

Signed-off-by: Antoine T=C3=A9nart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 .../devicetree/bindings/phy/berlin-sata-phy.txt          | 16 ++++++++=
++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/berlin-sata-p=
hy.txt

diff --git a/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt =
b/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt
new file mode 100644
index 000000000000..c61616e03931
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt
@@ -0,0 +1,16 @@
+Berlin SATA PHY
+---------------
+
+Required properties:
+- compatible: should be "marvell,berlin2q-sata-phy"
+- phy-cells: from the generic PHY bindings, must be 1
+- reg: address and length of the register
+- clocks: reference to the clock entry
+
+Example:
+	sata_phy: phy@f7e900a0 {
+		compatible =3D "marvell,berlin2q-sata-phy";
+		reg =3D <0xf7e900a0 0x200>;
+		clocks =3D <&chip CLKID_SATA>;
+		#phy-cells =3D <1>;
+	};
--=20
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
