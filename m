From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v3 2/4] Documentation: bindings: Add the regulator property to the sub-nodes AHCI bindings
Date: Tue, 13 Jan 2015 15:22:31 +0100
Message-ID: <1421158953-2957-3-git-send-email-gregory.clement@free-electrons.com>
References: <1421158953-2957-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421158953-2957-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

It is now possible to use a regulator property for each port of the
AHCI controller.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 4ab09f2202d4..c2340eeeb97f 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -37,9 +37,10 @@ Required properties when using sub-nodes:
 
 
 Sub-nodes required properties:
-- reg               : the port number
-- phys              : reference to the SATA PHY node
-
+- reg		    : the port number
+And at least one of the following properties:
+- phys		    : reference to the SATA PHY node
+- target-supply    : regulator for SATA target power
 
 Examples:
         sata@ffe08000 {
@@ -68,10 +69,12 @@ With sub-nodes:
 		sata0: sata-port@0 {
 			reg = <0>;
 			phys = <&sata_phy 0>;
+			target-supply = <&reg_sata0>;
 		};
 
 		sata1: sata-port@1 {
 			reg = <1>;
 			phys = <&sata_phy 1>;
+			target-supply = <&reg_sata1>;;
 		};
 	};
-- 
1.9.1
