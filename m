From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/2] sata_rcar: Add clocks to sata_rcar bindings
Date: Mon, 10 Nov 2014 19:42:29 +0100
Message-ID: <1415644950-2983-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Valentine Barshak <valentine.barshak@cogentembedded.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-ide@vger.kernel.org

From: Valentine Barshak <valentine.barshak@cogentembedded.com>

Now that the clocks are available in the R-Car Gen2 DT,
add clocks property description to the sata_rcar bindings.
The clocks have been tested on r8a7791 so we use that
as an example of the R-Car SATA node.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
[geert: Reworded clocks property]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
---
v2:
  - Add Acked-by
---
 Documentation/devicetree/bindings/ata/sata_rcar.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt b/Documentation/devicetree/bindings/ata/sata_rcar.txt
index 80ae87a0784bdba8..f09c1ee260ba1d10 100644
--- a/Documentation/devicetree/bindings/ata/sata_rcar.txt
+++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
@@ -9,12 +9,14 @@ Required properties:
 			  - "renesas,sata-r8a7793" for R-Car M2-N
 - reg			: address and length of the SATA registers;
 - interrupts		: must consist of one interrupt specifier.
+- clocks		: must contain a reference to the functional clock.
 
 Example:
 
-sata: sata@fc600000 {
-	compatible = "renesas,sata-r8a7779";
-	reg = <0xfc600000 0x2000>;
+sata0: sata@ee300000 {
+	compatible = "renesas,sata-r8a7791";
+	reg = <0 0xee300000 0 0x2000>;
 	interrupt-parent = <&gic>;
-	interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;
+	interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&mstp8_clks R8A7791_CLK_SATA0>;
 };
-- 
1.9.1

