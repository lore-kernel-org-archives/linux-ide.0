From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Subject: [PATCH] libata, dt: Add clocks to sata_rcar bindings
Date: Fri, 17 Jan 2014 02:07:42 +0400
Message-ID: <1389910062-17777-1-git-send-email-valentine.barshak@cogentembedded.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-ide@vger.kernel.org


Now that the clocks are available in the R-Car Gen2 DT,
add clocks property description to the sata_rcar bindings.
The clocks have been tested on r8a7791 so we use that
as an example of the R-Car SATA node.

The patch is against for-next branch of the libata git repo.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 Documentation/devicetree/bindings/ata/sata_rcar.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt b/Documentation/devicetree/bindings/ata/sata_rcar.txt
index 1e61113..6da60c0 100644
--- a/Documentation/devicetree/bindings/ata/sata_rcar.txt
+++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
@@ -7,12 +7,14 @@ Required properties:
 			  - "renesas,sata-r8a7791" for R-Car M2
 - reg			: address and length of the SATA registers;
 - interrupts		: must consist of one interrupt specifier.
+- clocks		: must contain a phandle and clock-specifier pair.
 
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
1.8.3.1

