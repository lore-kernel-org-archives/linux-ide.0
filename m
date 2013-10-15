From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Subject: [PATCH 1/2] sata_rcar: Adjust and document device tree bindings
Date: Tue, 15 Oct 2013 14:20:06 +0400
Message-ID: <1381832407-22541-2-git-send-email-valentine.barshak@cogentembedded.com>
References: <1381832407-22541-1-git-send-email-valentine.barshak@cogentembedded.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1381832407-22541-1-git-send-email-valentine.barshak@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Tejun Heo <tj@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-ide@vger.kernel.org

This deprecates the "rcar-sata" compatibility string
and adds the "sata-r8a7779" which complies to the
preferred <unit>-<soc> format for SH-Mobile devices.
The DT bindings are documented.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 Documentation/devicetree/bindings/ata/sata_rcar.txt | 15 +++++++++++++++
 arch/arm/boot/dts/r8a7779.dtsi                      |  2 +-
 drivers/ata/sata_rcar.c                             |  3 ++-
 3 files changed, 18 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/sata_rcar.txt

diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt b/Documentation/devicetree/bindings/ata/sata_rcar.txt
new file mode 100644
index 0000000..0719115
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
@@ -0,0 +1,15 @@
+* Renesas R-Car SATA
+
+Required properties:
+- compatible		: should contain "renesas,sata-r8a7779";
+- reg			: offset and length of the SATA registers;
+- interrupts		: must consist of one interrupt specifier.
+
+Example:
+
+sata: sata@fc600000 {
+	compatible = "renesas,sata-r8a7779";
+	reg = <0xfc600000 0x2000>;
+	interrupt-parent = <&gic>;
+	interrupts = <0 100 0x4>;
+};
diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index da61d27..b1747f5 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -201,7 +201,7 @@
 	};
 
 	sata: sata@fc600000 {
-		compatible = "renesas,rcar-sata";
+		compatible = "renesas,sata-r8a7779";
 		reg = <0xfc600000 0x2000>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 100 0x4>;
diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index c2d95e9..a625cc5 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -893,7 +893,8 @@ static const struct dev_pm_ops sata_rcar_pm_ops = {
 #endif
 
 static struct of_device_id sata_rcar_match[] = {
-	{ .compatible = "renesas,rcar-sata", },
+	{ .compatible = "renesas,rcar-sata", },	/* Deprecated */
+	{ .compatible = "renesas,sata-r8a7779", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sata_rcar_match);
-- 
1.8.3.1

